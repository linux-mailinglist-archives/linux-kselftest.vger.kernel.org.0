Return-Path: <linux-kselftest+bounces-20528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939D99AE143
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 11:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A621C20AE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B94917D340;
	Thu, 24 Oct 2024 09:43:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7216133C;
	Thu, 24 Oct 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763028; cv=none; b=tDsyhUTh3xu4wAYmhPVJfz1h3ymqFLTsda6a1TFcQAPrFSLbhTgW32eJ0XvkNI4Alv+44TuhUsD+K4qz5/hfTbkKN+yrBuo+XKkD7sDFGglmQ/uQFneEox8//O2G/Wt3GKdd+3FCkk7uMd9W9Yscupr+mpslIHrYXe47zZ619tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763028; c=relaxed/simple;
	bh=9q5r6qEkyBhH7/OipBzUS79WR1u9ItOSmP4yBmZMSbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZ6Ou/Z+9PkbMnEn5gngBD2ilQ5E8EDxEjZbgwphJ83X6GRWgwFsxI1zG5zHwDuApbV5iAD7rkRk+GC/GUu9pDTprOzd4Iy7sMDWT3DuzUJkIAlzMhuDFpm9drF6Tp4mtdWJ/sSGxc7AD+fTj+9O3SF5p9NsfXuIDJCHT0C1PrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XZ1DM4w9dzQs5j;
	Thu, 24 Oct 2024 17:42:43 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id A79B71800A7;
	Thu, 24 Oct 2024 17:43:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 17:43:36 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <brendan.higgins@linux.dev>, <davidgow@google.com>, <rmoar@google.com>,
	<skhan@linuxfoundation.org>, <rf@opensource.cirrus.com>,
	<linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] kunit: string-stream: Fix a UAF bug in kunit_init_suite()
Date: Thu, 24 Oct 2024 17:43:03 +0800
Message-ID: <20241024094303.1531810-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)

In kunit_debugfs_create_suite(), if alloc_string_stream() fails in the
kunit_suite_for_each_test_case() loop, the "suite->log = stream"
has assigned before, and the error path only free the suite->log's stream
memory but not set it to NULL in string_stream_destroy(), so the later
string_stream_clear() of suite->log in kunit_init_suite() will cause
below UAF bug.

Set stream pointer to NULL after free in string_stream_destroy()
to fix it.

	Unable to handle kernel paging request at virtual address 006440150000030d
	Mem abort info:
	  ESR = 0x0000000096000004
	  EC = 0x25: DABT (current EL), IL = 32 bits
	  SET = 0, FnV = 0
	  EA = 0, S1PTW = 0
	  FSC = 0x04: level 0 translation fault
	Data abort info:
	  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
	  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
	[006440150000030d] address between user and kernel address ranges
	Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
	Dumping ftrace buffer:
	   (ftrace buffer empty)
	Modules linked in: iio_test_gts industrialio_gts_helper cfg80211 rfkill ipv6 [last unloaded: iio_test_gts]
	CPU: 5 UID: 0 PID: 6253 Comm: modprobe Tainted: G    B   W        N 6.12.0-rc4+ #458
	Tainted: [B]=BAD_PAGE, [W]=WARN, [N]=TEST
	Hardware name: linux,dummy-virt (DT)
	pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	pc : string_stream_clear+0x54/0x1ac
	lr : string_stream_clear+0x1a8/0x1ac
	sp : ffffffc080b47410
	x29: ffffffc080b47410 x28: 006440550000030d x27: ffffff80c96b5e98
	x26: ffffff80c96b5e80 x25: ffffffe461b3f6c0 x24: 0000000000000003
	x23: ffffff80c96b5e88 x22: 1ffffff019cdf4fc x21: dfffffc000000000
	x20: ffffff80ce6fa7e0 x19: 032202a80000186d x18: 0000000000001840
	x17: 0000000000000000 x16: 0000000000000000 x15: ffffffe45c355cb4
	x14: ffffffe45c35589c x13: ffffffe45c03da78 x12: ffffffb810168e75
	x11: 1ffffff810168e74 x10: ffffffb810168e74 x9 : dfffffc000000000
	x8 : 0000000000000004 x7 : 0000000000000003 x6 : 0000000000000001
	x5 : ffffffc080b473a0 x4 : 0000000000000000 x3 : 0000000000000000
	x2 : 0000000000000001 x1 : ffffffe462fbf620 x0 : dfffffc000000000
	Call trace:
	 string_stream_clear+0x54/0x1ac
	 __kunit_test_suites_init+0x108/0x1d8
	 kunit_exec_run_tests+0xb8/0x100
	 kunit_module_notify+0x400/0x55c
	 notifier_call_chain+0xfc/0x3b4
	 blocking_notifier_call_chain+0x68/0x9c
	 do_init_module+0x24c/0x5c8
	 load_module+0x4acc/0x4e90
	 init_module_from_file+0xd4/0x128
	 idempotent_init_module+0x2d4/0x57c
	 __arm64_sys_finit_module+0xac/0x100
	 invoke_syscall+0x6c/0x258
	 el0_svc_common.constprop.0+0x160/0x22c
	 do_el0_svc+0x44/0x5c
	 el0_svc+0x48/0xb8
	 el0t_64_sync_handler+0x13c/0x158
	 el0t_64_sync+0x190/0x194
	Code: f9400753 d2dff800 f2fbffe0 d343fe7c (38e06b80)
	---[ end trace 0000000000000000 ]---
	Kernel panic - not syncing: Oops: Fatal exception

Cc: stable@vger.kernel.org
Fixes: a3fdf784780c ("kunit: string-stream: Decouple string_stream from kunit")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/string-stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 54f4fdcbfac8..00ad518b730b 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -178,6 +178,7 @@ void string_stream_destroy(struct string_stream *stream)
 
 	string_stream_clear(stream);
 	kfree(stream);
+	stream = NULL;
 }
 
 static void resource_free_string_stream(void *p)
-- 
2.34.1


