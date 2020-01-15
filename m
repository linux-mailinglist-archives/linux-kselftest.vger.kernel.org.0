Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7FF13B6D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 02:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgAOB1S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 20:27:18 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37484 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgAOB1M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 20:27:12 -0500
Received: by mail-pf1-f202.google.com with SMTP id d85so9934289pfd.4
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2020 17:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h8U2qNtEFbaq+hBB/JCIu5FRCXJjzgS5K1PNEW4ZKws=;
        b=DdORwNw0ndB7yPDnt8tT0WEqtdwD8V4r97JqJT/LXfvkDwe5s1Q21YiAh1Gty98/b0
         UViZadY+jCLv9/GwljHX1EpDUv/iKm4sPdChU0zjoMGyXN7zg1cbfcpgPdzbX5qTrdF/
         dbKOqYdZjkBCfPZQQ1YxpKX6DhhfqJq+713oEumbz1oluyU8GfaKlJqBtya86kphQBPp
         hQ6z3xF6QIrMNetm1VyXpVPsEnkMLh9SXbwVlRZzxr3OVTLRib9eqf1oTPYa4qshTYex
         xOfkILN202JFeCcVen+QZ9LO1j+FVNwWsgKIETR7mXnbAXLRN4ALA87go3rMV94BSNjZ
         9NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h8U2qNtEFbaq+hBB/JCIu5FRCXJjzgS5K1PNEW4ZKws=;
        b=ZIYykBB2iAvrMCeRQzrVZP8XinlMlgQCiyIa5Jq+QrFT9sH8prncXbCeZ3TAqRwu59
         3T7vJKhT4O4+1/iE/6mX79aWrWYzhOK5UxHLSAC5yMWPzao28ET7MrIjQHpggpMc+N5Z
         UIt6QJAQF9m/6egANVi7+96FNlDIYYCMyEKOCdhojj8NgzH/AANft/dAMHIISwTxdqvl
         5tyBIz9QsOQCGYae3jpgX/TQFTJ0/gxUC0/rRhBLsjrt7sElK75WROp27xQVXs5XNifo
         kUB79w88h/abS9NnubcBB+2a8I2UBkvTkbTwmMHO95TbcZsQc6gQ8wGz6n7cqHU59Ck1
         U1Yg==
X-Gm-Message-State: APjAAAVIGK0PPVvtCKKd0J4R4kFnnmvQTwCRS/1nXVsIv4PbsG0V5G2q
        5HfOl+2Ezh0aRMV1j3WMmpe37K0hRo5mn4/+Uw==
X-Google-Smtp-Source: APXvYqxmMi2/ACArgSv7fIgXtolIquE4UCUC/iP8qxu7HL4rR76nCNRpBZfD1IoYHxOtfCJxpCr2SfVY1MIWGdoxtA==
X-Received: by 2002:a63:4b49:: with SMTP id k9mr30074514pgl.269.1579051631919;
 Tue, 14 Jan 2020 17:27:11 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:26:51 -0800
In-Reply-To: <20200115012651.228058-1-almasrymina@google.com>
Message-Id: <20200115012651.228058-8-almasrymina@google.com>
Mime-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v10 8/8] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com, rientjes@google.com, shakeelb@google.com
Cc:     shuah@kernel.org, almasrymina@google.com, gthelen@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add docs for how to use hugetlb_cgroup reservations, and their behavior.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v10:
- Clarify reparenting behavior.
- Reword benefits of reservation limits.
Changes in v6:
- Updated docs to reflect the new design based on a new counter that
tracks both reservations and faults.

---
 .../admin-guide/cgroup-v1/hugetlb.rst         | 103 ++++++++++++++++--
 1 file changed, 92 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index a3902aa253a96..00dd4daf55f19 100644
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
+ hugetlb.<hugepagesize>.resv.limit_in_bytes            # set/show limit of "hugepagesize" hugetlb reservations
+ hugetlb.<hugepagesize>.resv.max_usage_in_bytes        # show max "hugepagesize" hugetlb reservations and no-reserve faults
+ hugetlb.<hugepagesize>.resv.usage_in_bytes            # show current reservations and no-reserve faults for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.resv.failcnt                   # show the number of allocation failure due to HugeTLB reservation limit
+ hugetlb.<hugepagesize>.limit_in_bytes                 # set/show limit of "hugepagesize" hugetlb faults
+ hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepagesize" hugetlb  usage recorded
+ hugetlb.<hugepagesize>.usage_in_bytes                 # show current usage for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.failcnt                        # show the number of allocation failure due to HugeTLB usage limit

 For a system supporting three hugepage sizes (64k, 32M and 1G), the control
 files include::
