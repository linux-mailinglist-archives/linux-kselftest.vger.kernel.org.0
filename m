Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16FA10B3E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 17:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfK0QxM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 11:53:12 -0500
Received: from foss.arm.com ([217.140.110.172]:50170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfK0QxM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 11:53:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E84D30E;
        Wed, 27 Nov 2019 08:53:11 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81B83F6C4;
        Wed, 27 Nov 2019 08:53:10 -0800 (PST)
Subject: Re: kselftest: failed to build with -C tool/testing/selftests when
 KBUILD_OUTPUT is set
To:     shuah <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Tim.Bird@sony.com,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <8d34a9b9-f8f3-0e37-00bf-c342cf3d4074@arm.com>
 <8736ea2cty.fsf@mpe.ellerman.id.au>
 <47e09faa-a3fb-04a7-4989-4443b27f47c2@arm.com>
 <8bd66a2d-e92f-6108-77d0-91d737df9b0d@kernel.org>
 <c0d01c8f-1a40-e491-28e8-e93f8f90c874@arm.com>
 <cf2ac53a-4547-0df7-52df-ef0ff4ffb453@kernel.org>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <3f436c1b-1921-78f7-c021-9c8472e24733@arm.com>
Date:   Wed, 27 Nov 2019 16:53:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cf2ac53a-4547-0df7-52df-ef0ff4ffb453@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27/11/2019 16:42, shuah wrote:
> On 11/27/19 9:23 AM, Cristian Marussi wrote:
>> On 27/11/2019 16:04, shuah wrote:
>>> On 11/27/19 3:54 AM, Cristian Marussi wrote:
>>>> Hi
>>>>
>>>> On 27/11/2019 03:54, Michael Ellerman wrote:
>>>>> Cristian Marussi <cristian.marussi@arm.com> writes:
>>>>>> Hi
>>>>>>
>>>>>> while testing on linux-next
>>>>>>
>>>>>> I see that, when KBUILD_OUTPUT is set in the env, running something like (using TARGETS=exec as a random subsystem here...)
>>>>>>
>>>>>> $ make TARGETS=exec INSTALL_PATH=/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_next kselftest-install
>>>>>>
>>>>>> works fine as usual, WHILE the alternative invocation (still documented in Documentation/dev-tools/kselftest.rst)
>>>>>>
>>>>>> make -C tools/testing/selftests/ TARGETS=exec INSTALL_PATH=/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_next install
>>>>>>
>>>>>> fails miserably with:
>>>>>> ...
>>>>>> ...
>>>>>>    REMOVE  usr/include/rdma/cxgb3-abi.h usr/include/rdma/nes-abi.h
>>>>>>     HDRINST usr/include/asm/kvm.h
>>>>>>     INSTALL /kselftest/usr/include
>>>>>> mkdir: cannot create directory ‘/kselftest’: Permission denied
>>>>>> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1187: recipe for target 'headers_install' failed
>>>>>> make[2]: *** [headers_install] Error 1
>>>>>>
>>>>>>
>>>>>> This is fixed by unsetting KBUILD_OUTPUT OR reverting:
>>>>>>
>>>>>> 303e6218ecec (ksft/fixes) selftests: Fix O= and KBUILD_OUTPUT handling for relative paths
>>>>>>
>>>>>> since bypassing top makefile with -C, the definition of abs-objtree used by the above patch
>>>>>> is no more available.
>>>>>>
>>>>>> As a side effect when KBUILD_OUTPUT is set, this breaks also the usage kselftest_install.sh.
>>>>>>
>>>>>>    $ ./kselftest_install.sh /home/crimar01/ARM/dev/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_full_next
>>>>>> ./kselftest_install.sh: Installing in specified location - /home/crimar01/ARM/dev/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_full_next ...
>>>>>> make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>>>>>> 	ARCH=arm64 -C ../../.. headers_install
>>>>>> make[1]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/linux'
>>>>>> make[2]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
>>>>>>     INSTALL /kselftest/usr/include
>>>>>> mkdir: cannot create directory ‘/kselftest’: Permission denied
>>>>>> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1187: recipe for target 'headers_install' failed
>>>>>> make[2]: *** [headers_install] Error 1
>>>>>> make[2]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
>>>>>> Makefile:179: recipe for target 'sub-make' failed
>>>>>> make[1]: *** [sub-make] Error 2
>>>>>> make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/linux'
>>>>>> Makefile:142: recipe for target 'khdr' failed
>>>>>> make: *** [khdr] Error 2
>>>>>>
>>>>>>
>>>>> ...
>>>>>> Any thoughts ? ... or am I missing something ?
>>>>>
>>>>> You're not missing anything, this is broken.
>>>> Thanks for the feedback !
>>>>
>>>> Cristian
>>>>
>>>>>
>>>>>> (I think I'm starting to see this in latest CI linaro kselftest while they cross-compile for arm64)
>>>>>
>>>>> It just hit my travis jobs when I merged up to master:
>>>>>
>>>>>     https://travis-ci.org/linuxppc/linux/jobs/617482001
>>>>>
>>>>> Shuah can we please get this reverted?
>>>>>
>>>
>>> I will take care of this. Supporting all these use-cases has been
>>> maintenance problem. Fixing one use-case breaks another. :(
>>>
>>> I will look into fixing this once for all.
>>
>> Thanks.
>>
>> In fact all of the above works fine with the new kselftest-install target you added recently
>> but I think a lot of CI is still using the old -C method.
>>
>> Regards
> 
> If all of the above works with kselftest-install target, I would rather
> ask for CI's to change, so we can get rid of make -C usage for install.
> 
> In which case, I would rather not revert this and request CIs to start
> using kselftest-install target.
> 
> 
> I would like to see CI's use kselftest-* targets from the main makefile
> for build/run/install.
> 
> It has been very difficult to support "make -C" use-cases in general
> and especially for install and relocatable builds.
> 

Well I'm not sure if it covers all the build cases/scenario for CIs and I have
only verified that this specific failure seems to work using the toplevel Makefile
targets (since the offending commit uses abs-objtree). 
Anyway $ ./kselftest_install.sh is broken too as of now.

Thanks

Cristian

> thanks,
> -- Shuah
> 

