Return-Path: <linux-kselftest+bounces-38753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6ACB21CF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718AF682D00
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A82C21F6;
	Tue, 12 Aug 2025 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F7+/UlEW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QTl4r/8i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272E28C02D;
	Tue, 12 Aug 2025 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977158; cv=none; b=goGiGCD+GvVLZbNt9JnFafgtjThGigXH7FG0A2+wabWT2ZQ6s+hB4GwN7el7lFXc4ox8keVkD1dPsSTY3AiXGp8IOvuUYl20Cx0M2iI1h6jyMnt+Tg6B61clJGL4m3/qVdcw1ohZgKwJ10fnL7qPpWPM2EGtaSMTgZdC+//rvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977158; c=relaxed/simple;
	bh=8lskH1ggdxOTGceff2aWifYwOuKr4MYSx00pX1x86TE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWqHgwoxNVKoa4C9BcLZOxJ+enAY0c7kADTG8BOIIwaA/w2uDk59lwoVEw4KTeb9S5RTfcj/7tzqENkqQoTm2UGa9bnGM0NfMBbMtk0/82xasSkFW1K8ZugZ9+c4YpieAEBBMeAN1yj7e8xJpt4BQpg7T8eGIZdM6FFtCE5ChOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F7+/UlEW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QTl4r/8i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv1iFUT91ndYeuayFYV7x2iCqw5t+n+5VIpTU5JYlu8=;
	b=F7+/UlEW8X8cC1ALL7KCLNIaf+EjzwbtAx9N2PkTvefaLBmg2EeiqkdN0cjqk3+zCW56o6
	FwLNsd1hEg1zxzuY9v0Y5C7k8hQo3hQt/eZLZjdRTdQUb3OSDe2fQojg/zGWCQSsfvrGpW
	0U2Dj8uSWRFqXUZYbOUJQm/I1em7VjqNEr5NlWhHVCww+MMEPmoqGBS4Ywc9qQDHliarug
	pINb6VWodiiTVBlLTJl96XOObQ1nhd7HcGn7/LrIxBzG94qw430eepPWSbkbzE8BATwE7j
	IzjvAWNmMBoafAVRvMdTqio4kX36j6TKm6RxWpE40AVuiijmR79AYFcPjxAh5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv1iFUT91ndYeuayFYV7x2iCqw5t+n+5VIpTU5JYlu8=;
	b=QTl4r/8iwxQyyaXvHd4QHYJiihQ73Ax3H6L4TjlRNYJVTtzz3mk/7S+Iyo5qtDNohGJarX
	Mog1lCDbsD9u/3Cg==
Date: Tue, 12 Aug 2025 07:39:03 +0200
Subject: [PATCH v2 2/8] selftests: vDSO: vdso_test_abi: Correctly skip
 whole test with missing vDSO
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-tests-fixes-v2-2-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
In-Reply-To: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977153; l=1530;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8lskH1ggdxOTGceff2aWifYwOuKr4MYSx00pX1x86TE=;
 b=xS2HDl+yZC3NMqHDtz/fe6u3lkQhR/SJQAw0PBD2gQi6SelYB+gY8aj9Cm62UnOyMwYkPHk+j
 mcLxpRtqio5CzeMhQ88+0/PzFeD2LLFyYGAHnGVCYrcgRkZfzTwuRQl
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If AT_SYSINFO_EHDR is missing the whole test needs to be skipped.
Currently this results in the following output:

	TAP version 13
	1..16
	# AT_SYSINFO_EHDR is not present!

This output is incorrect, as "1..16" still requires the subtest lines to
be printed, which isn't done however.

Switch to the correct skipping functions, so the output now correctly
indicates that no subtests are being run:

	TAP version 13
	1..0 # SKIP AT_SYSINFO_EHDR is not present!

Fixes: 693f5ca08ca0 ("kselftest: Extend vDSO selftest")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index a54424e2336f4597e67668052b62cd7d6c0531ff..67cbfc56e4e1b0edce50d37ae145a054e304892a 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -182,12 +182,11 @@ int main(int argc, char **argv)
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
 
 	ksft_print_header();
-	ksft_set_plan(VDSO_TEST_PLAN);
 
-	if (!sysinfo_ehdr) {
-		ksft_print_msg("AT_SYSINFO_EHDR is not present!\n");
-		return KSFT_SKIP;
-	}
+	if (!sysinfo_ehdr)
+		ksft_exit_skip("AT_SYSINFO_EHDR is not present!\n");
+
+	ksft_set_plan(VDSO_TEST_PLAN);
 
 	version = versions[VDSO_VERSION];
 	name = (const char **)&names[VDSO_NAMES];

-- 
2.50.1


