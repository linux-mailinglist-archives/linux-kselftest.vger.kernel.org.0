Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E3459C615
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 20:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiHVSZh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 14:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiHVSZg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 14:25:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC757481CB;
        Mon, 22 Aug 2022 11:25:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h22so12653338ejk.4;
        Mon, 22 Aug 2022 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=WSjr5OQXvdVIAyWdi/nVsKghIzdGvzvLM/PnvB44wFM=;
        b=WC1f7SWi499wGlSLhJLmOMlECqucvkW29KrwUxL6h6tXXo910BoiUURBB9jUKRWHUz
         o7HDVHdWWxpH1pK+gW1AkUS4HTI1GQz0z1kmjK6Hso0VOcPzdvFKAdAduML+M1nkcZtg
         jQ5SjedlKuFmp+H64qLDAZuSjMzZ9YyXB9glReiANSxjCfaDKLsS5epKSf3vqqBxWVPH
         mh2sXBvb4WVhT9pxI/mZgjiNpwNS3F27jE8HcraGOEUlcrD0WUeebJI2GqWa+5FqAoNY
         wo7kISGIS8K8WyS1y1KBkd38KMHSzBMCZCA6TFwmdaobiP0dgvBPMzXMrMhOhwKl1QFf
         fN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=WSjr5OQXvdVIAyWdi/nVsKghIzdGvzvLM/PnvB44wFM=;
        b=Qds2G8UwVGg4DrAerPG+pUa7V4J0OkH1coIbslyWm52V4osRpgolPhMnKwm8QMW0Ci
         07ko9uU6uIuGtuj4zEmKA+YUYBc+F50iGuU9snn7/9tb3viU80UrO+u5Gz7Z1utfKg+r
         w4a/LXtcRPU2MKD3A7VxmpTFR0aoHtKeXGP/Vh1QUMozf/0fYS3Jfhm8eVDjJZEvbakQ
         t1V6Rp+wf3g4FTl8VeyAFxbCZYJ+SnuQSEEEC8RNwsDailzhUAintfhU3Wr4jaslwX/g
         613431WM40R5xAn1Gp8AtM1Q5q3X9RWvus3exfnpxgAsTbHvQfloDfQ0ifYhr3f27Fq+
         oUCA==
X-Gm-Message-State: ACgBeo2ORi+3jxx82W7z1hkTUm79DrqV+cNQwa7BoZYTcbbioEY7pycK
        T5ESAwFnDGQSKlIIuEvjq5k=
X-Google-Smtp-Source: AA6agR5fCF5w1W9s5tvpqCkVObkd6n2SDUse+zon7NAdyNl1hz/xy1YZdqMQnPCokDEferoyK0zaKw==
X-Received: by 2002:a17:907:7fa7:b0:731:51b4:5020 with SMTP id qk39-20020a1709077fa700b0073151b45020mr13510113ejc.352.1661192733487;
        Mon, 22 Aug 2022 11:25:33 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906704b00b007315c723ac8sm6436212ejj.224.2022.08.22.11.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:33 -0700 (PDT)
Date:   Mon, 22 Aug 2022 20:25:31 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -next 2/5] landlock: add chmod and chown support
Message-ID: <YwPKG3G9PlStYPkz@nuc>
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <20220822114701.26975-3-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822114701.26975-3-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

Thanks for sending this patch set! :)

