Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E7B9DA01
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 01:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfHZXdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Aug 2019 19:33:19 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34249 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfHZXdS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Aug 2019 19:33:18 -0400
Received: by mail-qt1-f202.google.com with SMTP id f19so8280773qtq.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2019 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5FDOwwCe+APWdEQQqNbBpE6iIki5NU5vXPefDHikBmg=;
        b=BfXwwjAuhrLzwyV49VnJL7NxDepEgABTklx9qhc6rCK5F1w2xw2LFgmzTWfEAHiPTF
         c5v46KJZa6ts7LaEAl2UEDScmWBYH5FdRRkicG6JhCd5gzMC/MBrJM+gYNO8Y0DVWbd5
         NXpoHq7M83Am1Y0GWNerd7Jl1ueGsflkoKLPII48XaDmWf1gZAsG9uA8s1QmT0b9GiBR
         N55L5aExlS7kaRIdXdaPfI1XlO+g1o6LMycyymR5h1zGtC9eyWIzaUH81AY7A3AqGLvk
         we6DYp4QKXYWKwHLDCaThtFG284KWl3dBsOd8oJmCEJHfUQZs3Chk6Cz9lgq6vY8+BVj
         jxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5FDOwwCe+APWdEQQqNbBpE6iIki5NU5vXPefDHikBmg=;
        b=GHZ2JJMbPTs+uXHW+ub3iDMh1fwim8UsMvRArdT9bh1Rt+h2T32m3ZEmVOJfgoyX7e
         uJNGpYPcJsbCfJkg9D6ebghG+IuoiuHEcGo1Uf0joQEnA+6rTqjWPpqbL5qWev21bzzM
         FtHOmm6Mw/4AAaPOzxxMBaEd728JzNQrEIDSLmI+EAcxF8XaenjoZ3SNJZzfORtuBQK5
         RRv1eAnkN5vLHOD7sLZmrYh48IL2CPNkO/I2g+Z/lPIYV3R0jomB6jM3iQAXWSDArGRw
         elPVboLhA72pGd9PA4XxAc0EwG+L8YcspFI0Gksb+WY9XHzmT3rDtABXTiCgTrO+mQSH
         ZIcQ==
X-Gm-Message-State: APjAAAXpmA5E7p4Oa1l16MigaFj3IzZ/qXEuWiqVAGZ3uu6iJvdK7F2F
        3hWAJQhY2ZnzHpnEg6g8kH/NrHPwCpp67fbxgQ==
X-Google-Smtp-Source: APXvYqyDImAPzfr0N58wa/tY2W7Edq/krF5d6f1tRQcHXjvREDYlfn3oZlUNIZ7WqjjdFcG1GxtewDdCNH22t72/9w==
X-Received: by 2002:ad4:45d3:: with SMTP id v19mr17564793qvt.90.1566862396925;
 Mon, 26 Aug 2019 16:33:16 -0700 (PDT)
Date:   Mon, 26 Aug 2019 16:32:40 -0700
In-Reply-To: <20190826233240.11524-1-almasrymina@google.com>
Message-Id: <20190826233240.11524-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20190826233240.11524-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 6/6] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add docs for how to use hugetlb_cgroup reservations, and their behavior.

---
 .../admin-guide/cgroup-v1/hugetlb.rst         | 84 ++++++++++++++++---
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index a3902aa253a96..cc6eb859fc722 100644
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
+ hugetlb.<hugepagesize>.reservation_max_usage_in_bytes # show max "hugepagesize" hugetlb reservations recorded
+ hugetlb.<hugepagesize>.reservation_usage_in_bytes     # show current reservations for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.reservation_failcnt            # show the number of allocation failure due to HugeTLB reservation limit
+ hugetlb.<hugepagesize>.limit_in_bytes                 # set/show limit of "hugepagesize" hugetlb faults
+ hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepagesize" hugetlb  usage recorded
+ hugetlb.<hugepagesize>.usage_in_bytes                 # show current usage for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.failcnt                        # show the number of allocation failure due to HugeTLB usage limit

 For a system supporting three hugepage sizes (64k, 32M and 1G), the control
 files include::
@@ -40,11 +37,76 @@ files include::
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
+group and enforces the controller limit at reservation time. Reservation limits
+are superior to Page fault limits (see section 2), since Reservation limits are
+enforced at reservation time, and never causes the application to get SIGBUS
+signal. Instead, if the application is violating its limits, then it gets an
+error on reservation time, i.e. the mmap or shmget return an error.
+
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
+a. Charging and uncharging:
+
+For shared hugetlb memory, both hugetlb reservation and usage (page faults) are
+charged to the first task that causes the memory to be reserved or faulted,
+and all subsequent uses of this reserved or faulted memory is done without
+charging.
+
+Shared hugetlb memory is only uncharged when it is unreseved or deallocated.
+This is usually when the hugetlbfs file is deleted, and not when the task that
+caused the reservation or fault has exited.
+
+b. Interaction between reservation limit and fault limit.
+
+Generally, it's not recommended to set both of the reservation limit and fault
+limit in a cgroup. For private memory, the fault usage cannot exceed the
+reservation usage, so if you set both, one of those limits will be useless.
+
+For shared memory, a cgroup's fault usage may be greater than its reservation
+usage, so some care needs to be taken. Consider this example:
+
+- Task A reserves 4 pages in a shared hugetlbfs file. Cgroup A will get
+  4 reservations charged to it and no faults charged to it.
+- Task B reserves and faults the same 4 pages as Task A. Cgroup B will get no
+  reservation charge, but will get charged 4 faulted pages. If Cgroup B's limit
+  is less than 4, then Task B will get a SIGBUS.
+
+For the above scenario, it's not recommended for the userspace to set both
+reservation limits and fault limits, but it is still allowed to in case it sees
+some use for it.
--
2.23.0.187.g17f5b7556c-goog
