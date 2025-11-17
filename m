Return-Path: <linux-kselftest+bounces-45749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D5C64633
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 14:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FEF04E8B8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 13:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FF3358B2;
	Mon, 17 Nov 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Z1uA/unQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F77334C10;
	Mon, 17 Nov 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386285; cv=none; b=pVJ1dzYCS44MGvW78b3pNHTLpB4GJ2DoL1iiU47RM2/nh8f6qt1ZL7w+Bq0sZ7C3RZjvlPONHK4SS8oik0hAiQ23oVj1XDBcM4CCPT5ifSD9vONJBY8VBNolsYhlqIEFpRlV93cUVHjp99o71L3d7DbcyaDY8e/tK5diHU6rrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386285; c=relaxed/simple;
	bh=eJuBDNGuRK1zWani3rxt9NUaoN3lvcp+TJtZRlKVcI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LziJgxC3zE4m6p32UBi56bRD1vgZjtUuIMtJF2WLB8PqiC+lgLwMu5rfl+2s1ND1s0XdNNt7r3NuNLV9PGyfuEGc//WAfUcRzEIGAuvpx7th9BjPh6p11BnxTJTYCinPNr07Rw4IZktxSIw07BQESZD9e/F+kwFovxTK5/URkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Z1uA/unQ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=30ysq1zKlbnYeZwp+m2gLXTGDwEJmQJK7zrgP/PsCwA=;
	b=Z1uA/unQOJAeHJXfkKp+yStnZd4muxK8p5GFf9i9u82AOLbVoFgwUMcFfC6D4XNNnKqj1scJ8
	nECxV8SYy1tpy6yxSOp+UOdVnvo1wjm2wdToy8ivrQtR09iAQqYiGzIdYUFSICykJUnQM/3Ya0M
	qsAV5G8NPZQUBPDBZwNEUAE=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d97rV55prz1prKL;
	Mon, 17 Nov 2025 21:29:30 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 148EB140132;
	Mon, 17 Nov 2025 21:31:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:31:12 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <ldv@strace.io>, <macro@orcam.me.uk>,
	<deller@gmx.de>, <mark.rutland@arm.com>, <song@kernel.org>, <mbenes@suse.cz>,
	<ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <kevin.brodsky@arm.com>,
	<pengcan@kylinos.cn>, <dvyukov@google.com>, <kmal@cock.li>,
	<lihongbo22@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v7 06/11] arm64/ptrace: Expand secure_computing() in place
Date: Mon, 17 Nov 2025 21:30:43 +0800
Message-ID: <20251117133048.53182-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117133048.53182-1-ruanjinjie@huawei.com>
References: <20251117133048.53182-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The generic entry expand secure_computing() in place and call
__secure_computing() directly.

In order to switch to the generic entry for arm64, refactor
secure_computing() for syscall_trace_enter().

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 707951ad5d24..9af3046a2ce9 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2387,8 +2387,11 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 	}
 
 	/* Do the secure computing after ptrace; failures should be fast. */
-	if (secure_computing() == -1)
-		return NO_SYSCALL;
+	if (flags & _TIF_SECCOMP) {
+		ret = __secure_computing(NULL);
+		if (ret == -1L)
+			return NO_SYSCALL;
+	}
 
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
-- 
2.34.1


