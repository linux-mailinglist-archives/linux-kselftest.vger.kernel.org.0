Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10B26AD1FC
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 23:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCFWuj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 17:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCFWui (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 17:50:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62D83431A
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 14:50:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w192-20020a25dfc9000000b009fe14931caaso12082749ybg.7
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 14:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678143033;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hb/JdJnRstCiHb6uLxjoHUqYIXBW/NZZorg2FHxQCFI=;
        b=TPbOnADmbdqpnFsFLvKPr/SSUzR+W34C2wwBC2s89REqAS27kO9UPTCLcVJGnZ8WPi
         Jbz6BVE0uZl0launrxRyvrYVUt3gR/9D8g6QnIlWtOG+/YrQSU/yxJbfl79OmURQF6kA
         yIMqG+RPxcJFFOq6BPHBQKkEJc/0Ygf4x7BrKU+rmieTxu7KBIDwiosDR5iFBSV4CdhU
         r8FeFIAxn6PC0wCeDIiHpy7/ZWl9jvXk1j8x5zCKMr6UDCL1a0YL8oxt9owiblyw04mk
         bFojdRIzsLagPOBwUaXTuHyxh65jJ1kVzTW7/LzNhPx2ijGew4/eFcFdr2EnrFd4qZcT
         4c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143033;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hb/JdJnRstCiHb6uLxjoHUqYIXBW/NZZorg2FHxQCFI=;
        b=p8KTDN0r4N8csZl6GZ2OGRv+1TqcBDeOMiRpAsV9ZUen/XJfP+iG1GQ6MP6sBw9RKO
         smmlOb1nkHPgl559fT6UQcfuZRtvuOJ6Hn9bbcWGarCAbS6mZ+pcwvZwK6fq4NmQbSa4
         WcF+Z3qwNtYi7lQgAxLyQkSjE6FiST+YL2WAnDtpuEdctcRVgGyLFaYHit702MTFFCc8
         5SeoN3G5bEmUpbof8Z5XNgzjCReU2jM+fG2c0KbtkGqDSY7onTd2GPDT6RF4/jxpPno/
         uuQAsP0aGMdFwGbtNHRrZegY4UN5ZGr/L4DZKjEs8huruU0dx5s+YIHWTgzUR+OgdX1W
         HbOA==
X-Gm-Message-State: AO0yUKVFXZuljujApKVuDXEBWJg9fIaPFHrDcvxUgk5GcKcNqcM4sJTn
        /rw17nFKC1j5SzVp7kXPobu+X6QMvvB+CFivZXeq
X-Google-Smtp-Source: AK7set/PkFKTBVv8rb/ijZL0g/DGcxrk7FAkepszlqBXVP6/dldfpgHNd3E2bbiQcSg5PYF5nqRueFqjf9KjosxcivgJ
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:17e9:c330:41ce:6b08])
 (user=axelrasmussen job=sendgmr) by 2002:a25:910f:0:b0:afd:66d8:a495 with
 SMTP id v15-20020a25910f000000b00afd66d8a495mr3941062ybl.0.1678143032874;
 Mon, 06 Mar 2023 14:50:32 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:50:19 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306225024.264858-1-axelrasmussen@google.com>
Subject: [PATCH v3 0/5] mm: userfaultfd: refactor and add UFFDIO_CONTINUE_MODE_WP
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series, currently based on 6.3-rc1, is divided into two parts:

- Commits 1-4 refactor userfaultfd ioctl code without behavior changes, with the
  main goal of improving consistency and reducing the number of function args.
- Commit 5 adds UFFDIO_CONTINUE_MODE_WP.

The refactors are sorted by increasing controversial-ness, the idea being we
could drop some of the refactors if they are deemed not worth it.

Changelog:

v2->v3:
 - rebase onto 6.3-rc1
 - typedef a new type for mfill flags in patch 3/5 (suggested by Nadav)

v1->v2:
 - refactor before adding the new flag, to avoid perpetuating messiness

Axel Rasmussen (5):
  mm: userfaultfd: rename functions for clarity + consistency
  mm: userfaultfd: don't pass around both mm and vma
  mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
  mm: userfaultfd: don't separate addr + len arguments
  mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to install WP PTEs

 fs/userfaultfd.c                         | 120 +++++-------
 include/linux/hugetlb.h                  |  27 ++-
 include/linux/shmem_fs.h                 |   9 +-
 include/linux/userfaultfd_k.h            |  61 +++---
 include/uapi/linux/userfaultfd.h         |   7 +
 mm/hugetlb.c                             |  34 ++--
 mm/shmem.c                               |  14 +-
 mm/userfaultfd.c                         | 235 +++++++++++------------
 tools/testing/selftests/mm/userfaultfd.c |   4 +
 9 files changed, 247 insertions(+), 264 deletions(-)

--
2.40.0.rc0.216.gc4246ad0f0-goog

