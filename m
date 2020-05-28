Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1E1E69E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 20:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406027AbgE1S7K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 14:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406030AbgE1S7K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 14:59:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4114C08C5C7
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 11:59:08 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c3so3193040otr.12
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HHqQsghzpsUy5Y/+YMI+aY3yCNlDtB6gtSef4B8r+Dg=;
        b=U9WL+PjN6T4QwgCCxInTCydLPlY0jbG24pIkxp2OwtKVEWJP9UbM6PiXfohh0qAi76
         FlUjKukI/JUVz2w3UjRUXbYSZEc/gny+OSUCsRRtDZD5LAE5Jib9RwqIDmD6X28sv+34
         3ox25bz2xzU/uOhDoQwiN4PHXfoUcJIsqncmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HHqQsghzpsUy5Y/+YMI+aY3yCNlDtB6gtSef4B8r+Dg=;
        b=LwLLc2FJvBHsNhxrgKcFVHm9jKppYUaiOsVZt/Puk4SDWOwiLiBkHBolIbYCfN8ZEf
         dtMf5zpy6Gaa3pPE/sLTQ2XQsdNRMxAKqn2dHQZKd8fBcyXtuAfE6reYXyWtXAK5axIL
         AO/suuiV9Ou6YnT62gwQU5AB1nQfxBfrDfJKqXRTRUZz6EnaouY4H1Pfcs3dy1V+/ybI
         g/nw80ee4gVva2JQrWhAJlGfJ4C9awx3LHP8fS3CFHoLtRwz7PnSX+/eXWlbztarwd8H
         raDQYOQELtwmQub7vZH/ehQ13u2iX7QaF1CI2ZWZPXq02yd979ksnug1FjPU2zT4W1LP
         2vNA==
X-Gm-Message-State: AOAM531pOuezLN35ojR/gQodX6CmODmLBRhqwfEdIPfWpOq3QqqGQOhQ
        779WZAekwgZJt2mXRMnqArfYgw==
X-Google-Smtp-Source: ABdhPJxZDy6CgN9+IA1jxwh9xKHB9eIXUcMlVtx0MhD0K/g6SutBg+lGpSIcbTptWdm1AjTOPI165A==
X-Received: by 2002:a05:6830:14c4:: with SMTP id t4mr3466627otq.79.1590692348176;
        Thu, 28 May 2020 11:59:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x186sm1922487ooa.4.2020.05.28.11.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:59:07 -0700 (PDT)
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Benc <jbenc@redhat.com>,
        shuah <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <69d6eb73-ad59-53b9-4712-537a80bcefd7@linuxfoundation.org>
Date:   Thu, 28 May 2020 12:59:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/28/20 12:15 PM, Alexei Starovoitov wrote:
> On Thu, May 28, 2020 at 11:07:09AM -0600, Shuah Khan wrote:
>> On 5/28/20 10:14 AM, Alexei Starovoitov wrote:
>>> On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
>>>> On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
>>>>> On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
>>>>>> I prefer to keep selftests/bpf install broken.
>>>>>> This forced marriage between kselftests and selftests/bpf
>>>>>> never worked well. I think it's a time to free them up from each other.
>>>>>
>>>>> Alexei, it would be great if you could cooperate with other people
>>>>> instead of pushing your own way. The selftests infrastructure was put
>>>>> to the kernel to have one place for testing. Inventing yet another way
>>>>> to add tests does not help anyone. You don't own the kernel. We're
>>>>> community, we should cooperate.
>>>>
>>>> I agree, we rely on the infrastructure of the kselftests framework so
>>>> that testing systems do not have to create "custom" frameworks to handle
>>>> all of the individual variants that could easily crop up here.
>>>>
>>>> Let's keep it easy for people to run and use these tests, to not do so
>>>> is to ensure that they are not used, which is the exact opposite goal of
>>>> creating tests.
>>>
>>> Greg,
>>>
>>> It is easy for people (bpf developers) to run and use the tests.
>>> Every developer runs them before submitting patches.
>>> New tests is a hard requirement for any new features.
>>> Maintainers run them for every push.
>>>
>>> What I was and will push back hard is when other people (not bpf developers)
>>> come back with an excuse that some CI system has a hard time running these
>>> tests. It's the problem of weak CI. That CI needs to be fixed. Not the tests.
>>> The example of this is that we already have github/libbpf CI that runs
>>> selftests/bpf just fine. Anyone who wants to do another CI are welcome to copy
>>> paste what already works instead of burdening people (bpf developers) who run
>>> and use existing tests. I frankly have no sympathy to folks who put their own
>>> interest of their CI development in front of bpf community of developers.
>>> The main job of CI is to help developers and maintainers.
>>> Where helping means to not impose new dumb rules on developers because CI
>>> framework is dumb. Fix CI instead.
>>>
>>
>> Here is what CI users are requesting:
>>
>> - ability to install bpf test with other selftests using kselftest
>>    install. The common framework is in place and with minor changes
>>    to bpf test Makefile, we can make this happen. Others and myself
>>    are willing to work on this, so we can get bpf test coverage in
>>    test rings.
> 
> so you're saying that bpf maintainers and all bpf developers now
> would need to incorporate new 'make install' step to their workflow
> because some unknown CI system that is not even functional decided
> to do 'make install' ?
> That's exactly my point about selfish CI developers who put their
> needs in front of bpf community of developers.
> 

There is no need change bpf maintainer and developer workflow. You
don't have to use install option. Kselftest framework doesn't
require a specific workflow and you can:

1. Build and run your tests from bpf directory if you choose to
2. Install to run on different target.

Adding install install option requires a change to bpf Makefile
only to copy test that are built to install directory.

make kselftest-install from the main kernel Makefile in conjunction
with selftests Makefile and lib.mk will handle all of that.

Sounds like there is a misunderstanding that bpf maintainer/developer
workflow will have to change to support install. That is not the case.
The reason kselftest exists on the first place is to have common
framework to take care of build/run/install as a common layer so
individual test writers don't have to worry about these details
and write tests instead.

>> - be able to build and run existing tests without breaking the test
>>    build when new tests are added that have hard dependency on new
>>    versions of tools (llvm etc.). This isn't such a novel idea. We
>>    don't break kernel builds every single release and even when we
>>    require newer compiler releases. Plan the new tests with the intent
>>    to not break existing users and add new tests at the same time.
>>    We use min rev and not bleeding edge as the requirement for kernel
>>    build.
> 
> 'existing users'? 

I said existing tests not users. When you add new bpf tests, existing
tests should continue to build and run without dependency on new revs
of llvm.

CI is not a user. CI is machine that should _help_
> developers. Above two things (forcing install on humans and
> breaking day-to-day tests for bpf maintainers and developers)
> is the opposite of helping developers.
> Please do NOT use such useless CI as an excuse.
> Such CI should not be built in the first place when it slows down
> the development instead of helping it.
> 
LKFT test ring runs selftests now and Kernel CI will be soon. Various
users run selftests in their own environments. LKFT ring admins have
to build and install tests whether it is automated or not and look at
the results. If bpf test doesn't build and/or installed, it won't run
on test rings that qualify stable/next/main releases.

I don't understand why CI use-case is useless.

thanks,
-- Shuah

