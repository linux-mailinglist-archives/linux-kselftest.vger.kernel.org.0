Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C656486DBD
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 01:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbfHHXNx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 19:13:53 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:52693 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732708AbfHHXNw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 19:13:52 -0400
Received: by mail-vk1-f201.google.com with SMTP id l186so41093461vke.19
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2019 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wId29/KRlL3T3iL7X0HyROciU3enoTeQrmaI3uDvplM=;
        b=TMFjcZ4vhBvh4e7isaMSjyShLhjqgNI9SS84mRQBUZq7giQJNsbMV9xB8o589wPJjG
         ATqzdkESubrtjfyBEvm0HFq7aHibDZTA+VfHQqC1k82g6SeBBy3ZTDPxYWtdtsgA5gb2
         BaRU8mj248iyCd1JsH8c8z3c/1h2TbfYGpCiSAfmctaAa6DGr8+fhUkhzZc2E+FF0zff
         4oqJ0+yopnx6PrZt4GfyCNDb5JdmETVvW4BJCoi29CZ8EgWzd2MoiLzfjPs4BA70d/ap
         1mA4DuppfOGpbfO7bbk50y9t/h43rXMwgeWryuxIKqhcmfIG6gPb9Ygmtl0pwmsfnGk7
         iD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wId29/KRlL3T3iL7X0HyROciU3enoTeQrmaI3uDvplM=;
        b=DC0eIpyOlVrmm5yHcpC79+F6WjQCENBHwfUt1Ls2oFMAmlAGVvIX73nPzCSe7JoS2T
         hq4yduXooP8FMM1q/f9CUT1Ql2XV6urzfK3vG2cRmm2KgCiH3yXpww8WCo34JTmmAltk
         PKqm2Int/VWIHLPEa0g3JsWFFetqm5H2HVyLpKazkyRbZ6j5QhAGVqmlgFZG2Vdgqnrm
         Q+IST2Ujh8OvB1zPiuel3nhm/tizUcCcyNrOktyXOd1HtyIhNqb4+77stz/VfbqXOHjz
         vkk+G7ucEL8z0VxpnTdvDqBWfIjFZqDeXJtG0X1jLwyOl0C0FH1Tx8SYUAiTHtV+X6yC
         TRZw==
X-Gm-Message-State: APjAAAUVxqLP0CDxrdO7ujURF/hU9eVUBnmbvR4/Qfdhc/0k6/tX41YO
        Rjq+g6lHBZYfpltwWg5wooXFrDTspA/lxKk9/Q==
X-Google-Smtp-Source: APXvYqzJjnEQKXMAlqlBk6hL4U4b6xmXEzBX0SnBKAOjCUKuT01y6ae1E3MP3SuI38xxfLnqA1lnQNJFkC1pyxj9Hg==
X-Received: by 2002:a1f:5945:: with SMTP id n66mr6951132vkb.58.1565306031133;
 Thu, 08 Aug 2019 16:13:51 -0700 (PDT)
Date:   Thu,  8 Aug 2019 16:13:35 -0700
Message-Id: <20190808231340.53601-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [RFC PATCH v2 0/5] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
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

Changes in v2:
- Split the patch into a 5 patch series.
- Fixed patch subject.

Mina Almasry (5):
  hugetlb_cgroup: Add hugetlb_cgroup reservation counter
  hugetlb_cgroup: add interface for charge/uncharge hugetlb reservations
  hugetlb_cgroup: add reservation accounting for private mappings
  hugetlb_cgroup: add accounting for shared mappings
  hugetlb_cgroup: Add hugetlb_cgroup reservation tests

 include/linux/hugetlb.h                       |  10 +-
 include/linux/hugetlb_cgroup.h                |  19 +-
 mm/hugetlb.c                                  | 256 ++++++++--
 mm/hugetlb_cgroup.c                           | 153 +++++-
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   4 +
 .../selftests/vm/charge_reserved_hugetlb.sh   | 438 ++++++++++++++++++
 .../selftests/vm/write_hugetlb_memory.sh      |  22 +
 .../testing/selftests/vm/write_to_hugetlbfs.c | 252 ++++++++++
 9 files changed, 1087 insertions(+), 68 deletions(-)
 create mode 100755 tools/testing/selftests/vm/charge_reserved_hugetlb.sh
 create mode 100644 tools/testing/selftests/vm/write_hugetlb_memory.sh
 create mode 100644 tools/testing/selftests/vm/write_to_hugetlbfs.c

--
2.23.0.rc1.153.gdeed80330f-goog
