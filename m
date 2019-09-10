Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E1AAF35F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2019 01:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfIJXcY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 19:32:24 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:35304 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIJXcP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 19:32:15 -0400
Received: by mail-vk1-f201.google.com with SMTP id y187so7683998vkf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2019 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0LEswebCuXlUeK7tPzkfS93LgBHF3BU/v1A9gg1d3Jc=;
        b=e/SIH2orKqbKFX2gNfzSIzJVtzBFf5hXWjn5Vfz22L9QA5QFdedJKt3j7w0PpInHbz
         lVvPgETr0Jbfwbj6JUht/BSUXmoNajeGGPi8S9SsZus3IZtAJvMZ6uxAJDkOd/TRCrWE
         lJgntTxvOrHowSOhvclAmpFpHElnVn+5t1nNi2tzuO8BHw8B4izIfpv0AddmccrMionV
         u0BppCYSZfZS5SULW9vxvdunM4/nsrQ+G9B5srifEofG4anGR2hLcTooY1boiv+RKIoW
         bbiAxpTi+HUuTdp9NjxvSK9uWVWE1aO3FACG8wRiq/gx4HABAyUpGEWgMCtr5wL6gDke
         d3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0LEswebCuXlUeK7tPzkfS93LgBHF3BU/v1A9gg1d3Jc=;
        b=IcapMvrQByHAriUYacXqqJHLiAL4PBklcbXrrm0wgpNv04BGe06pHPXM7qclN1qIP4
         T9Mr44L7zSN03zubj8GjhRGUj75RVMb8IxP6dVzfTayRDyFVzJl3sO3lAZZiwc5LYCOF
         UrMIWUL7CXpbPMG0oF42QOK4VshqONbxO0b35RgO98vKfW67uzzKPSQ+uMOIScipE/az
         Q+1GoRIkqJsv0p4HLZGXgRvpSlMcmVlkx1jop7SZPKX6dyAyBG/z3xCy7vJb+h1vSulx
         xOKy6DwoYllVa6WUFhR40eYaCjQ3LCI0jVPPCtMJN8BYNmNw0u9CCXfCblTJhwKVxFv8
         yqSw==
X-Gm-Message-State: APjAAAWl67Hh41dPC9hb51jQLdgawBbdMEnyU8mt9F6oj+rIx7GsSCLD
        pT7EgsYhrbUI5sGIaVPB501XYA64h0tYFclKzQ==
X-Google-Smtp-Source: APXvYqy/3Zn8sqmETM/JAH7hp9TufhpKQ3F/v7pZaXngfOyH7O21D7gnsKHl66KuXfAx3PVnCWkls5tzRe2Ask7GvQ==
X-Received: by 2002:ac5:c7d3:: with SMTP id e19mr7511087vkn.60.1568158334638;
 Tue, 10 Sep 2019 16:32:14 -0700 (PDT)
Date:   Tue, 10 Sep 2019 16:31:46 -0700
In-Reply-To: <20190910233146.206080-1-almasrymina@google.com>
Message-Id: <20190910233146.206080-10-almasrymina@google.com>
Mime-Version: 1.0
References: <20190910233146.206080-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v4 9/9] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add docs for how to use hugetlb_cgroup reservations, and their behavior.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Hillf Danton <hdanton@sina.com>
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
2.23.0.162.g0b9fbb3734-goog
