Return-Path: <linux-kselftest+bounces-29955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B430A76C39
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 18:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32C316ADB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 16:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851D2147F8;
	Mon, 31 Mar 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vYcuHjFZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HS5nx1zI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08C1E47C9;
	Mon, 31 Mar 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439853; cv=none; b=j7jCb3yXfLvpjav/ibWJrEUBmJDyodh8lx5zdvCjNZ2v1ilc5yJwrBZLmJDf0kjCDEDZidPfjt19fJerSUrg4MC/uG2gZgTOvNFPH91C+snxHRuZTmoTmjvl+a2d6hrdfaEvSEeqcW2yU2LrW7elo/gOpUjwtopjZYHYmnZGxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439853; c=relaxed/simple;
	bh=JqKlDQuXzjsUcrvvN3ujBAWagZ//OblvwLgrNIB+jfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epq8T8hvdQPkyeqNHQNEFPKNLwoRbxHZFDXrbt/q8rhAjaeFaoYcQrvkO17PAw/NaBhSMBY+WCfG/k+zR9Rbf/FItEgAcNPBQGqxXlX/zPCNWqNBe106+OhfXczW4SeAaxP0ySgBYM48XnzOC0oh87ii1Gl3S4KvSL4Vwj2ppKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vYcuHjFZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HS5nx1zI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743439850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBPp69KpEetCt+Or6JrG0k52llQ+2PSTJOeU1Zxb5PM=;
	b=vYcuHjFZRZ6yS0WB4mv/ed/EuZR9Vo++DyFXKC9gQLbTkvuzoBsyFcaNGmHBvaxYTx6hZ4
	KUBdUlk3ZVnwB1MqeagtG+ZNNBLTzTohs58+6sLfFvWKFxw7QB2eTcefRR9wGn934hz4lS
	Dzpn3/WnvsbUgvuDX0np4faDhdNeQmy9DP16TV2kvfQB4+LI7/VYiBbxJxbHkO+XQC6dIR
	4Eptif6zJZwIPqXD3qq67VfQW7Y3fPHbNRDClTFBJnKN3m5VaF/zPTn9mXeoow4LIjdo4i
	0BMhFgKFU5jCEr/YxVr6tBu9n7QoxhzPONYOIm+iVl8DeuLfFwdwBLmiAtVhKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743439850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBPp69KpEetCt+Or6JrG0k52llQ+2PSTJOeU1Zxb5PM=;
	b=HS5nx1zIGdtiWhJE+3lq5WU/ejXiR/f61Ovt9P5ZMzlQ/Vljx+JETQizvD9ISjP1ZnLuiw
	0tpv1f88pRkEcSCg==
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/3] selftests: coredump: Use waitpid() instead of busy-wait
Date: Mon, 31 Mar 2025 18:50:43 +0200
Message-Id: <133d0dc62cebb6fde2764af384b0166d98755a3c.1743438749.git.namcao@linutronix.de>
In-Reply-To: <cover.1743438749.git.namcao@linutronix.de>
References: <cover.1743438749.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The test waits for coredump to finish by busy-waiting for the
stackdump_values file to be created. The maximum wait time is 10 seconds.

This doesn't work for slow machine (qemu-system-riscv64), because coredump
takes longer.

Switch to use waitpid().

With this, the stack_values file doesn't need to be atomically written by
coredump anymore, therefore simplify the stackdump script.

Fixes: 15858da53542 ("selftests: coredump: Add stackdump test")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/testing/selftests/coredump/stackdump        |  6 +-----
 tools/testing/selftests/coredump/stackdump_test.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/coredump/stackdump b/tools/testing/sel=
ftests/coredump/stackdump
index 96714ce42d12..ad487fd5ff15 100755
--- a/tools/testing/selftests/coredump/stackdump
+++ b/tools/testing/selftests/coredump/stackdump
@@ -4,11 +4,7 @@
 CRASH_PROGRAM_ID=3D$1
 STACKDUMP_FILE=3D$2
=20
-TMP=3D$(mktemp)
-
 for t in /proc/$CRASH_PROGRAM_ID/task/*; do
 	tid=3D$(basename $t)
-	cat /proc/$tid/stat | awk '{print $29}' >> $TMP
+	cat /proc/$tid/stat | awk '{print $29}' >> $STACKDUMP_FILE
 done
-
-mv $TMP $STACKDUMP_FILE
diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/test=
ing/selftests/coredump/stackdump_test.c
index 1dc54e128586..733feaa0f895 100644
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
@@ -131,12 +131,11 @@ TEST_F(coredump, stackdump)
 	/*
 	 * Step 3: Wait for the stackdump script to write the stack pointers to t=
he stackdump file
 	 */
-	for (i =3D 0; i < 10; ++i) {
-		file =3D fopen(STACKDUMP_FILE, "r");
-		if (file)
-			break;
-		sleep(1);
-	}
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	file =3D fopen(STACKDUMP_FILE, "r");
 	ASSERT_NE(file, NULL);
=20
 	/* Step 4: Make sure all stack pointer values are non-zero */
--=20
2.39.5


