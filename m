Return-Path: <linux-kselftest+bounces-47917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C6DCD8526
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 08:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBF2B3030FF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18E7309EE3;
	Tue, 23 Dec 2025 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="blCiFHJw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZaXbnglG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305373074AB;
	Tue, 23 Dec 2025 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473169; cv=none; b=YdXTpNbdOtYJnt4DSYoixv8eYc3p5Hzu4pnt1Fvpw9PQEzeQHG9a+oeUUjkw0516teYVgV5Cqw88KN54+n3iH2dVMCaSDG7YQSvNTgdUgrJmsPnaLSIz5qNAhdMcqx6ukzC93MKLmpa+8rVlhk1SV1QJrfcsz+6jgBstUhP70h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473169; c=relaxed/simple;
	bh=+SXAsfJphfIrvDszr56VyWDDLyMl5UJIQY3RHDubCt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnNnSh2ReB2SL9aWk0nFTw56MJSW/P5Ecan1wsM3n6wx4bygwDobfAZNJtekw1c4tdiSny33MAKXJbXnxqyKpRqH4ynZOgh7GFq5pkyNjD6+5RfXSf7S0lR1zvOBDmgxnfDyO6+zlhAOmna2fd6Vwi5fw8/4cgTHZhOh4BjMhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=blCiFHJw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZaXbnglG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDPjMJktX5CXG0MV0cMYF1xoy0v5P9eoHVtBs/6YCzU=;
	b=blCiFHJw2mRAV9nwsUR5N6L3+ukSSfnvpTxeAKtZRQ1NEq1VUzr7E6tZWQbslgmDrke50e
	C27FaPVWZmTPJ7h9YHRAYFfYu5QAdAzP3ZyPtktWU8z5mM7fEEB1+JBBj2dgxnjb5Ion8W
	G68dpQdI/lAJUS9BSvRerzsyVQ0rmzL/QJLrU05/0NtAb9tM5CQNTHubGebVasejz3S7Hb
	hzlvoFlVo/moVxdc8dN3npjtsF3BJAKakNCDGqqNRWJdkDguD27Ir78ICun9HGV5XTNTXF
	yX2VofiI1MpUOQQ7MeOCMRrGasNDFr1bHbX/wetCkoftIQXjo83Ak0e6fZ1lKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDPjMJktX5CXG0MV0cMYF1xoy0v5P9eoHVtBs/6YCzU=;
	b=ZaXbnglGzz9TnvdPj6mUCHiTlAorZmY88jZbjNgKVgKwDS+5kRvbDCV1WyuHL2KqKvIEs0
	lLzqwNqX06g2XlBA==
Date: Tue, 23 Dec 2025 07:59:14 +0100
Subject: [PATCH 3/9] selftests: vDSO: vdso_test_abi: Use UAPI system call
 numbers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-vdso-compat-time32-v1-3-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-0-97ea7a06a543@linutronix.de>
In-Reply-To: <20251223-vdso-compat-time32-v1-0-97ea7a06a543@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Russell King <rmk+kernel@armlinux.org.uk>, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=1042;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+SXAsfJphfIrvDszr56VyWDDLyMl5UJIQY3RHDubCt4=;
 b=wb277NVSHU6OwOBuItRYOE+qyzBzlMOBeppSwno9BH+tm/ZyHJAKOewX2axUQrpKLxCo4KNw2
 avEoktIEeBXCSQoGtEti/srIu339lEm3z1kmLKuKVW5+Qle5byz+MXN
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

SYS_clock_getres might have been redirected by libc to some other system
call than the actual clock_getres. In the test we want to make sure to
use exactly this system call.

Use the system call number exported by the UAPI headers which is always
correct.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index c620317eaeea..a75c12dcb0f1 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -179,7 +179,7 @@ static void vdso_test_clock_getres(clockid_t clk_id)
 		clock_getres_fail++;
 	}
 
-	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
+	ret = syscall(__NR_clock_getres, clk_id, &sys_ts);
 
 	ksft_print_msg("The syscall resolution is %lld %lld\n",
 			(long long)sys_ts.tv_sec, (long long)sys_ts.tv_nsec);

-- 
2.52.0


