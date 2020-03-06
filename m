Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08C817C8CD
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 00:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFXal (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 18:30:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34616 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFXak (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 18:30:40 -0500
Received: by mail-io1-f68.google.com with SMTP id h131so3055096iof.1
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Mar 2020 15:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DTh8zw+7j+IDCFtLjR+Et0mOTyR2UPoWt2JTjcAukIc=;
        b=cDisKuyTo87nw3pJqQk9hvVbdkNYFxtXQdHLEk4uq736TijN5izQv0HQkRuDAn3z3b
         hGeOiG1bn9l/A2uFoByc2kUW6bUdm7eomnpbgcUeWD9+kCi7ROT6y/43HteTx3XOw0IU
         Jo5ZZUXwnufbn6tsk3dgdI0PGvS3XNF7c7Ptc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DTh8zw+7j+IDCFtLjR+Et0mOTyR2UPoWt2JTjcAukIc=;
        b=UnHLq4TMdEmy0SPjuqYu0nVPjQySGocZKoMA/vriMCRov/+CYgAZdGPj785pkv7GQ9
         JQKXbpNVzlCga2dWLRk8yt5kN2xPejDkGMtP+XERmZGTAkbHm+Wcxu+IM+CW3prPrpQl
         3uES73nKdnPYPv3O5QohcjHA3SUZ0ZAHRKexv7bv4eV86kAHk4XS9Ip4562tSk6g4lSS
         gxsplSDne1pZJvW896jcLDthlMlln7EAFG2XFLLxe0rTkPTmcibZCEvG3FZYGRbkJKJ6
         BIbt5kzbARtZGDIUPa1KpOHNPOdxasj7ae3/OZMPwv7BvV3QXxkAaVqfPe1PPsiGR8W+
         pE1Q==
X-Gm-Message-State: ANhLgQ1S3fOT0gsYhvWndqirXqamUd7OwgMT7K5WNWzU2crv7LBNWUJ9
        oB0T4D3CpbOj8jrw5hgZo+8TOA==
X-Google-Smtp-Source: ADFU+vucaJCUAOUde7BMNayW6hKwEG38t9bs/LUK8plFPP+72ZPjXXZ1hR47RpnTyg0n1SFaFDeMOA==
X-Received: by 2002:a6b:c742:: with SMTP id x63mr4991083iof.162.1583537439669;
        Fri, 06 Mar 2020 15:30:39 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s2sm8304999iod.12.2020.03.06.15.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 15:30:39 -0800 (PST)
Subject: Re: kselftest selftest issues and clarifications
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <MWHPR13MB0895B92C9B4807D94E1E6B04FDE30@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f1f991a6-6e05-6ba3-b5c1-174b93029a99@linuxfoundation.org>
Date:   Fri, 6 Mar 2020 16:30:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <MWHPR13MB0895B92C9B4807D94E1E6B04FDE30@MWHPR13MB0895.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/6/20 12:49 PM, Bird, Tim wrote:
> 
>> -----Original Message-----
>> From: Shuah Khan
>>
>> On 2/28/20 10:50 AM, Bird, Tim wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From:  Shuah Khan
>>>>
>>>> Integrating Kselftest into Kernel CI rings depends on Kselftest build
>>>> and install framework to support Kernel CI use-cases. I am kicking off
>>>> an effort to support Kselftest runs in Kernel CI rings. Running these
>>>> tests in Kernel CI rings will help quality of kernel releases, both
>>>> stable and mainline.
>>>>
>>>> What is required for full support?
>>>>
>>>> 1. Cross-compilation & relocatable build support
>>>> 2. Generates objects in objdir/kselftest without cluttering main objdir
>>>> 3. Leave source directory clean
>>>> 4. Installs correctly in objdir/kselftest/kselftest_install and adds
>>>>       itself to run_kselftest.sh script generated during install.
>>>>
>>>> Note that install step is necessary for all files to be installed for
>>>> run time support.
>>>>
>>>> I looked into the current status and identified problems. The work is
>>>> minimal to add full support. Out of 80+ tests, 7 fail to cross-build
>>>> and 1 fails to install correctly.
>>>>
>>>> List is below:
>>>>
>>>> Tests fails to build: bpf, capabilities, kvm, memfd, mqueue, timens, vm
>>>> Tests fail to install: android (partial failure)
>>>> Leaves source directory dirty: bpf, seccomp
>>>>
>>>> I have patches ready for the following issues:
>>>>
>>>> Kselftest objects (test dirs) clutter top level object directory.
>>>> seccomp_bpf generates objects in the source directory.
>>>>
>>>> I created a topic branch to collect all the patches:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kernelci
>>>>
>>>> I am going to start working on build problems. If anybody is
>>>> interested in helping me with this effort, don't hesitate to
>>>> contact me. I first priority is fixing build and install and
>>>> then look into tests that leave the source directory dirty.
>>>
>>> I'm interested in this.  I'd like the same cleanups in order to run
>>> kselftest in Fuego, and I can try it with additional toolchains
>>> and boards.  Unfortunately, in terms of running tests, almost all
>>> the boards in my lab are running old kernels.  So the tests results
>>> aren't useful for upstream work.  But I can still test
>>> compilation and install issues, for the kselftest tests themselves.
>>>
>>
>> Testing compilation and install issues is very valuable. This is one
>> area that hasn't been test coverage compared to running tests. So it
>> great if you can help with build/install on linux-next to catch
>> problems in new tests. I am finding that older tests have been stable
>> and as new tests come in, we tend to miss catching these types of
>> problems.
>>
>> Especially cross-builds and installs on arm64 and others.
> 
> OK.  I've got 2 different arm64 compilers, with wildly different SDK setups,
> so hopefully this will be useful.
> 
>>>>
>>>> Detailed report can be found here:
>>>>
>>>> https://drive.google.com/file/d/11nnWOKIzzOrE4EiucZBn423lzSU_eNNv/view?usp=sharing
>>>
>>> Is there anything you'd like me to look at specifically?  Do you want me to start
>>> at the bottom of the list and work up?  I could look at 'vm' or 'timens'.
>>>
>>
>> Yes you can start with vm and timens.
> 
> I wrote a test for Fuego and ran into a few interesting issues.  Also, I have a question
> about the best place to start, and your preference for reporting results.  Your feedback
> on any of this would be appreciated:
> 
> Here are some issues and questions I ran into:
> 1) overwriting of CC in lib.mk
> This line in tools/testing/selftests/lib.mk caused me some grief:
> CC := $(CROSS_COMPILE)gcc
> 

Odd. It was added to mimic the top-level Makefile. I haven't seen
problems with this so far. I am using the following:

gcc-9-aarch64-linux-gnu 9.2.1-9ubuntu2cross1


> One of my toolchains pre-defines CC with a bunch of extra flags, so this didn't work for
> that tolchain.
> I'm still debugging this.  I'm not sure why the weird definition of CC works for the rest
> of the kernel but not with kselftest.  But I may submit some kind of patch to make this
> CC assignment conditional (that is, only do the assignment if it's not already defined)
> Let me know what you think.
> 
> 2) ability to get list of targets would be nice
> It would be nice if there were a mechanism to get the list of default targets from
> kselftest.  I added the following for my own tests, so that I don't have to hard-code
> my loop over the individual selftests:
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 63430e2..9955e71 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -246,4 +246,7 @@ clean:
>   		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
>   	done;
>   
> +show_targets:
> +	@echo $(TARGETS)
> +
>   .PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
> 
> This is pretty simple.  I can submit this as a proper patch, if you're willing to take
> something like it, and we can discuss details if you'd rather see this done another way.

Looks good to me. Please send the patch.

> 
> 3) different ways to invoke kselftest
> There are a number of different ways to invoke kselftest.  I'm currently using the
> '-C' method for both building and installing.
> make ARCH=$ARCHITECTURE TARGETS="$target" -C tools/testing/selftests
> make ARCH=$ARCHITECTURE TARGETS="$target" -C tools/testing/selftests install

