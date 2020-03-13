Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B797C185215
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCMXIe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:08:34 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52319 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgCMXId (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:08:33 -0400
Received: by mail-pj1-f65.google.com with SMTP id f15so4924928pjq.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8nLqA7X5m3Etephu+QvORY5svJ1+LUWz4tUe1goJqyY=;
        b=RVIob6TG+z1sL8f6oVG0Iv5sGIv/8jQ8fS1wSLT7ifW3o9AcuqOrwJVC+wP7FPrOlC
         QcWIfZKo3KUEiM3gC1NSfJkufKHPgMcZ2NdQ/jyLXnkZU7y574VuCnuv6Ts4FjaqONvm
         kcLJX3X04KA/uf8e44b+uRre/uVHHcWR4WpOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8nLqA7X5m3Etephu+QvORY5svJ1+LUWz4tUe1goJqyY=;
        b=LbXwiWVqroFJ5RVKqFEcruWJSh71bkCDbBiCvCDgEn9NkOfbhtc5IqgErXAI/qyc2H
         ckCbmlQg+MJZSSdOlPV+Kk63L/6WiuEV+NlKjF3yQ4C67pJPqIFc0U6utiLxNXOr3nlp
         w34ky7xUIA3lDm8DMn0TmF/Tq+CV7xxTXMa2qZyw3/sL/ljaCA39R0FmhlDtr4o4EZvC
         zLz/eR8C+gocfq7hCaZ44bfTTaOmdVPpq4/SUAF5qrqq8sEtpttYJArfeitp/fEIXlWK
         hQCNY2L1ZwPYDfSigiSw2cbsiP5QTQfDcIngGBr2dmQQK2gtJ/p8i4269+719zvCNlpW
         XkZA==
X-Gm-Message-State: ANhLgQ07kmy3raogzdmwAQCSnFa0Hoz3fTtjKT783hdyO3R6nkMG9Hjr
        d+tbwRQI9V9upiZjD6WxZcFpxA==
X-Google-Smtp-Source: ADFU+vvwktYNAVQoi3qnoq4K3BUiXaxY7yRKRrRlSw60hSFWn34w2ZceRWf6/u6cf2ALW6mr9/gx1Q==
X-Received: by 2002:a17:90a:198b:: with SMTP id 11mr12674224pji.23.1584140912374;
        Fri, 13 Mar 2020 16:08:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 63sm19063217pfx.132.2020.03.13.16.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:08:31 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:08:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     gregkh@linuxfoundation.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        ardb@kernel.org, arve@android.com, hridya@google.com,
        joel@joelfernandes.org, john.stultz@linaro.org,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        maco@android.com, naresh.kamboju@linaro.org, shuah@kernel.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2] binderfs: port to new mount api
