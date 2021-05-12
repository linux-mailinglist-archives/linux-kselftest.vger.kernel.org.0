Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ABE37EF43
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 01:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhELXB0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 19:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388294AbhELVtR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 17:49:17 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F7C06124F
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:06 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 76-20020a62164f0000b029027f27f50e56so15832025pfw.16
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5jUpkIWfMaq5Jmoaunq8eRpC3Xi5xzv1ZG/MFZDMBzk=;
        b=WGvG1+DLOaYsWwslzcFaBddiYRxp0XLqVYB2uArPgDzBleiI+uU3cDpZD1xK69YsJ1
         VY7xsOG//Dm7VOkj9PySP6eJvXdk66vQgdIaBXmFdzqhqDRnRDJ4ZteE1Q5Jkioj0Eyy
         Z4+DzQ36g5xqcpcc6bJb4Dwzj6ERvA9KCFrl6ETG1oxasRhdbscS7A3TMKEjJQxObA7L
         k0esfRk4vbESKv1UUlqYB8b4fRIuJFTme0t/PZ27GsZJZU4umFYYr53CGFaI9ZhkaS07
         CwZpz4xwZD3+xTAgBF7COPrLiUOF/gBc2jcwD3zczjVHVubH6LLTCDntZF3i6NRIe95G
         zGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5jUpkIWfMaq5Jmoaunq8eRpC3Xi5xzv1ZG/MFZDMBzk=;
        b=TpGxo2Y+N3bQ9yHIQwWaMXzcZlvi818IxKGxqY1ZV5SjQCk80leosbosdBdfM00MU0
         yZEU663ObqEu29Nz7b5+b0FAwulrX+MtCsLPiIw9d6qNuZmmcCbLow0IFC0AQs8nkdQ1
         Ck/hAQYbQ6H3rylaiT6AMdC9kf2dtV4UJkVRD87VrcMtVoN4vykyAx+KyT31GlDoSK95
         +U12Dr9mpzOHb25eDV9x4O3hAWRARvxQDqde/OS7OUmfovoXoXNwEaGhozZK5KbdSuf5
         6EhnUE5dfcUFV1LJydL5UpoSMlS5i9FbIQICjfxKiwIohhovY40GcbU86duPqc3+e17I
         jziQ==
X-Gm-Message-State: AOAM530W2IPIWA7O07Vcz/sv+DwtjZxwaRT4dei5lG2yvPkCTgj7b2GX
        Wi6X5pg7MfheTqQfzdFt79CA+YKuqbH9nv7kemaO
X-Google-Smtp-Source: ABdhPJznlwzFf+8b63G8BSVyi6fcbSnTpML8PUgB8sdorKJKvZseAtm8CUY4Wm7UAnSfjya00Qx++cbvuCwwU2jBGzQo
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:29e5:10fc:1128:b0c0])
 (user=axelrasmussen job=sendgmr) by 2002:a17:902:7488:b029:ef:838a:3071 with
 SMTP id h8-20020a1709027488b02900ef838a3071mr4687161pll.61.1620855905759;
 Wed, 12 May 2021 14:45:05 -0700 (PDT)
Date:   Wed, 12 May 2021 14:44:57 -0700
Message-Id: <20210512214502.2047008-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 0/5] KVM: selftests: exercise userfaultfd minor faults
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

These patches are based upon Andrew Morton's v5.13-rc1-mmots-2021-05-10-22-15
tag. This is because this series depends on:

- UFFD minor fault support for hugetlbfs (in v5.13-rc1) [1]
- UFFD minor fault support for shmem (in Andrew's tree) [2]

[1] https://lore.kernel.org/linux-fsdevel/20210301222728.176417-1-axelrasmussen@google.com/
[2] https://lore.kernel.org/patchwork/cover/1420967/

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

Axel Rasmussen (5):
  KVM: selftests: allow different backing memory types for demand paging
  KVM: selftests: add shmem backing source type
  KVM: selftests: create alias mappings when using shared memory
  KVM: selftests: allow using UFFD minor faults for demand paging
  KVM: selftests: add shared hugetlbfs backing source type

 .../selftests/kvm/demand_paging_test.c        | 146 +++++++++++++-----
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../testing/selftests/kvm/include/test_util.h |  11 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  79 +++++++++-
 .../selftests/kvm/lib/kvm_util_internal.h     |   2 +
 tools/testing/selftests/kvm/lib/test_util.c   |  46 ++++--
 6 files changed, 222 insertions(+), 63 deletions(-)

--
2.31.1.607.g51e8a6a459-goog