On Mon, Aug 22, 2022 at 07:46:58PM +0800, Xiu Jianfeng wrote:
> Add two flags LANDLOCK_ACCESS_FS_CHMOD and LANDLOCK_ACCESS_FS_CHOWN to
> support restriction to chmod(2) and chown(2) with landlock.
>
> Also change the landlock ABI version from 3 to 4.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  include/uapi/linux/landlock.h                |  8 ++++++--
>  security/landlock/fs.c                       | 16 +++++++++++++++-
>  security/landlock/limits.h                   |  2 +-
>  security/landlock/syscalls.c                 |  2 +-
>  tools/testing/selftests/landlock/base_test.c |  2 +-
>  tools/testing/selftests/landlock/fs_test.c   |  6 ++++--
>  6 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 735b1fe8326e..5ce633c92722 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -141,13 +141,15 @@ struct landlock_path_beneath_attr {
>   *   directory) parent.  Otherwise, such actions are denied with errno set to
>   *   EACCES.  The EACCES errno prevails over EXDEV to let user space
>   *   efficiently deal with an unrecoverable error.
> + * - %LANDLOCK_ACCESS_FS_CHMOD: Change the file mode bits of a file.
> + * - %LANDLOCK_ACCESS_FS_CHOWN: Change the owner and/or group of a file.
>   *
>   * .. warning::
>   *
>   *   It is currently not possible to restrict some file-related actions
>   *   accessible through these syscall families: :manpage:`chdir(2)`,
> - *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
> - *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> + *   :manpage:`stat(2)`, :manpage:`flock(2)`,
> + *   :manpage:`setxattr(2)`, :manpage:`utime(2)`,

*formatting nit*
We could fill up the full line width here

>   *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
>   *   Future Landlock evolutions will enable to restrict them.
>   */
> @@ -167,6 +169,8 @@ struct landlock_path_beneath_attr {
>  #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> +#define LANDLOCK_ACCESS_FS_CHMOD			(1ULL << 15)
> +#define LANDLOCK_ACCESS_FS_CHOWN			(1ULL << 16)
>  /* clang-format on */
>
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c57f581a9cd5..c25d5f89c8be 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -147,7 +147,9 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_CHMOD | \
> +	LANDLOCK_ACCESS_FS_CHOWN)
>  /* clang-format on */
>
>  /*
> @@ -1146,6 +1148,16 @@ static int hook_path_truncate(const struct path *const path)
>  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>  }
>
> +static int hook_path_chmod(const struct path *const dir, umode_t mode)
> +{
> +	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_CHMOD);
> +}
> +
> +static int hook_path_chown(const struct path *const dir, kuid_t uid, kgid_t gid)
> +{
> +	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_CHOWN);
> +}

One implication of this approach is that the chown+chmod right on a
directory's contents are always going together with the same rights on
the directory itself.

For example, if you grant chmod+chown access rights for "datadir/",
the command "chmod 0600 datadir/file1" will work, but so will the
command "chmod 0600 datadir". But the approach of checking just the
parent directory's rights is also inflexible if you think through the
kinds of rights you can grant with it. (It would also not be possible
to grant chmod+chown on individual files.)

Do you have any thoughts on how to resolve this if this flexibility
might be needed?

I wonder whether the right way to resolve this would be to give users
a way to make that distinction at the level of landlock_add_rule(),
with an API like this (note the additional flag):

  err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
                          &path_beneath, LANDLOCK_STRICTLY_BENEATH);
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^

Multiple calls of landlock_add_rule() on the same file are already
today joining the requested access rights, so it would be possible to
mix-and-match "strict beneath" with "beneath" rights on the same
directory, and it would work in the same way for other access rights
as well.

To be clear: I'm proposing this approach not because I think it should
be part of this patch set, but because it would be good to have a way
forward if that kind of flexibility is needed in the future.

Does that seem reasonable?

> +
>  /* File hooks */
>
>  static inline access_mask_t get_file_access(const struct file *const file)
> @@ -1199,6 +1211,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>  	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
>  	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> +	LSM_HOOK_INIT(path_chmod, hook_path_chmod),
> +	LSM_HOOK_INIT(path_chown, hook_path_chown),
>
>  	LSM_HOOK_INIT(file_open, hook_file_open),
>  };
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 82288f0e9e5e..08858da7fb4f 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,7 @@
>  #define LANDLOCK_MAX_NUM_LAYERS		16
>  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_CHOWN
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index f4d6fc7ed17f..469e0e11735c 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
>  	.write = fop_dummy_write,
>  };
>
> -#define LANDLOCK_ABI_VERSION 3
> +#define LANDLOCK_ABI_VERSION 4

ABI version 3 has not made it into a stable kernel yet; I wonder
whether it wouldn't be easier to just bundle the truncate, chmod and
chown rights as part of ABI version 3 (assuming that the patches make
it into a stable release together)?

Mickaël, do you have an opinion on this?

—Günther

--
