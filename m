Return-Path: <linux-kselftest+bounces-46993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332F7CA2CCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 857D0303F6FE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2333290D;
	Thu,  4 Dec 2025 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S7xkFUo5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C8332EC7;
	Thu,  4 Dec 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836532; cv=none; b=mtocZtyPCFo0x37aS4hmb/5vQpjSS9E03PNsuyMPQ8gu18KowIzXTl77oqN4+Nyo4JGKlt4yPlSKhSir2rrRTr4UAp680fz5FfMOj8hOwdcyNfGrU2PP+LRd3lfH87JTx/Sly8EF+0x6j3sRAosjocnbE+fLLMOAgPFTy9S0e18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836532; c=relaxed/simple;
	bh=e2EqaLHY+hi8mOpTTTohUlXK6N1GgMucbwUdNtAo4mQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhOmexF8ZG5ryt2sByS/WmdOXLjaFEif4wH6rJMojF7BtHV4belUiUShGyFrJIwdvwnqa5bnkJqWl2okjUkla7b1YYs/Rn2CUXExhcaYBi8D4vb5E8KXJt7GmImcfOJQDUXwx+wOdJxJ8/EqTfemrNVYYA7qDwIds524pUTpncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S7xkFUo5; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=g+Lx46iAeOgPpubr+gkS3rp+7tkakNKdnP1SW8F/O7E=;
	b=S7xkFUo5md6dhTG0nsu8qRM2GgJ9v6v89JBKj8/wzVd31elaHwd1fP2zVW/A3+qqgBnQ+4A7z
	wQSKuQnOtm3YmNhaO5bKVUSjbLwTiKvCKE8XvNbByBo36USluVhNnhXIY0Y4Mhox+LsCBXRGBki
	kDx0a9NwJN4XiI12mMBbuSU=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dMS992zY9znTZw;
	Thu,  4 Dec 2025 16:19:41 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FD0C1400D4;
	Thu,  4 Dec 2025 16:22:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:22:01 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>, <deller@gmx.de>,
	<macro@orcam.me.uk>, <charlie@rivosinc.com>, <kevin.brodsky@arm.com>,
	<ldv@strace.io>, <mark.rutland@arm.com>, <song@kernel.org>,
	<ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <pengcan@kylinos.cn>,
	<dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v9 16/16] selftests: sud_test: Support aarch64
Date: Thu, 4 Dec 2025 16:21:23 +0800
Message-ID: <20251204082123.2792067-17-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204082123.2792067-1-ruanjinjie@huawei.com>
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

From: kemal <kmal@cock.li>

Support aarch64 to test "Syscall User Dispatch" with sud_test
selftest testcase.

Signed-off-by: kemal <kmal@cock.li>
---
 tools/testing/selftests/syscall_user_dispatch/sud_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index 2eb2c06303f2..f53ebc89befc 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -192,6 +192,10 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 	((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A0] =
 			((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A7];
 #endif
+#ifdef __aarch64__
+	((ucontext_t *)ucontext)->uc_mcontext.regs[0] = (unsigned int)
+			((ucontext_t *)ucontext)->uc_mcontext.regs[8];
+#endif
 }
 
 int setup_sigsys_handler(void)
-- 
2.34.1


