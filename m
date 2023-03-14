Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7869F6BA22E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 23:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCNWPT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 18:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjCNWOt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 18:14:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE3C570A9
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 15:14:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i11-20020a256d0b000000b0086349255277so18483083ybc.8
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 15:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678831985;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v6jdDP8HhF+biD07TiydHxLy71rB2V7SdCiknod97SM=;
        b=kMu0VK08lTX+5fGCRmCECylQ1aqYZ8mpt4UDxQRqVGr8ZicRslJK6RZfMREIZJzldf
         b2WpiHLAep+eDhqTStwebxhwBuyEH+w8tmRzHHpxwWyep5Mh0PC88Wl2/3J4e+W7pAzP
         IDab7doSIoA8eZfk1DgaqTEDzb8HFVVtMZh95QNo3Qmw83r20VOALCNOvfejuXwDyc90
         CHLqs3kzNMn+KQjv8RdBvB11OBEEcP4lTTTzLF9fXIqz4pDf4RqUprJK1uTU3EK1dgHB
         BV6/EsDqJO7IonNIQMoqEv6ZVIdGnLhvdlGeLlPDsj6gw1dR15e+Snij3i1HCkBvM6z6
         bOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831985;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6jdDP8HhF+biD07TiydHxLy71rB2V7SdCiknod97SM=;
        b=KjKkTwk86iiFNZ8av8fJCA2Yd3HZvE7KXfT4x+t2A0HdBA5VVIp1a6WgzHgoqSPuRw
         sqK58lSwtSdUyFWM4aqQ3iE9F9WmPaOFqrPyfF9LejS5SM3ipiLgTYwjYXA1cjjMq+1V
         kdPq78rTtodsiE+mtMixfCtS194FLKXj463+Xpoe21RjRW4MzkVu6mlYfNNDxTuf1l7V
         iF03d9HcyC9DqoHxtxArN05iXsAILa+9ooZNYF/G6ULVxn57vM5jpTEE5bDHN/Q9hjcN
         Q57RBn4/B4TxQVSHpH2ZecBcAtEku7pGEwVoRCJ0A68AVQe3LYB8kkbavozW0KzG67VO
         nkxg==
X-Gm-Message-State: AO0yUKWQo4LXikTF4Y9/Ij+5PE0jas5VTp8zxswt1erjoxUiqbKJiwmX
        c7QLyl4Q+kD9SU5GBQ47w/rXNlULAPZtyOn3gafQ
X-Google-Smtp-Source: AK7set9RXicAeOPxAWz9Bj3vMYwmH12zqvh/H2CP6il+7wLaox5h+GED8g10IS8EvCU0qVZf8Sv5uMcqxHjOD8TzfHqN
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:21ce:bab3:17ec:2276])
 (user=axelrasmussen job=sendgmr) by 2002:a81:4512:0:b0:541:9f3a:ac46 with
 SMTP id s18-20020a814512000000b005419f3aac46mr6045642ywa.8.1678831985320;
 Tue, 14 Mar 2023 15:13:05 -0700 (PDT)
Date:   Tue, 14 Mar 2023 15:12:46 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230314221250.682452-1-axelrasmussen@google.com>
Subject: [PATCH v5 0/4] mm: userfaultfd: refactor and add UFFDIO_CONTINUE_MODE_WP
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series, currently based on 6.3-rc1, is divided into two parts:

- Commits 1-3 refactor userfaultfd ioctl code without behavior changes, with the
  main goal of improving consistency and reducing the number of function args.
- Commit 4 adds UFFDIO_CONTINUE_MODE_WP.

The refactors are sorted by increasing controversial-ness, the idea being we
could drop some of the refactors if they are deemed not worth it.

Changelog:

v4->v5:
 - rename "uffd_flags_has_mode" to "uffd_flags_mode_is"
 - modify "uffd_flags_set_mode" to clear mode bits before setting new mode
 - update userfaultfd documentation to describe new mode flag

v3->v4:
 - massage the uffd_flags_t implementation to eliminate all sparse warnings
 - add a couple inline helpers to make uffd_flags_t usage easier
 - drop the refactor passing `struct uffdio_range *` around (previously 4/5)
 - define a temporary `struct mm_struct *` in function with >=3 `vma->vm_mm`
 - consistent argument order between `flags` and `pagep`
 - expand on the use case in patch 4/4 message

v2->v3:
 - rebase onto 6.3-rc1
 - typedef a new type for mfill flags in patch 3/5 (suggested by Nadav)

v1->v2:
 - refactor before adding the new flag, to avoid perpetuating messiness

Axel Rasmussen (4):
  mm: userfaultfd: rename functions for clarity + consistency
  mm: userfaultfd: don't pass around both mm and vma
  mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
  mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to install WP PTEs

 Documentation/admin-guide/mm/userfaultfd.rst |   8 +
 fs/userfaultfd.c                             |  29 ++--
 include/linux/hugetlb.h                      |  27 ++-
 include/linux/shmem_fs.h                     |   9 +-
 include/linux/userfaultfd_k.h                |  69 +++++---
 include/uapi/linux/userfaultfd.h             |   7 +
 mm/hugetlb.c                                 |  28 +--
 mm/shmem.c                                   |  14 +-
 mm/userfaultfd.c                             | 170 +++++++++----------
 tools/testing/selftests/mm/userfaultfd.c     |   4 +
 10 files changed, 196 insertions(+), 169 deletions(-)

--
2.40.0.rc1.284.g88254d51c5-goog

