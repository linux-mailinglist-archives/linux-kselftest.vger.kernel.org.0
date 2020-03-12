Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20953183B42
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Mar 2020 22:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCLVYg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 17:24:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54101 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCLVYg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 17:24:36 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jCVJb-000465-SS; Thu, 12 Mar 2020 21:24:28 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     christian.brauner@ubuntu.com
Cc:     ard.biesheuvel@linaro.org, ardb@kernel.org, arve@android.com,
        gregkh@linuxfoundation.org, hridya@google.com,
        joel@joelfernandes.org, john.stultz@linaro.org,
        keescook@chromium.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        maco@android.com, naresh.kamboju@linaro.org, shuah@kernel.org,
        tkjos@android.com, Todd Kjos <tkjos@google.com>
Subject: [PATCH] binderfs: port to new mount api
Date:   Thu, 12 Mar 2020 22:24:20 +0100
Message-Id: <20200312212420.4032188-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
References: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It's time we port binderfs to the new mount api. We can make use of the
new option parser, get nicer infrastructure and it will be easiert if we
ever add any new mount options.

This survives testing with the binderfs selftests:

for i in `seq 1 1000`; do ./binderfs_test; done

including the new stress tests I sent out for review today:

 [==========] Running 3 tests from 1 test cases.
 [ RUN      ] global.binderfs_stress
 [       OK ] global.binderfs_stress
 [ RUN      ] global.binderfs_test_privileged
 # Tests are not run as root. Skipping privileged tests
 [       OK ] global.binderfs_test_privileged
 [ RUN      ] global.binderfs_test_unprivileged
 # Allocated new binder device with major 243, minor 4, and name my-binder
 # Detected binder version: 8
 [       OK ] global.binderfs_test_unprivileged
 [==========] 3 / 3 tests passed.
 [  PASSED  ]

Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 drivers/android/binderfs.c | 200 +++++++++++++++++++------------------
 1 file changed, 105 insertions(+), 95 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index f303106b3362..2c89e0b5a82d 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -18,7 +18,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/mount.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
 #include <linux/radix-tree.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
@@ -48,26 +48,30 @@ static dev_t binderfs_dev;
 static DEFINE_MUTEX(binderfs_minors_mutex);
 static DEFINE_IDA(binderfs_minors);
 
