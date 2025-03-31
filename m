Return-Path: <linux-kselftest+bounces-29956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE13BA76C3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428AB7A3E31
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC2214A79;
	Mon, 31 Mar 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bb/jdihU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKG8H3RP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED7210185;
	Mon, 31 Mar 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439853; cv=none; b=enp/kGAaMxC23Q40ILGnD21fYdPqQSpKcvisVEt3EmifZXgzPUNhSoRcx4czLD6Kzr9otIpJWCwEnB1w1Oro8xyVTNAaMPKn/Enkin8K/jwh7YzbJOEIo/hh+LSwnOCUGou1j/V2w8pJ8NayQtrFP+oOyjuUzqSctci5k0ksRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439853; c=relaxed/simple;
	bh=vfd7GsqSM1N+IaBAQA6GTPL3evHFk1Bl+lKqhv8ePws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCvrdWuRGxj7fSvuLLnDsBPabAwd4FblFHtI04bTLHb5OXLrRCZ8ezxD61mvZJF55fVqJlyUFLB3YGvMGOgek8VJC9pE81cvIwRTcmQ57LdRRjpN6R9O/N5fDZh4SyLSiQeTVWAu1M6ls1xnh7UsBpWO/4Ao4kGo2fK3eBkCAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bb/jdihU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKG8H3RP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743439850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TSq+iUEvcTWreQkuBF7G0xi5S2XYUc6egrdiVdP/W8=;
	b=Bb/jdihUtYcy4+Ou8JRMLwMSU/KNNwvZzu8AlG6SUFGqQaSNCLTS92UedD0tL+tLN2s6D0
	9ZFy1NRxifwcjWiKdsFZrvsRkbufwk2e+uxWBaPYQ2ity5hCZsTtIHKqxzhk0U8oQj5p9Y
	55h3BPkp4SuMDxey8CDmoAI3akio2ONkijEZiwvv9q3pbIpKw2C8YMGbW9qOBXT5UDElvY
	7MbrBKWsJZiZewx33umgg7T2/b4TyISFBx6G93HEb6ba9ndIjjQ4WKkI8EW4LzMzmkRyxC
	yt1cAr8lZ9UT+eqS2AoYYxc9g2H5stt8vD4GG2m0HBt0qxEUXTMh9O/N13LyDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743439850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TSq+iUEvcTWreQkuBF7G0xi5S2XYUc6egrdiVdP/W8=;
	b=LKG8H3RPmgAQrHsD+8FsCrJTHRt1qCZVfwvFqHFo1ng4w/9UaTGWec32OKF+FBtGmUewV/
	MqCR8mplE80/7CDg==
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH 3/3] selftests: coredump: Raise timeout to 2 minutes
Date: Mon, 31 Mar 2025 18:50:44 +0200
Message-Id: <09fe0146860c63dff734fab0c1ecea6ea39c2cc0.1743438749.git.namcao@linutronix.de>
In-Reply-To: <cover.1743438749.git.namcao@linutronix.de>
References: <cover.1743438749.git.namcao@linutronix.de>
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
index 733feaa0f895..b1924acf02af 100644
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


