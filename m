Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B7B361279
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 20:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhDOSsw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 14:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbhDOSsg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 14:48:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B8C06135A
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r14so2279797ybm.18
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+mbkINT23NQwVcWMsgi99GnmaMWJZnHq8mB1mAGG8Zs=;
        b=ZSlsp82JSr/sNFPR79ahcdPAjv0rihKZQF6PIsWd45K/weHiX1ENhXFh51YnUA2Rw9
         Cf6i4yiopIGKsJ9Io1LLgzWYIpQU3svVu0S2TpyRpxWmh/yMDP7UtSNwzZx0C5U3UAqC
         Z6E3ktux4DnPEkfRFlkMUEEn1H1QP8/ik02060vWHBETna33faXZjivothMZB/7SGBBu
         SQ1gIZidNmOdKBJn2TK5AJptQIVaopKlOHzLC0U6o4UQHK7xk+vV6WQueAaIv9EsulVK
         OzbjzWVO+uW7/1rtb88UpcT47O2BHQ8qMQdkfFYpH3mHCvAfPTIkiDBT2zzdE+g/bJVD
         ir7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+mbkINT23NQwVcWMsgi99GnmaMWJZnHq8mB1mAGG8Zs=;
        b=D451G24zpKqmza3puxttkGsCDzo6fLU6Iqu+yVEg4ao4sfi57oeDqEZpyhcXU7ACA6
         Xgi9u9kdQBw6YhBLu81Ue4RAAMpxvPnMUPt/5bHsTeclNfG2ODjAIljks1hxHec4ixzE
         mdWVJ134v5MB0918y4vureS+iYozPp2/i4jhoSi2xgjgTPaqX1IQ2pu6UNByB3m/jfaT
         taIzBXJkB8Nq6QxC4UQsyg8e6P49OZ/JmRsSlAqa3mUoscij+VbBZlNW2hkiFUTL//Xt
         Kk0I8aVpapcTs9k9ugLtX4aWgtPzMAhfzbPHaUXm20HAUrgqo3ms0lISMVHXE2fXbjFr
         KLaA==
X-Gm-Message-State: AOAM532lhofP9be8QW3ROOsFIqBdhcU2DZSJS28klWQGxJRJTrvm1Ib8
        kouiFF97LhQ5nxHvJi6t4FTMucEhnjQ+YLB4Mw1z
X-Google-Smtp-Source: ABdhPJzv4jhznq25ngxQoq/BpT5VWQhGf+uQvv1ACnHJKpTks7p3GEdhu7K8vM8cl3EK9bQTI0aiOa9XQ+0ELLk97csJ
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:21b1:6e5c:b371:7e3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:2412:: with SMTP id
 k18mr6986707ybk.436.1618512474171; Thu, 15 Apr 2021 11:47:54 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:47:32 -0700
In-Reply-To: <20210415184732.3410521-1-axelrasmussen@google.com>
Message-Id: <20210415184732.3410521-11-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210415184732.3410521-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 10/10] userfaultfd: update documentation to mention shmem
 minor faults
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Generally, the documentation we wrote for hugetlbfs-based minor faults
still all applies. The only missing piece is to mention the new feature
flag which indicates that the kernel supports this for shmem as well.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 3aa38e8b8361..6528036093e1 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -77,7 +77,8 @@ events, except page fault notifications, may be generated:
 
 - ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports
   ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory
-  areas.
+  areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
+  support for shmem virtual memory areas.
 
 The userland application should set the feature flags it intends to use
 when invoking the ``UFFDIO_API`` ioctl, to request that those features be
-- 
2.31.1.368.gbe11c130af-goog

