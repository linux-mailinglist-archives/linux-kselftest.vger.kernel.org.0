Return-Path: <linux-kselftest+bounces-30974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDDBA90B75
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 20:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4686A17B4ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A20022424E;
	Wed, 16 Apr 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qLb/MG4x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035F22423A;
	Wed, 16 Apr 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828848; cv=none; b=lHtuRt5Y59HbNySAzi8NWldvt28VrDMW+Yyn7+pk4Ebfmkddqa9e947PjFA1bsWqEJYgKW7tfOqGXcWNn5oDwprSYG+IO/7avZGYmo846M3AQblAcqQiWJh7wsg4zEu2FplEkLFfuPYuu7O+5/QALPwjH40vD1qaZivVfaaEnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828848; c=relaxed/simple;
	bh=jCc+HBe7/ZchbeIAcJPoVoIp6kCZq4gasvGUQMeonFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hE/nzmGfMqD/wktJCFnUUqHcEuRPrw0g2VEwZw11bM1QQz7p3RVjmMJ5qQvlImS5LM2mf8iu7YpoUwBrFgUi9bH+753otHRaA06p5VVyKkD7+iQgMMkTLyeg9zAfukBVjW815Vrryu0PeVFv1AT92z43yywo0/fXxd8zcpniUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qLb/MG4x; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1744828843;
	bh=jCc+HBe7/ZchbeIAcJPoVoIp6kCZq4gasvGUQMeonFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qLb/MG4xSlWLpaqStOv5OH1xID7I12d9e2QQ1wBstfkJu9NUd+56WJPpuzk889cSG
	 cO8gWaaIO/PIDOenTdmWi5DRujl8uG7Zw5x9+Z7UjDaTptu1VaReaF82oubRReEoJW
	 QP5zrUs9/JHcR6DXPNjg9M2nfaTeaO+q3PofTu4Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 16 Apr 2025 20:40:19 +0200
Subject: [PATCH 4/6] tools/nolibc: fix integer overflow in i{64,}toa_r()
 and
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-nolibc-ubsan-v1-4-c4704bb23da7@weissschuh.net>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
In-Reply-To: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744828842; l=1658;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jCc+HBe7/ZchbeIAcJPoVoIp6kCZq4gasvGUQMeonFo=;
 b=vd5RjBCHBQeCQH/O11mY77OCtqzNfHeAo+Netyu+qcXMeWelNtMNavSp6J9ZEe1X/k36LJHkF
 udmCZVxDT3fA640MqAYh/Qw3C19TXVTH4TDLCh2P4VkBRm8jLjDmGMW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In twos complement the most negative number can not be negated.

Fixes: b1c21e7d99cd ("tools/nolibc/stdlib: add i64toa() and u64toa()")
Fixes: 66c397c4d2e1 ("tools/nolibc/stdlib: replace the ltoa() function with more efficient ones")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdlib.h | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 86ad378ab1ea220559d5ab1adc4bb9972977ba9e..5e4b97810d49ac1b1bd79d6f779f6a748f188a39 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -271,16 +271,12 @@ int utoa_r(unsigned long in, char *buffer)
 static __attribute__((unused))
 int itoa_r(long in, char *buffer)
 {
-	char *ptr = buffer;
-	int len = 0;
-
 	if (in < 0) {
-		in = -in;
-		*(ptr++) = '-';
-		len++;
+		*(buffer++) = '-';
+		return 1 + utoa_r(-(unsigned long)in, buffer);
 	}
-	len += utoa_r(in, ptr);
-	return len;
+
+	return utoa_r(in, buffer);
 }
 
 /* for historical compatibility, same as above but returns the pointer to the
@@ -407,16 +403,12 @@ int u64toa_r(uint64_t in, char *buffer)
 static __attribute__((unused))
 int i64toa_r(int64_t in, char *buffer)
 {
-	char *ptr = buffer;
-	int len = 0;
-
 	if (in < 0) {
-		in = -in;
-		*(ptr++) = '-';
-		len++;
+		*(buffer++) = '-';
+		return 1 + u64toa_r(-(unsigned long long)in, buffer);
 	}
-	len += u64toa_r(in, ptr);
-	return len;
+
+	return u64toa_r(in, buffer);
 }
 
 /* converts int64_t <in> to a string using the static itoa_buffer and returns

-- 
2.49.0


