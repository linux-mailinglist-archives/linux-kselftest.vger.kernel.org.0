Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9520EBB708
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2019 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438157AbfIWOok (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 10:44:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35985 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437469AbfIWOoj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 10:44:39 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so34057068iof.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2019 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7IY3WfHR/RHwzLSdcAp2xrnv8k5NJEy3PyaVmfv4CDY=;
        b=NQ7ZNPV8IVbnPn1nKeczSvWdIziO7/LvkOpRdtfn7jjcfCmJd63EnpzPiyZak1/PA1
         PCepRjqBYRV249u0xy119RiiVRrbQnoewKvKDN2U/b/k/jXe+1AcSfJJemdKfTF/C3Ji
         rmsB1NgrpiBiQvGfWkKTemBKK4IGpSYPKY4A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7IY3WfHR/RHwzLSdcAp2xrnv8k5NJEy3PyaVmfv4CDY=;
        b=cVz9Bt7iXXVmO8ZxYVLpgJMqhjCu7C9KMNPHGWIQdY4fqOAaGjkU3ZJcKKQCZFJMgo
         zabUbEZolVI3ohIoUqnuirZ6OcIPOZ1WezxkDGwg4kAFXK8mIHcsjeYLoXctKnWd/Dix
         NQmQwGJlnmpYNRGlVp2fv6eJ2c6kkpU3X40bS63tAvMhikNk3+9R2TRAHFFhT4a+J3/i
         4stoevev8GuDfyNdHGHLgjR94eSG2NM3eKECX32U56F816QLZL/sGUgoIykedQ7GoGBy
         ptMTbaeWqYkGVH7xz50lqm1TRrpNj9vSDFKZKQ6R2zZLdxeXp2sazQjnHpUumQhsHXQR
         KdJg==
X-Gm-Message-State: APjAAAXmXCMMDHAc1LwbxcJx3DW6EquYruBb21r1IJHwhPfPnOsImBRn
        PoAFhdz3CeXwrkY8SvDPT2AqWw==
X-Google-Smtp-Source: APXvYqybAlJF5w6qEKsknpz6oEPoDndN/VoHitulS16OkFb0EfO8MLKYb6kdbgZ9Y3KL54FOS7PMgA==
X-Received: by 2002:a02:6616:: with SMTP id k22mr35837275jac.129.1569249878822;
        Mon, 23 Sep 2019 07:44:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a25sm6058452iod.62.2019.09.23.07.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 07:44:38 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com> <20190922115247.GA2679387@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0ab5da69-e4f2-8990-20f9-354461235581@linuxfoundation.org>
Date:   Mon, 23 Sep 2019 08:44:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922115247.GA2679387@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/22/19 5:52 AM, Greg KH wrote:
> On Sun, Sep 22, 2019 at 01:25:55PM +0200, Ingo Molnar wrote:
>>
>> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>>> On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
>>> <brendanhiggins@google.com> wrote:
>>>>
>>>> Sorry about that. I am surprised that none of the other reviewers
>>>> brought this up.
>>>
>>> I think I'm "special".
>>>
>>> There was some other similar change a few years ago, which I
>>> absolutely hated because of how it broke autocomplete for me. Very few
>>> other people seemed to react to it.
>>
>> FWIW, I am obsessively sensitive to autocomplete and overall source code
>> file hieararchy and nomenclature details as well, so it's not just you.
>>
>> Beyond the muscle memory aspect, nonsensical naming and inanely flat file
>> hierarchies annoy kernel developers and makes it harder for newbies to
>> understand the kernel source as well.
>>
>> The less clutter, the more organization, the better - and there's very
>> few valid technical reasons to add any new files or directories to the
>> top level directory - we should probably *remove* quite a few.
>>
>> For example 'firmware/' was recently moved to drivers/firmware/, and in a
>> similar fashion about a third of the remaining 22 directories should
>> probably be moved too:
>>
>>    drwxr-xr-x    arch
>>    drwxr-xr-x    block
>>    drwxr-xr-x    certs           # move to build/certs/ dir
>>    drwxr-xr-x    crypto          # move to kernel/crypto/ or security/crypto/
>>    drwxr-xr-x    Documentation
>>    drwxr-xr-x    drivers
>>    drwxr-xr-x    fs
>>    drwxr-xr-x    include
>>    drwxr-xr-x    init
>>    drwxr-xr-x    ipc             # move to kernel/ipc/
>>    drwxr-xr-x    kernel
>>    drwxr-xr-x    lib
>>    drwxr-xr-x    LICENSES
>>    drwxr-xr-x    mm
>>    drwxr-xr-x    net
>>    drwxr-xr-x    samples         # move to Documentation/samples/
>>    drwxr-xr-x    scripts         # move to build/scripts/
>>    drwxr-xr-x    security
>>    drwxr-xr-x    sound           # move to drivers/sound/
>>    drwxr-xr-x    tools
>>    drwxr-xr-x    usr             # move to build/usr/
>>    drwxr-xr-x    virt            # move to the already existing drivers/virt/
>>
>>    -rw-r--r--    COPYING
>>    -rw-r--r--    CREDITS
>>    -rw-r--r--    Kbuild
>>    -rw-r--r--    Kconfig
>>    -rw-r--r--    MAINTAINERS
>>    -rw-r--r--    Makefile
>>    -rw-r--r--    README
>>
>> There's a few borderline ones:
>>
>>   - 'block' could in principle move to drivers/block/core/ but it's fine
>>     at the top level too I think.
>>
>>   - 'init' could in principle be moved to kernel/init/ - but it's not
>>     wrong at the top level either.
>>
>> The remaining top level hierarchy would look pretty sweet and short:
>>
>>    drwxr-xr-x    arch
>>    drwxr-xr-x    block
>>    drwxr-xr-x    build             # new
>>    drwxr-xr-x    Documentation
>>    drwxr-xr-x    drivers
>>    drwxr-xr-x    fs
>>    drwxr-xr-x    include
>>    drwxr-xr-x    init
>>    drwxr-xr-x    kernel
>>    drwxr-xr-x    lib
>>    drwxr-xr-x    LICENSES
>>    drwxr-xr-x    mm
>>    drwxr-xr-x    net
>>    drwxr-xr-x    security
>>    drwxr-xr-x    tools
>>
>>    -rw-r--r--    COPYING
>>    -rw-r--r--    CREDITS
>>    -rw-r--r--    Kbuild
>>    -rw-r--r--    Kconfig
>>    -rw-r--r--    MAINTAINERS
>>    -rw-r--r--    Makefile
>>    -rw-r--r--    README
>>
>> I'm volunteering to do this (in a scripted, repeatable, reviewable,
>> tweakable and "easy to execute in a quiet moment" fashion), although
>> I also expect you to balk at the churn. :-)
> 
> I for one would love the above changes.  And I'm the one that has to
> deal with all of the backporting issues that arise with stable backports :)
> 

I am exploring the possibility to move selftests to a better location
or add a git alias so it can be found easily. With the addition of KUnit
and future work that is planned to connect kselftest and KUnit, it would
make sense have selftests to be in a location that is better suited than
where it currently resides.

I have been getting feedback from some developers that they would like
to see selftests more visible and easier to find.

There are some dependencies (unintended, shouldn't exist) between some
tests and content under tools that might pose some logistical problems,
in addition to the churn of backporting.

I haven't explored "git alias" yet though. Since this topic of moving
came up, I would liek to get feedback on selftests location in general
and where would be a good place for it.

thanks,
-- Shuah

