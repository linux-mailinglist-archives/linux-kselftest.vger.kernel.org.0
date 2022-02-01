Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF974A62D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 18:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbiBARp2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 12:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbiBARp1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 12:45:27 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508FC061714
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Feb 2022 09:45:27 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id h7so22198874iof.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Feb 2022 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hZJGDi4O38yZhJdwibyuJTdCKMidi1j6wS2HcvSmoow=;
        b=JT39to3C36+ZOsdkWRmlycM58WEzIi02MD2At9C+vYNsMBlFs/gnUF8kQHiW5KgjMV
         aWUxLEtmEcTX7xh1rj3AGThTMH8F3HDpXr++mGTx0xaZgrGltnEJjcT8vLeRUzk1+koC
         UnSk4IDWihdzb9R/rib+f2rvSiuONHqew6Veg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hZJGDi4O38yZhJdwibyuJTdCKMidi1j6wS2HcvSmoow=;
        b=SZwnM3d937BuARD7TL3dshIydZUEuvU4nzI6aLthQ1OVZxZfzKbrWv+JsmuPPO7rWj
         3TZ2QAvC2rlxU8f9C4MZus+XVU0aI0jqJpf/1zllUnd3HdZUdkpYWrQmrSUtQtkm9XwQ
         MDmr4TXnH6lv6KIE1QLDqO6iim4oERH46xqn/FzJbt5/lDPkJKSXDOzQFpY350cFP3AS
         odrhVoywrn6TCnhETv/K8jtUmo0i44q0S8V8OdX1YwpV1AG8v/F5dzhyKiFr8f19AMJW
         BVo1mmmGU7OKot/CHao8X3HtZqKdhfYnUObwrz2OMpZcYl4lgIx278WTDpAyLQ1ID84T
         HUrg==
X-Gm-Message-State: AOAM530OkXDuPBETBJTgdcyxwwRfVjF0KXiJLTEec5/R//7W/SwDCobt
        eMIQVAy+jTKgPBkRcvySfrUx8g==
X-Google-Smtp-Source: ABdhPJxu24Z2OMYalmTSNKDV1Z7lmV7+UiQTl3i3BGPSDKUuSjsIdUqyKL957baWoqv5R+htZecIyA==
X-Received: by 2002:a05:6602:158b:: with SMTP id e11mr9772951iow.93.1643737526680;
        Tue, 01 Feb 2022 09:45:26 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id t7sm18456372ilu.37.2022.02.01.09.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:45:26 -0800 (PST)
Subject: Re: [PATCH] kselftest: alsa: Check for event generation when we write
 to controls
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220201151551.21497-1-broonie@kernel.org>
 <0e1bc48d-ff3e-a4f8-5f81-d6902e89458d@linuxfoundation.org>
 <YflxOnS65NDyx5Ul@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dbdb5e4b-37de-d17a-d149-5c735d016115@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 10:45:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YflxOnS65NDyx5Ul@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/1/22 10:43 AM, Mark Brown wrote:
> On Tue, Feb 01, 2022 at 09:18:52AM -0700, Shuah Khan wrote:
>> On 2/1/22 8:15 AM, Mark Brown wrote:
> 
>>> +int wait_for_event(struct ctl_data *ctl, int timeout)
>>
>> Let's make this static.
> 
> None of the other functions in this file are static, that'd be a further
> change to make the whole file consistent rather than having a mix I
> think.
> 

Let's plan for it as a separate patch then.

thanks,
-- Shuah
