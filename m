Return-Path: <linux-kselftest+bounces-30610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C4A86157
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 17:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881D816D670
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AB420AF6D;
	Fri, 11 Apr 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kAFYGY1g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sdqL+MEy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C71F461D;
	Fri, 11 Apr 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384195; cv=none; b=Tyc+4k8O2rhbUoLi6uNuCgXa5FYYmNq5U8eVAWd3H+pX95bPzlnxGqV1nHn/Fe3SRu5HRKWmTKoU8b/lTzKuOkv8/Hq8pVR+LrqvWms2Onyr22dR+yjybp6gt5tdFBZ+MnX8z1UdZW1EH3Z0AekDawGoVTrX45if0ei+Og+4b/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384195; c=relaxed/simple;
	bh=d76UNAhJL2/CvDF5iXg10Cq43S1hVRfl9792k5Y/A0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+K4fzTyF8MIfgqkYezQbGGiOCnwyTJV+04RXD5QfbbI4a54G75hsBC/hg8UiTyv0tmYCTv+g4AOv0jrgm2PT39F8xiPG57whVGNGQLWNuIRn7GQ7A3yAjG+WAcZi5074ctJX8et24NLctaJcwN4h6qE2NBwpYqS2vhCO2WHmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kAFYGY1g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sdqL+MEy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744384192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+on7q0d2sKsDinQinkGf21gwhzzeN5z9itT+eLeiG8=;
	b=kAFYGY1gu6Y1HDzU+BWH7JTJVf/lZgE9f2YKBKE4fD3C08q5v9cZI+Umc0oI4YzfR/ukfM
	2b7XUYFIg4HybLgsZd/+Nhuaoaym8W5PrXQiMRh9sLdvavZi+wf0JOt3O6KPvwZ34uLvxH
	HPYNPxTebFKKVpPxAwZfkldY/R3XUjuYu3bXLzYSGb+abaKQBsyZmwAs8+CCCVD0KQOGXH
	B3u3Wci5ldL2sidJ4TgoR+tgRU+tGV4qbEUaL+CQjmNswaFUSQ1BQswW2qG2PiOedsyh6k
	03bJzilk1pwzOF3wiYvL/LbQH1mCxnhfAGkwDQPdV27FYk9eof7z5TDWWL8Aeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744384192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+on7q0d2sKsDinQinkGf21gwhzzeN5z9itT+eLeiG8=;
	b=sdqL+MEyxoyCN2Wg6HKr3EESb75s7XE21+l21rQ/EQdtjWjihyhKNkYUyPrAwYjUXMIRzm
	Wi8KZSJK7mIEzhAw==
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 1/3] selftests: coredump: Properly initialize pointer
Date: Fri, 11 Apr 2025 17:09:41 +0200
Message-Id: <4fb9b6fb3e0040481bacc258c44b4aab5c4df35d.1744383419.git.namcao@linutronix.de>
In-Reply-To: <cover.1744383419.git.namcao@linutronix.de>
References: <cover.1744383419.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The buffer pointer "line" is not initialized. This pointer is passed to
getline().

It can still work if the stack is zero-initialized, because getline() can
work with a NULL pointer as buffer.

But this is obviously broken. This bug shows up while running the test on a
riscv64 machine.

Fix it by properly initializing the pointer.

Fixes: 15858da53542 ("selftests: coredump: Add stackdump test")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/testing/selftests/coredump/stackdump_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/test=
ing/selftests/coredump/stackdump_test.c
index 137b2364a082..c23cf95c3f6d 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -138,10 +138,12 @@ TEST_F(coredump, stackdump)
 	ASSERT_NE(file, NULL);
=20
 	/* Step 4: Make sure all stack pointer values are non-zero */
+	line =3D NULL;
 	for (i =3D 0; -1 !=3D getline(&line, &line_length, file); ++i) {
 		stack =3D strtoull(line, NULL, 10);
 		ASSERT_NE(stack, 0);
 	}
+	free(line);
=20
 	ASSERT_EQ(i, 1 + NUM_THREAD_SPAWN);
=20
--=20
2.39.5


