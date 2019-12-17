Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3A9123AA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2019 00:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLQXQj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 18:16:39 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:34758 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLQXQi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 18:16:38 -0500
Received: by mail-pj1-f74.google.com with SMTP id c67so536714pje.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2019 15:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FDkTMVipAVEM2oYEaIDiMHcnRsGkEprqH/g1uso18v0=;
        b=Szx8SvtgGW397p6ntWPEc3OpmOTatK0fqb2QBbHtnTpfv1rzEt8maIi1s/Hfuw1VRm
         ZtB3AhgTUT9EmC5yHHgg3NsKkKJdxbchH2E/862SdXfeMDO+QiwWshasmmHEjTGL4+/3
         rs+5Zpvg8cvQ/FW/2eNZ+bZl/QTVa8lsxcloMPCa6BMVmxDi5i85hIlpvxflSLJ2+DEV
         /h8lRdRwV/AuW+qiL06i0BvmgS7fYwgBcbfhX2AzHDGGV2Ox5huBqBira7KXoqG4Mx3C
         dHYx+JcGqZlUoldeOLyLVmFcLErBHFdRWY4ExU18KYOu0wxfTuo3VfuJg7wMexqMktda
         4M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FDkTMVipAVEM2oYEaIDiMHcnRsGkEprqH/g1uso18v0=;
        b=qY45LKBLtkHFsyyS2Q3FG7Tb+ifhO0fsc2d3GF6TOiykCTfrrzweU1JPqcsq6h97Uw
         05Eqz9ceFNr2WWmaGzTT1IDNuiZ+iI7y+TvhrcEX0dA90mGEKTgDYhEWqwaoduB3rLRF
         62ojIdMGq0jltI2Zf2psozB7oUD4vul6PeLKiicHcmoKKDdggxwG5IytYoXFx1TUu9MF
         vFnLMOIXvdVK1V8V6vbdtpRDN7ecWcl2tkXuG7fna+MAo5V5re4vFPyDdKvma88x+R3M
         oBa3iPQqX1jag+p9Tku8nDSkZEG/We2H4ywg5hVkvQbh7kyv0bosyNF7oK4sZu+2tJrD
         +tCA==
X-Gm-Message-State: APjAAAVq9T413U0nfpz3N3lRX236HrA0GuGLlMXrSnDDKCO5pgByNbPv
        68JTKZtaWsMAmo/SjIYsqVYXXurK+Jkxbkfl3Q==
X-Google-Smtp-Source: APXvYqzwT3Z0rnODEkWeFuISUFMcJR8vLx9KJGGJxlN2WCBv1J/nE2VbtGHACnmLnrK21yQXTT5aweRVUSJiuRgH+Q==
X-Received: by 2002:a63:1e23:: with SMTP id e35mr28758023pge.219.1576624596330;
 Tue, 17 Dec 2019 15:16:36 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:16:15 -0800
In-Reply-To: <20191217231615.164161-1-almasrymina@google.com>
Message-Id: <20191217231615.164161-8-almasrymina@google.com>
Mime-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v9 8/8] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com,
        Hillf Danton <hdanton@sina.com>
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
2.24.1.735.g03f4e72817-goog
