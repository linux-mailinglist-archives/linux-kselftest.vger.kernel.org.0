Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1315A40C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiH2BtY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 21:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH2BtX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 21:49:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C8C30572;
        Sun, 28 Aug 2022 18:49:21 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGCwb0HlpznTm1;
        Mon, 29 Aug 2022 09:46:55 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 09:49:19 +0800
Subject: Re: [PATCH -next v2 4/6] landlock/selftests: add selftests for chmod
 and chown
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
CC:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-5-xiujianfeng@huawei.com> <YwpY6UpznnHpweh+@nuc>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <76c05799-91e1-dea3-92dd-beb299d0945c@huawei.com>
Date:   Mon, 29 Aug 2022 09:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YwpY6UpznnHpweh+@nuc>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

ÔÚ 2022/8/28 1:48, G¨¹nther Noack Ð´µÀ:
> On Sat, Aug 27, 2022 at 07:12:13PM +0800, Xiu Jianfeng wrote:
>> The following APIs are tested with simple scenarios.
>> 1. chmod/fchmod/fchmodat;
>> 2. chmod/fchmod/lchown/fchownat;
>>
>> The key point is that set these access rights on a directory but only for
>> its content, not the directory itself. this scenario is covered.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   tools/testing/selftests/landlock/fs_test.c | 261 +++++++++++++++++++++
>>   1 file changed, 261 insertions(+)
>>
>> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
>> index f513cd8d9d51..982cb824967c 100644
>> --- a/tools/testing/selftests/landlock/fs_test.c
>> +++ b/tools/testing/selftests/landlock/fs_test.c
>> @@ -3272,6 +3272,267 @@ TEST_F_FORK(layout1, truncate)
>>   	EXPECT_EQ(0, test_creat(file_in_dir_w));
>>   }
>>
>> +/* Invokes chmod(2) and returns its errno or 0. */
>> +static int test_chmod(const char *const path, mode_t mode)
>> +{
>> +	if (chmod(path, mode) < 0)
>> +		return errno;
>> +	return 0;
>> +}
> 
> Nice, this is much simpler than in the last revision :)
> 
>> +
>> +/* Invokes fchmod(2) and returns its errno or 0. */
>> +static int test_fchmod(int fd, mode_t mode)
>> +{
>> +	if (fchmod(fd, mode) < 0)
>> +		return errno;
>> +	return 0;
>> +}
>> +
>> +/* Invokes fchmodat(2) and returns its errno or 0. */
>> +static int test_fchmodat(int dirfd, const char *path, mode_t mode, int flags)
> 
> Nitpick: Some of these functions have path arguments declared as
> 
>    const char *path
> 
> and others as
> 
>    const char *const path
> 
> -- would be nice to stay consistent.

Thanks, const char *const path would be good to me.

