Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1A353AEC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 00:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiFAVKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jun 2022 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiFAVKK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jun 2022 17:10:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55CA3982C
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Jun 2022 14:10:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c2aa26ebfso25838227b3.4
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Jun 2022 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JchwRFKuJHzPLAwFeWJ+f/HpkUvCCjwCkmb09umjAZQ=;
        b=iKdv25CWOUBairih2XtXOpSzZR08HFkogjDTw5Tnemz3NhkhJtB/cIr40Z5657eVzZ
         cUc4KED8/y7bRdyi0Qz44m3MSEbjJg+hFwH2JZx76hsl89ScnI8HZMKiehkFM2d/UUrI
         HTdg/zoYNIhbyxvKczG2o2VTEXhTPa8MPenJjlkHrFZVNYdxc0TdOIhVcszdYhQdh+Ei
         ckcw3VuuniztzRQNvN7xpIgHK4F7xUR5RxykNR3FsoE5qfR47cqcDNoa8mgevvvhyVr2
         htrBahwDBd+bGLaFUJrDcVHnZMuLULIoLK3YWSeMTMIR1AJ8g0gCEC3Aric7jl19o2UH
         faSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JchwRFKuJHzPLAwFeWJ+f/HpkUvCCjwCkmb09umjAZQ=;
        b=BHeK8W7D57NvgfxCjOYhFyAJ21OWueRdC0Jeduv+uaIAH2TDypokNEn1txeo+EO3Zf
         QHKa6XWHiPL/kgAHexjHIpdVENl5NKQ1c59pdhjJgjYhPaj1hIufKB/bRJIezarYm7ZN
         Y4Y6fhrZRGCE4HmyweybrDM9+ZvbQbn3ZqIxW7NIKIoSZMYGn6t1KFvQJxRo3+NEcWVd
         p1Js7vTGONw5Yn/cwRMLWWqcGhMrcmx+YP1lDIT2N3+4WW8C1e6NIyLPnQICN1jv9tcx
         3fp+jrzTVu/eDfmIOux6G/d0EXuNOTL8OAw0EDMZWDzGpiH7wX3sjnGQPsgjqRSOVyF4
         q6fw==
X-Gm-Message-State: AOAM5304PvFdvg7PbqAbrbBZQnrVgEQeN488wUm0vN4HSeMMZSF+1Xm6
        iwS1zplYeRdOnnHMcaTmNavnzK+K3FFgt+ktL5bW
X-Google-Smtp-Source: ABdhPJy/eN27j4pZ1NkqpT8CI6PUsPWDSIHtIb4kG1E0T/sYOUaVzwtg5D3Dx0O3NczBDBxTwdx76j8TB/6t1bVwwgsF
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:aaec:e358:9f0e:2b26])
 (user=axelrasmussen job=sendgmr) by 2002:a81:a0d3:0:b0:30c:bf62:6f77 with
 SMTP id x202-20020a81a0d3000000b0030cbf626f77mr1780208ywg.342.1654117803881;
 Wed, 01 Jun 2022 14:10:03 -0700 (PDT)
Date:   Wed,  1 Jun 2022 14:09:49 -0700
In-Reply-To: <20220601210951.3916598-1-axelrasmussen@google.com>
Message-Id: <20220601210951.3916598-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220601210951.3916598-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 4/6] userfaultfd: update documentation to describe /dev/userfaultfd
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Explain the different ways to create a new userfaultfd, and how access
control works for each way.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 40 ++++++++++++++++++--
 Documentation/admin-guide/sysctl/vm.rst      |  3 ++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 6528036093e1..9bae1acd431f 100644
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
@@ -50,6 +52,38 @@ is a corner case that would currently return ``-EBUSY``).
 API
 ===
 
+Creating a userfaultfd
+----------------------
+
+There are two ways to create a new userfaultfd, each of which provide ways to
+restrict access to this functionality (since historically userfaultfds which
+handle kernel page faults have been a useful tool for exploiting the kernel).
+
+The first way, supported by older kernels, is the userfaultfd(2) syscall.
+Access to this is controlled in several ways:
+
+- By default, the userfaultfd will be able to handle kernel page faults. This
+  can be disabled by passing in UFFD_USER_MODE_ONLY.
+
+- If vm.unprivileged_userfaultfd is 0, then the caller must *either* have
+  CAP_SYS_PTRACE, or pass in UFFD_USER_MODE_ONLY.
+
+- If vm.unprivileged_userfaultfd is 1, then no particular privilege is needed to
+  use this syscall, even if UFFD_USER_MODE_ONLY is *not* set.
+
+The second way, added to the kernel more recently, is by opening and issuing a
+USERFAULTFD_IOC_NEW ioctl to /dev/userfaultfd. This method yields equivalent
+userfaultfds to the userfaultfd(2) syscall; its benefit is in how access to
+creating userfaultfds is controlled.
+
+Access to /dev/userfaultfd is controlled via normal filesystem permissions
+(user/group/mode for example), which gives fine grained access to userfaultfd
+specifically, without also granting other unrelated privileges at the same time
+(as e.g. granting CAP_SYS_PTRACE would do).
+
+Initializing up a userfaultfd
+-----------------------------
+
 When first opened the ``userfaultfd`` must be enabled invoking the
 ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
 a later API version) which will specify the ``read/POLLIN`` protocol
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index d7374a1e8ac9..e3a952d1fd35 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -927,6 +927,9 @@ calls without any restrictions.
 
 The default value is 0.
 
+An alternative to this sysctl / the userfaultfd(2) syscall is to create
+userfaultfds via /dev/userfaultfd. See
+Documentation/admin-guide/mm/userfaultfd.rst.
 
 user_reserve_kbytes
 ===================
-- 
2.36.1.255.ge46751e96f-goog

