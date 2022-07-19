Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F09557A7B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 21:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiGST5J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 15:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiGST4u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 15:56:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8375D0FC
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 12:56:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z9-20020a258689000000b0066e38ab7122so11542779ybk.9
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D+axFZcXM2aiH957XKoLzm0NK888e8vhfRqJcL8tQlk=;
        b=Q6lTmACHbxPLYKcD6TEAkGdodCXui8T8KQJjaNpTrLvbWN5YYkAgyFnxcQZ0lRY7oa
         9acQO03dUwhSLLvwZgG97CGmC+M40EFkdd14zNVuiZQDK4FpyM9U525S0X5c7VpbI6Xn
         marrPlcC1B8OnVdKcyWLEzuxmfyKhQY6KJ04vb6BCCY7/tXnVjU1sHyYUUStNY026lvx
         a1JgtjHgsUNop33vm+b+5kvkCAIjGuUeNHlBhU7D03TW84KjTflKGPaQP9ECMhxEIUtS
         /x21ATGjiJ/WPYC9JCPHfhv5dMPm6wUIZ9DJZ6WQtg1p5yFpjTb5vnOzyYzl9H6HwAsK
         MVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D+axFZcXM2aiH957XKoLzm0NK888e8vhfRqJcL8tQlk=;
        b=Vogc4DcQZ1/yqYDTgjSD7lPaAp287xV4vdXjRZ2kR5bSqJ60xPPtC/USK9A2US3eUy
         MwWFM/dUYW196KtOCSthSCw06EzunTeyp04QL9YQLDxZtLkA633ECZayTs3JShO+sXHl
         JktJ9du2kbDwBv8ZqKFHxy3PX/KLp0wpJ8mG3FmxkQ6l+8h3V1eFK9ybN8LyZSZIGWky
         k/9ApEBhTK3LffKHY5C1jq0nnP5QgduhU5MPWqVXvtkNz64n6MSiBOXQ9QKUQoN17eJv
         NdQi0VEO5Jy22CEeF+KEL7PeihvhorWCL8SCjtAB/2WjQCbRWqnITY/k1/ooAN+vexuw
         do7A==
X-Gm-Message-State: AJIora9WkWhsz8z1YCGSYAdKtiPFWUq6XxeFwRCK0xy/6dUG5lPrCEyo
        T1XaIcnTZ25sx3RIYZ2V4+2YRHVEYbL4hBtEoEBp
X-Google-Smtp-Source: AGRyM1sQ1a9x2GIZzx4aY+TQYaC9bhDEJVn0xFYWIaHkF0vSABxhMbIcNlU/zTDwvgT/LJednu8AwjLGuGiRA1DWNMMo
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:a065:9221:e40d:4fbe])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:202:0:b0:66f:aab4:9c95 with SMTP
 id z2-20020a5b0202000000b0066faab49c95mr32614656ybl.81.1658260602570; Tue, 19
 Jul 2022 12:56:42 -0700 (PDT)
Date:   Tue, 19 Jul 2022 12:56:27 -0700
In-Reply-To: <20220719195628.3415852-1-axelrasmussen@google.com>
Message-Id: <20220719195628.3415852-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220719195628.3415852-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 4/5] userfaultfd: update documentation to describe /dev/userfaultfd
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
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

Explain the different ways to create a new userfaultfd, and how access
control works for each way.

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
index 5c9aa171a0d3..36cf21f3b7ab 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -928,6 +928,9 @@ calls without any restrictions.
 
 The default value is 0.
 
+Another way to control permissions for userfaultfd is to use
+/dev/userfaultfd instead of userfaultfd(2). See
+Documentation/admin-guide/mm/userfaultfd.rst.
 
 user_reserve_kbytes
 ===================
-- 
2.37.0.170.g444d1eabd0-goog

