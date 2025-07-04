Return-Path: <linux-kselftest+bounces-36568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD851AF9482
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0135A7066
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDA309DB7;
	Fri,  4 Jul 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QB8jkdEL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oaZ2OGZU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D1309A65;
	Fri,  4 Jul 2025 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636639; cv=none; b=NnWGQuKtno60CEdaR/GB/WKlJPeuCJ0TLnca0n38JVP/83L4fVJxQqyxBNTnZce/Ba9IQiAsbz6l4/0e8oEtEA0I0uzZ8nTeEJpfAnx6kz2UTLbbiKajeoG68wTGycAZpMJqQXIYuXpmZPNou4MPG3djXkeZpOIvCFQSLGGreDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636639; c=relaxed/simple;
	bh=1tma4K7d+Qt/1ub4E/c6PqwxT6BbFRRAWVL2Lb5LT9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGFPDrOcPwJR+Yx5xYMsSqcCd6h76Y3mCPAskhujE7mFawxRAmTsWrBsBSnFagNeu6Z/JcUYXyOAIcE4qmEVevq5oJC4GvDP8Bri3zyBmkqpvHKXEdsuZf5GXk1Kd2u9UyjbtumLG7kjINOhF57vHHJ03LOmWOexdtuv+nMjs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QB8jkdEL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oaZ2OGZU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751636636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6LoX/VJ5O0HxDxeU6ZWJrt82v0DtEHPKVNDvEjviIs=;
	b=QB8jkdELCn0/0Sjg4u8vLmZTgIGTQXr8TgPRp+DyqDseNblzje+o6GLcWhPp2mY9m7R0me
	sfxfQIvNyM+Owujy/bwNNpRFfYfTbvhe3IfI7LhBqMQ6ySfCEG1+wIgBVyDoWneot8Iq87
	Yr/py3hRbTgJ/jwiRUdhbrewE0tEtuF5J5ONewCkQLQPnZRjo2Xj8vLDPbw6nM40HZgNh1
	ugClkJbB4sAaAn+xqeqbUWvdxC5rL+aDFkD8S5x5epfD38Bc9cGgIxRGe9OBnSS9gZsOif
	skIMGGepUd2knS1bzYJ9NY5RnJOtMeUUH/OhB17O0z7hZPUxkde2NnfXnjR9Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751636636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6LoX/VJ5O0HxDxeU6ZWJrt82v0DtEHPKVNDvEjviIs=;
	b=oaZ2OGZUjmcFm6XzbhwsFsqGZ82RPnxd0ebSJ6AY3dZQIdkmchWlpnvD3tXNo5GLjRdLbJ
	sEAuX5B1UIekkVBQ==
Date: Fri, 04 Jul 2025 15:43:12 +0200
Subject: [PATCH 1/2] selftests/nolibc: create /dev/full when running as PID
 1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-nolibc-printf-error-v1-1-74b7a092433b@linutronix.de>
References: <20250704-nolibc-printf-error-v1-0-74b7a092433b@linutronix.de>
In-Reply-To: <20250704-nolibc-printf-error-v1-0-74b7a092433b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751636627; l=1306;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1tma4K7d+Qt/1ub4E/c6PqwxT6BbFRRAWVL2Lb5LT9M=;
 b=8S651JVgAW8VjkWD1Cnzz3VKDzGQgnsGXLBndV/felVhBMXBrcQnk03XX/tmERDUWfQyDFIJJ
 TDz+usA9TMmDToUdvL9Mw/RHRnoIMOwoJ63I9vqQaidk4Clm8LHGgAD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

An upcoming testcase will use /dev/full.

Make sure it is always present.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b5bca1dcf36e95a576ca9ffba4f7c213978a3f35..929b966099b369aeca6d43002ebb0a160674dddc 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1777,12 +1777,14 @@ int prepare(void)
 	if (stat("/dev/.", &stat_buf) == 0 || mkdir("/dev", 0755) == 0) {
 		if (stat("/dev/console", &stat_buf) != 0 ||
 		    stat("/dev/null", &stat_buf) != 0 ||
-		    stat("/dev/zero", &stat_buf) != 0) {
+		    stat("/dev/zero", &stat_buf) != 0 ||
+		    stat("/dev/full", &stat_buf) != 0) {
 			/* try devtmpfs first, otherwise fall back to manual creation */
 			if (mount("/dev", "/dev", "devtmpfs", 0, 0) != 0) {
 				mknod("/dev/console", 0600 | S_IFCHR, makedev(5, 1));
 				mknod("/dev/null",    0666 | S_IFCHR, makedev(1, 3));
 				mknod("/dev/zero",    0666 | S_IFCHR, makedev(1, 5));
+				mknod("/dev/full",    0666 | S_IFCHR, makedev(1, 7));
 			}
 		}
 	}

-- 
2.50.0


