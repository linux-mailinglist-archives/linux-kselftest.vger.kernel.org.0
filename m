Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868E25A39BB
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 21:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiH0Ta6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 15:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiH0Ta4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 15:30:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1472F111F;
        Sat, 27 Aug 2022 12:30:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u5so5497018wrt.11;
        Sat, 27 Aug 2022 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=+9SLA5JMKgxjPbqJCOaB5bmEAWHKqypXN/iOxvc+ORg=;
        b=gzKJ80lGpK/Rti0kU41lRUXkmog54v8HFKLyqCocjmgKIg91vKugXxX+wgfL+WWlcG
         nsjJdnpogJ+bQmT5Y9jWJpetUSDxig05oy/AAZkcrZu6v/3wl1nLRu5qkeS57HGqrDr2
         XbwkGHMObE3VCqsh0OnwAPa3kPKnX1edfCjhB0UPuNN2wpX1BVieH7oay+d1fz25PjDg
         Mg5my9plD1EHCqeM47MI0X+6IIf025/DktAewF1VSpHZMLp8qFyIRLcxPglNOAb8bBr2
         nMD4gte7fV9DeCYucyk43akuv/bQRmhi2E5/V4o8YKu30cSCxHGr0PRfyNrLs8JWfZ5a
         QRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=+9SLA5JMKgxjPbqJCOaB5bmEAWHKqypXN/iOxvc+ORg=;
        b=c4Hl941+BdWyYgaEKo/JMjE7W82W2afCAFHhHNikx6ZvGvACvIrciqNdk/tq2Zvu5u
         v1rtJPD3kxQU+ud4wIdUqaK31u+zpSKEucPBt+CumH0x1bcNNbMQIUkA6LQOoLPgJLK0
         PBwYPsXULXY/6YZdX60ks3hL69tr0IWp6cqCMk7aCe6YK6aPqaXjAfT51mposDxgdWQo
         jRw8IlltnJrN74ffLECAAWL9RT9SwAG7LSBmtgnhHwieKgPuU6AL0o/dYz+6lj5j6+rA
         Bd8OA0SuKuh85rY73L7AIN2M5rwMA3kNKMiD0gdOipg5OaceUHzoHsG80Whlm75JOsSm
         bPAg==
X-Gm-Message-State: ACgBeo0IG0AFuacOh6lK9UagOh7CBIO6Du5BM9/L5QORtWJDVi3WsyYf
        7O9o6X+Tm+U7RpNoYLe8duA=
X-Google-Smtp-Source: AA6agR4hNJ5F4uQOveSUjyE4Xn1TBP+Kdlu49Pr2FVti/SyPWcViYMUtgePF6ehyE1o36bAEtpH18Q==
X-Received: by 2002:a5d:64ab:0:b0:225:5dc4:957 with SMTP id m11-20020a5d64ab000000b002255dc40957mr2886470wrp.271.1661628653358;
        Sat, 27 Aug 2022 12:30:53 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdd4e000000b0021f131de6aesm2954522wrm.34.2022.08.27.12.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 12:30:52 -0700 (PDT)
Date:   Sat, 27 Aug 2022 21:30:51 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -next v2 3/6] landlock: add chmod and chown support
Message-ID: <Ywpw66EYRDTQIyTx@nuc>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-4-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220827111215.131442-4-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

the mapping between Landlock rights to LSM hooks is now as follows in
your patch set:

* LANDLOCK_ACCESS_FS_CHMOD controls hook_path_chmod
* LANDLOCK_ACCESS_FS_CHGRP controls hook_path_chown
  (this hook can restrict both the chown(2) and chgrp(2) syscalls)

Is this the desired mapping?

The previous discussion I found on the topic was in

[1] https://lore.kernel.org/all/5873455f-fff9-618c-25b1-8b6a4ec94368@digikod.net/
[2] https://lore.kernel.org/all/b1d69dfa-6d93-2034-7854-e2bc4017d20e@schaufler-ca.com/
[3] https://lore.kernel.org/all/c369c45d-5aa8-3e39-c7d6-b08b165495fd@digikod.net/

In my understanding the main arguments were the ones in [2] and [3].

There were no further responses to [3], so I was under the impression
that we were gravitating towards an approach where the
file-metadata-modification operations were grouped more coarsely?

For example with the approach suggested in [3], which would be to
group the operations coarsely into (a) one Landlock right for
modifying file metadata that is used in security contexts, and (b) one
Landlock right for modifying metadata that was used in non-security
contexts. That would mean that there would be:

(a) LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES to control the
following operations:
  * chmod(2)-variants through hook_path_chmod,
  * chown(2)-variants and chgrp(2)-variants through hook_path_chown,
  * setxattr(2)-variants and removexattr(2)-variants for extended
    attributes that are not "user extended attributes" as described in
    xattr(7) through hook_inode_setxattr and hook_inode_removexattr

(b) LANDLOCK_ACCESS_FS_MODIFY_NON_SECURITY_ATTRIBUTES to control the
following operations:
  * utimes(2) and other operations for setting other non-security
    sensitive attributes, probably through hook_inode_setattr(?)
  * xattr modifications like above, but for the "user extended
    attributes", though hook_inode_setxattr and hook_inode_removexattr

In my mind, this would be a sensible grouping, and it would also help
to decouple the userspace-exposed API from the underlying
implementation, as Casey suggested to do in [2].

Specifically for this patch set, if you want to use this grouping, you
would only need to add one new Landlock right
(LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES) as described above
under (a) (and maybe we can find a shorter name for it... :))?

Did I miss any operations here that would be necessary to restrict?

