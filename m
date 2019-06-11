Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DB3D694
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405348AbfFKTUr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 15:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404789AbfFKTUr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 15:20:47 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C4D22173C;
        Tue, 11 Jun 2019 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560280846;
        bh=Te0HUbWNRYnh5j1SYpfIv81oMyhEScqWC6Jk+r1Z2HQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CX3rK3Vutn3LIWV4Q+Dz0mEvp70FLRlBGXZCJrf8DzNABAY/TSVAwUSDKOAXCDW7q
         KycH1eTk4EZMvBlaXkwu4RyNxKZEstsxsnkV5lKmwx1I0DaU9KJBjoyVn2fAqgTIvr
         lx9zTycLW/iYKYnv7khgFVn5/bC2xmCSsHq9xLIg=
Subject: Re: kselftest build broken?
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org>
 <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org>
Date:   Tue, 11 Jun 2019 13:20:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/11/19 10:03 AM, Dmitry Vyukov wrote:
> On Tue, Jun 11, 2019 at 5:16 PM shuah <shuah@kernel.org> wrote:
>>
>> Hi Dmitry,
>>
>> On 6/11/19 4:30 AM, Dmitry Vyukov wrote:
>>> Hi,
>>>
>>> I've tried to build kselftests for several years now, but I always
>>> find the build broken. Which makes me wonder if the instructions are
>>> broken or something. I follow the instructions in
>>> Documentation/dev-tools/kselftest.rst and start with "make -C
>>> tools/testing/selftests". Here is the errors I get on the upstream
>>> commit 16d72dd4891fecc1e1bf7ca193bb7d5b9804c038:
>>>> error: unable to create target: 'No available targets are compatible
>>> with triple "bpf"'
>>> 1 error generated.
>>> Makefile:259: recipe for target 'elfdep' failed
>>> Makefile:156: recipe for target 'all' failed
>>> Makefile:106: recipe for target
>>> '/linux/tools/testing/selftests/bpf/libbpf.a' failed
>>> test_execve.c:4:10: fatal error: cap-ng.h: No such file or directory
>>
>> These errors are due to missing dependencies. You will need
>>
>> libmount-dev
>> libcap-ng-dev
>> libelf-dev
>>
>> for bpf to build and also clang
>>
>>> ../lib.mk:138: recipe for target
>>> '/linux/tools/testing/selftests/capabilities/test_execve' failed
>>> gpio-mockup-chardev.c:20:10: fatal error: libmount.h: No such file or directory > <builtin>: recipe for target 'gpio-mockup-chardev' failed
>>> fuse_mnt.c:17:10: fatal error: fuse.h: No such file or directory
>>
>> libfuse-dev is missing.
>>
>>> ../lib.mk:138: recipe for target
>>> '/linux/tools/testing/selftests/memfd/fuse_mnt' failed
>>> collect2: error: ld returned 1 exit status
>>> ../lib.mk:138: recipe for target
>>> '/linux/tools/testing/selftests/mqueue/mq_open_tests' failed
>>
>> Needs libpopt-dev
>>
>>> reuseport_bpf_numa.c:24:10: fatal error: numa.h: No such file or directory
>>
>> Needs libnuma-dev
>>
>>> ../lib.mk:138: recipe for target
>>> '/linux/tools/testing/selftests/net/reuseport_bpf_numa' failed
>>> mlock-random-test.c:8:10: fatal error: sys/capability.h: No such file
>>> or directory > ../lib.mk:138: recipe for target
>>> '/linux/tools/testing/selftests/vm/mlock-random-test' failed
>>>
>>> Here is full log:
>>>
>>> https://gist.githubusercontent.com/dvyukov/47430636e160f297b657df5ba2efa82b/raw/7babc4db228b88f341a376c15e8bc9c4c3b02160/gistfile1.txt
>>>
>>> I have libelf-dev installed. Do I need to install something else? Or
>>> run some other command?
>>
>> ii  libelf-dev:amd 0.170-0.4ubu amd64        libelf1 development
>> libraries and
>> ii  libelf1:amd64  0.170-0.4ubu amd64        library to read and write
>> ELF fil
>>
>>
>> All of the above built for me on Linux 5.2-rc4. Try installing all of
>> these and let me know if you still see problems.
> 
> 
> Hi Shuah,
> 
> Thanks for quick reply!
> 
> I've installed these: libmount-dev libcap-ng-dev libfuse-dev
> libpopt-dev libnuma-dev.
> libelf-dev I already had. And for clang I switched to distro-provided one.
> 
> This reduced number of errors, but I still see some:
> 
> clang: error: unable to execute command: Broken pipe
> clang: error: clang frontend command failed due to signal (use -v to
> see invocation)
> Makefile:259: recipe for target 'elfdep' failed
> Makefile:156: recipe for target 'all' failed
> Makefile:106: recipe for target
> '/linux/tools/testing/selftests/bpf/libbpf.a' failed

Getting bpf compile to work take a few steps. If I remember correctly,
You will need llvm as well. Here is what I have on my system:

ii  libllvm6.0:amd 1:6.0-1ubunt amd64        Modular compiler and 
toolchain te
ii  llvm           1:6.0-41~exp amd64        Low-Level Virtual Machine 
(LLVM)
ii  llvm-6.0       1:6.0-1ubunt amd64        Modular compiler and 
toolchain te
ii  llvm-6.0-dev   1:6.0-1ubunt amd64        Modular compiler and 
toolchain te
un  llvm-6.0-doc   <none>       <none>       (no description available)
ii  llvm-6.0-runti 1:6.0-1ubunt amd64        Modular compiler and 
toolchain te
ii  llvm-runtime   1:6.0-41~exp amd64        Low-Level Virtual Machine 
(LLVM),

> timestamping.c:249:19: error: ‘SIOCGSTAMP’ undeclared (first use in
> this function); did you mean ‘SIOCGSTAMPNS’?
> ../../lib.mk:138: recipe for target
> '/linux/tools/testing/selftests/networking/timestamping/timestamping'
> failed
> mlock-random-test.c:8:10: fatal error: sys/capability.h: No such file
> or directory

Do you have libcap-dev installed?

ii  libcap-dev:amd 1:2.25-1.2   amd64        POSIX 1003.1e capabilities 
(devel
ii  libcap-ng-dev  0.7.7-3.1    amd64        Development and header 
files for
ii  libcap-ng0:amd 0.7.7-3.1    amd64        An alternate POSIX 
capabilities l
ii  libcap2:amd64  1:2.25-1.2   amd64        POSIX 1003.1e capabilities 
(libra
ii  libcap2-bin    1:2.25-1.2   amd64        POSIX 1003.1e capabilities 
(utili
un  libcap2-dev    <none>       <none>       (no description available)

thanks,
-- Shuah
