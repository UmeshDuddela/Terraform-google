locals {
  e = ["nqe", "nde", "pde"]
  d = ["d1", "d2", "d3", "d4", "d5", "d6"]
  qp = {
    d1 = ["qp1", "qp2", "qp3", "qp4", "qp5"],
    d5 = ["qp13"]
  }
  dp = {
    d1 = ["dp1", "dp2", "dp3", "dp4", "dp5"],
    d5 = ["dp13"]
  }
  
  eai = "12345"
  region = "us"
  billingcode = "567"

  qa_labels = contains(local.qp["d1"], "qp1") || contains(local.qp["d1"], "qp2") || contains(local.qp["d1"], "qp3") || contains(local.qp["d1"], "qp4") || contains(local.qp["d1"], "qp5") ? {
    d = "d1"
    e = "nqe"
  } : contains(local.qp["d5"], "qp13") ? {
    d = "d5"
    e = "nqe"
  } : {}

  dp_labels = contains(local.dp["d1"], "dp1") || contains(local.dp["d1"], "dp2") || contains(local.dp["d1"], "dp3") || contains(local.dp["d1"], "dp4") || contains(local.dp["d1"], "dp5") ? {
    d = "d1"
    e = "nqe"
  } : contains(local.dp["d5"], "dp13") ? {
    d = "d5"
    e = "nde"
  } : {}

  qa_label = merge(local.qa_labels, {eai = local.eai, region = local.region, billingcode = local.billingcode })
  dp_label = merge(local.dp_labels, {eai = local.eai, region = local.region, billingcode = local.billingcode })
}


resource "google_storage_bucket"  "storage_bucket" {
  name                        = "test-bucket-12987"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
  project                     = "poised-octane-385505"
  labels                      = local.dp_label
}
