Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42661707E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBZSnh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 13:43:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33449 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgBZSnh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 13:43:37 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so297103ioh.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2020 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a9lte+fOFVwIvTxY0D7kbm+KY6FljHyVVBNSpRiNzyM=;
        b=OucBm0ZhnE71Y6NLaHS+8+OxDn0OXDGuas9PRChmy3QLD0bVR75NCbyTbysiQKfv+5
         tgnJ96uTgDVWcOMM/h7OtqLUnDPZw70AvkLeDgpR2Xdako1sEqaK0hp+ugfXxgUlO/Bg
         D4GSs/1E98Z9r5M5JPSCCVNru12XZSg9js6PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a9lte+fOFVwIvTxY0D7kbm+KY6FljHyVVBNSpRiNzyM=;
        b=FtrRMZ3WtkGrjIhH8KOpPClGOI8lwyUc5PR4Y+HeIBkeuhrN92RbDIEG14P00uQ3Iu
         2ncDjA722I7YJSdTN0bHG9uSPgiqbebQDZMhGR5BnvCCiyG5067SpLrXpNAkAF2jMXHK
         JFFYBgQVCtdcK4fvHHiYVfCncivlNgOQ84MoC8jRpnwYusNCl3KV+3nk4BqzU8+TAsE6
         BkWy4KQPhg32kSwMdbT4AM09MvazTXMEGRXWA3ZOpQIvEvMUkLaDaFBATtMS8x+KhHF8
         rDY1iD6HFxwtXbAhs9+13m5+QiyOxU4+UsEk4Qa6GtdMY3zDRIios3IwbhVKYgxc2P+r
         DH0Q==
X-Gm-Message-State: APjAAAUh2fXAPyJlt5apXG04m2MxpkjCzL14EllTEGxWA5LozDn+a38b
        ZEh3C+vZpyFac7LRAzVsml1tvw==
X-Google-Smtp-Source: APXvYqy+pCE4nTPCtile37Mod0xvFRqxBv28FMYOV6K0DBWl5tfRZlfaid7fmF8zL+YAb6vyUG5KJw==
X-Received: by 2002:a6b:cf0a:: with SMTP id o10mr5292089ioa.267.1582742616682;
        Wed, 26 Feb 2020 10:43:36 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c24sm765230iom.0.2020.02.26.10.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 10:43:36 -0800 (PST)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.6-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <94b64a48-a337-63c4-c504-7e9b0c29a7c6@linuxfoundation.org>
 <CAHk-=whGqq1XyJgYr+Mrx7Po2d2JVRvroSigxzQ+C6jCcU7uqw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7764e4a5-1efc-2560-3766-bfce826af985@linuxfoundation.org>
Date:   Wed, 26 Feb 2020 11:43:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whGqq1XyJgYr+Mrx7Po2d2JVRvroSigxzQ+C6jCcU7uqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/26/20 11:14 AM, Linus Torvalds wrote:
> On Tue, Feb 25, 2020 at 3:26 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> - Declutter git status fix from Christophe Leroy
> 
> I've pulled this, but just for future reference (and hoping for a
> future cleanup patch): instead of putting things in the global
> .gitignore file, do it in the relevant local one.
> 
> So you could just have added
> 
>    *.sh
>    !run.sh
> 
> in 'tools/testing/selftests/lkdtm/.gitignore' instead of doing
> 
>    # Generated lkdtm tests
>    /tools/testing/selftests/lkdtm/*.sh
>    !/tools/testing/selftests/lkdtm/run.sh
> 
> in the top-level one.
> 
> That keeps things much better separated. It also incidentally means
> that if a directory gets renamed, the gitignore file just "magically"
> continues to work (if you rename the actual files themselves that are
> named in gitignore, then that's obviously a different thing).
> 
> If you put it in the leaf directory, it also means that you don't need
> the '/' at the beginning, because the local gitignore entries will
> only affect that subdirectory (and any subdirectories under it).
> 
> So please put only "global" gitignore patterns in the top-level gitignore file.
> 
>                Linus
> 

Thanks. I will keep this mind as I review these kinds of patches.

-- Shuah

