Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E3D5A3735
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 13:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiH0LOe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 07:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiH0LOe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 07:14:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CACF55098;
        Sat, 27 Aug 2022 04:14:33 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MFDXK0yKkz1N7bj;
        Sat, 27 Aug 2022 19:10:57 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 19:14:30 +0800
Subject: Re: [PATCH -next 3/5] landlock/selftests: add selftests for chmod and
 chown
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
CC:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <20220822114701.26975-4-xiujianfeng@huawei.com> <YwPYbY/HbHTOv7Ux@nuc>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <64b93d8e-f2b0-31c8-0736-3194053de687@huawei.com>
Date:   Sat, 27 Aug 2022 19:14:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YwPYbY/HbHTOv7Ux@nuc>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Hi£¬

ÔÚ 2022/8/23 3:26, G¨¹nther Noack Ð´µÀ:
> On Mon, Aug 22, 2022 at 07:46:59PM +0800, Xiu Jianfeng wrote:
>> +TEST_F_FORK(layout1, unhandled_chmod)
>> +{
>> +	const struct rule rules[] = {
>> +		{
>> +			.path = file2_s3d1,
>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
>> +		},
>> +		{
>> +			.path = file3_s3d1,
>> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
>> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
>> +		},
>> +		{},
>> +	};
>> +	const int ruleset_fd =
>> +		create_ruleset(_metadata, ACCESS_RW, rules);
>> +
>> +	ASSERT_LE(0, ruleset_fd);
>> +	enforce_ruleset(_metadata, ruleset_fd);
>> +	ASSERT_EQ(0, close(ruleset_fd));
>> +
>> +	ASSERT_EQ(0, test_chmod(file2_s3d1));
>> +	ASSERT_EQ(0, test_fchmod(file2_s3d1));
>> +	ASSERT_EQ(0, test_chmod(file3_s3d1));
>> +	ASSERT_EQ(0, test_chmod(dir_s3d1));
>> +}
> 
> I missed it in the previous mail:
> 
> There are also the chown variants lchown() and fchownat(), as well as
> the chmod variant fchmodat(), which might be interesting to test,
> especially the symlink scenarios.
> 
> fchmodat() has a AT_SYMLINK_NOFOLLOW flag which does the chmod
> equivalent to lchown().
> 

man fchmodat shows as follows:
...
AT_SYMLINK_NOFOLLOW
If pathname is a symbolic link, do not dereference it: instead operate 
on the link itself. This flag is not currently implemented.
...

so I suppose this can not be test. Please correct me if I am wrong.
thanks.

> --
> .
> 
