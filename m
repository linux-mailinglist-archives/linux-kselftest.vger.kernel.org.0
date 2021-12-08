Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60546DD78
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 22:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhLHVSN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 16:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhLHVSN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 16:18:13 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BF8C061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 13:14:40 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id w1so3416502ilh.9
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Dec 2021 13:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8ryZ1w0c8Aj/WW7+0em9KmWOSOY1s/jaKp4hTYC9QsQ=;
        b=EVNwBxgQOuoMQUYnwj5gMOldcJnqQfZ6TrJpizobhcirfVHLG6WyblU28pYX+Stdt+
         At95sZd4WdUxBPuIC0lZiTRR8+mwQU4Yqzvn5ML5ZKXyZG1V7cJ0XLbmoeoelJxYmOoR
         2iw4w9HTlYQLAySsjRd2DceDDMq3tW3zJAqkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ryZ1w0c8Aj/WW7+0em9KmWOSOY1s/jaKp4hTYC9QsQ=;
        b=tESqR7af7zBIIlPfNW1SML/UX6huvZzbS0VZnuST0kUi3WEaZ4pao78JM4fZRB7uQZ
         nmJtI6xRGGjDnoaP5kiaiFbhaxfGt0y44jyPTo3ozV3tbuOy5wc5Lo7HFPXAzYZ5LCan
         pLIlrBbM90gP+GIsM5zpFy0Ef0NLh7hETlNQ/paaiEfNJ7mBGeAem4b20k3h52+IwA8x
         zxk/u1vHIxuKF33QmJsiwKPYpMAaYqzXT2+UsVNRFEjnMkxaa//0Xw/gpBui5x9oJLz5
         MXybpLP6jXFKa4W5dLyrFlLYj7E5rpcv7S545K621hssY+fTAc4U+HAQ3J9P35LzNjK3
         3Tlg==
X-Gm-Message-State: AOAM531DCCiF4+IC/sSo09VTL5TB27wBbj1TO+b16Ne8QwZhzZrlk94e
        33+KTY5HI4v8fB2XXMQRCW1+Yw==
X-Google-Smtp-Source: ABdhPJzqBvRkuxbtSleJynpQuoNdEXo758C/5IbACtreWQ+T5Hr+sGPcYbPH1rQ0f00rRkCM0f1tTw==
X-Received: by 2002:a05:6e02:154c:: with SMTP id j12mr9719269ilu.51.1638998080338;
        Wed, 08 Dec 2021 13:14:40 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b3sm2612084ile.26.2021.12.08.13.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 13:14:39 -0800 (PST)
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kselftest@vger.kernel.org, alsa-devel@alsa-project.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211206160305.194011-1-broonie@kernel.org>
 <de0c5677-c2cf-d1ab-68c5-2f410d17b66c@linuxfoundation.org>
 <YbD7+C74DFlZEokt@sirena.org.uk>
 <37f87d39-b5a9-46f6-2667-c0b7aafb731a@linuxfoundation.org>
 <YbERo5FxA6Rm3bhd@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f18f28f8-fb78-3ddd-153e-40675e5e6e8e@linuxfoundation.org>
Date:   Wed, 8 Dec 2021 14:14:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YbERo5FxA6Rm3bhd@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/8/21 1:12 PM, Mark Brown wrote:
> On Wed, Dec 08, 2021 at 11:59:18AM -0700, Shuah Khan wrote:
>> On 12/8/21 11:39 AM, Mark Brown wrote:
>>> On Wed, Dec 08, 2021 at 10:42:35AM -0700, Shuah Khan wrote:
> 
>>>>> +	snd_ctl_elem_value_alloca(&val);
> 
>>> This is idiomatic for alsa-lib code.
> 
>> This is kernel code that is going into kernel sources. Why follow
>> alsa-lib convention?
> 
> Well, the kernel doesn't generally use alloca() as a pattern given the
> relatively small stack sizes we have and doesn't define helpers like
> these for it...  it's a toss up here between the conventions for use of
> the library we're using and the conventions of the kernel.
> 
>>>>> +	ksft_print_header();
> 
>>>> Add a check for root and skil the test.
> 
>>> There is no need for this test to run as root in most configurations,
>>> it is common to provide direct access to the sound cards to some or all
>>> users - for example with desktop distros the entire userspace audio
>>> subsystem normally runs as the logged in user by default.  alsa-lib's
> 
>> On my system, I don't see any output if run as root. Are there some tests
>> that work as non-root?
> 
> All of them work as non-root if the user they're running as has access
> to a card, if they do or not is system dependent - there may not be any
> cards at all in a given system to find.  Running as root will punch
> through most permission problems but it's not a requirement and a system
> could use a security module like SELinux to restrict what root can do.
> The sound devices are usually in /dev/snd, though userspace can place
> them where it wants - if run as a user that can access the relevant
> devices for the mixer interface (usually /dev/snd/controlC* though again
> userspace can rename them) then the tests will run on those devices.
> 

Sounds good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
