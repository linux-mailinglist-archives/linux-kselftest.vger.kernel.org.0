Return-Path: <linux-kselftest+bounces-30612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9479A86159
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 17:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C314416D4D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B420C482;
	Fri, 11 Apr 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKqMeb/X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3OuGrdY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556C5204840;
	Fri, 11 Apr 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384195; cv=none; b=JiWO0QsLZ5t1R9csN2k8atHuCQRJQLlnMQpaEkxgwfoKCA90o6yJ7MD2xppbybcFuYUm8bupM1/q+I/r96DrUfGxti9yL6TMJxb+Xg3vL/juDmXWggf6VZh1ZMYGV/ElkgDmMI4x8k1tnfjH4trEWgrAgTncx1X0NaZ0ZG5sN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384195; c=relaxed/simple;
	bh=ug2x1eGGc/292yTUbC2yb/U4/i1fnrOBUIn136WaKcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EXPRXGVyDp6uZZJWmPhv9uYZLXHch+oxzeTIHl7sNJAK+bn9MrbxNaXl6PB4isSAVeqq4qj/D9ArrG4AfuxpxG6uIXm1XGc0sFL5TyKfYMUltsdNV1yyhRJ6OkZlgiy372ilZC+pLaGo5+azkvWIxv9Epx2A1VeqLEEazZTQdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKqMeb/X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3OuGrdY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744384192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=332I2pBj+SBhHax9EjMYVSa2gzrL4NUN8QjGS26dHIo=;
	b=GKqMeb/XR+JqRmUD+nJZeLoT0UC6xJTXpISZj3PT3EbgK2Y0Hh/a9nnsO1/2gq9Qj01aIf
	rk6PTTi0dBwFkC95eeJtYsnq4qyCOT7nT2RlfwHZTCqUIGzHVZstbNFnP9wrybDfsFoCMQ
	MdunhtyIjbifvMRjghDCEMldKkZDiE+PgLYzfaxUa+PpjgqcRIxlDjN4m2y/oKvmpmLnvE
	kpryZRGpJP4uBy+0zBQrTP9jNyHvoB2TJpjvAevbs/Zq0/lVePz12ATedcoBnm/1Et+GAT
	rt5V21OFe5hjyo0RccIpXOQnH7OqtSDeu37mNjfpg7FdJ2NIbo0Pq7CPS687fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744384192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=332I2pBj+SBhHax9EjMYVSa2gzrL4NUN8QjGS26dHIo=;
	b=O3OuGrdY1JKU8Y3KijiyS9zzmzl5OILbG7Duu8Lh1ajgl8CNNzzr7aAglNrmN/oGseO9oi
	Gawd2fLmZQOoYKAw==
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 3/3] selftests: coredump: Raise timeout to 2 minutes
Date: Fri, 11 Apr 2025 17:09:43 +0200
Message-Id: <dd636084d55e7828782728d087fa2298dcab1c8b.1744383419.git.namcao@linutronix.de>
In-Reply-To: <cover.1744383419.git.namcao@linutronix.de>
References: <cover.1744383419.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The test's runtime (nearly 20s) is dangerously close to the limit (30s) on
qemu-system-riscv64:

$ time ./stackdump_test > /dev/null
real	0m19.210s
user	0m0.077s
sys	0m0.359s

There could be machines slower than qemu-system-riscv64. Therefore raise
the test timeout to 2 minutes to be safe.

Fixes: 15858da53542 ("selftests: coredump: Add stackdump test")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/testing/selftests/coredump/stackdump_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/test=
ing/selftests/coredump/stackdump_test.c
index 9da10fb5e597..fe3c728cd6be 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -89,7 +89,7 @@ FIXTURE_TEARDOWN(coredump)
 	fprintf(stderr, "Failed to cleanup stackdump test: %s\n", reason);
 }
=20
-TEST_F(coredump, stackdump)
+TEST_F_TIMEOUT(coredump, stackdump, 120)
 {
 	struct sigaction action =3D {};
 	unsigned long long stack;
--=20
2.39.5


