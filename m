Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC6120263D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jun 2020 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgFTTnN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Jun 2020 15:43:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41942 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgFTTnM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Jun 2020 15:43:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id a21so11773660oic.8
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Jun 2020 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RIOWaf+Y/IC5IumUTbHcSIUTmqTytf9U6a9ZMZVX/+Q=;
        b=Wpx/PkwpJVA62h/yxyifXguo4B/vp+ds5FY6STQtzt3IrEUZDal3eWPC15g36cIsN3
         cTB+9LrsQJKtvM149vYr9V8ax9fR/J3nJKhpLFZpxlB3e7SGABvbaLgqxqFNB7cMxAq3
         UxW2jF7aF6FlMJx0fm+iIOeBdDZXsPsipIgvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RIOWaf+Y/IC5IumUTbHcSIUTmqTytf9U6a9ZMZVX/+Q=;
        b=kKRq0zRdfcMlcCtzXbKmgICp+OymGym5iIxkkrojOH+429Rh6jP3cOf6TrmvJi0FHP
         rzA8jd1l5TTK5ElSePhAd94twitJo5P+3GG7ouPKB6M0ai5Btn6ejC1CEJ3vw+SO89Yl
         T2geFhsTr9JXG3WF9FU6L07m5V/GCJc0rIQX5cGV48kU8fq8GgYmyVL2cmVConX5S0GR
         dySQ9VsUhsZnZusMYOms1BQF3IelCWR0IWmgWwCBBWu/GqQkvmgDHtDs4N2iPPdZo/Cm
         kzXMdodSVsAEnYVRK96xDaJgxSqupuwyqm/casrUePtJJMy14H+yxZx/HADOew3QFu3S
         u7Vw==
X-Gm-Message-State: AOAM533AUq8nlgEfck/kIu+ouCCFYW+/GR7w1NSKk/+583duE3QXZ1eB
        BKlz0zL+HqIOQCH9c9x76USc/g==
X-Google-Smtp-Source: ABdhPJxSV8Jgwn1cwyHWNGyEuh4iDUv8Y2FKY83QDPvntIZ3lecCGJUm3uRCRVWBzKrXFG6eQRUylQ==
X-Received: by 2002:a54:4e9a:: with SMTP id c26mr7621939oiy.62.1592682130143;
        Sat, 20 Jun 2020 12:42:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v132sm2054176oif.6.2020.06.20.12.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 12:42:09 -0700 (PDT)
Subject: Re: [GIT PULL] Kunit update for Linux 5.8-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, skhan@linuxfoundation.org
References: <90024a5c-ea67-2529-e330-3a4f0bef6596@linuxfoundation.org>
 <CAHk-=wgO-3ZNiaM5gFbgtaSmEYnyZ10TUZz_JgXdzaK54xp1Kw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e9f0a460-5ff1-371f-a597-877751f76948@linuxfoundation.org>
Date:   Sat, 20 Jun 2020 13:42:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgO-3ZNiaM5gFbgtaSmEYnyZ10TUZz_JgXdzaK54xp1Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/20/20 1:13 PM, Linus Torvalds wrote:
> On Fri, Jun 19, 2020 at 10:28 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Please pull the Kunit update for Linux 5.8-rc12.
> 
> This doesn't sound like a fix for after the merge window. Explain.
> 
>                Linus
> 

I should have added a note like I usually do.

"KUnit resources are now refcounted to avoid passed in resources being
released while in use by kunit." is the reason why I made a call on
sending this request.

You are right that the second patch "Add support for named resources"
is a merge window content. However, my thinking is this could enable
writing more tests during 5.8 and these two patches are scoped
to just kunit.

Please feel free to delay it if you like. I will include them in for
next release.

thanks,
-- Shuah

