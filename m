Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9492057A7AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiGST4x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 15:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiGST4k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 15:56:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F08599D2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 12:56:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31e62bc916aso12556047b3.19
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qMVUvtohpl5u0YhYXflPGUyFWvhgp3J9BbhXpFzblMU=;
        b=lnfO9vGuCg2XCgU/FaH826cH1zjvOw9G/iNyzi1HOhL3DxRT5bJcHvrfvhI4t6URAW
         ZP8ma2CBwGO2AVLagAv1r0AO895+URwxT6XMHfplaCjyUO6lJkILUzedOiepPxy4Eahr
         EhH0JgOK+S8z069u+yUEl/l3mZrtwpKQA9Xw28TuBzAjavO2bWFh8TRuv1X2CVR90KpU
         qPBKThQYdZup0H8ibLQRBekD27EueLVSQBgOG0oQLbT0STjwrqunbK5D9oWZXtUEf2be
         s1WMV4AYiUbOkEVKGSa0BPiWU1Jl6E6ZbPremSWY888QlqwUWVrZ7Do8xcodXxNg2E9I
         fJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qMVUvtohpl5u0YhYXflPGUyFWvhgp3J9BbhXpFzblMU=;
        b=f0NK7ewgkH6h8+T46EY/SjtM3oLz4vXhYYttl1W3M54pXbtaYfi3kO4cepu9RRp1mM
         AIhfkUpwb6LzQEskKq3hmYkvd33FT52SR1OGOKKXZClUqYnppHFW+akd8d43VO7VU1rF
         GVuVKZOd8PsCZrRwsN3hkDeuVaxEHrqXTxg+p4/TMBWhzQRUBJcb0Jug32zR+3wljSiJ
         7bZ0UMnxXK8DTJelBhBZUSXwUg8/SZqvX7Rwm7Fcnh5pB45OCHI62y87Rww+bOK/OADx
         srA+6xHB+iSITPr8Gh6alDm4O+PSRsrukQyHve5glltRSsDqbL/p8a89L9/EAiEe2x8C
         YjSA==
X-Gm-Message-State: AJIora8OyIcqSq2afuhEIGQpGilpKGLWOjKyKK3Lb93muvpF0tr12qKA
        RaPiIQiz/HaZeOER2mbYBA09qW7h0IxkWmbUSs2t
X-Google-Smtp-Source: AGRyM1tJ/Uc5B/XJoSXLcnF76pAX+DiA/uqYaRjrJAYUu9yZiW0d+SAGBCOg8WS/GtxAUC/6LkRBA2YKMCzMouUel+Kd
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:a065:9221:e40d:4fbe])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6ed5:0:b0:669:8b84:bb57 with
 SMTP id j204-20020a256ed5000000b006698b84bb57mr32393560ybc.227.1658260597485;
 Tue, 19 Jul 2022 12:56:37 -0700 (PDT)
Date:   Tue, 19 Jul 2022 12:56:25 -0700
In-Reply-To: <20220719195628.3415852-1-axelrasmussen@google.com>
Message-Id: <20220719195628.3415852-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220719195628.3415852-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
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

Historically, it has been shown that intercepting kernel faults with
userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
of time) can be exploited, or at least can make some kinds of exploits
easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
changed things so, in order for kernel faults to be handled by
userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
must be configured so that any unprivileged user can do it.

In a typical implementation of a hypervisor with live migration (take
QEMU/KVM as one such example), we do indeed need to be able to handle
kernel faults. But, both options above are less than ideal:

- Toggling the sysctl increases attack surface by allowing any
  unprivileged user to do it.

- Granting the live migration process CAP_SYS_PTRACE gives it this
  ability, but *also* the ability to "observe and control the
  execution of another process [...], and examine and change [its]
  memory and registers" (from ptrace(2)). This isn't something we need
  or want to be able to do, so granting this permission violates the
  "principle of least privilege".

This is all a long winded way to say: we want a more fine-grained way to
grant access to userfaultfd, without granting other additional
permissions at the same time.

