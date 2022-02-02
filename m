Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B366A4A7A05
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 22:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347440AbiBBVKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 16:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiBBVKR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 16:10:17 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238EAC06173B
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 13:10:17 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n17so701500iod.4
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3t75659HzPBq87wFRBg/hKoyMSaZFRX143OrPCse9fA=;
        b=FetyPppDYU956R83igKID+s65jxrPkNP9iHqHnYDnzitra0C3DnelZ7GXPiKprrgb0
         XJyqkDaqbxlDVvpMEDWTdcBGD2368gDxM7OkZK42TJkWP/3pGxxp/pt6a2w2cOnaVQ2u
         +h9uqANz/+hYCmJUiwEHvljOoHS/HcPpgt8Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3t75659HzPBq87wFRBg/hKoyMSaZFRX143OrPCse9fA=;
        b=wsWUZ/2P95FXtbgNlN5wPeay8KFhnf+Zyotp9WW+IkCjhXPQFxxtzRLnJZOQeF+Szn
         WVl7xxWBvUpnJVO35Z32n5mWzUC1ltVa9LqIyoGWUX0Nte5PzUto1cE+JrFhRPlnGkwG
         CCjxU45dzGXknpIGIazVCYCwT2MMIxN+aHaVCDT5/VA8R5kwmHQUJOzrShmcx020yisC
         vmhXKJ/XIQEGqye3+0LA1kPnXRgncIP3tYn4sIotzYMwRb/kPtzt9PU9eCdWhLdi2/sT
         nxsvNk4DwNi+BWQFfoRFrBbBEUjtst+B24+pfumfX8P6brTdU/hIEtj8AarG7SfoWtUp
         i98A==
X-Gm-Message-State: AOAM5302k+9BZ047eUHujRiFASMJD8HH7/UosAV1HcRvA64ie8/0n+Mx
        NRHHt9fuFzw485AjwXD6s9O1TQ==
X-Google-Smtp-Source: ABdhPJzZ/U40pLxN1F7mOBlTvI7e1PiFI3vnLg2IOzGJpegL6dPnnCWv9ezVVSNzL/N6gkrjlBskXQ==
X-Received: by 2002:a05:6638:3888:: with SMTP id b8mr15850151jav.250.1643836216416;
        Wed, 02 Feb 2022 13:10:16 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c3sm24565292iow.28.2022.02.02.13.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 13:10:16 -0800 (PST)
Subject: Re: [PATCH net-next] selftests: fib offload: use sensible tos values
To:     Guillaume Nault <gnault@redhat.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <5e43b343720360a1c0e4f5947d9e917b26f30fbf.1643826556.git.gnault@redhat.com>
 <54a7071e-71ad-0c7d-ccc4-0f85dbe1e077@linuxfoundation.org>
 <20220202201614.GB15826@pc-4.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c5be299d-35e9-9ae9-185f-2faa6eccb149@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 14:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220202201614.GB15826@pc-4.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/2/22 1:16 PM, Guillaume Nault wrote:
> On Wed, Feb 02, 2022 at 12:46:10PM -0700, Shuah Khan wrote:
>> On 2/2/22 11:30 AM, Guillaume Nault wrote:
>>> Although both iproute2 and the kernel accept 1 and 2 as tos values for
>>> new routes, those are invalid. These values only set ECN bits, which
>>> are ignored during IPv4 fib lookups. Therefore, no packet can actually
>>> match such routes. This selftest therefore only succeeds because it
>>> doesn't verify that the new routes do actually work in practice (it
>>> just checks if the routes are offloaded or not).
>>>
>>> It makes more sense to use tos values that don't conflict with ECN.
>>> This way, the selftest won't be affected if we later decide to warn or
>>> even reject invalid tos configurations for new routes.
>>
>> Wouldn't it make sense to leave these invalid values in the test though.
>> Removing these makes this test out of sync withe kernel.
> 
> Do you mean keeping the test as is and only modify it when (if) we
> decide to reject such invalid values?

This is for sure. Remove the invalid values in sync with the kernel code.

> Or to write two versions of the
> test, one with invalid values, the other with correct ones?
> 

This one makes sense if it adds value in testing to make sure we continue
to reject invalid values.

> I don't get what keeping a test with the invalid values could bring us.
> It's confusing for the reader, and might break in the future. This
> patch makes the test future proof, without altering its intent and code
> coverage. It still works on current (and past) kernels, so I don't see
> what this patch could make out of sync.
> 

If kernel still accepts these values, then the test is valid as long as
kernel still doesn't flag these values as invalid.

I might be missing something. Don't you want to test with invalid values
so make sure they are indeed rejected?

thanks,
-- Shuah
