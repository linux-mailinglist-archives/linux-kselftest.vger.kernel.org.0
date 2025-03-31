Return-Path: <linux-kselftest+bounces-29957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E00A76C3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 18:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DE116B10E
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784AC21507C;
	Mon, 31 Mar 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RQzOTIXI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NTq5m2PU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898ED1DF748;
	Mon, 31 Mar 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439854; cv=none; b=Kz4h2k7BYpweH9rzHi/DXQi+55yVU6P6jkDK68wz7vO3Ji6wGsIXzinSSeaQRCHUGb8xE7bGKM6aio0VXkb5rGMSNWwTLglxJX1Y15+aYiBRNbb0nELin1K7k8E/rY2AVeggB6fubd2c6bu/r2noDttSRclwASArGqqeAph+rnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439854; c=relaxed/simple;
	bh=bgMwNkhBGnv8rP3ZdwMmJTU8/JPMOzHPhegnc9gemY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxqnOeCly+o+h74NUcfENmx2EQPHEwjuFaSM0/LewGnQArL8aHz15IOroQqdp3D3uDHqBLnIxMwcTV4xiAYqY15OOLepqq0jiGXJt2ufBXr11uwjf1Puxv4UE1dDQ2FuLMhzGdPQgrqy7Bg/RyvAt4nDFDOHoGbEMFya+kxKtr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RQzOTIXI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NTq5m2PU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743439849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbpPGliuR2iTK+/0zgI72kw6GIkb/4OY3SUNCgGx+MI=;
	b=RQzOTIXIzsE34ANhyDzSXgAhNiZVpmtmNPt2sIWfc5UB5yQzsmcDv+EdXOMQdcIfkYT1ZT
	a1FJXNyNEwGq5vhOQEW23EBo3jYPfiGBw1yD30Go1EfzE44VzRR7WZ/1wlkblUTX1q51DA
	yv/L4J3wswnJLa6QGQIbv+vcZihXDUeX51CUKHfRhTnfRm0A2wrysbOc5tJMNLNAW2vm5e
	Wq0L0VOoMb2AMBBlIZFWmFOsQeioDHkuWDOd1pRkSwdNJndHqFlrIhNRBdWcVEwkLvo0JP
	Dlh5bGtWmzdzX3KZ3CgQB8wcJE3jsvTHXmmUtzwh0xGzk6RVRrhfdGqqEd8aKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743439849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbpPGliuR2iTK+/0zgI72kw6GIkb/4OY3SUNCgGx+MI=;
	b=NTq5m2PU5/F6l9bLpli0Ajd211xsV/DSVnq7JQI9d5vSCMYaahUf2B8TPJa01fbOt7+4oW
	aehLwA7z9RP+DsDA==
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/3] selftests: coredump: Properly initialize pointer
Date: Mon, 31 Mar 2025 18:50:42 +0200
Message-Id: <b595166b7ece013b371c2bac1098533f1ffa12d0.1743438749.git.namcao@linutronix.de>
In-Reply-To: <cover.1743438749.git.namcao@linutronix.de>
References: <cover.1743438749.git.namcao@linutronix.de>
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
index 137b2364a082..1dc54e128586 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -100,6 +100,8 @@ TEST_F(coredump, stackdump)
 	FILE *file;
 	pid_t pid;
=20
+	line =3D NULL;
+
 	/*
 	 * Step 1: Setup core_pattern so that the stackdump script is executed wh=
en the child
 	 * process crashes
--=20
2.39.5


