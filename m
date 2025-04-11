Return-Path: <linux-kselftest+bounces-30613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DEFA86162
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274231BC1072
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D1520CCF5;
	Fri, 11 Apr 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ruo6dH/x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CqakS8R9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571F204C09;
	Fri, 11 Apr 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384195; cv=none; b=hVsbitNoVgkf5ap4pZb4irk9rnnFKiISpHHXMSAEu+l0C8Sa1fcZnrzVJVKDYQRdH5gbnJxT7t5jxTeFFIQnAsoe51dBr9ZO6FQng3eQSrHzSDSfxHSD0tIP0NUrYOYX7LRdqNloxaafxt6yqH+EGaUlBALnat02+5toJttauZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384195; c=relaxed/simple;
	bh=JegbAesfKsXVnJ7Bg4TxFD5E25Z3OL2aVo6miAOwyOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z8vwCvEkqMNuR1epiThkLWo0RAKr5k53SuGWikKj17vzv3akcwa2W4coTF/cdq8ZznvHcqQoN/jEJQgXEWEvUsCLmKw8uD13ecb0QxI429lGJmpwsUvzrjgYKpUmn+RGqUycQ22G2mMKRa88+MOizFzBpfukMdK5uzmvyWx6vxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ruo6dH/x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CqakS8R9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744384192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYQXJ3zmI4IiPEkNK58wbFDZKNRbM19pIX0dWKh4BBs=;
	b=Ruo6dH/x1Ezha0DfOd6a6sukapG75VMltxom7mmAJ2dampz2cEW9tPiRD3GdsiGQCigtFv
	SYT0iop2Cx7JB3DHaZhPbZ0NfxeCx1Gg67Kc7MVOcTtWF1CHCz1oKHgMXUPlNOqYm8zo0+
	WCrvBf61uyFn5QKzXHlV+rDLgC6oa2G37oqg7I7JRJ6x4/DmQxnGRDCw6TvdB5C20Zk7mM
	df14kKKpV3f/ytd6OHgRmSFWROhVvSdWxVMM1QUbI8+VvVDA2hh/b4XW3k271TyUN1VxzM
	tvFbUdp2/YFQfy2YxdaE9DR2F09tEmQMUIUw/Gx3nSmanMh4JtxBw16w/oSR3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744384192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYQXJ3zmI4IiPEkNK58wbFDZKNRbM19pIX0dWKh4BBs=;
	b=CqakS8R9lkjMMSd16aTHqSrr6OJUziqdUkHzEBAN6Rrf8TEIYBiPbU9mrraMHq0SxGTVNL
	giy0pFRpLd0COxBg==
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 2/3] selftests: coredump: Fix test failure for slow machines
Date: Fri, 11 Apr 2025 17:09:42 +0200
Message-Id: <ee657f3fc8e19657cf7aaa366552d6347728f371.1744383419.git.namcao@linutronix.de>
In-Reply-To: <cover.1744383419.git.namcao@linutronix.de>
References: <cover.1744383419.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The test waits for coredump to finish by busy-waiting for the stack_values
file to be created. The maximum wait time is 10 seconds.

This doesn't work for slow machine (qemu-system-riscv64), because coredump
takes longer.

Fix it by waiting for the crashing child process to finish first.

Fixes: 15858da53542 ("selftests: coredump: Add stackdump test")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/testing/selftests/coredump/stackdump_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/test=
ing/selftests/coredump/stackdump_test.c
index c23cf95c3f6d..9da10fb5e597 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -96,7 +96,7 @@ TEST_F(coredump, stackdump)
 	char *test_dir, *line;
 	size_t line_length;
 	char buf[PATH_MAX];
-	int ret, i;
+	int ret, i, status;
 	FILE *file;
 	pid_t pid;
=20
@@ -129,6 +129,10 @@ TEST_F(coredump, stackdump)
 	/*
 	 * Step 3: Wait for the stackdump script to write the stack pointers to t=
he stackdump file
 	 */
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_TRUE(WCOREDUMP(status));
+
 	for (i =3D 0; i < 10; ++i) {
 		file =3D fopen(STACKDUMP_FILE, "r");
 		if (file)
--=20
2.39.5


