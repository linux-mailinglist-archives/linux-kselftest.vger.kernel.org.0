Return-Path: <linux-kselftest+bounces-21532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DED09BED57
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 14:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114892859BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963A1D619E;
	Wed,  6 Nov 2024 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SQL7HMtK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E51F9413
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898306; cv=none; b=Hq2Q0795EQZITBIrz1ySO7x75mC20hBJzmoUQoQE4SFbIJRFuSvPnB9xUqst6c/tmXgTTd6CMiBDht3KgaL9Kc88IfC6xb/iIBGxMuvmNWKoJQtkcagbc7i3o34jnS/gp/P9Dxnb5O8r50EZRZZxT5QorPldzQv9KcQ5pZcqkNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898306; c=relaxed/simple;
	bh=i7MiKgj5PZI5/D7cKMTNOlgDFHng4HO19l7BB3vVgXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5aPHzavmz8WO0aN5fSSHZoMxVXmX/xAyMaZlLG/7fhXT7Wg7dQGP0BQKW3kSQMyKJeEMOTzcdIo0QNml/yPDYRy9vpqNv/QDt7HleRGoP99jJygm2zxFG/3B1JZmn5f3842hY+Xx8XsDbqVF+2MdnC7AnF11Sox0gGREkSJD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=SQL7HMtK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730898300;
	bh=qW1N95F/0dD6RAC3La/bvo9UN0+AgyqUeekkAk1k6sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQL7HMtKB9Hzn2YPrMPHbq0vPs6NsVSht0OT7tdD9x+9gug0bqDOx2Userp1YqU0A
	 LaITNIBj5YA3tobZeSvf/fXVFfKCSlzKhf6AsEucgkuv4yGEIXZC++LFbPIKEhkOWo
	 Yv9D/o4f1Eb1zvzlIdtljGnWAuhU/g85s4dx31LInHY0NcYKNIX+QbqDXEStRSIvSF
	 JyT/H1dDoWLoCt20RshW3skimRp5SCQ0cKNecMoUfrUcynaMxT1T7ykOPnSitDMfhC
	 5st1y+65BuGhidC/ebn1oASoEX6uQwIoz8pY6xNmUmAZwCs/1Iytw7vU68+m0oBlZZ
	 T40dKXJADn3Hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xk55m5vnLz4xRj;
	Thu,  7 Nov 2024 00:05:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kselftest@vger.kernel.org>
Subject: [PATCH 4/5] selftests/powerpc: Return errors from all tests
Date: Thu,  7 Nov 2024 00:04:52 +1100
Message-ID: <20241106130453.1741013-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106130453.1741013-1-mpe@ellerman.id.au>
References: <20241106130453.1741013-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some tests which weren't returning an error code from main.

Although these tests only ever return success, they can still fail if
they time out and the harness kills them. If that happens they still
return success to the shell, which is incorrect and confuses the higher
level error reporting.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/signal/sigfuz.c                | 2 +-
 .../testing/selftests/powerpc/tm/tm-signal-context-force-tm.c  | 2 +-
 tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c    | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/signal/sigfuz.c b/tools/testing/selftests/powerpc/signal/sigfuz.c
index 08f9afe3b95c..c101b1391696 100644
--- a/tools/testing/selftests/powerpc/signal/sigfuz.c
+++ b/tools/testing/selftests/powerpc/signal/sigfuz.c
@@ -321,5 +321,5 @@ int main(int argc, char **argv)
 	if (!args)
 		args = ARG_COMPLETE;
 
-	test_harness(signal_fuzzer, "signal_fuzzer");
+	return test_harness(signal_fuzzer, "signal_fuzzer");
 }
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
index 421cb082f6be..0a4bc479ae39 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
@@ -176,5 +176,5 @@ int tm_signal_context_force_tm(void)
 
 int main(int argc, char **argv)
 {
-	test_harness(tm_signal_context_force_tm, "tm_signal_context_force_tm");
+	return test_harness(tm_signal_context_force_tm, "tm_signal_context_force_tm");
 }
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c b/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c
index 06b801906f27..968864b052ec 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c
@@ -46,6 +46,5 @@ int tm_signal_sigreturn_nt(void)
 
 int main(int argc, char **argv)
 {
-	test_harness(tm_signal_sigreturn_nt, "tm_signal_sigreturn_nt");
+	return test_harness(tm_signal_sigreturn_nt, "tm_signal_sigreturn_nt");
 }
-
-- 
2.47.0


