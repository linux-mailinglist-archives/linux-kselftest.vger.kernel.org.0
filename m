Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B6B6447EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 16:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiLFPYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 10:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiLFPYH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 10:24:07 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F09765C
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 07:24:06 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 6so13653736pgm.6
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 07:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdDrnGbeR2v4+0YeS8iLZurDBTuoZ6giO5nJB6MXDpc=;
        b=hy4suxKV0CyxFkQ/z0Lxf0gL1yedefQH7rpxWKiGLEXG11CaUMjqSwBNt4//d8Yxut
         t8l+OOBEGKoLm75Fu0H9KVpPxy0L7HBWe9P0jq+lD75ae+9pN2+63j2gfiStg4HrqjUj
         dihRnu1ru6UOyG/D0new9gAKAkWXGkicC3NDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdDrnGbeR2v4+0YeS8iLZurDBTuoZ6giO5nJB6MXDpc=;
        b=0w90Mm23lVt4OB5Lk2LuzVEJK46dDLP/boaVEURMFeKl3wks+SAYvtqE8qBa7JaghY
         6CdQff155Ofy6jXiktvI5+UKfxq7fH3L03inNmaeu/mEQU52Qu+5SHRMcZzXK0ZaVQCl
         eDm9XoK5weK/vGPOILn+3SwZRv72HLoLEtJQv9k4Cysjn34L1G4N+9sR6IXsxhqC5ROF
         AsG5yJSpwHe7As8uFWd8YdQVR/Ay1OZUlqjtiFlyc4U9dJzCZl9OBSEGU0nCngf3VBOh
         HwlTrJlx1oeLQrd8HkvwDmOqI1blf2No/zOhTXT4Tu+iR5o6Z17uPPjmUfXZ4SK6ILym
         Ye0Q==
X-Gm-Message-State: ANoB5pmySuBxKbWB8Mf7gc+KP1V1cW+146DbGP0yTblEUikxt4rgI4RQ
        UJafnjMz6E0Lx0zWYOUPnsVGAw==
X-Google-Smtp-Source: AA0mqf7hmx55Kw+OHzvYFR+AHsG9oKpdy3Z1svwgYWVgdMcFmRoc0/JdTnW1Q7D/EpeoG38bhWZi7Q==
X-Received: by 2002:a05:6a00:368e:b0:574:ead0:7c22 with SMTP id dw14-20020a056a00368e00b00574ead07c22mr29281567pfb.9.1670340245699;
        Tue, 06 Dec 2022 07:24:05 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id r25-20020a635d19000000b0046b1dabf9a8sm10004686pgb.70.2022.12.06.07.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:24:05 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Date:   Tue,  6 Dec 2022 15:23:55 +0000
Message-Id: <20221206152358.1966099-4-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206152358.1966099-1-jeffxu@google.com>
References: <20221206152358.1966099-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

The new MFD_NOEXEC_SEAL and MFD_EXEC flags allows application to
set executable bit at creation time (memfd_create).

