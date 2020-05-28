Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3B1E6F7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 00:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437200AbgE1Wri (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 18:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437206AbgE1Wri (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 18:47:38 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3401C08C5C7
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 15:47:36 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z3so485656otp.9
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iucF+XxSRBLYcfQrxrBiIV/r1JDIabQhNyHCFDWj5Ts=;
        b=Pub6aMrPPbkqE6SRc8bozaOdSS6V2+jLPIWxoVxkCH786gilHSR0RmPYNYZmHq+a6S
         M9iuW5gLBWgm22JdX8eM1gXNSa9l9a+l8YKOALWHA7GWsNfmkBBmAilj66/GTQvlzWRt
         wpFqcyQIsoBvBpqK3abePdlVrM2JW0oijsVc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iucF+XxSRBLYcfQrxrBiIV/r1JDIabQhNyHCFDWj5Ts=;
        b=rROz27dUFIHg5c1jblz1ikoWE8KN2vBppLKiM4yL20On+9iplEUaqFiy9nLifkxKvS
         5w3ELmhRVDxZFEsQRcqzinKeSODs7in+Aw/lWTfV50tjrJbAJNFcioHmFPqVM/6sGgX/
         qQYsrq3HEXPNsrwz2RECr4BjSffW/93my/sXxbmTGbfvgB1TWXtBlKvaB4DhxOWhFV8n
         19fCADuPVab0shPOnOxhCU3hOgIKR6Tuw8Yls6qXtHRiCRO57FvPXbd/be0tFywoz2c9
         TXBYVmBTheg2o80x14oFJXqwfQ2NKUq6ndMWVwZlG0cdm2CRLmC9NY5RyMJbmICGuiVj
         ofSw==
X-Gm-Message-State: AOAM532GK6daT33Umaa4n2w6G194sbparo9XRO0eIAJSuKwcpA+Elqsq
        tvxo1t5Nu0nbtkMj2oHo08bKDA==
X-Google-Smtp-Source: ABdhPJz7SiPtKei1ckcd7pSLVrn4FDZ/sOl4YCjhNF/9j6F8a7vwEtObSCrRD12Vc148jSqXj27kmA==
X-Received: by 2002:a9d:2049:: with SMTP id n67mr3568747ota.177.1590706055989;
        Thu, 28 May 2020 15:47:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t2sm1999919otq.54.2020.05.28.15.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 15:47:35 -0700 (PDT)
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
        <linux-kselftest@vger.kernel.org>, skhan@linuxfoundation.org
References: <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
 <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com> <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <be0a24f4-8602-ba1b-6ca4-7308b01d7a48@linuxfoundation.org>
 <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com>
 <69d6eb73-ad59-53b9-4712-537a80bcefd7@linuxfoundation.org>
 <20200528191855.flqcm4zlyrvih5r4@ast-mbp.dhcp.thefacebook.com>
 <91af28bd-6f86-97d7-49bc-5b3e1be448e1@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1ae97f52-fda0-ab1a-a027-d191e5a22858@linuxfoundation.org>
Date:   Thu, 28 May 2020 16:47:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <91af28bd-6f86-97d7-49bc-5b3e1be448e1@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/28/20 2:09 PM, Shuah Khan wrote:
> On 5/28/20 1:18 PM, Alexei Starovoitov wrote:
>> On Thu, May 28, 2020 at 12:59:06PM -0600, Shuah Khan wrote:
>>> On 5/28/20 12:15 PM, Alexei Starovoitov wrote:
>>>> On Thu, May 28, 2020 at 11:07:09AM -0600, Shuah Khan wrote:
>>>>> On 5/28/20 10:14 AM, Alexei Starovoitov wrote:
>>>>>> On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
>>>>>>> On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
>>>>>>>> On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
>>>>>>>>> I prefer to keep selftests/bpf install broken.
>>>>>>>>> This forced marriage between kselftests and selftests/bpf
>>>>>>>>> never worked well. I think it's a time to free them up from 
>>>>>>>>> each other.
>>>>>>>>
>>>>>>>> Alexei, it would be great if you could cooperate with other people
>>>>>>>> instead of pushing your own way. The selftests infrastructure 
>>>>>>>> was put
>>>>>>>> to the kernel to have one place for testing. Inventing yet 
>>>>>>>> another way
>>>>>>>> to add tests does not help anyone. You don't own the kernel. We're
>>>>>>>> community, we should cooperate.
>>>>>>>
>>>>>>> I agree, we rely on the infrastructure of the kselftests 
>>>>>>> framework so
>>>>>>> that testing systems do not have to create "custom" frameworks to 
>>>>>>> handle
>>>>>>> all of the individual variants that could easily crop up here.
>>>>>>>
>>>>>>> Let's keep it easy for people to run and use these tests, to not 
>>>>>>> do so
>>>>>>> is to ensure that they are not used, which is the exact opposite 
>>>>>>> goal of
>>>>>>> creating tests.
>>>>>>
>>>>>> Greg,
>>>>>>
>>>>>> It is easy for people (bpf developers) to run and use the tests.
>>>>>> Every developer runs them before submitting patches.
>>>>>> New tests is a hard requirement for any new features.
>>>>>> Maintainers run them for every push.
>>>>>>
>>>>>> What I was and will push back hard is when other people (not bpf 
>>>>>> developers)
>>>>>> come back with an excuse that some CI system has a hard time 
>>>>>> running these
>>>>>> tests. It's the problem of weak CI. That CI needs to be fixed. Not 
>>>>>> the tests.
>>>>>> The example of this is that we already have github/libbpf CI that 
>>>>>> runs
>>>>>> selftests/bpf just fine. Anyone who wants to do another CI are 
>>>>>> welcome to copy
>>>>>> paste what already works instead of burdening people (bpf 
>>>>>> developers) who run
>>>>>> and use existing tests. I frankly have no sympathy to folks who 
>>>>>> put their own
>>>>>> interest of their CI development in front of bpf community of 
>>>>>> developers.
>>>>>> The main job of CI is to help developers and maintainers.
>>>>>> Where helping means to not impose new dumb rules on developers 
>>>>>> because CI
>>>>>> framework is dumb. Fix CI instead.
>>>>>>
>>>>>
>>>>> Here is what CI users are requesting:
>>>>>
>>>>> - ability to install bpf test with other selftests using kselftest
>>>>>     install. The common framework is in place and with minor changes
>>>>>     to bpf test Makefile, we can make this happen. Others and myself
>>>>>     are willing to work on this, so we can get bpf test coverage in
>>>>>     test rings.
>>>>
>>>> so you're saying that bpf maintainers and all bpf developers now
>>>> would need to incorporate new 'make install' step to their workflow
>>>> because some unknown CI system that is not even functional decided
>>>> to do 'make install' ?
>>>> That's exactly my point about selfish CI developers who put their
>>>> needs in front of bpf community of developers.
>>>>
>>>
>>> There is no need change bpf maintainer and developer workflow. You
>>> don't have to use install option. Kselftest framework doesn't
>>> require a specific workflow and you can:
>>>
>>> 1. Build and run your tests from bpf directory if you choose to
>>> 2. Install to run on different target.
>>>
>>> Adding install install option requires a change to bpf Makefile
>>> only to copy test that are built to install directory.
>>>
>>> make kselftest-install from the main kernel Makefile in conjunction
>>> with selftests Makefile and lib.mk will handle all of that.
>>>
>>> Sounds like there is a misunderstanding that bpf maintainer/developer
>>> workflow will have to change to support install. That is not the case.
>>> The reason kselftest exists on the first place is to have common
>>> framework to take care of build/run/install as a common layer so
>>> individual test writers don't have to worry about these details
>>> and write tests instead.
>>
>> I don't think you understand the 'make install' implications.
>> Not doing 'make install' means that all the Makefile changes that
>> Yauheni is proposing will immediately bit rot.
>> People are constantly adding new tests and changing makefile.
>> 'make install' _will_ be broken instantly unless _humans_ incorporate
>> it in their patch development process and maintainer incorporate
>> that step into their workflow as well.
>>
> 
> I don't think so. I think if you want to work with us on this, we can
> find a way. bpf isn't such a unique test that adding install will break
> it.
> 
>> Ohh, but don't worry about this broken 'make install' is not an answer.
>> It's broken now and I don't want to see patches that move it
>> from one broken state into another broken state and at the same time
>> add complexity to it.
>>
> 
> Well! What you are saying "I don;t want to collaborate to find a
> solution to the problem".
> 
>> That's very different from 'make install' doing 'cp -r' of the whole dir.
>> In such case the chances of it going stale and broken are much lower.
>>
>>>>> - be able to build and run existing tests without breaking the test
>>>>>     build when new tests are added that have hard dependency on new
>>>>>     versions of tools (llvm etc.). This isn't such a novel idea. We
>>>>>     don't break kernel builds every single release and even when we
>>>>>     require newer compiler releases. Plan the new tests with the 
>>>>> intent
>>>>>     to not break existing users and add new tests at the same time.
>>>>>     We use min rev and not bleeding edge as the requirement for kernel
>>>>>     build.
>>>>
>>>> 'existing users'?
>>>
>>> I said existing tests not users. When you add new bpf tests, existing
>>> tests should continue to build and run without dependency on new revs
>>> of llvm.
>>
>> Who said that existing test stop building with new llvm ?
>> Please check your facts.
>>
> 
> I am basing this on a previous discussion on this topic. bpf test(s)
> that build stop building and the solution always has been upgrade
> to new tool chain. If this changed now and there is no hard tie to
> bpf test building and llvm release, great.
> 
>>> If bpf test doesn't build and/or installed, it won't run
>>> on test rings that qualify stable/next/main releases.
>>
>> That's the case today and I prefer to keep it this way.
> 
> Why is that? Are you making a decision for the rest of the kernel
> with this approach? If bpf doesn't get tested in stable test rings,
> this isn't bpf problem alone. This is a kernel release issue.
> 
>> stable folks ignored our recommendations on how selftests/bpf should
>> be run, so please don't come up with your ways of doing it and
>> complain that something doesn't work.
>>
> 
> If you want to talk about history, bpf test was added in Oct 2016 and
> by then kselftest was in use with its run_tests and install support.
> So it is misleading to suggest that the framework came after the bpf
> test. bpf test was added to existing kselftest framework used  by all
> other tests. Expecting the existing framework to change and adapt to
> a new test isn't reasonable.
> 
> When a new test is added, it has to work within the framework. Framework
> can be improved and changed, however not the way you are attempting to
> do in this thread. You can do this like others in the community to do
> by making changes and improvements.
> 

In any case, kselftest framework lets you override INSTALL_RULE and
define your own. Same is true for other rules: RUN_TESTS, EMIT_TESTS,
CLEAN, INSTALL

bpf does this already for CLEAN.

# override lib.mk's default rules
OVERRIDE_TARGETS := 1
override define CLEAN

If generic install rule doesn't work for you do override so bpf so
users can install it.

thanks,
-- Shuah


