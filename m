Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB656E5F33
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDRKxd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjDRKxc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 06:53:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FE3E62;
        Tue, 18 Apr 2023 03:53:31 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q113B5HWJz8wx1;
        Tue, 18 Apr 2023 18:52:38 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 18:53:28 +0800
Message-ID: <d55baf4d-01d3-e4d7-e07f-9658d1606a8c@huawei.com>
Date:   Tue, 18 Apr 2023 18:53:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next v2 0/6] landlock: add chmod and chown support
From:   xiujianfeng <xiujianfeng@huawei.com>
To:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <roberto.sassu@huawei.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
Content-Language: en-US
In-Reply-To: <20220827111215.131442-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mickael,

Sorry about the long silence on this work, As we known this work depends
on another work about changing argument from struct dentry to struct
path for some attr/xattr related lsm hooks, I'm stuck with this thing,
because IMA/EVM is a special security module which is not LSM-based
currently, and severely coupled with the file system. so I am waiting
for Roberto Sassu' work (Move IMA and EVM to the LSM infrastructure) to
be ready, I think it can make my work more easy. you can find
Roberto'work here,
https://lwn.net/ml/linux-kernel/20230303181842.1087717-1-roberto.sassu@huaweicloud.com/

Any good idea are welcome, thanks.


On 2022/8/27 19:12, Xiu Jianfeng wrote:
> v2:
>  * abstract walk_to_visible_parent() helper
>  * chmod and chown rights only take affect on directory's context
>  * add testcase for fchmodat/lchown/fchownat
>  * fix other review issues
> 
> Xiu Jianfeng (6):
>   landlock: expand access_mask_t to u32 type
>   landlock: abstract walk_to_visible_parent() helper
>   landlock: add chmod and chown support
>   landlock/selftests: add selftests for chmod and chown
>   landlock/samples: add chmod and chown support
>   landlock: update chmod and chown support in document
> 
>  Documentation/userspace-api/landlock.rst     |   9 +-
>  include/uapi/linux/landlock.h                |  10 +-
>  samples/landlock/sandboxer.c                 |  13 +-
>  security/landlock/fs.c                       | 110 ++++++--
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/ruleset.h                  |   2 +-
>  security/landlock/syscalls.c                 |   2 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   | 267 ++++++++++++++++++-
>  9 files changed, 386 insertions(+), 31 deletions(-)
> 
