Return-Path: <linux-kselftest+bounces-43076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01252BD79FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C2E3B180D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B182D46B2;
	Tue, 14 Oct 2025 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbS1ivXK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J46V6TKs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF82BE03E;
	Tue, 14 Oct 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424557; cv=none; b=Lb9x6wqMRzF+q+BKiyJAAzl7AUWy7AXWSBPawEXnIlaCZkB0IQsQdo/NWRokrmfeFTcSmgbwc34zyfO6aBDK1u+DTp7SdSPLhPkUnveAXWpBI/SDr8Mlx1t9q2SFjusqp2WQ43kwhX8hyEqKOI3x/SDrT/9D1nFXNcn17vJPpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424557; c=relaxed/simple;
	bh=xwlcFnQEXqQ5ZW5NFBVaIG/RI+shPsghmy7vrrzmGh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKbqwRbUFEE81uJTvVdt+ws5E42SgnGEHOOVt2AUkyeTll+G4TQ447VTUfD9MrzRgrqf9aQ1LQdeMBKluPO3AWNHbulfA7mpzS0hjUuZeoT/i/NkEMTkmHhB7lYTGiKvL9W8X8Nt4YBE4bhpPfn09W+duEpXpqu4uIF7Xd4ZhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbS1ivXK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J46V6TKs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpEp5M7NzfQSiFH2jKL570Ai1wZvStN2XYEWzJ3d1nM=;
	b=AbS1ivXKSxxKvhGecPLcRSNUEWEuw9fn6U9T3JexzRDy4JP8ptlcSanCYF7zLa7B67+Fvx
	vWnzFZpxNxM35GWpLIGZRc6nT8e15qKJ03J0cCqPobHZ10bRDU/JD56SGgEXedarEiedw0
	UmgAgk0wbFazDmiJ/4I1Psqpi57GDcTb2aDqLWjaCwXFbhwedWiRm8Dv/sUI0ZAnVA0DJy
	DKzMrqyjpZb62iR/9tN73/HrfsZyr3QuaxXpuQG1x9YgTtIOXEuBtSM+husw4mfA1Xxamw
	XrpoFznq3OcrLyOV/jN2QbdxFGXTjcVXOHEVMFjepXBXGWwPZ/TOQ/hdp0hORw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpEp5M7NzfQSiFH2jKL570Ai1wZvStN2XYEWzJ3d1nM=;
	b=J46V6TKs5EP3v7C7yqoHXUbYqQbF+JHtlmqZ3FKeLekr9GW27Um+kEL7iiE8relpRw5k4T
	qT89+dQndZVSw0Aw==
Date: Tue, 14 Oct 2025 08:48:47 +0200
Subject: [PATCH v4 01/35] selftests: vDSO: vdso_test_correctness: Handle
 different tv_usec types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-1-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=1636;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xwlcFnQEXqQ5ZW5NFBVaIG/RI+shPsghmy7vrrzmGh4=;
 b=qHfqnjpjjXV61eOxYf7edKHo0slWvZ5SYsA/BifGNprPJAD8Khq30C50W+CTRD32kGW8dw5tZ
 hV7nr3UKiEeCeSt/ajtTzQxWm4toVPCt96lvMzDcV9Vp8mhorWE8oeH
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


