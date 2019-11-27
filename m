Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCEC10AE3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2019 11:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfK0KyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 05:54:05 -0500
Received: from foss.arm.com ([217.140.110.172]:46132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfK0KyF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 05:54:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9269630E;
        Wed, 27 Nov 2019 02:54:04 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D86DA3F6C4;
        Wed, 27 Nov 2019 02:54:03 -0800 (PST)
Subject: Re: kselftest: failed to build with -C tool/testing/selftests when
 KBUILD_OUTPUT is set
To:     Michael Ellerman <mpe@ellerman.id.au>, Tim.Bird@sony.com,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <8d34a9b9-f8f3-0e37-00bf-c342cf3d4074@arm.com>
 <8736ea2cty.fsf@mpe.ellerman.id.au>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <47e09faa-a3fb-04a7-4989-4443b27f47c2@arm.com>
Date:   Wed, 27 Nov 2019 10:54:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8736ea2cty.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 27/11/2019 03:54, Michael Ellerman wrote:
> Cristian Marussi <cristian.marussi@arm.com> writes:
>> Hi
>>
>> while testing on linux-next
>>
>> I see that, when KBUILD_OUTPUT is set in the env, running something like (using TARGETS=exec as a random subsystem here...)
>>
>> $ make TARGETS=exec INSTALL_PATH=/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_next kselftest-install
>>
>> works fine as usual, WHILE the alternative invocation (still documented in Documentation/dev-tools/kselftest.rst)
>>
>> make -C tools/testing/selftests/ TARGETS=exec INSTALL_PATH=/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_next install
>>
>> fails miserably with:
>> ...
>> ...
>>  REMOVE  usr/include/rdma/cxgb3-abi.h usr/include/rdma/nes-abi.h
>>   HDRINST usr/include/asm/kvm.h
>>   INSTALL /kselftest/usr/include
>> mkdir: cannot create directory ‘/kselftest’: Permission denied
>> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1187: recipe for target 'headers_install' failed
>> make[2]: *** [headers_install] Error 1
>>
>>
>> This is fixed by unsetting KBUILD_OUTPUT OR reverting: 
>>
>> 303e6218ecec (ksft/fixes) selftests: Fix O= and KBUILD_OUTPUT handling for relative paths
>>
>> since bypassing top makefile with -C, the definition of abs-objtree used by the above patch
>> is no more available.
>>
>> As a side effect when KBUILD_OUTPUT is set, this breaks also the usage kselftest_install.sh.
>>
>>  $ ./kselftest_install.sh /home/crimar01/ARM/dev/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_full_next
>> ./kselftest_install.sh: Installing in specified location - /home/crimar01/ARM/dev/nfs/LTP-official-debian-aarch64-rootfs/opt/KSFT_full_next ...
>> make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>> 	ARCH=arm64 -C ../../.. headers_install
>> make[1]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/linux'
>> make[2]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
>>   INSTALL /kselftest/usr/include
>> mkdir: cannot create directory ‘/kselftest’: Permission denied
>> /home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1187: recipe for target 'headers_install' failed
>> make[2]: *** [headers_install] Error 1
>> make[2]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
>> Makefile:179: recipe for target 'sub-make' failed
>> make[1]: *** [sub-make] Error 2
>> make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/linux'
>> Makefile:142: recipe for target 'khdr' failed
>> make: *** [khdr] Error 2
>>
>>
> ...
>> Any thoughts ? ... or am I missing something ?
> 
> You're not missing anything, this is broken.
Thanks for the feedback !

Cristian

> 
>> (I think I'm starting to see this in latest CI linaro kselftest while they cross-compile for arm64)
> 
> It just hit my travis jobs when I merged up to master:
> 
>   https://travis-ci.org/linuxppc/linux/jobs/617482001
> 
> Shuah can we please get this reverted?
> 
> cheers
> 

