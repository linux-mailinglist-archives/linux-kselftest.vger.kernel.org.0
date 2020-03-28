Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA13419649A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Mar 2020 09:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1Ivv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Mar 2020 04:51:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:27699 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgC1Ivv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Mar 2020 04:51:51 -0400
IronPort-SDR: m8kvRmMkW39MJBLjWsF9Jfpa4EG8Uw6SCybEJvZmxwZWd0vI/E2GWpcjvySGhyNcQPp3IH1899
 AAb3zzwbwBbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 01:51:50 -0700
IronPort-SDR: DnFNzJoKKx4pybnpmbugiNxSEoGLALF6L+Ygzs6p+mB+mGRbQu39tKO1jT86ZiXlwnsVWxtQa7
 4DLnc1OpyAjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,315,1580803200"; 
   d="scan'208";a="394616392"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.174.239]) ([10.249.174.239])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2020 01:51:48 -0700
Subject: Re: [RFC v3 0/3] Fix errors when try to build kvm selftests on
 specified output
To:     shuah <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200326030750.173972-1-xiaoyao.li@intel.com>
 <41d5d89e-79c2-6f7d-de3e-ca3255e910e8@kernel.org>
 <cb445047-ab84-0c49-cfba-ec6933971dc7@intel.com>
 <71a5abdf-07b5-d927-1a08-de8019b3f39f@kernel.org>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <77ad35cf-6332-9381-200e-40b6a3d18070@intel.com>
Date:   Sat, 28 Mar 2020 16:51:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <71a5abdf-07b5-d927-1a08-de8019b3f39f@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/28/2020 12:03 AM, shuah wrote:
> On 3/27/20 7:31 AM, Xiaoyao Li wrote:
>> On 3/27/2020 4:57 AM, shuah wrote:
>>> On 3/25/20 9:07 PM, Xiaoyao Li wrote:
> The patches you sent are based on running the command with OUTPUT
> set. 

The issues are also there when I use

   make O=/somewher TARGETS=kvm

from tools/testing/selftests/ directory,

Is it the right usecase?

> That is why I am asking you start with the right use-cases,
> and gave you pointers on tests to refer to that have sub-dirs
> and handle relocatable builds:
> 
> futex
> arm64
> android

I have read the Makefile in futex, arm64, android to learn how they
deal with subdir, they have Makefile in subdir but kvm doesn't.

I just want to create the subdir as easy as possible, so I follow the 
method how to create subdir for LIBKVM_OBJ in kvm.

If you dislike it way you can reply it Patch 1 to disclaim clear what 
you want to fix the subdir.

>>> Also, just build isn't sufficient for you to be able to run the
>>> tests.
>>>
>>> make kselftest-install O=/path/to/mydir TARGETS=kvm will generate
>>> run script.
>>
>> This command also has the x86_64 directory not created issue.
>> Since it generates header files in kernel_src/usr/include, it doesn't 
>> have headers path issue. But as result, the kernel_src directory is 
>> not clean, this requires me to run "make mrproper", I *really* don't 
>> like it.
>>
>>
> 
> If the test leverages lib.mk headers install logic correctly, you
> shouldn't see this problem.
> 
> Yes. It does make the source directory dirty. That is the problem we
> have to fix. I am seeing issues the issue of x86_64 not being created
> in the case of relocatable builds.
> 
> Thanks for working on this by the way. It is one of the tests that
> identified as the one doesn't support relocatable builds.
> 
> You will see fixes to others I already fixed in
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next 
> 
> 
> Start withe the following use0-cases to fix and then test your fixes
> for these use-cases. The goal is to be able to run kvm from target
> directory and source directory staying clean.
> 
> You will have to build the kernel first in all of these cases.
> Let's use kselftest-install which is what you would need if you
> want build and then run tests later. Also assuming you are doing
> native build on x86_64.
> 
>  From main kernel Makefile: (from kernel source root dir)
> 
> Builds in the same source directory:
> make kselftest-install TARGETS=kvm
> 
> Relocatable build: (from kernel source root dir)
> 
> make O=/path/objdir  - build kernel
> make kselftest-install O=/path/objdir TARGETS=kvm

I don't want to build kernel at all.

>  From tools/testing/selftests/kvm directory:
> make O=/path/objdir install

Oh no. This needs to define INSTALL_PATH, and I don't want to install.
I just want to build the testcase of kvm to anywhere else to make srcdir 
clean.

Besides this command make both kernel src and selftest/kvm dirty.

> Install step is important especially for relocatable builds,
> as it makes sure all run-time dependencies are copied to the
> target directory.
> 

OK.

So, again.

is

   make O=/tmp/kvm-selftest -C tools/testing/selftests \
        TARGETS=kvm install INSTALL_PATH=/home/lxy/kvm-selftest

the right command for me to start on?
