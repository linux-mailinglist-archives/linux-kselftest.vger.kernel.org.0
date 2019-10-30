Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F345E94B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 02:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfJ3Bha (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Oct 2019 21:37:30 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36438 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfJ3Bh2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Oct 2019 21:37:28 -0400
Received: by mail-pf1-f201.google.com with SMTP id f21so449161pfa.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2019 18:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dB8tzf8sZtneCZa7MSScr4+OQXIODrIR247B+8t/8nM=;
        b=fwSWGAxtQo5BumELzWIUcPXc08BjYwDJdEEBA4f1Viee3PeOy1kCh9W8um7OS/hWkZ
         BL7Jd9CNRMkkgwF3jQ5+9cg+71MnkXPGsGCHlSM8ZQtLyiESMI7FOVMdTdauqgNd8pnf
         tUXQtl6BBxD0drbo17rOPtSIBaX83tCu82354FR8Rx3OZSmhwZql4OHKxoLVjBa3Ygdc
         Hxerg5TfGOfmgUJWp1YXwURB1qDbr76rFRwd+EMY3yfpPLJ0uRomAZvJHuBKgAx7SZV3
         1f4IxsTzQ7ppcEQ/E3VwqSz7Bmq3GnqMXXP9oUOwzGJU95/5lVJbiYtFk6m42YhwqO6/
         GYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dB8tzf8sZtneCZa7MSScr4+OQXIODrIR247B+8t/8nM=;
        b=Nd8Xm9GBviR8seIXEvkw5+xhWnN9eoMzUhatFpCg/uSb74hHvaHNDvmcOaLFaGEyZo
         2paVFkNDRSWwqcQ7tNBQ1yfpKodO2kHjfl45Ocpgs06v+gSKGQplUVdA7mBNrtzSyqvN
         5fWnRjiKEoniQ/XF7SU+Of/ZjnN05DH7Rz8sGYMyLYJqQjLM4h+yVXdVpoxEWAUYW3uO
         +w2oBtB1DxTQ6Tur9MbLqlFHIKkhdxw0D5ak7tXbs9ElzYqhfOzWO3E1kbmKplVK+KNN
         9Dtsy76xFBN3irgsePKWc5aAHbCoctPJDb8ZKt9So5+bE3T0h/n0OpR/NIyNcAGH1giG
         yAzA==
X-Gm-Message-State: APjAAAWTrnFxJ5DueLcXk1LMNEMtgTlZ73sfs5OGtW+fOvVFF1Lf+Jew
        a68NLLyyay/UMBmn+DheOpdj0FNhbVw+ywh3LA==
X-Google-Smtp-Source: APXvYqyVey/8zK1PSid9UhvE+qiny4gHfLMVl8hjsESpTAO/gniAcYiAWFz1t75zYbs3qZtIOppBIXqadHcuruxfKA==
X-Received: by 2002:a65:5382:: with SMTP id x2mr2468380pgq.420.1572399445924;
 Tue, 29 Oct 2019 18:37:25 -0700 (PDT)
Date:   Tue, 29 Oct 2019 18:37:01 -0700
In-Reply-To: <20191030013701.39647-1-almasrymina@google.com>
Message-Id: <20191030013701.39647-9-almasrymina@google.com>
Mime-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v8 9/9] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add docs for how to use hugetlb_cgroup reservations, and their behavior.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Hillf Danton <hdanton@sina.com>

---

Changes in v6:
- Updated docs to reflect the new design based on a new counter that
tracks both reservations and faults.

---
 .../admin-guide/cgroup-v1/hugetlb.rst         | 64 +++++++++++++++----
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index a3902aa253a96..efb94e4db9d5a 100644
--- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
+++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
@@ -2,13 +2,6 @@
 HugeTLB Controller
 ==================

-The HugeTLB controller allows to limit the HugeTLB usage per control group and
-enforces the controller limit during page fault. Since HugeTLB doesn't
-support page reclaim, enforcing the limit at page fault time implies that,
-the application will get SIGBUS signal if it tries to access HugeTLB pages
-beyond its limit. This requires the application to know beforehand how much
-HugeTLB pages it would require for its use.
-
 HugeTLB controller can be created by first mounting the cgroup filesystem.

 # mount -t cgroup -o hugetlb none /sys/fs/cgroup
