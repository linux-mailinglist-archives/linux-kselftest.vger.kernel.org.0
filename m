Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6FD5933F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiHORRp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiHORRo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 13:17:44 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48ED175B1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 10:17:43 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s199so9235116oie.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=iTqSFcKdBFWRcG51JwvSqUqajl7nbOchSE6cjtY60jg=;
        b=VPokcfO/Zn58P+uPyP+d80HrKyQ7jUIFzXVlgLDYNHAOD4WqTbEoWTM7oNaHLHqrNL
         bLm3dEEy1peXTF6kAfI6V3KmWLM9V4DvpaE2OkRW9sHzeoLypopzAPfNKgNKX8uLTnnk
         uZ/1fsZDVNaeiD/OTShmrfLX5AX/OZXgcY4Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=iTqSFcKdBFWRcG51JwvSqUqajl7nbOchSE6cjtY60jg=;
        b=rlYl7LHFEGCX+XS8XVXBgcAIKnrwjiSyIAwt0/p++AwUEhfRtPlp6cn0GczUdtx6oA
         6LfmthCIdo3GggY4f0uJoxq6RXP4XmulClZoqES45u8LRHSZuDogKC1ReSeYCgjWEXDP
         fxMBBVHAazJNMoHUuSR1ln9tMJRoDJ64WG/E6nMTpCInZkjzVMHUWhwloIpLkRzWRN15
         IRw1GUzMjX/9c/zTU5C3VPpQ3YsVUVtuzCVlZvRN7pHGURGdmsTgjytS0SffXXRrWkhm
         MnrDIx4YCpXAVKtkYifmAwDxdspY7/SXoyVe2y9DPJeV93By+qk71R7tzgC/UGKCXkfz
         czdA==
X-Gm-Message-State: ACgBeo3g8PnQkQW3+4R587tnX/AWZ7JnolBeHNoGxQ+l9NE+1PhRFIka
        Xbfrr6+pqsX3Q938bOjxvSrnkg==
X-Google-Smtp-Source: AA6agR5/eLFCnzSFObcfd6XyGoNsQ1b8dU8kb/ubZnHu5G5/wVMPb72Jx+yfPnA5mf5nhKDFxj2gJA==
X-Received: by 2002:a05:6808:1ab4:b0:33a:1081:2498 with SMTP id bm52-20020a0568081ab400b0033a10812498mr10170733oib.103.1660583863188;
        Mon, 15 Aug 2022 10:17:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d63-20020aca3642000000b00339c8aab320sm1914684oia.3.2022.08.15.10.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 10:17:42 -0700 (PDT)
Subject: Re: [PATCH] selftests/landlock: fix broken include of
 linux/landlock.h
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
 <f1fc4e6e-e2a6-3ec7-2d3b-215111a4b9ae@digikod.net>
 <76a2ac43-6e3d-0b62-7c8c-eec5f247f8f8@collabora.com>
 <3de9a64e-6f27-8f76-9626-6ee082d382ea@digikod.net>
 <c0c65ade-1d2a-5466-2c12-8e016904817f@digikod.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <32f7befd-19be-19aa-6db6-7b1fd670166e@linuxfoundation.org>
Date:   Mon, 15 Aug 2022 11:17:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c0c65ade-1d2a-5466-2c12-8e016904817f@digikod.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/12/22 9:29 AM, Mickaël Salaün wrote:
> Shuah, do you plan to send a pull request before merge window closes?
> 

I was hoping to do so and missed the window. Looks like more discussion
happening on this change. I will get this in for the next rc

thanks,
-- Shuah