Why not use make kselftes-install? I am asking people to move to the
following if at all possible. Since you are just starting out, please
use "kselftest-install" target from main Makefile instead.

This is what I am using:

make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
      CROSS_COMPILE=aarch64-linux-gnu- TARGETS=$target


> 
> I think, there there are now targets for kselftest in the top-level Makefile.
> Do you have a preferred method you'd like me to test?  Or would you like
> me to run my tests with multiple methods?

See above.

> 
> And I'm using a KBUILD_OUTPUT environment variable, rather than O=.
> Let me know if you'd like me to build a matrix of these different build methods.
> 

This is fine. Please note that relative paths don't work in both of
these. Something I will tackle once the bugger problems are addressed.

> 4) what tree(s) would you like me to test?

linux-next and Linus's mainline, and stable releases. Hey you asked :)
linux-next will catch any problems introduced in kselftest commits.

> I think you mentioned that you'd like to see the tests against 'linux-next'.
> Right now I've been doing tests against the 'torvalds' mainline tree, and
> the 'linux-kselftest' tree, master branch.  Let me know if there are other
> branches or trees you like me to test.
> 

linux-next will catch any problems introduced in kselftest fixes
and next. This will also catch selftests coming in through all
other trees. Please note that selftests flow through subsystem trees
for dependencies linux-next is catch all. If you can test only one,
please pick linux-next

As a temporary measure you can test linux-kselftest kernelci branch
where I am staging all the fix to related to Kselftest integration
into Kernel CI

> 5) where would you like test results?
> In the short term, I'm testing the compile and install of the tests
> and working on the ones that fail for me (I'm getting 17 or 18
> failures, depending on the toolchain I'm using, for some of my boards).
> However, I'm still debugging my setup, I hope I can drop that down
> to the same one's you are seeing shortly.
>  > Longer-term I plan to set up a CI loop for these tests for Fuego, and 
publish some
> kind of matrix results and reports on my own server (https://birdcloud.org/)
> I'm generating HTML tables now that work with Fuego's Jenkins
> configuration, but I could send the data elsewhere if desired.
> 

This is fine. Please see below on centralizing reports on Kernel CI
if we can.

> This is still under construction.  Would you like me to publish results also to
> kcidb, or some other repository?  I might be able to publish my
> results to Kernelci, but I'll end up with a customized report for kselftest,
> that will allow drilling down to see output for individual compile or
> install failures.  I'm not sure how much of that would be supported in
> the KernelCI interface.  But I recognize you'd probably not like to
> have to go to multiple places to see results.
> 

Yup. One place will be great. Maybe we can make Kernel CI as the central
location as we move forward. Kevin can weigh on on this.

> Also, in terms of periodic results do you want any e-mails
> sent to the Linux-kselftest list?  I thought I'd hold off for now,
> and wait for the compile/install fixes to settle down, so that
> future e-mails would only report regressions or issues with new tests.
> We can discuss this later, as I don't plan to do this quite
> yet (and would only do an e-mail after checking with you anyway).
> 

You can send them to linux-kselftest mailing list like LKFT does.
Start sending reports and we can refine the reporting as we go along.

Thank you for helping with this. This will help catch problems early and
help me get Kselftest integrated into Kernel CI quickly.

> 
> P.S. Also, please let me know who is working on this on the KernelCI
> side (if it's not Kevin), so I can CC them on future discussions.
> 

Yes please. I have the same request.

thanks,
-- Shuah
