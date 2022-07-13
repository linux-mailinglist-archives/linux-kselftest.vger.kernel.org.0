Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CC65736CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbiGMNEQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiGMNEM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 09:04:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E11B109;
        Wed, 13 Jul 2022 06:04:11 -0700 (PDT)
Received: from [192.168.0.24] (86.166.5.84.rev.sfr.net [84.5.166.86])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E71D766019BF;
        Wed, 13 Jul 2022 14:04:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657717449;
        bh=DJ+Ifi8q1WZKJgWhlUSNwAnvaUire0QYSjxk5nepsmo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P4hVcmUIXP6LG161pXraZZktponzCwBMPKtf3oM1oGGKt2yogmLj6r/ZcUlJsjO8k
         gE6ArqhETBVaxuy+ZmSNQtM0PdTKuV0pgotE94ZTROKe8ekKNXRx90N05s1JseLABv
         h9XlVjq8QZZGJxUpFaRfB/iBZ6mBuD2huvPQq/SyN3PjQ2CQOPwsrxXoxnc9173czn
         Tb0GZ2fB0v++AozwwI58NAGAuiUVT93FN0DZM/9bwmvZBt2gyHvUhVdUpkUJPyKM0o
         T/+8bVpHZRQx7NRKeK6fWALNamuh0kEblrur2na9mAXxTZ6gwhowMN6iB4tIuKV+Rc
         PydcKPiXgXTvA==
Message-ID: <b2a7c23e-88be-4b44-d98b-a8555131f1a7@collabora.com>
Date:   Wed, 13 Jul 2022 15:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/4] Makefile: add headers to kselftest targets
Content-Language: en-US
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1657614127.git.guillaume.tucker@collabora.com>
 <745d1921a4d048ea25d262e33b40aad5ee470614.1657614127.git.guillaume.tucker@collabora.com>
 <Ys6LsqvQC+h3eM46@bergen.fjasle.eu>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <Ys6LsqvQC+h3eM46@bergen.fjasle.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/07/2022 11:09, Nicolas Schier wrote:
> On Tue, 12 Jul 2022 09:29 +0100 Guillaume Tucker wrote:
>> Add headers as a dependency to kselftest targets so that they can be
>> run directly from the top of the tree.  The kselftest Makefile used to
>> try to call headers_install "backwards" but failed due to the relative
>> path not being consistent.
>>
>> Now we can either run this directly:
>>
>>   $ make O=build kselftest-all
>>
>> or this:
>>
>>   $ make O=build headers
>>   $ make O=build -C tools/testing/selftests all
>>
>> The same commands work as well when building directly in the source
>> tree (no O=) or any arbitrary path (relative or absolute).
>>
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
> You might want to add the 'Reported-by: as you did in 
> https://lore.kernel.org/linux-kbuild/a7af58feaa6ae6d3b0c8c55972a470cec62341e5.1657693952.git.guillaume.tucker@collabora.com/ 

Except I don't know who reported the issue, I think it was just
very well known.  KernelCI builds have been working around it for
a couple of years.

The Reported-by in the other patch was about using "headers"
rather than "headers_install", as a follow-up improvement on top
of this patch.

> Tested-by: Nicolas Schier <nicolas@fjasle.eu>

Thank you!

Guillaume