> 
>> +{
>> +	if (fchmodat(dirfd, path, mode, flags) < 0)
>> +		return errno;
>> +	return 0;
>> +}
>> +
>> +/* Invokes chown(2) and returns its errno or 0. */
>> +static int test_chown(const char *path, uid_t uid, gid_t gid)
>> +{
>> +	if (chown(path, uid, gid) < 0)
>> +		return errno;
>> +	return 0;
>> +}
>> +
>> +/* Invokes fchown(2) and returns its errno or 0. */
>> +static int test_fchown(int fd, uid_t uid, gid_t gid)
>> +{
>> +	if (fchown(fd, uid, gid) < 0)
>> +		return errno;
>> +	return 0;
>> +}
>> +
>> +/* Invokes lchown(2) and returns its errno or 0. */
>> +static int test_lchown(const char *path, uid_t uid, gid_t gid)
>> +{
>> +	if (lchown(path, uid, gid) < 0)
>> +		return errno;
>> +	return 0;
>> +}
>> +
>> +/* Invokes fchownat(2) and returns its errno or 0. */
>> +static int test_fchownat(int dirfd, const char *path,
>> +			 uid_t uid, gid_t gid, int flags)
>> +{
>> +	if (fchownat(dirfd, path, uid, gid, flags) < 0)
>> +		return errno;
>> +	return 0;
>> +}
>> +
>> +TEST_F_FORK(layout1, unhandled_chmod)
>> +{
>> +	int ruleset_fd, file1_fd;
>> +	const char *file1 = file1_s1d1;
>> +	const char *file2 = file2_s1d1;
>> +	const char *dir1 = dir_s1d1;
> 
> I'd suggest to name these kinds of variables according to the rights
> that are granted on these files and directories, for example as as
> w_file and rw_file. (Then, when looking at the EXPECT_EQ checks below,
> you don't need to jump back up to the start of the test to remember
> which of the rights is being tested.)
> 
> Nitpick: The same remark as above about the 'const' modifier applies
> here as well. The rest of the file uses "const char *const varname".

Good point, will do it in v3.
> 
>> +	const struct rule rules[] = {
>> +		{
>> +			.path = file1,
>> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
>> +		},
>> +		{
>> +			.path = file2,
>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
>> +		},
>> +		{
>> +			.path = dir1,
>> +			.access = ACCESS_RW,
>> +		},
>> +		{},
>> +	};
>> +
>> +	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
>> +	ASSERT_LE(0, ruleset_fd);
>> +	file1_fd = open(file1, O_WRONLY | O_CLOEXEC);
>> +	ASSERT_LE(0, file1_fd);
>> +
>> +	enforce_ruleset(_metadata, ruleset_fd);
>> +	ASSERT_EQ(0, close(ruleset_fd));
>> +
>> +	EXPECT_EQ(0, test_chmod(file1, 0400));
>> +	EXPECT_EQ(0, test_fchmod(file1_fd, 0400));
>> +	EXPECT_EQ(0, test_fchmodat(AT_FDCWD, file1, 0400, 0));
>> +	EXPECT_EQ(0, test_chmod(file2, 0400));
>> +	EXPECT_EQ(0, test_chmod(dir1, 0700));
>> +	ASSERT_EQ(0, close(file1_fd));
>> +}
>> +
>> +TEST_F_FORK(layout1, chmod)
>> +{
>> +	int ruleset_fd, file1_fd;
>> +	const char *file1 = file1_s1d1;
>> +	const char *file2 = file2_s1d1;
>> +	const char *file3 = file1_s2d1;
>> +	const char *dir1 = dir_s1d1;
>> +	const char *dir2 = dir_s2d1;
>> +	const struct rule rules[] = {
>> +		{
>> +			.path = file1,
>> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE |
>> +				  LANDLOCK_ACCESS_FS_CHMOD,
>> +		},
>> +		{
>> +			.path = file2,
>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
>> +		},
>> +		{
>> +			.path = dir1,
>> +			.access = ACCESS_RW,
>> +		},
>> +		{
>> +			.path = dir2,
>> +			.access = ACCESS_RW | LANDLOCK_ACCESS_FS_CHMOD,
>> +		},
>> +		{},
>> +	};
>> +
>> +	ruleset_fd = create_ruleset(_metadata, ACCESS_RW | LANDLOCK_ACCESS_FS_CHMOD, rules);
>> +	ASSERT_LE(0, ruleset_fd);
>> +	file1_fd = open(file1, O_WRONLY | O_CLOEXEC);
>> +	ASSERT_LE(0, file1_fd);
>> +
>> +	enforce_ruleset(_metadata, ruleset_fd);
>> +	ASSERT_EQ(0, close(ruleset_fd));
>> +
>> +	EXPECT_EQ(0, test_chmod(file1, 0400));
>> +	EXPECT_EQ(0, test_fchmod(file1_fd, 0400));
>> +	EXPECT_EQ(0, test_fchmodat(AT_FDCWD, file1, 0400, 0));
>> +	EXPECT_EQ(EACCES, test_chmod(file2, 0400));
>> +	EXPECT_EQ(EACCES, test_chmod(dir1, 0700));
>> +	/* set CHMOD right on dir will only affect its context not dir itself*/
>> +	EXPECT_EQ(0, test_chmod(file3, 0400));
>> +	EXPECT_EQ(0, test_fchmodat(AT_FDCWD, file3, 0400, 0));
>> +	EXPECT_EQ(EACCES, test_chmod(dir2, 0700));
>> +	EXPECT_EQ(EACCES, test_fchmodat(AT_FDCWD, dir2, 0700, 0));
>> +	ASSERT_EQ(0, close(file1_fd));
>> +}
>> +
>> +TEST_F_FORK(layout1, unhandled_chown)
>> +{
>> +	int ruleset_fd, file1_fd;
>> +	const char *file1 = file1_s1d1;
>> +	const char *file2 = file2_s1d1;
>> +	const char *dir1 = dir_s1d1;
>> +	const struct rule rules[] = {
>> +		{
>> +			.path = file1,
>> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
>> +		},
>> +		{
>> +			.path = file2,
>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
>> +		},
>> +		{
>> +			.path = dir1,
>> +			.access = ACCESS_RW,
>> +		},
>> +		{},
>> +	};
>> +	struct stat st;
>> +	uid_t uid;
>> +	gid_t gid;
>> +
>> +	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
>> +	ASSERT_LE(0, ruleset_fd);
>> +	file1_fd = open(file1, O_WRONLY | O_CLOEXEC);
>> +	ASSERT_LE(0, file1_fd);
>> +	/*
>> +	 * there is no CAP_CHOWN when the testcases framework setup,
>> +	 * and we cannot assume the testcases are run as root, to make
>> +	 * sure {f}chown syscall won't fail, get the original uid/gid and
>> +	 * use them in test_{f}chown.
>> +	 */
>> +	ASSERT_EQ(0, stat(dir1, &st));
>> +	uid = st.st_uid;
>> +	gid = st.st_gid;
>> +
>> +	enforce_ruleset(_metadata, ruleset_fd);
>> +	ASSERT_EQ(0, close(ruleset_fd));
>> +
>> +	EXPECT_EQ(0, test_chown(file1, uid, gid));
>> +	EXPECT_EQ(0, test_fchown(file1_fd, uid, gid));
>> +	EXPECT_EQ(0, test_lchown(file1, uid, gid));
>> +	EXPECT_EQ(0, test_fchownat(AT_FDCWD, file1, uid, gid, 0));
>> +	EXPECT_EQ(0, test_chown(file2, uid, gid));
>> +	EXPECT_EQ(0, test_chown(dir1, uid, gid));
>> +	ASSERT_EQ(0, close(file1_fd));
>> +}
>> +
>> +TEST_F_FORK(layout1, chown)
>> +{
>> +	int ruleset_fd, file1_fd;
>> +	const char *file1 = file1_s1d1;
>> +	const char *file2 = file2_s1d1;
>> +	const char *file3 = file1_s2d1;
>> +	const char *dir1 = dir_s1d1;
>> +	const char *dir2 = dir_s2d1;
>> +	const struct rule rules[] = {
>> +		{
>> +			.path = file1,
>> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE |
>> +				  LANDLOCK_ACCESS_FS_CHGRP,
>> +		},
>> +		{
>> +			.path = file2,
>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
>> +		},
>> +		{
>> +			.path = dir1,
>> +			.access = ACCESS_RW,
>> +		},
>> +		{
>> +			.path = dir2,
>> +			.access = ACCESS_RW | LANDLOCK_ACCESS_FS_CHGRP,
>> +		},
>> +		{},
>> +	};
>> +	struct stat st;
>> +	uid_t uid;
>> +	gid_t gid;
>> +
>> +	ruleset_fd = create_ruleset(_metadata, ACCESS_RW | LANDLOCK_ACCESS_FS_CHGRP, rules);
>> +	ASSERT_LE(0, ruleset_fd);
>> +	file1_fd = open(file1, O_WRONLY | O_CLOEXEC);
>> +	ASSERT_LE(0, file1_fd);
>> +	/*
>> +	 * there is no CAP_CHOWN when the testcases framework setup,
>> +	 * and we cannot assume the testcases are run as root, to make
>> +	 * sure {f}chown syscall won't fail, get the original uid/gid and
>> +	 * use them in test_{f}chown.
>> +	 */
>> +	ASSERT_EQ(0, stat(dir1, &st));
>> +	uid = st.st_uid;
>> +	gid = st.st_gid;
>> +
>> +	enforce_ruleset(_metadata, ruleset_fd);
>> +	ASSERT_EQ(0, close(ruleset_fd));
>> +
>> +	EXPECT_EQ(0, test_chown(file1, uid, gid));
>> +	EXPECT_EQ(0, test_fchown(file1_fd, uid, gid));
>> +	EXPECT_EQ(0, test_lchown(file1, uid, gid));
>> +	EXPECT_EQ(0, test_fchownat(AT_FDCWD, file1, uid, gid, 0));
>> +	EXPECT_EQ(EACCES, test_chown(file2, uid, gid));
>> +	EXPECT_EQ(EACCES, test_chown(dir1, uid, gid));
>> +	/* set CHOWN right on dir will only affect its context not dir itself*/
>> +	EXPECT_EQ(0, test_chown(file3, uid, gid));
>> +	EXPECT_EQ(EACCES, test_chown(dir2, uid, gid));
>> +	ASSERT_EQ(0, close(file1_fd));
>> +}
>> +
>>   /* clang-format off */
>>   FIXTURE(layout1_bind) {};
>>   /* clang-format on */
>> --
>> 2.17.1
>>
> 
> --
> .
> 
