Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C3D7ABD0B
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Sep 2023 03:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjIWBb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 21:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjIWBb7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 21:31:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C97F7
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 18:31:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e1154756so48897517b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695432712; x=1696037512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KbsGHzMZ4WdaKCliylW7h6jhLyquTlpj2AXcxZt+2PU=;
        b=hu4s8X1ObsiMAumjGmwc677jy+DECfcMoAMShv1LsB17LiXE299JaaGP/EJxpfIVsU
         iGp5xEcqr3JpWnayCP+/AenGIHFBD7SPsvfUK73wTKrB5l6nTuZuXWjub2nNHC9m4QX3
         jN/IF2ckgiDlZVCq2Qp5FfSbdGeWizvKrNC5x17HCWatp1fpjZk8bjP8+gQYMCZ8mFAW
         0XZtzlQhHVD2EkLjlHQgjPrkiUkd1/OrQvkNUIPNXt55+ehVk373uwDl5ezID6b3sKhy
         bEWXizgT68hdtI1DnH3xeGqhMfIZ3r/KQav//mNMDIizELhubTquhsPFaAlmsYTvfJav
         yT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695432712; x=1696037512;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbsGHzMZ4WdaKCliylW7h6jhLyquTlpj2AXcxZt+2PU=;
        b=SVATe0BBmk3h23leA+jgqB5WoXN62GCbCy148IFnyLD9auXK2BD6SYX6hnU5NO1I3o
         woIjxdaoduUGyUFU70ULkaqlgPlR1Z8sG/6IMU77piy00QVR2sMQyGjcc7FAtjt2MnUp
         NZMm2aQYQZ94tkyLICP+caO7g+YRaJDGzd9+rn36g5iRJiQieQ5ceRb8LsW0AE9Rk3BA
         YiPvaBETHc6LlIjlSurnXOGatwt5Zw8iBh98PG4LM1Bteq7mqf8BaM/vctTdgoW8gAxV
         5V0zdwLKhhb7tH4N0oXscx1jJlib0l+mxiOdzal5cmCMZgchqGadFwyV0D09Jm4lH3bI
         ln8A==
X-Gm-Message-State: AOJu0YyTyOCkZIx0wCvo/28VNyYcDW/a0/k3aJD1ZWbOUJb9sPrJkCOX
        9Bol2C+kNCU+P2XGtAZ6/XlmYSLqlHY=
X-Google-Smtp-Source: AGHT+IE4ADU4C0Pp+rt39uFleka+iXZpTfhXH7ZHR9+MVLwVc0IPZg1d6xDn1jjOqOJRYkPT+nl5tp2OE6Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3398:6644:ed7f:bec9])
 (user=surenb job=sendgmr) by 2002:a25:48f:0:b0:d86:5644:5d12 with SMTP id
 137-20020a25048f000000b00d8656445d12mr9916ybe.4.1695432711967; Fri, 22 Sep
 2023 18:31:51 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:31:43 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230923013148.1390521-1-surenb@google.com>
Subject: [PATCH v2 0/3] userfaultfd remap option
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series introduces UFFDIO_REMAP feature to userfaultfd, which
has long been implemented and maintained by Andrea in his local tree [1],
but was not upstreamed due to lack of use cases where this approach would
be better than allocating a new page and copying the contents.

UFFDIO_COPY performs ~20% better than UFFDIO_REMAP when the application
needs pages to be allocated [2]. However, with UFFDIO_REMAP, if pages are
available (in userspace) for recycling, as is usually the case in heap
compaction algorithms, then we can avoid the page allocation and memcpy
(done by UFFDIO_COPY). Also, since the pages are recycled in the
userspace, we avoid the need to release (via madvise) the pages back to
the kernel [3].
We see over 40% reduction (on a Google pixel 6 device) in the compacting
thread=E2=80=99s completion time by using UFFDIO_REMAP vs. UFFDIO_COPY. Thi=
s was
measured using a benchmark that emulates a heap compaction implementation
using userfaultfd (to allow concurrent accesses by application threads).
More details of the usecase are explained in [3].

Furthermore, UFFDIO_REMAP enables remapping swapped-out pages without
touching them within the same vma. Today, it can only be done by mremap,
however it forces splitting the vma.

Main changes since Andrea's last version [1]:
- Trivial translations from page to folio, mmap_sem to mmap_lock
- Replace pmd_trans_unstable() with pte_offset_map_nolock() and handle its
possible failure
- Move pte mapping into remap_pages_pte to allow for retries when source
page or anon_vma is contended. Since pte_offset_map_nolock() start RCU
read section, we can't block anymore after mapping a pte, so have to unmap
the ptesm do the locking and retry.
- Add and use anon_vma_trylock_write()  to avoid blocking while in RCU
read section.
- Accommodate changes in mmu_notifier_range_init() API, switch to
mmu_notifier_invalidate_range_start_nonblock() to avoid blocking while in
RCU read section.
- Open-code now removed __swp_swapcount()
- Replace pmd_read_atomic() with pmdp_get_lockless()
- Add new selftest for UFFDIO_REMAP

Changes since v1 [4]:
- add mmget_not_zero in userfaultfd_remap, per Jann Horn
- removed extern from function definitions, per Matthew Wilcox
- converted to folios in remap_pages_huge_pmd, per Matthew Wilcox
- use PageAnonExclusive in remap_pages_huge_pmd, per David Hildenbrand
- handle pgtable transfers between MMs, per Jann Horn
- ignore concurrent A/D pte bit changes, per Jann Horn
- split functions into smaller units, per David Hildenbrand
- test for folio_test_large in remap_anon_pte, per Matthew Wilcox
- use pte_swp_exclusive for swapcount check, per David Hildenbrand
- eliminated use of mmu_notifier_invalidate_range_start_nonblock,
per Jann Horn
- simplified THP alignment checks, per Jann Horn
- refactored the loop inside remap_pages, per Jann Horn
- additional clarifying comments, per Jann Horn

[1] https://gitlab.com/aarcange/aa/-/commit/2aec7aea56b10438a3881a20a411aa4=
b1fc19e92
[2] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@r=
edhat.com/
[3] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqx=
RCyjniNVjp0Aw@mail.gmail.com/
[4] https://lore.kernel.org/all/20230914152620.2743033-1-surenb@google.com/

Andrea Arcangeli (2):
  userfaultfd: UFFDIO_REMAP: rmap preparation
  userfaultfd: UFFDIO_REMAP uABI

Suren Baghdasaryan (1):
  selftests/mm: add UFFDIO_REMAP ioctl test

 fs/userfaultfd.c                             |  63 ++
 include/linux/rmap.h                         |   5 +
 include/linux/userfaultfd_k.h                |  12 +
 include/uapi/linux/userfaultfd.h             |  22 +
 mm/huge_memory.c                             | 130 ++++
 mm/khugepaged.c                              |   3 +
 mm/rmap.c                                    |  13 +
 mm/userfaultfd.c                             | 590 +++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.c     |  41 +-
 tools/testing/selftests/mm/uffd-common.h     |   1 +
 tools/testing/selftests/mm/uffd-unit-tests.c |  62 ++
 11 files changed, 940 insertions(+), 2 deletions(-)

--=20
2.42.0.515.g380fc7ccd1-goog

