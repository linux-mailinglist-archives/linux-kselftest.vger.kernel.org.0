Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C059A749
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 23:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352053AbiHSUxu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 16:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352042AbiHSUwf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 16:52:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5DF10E967
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 13:52:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-333b218f2cbso94415287b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=jMyZorWE6E22hV3NDdjIMErSuhZAX9bJlMRQ4lfwoQk=;
        b=IpWUwfsPRKJE7OaJsJdB2L08XMnLW2ICg+R0QoqCfLw/E4APvPDrTfhcUirY+CZND6
         evb3tGyOoymzo6FCUW8oF7Syaupj6TQjDhLih1PVQf/Rio67h8m/TNR8mc+mNIFCccFO
         XDR3/ttkxX+6+uyZ0L00oWOJw7Abd3WlwNN0nzKmbpMcBzrOLmiIY2XAchs5p9aaKPyV
         19dMLz80LBUqjO9wA3XLdqK8TlQm9heL8kJXn7tdZEh0h1An+wd9Oxwp+/xzzATJG9Wb
         jFJZoo5Q77AwoC/iF70h0EENSO63wwRgUEvWmas1zzZOsbJjVnw2hhoS71ceZe4QoIX8
         uB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jMyZorWE6E22hV3NDdjIMErSuhZAX9bJlMRQ4lfwoQk=;
        b=W4ysmyU8rhb0bfqzzgTNZWbC4XGAxbgBMbi0nazPTUECgPksPuzXtgZxnIlLXCaap6
         NOpDhzFOfyS47gfJWGxpgVZq3ynATvMFw9mr7PryrLi6xcpodwT+U6rSDsSmU4F4ENYl
         4l1KItVyAiQ/VGss1mM8G8i1Krm4TgeTzHpwNzSCd+aayUwIdCBk40gRQnh9Bx6Y6jnW
         wfvHo6hC5NkStwn1fqhDEnezWgsxQe3KnYUz84PGO3G77HANLx/mqNVy3e7hizRO7APz
         8KNOmyyaLJ8bKgUz5NKJ13kFAqp1qLfcFq2D6uHaIu2pH4fQX4rTrJv+uFUhqQBKVo5M
         QFMg==
X-Gm-Message-State: ACgBeo3iSjPe+OCeEHbDt/0/3ZWql34/HzXYUrCCYu7Yf3wgPzUAoRuN
        OlUJ9U4BbM2vnL7vQl0rHcXOuPtxevrEgCtYeojM
X-Google-Smtp-Source: AA6agR5HOAyxwvEDm7V3pQX2zZvc4IogiVRAS3GDNSIX/0PRNm7ftLReSWlEyTi49ZVZs+XnFcamtJitzIArA/qTOKgk
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:baf:4c5:18b:2c4b])
 (user=axelrasmussen job=sendgmr) by 2002:a0d:eace:0:b0:332:1c2a:6d7c with
 SMTP id t197-20020a0deace000000b003321c2a6d7cmr9325489ywe.481.1660942339850;
 Fri, 19 Aug 2022 13:52:19 -0700 (PDT)
Date:   Fri, 19 Aug 2022 13:52:00 -0700
In-Reply-To: <20220819205201.658693-1-axelrasmussen@google.com>
Message-Id: <20220819205201.658693-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220819205201.658693-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v7 4/5] userfaultfd: update documentation to describe /dev/userfaultfd
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 6528036093e1..83f31919ebb3 100644
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
+- In order to also trap kernel page faults for the address space, either the
+  process needs the CAP_SYS_PTRACE capability, or the system must have
+  vm.unprivileged_userfaultfd set to 1. By default, vm.unprivileged_userfaultfd
+  is set to 0.
+
+The second way, added to the kernel more recently, is by opening
+/dev/userfaultfd and issuing a USERFAULTFD_IOC_NEW ioctl to it. This method
+yields equivalent userfaultfds to the userfaultfd(2) syscall.
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
index 9b833e439f09..988f6a4c8084 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -926,6 +926,9 @@ calls without any restrictions.
 
 The default value is 0.
 
+Another way to control permissions for userfaultfd is to use
+/dev/userfaultfd instead of userfaultfd(2). See
+Documentation/admin-guide/mm/userfaultfd.rst.
 
 user_reserve_kbytes
 ===================
-- 
2.37.1.595.g718a3a8f04-goog

