Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B9B9D9EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 01:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHZXcw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Aug 2019 19:32:52 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37320 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfHZXct (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Aug 2019 19:32:49 -0400
Received: by mail-pf1-f202.google.com with SMTP id w30so13269212pfj.4
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2019 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ElPLhkujITMw+6kOZxdN4egPf1l2LHGwTUiYDYEp8fM=;
        b=CY1aI8s69o9YGJ6K0vFmmYLyZzVcf7onXN3mweVqR4ZVSJ+5HLlMO+q+W9vvWtb6vR
         z2AkrdPcZcVdVlYEGdkDSHBbkFBq51Ovx3UJg1LQ4+Ycem0XA2703fLioTfaokEhnbA8
         syXgP8odCYCcmUvJVe8bSrlTzfih3jZ+pCyEfFf7ALVFgfr+A50/JcYr33g1gZ3yJUT5
         pRNe4gRSKcKE0AUplOuw3dNWsmY4BpIby3TVjfxq9tasyxAMh4DsD8kRtius50dvXEUd
         WiEEXxDZY+WKTX2pe0nvVtRh9/M/BgviA6AIcxL76YM9EiRGO7Bg+4aetvVdl6UVPQmN
         oNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ElPLhkujITMw+6kOZxdN4egPf1l2LHGwTUiYDYEp8fM=;
        b=c7+mBUV/UVne6wE7iPt8bGrSUNum9CX/JAXoY92dCh1aPg+7kWYEMNu7gsAnNe5WeB
         lVlzVj756ly3VOjmpxB9TL6d7uCWyiOR2qCgKC2McBURHjZ+S2I+/brtnaU1RnVhhDMH
         1E0ckrPO70el3er3LYvBnboybvTrpwgJ303nSMo2fMw6DcEVuTuK4oBqnJux9mG0gwqU
         PWJgUK3dg+kvF9CgYBLYfjawMKEz7JB7eL8QeO9Cb0Y6jnAbLaJlzVN2JbL0CZdvcuxC
         sZST+1WOxAcS7TdbGmRGz5t2MMTKXvvLYZd1i9NT+cc97slZsHKR3JOXCdimcy1ehjA/
         jRtw==
X-Gm-Message-State: APjAAAU/TDuI5hS+3SJonI/9W/cg8tAcJ4i1nIQFE8BEz7XqPOG8LmJW
        fyxWnrP7eS6VFehBy2fiZbUYm31PkSwM64sqEw==
X-Google-Smtp-Source: APXvYqy4f+EGhY8DA4EciaGoRIk8Vvo11a6sPW9cP6RYxJwTxvvZimzDTPUT71oa4DyVBmPcrm+fw+qhfDPlEnv/bQ==
X-Received: by 2002:a63:c013:: with SMTP id h19mr18714986pgg.108.1566862367741;
 Mon, 26 Aug 2019 16:32:47 -0700 (PDT)
Date:   Mon, 26 Aug 2019 16:32:34 -0700
Message-Id: <20190826233240.11524-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 0/6] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
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

Problem:
Currently tasks attempting to allocate more hugetlb memory than is available get
a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
However, if a task attempts to allocate hugetlb memory only more than its
hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
but will SIGBUS the task when it attempts to fault the memory in.

We have developers interested in using hugetlb_cgroups, and they have expressed
dissatisfaction regarding this behavior. We'd like to improve this
behavior such that tasks violating the hugetlb_cgroup limits get an error on
mmap/shmget time, rather than getting SIGBUS'd when they try to fault
the excess memory in.

The underlying problem is that today's hugetlb_cgroup accounting happens
at hugetlb memory *fault* time, rather than at *reservation* time.
Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
the offending task gets SIGBUS'd.

Proposed Solution:
A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes. This
counter has slightly different semantics than
hugetlb.xMB.[limit|usage]_in_bytes:

