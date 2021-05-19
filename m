Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A202138975A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 22:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhESUFJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhESUFJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 16:05:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680BFC061761
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so19421404ybo.11
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TRzyq4oNy0xbwezI+8cBZnf/nTLSb+t8cRqYWcWY/Eg=;
        b=CxvtArSRKX6OIHDHNbloVqlUItuDs1pUVWO461kxImFFcH32VxsUk8wQRTWZwQ6azV
         xH9kIDgHSGkmKm3QMzYT8uD5SUun0xyFySIS+XdVS0A3rqkbCqR3aWZIGyOmeKCdjjEj
         ZC2H/hOoPa5G7ZMVYY0Ra3jjN+vFL3opMB+3VKbRuP9Um+YHZNcNdhuIUS/xWwqbJH+i
         jXPI/8k+0f6H7op/p+Aa0EWorl/GZObZys8KJJnM7xcqT6q9C+QoQGA3cOfd6VG2rF60
         ETVQ91+uqYc3SF2jfC1c2q0N8ia/NuFB3pTg7Cf2b5wJCmdp2TJch+OuowdqLY9nCkD2
         dOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TRzyq4oNy0xbwezI+8cBZnf/nTLSb+t8cRqYWcWY/Eg=;
        b=nQEG/aaV4w/p0BNTWvqHHMtu3l0F0cXIcAOl/iaGJadq9KDjEvMg55DDLmtaPFxlG3
         0lTHLWdyPWN0pUMMJJxVFdJ0MAt5SKF+0/k6hTaSd2MttpeAfga2uTOSq4Xb8UGQsbhh
         6nHQw789cGX7XGdMg+Z/BD+MX1becl6nwbajnGXLOoRe333iCaGyyCTXEcTdqR+tsqBj
         IYhckZ/sXrte27cI1+0zKlis2+apXjnS7Fzi/BWqGyurWy9fWDi0NzaKm0eOGiGNHI1A
         yZGCP6eFdv7W1fLRZbai3R0EjbxuYg9GJixu9RG9e3SVd+G/5QHFrp81Cj6KSEtVn6W4
         u66g==
X-Gm-Message-State: AOAM530lLbbbqS817G5pcYrgNeDmYWFLAOFBz7oFMdp8n2vqViJB9sq3
        CUdTfttwMOChBjSoOUlAsvb0E5TBqGnOKepH0L82
X-Google-Smtp-Source: ABdhPJyFo1HijtaGGGcxKGVnq1SWKSvHoMWpsxuc+TwmN6hh5Zag+cdBMzwAriowHUIKTHlRVkauQ7YZIi2LKSLHBpWj
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7eb5:10bb:834a:d5ec])
 (user=axelrasmussen job=sendgmr) by 2002:a25:8205:: with SMTP id
 q5mr1802119ybk.170.1621454627516; Wed, 19 May 2021 13:03:47 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:29 -0700
Message-Id: <20210519200339.829146-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 00/10] KVM: selftests: exercise userfaultfd minor faults
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Gardon <bgardon@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Base
====

These patches are based upon Andrew Morton's v5.13-rc1-mmots-2021-05-13-17-23
tag. This is because this series depends on:

- UFFD minor fault support for hugetlbfs (in v5.13-rc1) [1]
- UFFD minor fault support for shmem (in Andrew's tree) [2]

[1] https://lore.kernel.org/linux-fsdevel/20210301222728.176417-1-axelrasmussen@google.com/
[2] https://lore.kernel.org/patchwork/cover/1420967/

Changelog
=========

v1->v2:
- Picked up Reviewed-by's.
- Change backing_src_is_shared() to check the flags, instead of the type. This
  makes it robust to adding new backing source types in the future.
- Add another commit which refactors setup_demand_paging() error handling.
- Print UFFD ioctl type once in setup_demand_paging, instead of on every page-in
  operation.
- Expand comment on why we use MFD_HUGETLB instead of MAP_HUGETLB.
- Reworded comment on addr_gpa2alias.
- Moved demand_paging_test.c timing calls outside of the if (), deduplicating
  them.
- Split trivial comment / logging fixups into a separate commit.
- Add another commit which prints a clarifying message on test skip.
- Split the commit allowing backing src_type to be modified in two.
- Split the commit adding the shmem backing type in two.
- Rebased onto v5.13-rc1-mmots-2021-05-13-17-23.

Overview
========

Minor fault handling is a new userfaultfd feature whose goal is generally to
improve performance. In particular, it is intended for use with demand paging.
There are more details in the cover letters for this new feature (linked above),
but at a high level the idea is that we think of these three phases of live
migration of a VM:

1. Precopy, where we copy "some" pages from the source to the target, while the
   VM is still running on the source machine.
2. Blackout, where execution stops on the source, and begins on the target.
3. Postcopy, where the VM is running on the target, some pages are already up
   to date, and others are not (because they weren't copied, or were modified
   after being copied).

During postcopy, the first time the guest touches memory, we intercept a minor
fault. Userspace checks whether or not the page is already up to date. If
needed, we copy the final version of the page from the soure machine. This
could be done with RDMA for example, to do it truly in place / with no copying.
At this point, all that's left is to setup PTEs for the guest: so we issue
UFFDIO_CONTINUE. No copying or page allocation needed.

Because of this use case, it's useful to exercise this as part of the demand
paging test. It lets us ensure the use case works correctly end-to-end, and also
gives us an in-tree way to profile the end-to-end flow for future performance
improvements.

Axel Rasmussen (10):
  KVM: selftests: trivial comment/logging fixes
  KVM: selftests: simplify setup_demand_paging error handling
  KVM: selftests: print a message when skipping KVM tests
  KVM: selftests: compute correct demand paging size
  KVM: selftests: allow different backing source types
  KVM: selftests: refactor vm_mem_backing_src_type flags
  KVM: selftests: add shmem backing source type
  KVM: selftests: create alias mappings when using shared memory
  KVM: selftests: allow using UFFD minor faults for demand paging
  KVM: selftests: add shared hugetlbfs backing source type

 .../selftests/kvm/demand_paging_test.c        | 175 +++++++++++-------
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../testing/selftests/kvm/include/test_util.h |  12 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  84 ++++++++-
 .../selftests/kvm/lib/kvm_util_internal.h     |   2 +
 tools/testing/selftests/kvm/lib/test_util.c   |  51 +++--
 6 files changed, 238 insertions(+), 87 deletions(-)

--
2.31.1.751.gd2f1c929bd-goog

