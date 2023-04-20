Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC16E9AF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjDTRky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjDTRkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 13:40:53 -0400
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DCB44A2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 10:40:49 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Q2Q1C69WSzMqQVD;
        Thu, 20 Apr 2023 19:40:47 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Q2Q196HmLzMppF8;
        Thu, 20 Apr 2023 19:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1682012447;
        bh=C42CG0yEhZ3//t6vNF4EAp/UK1VoZRlM/xbyZMTq9sw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ww1/qKoHdAKBnghB3zJAndSHHtlhWFME+1v84JiiUfZsB7CaOOqVsLbd0uITMgTCt
         VvjQ/4XR7CHTonbqvGTXfTB8WETF74lCX0tx9l329juYD85bDx6iqcoL0DbZoes+0b
         o+4McyPqybIf2i8Shqgmo4gSkoEP6pUNjKaAPGJU=
Message-ID: <a4dc7c12-b485-2eb2-add5-4f7a387a50fa@digikod.net>
Date:   Thu, 20 Apr 2023 19:40:44 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next v2 0/6] landlock: add chmod and chown support
Content-Language: en-US
To:     xiujianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, roberto.sassu@huawei.com,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <d55baf4d-01d3-e4d7-e07f-9658d1606a8c@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <d55baf4d-01d3-e4d7-e07f-9658d1606a8c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 18/04/2023 12:53, xiujianfeng wrote:
> Hi Mickael,
> 
> Sorry about the long silence on this work, As we known this work depends
> on another work about changing argument from struct dentry to struct
> path for some attr/xattr related lsm hooks, I'm stuck with this thing,
> because IMA/EVM is a special security module which is not LSM-based
> currently, and severely coupled with the file system. so I am waiting
> for Roberto Sassu' work (Move IMA and EVM to the LSM infrastructure) to
> be ready, I think it can make my work more easy. you can find
> Roberto'work here,
> https://lwn.net/ml/linux-kernel/20230303181842.1087717-1-roberto.sassu@huaweicloud.com/
> 
> Any good idea are welcome, thanks.

Thanks for the update Xiu.

Which part would be needed from Roberto's patch series?


> 
> 
> On 2022/8/27 19:12, Xiu Jianfeng wrote:
>> v2:
>>   * abstract walk_to_visible_parent() helper
>>   * chmod and chown rights only take affect on directory's context
>>   * add testcase for fchmodat/lchown/fchownat
>>   * fix other review issues
>>
>> Xiu Jianfeng (6):
>>    landlock: expand access_mask_t to u32 type
>>    landlock: abstract walk_to_visible_parent() helper
>>    landlock: add chmod and chown support
>>    landlock/selftests: add selftests for chmod and chown
>>    landlock/samples: add chmod and chown support
>>    landlock: update chmod and chown support in document
>>
>>   Documentation/userspace-api/landlock.rst     |   9 +-
>>   include/uapi/linux/landlock.h                |  10 +-
>>   samples/landlock/sandboxer.c                 |  13 +-
>>   security/landlock/fs.c                       | 110 ++++++--
>>   security/landlock/limits.h                   |   2 +-
>>   security/landlock/ruleset.h                  |   2 +-
>>   security/landlock/syscalls.c                 |   2 +-
>>   tools/testing/selftests/landlock/base_test.c |   2 +-
>>   tools/testing/selftests/landlock/fs_test.c   | 267 ++++++++++++++++++-
>>   9 files changed, 386 insertions(+), 31 deletions(-)
>>
