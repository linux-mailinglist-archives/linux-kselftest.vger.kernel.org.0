Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15015767973
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 02:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjG2AZk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 20:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjG2AZj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 20:25:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B572719
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 17:25:38 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id ca18e2360f4ac-78706966220so26639539f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 17:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690590337; x=1691195137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOAz5xtt/rpwKPYtZkbSQLD2PuwkkA8Bd2vIES6kj3U=;
        b=CYnU75nh2a8/M+OlHX2F9V0ToNhPxVs0SyPFhMR4XBQ/hBKgl6ckKsasI8WdGeH9GC
         jplbSKuA8K2d/qJ9rK5zvAGERUPZUQGEzkW5wUhdOn/AAfP6QvYS8haAfWP0i1KEjjf0
         Gg3Qy4EkJY91ETe9AayH3zd1/we14Uom3MRjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690590337; x=1691195137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOAz5xtt/rpwKPYtZkbSQLD2PuwkkA8Bd2vIES6kj3U=;
        b=Jzd7iEyapb45oeWAX3m9de96G2SXuu6FuzoQ+id5WoB8RPmCuboG/Y9zv4E9HaJWza
         FSUEsA7kGZcAEDnGkBgZb0DaQdoFNUIni5fATND+tjeFVcGelZkvAzqyYCqmXR/C8rvj
         ngvdmtNixSCEthAxUipGS+NiEHXpZX24sO2UTi1jnU0ApDaOAWVsjAuORnc/VO1Kawe/
         fi06v+Q2cSV9G8btNcf31Zh/oWJDfxCHp2XwmJhPFUWSuZlMoIlc706u4BUOiCtcTHuS
         Yss6UpVPVGAp/S3gwnOu+7Kjzd3gjSzqBXzl47kvCsrT2mI0dFeffFxM5jTw9q6SkkX+
         OLGw==
X-Gm-Message-State: ABy/qLY82ASomwXadNQyA1Uv4BtEXIKG3MFX3cJnmXCfGVTZxoR4GCYK
        4V86Hgo8a41ZzBt27e/YDbcjaw==
X-Google-Smtp-Source: APBJJlHYt90mFh+OA10ERF67CbdWEGZS/hMot4gSswHxGj5wIxZNMY6GO/DppIAXHLAgqzlyYLd6XQ==
X-Received: by 2002:a05:6602:2b91:b0:77a:ee79:652 with SMTP id r17-20020a0566022b9100b0077aee790652mr1652390iov.1.1690590337662;
        Fri, 28 Jul 2023 17:25:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o8-20020a6bcf08000000b0078702f4894asm1472457ioa.9.2023.07.28.17.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 17:25:37 -0700 (PDT)
Message-ID: <1f57e767-afd6-d30b-0c3a-de41e6adb68c@linuxfoundation.org>
Date:   Fri, 28 Jul 2023 18:25:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] selftests:connector: Fix input argument error paths to
 skip
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, Liam.Howlett@oracle.com,
        anjali.k.kulkarni@oracle.com, davem@davemloft.net,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230728225357.5040-1-skhan@linuxfoundation.org>
 <20230728162144.3db7dbac@kernel.org>
 <7b7b8acc-5db2-5e6a-e803-e054ec7e1ab0@linuxfoundation.org>
 <20230728170505.4bbe3ea9@kernel.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230728170505.4bbe3ea9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/28/23 18:05, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 17:58:01 -0600 Shuah Khan wrote:
>>> netdev was not CCed on this or patch 3 of the previous series :S
>>> Which is a bit odd 'cause it was CCed on patches 1 and 2 🤷️
>>
>> Odd. get_maintainers.pl didn't give me netdev. I added netdev
>> and others to the first patch from the bug report.
>>
>> Would you like me to resend this with netdev on the cc?
> 
> If you don't mind that'd be quite helpful, all our local tooling
> depends on the patch being in netdev's patchwork.

I understand - same case with kselftest patches. I rely on them
going kselftest patchwork.

Resent the patch.

thanks,
-- Shuah
