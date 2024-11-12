Return-Path: <linux-kselftest+bounces-21847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6AC9C503B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 09:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A023B280E5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D8204932;
	Tue, 12 Nov 2024 08:03:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0219D067;
	Tue, 12 Nov 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398625; cv=none; b=N6udRoZJm6Xr8fheIAmqEkhzp04vBIcczDz7zr8eb8kKs/Q/mMbb1ZPPL9HojBfdpNPliHYevGAYCvi9gIp8X89sXvoeR0X7ELE0YAvK+GFf7Fiu4jGazm3n4eefJ0K6Ate7kFucVqw+xKVovMWLAUkrELzvfxBSi3GQ/lrgZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398625; c=relaxed/simple;
	bh=2Wm92elPAtztDmT3Kx85R9bXNVMbAhWA0esUZf8fJzo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TjHuyWdg7PDjU507g1UczESCnkS4aJz+/RQuqmKzxIgxBvgMfWApWIOkdNA+z9M7TdCAp46TZczbyBlCX4OP6VcUQ+KT7DuDeO2A/OS4N3erqNqhFFSz0H1dLz2wZQNXwc/lbFEsfcRtAplBAHxVyfD+0+5mADqAu66wUpZnx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xnf4J5ktSz10Mf1;
	Tue, 12 Nov 2024 16:01:04 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id B6B071800F2;
	Tue, 12 Nov 2024 16:03:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Nov
 2024 16:03:31 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <visitorckw@gmail.com>, <brendan.higgins@linux.dev>,
	<davidgow@google.com>, <rmoar@google.com>, <skhan@linuxfoundation.org>,
	<rf@opensource.cirrus.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] kunit: string-stream: Fix a UAF bug in kunit_init_suite()
Date: Tue, 12 Nov 2024 16:03:14 +0800
Message-ID: <20241112080314.407966-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

In kunit_debugfs_create_suite(), if alloc_string_stream() fails in the
kunit_suite_for_each_test_case() loop, the "suite->log = stream"
has assigned before, and the error path only free the suite->log's stream
memory but not set it to NULL, so the later string_stream_clear() of
suite->log in kunit_init_suite() will cause below UAF bug.

Set stream pointer to NULL after free to fix it.

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
Suggested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Correct the fix way.
- Add Suggested-by.
---
 lib/kunit/debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index d548750a325a..b25d214b93e1 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -212,8 +212,11 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 
 err:
 	string_stream_destroy(suite->log);
-	kunit_suite_for_each_test_case(suite, test_case)
+	suite->log = NULL;
+	kunit_suite_for_each_test_case(suite, test_case) {
 		string_stream_destroy(test_case->log);
+		test_case->log = NULL;
+	}
 }
 
 void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
-- 
2.34.1


