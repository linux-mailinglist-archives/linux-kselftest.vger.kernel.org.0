Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D654579F85
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiGSNVZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 09:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiGSNVL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 09:21:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A05E5A160;
        Tue, 19 Jul 2022 05:37:22 -0700 (PDT)
Received: from [192.168.1.72] (136.203.115.78.rev.sfr.net [78.115.203.136])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 82A216601A38;
        Tue, 19 Jul 2022 13:37:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658234240;
        bh=wWppogLD5zvn424zVkczPstVmt7AHw1XWt3/QUo8fcs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YfR11FBpG+V4i8kKp3fXf+IFG0HHjy2q54moSk2syuggQPp6vlROFGrbrDyrm9pS5
         bj6+44CcyVsvWl26P6y+h/05hIXG/+Hw5DOv14dH9lcBUlnO85tEnDQuZ8GYPA1OxO
         BnIviNip25/4X3aIZoq8wSvPebv/quZQ1uKjxAx+KqHfA1z6mVIxA05NVHjHkCcl0a
         AiFZqbodH5pIU0Hwymd4F5KiGsJMWE6NcLTd3IiYO7DwQAFRIOl/cg1inNmHgvZTno
         96fPbiNXfMo6agx1KoJAKCxdPtHJce8QanLcVu1lINgdwF//KaJPrrwRs9dHY9ZTol
         QBz+CK0zkD93Q==
Message-ID: <8fc9d169-78ff-0fe4-67c0-784097861f12@collabora.com>
Date:   Tue, 19 Jul 2022 14:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Makefile: replace headers_install with headers for
 kselftest
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <a7af58feaa6ae6d3b0c8c55972a470cec62341e5.1657693952.git.guillaume.tucker@collabora.com>
 <f35a71d6-bd96-7aa9-c143-39ae88bc85d5@linuxfoundation.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <f35a71d6-bd96-7aa9-c143-39ae88bc85d5@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/07/2022 22:45, Shuah Khan wrote:
> On 7/13/22 12:33 AM, Guillaume Tucker wrote:
>> Replace headers_install with headers as kselftest uses the header
>> files from within the kernel tree rather than from a system-wide
>> installation.
>>
>> We can still run this directly:
>>
>>    $ make O=build kselftest-all
>>
>> and when building from the selftests directory:
>>
>>    $ make O=build headers
>>    $ make O=build -C tools/testing/selftests all
>>
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
>> ---
>>   Makefile | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index fb2f3bb53a6b..5c934d16664c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1347,10 +1347,10 @@ tools/%: FORCE
>>   # Kernel selftest
>>     PHONY += kselftest
>> -kselftest: headers_install
>> +kselftest: headers
>>       $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
>>   -kselftest-%: headers_install FORCE
>> +kselftest-%: headers FORCE
>>       $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
>>     PHONY += kselftest-merge
>>
> 
> Thank you for taking care of this. This will go through kbuild?

You're welcome.

Masahiro-san,

A you OK with applying this in the kbuild tree ahead of the
upcoming merge window?

Best wishes,
Guillaume
 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah
> 
