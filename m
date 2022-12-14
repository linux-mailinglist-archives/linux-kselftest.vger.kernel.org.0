Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA664CE3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Dec 2022 17:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiLNQkL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 11:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239090AbiLNQkF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 11:40:05 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD61B6464
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 08:40:04 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p6so3661582iod.13
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKOOiUPKftict/8DhQFtuAp51sa4ovrd2kJ1MyabHJw=;
        b=O3GKHlfCENCpCId9rzfgQyNazbXImgRjhe1IswoXuSD+obIOxQMzCJvjjn4DSO8TfB
         pnhJIYsu7L+bfp85STMCZNRGPLJsWYDIbGEnTiTNqiQ6QQMWtnc1xXP3s/hb29i0HQx8
         xLGWppNpMlvdaaE09ISsLcVZ+umUpgvV1+VKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKOOiUPKftict/8DhQFtuAp51sa4ovrd2kJ1MyabHJw=;
        b=D7p/UnGmMw2erZGz5Uzr/+d4rCbDInKHPnuEm6v1LHYihAsqUFaLHK5aqTMuD9Qyzl
         dRsJWgK+p+THZxEai/unN5Sq0bRja5Dy0BJajgCJcCf3HpA74FrpDii4d+06BiVGyaF8
         +2bZ2xDO88XqPKNdOM8OTl+Tfu2r1SZw8RyCKO86mltg6InCJBid31WwLbAsfMUb+bfC
         aqGW3UgNbFLdFLKXbHjvOAHUFVOkT1HyYNiVVvOSu/jHVhBORmp4HJj6s3WyXgArFZD1
         XuAhiF6DfwXoxDr8faJHvCgn8/wI/TSqMUIOck3uxqZqxgZTjmViqy4N5XIUeuF8us6U
         qrUA==
X-Gm-Message-State: ANoB5plaiqK7wxChGXoJkM5wdmY8BO6UQU1fNuLIjVOXijBkQ2ZchJk6
        XLIeNHuOVSHOYJvi6s29+AZEPg==
X-Google-Smtp-Source: AA0mqf4uk2vQ/34IoSVvV22g4d7cg9twWjLWq2DpSCNefcinONz0Gv+PJabIJlO243XLGuqdLtAuPg==
X-Received: by 2002:a6b:500e:0:b0:6e2:d3f7:3b60 with SMTP id e14-20020a6b500e000000b006e2d3f73b60mr2416935iob.2.1671036003942;
        Wed, 14 Dec 2022 08:40:03 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c17-20020a023311000000b0038a0182e0casm1939716jae.11.2022.12.14.08.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:40:03 -0800 (PST)
Message-ID: <808f35bf-2800-c34b-cae9-4d8eaa11294d@linuxfoundation.org>
Date:   Wed, 14 Dec 2022 09:40:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] kselftest/alsa: Increase kselftest timeout
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221214130353.1989075-1-nfraprado@collabora.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221214130353.1989075-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/14/22 06:03, Nícolas F. R. A. Prado wrote:
> The default timeout for kselftests is 45 seconds, but that isn't enough
> time to run pcm-test when there are many PCMs on the device, nor for
> mixer-test when slower control buses and fancier CODECs are present.
> 
> As data points, running pcm-test on mt8192-asurada-spherion takes about
> 1m15s, and mixer-test on rk3399-gru-kevin takes about 2m.
> 
> Set the timeout to 4 minutes to allow both pcm-test and mixer-test to
> run to completion with some slack.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Reduced timeout from 10 to 4 minutes
> - Tweaked commit message to also mention mixer-test and run time for
>    mixer-test on rk3399-gru-kevin
> 

What I have in mind is that the default run can be limited scope.
Run it on a few controllers and in the report mention that a full
test can be run as needed.

There are a couple of examples of default vs. full test runs - cpu
and memory hot-lug tests.

thanks,
-- Shuah
