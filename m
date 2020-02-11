Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867A2159B29
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 22:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBKVcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 16:32:08 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:54748 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgBKVcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 16:32:06 -0500
Received: by mail-pj1-f74.google.com with SMTP id a31so2318920pje.4
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 13:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vqDD6Gs7ngqLSWc3KTUHIOcGSlcLabi4lsGh3QCG31M=;
        b=AW3+a6HpfbMIZUeziVe7326NVlNXRe6KKs/Jy9Bv8LgX23ZEmjRGxE1TOSLx5zOLGd
         BStdGUu6ZAK+vjPmmeQgLrLCE8aZNR2rMSWNwhwdr5rFsnOjag/nmx+wEftHYHwaqwQD
         uXhiUe/ZBtNo9TfsWaykRXTr0r/C8//JshbuuaHo1/nr7oFrZyn6VskYeG+8muDz8UWe
         pVBtP0+7C8imVM8fJiV1R+aH8xRUUm4VNkoBB0P78V3sSpdAHBXYuPeTrgNuSAr/htFh
         wVDP5VM/1gmKrcBnQ559/C3apZyOuBlSJyJBljyoPDEsdxiIu+eUll01s9kuOape4yWl
         XH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vqDD6Gs7ngqLSWc3KTUHIOcGSlcLabi4lsGh3QCG31M=;
        b=sXrxKK0N5KEIfU8tTeu8xXeXaV138aEj3ZCnTQ2IPbYmENenuqQTXCyttx2qXaZn1U
         x28k7XhMCp7wb2DdwCzDoM8FZ93Rd0tG3oiinTF3j9VdoPV6YcaJ3nZ5t5PFCYezp1+W
         Ahslu9ovakAiAvoIBOZUhRp5zZ+H8mixds6kr08Eh7j+ezITmqfnQl6g6KHxoZuqV+08
         pnoJiVmnnz/3liwR0Ax7duokyl8lskYqWxawasZCc27kaMXY5+ZBSSbEIU9CHkuuHFYY
         rCOscx0sWuKWSoXExzlmEEJ8WAowPgWSxW5XXPwOitMWd4Dld7UbIXirgwjLpJStuGzc
         Yaeg==
X-Gm-Message-State: APjAAAWKRG3EdgpdQPY8TwgFsx+QzIr+Vi5IR4Ukhk+plPL95wT22Klt
        PILqN01A5zbjtiJ/enaQjL+zpmtZ6yOQIuyd4A==
X-Google-Smtp-Source: APXvYqzQHWOyvxutWwSWozD1YwqfvrNdtFLk+uHTrMAzzyDXIUBRUgauYZSzihOXYE/q8NSPm50+Tb4mcBrAeZ2aHg==
X-Received: by 2002:a63:348c:: with SMTP id b134mr8572145pga.197.1581456726045;
 Tue, 11 Feb 2020 13:32:06 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:31:28 -0800
In-Reply-To: <20200211213128.73302-1-almasrymina@google.com>
Message-Id: <20200211213128.73302-9-almasrymina@google.com>
Mime-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v12 9/9] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add docs for how to use hugetlb_cgroup reservations, and their behavior.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v11:
- Changed resv.* to rsvd.*
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
index a3902aa253a96..338f2c7d7a1cd 100644
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
+ hugetlb.<hugepagesize>.rsvd.limit_in_bytes            # set/show limit of "hugepagesize" hugetlb reservations
+ hugetlb.<hugepagesize>.rsvd.max_usage_in_bytes        # show max "hugepagesize" hugetlb reservations and no-reserve faults
+ hugetlb.<hugepagesize>.rsvd.usage_in_bytes            # show current reservations and no-reserve faults for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.rsvd.failcnt                   # show the number of allocation failure due to HugeTLB reservation limit
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
+  hugetlb.1GB.rsvd.limit_in_bytes
+  hugetlb.1GB.rsvd.max_usage_in_bytes
+  hugetlb.1GB.rsvd.usage_in_bytes
+  hugetlb.1GB.rsvd.failcnt
   hugetlb.64KB.limit_in_bytes
   hugetlb.64KB.max_usage_in_bytes
   hugetlb.64KB.usage_in_bytes
   hugetlb.64KB.failcnt
+  hugetlb.64KB.rsvd.limit_in_bytes
+  hugetlb.64KB.rsvd.max_usage_in_bytes
+  hugetlb.64KB.rsvd.usage_in_bytes
+  hugetlb.64KB.rsvd.failcnt
   hugetlb.32MB.limit_in_bytes
   hugetlb.32MB.max_usage_in_bytes
   hugetlb.32MB.usage_in_bytes
   hugetlb.32MB.failcnt
+  hugetlb.32MB.rsvd.limit_in_bytes
+  hugetlb.32MB.rsvd.max_usage_in_bytes
+  hugetlb.32MB.rsvd.usage_in_bytes
+  hugetlb.32MB.rsvd.failcnt
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
+hugetlb.<hugepagesize>.rsvd.limit_in_bytes
+hugetlb.<hugepagesize>.rsvd.max_usage_in_bytes
+hugetlb.<hugepagesize>.rsvd.usage_in_bytes
+hugetlb.<hugepagesize>.rsvd.failcnt
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
2.25.0.225.g125e21ebc7-goog
