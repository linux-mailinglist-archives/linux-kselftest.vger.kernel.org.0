Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC85894A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Aug 2022 01:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbiHCXIQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 19:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiHCXIP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 19:08:15 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66934D833
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Aug 2022 16:08:14 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso13139477otb.6
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Aug 2022 16:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zK33He6y28I2A9IcjFpGLeX6JG4yyriF39hUBO95RxU=;
        b=cNbtWAh9PYV+AhaqpPHWspWjIZUyRV6dWb78y3lddg5jfwOucE3VftBWAmYjru2+Ia
         i6hTWOVSobiSioHAlIsXVsHMvwTx8Etkv0HfP6yEfZ4cWyshUaYtgH6VNT25v+XddRiA
         unwClFJy1DZMyAIm6AiZ/vNdEvpuSOSRR6N7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zK33He6y28I2A9IcjFpGLeX6JG4yyriF39hUBO95RxU=;
        b=5DbiCflm2KVdAeqE3CWWWg91GpfMGe6pYcpxHICRbRSDz5i1Ioa5E56sK9RpjftZes
         oCX3qlun7YTwwNfFG0mGBCPzAkZwZomIekonV26D72obciSrqixEsoI72JYj4qhOPZxn
         tzTClJF1yj0h0pu25CZa1BCYqWeE65cYKY5rj7maGfIjJAeO95vgAlEPGYR3hjAVxhay
         WSZyEJZE4Ws1eB8S60JqjyV4GgPDGPzF1cfgKoGeqEaVjbOVZPXXAPR48oPw2U2OYEdE
         K+5Mwy/Sr4OrR3Lg7u2d6j/kLV7/64t1bQm97PM9ACvC37xfI2Z8uHJETIRyVsjPVWdN
         jRRA==
X-Gm-Message-State: AJIora8LEkX+SGhxjYftUuJ55IXRPrAb5NRweeTycV70df1VRIrnVENX
        OAVdroMXsNngFaQhfYEi2I4tuQ==
X-Google-Smtp-Source: AGRyM1tPuti8ZQ0UO1fbTpjB5tLkNS+5eRQ4uoNezs4/RqKsJQVjN40F0a5Om7/CKEcZSIIF3a9nig==
X-Received: by 2002:a9d:61d7:0:b0:61c:7bed:ce14 with SMTP id h23-20020a9d61d7000000b0061c7bedce14mr10041161otk.366.1659568093984;
        Wed, 03 Aug 2022 16:08:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bd37-20020a056870d7a500b000f5e89a9c60sm4714494oab.3.2022.08.03.16.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 16:08:13 -0700 (PDT)
Subject: Re: [PATCH] selftests/landlock: fix broken include of
 linux/landlock.h
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Guillaume <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <677a5a8f-87df-dde6-0adc-292858e4b5bd@linuxfoundation.org>
Date:   Wed, 3 Aug 2022 17:08:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/3/22 2:13 PM, Guillaume Tucker wrote:
> Revert part of the earlier changes to fix the kselftest build when
> using a sub-directory from the top of the tree as this broke the
> landlock test build as a side-effect when building with "make -C
> tools/testing/selftests/landlock".
> 
> Reported-by: Mickaël Salaün <mic@digikod.net>
> Fixes: a917dd94b832 ("selftests/landlock: drop deprecated headers dependency")
> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>   tools/testing/selftests/landlock/Makefile | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 

Thank you. Now applied to linux-kselftest next for the next pull request.

thanks,
-- Shuah
