Return-Path: <linux-kselftest+bounces-38790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA8B22CFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 18:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B79E167E85
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE282C15BF;
	Tue, 12 Aug 2025 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ncs6K/51"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047F27932F
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015116; cv=none; b=Aat1OSRrZ9yWQj/CQQ/9s68UXl+eRmHTayJR629w3qjtrqmIjbJWA/nH7Dxfi2oCT3h1vPr06/pbjloP9m7OAjoBIjlEXtgx3e/7qn+oTOb/UDWRvTq3sfUJ5v9jL8jIyN7XqFgIwSwW7RyXXdkfCHh2I1IQaPyW/b1Cn0PKpbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015116; c=relaxed/simple;
	bh=ZNHzSWxxdQBQ5le7poj2nm65AEXDF8Di90b1RkACNOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEhzzKaEjYRuf4Ly2eQuhcmCkvzm4YVElr030mUxaap934ZhtQValdACTW/IsevgowUogJeMP0Q7QJrC2BVXDhagjRBeqOZLfLdwfDzmZMxwdDxyd+0vAqHjVlIgTgmGcDntermXB+Lz5yp3NspZ1MBh/6UkRQ8W/13eI7vxQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ncs6K/51; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2559a8cd-b439-43fc-96e4-d5f2941ca4d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755015109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85LD0M+g7vnAQvqfLaFISlWJcgUdOVtpk5d2oOh+o0w=;
	b=Ncs6K/514Lq4fXrOke0KLWLMuWasTnw9WQfXhrASLXp7Qs2JIX9yfeIqUket2J2JHXRAhg
	UoASoe1v2osVsYUtzl1cQNAKYLU6nyWinm2N5yUbzqXFH5eH7iizp5OzBHvFV0/1TaZh0C
	o1JaAuZdOElIGVSFGCYglFd9aZIT8Ro=
Date: Tue, 12 Aug 2025 09:11:45 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/2] selftests/bpf: Force -O2 for USDT selftests to
 cover SIB handling logic
Content-Language: en-GB
To: =?UTF-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806092458.111972-1-phoenix500526@163.com>
 <20250806092458.111972-3-phoenix500526@163.com>
 <f5d8d886-1de3-4521-917a-e98b645b987e@linux.dev>
 <30d8fcac.2669.19882763de2.Coremail.phoenix500526@163.com>
 <e7ba3f7f-38b8-4c06-8aff-ef1fb8d04d86@linux.dev>
 <310495cd.19eb.19893314d03.Coremail.phoenix500526@163.com>
 <0f6d16c1-0e85-4709-9846-3a993a9f041b@linux.dev>
 <65e51538.57aa.1989d162bb8.Coremail.phoenix500526@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <65e51538.57aa.1989d162bb8.Coremail.phoenix500526@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/12/25 12:02 AM, 赵佳炜 wrote:
