Return-Path: <linux-kselftest+bounces-47839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D515CD5DB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E44303058B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76F32AAC9;
	Mon, 22 Dec 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kxKN7EC2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96326329E46;
	Mon, 22 Dec 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404118; cv=none; b=sNdFTq2pO650mHdXr7bmPI0tFubpKy0jFoIYytLiJ8Co7UNUPHMfH0Ewjg0dLLSn6XF7qxPLpNLodxDkueNaXuUkOc8qctIvpcdo7lOMbyDurWBfTMYEBOQsKQkpmbOM305ZdTZhURV243vB9pKKabCWh1KFTtpB1712Qt9nKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404118; c=relaxed/simple;
	bh=DlAuNfHcDAnBWNTtcVAuSZqlrfIHDJ1ArnJPjTEYxx8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDIw3bhsGM8oXJzHcf76+bRQ2R0oEx5rK04ttk0j1ofv6OnYIc0LPZ60YPnhvubzYVWoMsEsyuf7/SQlW3UWGrV2R94DUI6mufQzthpSo88biqwgZ5zDSKRmhP3e7HSL4iQCLf+yxfGXyNarr3P5rScSJbIaNC24jpDWRe8+Bw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kxKN7EC2; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BvR7YcTvE00lWHQbU4IS+hM0Xz5YMD3BeY0bCI8PRBw=;
	b=kxKN7EC2DVzEPw6j55Rh10QT6j69Hd+KHvk8DXRJAuGwYp0b+8ClSH2oAP/Qu/qMpM8Tn1l8W
	CEPoWjk1yUtmwZtnxxYxyGvrPraeB7X3bc1iHrdOeiL7L3Wl06JrHGqHy3X6aGlVpa6E7RIrKBe
	ZWKypiYoDri0zz2+a/HxdoA=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dZbvM0vmmznTXZ;
	Mon, 22 Dec 2025 19:46:23 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A385640539;
	Mon, 22 Dec 2025 19:48:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Dec
 2025 19:48:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<ruanjinjie@huawei.com>, <kevin.brodsky@arm.com>, <macro@orcam.me.uk>,
	<charlie@rivosinc.com>, <akpm@linux-foundation.org>, <ldv@strace.io>,
	<anshuman.khandual@arm.com>, <mark.rutland@arm.com>, <thuth@redhat.com>,
	<song@kernel.org>, <ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<broonie@kernel.org>, <liqiang01@kylinos.cn>, <pengcan@kylinos.cn>,
	<kmal@cock.li>, <dvyukov@google.com>, <richard.weiyang@gmail.com>,
	<reddybalavignesh9979@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v10 14/16] arm64: Inline el0_svc_common()
Date: Mon, 22 Dec 2025 19:47:35 +0800
Message-ID: <20251222114737.1334364-15-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222114737.1334364-1-ruanjinjie@huawei.com>
References: <20251222114737.1334364-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

After switch arm64 to Generic Entry, the compiler no longer inlines
el0_svc_common() into do_el0_svc(). So inline el0_svc_common() and it
has 1% performance uplift on perf bench basic syscall on kunpeng920
as below.

| Metric     | W/O this patch | With this patch | Change    |
| ---------- | -------------- | --------------- | --------- |
| Total time | 2.195 [sec]    | 2.171 [sec]     |  ↓1.1%   |
| usecs/op   | 0.219575       | 0.217192        |  ↓1.1%   |
| ops/sec    | 4,554,260      | 4,604,225       |  ↑1.1%    |

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c440ccb2af62..45ceb8c4316a 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -66,8 +66,8 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	choose_random_kstack_offset(get_random_u16());
 }
 
-static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
-			   const syscall_fn_t syscall_table[])
+static __always_inline void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
+					   const syscall_fn_t syscall_table[])
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long flags = read_thread_flags();
-- 
2.34.1