@@ -40,11 +37,95 @@ files include::
   hugetlb.1GB.max_usage_in_bytes
   hugetlb.1GB.usage_in_bytes
   hugetlb.1GB.failcnt
+  hugetlb.1GB.resv.limit_in_bytes
+  hugetlb.1GB.resv.max_usage_in_bytes
+  hugetlb.1GB.resv.usage_in_bytes
+  hugetlb.1GB.resv.failcnt
   hugetlb.64KB.limit_in_bytes
   hugetlb.64KB.max_usage_in_bytes
   hugetlb.64KB.usage_in_bytes
   hugetlb.64KB.failcnt
+  hugetlb.64KB.resv.limit_in_bytes
+  hugetlb.64KB.resv.max_usage_in_bytes
+  hugetlb.64KB.resv.usage_in_bytes
+  hugetlb.64KB.resv.failcnt
   hugetlb.32MB.limit_in_bytes
   hugetlb.32MB.max_usage_in_bytes
   hugetlb.32MB.usage_in_bytes
   hugetlb.32MB.failcnt
+  hugetlb.32MB.resv.limit_in_bytes
+  hugetlb.32MB.resv.max_usage_in_bytes
+  hugetlb.32MB.resv.usage_in_bytes
+  hugetlb.32MB.resv.failcnt
+
+
+1. Page fault accounting
+
+hugetlb.<hugepagesize>.limit_in_bytes
+hugetlb.<hugepagesize>.max_usage_in_bytes
+hugetlb.<hugepagesize>.usage_in_bytes
+hugetlb.<hugepagesize>.failcnt
+
+The HugeTLB controller allows users to limit the HugeTLB usage (page fault) per
+control group and enforces the limit during page fault. Since HugeTLB
+doesn't support page reclaim, enforcing the limit at page fault time implies
+that, the application will get SIGBUS signal if it tries to fault in HugeTLB
+pages beyond its limit. Therefore the application needs to know exactly how many
+HugeTLB pages it uses before hand, and the sysadmin needs to make sure that
+there are enough available on the machine for all the users to avoid processes
+getting SIGBUS.
+
+
+2. Reservation accounting
+
+hugetlb.<hugepagesize>.resv.limit_in_bytes
+hugetlb.<hugepagesize>.resv.max_usage_in_bytes
+hugetlb.<hugepagesize>.resv.usage_in_bytes
+hugetlb.<hugepagesize>.resv.failcnt
+
+The HugeTLB controller allows to limit the HugeTLB reservations per control
+group and enforces the controller limit at reservation time and at the fault of
+HugeTLB memory for which no reservation exists. Since reservation limits are
+enforced at reservation time (on mmap or shget), reservation limits never causes
+the application to get SIGBUS signal if the memory was reserved before hand. For
+MAP_NORESERVE allocations, the reservation limit behaves the same as the fault
+limit, enforcing memory usage at fault time and causing the application to
+receive a SIGBUS if it's crossing its limit.
+
+Reservation limits are superior to page fault limits described above, since
+reservation limits are enforced at reservation time (on mmap or shget), and
+never causes the application to get SIGBUS signal if the memory was reserved
+before hand. This allows for easier fallback to alternatives such as
+non-HugeTLB memory for example. In the case of page fault accounting, it's very
+hard to avoid processes getting SIGBUS since the sysadmin needs precisely know
+the HugeTLB usage of all the tasks in the system and make sure there is enough
+pages to satisfy all requests. Avoiding tasks getting SIGBUS on overcommited
+systems is practically impossible with page fault accounting.
+
+
+3. Caveats with shared memory
+
+For shared HugeTLB memory, both HugeTLB reservation and page faults are charged
+to the first task that causes the memory to be reserved or faulted, and all
+subsequent uses of this reserved or faulted memory is done without charging.
+
+Shared HugeTLB memory is only uncharged when it is unreserved or deallocated.
+This is usually when the HugeTLB file is deleted, and not when the task that
+caused the reservation or fault has exited.
+
+
+4. Caveats with HugeTLB cgroup offline.
+
+When a HugeTLB cgroup goes offline with some reservations or faults still
+charged to it, the behavior is as follows:
+
+- The fault charges are charged to the parent HugeTLB cgroup (reparented),
+- the reservation charges remain on the offline HugeTLB cgroup.
+
+This means that if a HugeTLB cgroup gets offlined while there is still HugeTLB
+reservations charged to it, that cgroup persists as a zombie until all HugeTLB
+reservations are uncharged. HugeTLB reservations behave in this manner to match
+the memory controller whose cgroups also persist as zombie until all charged
+memory is uncharged. Also, the tracking of HugeTLB reservations is a bit more
+complex compared to the tracking of HugeTLB faults, so it is significantly
+harder to reparent reservations at offline time.
--
2.25.0.rc1.283.g88dfdc4193-goog
