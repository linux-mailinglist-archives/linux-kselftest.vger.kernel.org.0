Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5325A40CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 03:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH2Bw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 21:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH2Bw5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 21:52:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE4C2F3AA;
        Sun, 28 Aug 2022 18:52:56 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGD0k6ky5znTmr;
        Mon, 29 Aug 2022 09:50:30 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 09:52:54 +0800
Subject: Re: [PATCH -next v2 6/6] landlock: update chmod and chown support in
 document
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
CC:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-7-xiujianfeng@huawei.com> <YwpUU+DZKfD/lV/g@nuc>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <9e278dc5-35e6-2872-3255-52f38d1670e5@huawei.com>
Date:   Mon, 29 Aug 2022 09:52:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YwpUU+DZKfD/lV/g@nuc>
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

Hi,

ÔÚ 2022/8/28 1:28, G¨¹nther Noack Ð´µÀ:
> On Sat, Aug 27, 2022 at 07:12:15PM +0800, Xiu Jianfeng wrote:
>> update LANDLOCK_ACCESS_FS_{CHMOD, CHGRP} support and add abi change
>> in the document.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   Documentation/userspace-api/landlock.rst | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
>> index 2509c2fbf98f..0e97a7998fa1 100644
>> --- a/Documentation/userspace-api/landlock.rst
>> +++ b/Documentation/userspace-api/landlock.rst
>> @@ -61,7 +61,9 @@ the need to be explicit about the denied-by-default access rights.
>>               LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>>               LANDLOCK_ACCESS_FS_MAKE_SYM |
>>               LANDLOCK_ACCESS_FS_REFER |
>> -            LANDLOCK_ACCESS_FS_TRUNCATE,
>> +            LANDLOCK_ACCESS_FS_TRUNCATE |
>> +            LANDLOCK_ACCESS_FS_CHMOD |
>> +            LANDLOCK_ACCESS_FS_CHGRP
>>       };
>>
>>   Because we may not know on which kernel version an application will be
>> @@ -90,6 +92,11 @@ the ABI.
>>       case 2:
>>               /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
>>               ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
>> +            __attribute__((fallthrough));
>> +    case 3:
>> +            /* Removes LANDLOCK_ACCESS_FS_{CHMOD, CHGRP} for ABI < 4 */
>> +            ruleset_attr.handled_access_fs &= ~(LANDLOCK_ACCESS_FS_CHMOD |
>> +                                                LANDLOCK_ACCESS_FS_CHGRP);
>>       }
>>
>>   This enables to create an inclusive ruleset that will contain our rules.
> 
> There is a sentence just above this code example that neesd updating as well.
> 

Get it, it's the follwing sentence, thanks.
...
Let's check if we should
remove the `LANDLOCK_ACCESS_FS_REFER` or `LANDLOCK_ACCESS_FS_TRUNCATE` 
access
rights, which are only supported starting with the second and third 
version of
the ABI.
...

> --
> .
> 
