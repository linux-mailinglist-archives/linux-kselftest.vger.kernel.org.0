Return-Path: <linux-kselftest+bounces-41688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C345B7FBCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F203189927E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621E424E01D;
	Wed, 17 Sep 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/eCfV2A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W52crnUP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB90231829;
	Wed, 17 Sep 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117717; cv=none; b=JOjRSeNujM4AB/+fNZa2hwcL0GS549QVkHWDAoORgkga05cpb4RShDmhQsExp/qNJ3yWu7Q4fz6Ga6ZXrY8PWDbgviGntFBvvtjurOXOjSICl78G14njRsEWxab2bGLzX/eEKn/4HsS0Wi/SEax2Yr96Jq24pR3wFyGy2Z6yv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117717; c=relaxed/simple;
	bh=dxGml88YTpXNwHnjeiwW+9wKR4AFCzeF66t12h2yWw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+biXkGPhLXnf7usT4GuwMA0JBES7/wTNB1IAgmxhhGYgPfTny75m/+VJnNnk9bA6yyYTvOHWZDF0TltqoBSIaMxcFm0RXWd42jepJXAyieDK29RTmM83j6bfEdQ6oyIDv8r/n9dZ23UY+BXlcOM4IAPlFQpDyJqJA+TuDD5YlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/eCfV2A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W52crnUP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFIP54MniVnf5EGTPufMPHxf8fheB3gBmBURTuq+XGU=;
	b=i/eCfV2ABDukPucI//PpdUU6LyRgVE7dTk4Y3llVycTxBgeaHfxGv4H7xFOfNwsnaVK1LX
	seAOSwR26e+BWCgwfg5jGjjlC35yBOCPat7SR1y3H9gqKi20Cyzep4jF4C/378UlMhKUSG
	3CZM+K2ro0Yp7YBYV71cDYZ0HIMQTIZbXBej0a6adC/LwjmzRHztxFcrKWFmZAjSvLTg04
	OymWERZlqMGeQVpYHJOYjf0l+VyVNo7pkjXu4ID2BwIscuRnA2SZG/Y1iVfqvYosSt46fh
	bcI5/PtrP+k42mFKBQfZjDEjahQjXKKMbKyATPm0kh1QNtOEq+YnNJGJzM7+bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFIP54MniVnf5EGTPufMPHxf8fheB3gBmBURTuq+XGU=;
	b=W52crnUPJPo5c/eZsQSqy+QH+36zi5qvwsNv2i/19gU+8PzDGN0z09KNoWmlDihoGaxSkB
	NrAyvyqo92+GiECg==
Date: Wed, 17 Sep 2025 16:00:03 +0200
Subject: [PATCH v3 01/36] selftests: vDSO: vdso_test_correctness: Handle
 different tv_usec types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-1-3679b1bc8ee8@linutronix.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
In-Reply-To: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=1534;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=dxGml88YTpXNwHnjeiwW+9wKR4AFCzeF66t12h2yWw8=;
 b=Dk+6/flxkQ7mCLObWWzjjfhsBrtGVvmXzlgwZqiEoYabErEDOFsuZj7cl/cvPbRgZFxB+bbcJ
 GZDq+9Kqu4mDeKk5EPXUZQw+1+jRoftv+NJBFWVnT5eQnfylN0dXmdu
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

On SPARC the field tv_usec of 'struct timespec' is not a 'long int', but
only a regular int. In this case the format string is incorrect and will
trigger compiler warnings.

Avoid the warnings by casting to 'long long', similar to how it is done for
the tv_sec and what the other similar selftests are doing.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index da651cf53c6ca4242085de109c7fc57bd807297c..5229fcaae8194d51b2cdffdbae59f00cfaeb96dc 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -412,10 +412,10 @@ static void test_gettimeofday(void)
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
2.51.0


