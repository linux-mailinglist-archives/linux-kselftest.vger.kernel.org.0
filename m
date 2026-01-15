Return-Path: <linux-kselftest+bounces-48998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC03D232E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF2531BDC69
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DFC337BBA;
	Thu, 15 Jan 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1M6XrE2q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gftZgSNC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280B3376AC;
	Thu, 15 Jan 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465814; cv=none; b=S6Dn5hA/dbnDK+ntPPylL/UpZMECgASLS5R7tw4IcWAuDc4EozCCaPAXLlVYEx1Ixvb+me9nEQ6ehoXF6BTsG8bzw2EaZsMU2JU6LZF9yHwd8F4k7Rh1sV0bElZA3VypTX9iCRdzscmHelqFNGViNMYD8uXD6qwTDKIk9jfE90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465814; c=relaxed/simple;
	bh=d5u4jVkOe54xPXSa2SGMxn+ig8mxSln3f2hshXkA/u8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QczhS/15BysizDk7RyB+i/maey41ubFPZ/h6zg02RHluN8hBRjA2PRK6Pp5e/+YiaWkRIEo4ofbsuWaGUmUFEVePXxC9MhIGjUBMlhvwUn17i9qxHJ8ZnJCDpDM7cbnwF2OU+9GlURAT1hR98VR7kL8Zl8UWf0wuKMuAjx2B738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1M6XrE2q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gftZgSNC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768465802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2ElU1OUk7NhzldoS3gWwQ6sGhWNatcq3kzNXwmpiAA=;
	b=1M6XrE2qw80s6vFsTdo2TF6G8rD+0Skcg29W3fy1ACCP3qN6WW2UvGB2Yad4+vSM5sWXa5
	4V+ZaQpk9SA/AB4LS9gO0SE1LqS0Hvt8jprtsc0noytDXswsa0bwVAzlW6jYz/2/ygtU4m
	fqzR+GwNGUJuTLBOOVQy2PnL7gIaaR7hSjK6WiFOkMaYg2gKJAMuaZ4EpR4TAwOq8uYwqz
	KKBDQ56bycvqI4IoLHbvv3ed01ND8RTvMf1YOmu1ohOkgrVWVBIiDK5PeVIxkhnxLIx0/j
	Y4ViMAElO6qQ18QjWbAbYXIjz0er5gElkG3sjHBgA0yLKuxNcjS5trkvU4gnOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768465802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2ElU1OUk7NhzldoS3gWwQ6sGhWNatcq3kzNXwmpiAA=;
	b=gftZgSNC7Uoq7gXqG8uHVLCETJzGi6EliiesI9OsvkCYqVAGq6N7BKYugTau+CfY0GgzxG
	KH5wfc6MFaXrLMCA==
Date: Thu, 15 Jan 2026 09:29:56 +0100
Subject: [PATCH 4/6] selftests: vDSO: vdso_test_correctness: Handle
 different tv_usec types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-vdso-selftest-cleanups-v1-4-103e1ccbfdc3@linutronix.de>
References: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
In-Reply-To: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Andreas Larsson <andreas@gaisler.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465799; l=1580;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=d5u4jVkOe54xPXSa2SGMxn+ig8mxSln3f2hshXkA/u8=;
 b=/74q3qt/tipah4q+SlHvAMoqWj2HXC1stblxmbwHYZlYZpVmZs6jCCN+8AD7lffTxpp2scEiN
 9nmZziTG/4UAzP2/9m6Vw24sKxn3pv2jtCvU9WdhJRMT67FKc47rx3u
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

On SPARC the field tv_usec of 'struct timespec' is not a 'long int', but
only a regular int. In this case the format string is incorrect and will
trigger compiler warnings.

Avoid the warnings by casting to 'long long', similar to how it is done for
the tv_sec and what the other similar selftests are doing.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 2a2d9b01a938..9b564888e74d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -404,10 +404,10 @@ static void test_gettimeofday(void)
 		return;
 	}
 
-	printf("\t%llu.%06ld %llu.%06ld %llu.%06ld\n",
-	       (unsigned long long)start.tv_sec, start.tv_usec,
-	       (unsigned long long)vdso.tv_sec, vdso.tv_usec,
-	       (unsigned long long)end.tv_sec, end.tv_usec);
+	printf("\t%llu.%06lld %llu.%06lld %llu.%06lld\n",
+	       (unsigned long long)start.tv_sec, (long long)start.tv_usec,
+	       (unsigned long long)vdso.tv_sec, (long long)vdso.tv_usec,
+	       (unsigned long long)end.tv_sec, (long long)end.tv_usec);
 
 	if (!tv_leq(&start, &vdso) || !tv_leq(&vdso, &end)) {
 		printf("[FAIL]\tTimes are out of sequence\n");

-- 
2.52.0