When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
(mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
be executable (mode: 0777) after creation.

when MFD_EXEC flag is set, memfd is created with executable bit
(mode:0777), this is the same as the old behavior of memfd_create.

The new pid namespaced sysctl vm.memfd_noexec has 3 values:
0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
	MFD_EXEC was set.
1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
	MFD_NOEXEC_SEAL was set.
2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.

The sysctl allows finer control of memfd_create for old-software
that doesn't set the executable bit, for example, a container with
vm.memfd_noexec=1 means the old-software will create non-executable
memfd by default.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/pid_namespace.h | 19 ++++++++++++++
 include/uapi/linux/memfd.h    |  4 +++
 kernel/pid_namespace.c        | 48 +++++++++++++++++++++++++++++++++++
 mm/memfd.c                    | 48 +++++++++++++++++++++++++++++++++--
 4 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 07481bb87d4e..a4789a7b34a9 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -16,6 +16,21 @@
 
 struct fs_pin;
 
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+/*
+ * sysctl for vm.memfd_noexec
+ * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
+ *	acts like MFD_EXEC was set.
+ * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
+ *	acts like MFD_NOEXEC_SEAL was set.
+ * 2: memfd_create() without MFD_NOEXEC_SEAL will be
+ *	rejected.
+ */
+#define MEMFD_NOEXEC_SCOPE_EXEC		0
+#define MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL		1
+#define MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED	2
+#endif
+
 struct pid_namespace {
 	struct idr idr;
 	struct rcu_head rcu;
@@ -31,6 +46,10 @@ struct pid_namespace {
 	struct ucounts *ucounts;
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+	/* sysctl for vm.memfd_noexec */
+	int memfd_noexec_scope;
+#endif
 } __randomize_layout;
 
 extern struct pid_namespace init_pid_ns;
diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..273a4e15dfcf 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -8,6 +8,10 @@
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U
+/* not executable and sealed to prevent changing to executable. */
+#define MFD_NOEXEC_SEAL		0x0008U
+/* executable */
+#define MFD_EXEC		0x0010U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index f4f8cb0435b4..2b7563ddd22c 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -110,6 +110,11 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
 
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+	ns->memfd_noexec_scope =
+		task_active_pid_ns(current)->memfd_noexec_scope;
+#endif
+
 	return ns;
 
 out_free_idr:
@@ -255,6 +260,45 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	return;
 }
 
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+static int pid_mfd_noexec_dointvec_minmax(struct ctl_table *table, int write,
+	void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct pid_namespace *ns = task_active_pid_ns(current);
+	struct ctl_table table_copy;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	table_copy = *table;
+	if (ns != &init_pid_ns)
+		table_copy.data = &ns->memfd_noexec_scope;
+
+	/*
+	 * set minimum to current value, the effect is only bigger
+	 * value is accepted.
+	 */
+	if (*(int *)table_copy.data > *(int *)table_copy.extra1)
+		table_copy.extra1 = table_copy.data;
+
+	return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
+}
+
+static struct ctl_table pid_ns_ctl_table_vm[] = {
+	{
+		.procname	= "memfd_noexec",
+		.data		= &init_pid_ns.memfd_noexec_scope,
+		.maxlen		= sizeof(init_pid_ns.memfd_noexec_scope),
+		.mode		= 0644,
+		.proc_handler	= pid_mfd_noexec_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{ }
+};
+static struct ctl_path vm_path[] = { { .procname = "vm", }, { } };
+#endif
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
@@ -455,6 +499,10 @@ static __init int pid_namespaces_init(void)
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	register_sysctl_paths(kern_path, pid_ns_ctl_table);
 #endif
+
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+	register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
+#endif
 	return 0;
 }
 
diff --git a/mm/memfd.c b/mm/memfd.c
index 4ebeab94aa74..ec70675a7069 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -18,6 +18,7 @@
 #include <linux/hugetlb.h>
 #include <linux/shmem_fs.h>
 #include <linux/memfd.h>
+#include <linux/pid_namespace.h>
 #include <uapi/linux/memfd.h>
 
 /*
@@ -263,12 +264,14 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
 {
+	char comm[TASK_COMM_LEN];
+	struct pid_namespace *ns;
 	unsigned int *file_seals;
 	struct file *file;
 	int fd, error;
@@ -285,6 +288,39 @@ SYSCALL_DEFINE2(memfd_create,
 			return -EINVAL;
 	}
 
+	/* Invalid if both EXEC and NOEXEC_SEAL are set.*/
+	if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
+		return -EINVAL;
+
+	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
+#ifdef CONFIG_SYSCTL
+		int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
+
+		ns = task_active_pid_ns(current);
+		if (ns)
+			sysctl = ns->memfd_noexec_scope;
+
+		switch (sysctl) {
+		case MEMFD_NOEXEC_SCOPE_EXEC:
+			flags |= MFD_EXEC;
+			break;
+		case MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL:
+			flags |= MFD_NOEXEC_SEAL;
+			break;
+		default:
+			pr_warn_ratelimited(
+				"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
+				task_pid_nr(current), get_task_comm(comm, current));
+			return -EINVAL;
+		}
+#else
+		flags |= MFD_EXEC;
+#endif
+		pr_warn_ratelimited(
+			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
+			task_pid_nr(current), get_task_comm(comm, current));
+	}
+
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
 	if (len <= 0)
@@ -328,7 +364,15 @@ SYSCALL_DEFINE2(memfd_create,
 	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
 	file->f_flags |= O_LARGEFILE;
 
-	if (flags & MFD_ALLOW_SEALING) {
+	if (flags & MFD_NOEXEC_SEAL) {
+		struct inode *inode = file_inode(file);
+
+		inode->i_mode &= ~0111;
+		file_seals = memfd_file_seals_ptr(file);
+		*file_seals &= ~F_SEAL_SEAL;
+		*file_seals |= F_SEAL_EXEC;
+	} else if (flags & MFD_ALLOW_SEALING) {
+		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
 		file_seals = memfd_file_seals_ptr(file);
 		*file_seals &= ~F_SEAL_SEAL;
 	}
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