> Yes, I've tried that but it didn't help. FYI:
>
> $ readelf -nsr usdt_rip
>
>
> Relocation section '.rela.dyn' at offset 0x530 contains 9 entries:
>    Offset          Info           Type           Sym. Value    Sym. Name + Addend
> 000000003df0  000000000008 R_X86_64_RELATIVE                    1150
> 000000003df8  000000000008 R_X86_64_RELATIVE                    1110
> 000000004008  000000000008 R_X86_64_RELATIVE                    4008
> 000000004018  000000000008 R_X86_64_RELATIVE                    1160
> 000000003fd8  000100000006 R_X86_64_GLOB_DAT 0000000000000000 __libc_start_main@GLIBC_2.34 + 0
> 000000003fe0  000200000006 R_X86_64_GLOB_DAT 0000000000000000 _ITM_deregisterTM[...] + 0
> 000000003fe8  000300000006 R_X86_64_GLOB_DAT 0000000000000000 __gmon_start__ + 0
> 000000003ff0  000400000006 R_X86_64_GLOB_DAT 0000000000000000 _ITM_registerTMCl[...] + 0
> 000000003ff8  000500000006 R_X86_64_GLOB_DAT 0000000000000000 __cxa_finalize@GLIBC_2.2.5 + 0
>
>
> Symbol table '.dynsym' contains 6 entries:
>     Num:    Value          Size Type    Bind   Vis      Ndx Name
>       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>       1: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND _[...]@GLIBC_2.34 (2)
>       2: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_deregisterT[...]
>       3: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND __gmon_start__
>       4: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_registerTMC[...]
>       5: 0000000000000000     0 FUNC    WEAK   DEFAULT  UND [...]@GLIBC_2.2.5 (3)
>
>
> Symbol table '.symtab' contains 42 entries:
>     Num:    Value          Size Type    Bind   Vis      Ndx Name
>       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>       1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS Scrt1.o
>       2: 000000000000038c    32 OBJECT  LOCAL  DEFAULT    4 __abi_tag
>       3: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS usdt_rip.c
>       4: 0000000000004021     1 OBJECT  LOCAL  DEFAULT   25 ti
>       5: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crtstuff.c
>       6: 00000000000010a0     0 FUNC    LOCAL  DEFAULT   14 deregister_tm_clones
>       7: 00000000000010d0     0 FUNC    LOCAL  DEFAULT   14 register_tm_clones
>       8: 0000000000001110     0 FUNC    LOCAL  DEFAULT   14 __do_global_dtors_aux
>       9: 0000000000004020     1 OBJECT  LOCAL  DEFAULT   25 completed.0
>      10: 0000000000003df8     0 OBJECT  LOCAL  DEFAULT   21 __do_global_dtor[...]
>      11: 0000000000001150     0 FUNC    LOCAL  DEFAULT   14 frame_dummy
>      12: 0000000000003df0     0 OBJECT  LOCAL  DEFAULT   20 __frame_dummy_in[...]
>      13: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS damo.c
>      14: 0000000000004022     1 OBJECT  LOCAL  DEFAULT   25 ti
>      15: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crtstuff.c
>      16: 00000000000020d8     0 OBJECT  LOCAL  DEFAULT   19 __FRAME_END__
>      17: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS
>      18: 0000000000003e00     0 OBJECT  LOCAL  DEFAULT   22 _DYNAMIC
>      19: 0000000000002008     0 NOTYPE  LOCAL  DEFAULT   18 __GNU_EH_FRAME_HDR
>      20: 0000000000003fc0     0 OBJECT  LOCAL  DEFAULT   23 _GLOBAL_OFFSET_TABLE_
>      21: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __libc_start_mai[...]
>      22: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_deregisterT[...]
>      23: 0000000000004000     0 NOTYPE  WEAK   DEFAULT   24 data_start
>      24: 0000000000001160     8 FUNC    GLOBAL DEFAULT   14 add
>      25: 0000000000004020     0 NOTYPE  GLOBAL DEFAULT   24 _edata
>      26: 0000000000002004     1 NOTYPE  WEAK   HIDDEN    17 _.stapsdt.base
>      27: 0000000000004010     8 OBJECT  GLOBAL DEFAULT   24 t1
>      28: 0000000000001168     0 FUNC    GLOBAL HIDDEN    15 _fini
>      29: 0000000000004000     0 NOTYPE  GLOBAL DEFAULT   24 __data_start
>      30: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND __gmon_start__
>      31: 0000000000004008     0 OBJECT  GLOBAL HIDDEN    24 __dso_handle
>      32: 0000000000002000     4 OBJECT  GLOBAL DEFAULT   16 _IO_stdin_used
>      33: 0000000000004028     0 NOTYPE  GLOBAL DEFAULT   25 _end
>      34: 0000000000001070    38 FUNC    GLOBAL DEFAULT   14 _start
>      35: 0000000000004020     0 NOTYPE  GLOBAL DEFAULT   25 __bss_start
>      36: 0000000000001040    48 FUNC    GLOBAL DEFAULT   14 main
>      37: 0000000000004018     8 OBJECT  GLOBAL DEFAULT   24 add_ptr
>      38: 0000000000004020     0 OBJECT  GLOBAL HIDDEN    24 __TMC_END__
>      39: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_registerTMC[...]
>      40: 0000000000000000     0 FUNC    WEAK   DEFAULT  UND __cxa_finalize@G[...]
>      41: 0000000000001000     0 FUNC    GLOBAL HIDDEN    11 _init
>
>
> Displaying notes found in: .note.gnu.property
>    Owner                Data size        Description
>    GNU                  0x00000020       NT_GNU_PROPERTY_TYPE_0
>        Properties: x86 feature: IBT, SHSTK
>          x86 ISA needed: x86-64-baseline
>
>
> Displaying notes found in: .note.gnu.build-id
>    Owner                Data size        Description
>    GNU                  0x00000014       NT_GNU_BUILD_ID (unique build ID bitstring)
>      Build ID: eb615daa575687cc44edc1d339b27890c12c27f1
>
>
> Displaying notes found in: .note.ABI-tag
>    Owner                Data size        Description
>    GNU                  0x00000010       NT_GNU_ABI_TAG (ABI version tag)
>      OS: Linux, ABI: 3.2.0
>
>
> Displaying notes found in: .note.stapsdt
>    Owner                Data size        Description
>    stapsdt              0x00000066       NT_STAPSDT (SystemTap probe descriptors)
>      Provider: usdt_rip
>      Name: rip_global_var
>      Location: 0x0000000000001058, Base: 0x0000000000002004, Semaphore: 0x0000000000000000
>      Arguments: -1@ti(%rip) 8@add_ptr(%rip) -1@4+t1(%rip) -1@ti(%rip)

