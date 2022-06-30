Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA635616B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 11:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiF3Jov (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jun 2022 05:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiF3Jou (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jun 2022 05:44:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3CB40E69;
        Thu, 30 Jun 2022 02:44:49 -0700 (PDT)
Received: from [192.168.10.6] (unknown [39.45.241.119])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C43256601948;
        Thu, 30 Jun 2022 10:44:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656582288;
        bh=P0BWtySV4MRg9zO1ItPPouw9QtNHTwKz3nOrSZIaxDI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=E0QxmrqoI2wUI1dd89dOh+MH+Yk0NUrB1Jtn2xHixHAfYESASPuxOAFRtsgm3HPhR
         S52Uh6/Zq8P0XBl2BplIl9Ofxw5oBIZMGoMPm+Arnop/cUAMZeE6MQQQ+vXN+zgBa3
         CJ8ySoKfySKiG6weR0jnXpzdyamenOCMtXUR7HSqBgFz20Kq8EwlaTcu9JWtdwcE4Q
         qDP8Dsj6Dh7rWY6wVmYf3J6Kd1s8qwoHKSj1alc9t1251u1oJVdvEBwlXTp1a8r318
         f5dtsoA78384gKfCiPUkJupKYp5ReBVpjtGjaWr0Gp5Gq5W29oAlt0gt7afzn368Ro
         TONJSHH26JpUg==
Message-ID: <95a3eb80-645e-a1b9-8373-46b1ad015e96@collabora.com>
Date:   Thu, 30 Jun 2022 14:44:40 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     usama.anjum@collabora.com, Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kieran Bingham <kbingham@kernel.org>, kernel@collabora.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, guillaume.tucker@collabora.co.uk
Subject: Re: [PATCH v1] kbuild: fix sub directory output build of kselftests
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20220627070214.432390-1-usama.anjum@collabora.com>
 <15532d64-6744-c8a5-184b-18358211d345@linuxfoundation.org>
 <CAK7LNARxSFSQgmrZe2CXj+V153kymBVyGkXwOPWLNoybQ8+bfg@mail.gmail.com>
 <04f168f8-0369-f0f6-8eab-9d384aced2c8@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <04f168f8-0369-f0f6-8eab-9d384aced2c8@linuxfoundation.org>
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

Hi Masahiro,

>>> Please resend cc'ing linux-kselftest
>>>
>>> thanks,
>>> -- Shuah
>>
>>
>> Please do not send this any more.
>> This part is good as is.
I'm confused. Have you accepted or rejected the patch?

>>
> 
> + linux-kselftest@vger.kernel.org
> 
> The reason I suggested resending cc'ing linux-kselftest is because
> this fixes a kselftest problem.
> 
> I am assuming this patch will go through kbuild
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>


-- 
Muhammad Usama Anjum
