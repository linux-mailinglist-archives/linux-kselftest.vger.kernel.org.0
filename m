Return-Path: <linux-kselftest+bounces-14871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA79494CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 17:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8091F2698F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D412BAE5;
	Tue,  6 Aug 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOV5jlM3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49758282F7;
	Tue,  6 Aug 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959328; cv=none; b=iFkIdR7r/VkeFNKDZldrGqg05yO+eJMTIYwKJNjcgYd00Xw9ws58/6oUpbbFSnWO5cQax23AUcSmsb39mQC/ZqSEfS+DpgYV3i76vIiYNaVBa3KW79Q/MkiyUyps2InetPf9Qw8eUTxwtKU7oyN7Sy+qvzFMyWNbDQN9eGUWFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959328; c=relaxed/simple;
	bh=a5ldl9NyABP9HYUnDOVqUtUiKjaa7pCE+GI2xJiFpAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLuKuN+f1k0i4+6ZThByYNgDRJ1Gj3Xnl6bf7z/3+ODbeDCSlbeAVP88kzvoB/E3PDe1Og1HbkDvsd7/1SVHfghFQ89G88Hbjs2w09BpZvIAsILmJtDQVI52FwlsmZsZNWEKt1bRJ8d13yWZpK6oeK0MYVQ/yIy8YgOwkqiVxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOV5jlM3; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db1657c0fdso473838b6e.1;
        Tue, 06 Aug 2024 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722959325; x=1723564125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOWuQRrXEXgqFoB1KqQBLyM96Puu9GkfkQ84dwQkou0=;
        b=jOV5jlM35i93m6LpwjuSCzNl3ghHVrqpPrX4rWeTAG+Jk0h1U/Duz0tvIfZiAf1v8R
         z/hgCrNx72Hdbohx28n+0fB9/OS9YAzpmN3ugK/aijZ+4TK/b3jWwtJZEi2buEd8VUB8
         Hq61wt8k4Al2CdjaLQOGcyPDl1fHMl+aQro+OULrKKsnq1AOXSQnr+a7eCPgiWn7WGoI
         hAznF/xGsNMBVZtSHO9uWgexRuaFdWxP88bQXltsp6TEwVT3jqqSXDHER5RgNgVjbiTZ
         M7dxmMXfrErCtMSHTjlc6wVsEk9bWPAH+RqHx3jCDH82jcGAUoJCaTiDLoR8Kp/nAH0I
         a5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959325; x=1723564125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOWuQRrXEXgqFoB1KqQBLyM96Puu9GkfkQ84dwQkou0=;
        b=OvN74xr7WhGF0Q9CW6BbuGvsMseST4QSDAxncjcMu5GxU3dszvKmBZxEnUeLWam2b4
         W0iN/0+iql7/+zniMzfhhiqE9dl1BM/7I+tjk9ImxJzIrzR33nb6FumCpK33LBx8xV3q
         4ONlwD2qEKztO59zoq864iyPwCgB065ESlmGIctNUjeU2zR8R//cBd0Fi3RignPlF1mb
         d/Gzrtu8mJrDEx2AKPyl4l2zAFzSvUtL1B6DPIxFm+HtaGR+D20YoK3ocRZ3AFex9idD
         D0r7ldnmujnjE7BG7lwYjmEK/y/M4YcMFOxkm3NnIFrs3WwrGpj8LbEr23iWYzrWrO4w
         8hgg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Gmms37lDTN1I++MyZ+Ig+7yIggbVznuH4jHi3E1OuBPtSgr8ecUfkwnKZeR5MfDjKF+9kDgLVtWyZFx0WM1Ivoam/RCOTWkimhed1H2juNj5PhegGRbdef2KLiklqkldSX32mg8hpL4t9r20
X-Gm-Message-State: AOJu0Yxq8MtnWqxjbvmp7VMlAgk/pvsgmwRrSsgH+PTSL0osIQFp4J6w
	BopEXpDCZ58QIvdaXOtJU2SUQ6a5ZNE58wdmSOXsnLnJ+6zFYPLb
