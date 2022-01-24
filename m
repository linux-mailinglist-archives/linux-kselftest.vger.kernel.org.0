Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C2D49AA2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 05:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385009AbiAYDev (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 22:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3410179AbiAYA2o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 19:28:44 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25412C046E10
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 14:12:50 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x3so483919ilm.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 14:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PzFG9Ft4neOQvOvfQEzqyoKYmf495tiJ7B3zbncRZZw=;
        b=DDTVsNaAbFCpmddw0GDO5l4NnFIxgkzK4lvBgBiv11VpLsCvXHAvcacLDhMS+WNVpM
         YwkE7fAnYPp7JRtna8Mza5bsOzADR3WWXYE2y2jRVthTyS35OKKRp8g4WZyRY9qV/K0e
         W8JxcOREGJQikZzJ9WiRtnnxHV7cZnMVK/79I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PzFG9Ft4neOQvOvfQEzqyoKYmf495tiJ7B3zbncRZZw=;
        b=yJkKlePIVT2WLJ6/eo3d1/7UxvKRbewcbvVqYCm4+2l1nua79fswt+Qgl4TfdIOSxz
         c1qqIV35dGRmS7jQIG/H64U8DTusaNhDL8KLv7VxSb7XxBNtRBVfk7/1BPDELnhBWZaw
         asRy6poNXc90NG5Ccd6tX6/D0WW9dgpTXWsWLV6Gxl7cDcDJuRMxW9J9PMu70MegHnMX
         DWbeioIP2Pdfyk0doXaRhe8Om49BRn2DPDzENrncuaffBJaI2Zo2t3YlI0b4lPiiqOFv
         c67PaetyAav96VgsVtqZHx3auqkR0zUq/BjLyi4/Y7C6kJ8dxQZymlYlL0zR8qjMy2Lr
         pmRw==
X-Gm-Message-State: AOAM5309c5N/9jzm456jlnb5vP/D9XZEleDOyPqP17zHQzWNdygI8jzO
        Y2bLtpjYYvmaCqKAxvzVbrAKVjpuT8xXKA==
X-Google-Smtp-Source: ABdhPJyJvPzXpbd0LFupmd5PRT1bo2rG/5zUrQ8MHcgBSo2wDc+IwvUCPwkBGIGPhaYyT/rd7rtNHA==
X-Received: by 2002:a05:6e02:1a88:: with SMTP id k8mr9009035ilv.36.1643062369485;
        Mon, 24 Jan 2022 14:12:49 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:b48b:eb27:e282:37fe? ([2601:282:8200:4c:b48b:eb27:e282:37fe])
        by smtp.gmail.com with ESMTPSA id x13sm6463429ilu.0.2022.01.24.14.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 14:12:49 -0800 (PST)
Subject: Re: [PATCH] kselftest: alsa: Add test case for writing invalid values
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        alsa-devel@alsa-project.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220124151410.2715572-1-broonie@kernel.org>
 <f9a0addc-9e81-b2c2-e5c7-d5e69dae26cd@linuxfoundation.org>
 <Ye8enGjqmiUB9HTw@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <92819c09-f77d-0a4b-b3cf-a144cde7e30c@linuxfoundation.org>
Date:   Mon, 24 Jan 2022 15:12:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Ye8enGjqmiUB9HTw@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/24/22 2:48 PM, Mark Brown wrote:
> On Mon, Jan 24, 2022 at 02:35:53PM -0700, Shuah Khan wrote:
>> On 1/24/22 8:14 AM, Mark Brown wrote:
> 
>>> +	/* Restore the default value to minimise disruption */
>>> +	err = write_and_verify(ctl, ctl->def_val, NULL);
> 
>> Why not read the value and then restore the value, in case the value
>> before the write test is different from the ctl->def_val?
> 
> That's what we're doing - def_val is the value read from the device at
> the start of the test program before it tries to do any writes, we then
> restore it at the end of every test to minimise the chances that the
> device configuration will be messed up if the test program falls over.
> 

Missed that. Sounds good. In case this is going through sound tree

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
