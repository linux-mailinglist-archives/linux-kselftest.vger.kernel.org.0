Return-Path: <linux-kselftest+bounces-21571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852279BFB9E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEF21F2282D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238DF196D9D;
	Thu,  7 Nov 2024 01:31:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91886192B88;
	Thu,  7 Nov 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943107; cv=none; b=smHXXZCfIapyGBujQJ7TSo3IZdtxmSZFZH/CExQFUGejJUtb+JWPUWJ7Wfkd8DNWkAihl+ljw8pIlPSm9pW8pinJIMpb27sRODwYC9kzGq7YwnZAbxshd3WoTOFh+KTGyfN0acduQg/gS852s6tYa1MGk3pT6qHr08yrD9CG9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943107; c=relaxed/simple;
	bh=SnoIDL63G3LXoykevZWwegZPXoJfoGkT7hgUBMu0BW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cayeATySqUORHsa6ssiSb70KQr/wvkdUYJxTEZkD/LfGlGl9qSRQKSEaqhd21vz2bTc/1llyeWYSWZ3hIuGhqzdAlUZHqGq9lLok1yBb/T3rVrWBpJo42svXpXAQ7lzYcMTo6vryOoOOwEd1KmQmqhmf0B2ejFVptXg0vbNG+Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XkPcc0Dlyz10PVw;
	Thu,  7 Nov 2024 09:29:20 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 170C81402CB;
	Thu,  7 Nov 2024 09:31:41 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 09:31:40 +0800
Message-ID: <ccb3c255-3323-971c-ebd2-29069d621914@huawei.com>
Date: Thu, 7 Nov 2024 09:31:39 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] kunit: string-stream: Fix a UAF bug in kunit_init_suite()
Content-Language: en-US
To: <brendan.higgins@linux.dev>, <davidgow@google.com>, <rmoar@google.com>,
	<skhan@linuxfoundation.org>, <rf@opensource.cirrus.com>,
	<linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>
References: <20241024094303.1531810-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241024094303.1531810-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Gentle Ping.

On 2024/10/24 17:43, Jinjie Ruan wrote:
> In kunit_debugfs_create_suite(), if alloc_string_stream() fails in the
> kunit_suite_for_each_test_case() loop, the "suite->log = stream"
> has assigned before, and the error path only free the suite->log's stream
> memory but not set it to NULL in string_stream_destroy(), so the later
> string_stream_clear() of suite->log in kunit_init_suite() will cause
> below UAF bug.
> 
> Set stream pointer to NULL after free in string_stream_destroy()
> to fix it.
> 
> 	Unable to handle kernel paging request at virtual address 006440150000030d
> 	Mem abort info:
> 	  ESR = 0x0000000096000004
> 	  EC = 0x25: DABT (current EL), IL = 32 bits
> 	  SET = 0, FnV = 0
> 	  EA = 0, S1PTW = 0
> 	  FSC = 0x04: level 0 translation fault
> 	Data abort info:
> 	  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> 	  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> 	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> 	[006440150000030d] address between user and kernel address ranges
> 	Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> 	Dumping ftrace buffer:
> 	   (ftrace buffer empty)
> 	Modules linked in: iio_test_gts industrialio_gts_helper cfg80211 rfkill ipv6 [last unloaded: iio_test_gts]
> 	CPU: 5 UID: 0 PID: 6253 Comm: modprobe Tainted: G    B   W        N 6.12.0-rc4+ #458
> 	Tainted: [B]=BAD_PAGE, [W]=WARN, [N]=TEST
> 	Hardware name: linux,dummy-virt (DT)
> 	pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> 	pc : string_stream_clear+0x54/0x1ac
> 	lr : string_stream_clear+0x1a8/0x1ac
> 	sp : ffffffc080b47410
> 	x29: ffffffc080b47410 x28: 006440550000030d x27: ffffff80c96b5e98
> 	x26: ffffff80c96b5e80 x25: ffffffe461b3f6c0 x24: 0000000000000003
> 	x23: ffffff80c96b5e88 x22: 1ffffff019cdf4fc x21: dfffffc000000000
> 	x20: ffffff80ce6fa7e0 x19: 032202a80000186d x18: 0000000000001840
> 	x17: 0000000000000000 x16: 0000000000000000 x15: ffffffe45c355cb4
> 	x14: ffffffe45c35589c x13: ffffffe45c03da78 x12: ffffffb810168e75
> 	x11: 1ffffff810168e74 x10: ffffffb810168e74 x9 : dfffffc000000000
> 	x8 : 0000000000000004 x7 : 0000000000000003 x6 : 0000000000000001
> 	x5 : ffffffc080b473a0 x4 : 0000000000000000 x3 : 0000000000000000
> 	x2 : 0000000000000001 x1 : ffffffe462fbf620 x0 : dfffffc000000000
> 	Call trace:
> 	 string_stream_clear+0x54/0x1ac
> 	 __kunit_test_suites_init+0x108/0x1d8
> 	 kunit_exec_run_tests+0xb8/0x100
> 	 kunit_module_notify+0x400/0x55c
> 	 notifier_call_chain+0xfc/0x3b4
> 	 blocking_notifier_call_chain+0x68/0x9c
> 	 do_init_module+0x24c/0x5c8
> 	 load_module+0x4acc/0x4e90
> 	 init_module_from_file+0xd4/0x128
> 	 idempotent_init_module+0x2d4/0x57c
> 	 __arm64_sys_finit_module+0xac/0x100
> 	 invoke_syscall+0x6c/0x258
> 	 el0_svc_common.constprop.0+0x160/0x22c
> 	 do_el0_svc+0x44/0x5c
> 	 el0_svc+0x48/0xb8
> 	 el0t_64_sync_handler+0x13c/0x158
> 	 el0t_64_sync+0x190/0x194
> 	Code: f9400753 d2dff800 f2fbffe0 d343fe7c (38e06b80)
> 	---[ end trace 0000000000000000 ]---
> 	Kernel panic - not syncing: Oops: Fatal exception
> 
> Cc: stable@vger.kernel.org
> Fixes: a3fdf784780c ("kunit: string-stream: Decouple string_stream from kunit")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  lib/kunit/string-stream.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 54f4fdcbfac8..00ad518b730b 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -178,6 +178,7 @@ void string_stream_destroy(struct string_stream *stream)
>  
>  	string_stream_clear(stream);
>  	kfree(stream);
> +	stream = NULL;
>  }
>  
>  static void resource_free_string_stream(void *p)

