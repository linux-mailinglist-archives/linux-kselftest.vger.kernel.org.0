Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5855A394E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiH0Rsg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 13:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH0Rsf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 13:48:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60576968;
        Sat, 27 Aug 2022 10:48:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bu22so4994930wrb.3;
        Sat, 27 Aug 2022 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3Zdop84jkpxYAhBtGBx+oj5ymYpGJcLf+5H9LufTC0M=;
        b=AK8F3RM9/QJfP3KjxtMiskPGED6xsI/cDUKKUXQODGIuzmu4vxIB3QdOWwK3/j6oX/
         3Nsnau4jhoudQePWNp9NsBC06Lu16Y4RfYED3tLdT5Z8wVr/Q/klfibRCozdWC2ExSjg
         hZjDEutI41cigh56vi2U3ybDYivkTckWageotDtX5Io4rEBzM9L33JIWRcK4pMiymKMR
         GhwS4VxmHW8Sg/eFkjwOSNIMeungqd4fXl8lE4lFsHFkyfYqCD1IoeZ9RzKGL6y3RXf0
         Tdi4U/Xlh1uPC/wX3if2+LToN68JVeVvZMyziwQjUKbrh45n/Gn830bx7uibzwEgGD+t
         DdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3Zdop84jkpxYAhBtGBx+oj5ymYpGJcLf+5H9LufTC0M=;
        b=zi129EOgxV82f8XcON23KDvUtF/qkNyKeVLdzkqYU/bpMlUUsehIKMwLNehEy7eIVc
         7NEJKl4y4IfcKCNz5S3uHW1ANHmHhdEUdPLV8HSMJHYsgtyuAs0JYP8/X9famAbMuAvf
         OvL4sPxUsTM/lWznvGuCARPeXQ6VaRUoVDueXL19xt04JJvy1a/lLiWJUOmweIfoN0Cy
         Qmnu6vM2Fnsk8yQ5WTLeZVcr1eTaaEymmSuuKwcWgV9mVhakiUo14RLW7QqPASxyxpW+
         DIaA6UAuqVtvcIyAg3uOIw4CLiQwMO1EyZ6W52JNNnMRNlvXQx9Kunl+yfj/LqqtfQJa
         2nRg==
X-Gm-Message-State: ACgBeo3IwZEXTi/v2uKMvikbG7Wn4C/frtn92zJ3m4QzwSzFOfLKMFB3
        Bo6Vl9QgfoRsqCwii9yqBss=
X-Google-Smtp-Source: AA6agR76ClBGY0nAOJeIhs0qFBYcxd89IzO1xCQocK3uIM6tw7eD+jfRNoZniVP+OXHc7O3xI0+/3Q==
X-Received: by 2002:a5d:4d0b:0:b0:226:d4d8:c3da with SMTP id z11-20020a5d4d0b000000b00226d4d8c3damr825384wrt.370.1661622508071;
        Sat, 27 Aug 2022 10:48:28 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a62400724bsm4392621wmq.0.2022.08.27.10.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 10:48:27 -0700 (PDT)
Date:   Sat, 27 Aug 2022 19:48:25 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -next v2 4/6] landlock/selftests: add selftests for chmod
 and chown
Message-ID: <YwpY6UpznnHpweh+@nuc>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-5-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827111215.131442-5-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 27, 2022 at 07:12:13PM +0800, Xiu Jianfeng wrote:
> The following APIs are tested with simple scenarios.
> 1. chmod/fchmod/fchmodat;
> 2. chmod/fchmod/lchown/fchownat;
>
> The key point is that set these access rights on a directory but only for
> its content, not the directory itself. this scenario is covered.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 261 +++++++++++++++++++++
>  1 file changed, 261 insertions(+)
>
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index f513cd8d9d51..982cb824967c 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -3272,6 +3272,267 @@ TEST_F_FORK(layout1, truncate)
>  	EXPECT_EQ(0, test_creat(file_in_dir_w));
>  }
>
> +/* Invokes chmod(2) and returns its errno or 0. */
> +static int test_chmod(const char *const path, mode_t mode)
> +{
> +	if (chmod(path, mode) < 0)
> +		return errno;
> +	return 0;
> +}

Nice, this is much simpler than in the last revision :)

