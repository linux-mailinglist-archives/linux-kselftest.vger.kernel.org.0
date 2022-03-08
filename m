Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA314D11CD
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 09:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344816AbiCHIMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 03:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbiCHIMM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 03:12:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C73ED01;
        Tue,  8 Mar 2022 00:11:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id E32481F4337F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646727074;
        bh=b5ERzQo2oqbkiehexNuKVS3aYF5UF95XAAUjgJ4Isy0=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=NGsQx+S96GhtSrWrly1BUol0VPltHVwr0//zQEkMfokKpHLDe0NDEVuXXQLrqIKrh
         EqsMtWGORp7qJi5rGVkLb0cosMO+d12JpKwQuRLQHRnepvX1TNnp4UOgb9FxEr3908
         lDu2Xbi0cLyYxDjpKoP9bgIxq2JkIslc/g1jbDeugxJOUkS7qapfly+on8h3dd6EsY
         RMAopm3R8gTF3IYmygPBJVzOA/hRVfI/1akYBBxvZh95L9hypO5S25xBtc/0lqhzk1
         Nl474wfP74vxU2jIUl4LKmfn+1rEwO+OL3EGV4JRluF1bLtKoL9vbbb46ymr3UEe7s
         KGfKzOplHlTRw==
Message-ID: <2ac8cecb-5e14-a8b2-7629-a9ab9d474585@collabora.com>
Date:   Tue, 8 Mar 2022 13:11:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernelci@groups.io, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Makefile: Fix separate output directory build of
 kselftests
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20220223191016.1658728-1-usama.anjum@collabora.com>
 <6e954470-f593-e27a-d15c-ecd5c28f4dca@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <6e954470-f593-e27a-d15c-ecd5c28f4dca@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/4/22 2:32 AM, Shuah Khan wrote:
> On 2/23/22 12:10 PM, Muhammad Usama Anjum wrote:
>> Build of kselftests fail if kernel's top most Makefile is used for
>> running or building kselftests with separate output directory. The
>> absolute path is needed to reference other files during this kind of
>> build. Set KBUILD_ABS_SRCTREE to use absolute path during the build. It
>> fixes the following different types of errors:
>>
>> make kselftest-all O=/linux_mainline/build
>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>
>> make kselftest-all O=build
>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> I've tested this patch on top of next-20220217. The latest next-20220222
>> have missing patches.
> 
> Can you give more details on the use-cases you tested? Did you test all
> the ways kselftest are built?
> 
Yeah, I've tried to test all the ways. Here are the different ways I've
used to test it:
1) Same directory build of kselftest (this is already working)
make kselftest
make kselftest-all
make kselftest-install
make kselftest-clean
make kselftest-gen_tar

2) These were failing when separate output directory is specified either
as relative or absolute path. After adding this patch, these are also
working. kselfetst.rst mentions separate output directory build in this way.
make kselftest O=build
make kselftest-all O=build
make kselftest-install O=build
make kselftest-clean O=build
make kselftest-gen_tar O=build

make kselftest O=/build
make kselftest-all O=/build
make kselftest-install O=/build
make kselftest-clean O=/build
make kselftest-gen_tar O=/build

Tested on top of next-20220307 after applying this patch.