Would that make sense to you? Xiu, what is your opinion on how this
should be grouped? Do you have use cases in mind where a more
fine-grained grouping would be required?

—Günther

P.S.: Regarding utimes: The hook_inode_setattr hook *also* gets called
on a variety on attribute changes including file ownership, file size
and file mode, so it might potentially interact with a bunch of other
existing Landlock rights. Maybe that is not the right approach. In any
case, it seems like it might require more thinking and it might be
sensible to do that in a separate patch set IMHO.

On Sat, Aug 27, 2022 at 07:12:12PM +0800, Xiu Jianfeng wrote:
> Add two flags LANDLOCK_ACCESS_FS_CHMOD and LANDLOCK_ACCESS_FS_CHGRP to
> support restriction to chmod(2) and chown(2) with landlock.
>
> If these two access rights are set on a directory, they only take effect
> for its context, not the directory itself.
>
> This patch also change the landlock ABI version from 3 to 4.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  include/uapi/linux/landlock.h                | 10 +++--
>  security/landlock/fs.c                       | 43 +++++++++++++++++++-
>  security/landlock/limits.h                   |  2 +-
>  security/landlock/syscalls.c                 |  2 +-
>  tools/testing/selftests/landlock/base_test.c |  2 +-
>  tools/testing/selftests/landlock/fs_test.c   |  6 ++-
>  6 files changed, 56 insertions(+), 9 deletions(-)
>
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 735b1fe8326e..07b73626ff20 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -141,14 +141,16 @@ struct landlock_path_beneath_attr {
>   *   directory) parent.  Otherwise, such actions are denied with errno set to
>   *   EACCES.  The EACCES errno prevails over EXDEV to let user space
>   *   efficiently deal with an unrecoverable error.
> + * - %LANDLOCK_ACCESS_FS_CHMOD: Change the file mode bits of a file.
> + * - %LANDLOCK_ACCESS_FS_CHGRP: Change the owner and/or group of a file.
>   *
>   * .. warning::
>   *
>   *   It is currently not possible to restrict some file-related actions
>   *   accessible through these syscall families: :manpage:`chdir(2)`,
> - *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
> - *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> - *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
> + *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`setxattr(2)`,
> + *   :manpage:`utime(2)`,:manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
> + *   :manpage:`access(2)`.
>   *   Future Landlock evolutions will enable to restrict them.
>   */
>  /* clang-format off */
> @@ -167,6 +169,8 @@ struct landlock_path_beneath_attr {
>  #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> +#define LANDLOCK_ACCESS_FS_CHMOD			(1ULL << 15)
> +#define LANDLOCK_ACCESS_FS_CHGRP			(1ULL << 16)
>  /* clang-format on */
>
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 4ef614a4ea22..6ac83d96ada7 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -185,7 +185,9 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_CHMOD | \
> +	LANDLOCK_ACCESS_FS_CHGRP)
>  /* clang-format on */
>
>  /*
> @@ -690,6 +692,31 @@ static inline int current_check_access_path(const struct path *const path,
>  	return check_access_path(dom, path, access_request);
>  }
>
> +static inline int
> +current_check_access_path_context_only(const struct path *const path,
> +				       const access_mask_t access_request)
> +{
> +	const struct landlock_ruleset *const dom =
> +		landlock_get_current_domain();
> +	struct path eff_path;
> +	int ret;
> +
> +	if (!dom)
> +		return 0;
> +	eff_path = *path;
> +	/* if it's dir, check its visible parent. */
> +	if (d_is_dir(eff_path.dentry)) {
> +		path_get(&eff_path);
> +		/* dont care if reaches the root or not. */
> +		walk_to_visible_parent(&eff_path);
> +		ret = current_check_access_path(&eff_path, access_request);
> +		path_put(&eff_path);
> +	} else {
> +		ret = current_check_access_path(&eff_path, access_request);
> +	}
> +	return ret;
> +}
> +
>  static inline access_mask_t get_mode_access(const umode_t mode)
>  {
>  	switch (mode & S_IFMT) {
> @@ -1177,6 +1204,18 @@ static int hook_path_truncate(const struct path *const path)
>  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>  }
>
> +static int hook_path_chmod(const struct path *const path, umode_t mode)
> +{
> +	return current_check_access_path_context_only(path,
> +					LANDLOCK_ACCESS_FS_CHMOD);
> +}
> +
> +static int hook_path_chown(const struct path *const path, kuid_t uid, kgid_t gid)
> +{
> +	return current_check_access_path_context_only(path,
> +					LANDLOCK_ACCESS_FS_CHGRP);
> +}
> +
>  /* File hooks */
>
>  static inline access_mask_t get_file_access(const struct file *const file)
> @@ -1230,6 +1269,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>  	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
>  	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> +	LSM_HOOK_INIT(path_chmod, hook_path_chmod),
> +	LSM_HOOK_INIT(path_chown, hook_path_chown),
>
>  	LSM_HOOK_INIT(file_open, hook_file_open),
>  };
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 82288f0e9e5e..7cdd7d467d12 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,7 @@
>  #define LANDLOCK_MAX_NUM_LAYERS		16
>  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_CHGRP
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
>
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 72cdae277b02..9f00582f639c 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -75,7 +75,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
>  					     LANDLOCK_CREATE_RULESET_VERSION));
>
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index debe2d9ea6cf..f513cd8d9d51 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -404,9 +404,11 @@ TEST_F_FORK(layout1, inval)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_CHMOD | \
> +	LANDLOCK_ACCESS_FS_CHGRP)
>
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_CHGRP
>
>  #define ACCESS_ALL ( \
>  	ACCESS_FILE | \
> --
> 2.17.1
>

--
