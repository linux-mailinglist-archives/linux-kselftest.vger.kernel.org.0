Return-Path: <linux-kselftest+bounces-28176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BCA4D483
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5E3174806
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5141FF1D1;
	Tue,  4 Mar 2025 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DTNZ3d99";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCu+hbFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DC1FCFFB;
	Tue,  4 Mar 2025 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072287; cv=none; b=jJ0WvxZi7O8L87Ojmts0sMgdBTiJJEkEdFKEIjSSqPIoqWYSXntmHFqT64K3BEN5OUFXi1GRNG/FWfMuW6Q4DOfWTjL0IwwJ6gRa/wV9bw97XIUazwNnr9r4lcLyFXNb0kuXuF/4o4Lf9VUl7Yz9U5Z0pPSuthf/jpMxIkmJkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072287; c=relaxed/simple;
	bh=F+4L6Lcnwfanmt5Kqdkvi87g3JgnQgxpyb3eeUpp8po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/115ltsDEMp71I+81DdPef3CNbykcVKL80D8yoebqyL41jK/T5V94cEOTkRiyi+OpzWKox3Sg24+6HXlF/6/932WTu7hNoL+pbNcI+2ogZMHm4x0EbIYaQhIKJ78w7Qo6/bSqJCVVEe/6bOK7FlxagdUjoGBq/x2aI9kSK9JtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DTNZ3d99; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KCu+hbFU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jolyi30wjQpEq7ly7BNkZpNqTbniwn3HizEwB2dNsZY=;
	b=DTNZ3d99XogvvQj/vxCMTpOouYsqEowtm1ID5ToKdoP2PeVSHAwoeHk4ARGQbQvEwiX4Xd
	UoKp1o+3G7y03iwapnKdh1IoZxXhaSCha2ShkEqGTxYBsNny/oFF5AO/lkQliyAinzxf8z
	pZ2FuvKILOu9V9FZpn2UbOVACDxRWhesLp1Bf5fneboXpjc9okNKQD8+UMhz8XnCV/IXJn
	PTNxG6/aZiItbeWlbbL+PecK0J2iuU9mcFiT9Y/AGrwajfySnr8GJkjDUY79cRoykZOT65
	yE5AspxDdvPP0+COoTZ8cuU1D/OOXLTdbqFClXqPescql5jqKx269Cd0Y4Ax6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jolyi30wjQpEq7ly7BNkZpNqTbniwn3HizEwB2dNsZY=;
	b=KCu+hbFUB08/qsKpGY+N/XZq0J46mb1JGeHy58y7Qxgcoz0f7tSq5Z/Wyy61/hrAMk1H83
	qfYgVESM7eQg7mAw==
Date: Tue, 04 Mar 2025 08:10:59 +0100
Subject: [PATCH 29/32] selftests/nolibc: rename vfprintf test suite
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-29-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1259;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=F+4L6Lcnwfanmt5Kqdkvi87g3JgnQgxpyb3eeUpp8po=;
 b=4lYomLqaCL6x45tqww+3yPOX/dkk26DnxQgwZZxEEO8+1DVdVHNHsv3ZxuHo/OypFjKknmroo
 Q5SpbGadjgvC5JS7iHfm9sJqbTDv2+apmSNh025p4kGEBCQWrDnhIH+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With the addition of snprintf() and its usage in nolibc-test, the name of
the "vfprintf" test suite is not accurate anymore.

Rename the suite to be more generic.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1b60eb848c02ef4e90782a83e90987b7efb71031..a45fded42c14110c97c4c899d04dba8e676dfd49 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1373,7 +1373,7 @@ static int test_scanf(void)
 	return 0;
 }
 
-static int run_vfprintf(int min, int max)
+static int run_printf(int min, int max)
 {
 	int test;
 	int ret = 0;
@@ -1534,7 +1534,7 @@ static const struct test test_names[] = {
 	{ .name = "startup",    .func = run_startup    },
 	{ .name = "syscall",    .func = run_syscall    },
 	{ .name = "stdlib",     .func = run_stdlib     },
-	{ .name = "vfprintf",   .func = run_vfprintf   },
+	{ .name = "printf",     .func = run_printf     },
 	{ .name = "protection", .func = run_protection },
 	{ 0 }
 };

-- 
2.48.1


