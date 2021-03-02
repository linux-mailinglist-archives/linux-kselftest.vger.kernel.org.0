Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE532A7BE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Mar 2021 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbhCBQaI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Mar 2021 11:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbhCBACS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Mar 2021 19:02:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B407C06178B
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Mar 2021 16:01:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u1so20683837ybu.14
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Mar 2021 16:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=9heSrccM4QtbO8zJbZROi2fke/pBPWI/6xjb8kl8EnA=;
        b=v6/QDeREsxB4ARFCeFWrSwJ2dSOaKDO4I9YTPff/uItNGTtUIPsya5PcsPffq9USJV
         GyLgJlAiJtpUdoBfsiCVqJ8PnpkRa85psOWf6na+KGzRfr2Lrk9fNewpTU5x6pczbof1
         xnh7jFSPMCqUCA3rIJEHHdO9iQiZKpT/iXDIYNtVbOYVpbORcp+OEKp/seXIsX3DKu5z
         vz3jixxH+biRLNNZR5UwrHfpYr2uLeMroJEM1ECn5+/UPmTS5QfRMdLU9LU4k2ewYTsN
         4RmHX1IZkJBxo51233WQAq/+zg+fU7F1yG06Tv4YSY9xxqIsE9C/ypSk8QzdibOfDWRq
         HqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=9heSrccM4QtbO8zJbZROi2fke/pBPWI/6xjb8kl8EnA=;
        b=KpJq+WUTgCzb3HCpbRjgyc0B6bxRo3Ener2yF/hqoXzRpOeLJElvGni7+vyxnkKfJj
         jWUetcmXKhv24iQUMd95IglE+rvfHdDLhvt0++22SmKdS8+4VDTmoxb1LcKAjQd3+VSk
         Fn0yWf0OvDweLyNZ27fKnpj8+r9aqx8VYEV7T1AqC2NuB+oSpQ84Su/8XSBRnzhacVfG
         qNAsIOlIj8b8lmY9eUvezBfNkJtg22waM76A7UF4ddD/ceB39MJ5YSdf5Ef+gN8xj7YX
         v4J0ia+m06dbt1IdzZY1s0iOt/KuQyBkPFua+dfUNnqn51BW5Rj853kNSTRJJXltfc+/
         qvQg==
X-Gm-Message-State: AOAM531e+vklqt3n/XLfVV7GTeiUJK/Lyt5RaXTm99Gh9Mv9XJWAWDnT
        l74lXIbMg4PVd2H+mP3vUjJ+PrHMj7d1r8qCmQwI
X-Google-Smtp-Source: ABdhPJwsjvTDQKynUq7mWB/rP6Sd9oEm0+6px27QpmseIPIUTtqRcvUs45V4lejD7oru/ynawP80FvtnrstPwSCt+XlZ
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1998:8165:ca50:ab8d])
 (user=axelrasmussen job=sendgmr) by 2002:a25:c0ca:: with SMTP id
 c193mr27567242ybf.74.1614643297301; Mon, 01 Mar 2021 16:01:37 -0800 (PST)
Date:   Mon,  1 Mar 2021 16:01:28 -0800
Message-Id: <20210302000133.272579-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 0/5] userfaultfd: support minor fault handling for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Base
====

This series is based on top of my series which adds minor fault handling for
hugetlbfs [1]. (And, therefore, it is based on 5.12-rc1 and Peter Xu's series
for disabling huge pmd sharing as well.)

[1] https://lore.kernel.org/linux-fsdevel/20210301222728.176417-1-axelrasmussen@google.com/T/#t

Changelog
=========

v1->v2:
- For UFFDIO_CONTINUE, don't mess with page flags. Just use find_lock_page to
  get a locked page from the page cache, instead of doing __SetPageLocked.
  This fixes a VM_BUG_ON v1 hit when handling minor faults for THP-backed
  shmem (a tmpfs mounted with huge=always).

Overview
========

See my original series linked above for a detailed overview of minor fault
handling in general. The feature in this series works exactly like the
hugetblfs version (from userspace's perspective).

I'm sending this as a separate series because:

- The original minor fault handling series has a full set of R-Bs, and seems
  close to being merged. So, it seems reasonable to start looking at this next
  step, which extends the basic functionality.

- shmem is different enough that this series may require some additional work
  before it's ready, and I don't want to delay the original series
  unnecessarily by bundling them together.

Use Case
========

In some cases it is useful to have VM memory backed by tmpfs instead of
hugetlbfs. So, this feature will be used to support the same VM live migration
use case described in my original series.

Additionally, Android folks (Lokesh Gidra <lokeshgidra@google.com>) hope to
optimize the Android Runtime garbage collector using this feature:

"The plan is to use userfaultfd for concurrently compacting the heap. With
this feature, the heap can be shared-mapped at another location where the
GC-thread(s) could continue the compaction operation without the need to
invoke userfault ioctl(UFFDIO_COPY) each time. OTOH, if and when Java threads
get faults on the heap, UFFDIO_CONTINUE can be used to resume execution.
Furthermore, this feature enables updating references in the 'non-moving'
portion of the heap efficiently. Without this feature, uneccessary page
copying (ioctl(UFFDIO_COPY)) would be required."

Axel Rasmussen (5):
  userfaultfd: support minor fault handling for shmem
  userfaultfd/selftests: use memfd_create for shmem test type
  userfaultfd/selftests: create alias mappings in the shmem test
  userfaultfd/selftests: reinitialize test context in each test
  userfaultfd/selftests: exercise minor fault handling shmem support

 fs/userfaultfd.c                         |   6 +-
 include/linux/shmem_fs.h                 |  26 +-
 include/uapi/linux/userfaultfd.h         |   4 +-
 mm/memory.c                              |   8 +-
 mm/shmem.c                               |  92 +++----
 mm/userfaultfd.c                         |  27 +-
 tools/testing/selftests/vm/userfaultfd.c | 322 +++++++++++++++--------
 7 files changed, 295 insertions(+), 190 deletions(-)

--
2.30.1.766.gb4fecdf3b7-goog

