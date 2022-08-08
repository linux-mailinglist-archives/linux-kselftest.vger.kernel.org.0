Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A558CD2C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 19:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbiHHR5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Aug 2022 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244140AbiHHR4i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Aug 2022 13:56:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E217E2A
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 10:56:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a11-20020a5b090b000000b00672acbe13c1so7942230ybq.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Aug 2022 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=yr7nZVaG6KnPFzU0GkO8LDPXim3Y8RycylsE6e+KYS8=;
        b=XTaOh2Emx3RzjrAPUqBKn7IkMuMVZE1sNV0UiYrdi4ST+a2W2wVmMRWlnckX47kh8Z
         3pwWPZdwO8GQdIoktR8SRLEK3dSAejavjjUTWBsMyR+Lp5qe4E/lj1k5E4pudhXvTlU1
         vWnmtqMlJJxhIo/oHFLmarz9DbuZqb7BY/Hq5+m69WpRoZFozOBzbmm16L/QQMNwNYDw
         /zjQVMRUVK3zklQ5u/E8z49CYBhRyjzy5hwdW98+CYPELiPv45DHhqY4YhFMqJv/CvHY
         fo3mzTiobWlSpgKtmrAIQxHOldOvv7ws6xTPxVwYC1JWlOe8DXo3TZGLvcyRrvwKcC6H
         hdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=yr7nZVaG6KnPFzU0GkO8LDPXim3Y8RycylsE6e+KYS8=;
        b=D1cmYInIoKNc+TKBSuy1FbspILnKmveNfRXQlCKAqrMX/UGczwlz+MG4gZrYyjkqwh
         B0Flkx7pHjEQa73sHI7vUqbvD0YYeyWHhtSw7BEjUNttKz2+YlwyOG48pG834EY7wA8W
         bsaAglqpNmc8Rykbvgn5zw1ghqijA+e+feEZZiKrdY23pZcg7025RdHAEIzDrZb52R0t
         ktttzQfyT2pu04Y0saPMGFYvQRQSnwd7s0MuQ27Rpd1OOMXNIRhC8pEwa5qj1Tr4ARJP
         iMRkg8TDKVUcX+3IiyP1emxP3kxQuHsdaBwNo09oucExUjCMEwJI5g/rb0bhydAMpRG2
         sRlA==
X-Gm-Message-State: ACgBeo1PMdyUXiyLQZinzjAVhad25LiFYH13jNtf3A4HZs+o+60GAZgU
        GSuxs90seoECbRo/1QxQQzLXzeptmiC3c4P2iV6f
X-Google-Smtp-Source: AA6agR5OFChi2bWVcsCQV2S7ZdR7lgDMmRJT1bj1DNJoylej7bIRyUqOMr7NzN7+osLysSkQ7f1ZEMtCfU38FTFoNzeM
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:7a2a:3bb5:f3a0:3bbc])
 (user=axelrasmussen job=sendgmr) by 2002:a25:25d8:0:b0:671:80a8:2d73 with
 SMTP id l207-20020a2525d8000000b0067180a82d73mr16769495ybl.125.1659981390656;
 Mon, 08 Aug 2022 10:56:30 -0700 (PDT)
Date:   Mon,  8 Aug 2022 10:56:13 -0700
In-Reply-To: <20220808175614.3885028-1-axelrasmussen@google.com>
Message-Id: <20220808175614.3885028-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220808175614.3885028-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 4/5] userfaultfd: update documentation to describe /dev/userfaultfd
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Explain the different ways to create a new userfaultfd, and how access
control works for each way.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 41 ++++++++++++++++++--
 Documentation/admin-guide/sysctl/vm.rst      |  3 ++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 6528036093e1..a76c9dc1865b 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -17,7 +17,10 @@ of the ``PROT_NONE+SIGSEGV`` trick.
 Design
 ======
 
-Userfaults are delivered and resolved through the ``userfaultfd`` syscall.
+Userspace creates a new userfaultfd, initializes it, and registers one or more
+regions of virtual memory with it. Then, any page faults which occur within the
+region(s) result in a message being delivered to the userfaultfd, notifying
+userspace of the fault.
 
 The ``userfaultfd`` (aside from registering and unregistering virtual
 memory ranges) provides two primary functionalities:
@@ -34,12 +37,11 @@ The real advantage of userfaults if compared to regular virtual memory
 management of mremap/mprotect is that the userfaults in all their
 operations never involve heavyweight structures like vmas (in fact the
 ``userfaultfd`` runtime load never takes the mmap_lock for writing).
-
 Vmas are not suitable for page- (or hugepage) granular fault tracking
 when dealing with virtual address spaces that could span
 Terabytes. Too many vmas would be needed for that.
 
-The ``userfaultfd`` once opened by invoking the syscall, can also be
+The ``userfaultfd``, once created, can also be
 passed using unix domain sockets to a manager process, so the same
 manager process could handle the userfaults of a multitude of
 different processes without them being aware about what is going on
@@ -50,6 +52,39 @@ is a corner case that would currently return ``-EBUSY``).
 API
 ===
 
+Creating a userfaultfd
+----------------------
+
+There are two ways to create a new userfaultfd, each of which provide ways to
+restrict access to this functionality (since historically userfaultfds which
+handle kernel page faults have been a useful tool for exploiting the kernel).
+
+The first way, supported since userfaultfd was introduced, is the
+userfaultfd(2) syscall. Access to this is controlled in several ways:
+
+- Any user can always create a userfaultfd which traps userspace page faults
+  only. Such a userfaultfd can be created using the userfaultfd(2) syscall
+  with the flag UFFD_USER_MODE_ONLY.
+
+- In order to also trap kernel page faults for the address space, then either
+  the process needs the CAP_SYS_PTRACE capability, or the system must have
+  vm.unprivileged_userfaultfd set to 1. By default, vm.unprivileged_userfaultfd
+  is set to 0.
+
+The second way, added to the kernel more recently, is by opening and issuing a
+USERFAULTFD_IOC_NEW ioctl to /dev/userfaultfd. This method yields equivalent
+userfaultfds to the userfaultfd(2) syscall.
+
+Unlike userfaultfd(2), access to /dev/userfaultfd is controlled via normal
+filesystem permissions (user/group/mode), which gives fine grained access to
+userfaultfd specifically, without also granting other unrelated privileges at
+the same time (as e.g. granting CAP_SYS_PTRACE would do). Users who have access
+to /dev/userfaultfd can always create userfaultfds that trap kernel page faults;
+vm.unprivileged_userfaultfd is not considered.
+
+Initializing a userfaultfd
+--------------------------
+
 When first opened the ``userfaultfd`` must be enabled invoking the
 ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
 a later API version) which will specify the ``read/POLLIN`` protocol
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f74f722ad702..b3e40b42e1b3 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -927,6 +927,9 @@ calls without any restrictions.
 
 The default value is 0.
 
+Another way to control permissions for userfaultfd is to use
+/dev/userfaultfd instead of userfaultfd(2). See
+Documentation/admin-guide/mm/userfaultfd.rst.
 
 user_reserve_kbytes
 ===================
-- 
2.37.1.559.g78731f0fdb-goog

