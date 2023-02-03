Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE7D689E72
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjBCPkH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 10:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBCPkG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 10:40:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A8F40F0;
        Fri,  3 Feb 2023 07:40:04 -0800 (PST)
Received: from [10.101.1.132] (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D3B76602F05;
        Fri,  3 Feb 2023 15:40:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675438803;
        bh=XT+0Kpt9XssEBiYGUgWT3AdMr3kbbqgonP7RwP555rg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jqigyZMGKF1YMfy+M2oXL0oSp/6I7w5pkpOU3i3Si9moEQiYAhgkMqXB0fkoSW7u7
         NjQgGL+nOrkmPLk1OaplN8c9lrAUAG2WhfmyRdjK1U5y2jioHtp7RtwCMlyVoUbbls
         kBdjhW3DlIPVLO4wfTiadlMK725n2idbJ9M3ymobNojR/HQ09vMwEx9/Lg4nEFT438
         jlKbSixk95Adn2uEJlnJ8QUJCX993zS7JJcTUeBbq/kDNtOx79OWzDuTUpuloR0V57
         ieGBIOGkHEjfLilDc1zEYoY2F6NhWpcnWi0wKS9GMuVWxGd7kO0KjinZ6RITp29G0s
         EUJ5pHRJfF4EQ==
Message-ID: <6a7db0df-4f91-293a-35a9-2af77fa36dff@collabora.com>
Date:   Fri, 3 Feb 2023 16:40:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] selftests: add missing ')' in lib.mk
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <7de08f7f11551d6b8195c3e5d801db2fae3f49a9.1660048017.git.guillaume.tucker@collabora.com>
 <YvKM/J5xO8gKto+p@dev-arch.thelio-3990X>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <YvKM/J5xO8gKto+p@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09/08/2022 18:36, Nathan Chancellor wrote:
> On Tue, Aug 09, 2022 at 03:20:46PM +0200, Guillaume Tucker wrote:
>> Add missing closing ')' in lib.mk in a call to $error().  This only
>> affects LLVM / Clang builds.
>>
>> Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Ha, I see Mark just came up with the same fix many months later :)
Shame this wasn't applied back then, for some reason...

Guillaume

