Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8868A9F9
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Feb 2023 14:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjBDNVP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Feb 2023 08:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjBDNVO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Feb 2023 08:21:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C292E814;
        Sat,  4 Feb 2023 05:21:10 -0800 (PST)
Received: from [151.216.142.144] (unknown [151.216.142.144])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B5A0966029A5;
        Sat,  4 Feb 2023 13:21:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675516869;
        bh=YBYs+Vt0MYtSPHbZNBXHf50wjrg2a1Ig8HzAhqon1og=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QSbmWKXW4fFmgeOkN0y8T3aJfISWWMyyxyGpcJynyHCW1wTRew9QuP1zatGPML1UR
         lnqiqNEEKcN4L+JLKiXZVFMeuTq6YoBp+CTRSIMRzx68FyLHxjPaH4+6p2PUFl/XW7
         uDwKeO31sDjFI98MuRaE9j27iccN95/R9iD/eOdS5S9VVMODpKOxyTbFz7+F3br484
         8C9NH17K7oxHlkW25aOdxGwaTrSDKw12s6Ac7zv6fb9Kyq6bzPpW6c7qG/GEAehEhi
         dhbmEH+WuMwL/220iXON/rAfZofacuxhIAIbFtoeYHGJaoOL9TT8QLx8REpsqz2j2R
         rXyMqrJWfoYRQ==
Message-ID: <dae9314b-c99a-bb95-b0ed-f6a8c861d78d@collabora.com>
Date:   Sat, 4 Feb 2023 14:19:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] selftests: fix LLVM build for i386 and x86_64
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20220809142231.2419274-1-guillaume.tucker@collabora.com>
 <YvKOV1L73Mv/Dc6P@dev-arch.thelio-3990X>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <YvKOV1L73Mv/Dc6P@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah, Nathan,

On 09/08/2022 18:41, Nathan Chancellor wrote:
> On Tue, Aug 09, 2022 at 04:22:31PM +0200, Guillaume Tucker wrote:
>> Add missing cases for the i386 and x86_64 architectures when
>> determining the LLVM target for building kselftest.
>>
>> Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> 
> Right, I think this is the correct thing to do for the selftests. For
> the main kernel build, we use CLANG_TARGETS_FLAGS_x86 because ARCH=i386
> and ARCH=x86_64 are covered by SUBARCH=x86, which is what we switch on,
> rather than ARCH. I do see a couple of references to SUBARCH in the
> tools directory but I am not sure if that is usable for this part so:
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the review.

Could you please apply this patch?  It looks like it was
forgotten like the one with the missing trailing ')' I sent
around that time (now fixed with Mark's patch).

Alternatively, please let me know if anything else needs to be
done for it.

Thanks,
Guillaume

>> ---
>>  tools/testing/selftests/lib.mk | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>> index b1c62914366b..cc4c443d5b14 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -10,12 +10,14 @@ endif
>>  CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
>>  CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
>>  CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
>> +CLANG_TARGET_FLAGS_i386         := i386-linux-gnu
>>  CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
>>  CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
>>  CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
>>  CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
>>  CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
>>  CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
>> +CLANG_TARGET_FLAGS_x86_64       := x86_64-linux-gnu
>>  CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
>>  
>>  ifeq ($(CROSS_COMPILE),)
>> -- 
>> 2.30.2
>>