-enum {
+enum binderfs_param {
 	Opt_max,
 	Opt_stats_mode,
-	Opt_err
 };
 
 enum binderfs_stats_mode {
-	STATS_NONE,
-	STATS_GLOBAL,
+	binderfs_stats_mode_unset,
+	binderfs_stats_mode_global,
 };
 
-static const match_table_t tokens = {
-	{ Opt_max, "max=%d" },
-	{ Opt_stats_mode, "stats=%s" },
-	{ Opt_err, NULL     }
+static const struct constant_table binderfs_param_stats[] = {
+	{ "global", binderfs_stats_mode_global },
+	{}
 };
 
-static inline struct binderfs_info *BINDERFS_I(const struct inode *inode)
+const struct fs_parameter_spec binderfs_fs_parameters[] = {
+	fsparam_u32("max",	Opt_max),
+	fsparam_enum("stats",	Opt_stats_mode, binderfs_param_stats),
+	{}
+};
+
+static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
 {
-	return inode->i_sb->s_fs_info;
+	return sb->s_fs_info;
 }
 
 bool is_binderfs_device(const struct inode *inode)
@@ -246,7 +250,7 @@ static long binder_ctl_ioctl(struct file *file, unsigned int cmd,
 static void binderfs_evict_inode(struct inode *inode)
 {
 	struct binder_device *device = inode->i_private;
-	struct binderfs_info *info = BINDERFS_I(inode);
+	struct binderfs_info *info = BINDERFS_SB(inode->i_sb);
 
 	clear_inode(inode);
 
@@ -264,97 +268,85 @@ static void binderfs_evict_inode(struct inode *inode)
 	}
 }
 
-/**
- * binderfs_parse_mount_opts - parse binderfs mount options
- * @data: options to set (can be NULL in which case defaults are used)
- */
-static int binderfs_parse_mount_opts(char *data,
-				     struct binderfs_mount_opts *opts)
+static int binderfs_fs_context_parse_param(struct fs_context *fc,
+					   struct fs_parameter *param)
 {
-	char *p, *stats;
-	opts->max = BINDERFS_MAX_MINOR;
-	opts->stats_mode = STATS_NONE;
-
-	while ((p = strsep(&data, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		int max_devices;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_max:
-			if (match_int(&args[0], &max_devices) ||
-			    (max_devices < 0 ||
-			     (max_devices > BINDERFS_MAX_MINOR)))
-				return -EINVAL;
-
-			opts->max = max_devices;
-			break;
-		case Opt_stats_mode:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EINVAL;
+	int opt;
+	struct binderfs_mount_opts *ctx = fc->fs_private;
+	struct fs_parse_result result;
 
-			stats = match_strdup(&args[0]);
-			if (!stats)
-				return -ENOMEM;
+	opt = fs_parse(fc, binderfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
 
-			if (strcmp(stats, "global") != 0) {
-				kfree(stats);
-				return -EINVAL;
-			}
+	switch (opt) {
+	case Opt_max:
+		if (result.uint_32 > BINDERFS_MAX_MINOR)
+			return invalfc(fc, "Bad value for '%s'", param->key);
 
-			opts->stats_mode = STATS_GLOBAL;
-			kfree(stats);
-			break;
-		default:
-			pr_err("Invalid mount options\n");
-			return -EINVAL;
-		}
+		ctx->max = result.uint_32;
+		break;
+	case Opt_stats_mode:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		ctx->stats_mode = result.uint_32;
+		break;
+	default:
+		return invalfc(fc, "Unsupported parameter '%s'", param->key);
 	}
 
 	return 0;
 }
 
-static int binderfs_remount(struct super_block *sb, int *flags, char *data)
+static int binderfs_fs_context_reconfigure(struct fs_context *fc)
 {
-	int prev_stats_mode, ret;
-	struct binderfs_info *info = sb->s_fs_info;
+	struct binderfs_mount_opts *ctx = fc->fs_private;
+	struct binderfs_info *info = BINDERFS_SB(fc->root->d_sb);
 
-	prev_stats_mode = info->mount_opts.stats_mode;
-	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
-	if (ret)
-		return ret;
+	if (info->mount_opts.stats_mode != ctx->stats_mode)
+		return invalfc(fc, "Binderfs stats mode cannot be changed during a remount");
 
-	if (prev_stats_mode != info->mount_opts.stats_mode) {
-		pr_err("Binderfs stats mode cannot be changed during a remount\n");
-		info->mount_opts.stats_mode = prev_stats_mode;
-		return -EINVAL;
-	}
+	info->mount_opts.stats_mode = ctx->stats_mode;
+	info->mount_opts.max = ctx->max;
 
 	return 0;
 }
 
-static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
+static int binderfs_show_options(struct seq_file *seq, struct dentry *root)
 {
-	struct binderfs_info *info;
+	struct binderfs_info *info = BINDERFS_SB(root->d_sb);
 
-	info = root->d_sb->s_fs_info;
 	if (info->mount_opts.max <= BINDERFS_MAX_MINOR)
 		seq_printf(seq, ",max=%d", info->mount_opts.max);
-	if (info->mount_opts.stats_mode == STATS_GLOBAL)
+
+	switch (info->mount_opts.stats_mode) {
+	case binderfs_stats_mode_unset:
+		break;
+	case binderfs_stats_mode_global:
 		seq_printf(seq, ",stats=global");
+		break;
+	}
 
 	return 0;
 }
 
+static void binderfs_put_super(struct super_block *sb)
+{
+	struct binderfs_info *info = sb->s_fs_info;
+
+	if (info && info->ipc_ns)
+		put_ipc_ns(info->ipc_ns);
+
+	kfree(info);
+	sb->s_fs_info = NULL;
+}
+
 static const struct super_operations binderfs_super_ops = {
 	.evict_inode    = binderfs_evict_inode,
-	.remount_fs	= binderfs_remount,
-	.show_options	= binderfs_show_mount_opts,
+	.show_options	= binderfs_show_options,
 	.statfs         = simple_statfs,
+	.put_super	= binderfs_put_super,
 };
 
 static inline bool is_binderfs_control_device(const struct dentry *dentry)
@@ -653,10 +645,11 @@ static int init_binder_logs(struct super_block *sb)
 	return ret;
 }
 
-static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
+static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int ret;
 	struct binderfs_info *info;
+	struct binderfs_mount_opts *ctx = fc->fs_private;
 	struct inode *inode = NULL;
 	struct binderfs_device device_info = { 0 };
 	const char *name;
@@ -689,16 +682,14 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	info->ipc_ns = get_ipc_ns(current->nsproxy->ipc_ns);
 
-	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
-	if (ret)
-		return ret;
-
 	info->root_gid = make_kgid(sb->s_user_ns, 0);
 	if (!gid_valid(info->root_gid))
 		info->root_gid = GLOBAL_ROOT_GID;
 	info->root_uid = make_kuid(sb->s_user_ns, 0);
 	if (!uid_valid(info->root_uid))
 		info->root_uid = GLOBAL_ROOT_UID;
+	info->mount_opts.max = ctx->max;
+	info->mount_opts.stats_mode = ctx->stats_mode;
 
 	inode = new_inode(sb);
 	if (!inode)
@@ -730,36 +721,55 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 			name++;
 	}
 
-	if (info->mount_opts.stats_mode == STATS_GLOBAL)
+	if (info->mount_opts.stats_mode == binderfs_stats_mode_global)
 		return init_binder_logs(sb);
 
 	return 0;
 }
 
-static struct dentry *binderfs_mount(struct file_system_type *fs_type,
-				     int flags, const char *dev_name,
-				     void *data)
+static int binderfs_fs_context_get_tree(struct fs_context *fc)
 {
-	return mount_nodev(fs_type, flags, data, binderfs_fill_super);
+	return get_tree_nodev(fc, binderfs_fill_super);
 }
 
-static void binderfs_kill_super(struct super_block *sb)
+static void binderfs_fs_context_free(struct fs_context *fc)
 {
-	struct binderfs_info *info = sb->s_fs_info;
+	struct binderfs_mount_opts *ctx = fc->fs_private;
+
+	fc->fs_private = NULL;
+	kfree(ctx);
+}
 
-	kill_litter_super(sb);
+static const struct fs_context_operations binderfs_fs_context_ops = {
+	.free		= binderfs_fs_context_free,
+	.get_tree	= binderfs_fs_context_get_tree,
+	.parse_param	= binderfs_fs_context_parse_param,
+	.reconfigure	= binderfs_fs_context_reconfigure,
+};
 
-	if (info && info->ipc_ns)
-		put_ipc_ns(info->ipc_ns);
+static int binderfs_init_fs_context(struct fs_context *fc)
+{
+	struct binderfs_mount_opts *ctx;
 
-	kfree(info);
+	ctx = kzalloc(sizeof(struct binderfs_mount_opts), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->max = BINDERFS_MAX_MINOR;
+	ctx->stats_mode = binderfs_stats_mode_unset;
+
+	fc->fs_private = ctx;
+	fc->ops = &binderfs_fs_context_ops;
+
+	return 0;
 }
 
 static struct file_system_type binder_fs_type = {
-	.name		= "binder",
-	.mount		= binderfs_mount,
-	.kill_sb	= binderfs_kill_super,
-	.fs_flags	= FS_USERNS_MOUNT,
+	.name			= "binder",
+	.init_fs_context	= binderfs_init_fs_context,
+	.parameters		= binderfs_fs_parameters,
+	.kill_sb		= kill_litter_super,
+	.fs_flags		= FS_USERNS_MOUNT,
 };
 
 int __init init_binderfs(void)

base-commit: f17f06a0c7794d3a7c2425663738823354447472
-- 
2.25.1