Could you share the complete source codes and compiler options which
reproduce the above result?

>
>
>
> At 2025-08-12 13:06:40, "Yonghong Song" <yonghong.song@linux.dev> wrote:
>>
>> On 8/10/25 1:55 AM, 赵佳炜 wrote:
>>>
>>> Hi Yonghong,
>>>
>>> I found another issue where symbols can be duplicated, and I’m not sure how to tell them apart.
>>>
>>> For example, I created two C files named usdt_rip.c and hello.c. Both define their own static ti variables, like:`static volatile char ti = 0;`.
>>>
>>> After compiling, I obtained an ELF file usdt_rip whose .symtab contains the following entries:
>>>
>>> $ readelf -s usdt_rip
>>>
>>> Symbol table '.symtab' contains 42 entries:
>>>      Num:    Value          Size Type    Bind   Vis      Ndx Name
>>>        0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>>>        1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS Scrt1.o
>>>        2: 000000000000038c    32 OBJECT  LOCAL  DEFAULT    4 __abi_tag
>>>        3: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS usdt_rip.c
>>>        4: 0000000000004021     1 OBJECT  LOCAL  DEFAULT   25 ti
>>>        5: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crtstuff.c
>>>        6: 00000000000010a0     0 FUNC    LOCAL  DEFAULT   14 deregister_tm_clones
>>>        7: 00000000000010d0     0 FUNC    LOCAL  DEFAULT   14 register_tm_clones
>>>        8: 0000000000001110     0 FUNC    LOCAL  DEFAULT   14 __do_global_dtors_aux
>>>        9: 0000000000004020     1 OBJECT  LOCAL  DEFAULT   25 completed.0
>>>       10: 0000000000003df8     0 OBJECT  LOCAL  DEFAULT   21 __do_global_dtor[...]
>>>       11: 0000000000001150     0 FUNC    LOCAL  DEFAULT   14 frame_dummy
>>>       12: 0000000000003df0     0 OBJECT  LOCAL  DEFAULT   20 __frame_dummy_in[...]
>>>       13: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS damo.c
>>>       14: 0000000000004022     1 OBJECT  LOCAL  DEFAULT   25 ti
>>>       15: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crtstuff.c
>>>       16: 00000000000020d8     0 OBJECT  LOCAL  DEFAULT   19 __FRAME_END__
>>>
>>>
>>> As you can see, there are two ti variables in the .symtab section. Their values are very close, making them hard to distinguish.
>>>
>>> I’m unsure how to handle this situation. Do you have any suggestions?
>> Did you check relocations? Relocaitons should be able to point exact which symbol.
>>
>>> Thanks,
>>> Jiawei Zhao
>> [...]