> +
> +/* Invokes fchmod(2) and returns its errno or 0. */
> +static int test_fchmod(int fd, mode_t mode)
> +{
> +	if (fchmod(fd, mode) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/* Invokes fchmodat(2) and returns its errno or 0. */
> +static int test_fchmodat(int dirfd, const char *path, mode_t mode, int flags)

Nitpick: Some of these functions have path arguments declared as

  const char *path

and others as

  const char *const path

-- would be nice to stay consistent.

> +{
> +	if (fchmodat(dirfd, path, mode, flags) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/* Invokes chown(2) and returns its errno or 0. */
> +static int test_chown(const char *path, uid_t uid, gid_t gid)
> +{
> +	if (chown(path, uid, gid) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/* Invokes fchown(2) and returns its errno or 0. */
> +static int test_fchown(int fd, uid_t uid, gid_t gid)
> +{
> +	if (fchown(fd, uid, gid) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/* Invokes lchown(2) and returns its errno or 0. */
> +static int test_lchown(const char *path, uid_t uid, gid_t gid)
> +{
> +	if (lchown(path, uid, gid) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/* Invokes fchownat(2) and returns its errno or 0. */
> +static int test_fchownat(int dirfd, const char *path,
> +			 uid_t uid, gid_t gid, int flags)
> +{
> +	if (fchownat(dirfd, path, uid, gid, flags) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +TEST_F_FORK(layout1, unhandled_chmod)
> +{
> +	int ruleset_fd, file1_fd;
> +	const char *file1 = file1_s1d1;
> +	const char *file2 = file2_s1d1;
> +	const char *dir1 = dir_s1d1;

I'd suggest to name these kinds of variables according to the rights
that are granted on these files and directories, for example as as
w_file and rw_file. (Then, when looking at the EXPECT_EQ checks below,
you don't need to jump back up to the start of the test to remember
which of the rights is being tested.)

Nitpick: The same remark as above about the 'const' modifier applies
here as well. The rest of the file uses "const char *const varname".

> +	const struct rule rules[] = {
> +		{
> +			.path = file1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = file2,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = dir1,
> +			.access = ACCESS_RW,
> +		},
> +		{},
> +	};
> +
> +	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	file1_fd = open(file1, O_WRONLY | O_CLOEXEC);
> +	ASSERT_LE(0, file1_fd);
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	EXPECT_EQ(0, test_chmod(file1, 0400));
> +	EXPECT_EQ(0, test_fchmod(file1_fd, 0400));
> +	EXPECT_EQ(0, test_fchmodat(AT_FDCWD, file1, 0400, 0));
> +	EXPECT_EQ(0, test_chmod(file2, 0400));
> +	EXPECT_EQ(0, test_chmod(dir1, 0700));
> +	ASSERT_EQ(0, close(file1_fd));
> +}
> +
> +TEST_F_FORK(layout1, chmod)
> +{
> +	int ruleset_fd, file1_fd;
> +	const char *file1 = file1_s1d1;
> +	const char *file2 = file2_s1d1;
> +	const char *file3 = file1_s2d1;
> +	const char *dir1 = dir_s1d1;
> +	const char *dir2 = dir_s2d1;
> +	const struct rule rules[] = {
> +		{
> +			.path = file1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE |
> +				  LANDLOCK_ACCESS_FS_CHMOD,
> +		},
> +		{
> +			.path = file2,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = dir1,
> +			.access = ACCESS_RW,
> +		},
> +		{
> +			.path = dir2,
> +			.access = ACCESS_RW | LANDLOCK_ACCESS_FS_CHMOD,
> +		},
> +		{},
> +	};
> +
> +	ruleset_fd = create_ruleset(_metadata, ACCESS_RW | LANDLOCK_ACCESS_FS_CHMOD, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	file1_fd = open(file1, O_WRONLY | O_CLOEXEC);
> +	ASSERT_LE(0, file1_fd);
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	EXPECT_EQ(0, test_chmod(file1, 0400));
> +	EXPECT_EQ(0, test_fchmod(file1_fd, 0400));
> +	EXPECT_EQ(0, test_fchmodat(AT_FDCWD, file1, 0400, 0));
> +	EXPECT_EQ(EACCES, test_chmod(file2, 0400));
> +	EXPECT_EQ(EACCES, test_chmod(dir1, 0700));
> +	/* set CHMOD right on dir will only affect its context not dir itself*/
> +	EXPECT_EQ(0, test_chmod(file3, 0400));
> +	EXPECT_EQ(0, test_fchmodat(AT_FDCWD, file3, 0400, 0));
> +	EXPECT_EQ(EACCES, test_chmod(dir2, 0700));
> +	EXPECT_EQ(EACCES, test_fchmodat(AT_FDCWD, dir2, 0700, 0));
> +	ASSERT_EQ(0, close(file1_fd));
> +}
> +
> +TEST_F_FORK(layout1, unhandled_chown)
> +{
> +	int ruleset_fd, file1_fd;
> +	const char *file1 = file1_s1d1;
> +	const char *file2 = file2_s1d1;
> +	const char *dir1 = dir_s1d1;
> +	const struct rule rules[] = {
> +		{
> +			.path = file1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = file2,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = dir1,
> +			.access = ACCESS_RW,
> +		},
> +		{},
> +	};
> +	struct stat st;
> +	uid_t uid;
> +	gid_t gid;
> +
> +	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	file1_fd = open(file1, O_WRONLY | O_CLOEXEC);
> +	ASSERT_LE(0, file1_fd);
> +	/*
> +	 * there is no CAP_CHOWN when the testcases framework setup,
> +	 * and we cannot assume the testcases are run as root, to make
> +	 * sure {f}chown syscall won't fail, get the original uid/gid and
> +	 * use them in test_{f}chown.
> +	 */
> +	ASSERT_EQ(0, stat(dir1, &st));
> +	uid = st.st_uid;
> +	gid = st.st_gid;
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	EXPECT_EQ(0, test_chown(file1, uid, gid));
> +	EXPECT_EQ(0, test_fchown(file1_fd, uid, gid));
> +	EXPECT_EQ(0, test_lchown(file1, uid, gid));
> +	EXPECT_EQ(0, test_fchownat(AT_FDCWD, file1, uid, gid, 0));
> +	EXPECT_EQ(0, test_chown(file2, uid, gid));
> +	EXPECT_EQ(0, test_chown(dir1, uid, gid));
> +	ASSERT_EQ(0, close(file1_fd));
> +}
> +
> +TEST_F_FORK(layout1, chown)
> +{
> +	int ruleset_fd, file1_fd;
> +	const char *file1 = file1_s1d1;
> +	const char *file2 = file2_s1d1;
> +	const char *file3 = file1_s2d1;
> +	const char *dir1 = dir_s1d1;
> +	const char *dir2 = dir_s2d1;
> +	const struct rule rules[] = {
> +		{
> +			.path = file1,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE |
> +				  LANDLOCK_ACCESS_FS_CHGRP,
> +		},
> +		{
> +			.path = file2,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = dir1,
> +			.access = ACCESS_RW,
> +		},
> +		{
> +			.path = dir2,
> +			.access = ACCESS_RW | LANDLOCK_ACCESS_FS_CHGRP,
> +		},
> +		{},
> +	};
> +	struct stat st;
> +	uid_t uid;
> +	gid_t gid;
> +
> +	ruleset_fd = create_ruleset(_metadata, ACCESS_RW | LANDLOCK_ACCESS_FS_CHGRP, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	file1_fd = open(file1, O_WRONLY | O_CLOEXEC);
> +	ASSERT_LE(0, file1_fd);
> +	/*
> +	 * there is no CAP_CHOWN when the testcases framework setup,
> +	 * and we cannot assume the testcases are run as root, to make
> +	 * sure {f}chown syscall won't fail, get the original uid/gid and
> +	 * use them in test_{f}chown.
> +	 */
> +	ASSERT_EQ(0, stat(dir1, &st));
> +	uid = st.st_uid;
> +	gid = st.st_gid;
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	EXPECT_EQ(0, test_chown(file1, uid, gid));
> +	EXPECT_EQ(0, test_fchown(file1_fd, uid, gid));
> +	EXPECT_EQ(0, test_lchown(file1, uid, gid));
> +	EXPECT_EQ(0, test_fchownat(AT_FDCWD, file1, uid, gid, 0));
> +	EXPECT_EQ(EACCES, test_chown(file2, uid, gid));
> +	EXPECT_EQ(EACCES, test_chown(dir1, uid, gid));
> +	/* set CHOWN right on dir will only affect its context not dir itself*/
> +	EXPECT_EQ(0, test_chown(file3, uid, gid));
> +	EXPECT_EQ(EACCES, test_chown(dir2, uid, gid));
> +	ASSERT_EQ(0, close(file1_fd));
> +}
> +
>  /* clang-format off */
>  FIXTURE(layout1_bind) {};
>  /* clang-format on */
> --
> 2.17.1
>

--