X-Google-Smtp-Source: AGHT+IGOzzbbv2xdZnbN/iJEvz3/mpK9SA/ghwJm9OrmJ7b5JXuGwmub9mTWstwPpqJLJQYfFm7yWg==
X-Received: by 2002:a05:6808:bd3:b0:3da:bc80:b233 with SMTP id 5614622812f47-3db55806691mr17073564b6e.17.1722959324979;
        Tue, 06 Aug 2024 08:48:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b764fba580sm7110455a12.70.2024.08.06.08.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:48:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Aug 2024 08:48:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vitor Massaru Iha <vitor@massaru.org>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, brendanhiggins@google.com,
	keescook@chromium.org, davidgow@google.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: Convert test_user_copy to KUnit test
Message-ID: <a41ab091-42d3-4e03-b0e8-89af354faadc@roeck-us.net>
References: <20200721174654.72132-1-vitor@massaru.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721174654.72132-1-vitor@massaru.org>

Hi,

On Tue, Jul 21, 2020 at 02:46:54PM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the runtime tests of test_user_copy fuctions,
> from `lib/test_user_copy.c`to KUnit tests.
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

These tests are failing (at least) for arm-v7, loongarch, and mips
qemu emulations; see below for failure logs.

Any idea if those might be architecture problems, problems with qemu,
or problems with the test ?

Thanks,
Guenter

---
On arm:

[   13.097105]     # usercopy_test_valid: ASSERTION FAILED at lib/usercopy_kunit.c:311
[   13.097105]     Expected user_addr < (unsigned long)((((0xC0000000UL))) - (((0x01000000UL)))), but
[   13.097105]         user_addr == 4294967284 (0xfffffff4)
[   13.097105]         (unsigned long)((((0xC0000000UL))) - (((0x01000000UL)))) == 3204448256 (0xbf000000)
[   13.097105] Failed to allocate user memory
[   13.098876]     # usercopy_test_valid: pass:0 fail:1 skip:0 total:1
[   13.099378]     not ok 1 usercopy_test_valid
[   13.101143]     # usercopy_test_invalid: ASSERTION FAILED at lib/usercopy_kunit.c:311
[   13.101143]     Expected user_addr < (unsigned long)((((0xC0000000UL))) - (((0x01000000UL)))), but
[   13.101143]         user_addr == 4294967284 (0xfffffff4)
[   13.101143]         (unsigned long)((((0xC0000000UL))) - (((0x01000000UL)))) == 3204448256 (0xbf000000)
[   13.101143] Failed to allocate user memory
[   13.102726]     # usercopy_test_invalid: pass:0 fail:1 skip:0 total:1
[   13.103167]     not ok 2 usercopy_test_invalid
[   13.104744]     # usercopy_test_check_nonzero_user: ASSERTION FAILED at lib/usercopy_kunit.c:311
[   13.104744]     Expected user_addr < (unsigned long)((((0xC0000000UL))) - (((0x01000000UL)))), but
[   13.104744]         user_addr == 4294967284 (0xfffffff4)
[   13.104744]         (unsigned long)((((0xC0000000UL))) - (((0x01000000UL)))) == 3204448256 (0xbf000000)
[   13.104744] Failed to allocate user memory
[   13.106485]     # usercopy_test_check_nonzero_user: pass:0 fail:1 skip:0 total:1
[   13.106935]     not ok 3 usercopy_test_check_nonzero_user
[   13.108812]     # usercopy_test_copy_struct_from_user: ASSERTION FAILED at lib/usercopy_kunit.c:311
[   13.108812]     Expected user_addr < (unsigned long)((((0xC0000000UL))) - (((0x01000000UL)))), but
[   13.108812]         user_addr == 4294967284 (0xfffffff4)
[   13.108812]         (unsigned long)((((0xC0000000UL))) - (((0x01000000UL)))) == 3204448256 (0xbf000000)
[   13.108812] Failed to allocate user memory
[   13.110643]     # usercopy_test_copy_struct_from_user: pass:0 fail:1 skip:0 total:1
[   13.111096]     not ok 4 usercopy_test_copy_struct_from_user
[   13.111260] # usercopy: pass:0 fail:4 skip:0 total:4
[   13.111401] # Totals: pass:0 fail:4 skip:0 total:4
[   13.111533] not ok 40 usercopy

