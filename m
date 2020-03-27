Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35855195A90
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Mar 2020 17:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgC0QDT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Mar 2020 12:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgC0QDT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Mar 2020 12:03:19 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A1A220716;
        Fri, 27 Mar 2020 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585324997;
        bh=buElJtB4x/XrZOgypEpMPh22nhReLA0geldePbdmD4I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=viFO5kDP/2s0/3AJx9TFLXHX6SV5+ibd4fa3+p65xOq3D6zaGzSmJwvR+YMS7agDw
         52hjxt++Nekk6rPPLyuP2m6Hqm4Jn5G1fFpMR48LAHPBT00ULt4GWgmBUIsKIc9VvH
         0WVB5OKiOkcJhJb7hWddUOndBUJwW3aaEynCjsss=
Subject: Re: [RFC v3 0/3] Fix errors when try to build kvm selftests on
 specified output
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200326030750.173972-1-xiaoyao.li@intel.com>
 <41d5d89e-79c2-6f7d-de3e-ca3255e910e8@kernel.org>
 <cb445047-ab84-0c49-cfba-ec6933971dc7@intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <71a5abdf-07b5-d927-1a08-de8019b3f39f@kernel.org>
Date:   Fri, 27 Mar 2020 10:03:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cb445047-ab84-0c49-cfba-ec6933971dc7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/27/20 7:31 AM, Xiaoyao Li wrote:
> On 3/27/2020 4:57 AM, shuah wrote:
>> On 3/25/20 9:07 PM, Xiaoyao Li wrote:
>>> Hi Shuah,
>>>
>>> Hope you're happy with this version that I only touch KVM's Makefile.
>>>
>>> I attempted to build KVM selftests on a specified dir, unfortunately
>>> neither    "make O=/path/to/mydir TARGETS=kvm" in 
>>> tools/testing/selftests, nor
>>> "make OUTPUT=/path/to/mydir" in tools/testing/selftests/kvm work.
>>>
>>
>> Why are you running "make OUTPUT=/path/to/mydir"
>>
>> It isn't correct.
> 
> So what's the meaning of
> 
> ifeq (0,$(MAKELEVEL))
>      ifeq ($(OUTPUT),)
>      OUTPUT := $(shell pwd)
>      DEFAULT_INSTALL_HDR_PATH := 1
>      endif
> endif
> 
> in lib.mk?
> 

O is the variable for selftests Makefile and which is handled in
lib.mk. OUTPUT is internal and shouldn't set when running make.

>>
>> make O=/path/to/mydir is what you have to use. Please main Makefile
>> as well for O= and KBUILD_OUTPUT usages.
>>
>> Please see Documentation/dev-tools/kselftest.rst for use-cases.
>>
>> make O=/path/to/mydir TARGETS=kvm is a right use-case and I can see
>> it will fail to create x86_64 directory.
>>
>> Let's start with the following two commands and try to fix the
>> problems you are seeing.
>>
>> make O=/path/to/mydir in kvm directory (this is supported,
>> however, the following command from the main Makefile is
>> recommended use.)
> 
> Of course we can do this, but the "O=/path/to/mydir" only has effect on 
> header install, the *.o files still generated in kvm/ directory.
> 

Right. That is what needs to be fixed. This is the reason for your
source directory getting dirty when kvm test is built.

> And kvm's INSTALL_HDR_PATH cannot find the right headers.
> 
> That's why I choose to use "OUTPUT=/somewhere"
> 
>>  From main Makefile in kernel srcdir
>> make O=/path/to/mydir TARGETS=kvm
> 
> I guess "kernel srcdir" means "kselftest srcdir", i.e., 
> tools/testing/selftests/ ?

This is kernel source root directory. The command you would
use is:

make kselftest-all O=/path/to/mydir TARGETS=kvm

> 
> Well, as I said in the first place, I tried
> 
>      make O=/path/to/mydir TARGETS=kvm
> 
> but it doesn't work. So I did some fixup, and sent out the Patches.
> 

Right. It doesn't work for a couple of reasons:

1. The Makefile doesn't create sub-dirs when build is relocatable.
2. Makes source directory dirty.

> If the patches are wrong, please point it out and give your comments how 
> to make it right.
> 

The patches you sent are based on running the command with OUTPUT
set. That is why I am asking you start with the right use-cases,
and gave you pointers on tests to refer to that have sub-dirs
and handle relocatable builds:

futex
arm64
android

>> Also, just build isn't sufficient for you to be able to run the
>> tests.
>>
>> make kselftest-install O=/path/to/mydir TARGETS=kvm will generate
>> run script.
> 
> This command also has the x86_64 directory not created issue.
> Since it generates header files in kernel_src/usr/include, it doesn't 
> have headers path issue. But as result, the kernel_src directory is not 
> clean, this requires me to run "make mrproper", I *really* don't like it.
> 
> 

If the test leverages lib.mk headers install logic correctly, you
shouldn't see this problem.

Yes. It does make the source directory dirty. That is the problem we
have to fix. I am seeing issues the issue of x86_64 not being created
in the case of relocatable builds.

Thanks for working on this by the way. It is one of the tests that
identified as the one doesn't support relocatable builds.

You will see fixes to others I already fixed in

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

Start withe the following use0-cases to fix and then test your fixes
for these use-cases. The goal is to be able to run kvm from target
directory and source directory staying clean.

You will have to build the kernel first in all of these cases.
Let's use kselftest-install which is what you would need if you
want build and then run tests later. Also assuming you are doing
native build on x86_64.

 From main kernel Makefile: (from kernel source root dir)

Builds in the same source directory:
make kselftest-install TARGETS=kvm

Relocatable build: (from kernel source root dir)

make O=/path/objdir  - build kernel
make kselftest-install O=/path/objdir TARGETS=kvm

 From tools/testing/selftests/kvm directory:
make O=/path/objdir install

Install step is important especially for relocatable builds,
as it makes sure all run-time dependencies are copied to the
target directory.

thanks,
-- Shuah
