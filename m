Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96C41E6A04
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 21:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406125AbgE1TF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 15:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406123AbgE1TF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 15:05:26 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B647C08C5C7
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 12:05:26 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id b3so130137oib.13
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zayuezgcz+k4PkQr7+Zp+Yj5Uyvc00S4ilElKD5RoqQ=;
        b=BOKyHigFkIszdY6Dz9TkcwV9lzSFcg4/7r5Zyjm5vRi8nf/M195V+ibUPh/M4WQqXQ
         S1kqP/cVuxZAt1eLk1SBr8dNB4vr+7e+iu4vBqU+yIYGegKyOdCGTORELlPfCiPyIcrZ
         uRcZddaYHNJpWIjwyPeu4DfP3J9Zjo84/bhxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zayuezgcz+k4PkQr7+Zp+Yj5Uyvc00S4ilElKD5RoqQ=;
        b=UO9PRT3KIbfNGeVTlPhrueh8s01pkI4BmyWyRK31U4lQaU8N6JvQ2mZFtQYSYN5yk2
         OLii9nCOuY7wXIzULIjywgphEsphsMvDyetmy46gMXaHuv8w/VM0NebTN2gciwadYGpb
         ck+mbKp3BH8yicvV40FV6dCtzxtQbwh2rT8XctLybT8ViutXaH5RlWCml72AAfGZA2T6
         E09qGAbEAOip8w1smXMB6vkSpR7qyc530TWgXojAfNU+TXn2MBnfkpgIrv10loMSKv+u
         sEoX1d2SISGTQz7gd/PpT760U/ocaMck9vsZYDew2n1RCU4luFWSFfFoKfWRrLW/Kwxa
         NPFw==
X-Gm-Message-State: AOAM5321XcCsUrXWNloLZjcDmfkf2J/Ys8Z7T/0i75Tc6j1bxqyBG+5B
        CaJPLUvRa6z7oR8Cc0hbHa2kHw==
X-Google-Smtp-Source: ABdhPJyyDPGR2hKdt3sx1/IY2x8I5w5rSB6ARZafgWF+9Wu868mYI574XuWofdN3OeeNkeC77pErBg==
X-Received: by 2002:aca:4a8b:: with SMTP id x133mr3109620oia.41.1590692726025;
        Thu, 28 May 2020 12:05:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h64sm2066424oia.28.2020.05.28.12.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:05:25 -0700 (PDT)
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Benc <jbenc@redhat.com>,
        shuah <shuah@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <xuny367lq1z1.fsf@redhat.com>
 <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
 <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com> <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <be0a24f4-8602-ba1b-6ca4-7308b01d7a48@linuxfoundation.org>
 <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com>
 <CANoWsw=NOvkFAv_roNSJhCqK6Z=xAv79CERzDNKz0qSqzZPstQ@mail.gmail.com>
 <CAADnVQL0doJyDFGFZEPgM4_crvDskxRhXQGevzX9KRg8PaFvSQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9068d622-2326-23e8-ad42-a4cbfb817f85@linuxfoundation.org>
Date:   Thu, 28 May 2020 13:05:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQL0doJyDFGFZEPgM4_crvDskxRhXQGevzX9KRg8PaFvSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/28/20 12:34 PM, Alexei Starovoitov wrote:
> On Thu, May 28, 2020 at 11:29 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
>>
>> Hi!
>>
>> On Thu, May 28, 2020 at 9:16 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Thu, May 28, 2020 at 11:07:09AM -0600, Shuah Khan wrote:
>>
>> [...]
>>>>
>>>> Here is what CI users are requesting:
>>>>
>>>> - ability to install bpf test with other selftests using kselftest
>>>>    install. The common framework is in place and with minor changes
>>>>    to bpf test Makefile, we can make this happen. Others and myself
>>>>    are willing to work on this, so we can get bpf test coverage in
>>>>    test rings.
>>>
>>> so you're saying that bpf maintainers and all bpf developers now
>>> would need to incorporate new 'make install' step to their workflow
>>> because some unknown CI system that is not even functional decided
>>> to do 'make install' ?
>>> That's exactly my point about selfish CI developers who put their
>>> needs in front of bpf community of developers.
>>
>> May be, it can work both ways to make everybody happy :) (I haven't
>> seen yet fundamental problems why not).
> 
> then stop pretending and do 'cp -r' for your CI as you were suggested
> several times already.
> It works just fine for libbpf CI. Feel free to copy those scripts.
> 

Yauheni,

Let's drop discussing this patch set. I don't have all the patches
and changes in this to weigh in. There is no need to add cp -r at all.

I want to take the discussion one level up to the use-cases.

thanks,
-- Shuah
