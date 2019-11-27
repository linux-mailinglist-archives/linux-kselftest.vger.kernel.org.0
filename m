Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A682110B2E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfK0QEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 11:04:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0QEH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 11:04:07 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 356D620659;
        Wed, 27 Nov 2019 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574870646;
        bh=2Xms2YVrCNl2SkvH45py4ER78AkaD4YCXjSRoXsbaIo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=fFUIRvrd+4oAaS4jKlgB7zu2yHU68olI8+CDaiKQqhHCUHVDEe6Am9jSqSMDJnWHt
         BpydxB35/6jHkjIgY0Mp4Q6LTXHZZqMdgQu/1XTuqDa04PO/m43aaEyqhqGtZZi9w6
         Zri/O+xj/Hzzbi4UhLZte8IHIHEeXFQOkr0sebbg=
Subject: Re: kselftest: failed to build with -C tool/testing/selftests when
 KBUILD_OUTPUT is set
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Tim.Bird@sony.com,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <8d34a9b9-f8f3-0e37-00bf-c342cf3d4074@arm.com>
 <8736ea2cty.fsf@mpe.ellerman.id.au>
 <47e09faa-a3fb-04a7-4989-4443b27f47c2@arm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <8bd66a2d-e92f-6108-77d0-91d737df9b0d@kernel.org>
Date:   Wed, 27 Nov 2019 09:04:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <47e09faa-a3fb-04a7-4989-4443b27f47c2@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/27/19 3:54 AM, Cristian Marussi wrote:
> Hi
> 
> On 27/11/2019 03:54, Michael Ellerman wrote:
>> Cristian Marussi <cristian.marussi@arm.com> writes:
>>> Hi
>>>
>>> while testing on linux-next
>>>
>>> I see that, when KBUILD_OUTPUT is set in the env, running something like (using TARGETS=exec as a random subsystem here...)
>>>
>>> $ make TARGETS=exec INSTALL_PATH=/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_next kselftest-install
>>>
>>> works fine as usual, WHILE the alternative invocation (still documented in Documentation/dev-tools/kselftest.rst)
>>>
>>> make -C tools/testing/selftests/ TARGETS=exec INSTALL_PATH=/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_next install
>>>
>>> fails miserably with:
>>> ...
>>> ...
>>>   REMOVE  usr/include/rdma/cxgb3-abi.h usr/include/rdma/nes-abi.h
>>>    HDRINST usr/include/asm/kvm.h
>>>    INSTALL /kselftest/usr/include
>>> mkdir: cannot create directory ‘/kselftest’: Permission denied
>>> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1187: recipe for target 'headers_install' failed
>>> make[2]: *** [headers_install] Error 1
>>>
>>>
>>> This is fixed by unsetting KBUILD_OUTPUT OR reverting:
>>>
>>> 303e6218ecec (ksft/fixes) selftests: Fix O= and KBUILD_OUTPUT handling for relative paths
>>>
>>> since bypassing top makefile with -C, the definition of abs-objtree used by the above patch
>>> is no more available.
>>>
>>> As a side effect when KBUILD_OUTPUT is set, this breaks also the usage kselftest_install.sh.
>>>
>>>   $ ./kselftest_install.sh /home/crimar01/ARM/dev/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_full_next
>>> ./kselftest_install.sh: Installing in specified location - /home/crimar01/ARM/dev/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_full_next ...
>>> make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>>> 	ARCH=arm64 -C ../../.. headers_install
>>> make[1]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/linux'
>>> make[2]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
>>>    INSTALL /kselftest/usr/include
>>> mkdir: cannot create directory ‘/kselftest’: Permission denied
>>> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1187: recipe for target 'headers_install' failed
>>> make[2]: *** [headers_install] Error 1
>>> make[2]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
>>> Makefile:179: recipe for target 'sub-make' failed
>>> make[1]: *** [sub-make] Error 2
>>> make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/linux'
>>> Makefile:142: recipe for target 'khdr' failed
>>> make: *** [khdr] Error 2
>>>
>>>
>> ...
>>> Any thoughts ? ... or am I missing something ?
>>
>> You're not missing anything, this is broken.
> Thanks for the feedback !
> 
> Cristian
> 
>>
>>> (I think I'm starting to see this in latest CI linaro kselftest while they cross-compile for arm64)
>>
>> It just hit my travis jobs when I merged up to master:
>>
>>    https://travis-ci.org/linuxppc/linux/jobs/617482001
>>
>> Shuah can we please get this reverted?
>>

I will take care of this. Supporting all these use-cases has been
maintenance problem. Fixing one use-case breaks another. :(

I will look into fixing this once for all.

thanks,
-- Shuah