- While usage_in_bytes tracks all *faulted* hugetlb memory,
reservation_usage_in_bytes tracks all *reserved* hugetlb memory.

- If a task attempts to reserve more memory than limit_in_bytes allows,
the kernel will allow it to do so. But if a task attempts to reserve
more memory than reservation_limit_in_bytes, the kernel will fail this
reservation.

This proposal is implemented in this patch, with tests to verify
functionality and show the usage.

Alternatives considered:
1. A new cgroup, instead of only a new page_counter attached to
   the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
   duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
   hugetlb_cgroup seemed cleaner as well.

2. Instead of adding a new counter, we considered adding a sysctl that modifies
   the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
   reservation time rather than fault time. Adding a new page_counter seems
   better as userspace could, if it wants, choose to enforce different cgroups
   differently: one via limit_in_bytes, and another via
   reservation_limit_in_bytes. This could be very useful if you're
   transitioning how hugetlb memory is partitioned on your system one
   cgroup at a time, for example. Also, someone may find usage for both
   limit_in_bytes and reservation_limit_in_bytes concurrently, and this
   approach gives them the option to do so.

Caveats:
1. This support is implemented for cgroups-v1. I have not tried
   hugetlb_cgroups with cgroups v2, and AFAICT it's not supported yet.
   This is largely because we use cgroups-v1 for now. If required, I
   can add hugetlb_cgroup support to cgroups v2 in this patch or
   a follow up.
2. Most complicated bit of this patch I believe is: where to store the
   pointer to the hugetlb_cgroup to uncharge at unreservation time?
   Normally the cgroup pointers hang off the struct page. But, with
   hugetlb_cgroup reservations, one task can reserve a specific page and another
   task may fault it in (I believe), so storing the pointer in struct
   page is not appropriate. Proposed approach here is to store the pointer in
   the resv_map. See patch for details.

Signed-off-by: Mina Almasry <almasrymina@google.com>

[1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html

Changes in v3:
- Addressed comments of Hillf Danton:
  - Added docs.
  - cgroup_files now uses enum.
  - Various readability improvements.
- Addressed comments of Mike Kravetz.
  - region_* functions no longer coalesce file_region entries in the resv_map.
  - region_add() and region_chg() refactored to make them much easier to
    understand and remove duplicated code so this patch doesn't add too much
    complexity.
  - Refactored common functionality into helpers.

Changes in v2:
- Split the patch into a 5 patch series.
- Fixed patch subject.

Mina Almasry (6):
  hugetlb_cgroup: Add hugetlb_cgroup reservation counter
  hugetlb_cgroup: add interface for charge/uncharge hugetlb reservations
  hugetlb_cgroup: add reservation accounting for private mappings
  hugetlb_cgroup: add accounting for shared mappings
  hugetlb_cgroup: Add hugetlb_cgroup reservation tests
  hugetlb_cgroup: Add hugetlb_cgroup reservation docs

 .../admin-guide/cgroup-v1/hugetlb.rst         |  84 ++-
 include/linux/hugetlb.h                       |  24 +-
 include/linux/hugetlb_cgroup.h                |  19 +-
 mm/hugetlb.c                                  | 493 ++++++++++++------
 mm/hugetlb_cgroup.c                           | 187 +++++--
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   4 +
 .../selftests/vm/charge_reserved_hugetlb.sh   | 438 ++++++++++++++++
 .../selftests/vm/write_hugetlb_memory.sh      |  22 +
 .../testing/selftests/vm/write_to_hugetlbfs.c | 252 +++++++++
 10 files changed, 1300 insertions(+), 224 deletions(-)
 create mode 100755 tools/testing/selftests/vm/charge_reserved_hugetlb.sh
 create mode 100644 tools/testing/selftests/vm/write_hugetlb_memory.sh
 create mode 100644 tools/testing/selftests/vm/write_to_hugetlbfs.c

--
2.23.0.187.g17f5b7556c-goog
