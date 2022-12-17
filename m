Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE064F86A
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 10:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiLQJPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 04:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLQJPq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 04:15:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6B66273
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Dec 2022 01:15:42 -0800 (PST)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NZ0fJ1f9lzRq7H;
        Sat, 17 Dec 2022 17:14:32 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 17:15:36 +0800
Subject: Re: [PATCH v3 14/21] kselftest/arm64: Add a stress test program for
 ZT0
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
 <20221111215026.813348-15-broonie@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <bc1c581d-55e4-c867-8cf2-269084756e91@huawei.com>
Date:   Sat, 17 Dec 2022 17:15:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20221111215026.813348-15-broonie@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/11/12 5:50, Mark Brown wrote:
> +// Trivial memory copy: copy x2 bytes, starting at address x1, to address x0.
> +// Clobbers x0-x3
> +function memcpy
> +	cmp	x2, #0
> +	b.eq	1f
> +0:	ldrb	w3, [x1], #1
> +	strb	w3, [x0], #1
> +	subs	x2, x2, #1
> +	b.ne	0b
> +1:	ret
> +endfunction

There is an exact same implementation of memcpy in fp/asm-utils.S.

> +
> +// Generate a test pattern for storage in ZT
> +// x0: pid
> +// x1: generation
> +
> +// These values are used to constuct a 32-bit pattern that is repeated in the

s/constuct/construct/ ?

> +// scratch buffer as many times as will fit:
> +// bits 31:24	generation number (increments once per test_loop)
> +// bits 23: 8	pid
> +// bits  7: 0	32-bit lane index
> +
> +function pattern
> +	mov	w3, wzr
> +	bfi	w3, w0, #8, #16		// PID
> +	bfi	w3, w1, #24, #8		// Generation
> +
> +	ldr	x0, =scratch
> +	mov	w1, #ZT_B / 4
> +
> +0:	str	w3, [x0], #4
> +	add	w3, w3, #1		// Lane
> +	subs	w1, w1, #1
> +	b.ne	0b
> +
> +	ret
> +endfunction
> +
> +// Set up test pattern in a ZT horizontal vector
> +// x0: pid
> +// x1: generation
> +function setup_zt
> +	mov	x4, x30
> +
> +	bl	pattern			// Get pattern in scratch buffer
> +	ldr	x0, =ztref
> +	ldr	x1, =scratch
> +	mov	x2, #ZT_B
> +	bl	memcpy
> +
> +	_ldr_zt 0			// load zt0 from pointer x0

Isn't x0 already clobbered by memcpy (and is now pointing to the
end of ztref)?

> +
> +	ret	x4
> +endfunction
> +
> +// Trivial memory compare: compare x2 bytes starting at address x0 with
> +// bytes starting at address x1.
> +// Returns only if all bytes match; otherwise, the program is aborted.
> +// Clobbers x0-x5.
> +function memcmp
> +	cbz	x2, 2f
> +
> +	stp	x0, x1, [sp, #-0x20]!
> +	str	x2, [sp, #0x10]
> +
> +	mov	x5, #0
> +0:	ldrb	w3, [x0, x5]
> +	ldrb	w4, [x1, x5]
> +	add	x5, x5, #1
> +	cmp	w3, w4
> +	b.ne	1f
> +	subs	x2, x2, #1
> +	b.ne	0b
> +
> +1:	ldr	x2, [sp, #0x10]
> +	ldp	x0, x1, [sp], #0x20
> +	b.ne	barf
> +
> +2:	ret
> +endfunction
> +
> +// Verify that a ZT vector matches its shadow in memory, else abort
> +// Clobbers x0-x7 and x12.

It looks like check_zt doesn't clobber as many registers as "x0-x7
and x12".

> +function check_zt
> +	mov	x3, x30
> +
> +	ldr	x0, =scratch		// Poison scratch
> +	mov	x1, #ZT_B
> +	bl	memfill_ae
> +
> +	ldr	x0, =scratch
> +	_str_zt 0
> +
> +	ldr	x0, =ztref
> +	ldr	x1, =scratch
> +	mov	x2, #ZT_B
> +	mov	x30, x3
> +	b	memcmp
> +endfunction

[...]
> +.Ltest_loop:
> +	mov	x0, x20
> +	mov	x1, x22
> +	bl	setup_zt
> +
> +	mov	x8, #__NR_sched_yield	// Encourage preemption
> +	svc	#0
> +
> +	mov	x0, x20
> +	mov	x1, x22

check_zt receives no parameter so there is no need to initialize
x0 and x1.

> +	bl	check_zt
> +
> +	add	x22, x22, #1	// Everything still working
> +	b	.Ltest_loop
> +
> +.Labort:
> +	mov	x0, #0
> +	mov	x1, #SIGABRT
> +	mov	x8, #__NR_kill
> +	svc	#0
> +endfunction

[...]
> +function svcr_barf

And svcr_barf is unused in zt-test.

Zenghui
