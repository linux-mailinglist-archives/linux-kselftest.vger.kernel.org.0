Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B9D1E6846
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 19:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405522AbgE1RHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 13:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405519AbgE1RHM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 13:07:12 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346CAC08C5C6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 10:07:12 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id f39so2553725ooi.7
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MSYAXf0gH1R97AXlajHE5LTABlem3lPHGGzXxX7zQC8=;
        b=MYYjYlTAOhQ1+b7SP+A2xe40exKwJ/+0EOjzdy2zmz8rGnhqKF8L/wf2eqHj83KZ9l
         Jo6EFTajJkyIW54WpBbcTZC3HZP8Aez5Jm26HFZdFHYB513g1oLJIpHal00HXMngNaB+
         HlvZvvpa4MFIXR9svkhixu5SxdcHGsVmB+3do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MSYAXf0gH1R97AXlajHE5LTABlem3lPHGGzXxX7zQC8=;
        b=SZrbKGb1Pz/FqF0zZoYplP8wMmD6VLvfz3r0hyjR12Lb+gpw64LIIrmQl/fhDZNVe+
         KUcnOBkAM8y6HTmuLaPvJlugkQiUax3V3y4KRxMC7YhJ4ySwPrQITRIcsx2l9j+F40DM
         EKAgds1TP1N4iqYWepXCGtObT2Wy7KE2CEVDOKqIVoPu5PrLskW9H5qZFR2QFNZMyrpS
         EmDyFn9W+qymrITwt5iUHzFjAl08cNBRXylAXG1Ja+BgTrgAXTe+UUjiBbbkjTvw4bMU
         S4MSZyvb6QKefIAQBuQKe0rI9VaEFV5FmkFum1hjlfUQs4bWJ0qfXcG22trF+LPn2nvR
         KQ0g==
X-Gm-Message-State: AOAM532TqIx6NkWI8fp6amCSyAbGs9QCOSn8EaMs/aSj/Zyrk0c1TbD0
        b0k6jkdEKvA8VHZEeOseQSLOInNlu9k=
X-Google-Smtp-Source: ABdhPJzVGEG4NA8jcw9ZrJVD6PSwQ8zFUrVfjK/h9WyCT35b+tpc8nk3Go4NEEta5zP4jF8iSYu2Ug==
X-Received: by 2002:a4a:9d42:: with SMTP id f2mr3310265ook.15.1590685631525;
        Thu, 28 May 2020 10:07:11 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g10sm1060259otn.34.2020.05.28.10.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 10:07:10 -0700 (PDT)
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <xunya71uosvv.fsf@redhat.com>
 <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com>
 <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
 <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com> <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <be0a24f4-8602-ba1b-6ca4-7308b01d7a48@linuxfoundation.org>
Date:   Thu, 28 May 2020 11:07:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/28/20 10:14 AM, Alexei Starovoitov wrote:
> On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
>> On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
>>> On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
>>>> I prefer to keep selftests/bpf install broken.
>>>> This forced marriage between kselftests and selftests/bpf
>>>> never worked well. I think it's a time to free them up from each other.
>>>
>>> Alexei, it would be great if you could cooperate with other people
>>> instead of pushing your own way. The selftests infrastructure was put
>>> to the kernel to have one place for testing. Inventing yet another way
>>> to add tests does not help anyone. You don't own the kernel. We're
>>> community, we should cooperate.
>>
>> I agree, we rely on the infrastructure of the kselftests framework so
>> that testing systems do not have to create "custom" frameworks to handle
>> all of the individual variants that could easily crop up here.
>>
>> Let's keep it easy for people to run and use these tests, to not do so
>> is to ensure that they are not used, which is the exact opposite goal of
>> creating tests.
> 
> Greg,
> 
> It is easy for people (bpf developers) to run and use the tests.
> Every developer runs them before submitting patches.
> New tests is a hard requirement for any new features.
> Maintainers run them for every push.
> 
> What I was and will push back hard is when other people (not bpf developers)
> come back with an excuse that some CI system has a hard time running these
> tests. It's the problem of weak CI. That CI needs to be fixed. Not the tests.
> The example of this is that we already have github/libbpf CI that runs
> selftests/bpf just fine. Anyone who wants to do another CI are welcome to copy
> paste what already works instead of burdening people (bpf developers) who run
> and use existing tests. I frankly have no sympathy to folks who put their own
> interest of their CI development in front of bpf community of developers.
> The main job of CI is to help developers and maintainers.
> Where helping means to not impose new dumb rules on developers because CI
> framework is dumb. Fix CI instead.
> 

Here is what CI users are requesting:

- ability to install bpf test with other selftests using kselftest
   install. The common framework is in place and with minor changes
   to bpf test Makefile, we can make this happen. Others and myself
   are willing to work on this, so we can get bpf test coverage in
   test rings.

- be able to build and run existing tests without breaking the test
   build when new tests are added that have hard dependency on new
   versions of tools (llvm etc.). This isn't such a novel idea. We
   don't break kernel builds every single release and even when we
   require newer compiler releases. Plan the new tests with the intent
   to not break existing users and add new tests at the same time.
   We use min rev and not bleeding edge as the requirement for kernel
   build.

Requiring test rings upgrade to new versions of llvm is unreasonable.
It places undue burden on the admins to do this every single release
(may be even every rc cycle)

What is dumb about these requests and why is it not acceptable to just
bpf when all other sub-systems keep adding tests continuously using the
selftests framework so we can test the kernel better and our releases
are of better quality.

If you check the volume of tests that get added every release, you can
easily see it isn't hard.

Calling the needs of CI dumb is detrimental to kernel quality as these
rings provide a very important function. Addressing their use-case helps
get better test coverage for bpf and kernel areas that use bpf.

thanks,
-- Shuah