Message-ID: <202003131608.D3A8AED8A7@keescook>
References: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200313153427.141789-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313153427.141789-1-christian.brauner@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 04:34:27PM +0100, Christian Brauner wrote:
> When I first wrote binderfs the new mount api had not yet landed. Now
> that it has been around for a little while and a bunch of filesystems
> have already been ported we should do so too. When Al sent his
> mount-api-conversion pr he requested that binderfs (and a few others) be
> ported separately. It's time we port binderfs. We can make use of the
> new option parser, get nicer infrastructure and it will be easier if we
> ever add any new mount options.
> 
> This survives testing with the binderfs selftests:
> 
> for i in `seq 1 1000`; do ./binderfs_test; done
> 
> including the new stress tests I sent out for review today:
> 
>  TAP version 13
>  1..1
>  # selftests: filesystems/binderfs: binderfs_test
>  # [==========] Running 3 tests from 1 test cases.
>  # [ RUN      ] global.binderfs_stress
>  # [  XFAIL!  ] Tests are not run as root. Skipping privileged tests
>  # [==========] Running 3 tests from 1 test cases.
>  # [ RUN      ] global.binderfs_stress
>  # [       OK ] global.binderfs_stress
>  # [ RUN      ] global.binderfs_test_privileged
>  # [       OK ] global.binderfs_test_privileged
>  # [ RUN      ] global.binderfs_test_unprivileged
>  # # Allocated new binder device with major 243, minor 4, and name my-binder
>  # # Detected binder version: 8
>  # [==========] Running 3 tests from 1 test cases.
>  # [ RUN      ] global.binderfs_stress
>  # [       OK ] global.binderfs_stress
>  # [ RUN      ] global.binderfs_test_privileged
>  # [       OK ] global.binderfs_test_privileged
>  # [ RUN      ] global.binderfs_test_unprivileged
>  # [       OK ] global.binderfs_test_unprivileged
>  # [==========] 3 / 3 tests passed.
>  # [  PASSED  ]
>  ok 1 selftests: filesystems/binderfs: binderfs_test
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> /* v2 */
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - Commit message adapted to new stresstest output after porting to
>     XFAIL infrastructure.
>     For the stresstest patchset see:
>     https://lore.kernel.org/r/20200313152420.138777-1-christian.brauner@ubuntu.com
> ---
>  drivers/android/binderfs.c | 200 +++++++++++++++++++------------------
>  1 file changed, 104 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index f303106b3362..9ecad74183a3 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -18,7 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/mount.h>
> -#include <linux/parser.h>
> +#include <linux/fs_parser.h>
>  #include <linux/radix-tree.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
> @@ -48,26 +48,30 @@ static dev_t binderfs_dev;
>  static DEFINE_MUTEX(binderfs_minors_mutex);
>  static DEFINE_IDA(binderfs_minors);
>  
> -enum {
> +enum binderfs_param {
>  	Opt_max,
>  	Opt_stats_mode,
> -	Opt_err
>  };
>  
>  enum binderfs_stats_mode {
> -	STATS_NONE,
> -	STATS_GLOBAL,
> +	binderfs_stats_mode_unset,
> +	binderfs_stats_mode_global,
>  };
>  
> -static const match_table_t tokens = {
> -	{ Opt_max, "max=%d" },
> -	{ Opt_stats_mode, "stats=%s" },
> -	{ Opt_err, NULL     }
> +static const struct constant_table binderfs_param_stats[] = {
> +	{ "global", binderfs_stats_mode_global },
> +	{}
>  };
>  
> -static inline struct binderfs_info *BINDERFS_I(const struct inode *inode)
> +const struct fs_parameter_spec binderfs_fs_parameters[] = {
> +	fsparam_u32("max",	Opt_max),
> +	fsparam_enum("stats",	Opt_stats_mode, binderfs_param_stats),
> +	{}
> +};
> +
> +static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
>  {
> -	return inode->i_sb->s_fs_info;
> +	return sb->s_fs_info;
>  }
>  
>  bool is_binderfs_device(const struct inode *inode)
> @@ -246,7 +250,7 @@ static long binder_ctl_ioctl(struct file *file, unsigned int cmd,
>  static void binderfs_evict_inode(struct inode *inode)
>  {
>  	struct binder_device *device = inode->i_private;
> -	struct binderfs_info *info = BINDERFS_I(inode);
> +	struct binderfs_info *info = BINDERFS_SB(inode->i_sb);
>  
>  	clear_inode(inode);
>  
> @@ -264,97 +268,84 @@ static void binderfs_evict_inode(struct inode *inode)
>  	}
>  }
>  
> -/**
> - * binderfs_parse_mount_opts - parse binderfs mount options
> - * @data: options to set (can be NULL in which case defaults are used)
> - */
> -static int binderfs_parse_mount_opts(char *data,
> -				     struct binderfs_mount_opts *opts)
> +static int binderfs_fs_context_parse_param(struct fs_context *fc,
> +					   struct fs_parameter *param)
>  {
> -	char *p, *stats;
> -	opts->max = BINDERFS_MAX_MINOR;
> -	opts->stats_mode = STATS_NONE;
> -
> -	while ((p = strsep(&data, ",")) != NULL) {
> -		substring_t args[MAX_OPT_ARGS];
> -		int token;
> -		int max_devices;
> -
> -		if (!*p)
> -			continue;
> -
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case Opt_max:
> -			if (match_int(&args[0], &max_devices) ||
> -			    (max_devices < 0 ||
> -			     (max_devices > BINDERFS_MAX_MINOR)))
> -				return -EINVAL;
> -
> -			opts->max = max_devices;
> -			break;
> -		case Opt_stats_mode:
> -			if (!capable(CAP_SYS_ADMIN))
> -				return -EINVAL;
> +	int opt;
> +	struct binderfs_mount_opts *ctx = fc->fs_private;
> +	struct fs_parse_result result;
>  
> -			stats = match_strdup(&args[0]);
> -			if (!stats)
> -				return -ENOMEM;
> +	opt = fs_parse(fc, binderfs_fs_parameters, param, &result);
> +	if (opt < 0)
> +		return opt;
>  
> -			if (strcmp(stats, "global") != 0) {
> -				kfree(stats);
> -				return -EINVAL;
> -			}
> +	switch (opt) {
> +	case Opt_max:
> +		if (result.uint_32 > BINDERFS_MAX_MINOR)
> +			return invalfc(fc, "Bad value for '%s'", param->key);
>  
> -			opts->stats_mode = STATS_GLOBAL;
> -			kfree(stats);
> -			break;
> -		default:
> -			pr_err("Invalid mount options\n");
> -			return -EINVAL;
> -		}
> +		ctx->max = result.uint_32;
> +		break;
> +	case Opt_stats_mode:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		ctx->stats_mode = result.uint_32;
> +		break;
> +	default:
> +		return invalfc(fc, "Unsupported parameter '%s'", param->key);
>  	}
>  
>  	return 0;
>  }
>  
> -static int binderfs_remount(struct super_block *sb, int *flags, char *data)
> +static int binderfs_fs_context_reconfigure(struct fs_context *fc)
>  {
> -	int prev_stats_mode, ret;
> -	struct binderfs_info *info = sb->s_fs_info;
> +	struct binderfs_mount_opts *ctx = fc->fs_private;
> +	struct binderfs_info *info = BINDERFS_SB(fc->root->d_sb);
>  
> -	prev_stats_mode = info->mount_opts.stats_mode;
> -	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
> -	if (ret)
> -		return ret;
> -
> -	if (prev_stats_mode != info->mount_opts.stats_mode) {
> -		pr_err("Binderfs stats mode cannot be changed during a remount\n");
> -		info->mount_opts.stats_mode = prev_stats_mode;
> -		return -EINVAL;
> -	}
> +	if (info->mount_opts.stats_mode != ctx->stats_mode)
> +		return invalfc(fc, "Binderfs stats mode cannot be changed during a remount");
>  
> +	info->mount_opts.stats_mode = ctx->stats_mode;
> +	info->mount_opts.max = ctx->max;
>  	return 0;
>  }
>  
> -static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
> +static int binderfs_show_options(struct seq_file *seq, struct dentry *root)
>  {
> -	struct binderfs_info *info;
> +	struct binderfs_info *info = BINDERFS_SB(root->d_sb);
>  
> -	info = root->d_sb->s_fs_info;
>  	if (info->mount_opts.max <= BINDERFS_MAX_MINOR)
>  		seq_printf(seq, ",max=%d", info->mount_opts.max);
> -	if (info->mount_opts.stats_mode == STATS_GLOBAL)
> +
> +	switch (info->mount_opts.stats_mode) {
> +	case binderfs_stats_mode_unset:
> +		break;
> +	case binderfs_stats_mode_global:
>  		seq_printf(seq, ",stats=global");
> +		break;
> +	}
>  
>  	return 0;
>  }
>  
> +static void binderfs_put_super(struct super_block *sb)
> +{
> +	struct binderfs_info *info = sb->s_fs_info;
> +
> +	if (info && info->ipc_ns)
> +		put_ipc_ns(info->ipc_ns);
> +
> +	kfree(info);
> +	sb->s_fs_info = NULL;
> +}
> +
>  static const struct super_operations binderfs_super_ops = {
>  	.evict_inode    = binderfs_evict_inode,
> -	.remount_fs	= binderfs_remount,
> -	.show_options	= binderfs_show_mount_opts,
> +	.show_options	= binderfs_show_options,
>  	.statfs         = simple_statfs,
> +	.put_super	= binderfs_put_super,
>  };
>  
>  static inline bool is_binderfs_control_device(const struct dentry *dentry)
> @@ -653,10 +644,11 @@ static int init_binder_logs(struct super_block *sb)
>  	return ret;
>  }
>  
> -static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> +static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	int ret;
>  	struct binderfs_info *info;
> +	struct binderfs_mount_opts *ctx = fc->fs_private;
>  	struct inode *inode = NULL;
>  	struct binderfs_device device_info = { 0 };
>  	const char *name;
> @@ -689,16 +681,14 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	info->ipc_ns = get_ipc_ns(current->nsproxy->ipc_ns);
>  
> -	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
> -	if (ret)
> -		return ret;
> -
>  	info->root_gid = make_kgid(sb->s_user_ns, 0);
>  	if (!gid_valid(info->root_gid))
>  		info->root_gid = GLOBAL_ROOT_GID;
>  	info->root_uid = make_kuid(sb->s_user_ns, 0);
>  	if (!uid_valid(info->root_uid))
>  		info->root_uid = GLOBAL_ROOT_UID;
> +	info->mount_opts.max = ctx->max;
> +	info->mount_opts.stats_mode = ctx->stats_mode;
>  
>  	inode = new_inode(sb);
>  	if (!inode)
> @@ -730,36 +720,54 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  			name++;
>  	}
>  
> -	if (info->mount_opts.stats_mode == STATS_GLOBAL)
> +	if (info->mount_opts.stats_mode == binderfs_stats_mode_global)
>  		return init_binder_logs(sb);
>  
>  	return 0;
>  }
>  
> -static struct dentry *binderfs_mount(struct file_system_type *fs_type,
> -				     int flags, const char *dev_name,
> -				     void *data)
> +static int binderfs_fs_context_get_tree(struct fs_context *fc)
>  {
> -	return mount_nodev(fs_type, flags, data, binderfs_fill_super);
> +	return get_tree_nodev(fc, binderfs_fill_super);
>  }
>  
> -static void binderfs_kill_super(struct super_block *sb)
> +static void binderfs_fs_context_free(struct fs_context *fc)
>  {
> -	struct binderfs_info *info = sb->s_fs_info;
> +	struct binderfs_mount_opts *ctx = fc->fs_private;
>  
> -	kill_litter_super(sb);
> +	kfree(ctx);
> +}
>  
> -	if (info && info->ipc_ns)
> -		put_ipc_ns(info->ipc_ns);
> +static const struct fs_context_operations binderfs_fs_context_ops = {
> +	.free		= binderfs_fs_context_free,
> +	.get_tree	= binderfs_fs_context_get_tree,
> +	.parse_param	= binderfs_fs_context_parse_param,
> +	.reconfigure	= binderfs_fs_context_reconfigure,
> +};
>  
> -	kfree(info);
> +static int binderfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct binderfs_mount_opts *ctx = fc->fs_private;
> +
> +	ctx = kzalloc(sizeof(struct binderfs_mount_opts), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->max = BINDERFS_MAX_MINOR;
> +	ctx->stats_mode = binderfs_stats_mode_unset;
> +
> +	fc->fs_private = ctx;
> +	fc->ops = &binderfs_fs_context_ops;
> +
> +	return 0;
>  }
>  
>  static struct file_system_type binder_fs_type = {
> -	.name		= "binder",
> -	.mount		= binderfs_mount,
> -	.kill_sb	= binderfs_kill_super,
> -	.fs_flags	= FS_USERNS_MOUNT,
> +	.name			= "binder",
> +	.init_fs_context	= binderfs_init_fs_context,
> +	.parameters		= binderfs_fs_parameters,
> +	.kill_sb		= kill_litter_super,
> +	.fs_flags		= FS_USERNS_MOUNT,
>  };
>  
>  int __init init_binderfs(void)
> 
> base-commit: f17f06a0c7794d3a7c2425663738823354447472
> -- 
> 2.25.1
> 

-- 
Kees Cook
