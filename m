Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDBE1C1B51
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgEARLm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 13:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbgEARLm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 13:11:42 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D0520857;
        Fri,  1 May 2020 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588353101;
        bh=WacCN/Oz3FfWXAtl9ZPGc7vScq7nB5CuG218xrDN1ec=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wUGrqrGuByK8Iq+aQhf5BTao7flxposRXqEmjYSGNiTh9u4Ku8B4qzg2sxzELZd94
         jX0Mt2N18gmRpeTr6N+UQxCGVGyQu2aULcnknFKEEs2fu6atnjc9w8WYurDab0dDa1
         O9JWXPdm3WpXF1+nkDjuRTl6+6hq0Mdv3hK64/w4=
Subject: Re: [RFC v3 0/3] Fix errors when try to build kvm selftests on
 specified output
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200326030750.173972-1-xiaoyao.li@intel.com>
 <41d5d89e-79c2-6f7d-de3e-ca3255e910e8@kernel.org>
 <cb445047-ab84-0c49-cfba-ec6933971dc7@intel.com>
 <71a5abdf-07b5-d927-1a08-de8019b3f39f@kernel.org>
 <77ad35cf-6332-9381-200e-40b6a3d18070@intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <920ea28b-5c36-75dc-ec51-d501a0322f50@kernel.org>
Date:   Fri, 1 May 2020 11:11:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <77ad35cf-6332-9381-200e-40b6a3d18070@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/28/20 2:51 AM, Xiaoyao Li wrote:
> On 3/28/2020 12:03 AM, shuah wrote:
>> On 3/27/20 7:31 AM, Xiaoyao Li wrote:
>>> On 3/27/2020 4:57 AM, shuah wrote:
>>>> On 3/25/20 9:07 PM, Xiaoyao Li wrote:
>> The patches you sent are based on running the command with OUTPUT
>> set. 
> 
> The issues are also there when I use
> 
>    make O=/somewher TARGETS=kvm
> 
> from tools/testing/selftests/ directory,
> 
> Is it the right usecase?
> 
>> That is why I am asking you start with the right use-cases,
>> and gave you pointers on tests to refer to that have sub-dirs
>> and handle relocatable builds:
>>
>> futex
>> arm64
>> android
> 
> I have read the Makefile in futex, arm64, android to learn how they
> deal with subdir, they have Makefile in subdir but kvm doesn't.
> 
> I just want to create the subdir as easy as possible, so I follow the 
> method how to create subdir for LIBKVM_OBJ in kvm.
> 
> If you dislike it way you can reply it Patch 1 to disclaim clear what 
> you want to fix the subdir.
> 
>>>> Also, just build isn't sufficient for you to be able to run the
>>>> tests.
>>>>
>>>> make kselftest-install O=/path/to/mydir TARGETS=kvm will generate
>>>> run script.
>>>
>>> This command also has the x86_64 directory not created issue.
>>> Since it generates header files in kernel_src/usr/include, it doesn't 
>>> have headers path issue. But as result, the kernel_src directory is 
>>> not clean, this requires me to run "make mrproper", I *really* don't 
>>> like it.
>>>
>>>
>>
>> If the test leverages lib.mk headers install logic correctly, you
>> shouldn't see this problem.
>>
>> Yes. It does make the source directory dirty. That is the problem we
>> have to fix. I am seeing issues the issue of x86_64 not being created
>> in the case of relocatable builds.
>>
>> Thanks for working on this by the way. It is one of the tests that
>> identified as the one doesn't support relocatable builds.
>>
>> You will see fixes to others I already fixed in
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next 
>>
>>
>> Start withe the following use0-cases to fix and then test your fixes
>> for these use-cases. The goal is to be able to run kvm from target
>> directory and source directory staying clean.
>>
>> You will have to build the kernel first in all of these cases.
>> Let's use kselftest-install which is what you would need if you
>> want build and then run tests later. Also assuming you are doing
>> native build on x86_64.
>>
>>  From main kernel Makefile: (from kernel source root dir)
>>
>> Builds in the same source directory:
>> make kselftest-install TARGETS=kvm
>>
>> Relocatable build: (from kernel source root dir)
>>
>> make O=/path/objdir  - build kernel
>> make kselftest-install O=/path/objdir TARGETS=kvm
> 
> I don't want to build kernel at all.
> 
>>  From tools/testing/selftests/kvm directory:
>> make O=/path/objdir install
> 
> Oh no. This needs to define INSTALL_PATH, and I don't want to install.
> I just want to build the testcase of kvm to anywhere else to make srcdir 
> clean.
> 
> Besides this command make both kernel src and selftest/kvm dirty.
> 
>> Install step is important especially for relocatable builds,
>> as it makes sure all run-time dependencies are copied to the
>> target directory.
>>
> 
> OK.
> 
> So, again.
> 
> is
> 
>    make O=/tmp/kvm-selftest -C tools/testing/selftests \
>         TARGETS=kvm install INSTALL_PATH=/home/lxy/kvm-selftest
> 
> the right command for me to start on?
> 

Sorry for the delay. Yes the above command will work. Please check

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git 
next branch

I fixed kvm build/cross-build problems and applied it to next for
testing.

https://patchwork.kernel.org/patch/11513471/

thanks,
-- Shuah
