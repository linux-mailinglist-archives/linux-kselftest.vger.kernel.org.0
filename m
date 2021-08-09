Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990633E43BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhHIKSK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 06:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhHIKSK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 06:18:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB1EC0613D3;
        Mon,  9 Aug 2021 03:17:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628504266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mUREw8STJ2JWCIPIy1C7QUNcphVARQ51gXSM8DV+C24=;
        b=KQ+99kkaNjD1Av179Orlm992PCKb9LQzNHyTyYJk474sOaLFDMzrbEBo6VnDQwMIVOj0HH
        7Vg0WcdSPCRQOEQHqYYuIK+UBl0jXtaYiAhTcrzrh+SUhwdbKclZKG1jj/plt0+/CcVGcA
        bLD8R9rMzuCZvr7xK0abr8E/CwnBZvfI5WSt0o3fFHoYUOOITjejDc5B+fezadwrhIRLTt
        TZJcnsSoWyvZ+APsd/QLAupLicHnGocK0NwpIqTyYUG/V0JngnJh0tjRsTvpLNuam6kfzH
        EKUTywhCFPQ1Z/zEOg3hcVfw7+bbs7rkMddgaG6HbkkL3lwOCAbxndQBkwxKRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628504266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mUREw8STJ2JWCIPIy1C7QUNcphVARQ51gXSM8DV+C24=;
        b=dhN5EycmkS7LI28GcBkJIEkszO1KtksoHgVU9B71fNWgSUeiW3cJKGvECK+nH+MgDE/3J0
        WdvR44JAO/80+iCA==
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [kbuild-all] Re: sparc64-linux-gcc: error: unrecognized
 command-line option '-mxsave'
In-Reply-To: <277810e0-3887-f5d4-a150-60fdb1626e60@intel.com>
References: <202107271153.7QWf3g6F-lkp@intel.com>
 <efd7ab16-ed45-0ab0-a123-4e8e45c100d0@intel.com>
 <8bee8632-9129-bb02-ab94-f65786e65268@intel.com> <87a6lu68xv.ffs@tglx>
 <277810e0-3887-f5d4-a150-60fdb1626e60@intel.com>
Date:   Mon, 09 Aug 2021 12:17:46 +0200
Message-ID: <87im0eudkl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 09 2021 at 09:54, Rong A. Chen wrote:
> On 8/6/2021 8:42 PM, Thomas Gleixner wrote:
>> On Wed, Aug 04 2021 at 17:04, Rong A. Chen wrote:
>>> On 7/27/2021 10:52 PM, Dave Hansen wrote:
>>>> On 7/26/21 8:11 PM, kernel test robot wrote:
>>>>>>> sparc64-linux-gcc: error: unrecognized command-line option '-mxsave'
>>>>
>>>> Is there something else funky going on here?  All of the "-mxsave" flags
>>>> that I can find are under checks for x86 builds, like:
>>>>
>>>> 	ifeq ($(CAN_BUILD_I386),1)
>>>> 	$(BINARIES_32): CFLAGS += -m32 -mxsave
>>>> 	..
>>>>
>>>> I'm confused how we could have a sparc64 compiler (and only a sparc64
>>>> compiler) that would end up with "-mxsave" in CFLAGS.
>>>
>>> Hi Dave,
>>>
>>> We can reproduce the error and have no idea too, but we have disabled
>>> the test for selftests on non-x86 arch.
>> 
>> This smells like a host/target compiler mixup. Can you please make the
>> kernel build verbose with 'V=1' and provide the full build output?
>
> Hi Thomas,
>
> I run the below command:
>
> $make V=1 --keep-going CROSS_COMPILE=sparc64-linux- -j1 O=build_dir 
> ARCH=sparc64 -C tools/testing/selftests/vm
> ...
> sparc64-linux-gcc -Wall -I ../../../../usr/include  -no-pie -m32 -mxsave 
>   protection_keys.c -lrt -lpthread -lrt -ldl -lm -o 
> /root/linux/tools/testing/selftests/vm/protection_keys_32
> sparc64-linux-gcc: error: unrecognized command-line option '-mxsave'
> make: *** [Makefile:107:

Right. That's clearly broken because all these x8664 muck is derived
from:

  MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/ppc64/')

which obviously fails for cross compiling because it's looking at the
compile machine and not at the target.

Something like the below should cure that, but TBH I lost track
which one of ARCH, SUBARCH, UTS_MACHINE should be used here. The kbuild
folks should know.

Thanks,

        tglx

---
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -4,7 +4,6 @@
 include local_config.mk
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
-MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/ppc64/')
 
 # Without this, failed build products remain, with up-to-date timestamps,
 # thus tricking Make (and you!) into believing that All Is Well, in subsequent
@@ -46,7 +45,7 @@ TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
 TEST_GEN_FILES += split_huge_page_test
 
-ifeq ($(MACHINE),x86_64)
+ifeq ($(UTS_MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
@@ -68,7 +67,7 @@ TEST_GEN_FILES += $(BINARIES_64)
 endif
 else
 
-ifneq (,$(findstring $(MACHINE),ppc64))
+ifneq (,$(findstring $(UTS_MACHINE),ppc64))
 TEST_GEN_FILES += protection_keys
 endif
 
@@ -87,7 +86,7 @@ TEST_FILES := test_vmalloc.sh
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
-ifeq ($(MACHINE),x86_64)
+ifeq ($(UTS_MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