To achieve this, add a /dev/userfaultfd misc device. This device
provides an alternative to the userfaultfd(2) syscall for the creation
of new userfaultfds. The idea is, any userfaultfds created this way will
be able to handle kernel faults, without the caller having any special
capabilities. Access to this mechanism is instead restricted using e.g.
standard filesystem permissions.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 | 69 +++++++++++++++++++++++++-------
 include/uapi/linux/userfaultfd.h |  4 ++
 2 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e943370107d0..968f2517a281 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -30,6 +30,7 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 #include <linux/swapops.h>
+#include <linux/miscdevice.h>
 
 int sysctl_unprivileged_userfaultfd __read_mostly;
 
@@ -413,13 +414,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
-	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
-	    ctx->flags & UFFD_USER_MODE_ONLY) {
-		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
-			"sysctl knob to 1 if kernel faults must be handled "
-			"without obtaining CAP_SYS_PTRACE capability\n");
+	if (!(vmf->flags & FAULT_FLAG_USER) && (ctx->flags & UFFD_USER_MODE_ONLY))
 		goto out;
-	}
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -2052,19 +2048,30 @@ static void init_once_userfaultfd_ctx(void *mem)
 	seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
 }
 
-SYSCALL_DEFINE1(userfaultfd, int, flags)
+static inline bool userfaultfd_syscall_allowed(int flags)
+{
+	/* Userspace-only page faults are always allowed */
+	if (flags & UFFD_USER_MODE_ONLY)
+		return true;
+
+	/*
+	 * The user is requesting a userfaultfd which can handle kernel faults.
+	 * Privileged users are always allowed to do this.
+	 */
+	if (capable(CAP_SYS_PTRACE))
+		return true;
+
+	/* Otherwise, access to kernel fault handling is sysctl controlled. */
+	return sysctl_unprivileged_userfaultfd;
+}
+
+static int new_userfaultfd(bool is_syscall, int flags)
 {
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
-	if (!sysctl_unprivileged_userfaultfd &&
-	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
-	    !capable(CAP_SYS_PTRACE)) {
-		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
-			"sysctl knob to 1 if kernel faults must be handled "
-			"without obtaining CAP_SYS_PTRACE capability\n");
+	if (is_syscall && !userfaultfd_syscall_allowed(flags))
 		return -EPERM;
-	}
 
 	BUG_ON(!current->mm);
 
@@ -2098,8 +2105,42 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	return fd;
 }
 
+SYSCALL_DEFINE1(userfaultfd, int, flags)
+{
+	return new_userfaultfd(true, flags);
+}
+
+static int userfaultfd_dev_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static long userfaultfd_dev_ioctl(struct file *file, unsigned int cmd, unsigned long flags)
+{
+	if (cmd != USERFAULTFD_IOC_NEW)
+		return -EINVAL;
+
+	return new_userfaultfd(false, flags);
+}
+
+static const struct file_operations userfaultfd_dev_fops = {
+	.open = userfaultfd_dev_open,
+	.unlocked_ioctl = userfaultfd_dev_ioctl,
+	.compat_ioctl = userfaultfd_dev_ioctl,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice userfaultfd_misc = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "userfaultfd",
+	.fops = &userfaultfd_dev_fops
+};
+
 static int __init userfaultfd_init(void)
 {
+	WARN_ON(misc_register(&userfaultfd_misc));
+
 	userfaultfd_ctx_cachep = kmem_cache_create("userfaultfd_ctx_cache",
 						sizeof(struct userfaultfd_ctx),
 						0,
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 7d32b1e797fb..005e5e306266 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -12,6 +12,10 @@
 
 #include <linux/types.h>
 
+/* ioctls for /dev/userfaultfd */
+#define USERFAULTFD_IOC 0xAA
+#define USERFAULTFD_IOC_NEW _IO(USERFAULTFD_IOC, 0x00)
+
 /*
  * If the UFFDIO_API is upgraded someday, the UFFDIO_UNREGISTER and
  * UFFDIO_WAKE ioctls should be defined as _IOW and not as _IOR.  In
-- 
2.37.0.170.g444d1eabd0-goog