On loongarch:

[    5.202648] CPU 0 Unable to handle kernel paging request at virtual address 0000000000000008, era == 90000000040f4b60, ra == 900000000436e558
[    5.203061] Oops[#1]:
[    5.203288] CPU: 0 UID: 0 PID: 877 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc2+ #1
[    5.203469] Tainted: [N]=TEST
[    5.203523] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[    5.203686] pc 90000000040f4b60 ra 900000000436e558 tp 9000000107dec000 sp 9000000107defc90
[    5.203801] a0 ffffffffffff4000 a1 90000001063554f8 a2 0000000000000000 a3 9000000107defb84
[    5.203913] a4 0000000000000001 a5 0000000000000000 a6 900000000696e030 a7 9000000004b617c0
[    5.204025] t0 9000000104ab8840 t1 0000800000000000 t2 0000000000208040 t3 9000000107dec000
[    5.204134] t4 0000000000000000 t5 9000000006f39f10 t6 0000000000000001 t7 0000000000006000
[    5.204245] t8 0000000045eeca10 u0 9000000004b61818 s9 90000001002e7e40 s0 0000000008000000
[    5.204355] s1 9000000104b58040 s2 0000000000000000 s3 fffffffffffff000 s4 9000000005f62d00
[    5.204465] s5 9000000104ab8840 s6 90000000061752e8 s7 0000000000000000 s8 9000000004144df8
[    5.204580]    ra: 900000000436e558 arch_pick_mmap_layout+0xa0/0x1fc
[    5.204928]   ERA: 90000000040f4b60 stack_top+0x58/0xa8
[    5.205009]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[    5.205189]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[    5.205286]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[    5.205398]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
[    5.205629] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
[    5.205732]  BADV: 0000000000000008
[    5.205802]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
[    5.205897] Modules linked in:
[    5.205982] Process kunit_try_catch (pid: 877, threadinfo=9000000107dec000, task=9000000104ab8840)
[    5.206120] Stack : 9000000005f62d00 fffffffffffff000 900000000616f000 9000000107da5b40
[    5.206323]         9000000107defd58 9000000004a6cce4 0000000000000dc0 9000000104b58040
[    5.206444]         9000000100004ac0 0000000000000000 0000000000000000 0e03af9ea058218b
[    5.206562]         900000000616f000 90000001002d7b00 9000000107da5b40 9000000004a6c2c4
[    5.206681]         90000000061752e8 9000000104ab8840 9000000005f62d00 fffffffffffff000
[    5.206799]         900000000616f000 90000001002d7b00 9000000107da5b40 9000000004a6cb9c
[    5.206918]         9000000107cc8000 0000000000000000 0000000000000000 0000000000008000
[    5.207035]         0000000000000007 0000000000000022 0000000000000000 0e03af9ea058218b
[    5.207153]         900000000616f000 90000001079d2f00 90000001002d7b00 9000000004ba6a60
[    5.207271]         9000000104ab9170 90000000056c0788 00000000000000b0 0e03af9ea058218b
[    5.207389]         ...
[    5.207450] Call Trace:
[    5.207467] [<90000000040f4b60>] stack_top+0x58/0xa8
[    5.207588] [<900000000436e554>] arch_pick_mmap_layout+0x9c/0x1fc
[    5.207675] [<9000000004a6cce0>] kunit_vm_mmap_init+0x104/0x12c
[    5.207758] [<9000000004a6c2c0>] __kunit_add_resource+0x48/0xd0
[    5.207839] [<9000000004a6cb98>] kunit_vm_mmap+0x84/0xc8
[    5.207913] [<9000000004ba6a5c>] usercopy_test_init+0xb8/0x25c
[    5.207993] [<9000000004a6c064>] kunit_try_run_case+0x58/0x184
[    5.208073] [<9000000004a6e260>] kunit_generic_run_threadfn_adapter+0x20/0x48
[    5.208168] [<9000000004144914>] kthread+0x130/0x140
[    5.208238] [<90000000040f1c04>] ret_from_kernel_thread+0x8/0xa4
[    5.208323]
[    5.208370] Code: 15fffe84  26165190  2400158e <28c0220c> 14000070  03bffe10  0010c18c  15ffff90  0014c18c
[    5.208583]
[    5.208822] ---[ end trace 0000000000000000 ]---
[    5.209975]     # usercopy_test_valid: try faulted: last line seen lib/usercopy_kunit.c:304
[    5.210227]     # usercopy_test_valid: internal error occurred preventing test case from running: -4
[    5.210890]     # usercopy_test_valid: pass:0 fail:1 skip:0 total:1
[    5.210942]     not ok 1 usercopy_test_valid

On mips:

CPU 0 Unable to handle kernel paging request at virtual address 00000018, epc == 80105f14, ra == 80299028
Oops[#1]:
CPU: 0 UID: 0 PID: 783 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc2-00102-g8857973f206d #1
Tainted: [N]=TEST
Hardware name: mti,malta
$ 0   : 00000000 00000001 00000000 00000000
$ 4   : 00000000 854ccec0 ffffffff 00000002
$ 8   : 82c6c340 8155ba9c 42314149 00000001
$12   : ffffffff 00000012 00000000 00000012
$16   : 00000000 08000000 82c6c040 82c6c040
$20   : 821c7c28 854ccec0 82205c68 80164c7c
$24   : 00000000 00000000
$28   : 85b14000 85b17d20 00000001 80299028
Hi    : 00000000
Lo    : 00000004
epc   : 80105f14 mips_stack_top+0x20/0x78
ra    : 80299028 arch_pick_mmap_layout+0xa4/0x1a4
Status: 1000a403	KERNEL EXL IE
Cause : 00800008 (ExcCode 02)
BadVA : 00000018
PrId  : 00019300 (MIPS 24Kc)
Modules linked in:
Process kunit_try_catch (pid: 783, threadinfo=85b14000, task=854ccec0, tls=00000000)
Stack : 82205c68 80164c7c 00400cc0 00000004 813d989c 85b17dd4 85b2ac00 81250000
        82c6c040 8070f984 00000001 802f1560 00000400 00000dc0 ffffffff 8070fa14
        81b43a80 00000000 00000000 657ad470 00000001 85b2ac00 821c7c1c 821c7c1c
        81250000 8070efb8 81b43bc0 657ad470 821c7c1c 81250000 85b2ac00 81250000
        821c7c1c 81250000 821c7c28 854ccec0 82205c68 8070fa48 821c7c1c 821c7c1c
        ...
Call Trace:
[<80105f14>] mips_stack_top+0x20/0x78
[<80299028>] arch_pick_mmap_layout+0xa4/0x1a4
[<8070f984>] kunit_vm_mmap_init+0xe8/0x114
[<8070efb8>] __kunit_add_resource+0x4c/0xdc
[<8070fa48>] kunit_vm_mmap+0x98/0xf0
[<808181a4>] usercopy_test_init+0xc4/0x254
[<8070eca8>] kunit_try_run_case+0x74/0x234
[<807110f8>] kunit_generic_run_threadfn_adapter+0x28/0x50
[<801647fc>] kthread+0x12c/0x154
[<80103078>] ret_from_kernel_thread+0x14/0x1c
Code: 9084635d  0003182b  00031b80 <8c460018> 3402ffff  30840004  000213c0  00431023  8cc30004
---[ end trace 0000000000000000 ]---
    # usercopy_test_valid: try faulted: last line seen lib/usercopy_kunit.c:304
    # usercopy_test_valid: internal error occurred preventing test case from running: -4
    # usercopy_test_valid: pass:0 fail:1 skip:0 total:1
    not ok 1 usercopy_test_valid