@@ -28,10 +21,14 @@ process (bash) into it.

 Brief summary of control files::

- hugetlb.<hugepagesize>.limit_in_bytes     # set/show limit of "hugepagesize" hugetlb usage
- hugetlb.<hugepagesize>.max_usage_in_bytes # show max "hugepagesize" hugetlb  usage recorded
- hugetlb.<hugepagesize>.usage_in_bytes     # show current usage for "hugepagesize" hugetlb
- hugetlb.<hugepagesize>.failcnt		   # show the number of allocation failure due to HugeTLB limit
+ hugetlb.<hugepagesize>.reservation_limit_in_bytes     # set/show limit of "hugepagesize" hugetlb reservations
+ hugetlb.<hugepagesize>.reservation_max_usage_in_bytes # show max "hugepagesize" hugetlb reservations and no-reserve faults.
+ hugetlb.<hugepagesize>.reservation_usage_in_bytes     # show current reservations and no-reserve faults for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.reservation_failcnt            # show the number of allocation failure due to HugeTLB reservation limit
+ hugetlb.<hugepagesize>.limit_in_bytes                 # set/show limit of "hugepagesize" hugetlb faults
+ hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepagesize" hugetlb  usage recorded
+ hugetlb.<hugepagesize>.usage_in_bytes                 # show current usage for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.failcnt                        # show the number of allocation failure due to HugeTLB usage limit

 For a system supporting three hugepage sizes (64k, 32M and 1G), the control
 files include::
@@ -40,11 +37,56 @@ files include::
   hugetlb.1GB.max_usage_in_bytes
   hugetlb.1GB.usage_in_bytes
   hugetlb.1GB.failcnt
+  hugetlb.1GB.reservation_limit_in_bytes
+  hugetlb.1GB.reservation_max_usage_in_bytes
+  hugetlb.1GB.reservation_usage_in_bytes
+  hugetlb.1GB.reservation_failcnt
   hugetlb.64KB.limit_in_bytes
   hugetlb.64KB.max_usage_in_bytes
   hugetlb.64KB.usage_in_bytes
   hugetlb.64KB.failcnt
+  hugetlb.64KB.reservation_limit_in_bytes
+  hugetlb.64KB.reservation_max_usage_in_bytes
+  hugetlb.64KB.reservation_usage_in_bytes
+  hugetlb.64KB.reservation_failcnt
   hugetlb.32MB.limit_in_bytes
   hugetlb.32MB.max_usage_in_bytes
   hugetlb.32MB.usage_in_bytes
   hugetlb.32MB.failcnt
+  hugetlb.32MB.reservation_limit_in_bytes
+  hugetlb.32MB.reservation_max_usage_in_bytes
+  hugetlb.32MB.reservation_usage_in_bytes
+  hugetlb.32MB.reservation_failcnt
+
+
+1. Reservation limits
+
+The HugeTLB controller allows to limit the HugeTLB reservations per control
+group and enforces the controller limit at reservation time and at the fault of
+hugetlb memory for which no reservation exists. Reservation limits
+are superior to Page fault limits (see section 2), since Reservation limits are
+enforced at reservation time (on mmap or shget), and never causes the
+application to get SIGBUS signal if the memory was reserved before hand. For
+MAP_NORESERVE allocations, the reservation limit behaves the same as the fault
+limit, enforcing memory usage at fault time and causing the application to
+receive a SIGBUS if it's crossing its limit.
+
+2. Page fault limits
+
+The HugeTLB controller allows to limit the HugeTLB usage (page fault) per
+control group and enforces the controller limit during page fault. Since HugeTLB
+doesn't support page reclaim, enforcing the limit at page fault time implies
+that, the application will get SIGBUS signal if it tries to access HugeTLB
+pages beyond its limit. This requires the application to know beforehand how
+much HugeTLB pages it would require for its use.
+
+
+3. Caveats with shared memory
+
+For shared hugetlb memory, both hugetlb reservation and page faults are charged
+to the first task that causes the memory to be reserved or faulted, and all
+subsequent uses of this reserved or faulted memory is done without charging.
+
+Shared hugetlb memory is only uncharged when it is unreserved or deallocated.
+This is usually when the hugetlbfs file is deleted, and not when the task that
+caused the reservation or fault has exited.
--
2.24.0.rc1.363.gb1bccd3e3d-goog
