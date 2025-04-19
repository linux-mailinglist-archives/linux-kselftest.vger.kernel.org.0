Return-Path: <linux-kselftest+bounces-31205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A20CA942F4
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5403A17CC15
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD641D6DDC;
	Sat, 19 Apr 2025 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="A8w+UOkN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88454654;
	Sat, 19 Apr 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059593; cv=none; b=SoC6bNh4Q4RRakqiYzM07v3obv5HeQJlGigi25B1aUtCtIun9KAn6kgry2hqDHWdkoigDzSjiJBnxI0qR3useNYOV/dbRT5/45zRbLssTM8pnEFoM9qfYR9fPf2QHchwC1lXPcxVyymfs7uQTzuCzr1TPl8WhHaPIPF6813rz9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059593; c=relaxed/simple;
	bh=rIGG2avDYewQyNpFGCRyAH1BFtTaIBDk0rn7Rm/dLos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dFJro3lnFGcMZwDRDJbsCeO7v/BKeFSxAB0D09xd03AMfZUq78zxwuXEdR1U7BbpjLdkX3+0l4lJjjuYrjGntVfZR+sCRjezk6ncdS7WaJM2vi/P5iptyLcOlEnGuzZJjnlsesj/mzu+lO946oERjMqFUZnO7BSe9eUGGXicxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=A8w+UOkN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745059588;
	bh=rIGG2avDYewQyNpFGCRyAH1BFtTaIBDk0rn7Rm/dLos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A8w+UOkNu7gCcfcEt4vSylXiYQmDdHbl7m4dGjBGqEavophuUD4cPc18j271eyf1A
	 mUn4iVviH6miaJSLM76MRB/HhE0G7qD7cAApfdzUmDQNSXdcQRVNuWZdTDnFimYToE
	 SF+od9yPZfD1nDjshEpyIQ0YZ0guYIc9mGoV3c6k=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 19 Apr 2025 12:46:22 +0200
Subject: [PATCH v2 5/7] tools/nolibc: fix integer overflow in i{64,}toa_r()
 and
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250419-nolibc-ubsan-v2-5-060b8a016917@weissschuh.net>
References: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
In-Reply-To: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745059587; l=995;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rIGG2avDYewQyNpFGCRyAH1BFtTaIBDk0rn7Rm/dLos=;
 b=NWlPgVZMFUZIo1HfbezTXZNzFRbXco3HXj7B2A3pv9V2VslYbDVKSwJ5sON3S0Rs03zCveuL1
 rAwvEJezQpHB0jCh4Hbb0sJlRtbWmbogo4Ommpj0oDYf36PNZXrxie4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In twos complement the most negative number can not be negated.

Fixes: b1c21e7d99cd ("tools/nolibc/stdlib: add i64toa() and u64toa()")
Fixes: 66c397c4d2e1 ("tools/nolibc/stdlib: replace the ltoa() function with more efficient ones")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdlib.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 86ad378ab1ea220559d5ab1adc4bb9972977ba9e..32b3038002c16864cf66a71ae9fa3825f995b09c 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -275,7 +275,7 @@ int itoa_r(long in, char *buffer)
 	int len = 0;
 
 	if (in < 0) {
-		in = -in;
+		in = -(unsigned long)in;
 		*(ptr++) = '-';
 		len++;
 	}
@@ -411,7 +411,7 @@ int i64toa_r(int64_t in, char *buffer)
 	int len = 0;
 
 	if (in < 0) {
-		in = -in;
+		in = -(uint64_t)in;
 		*(ptr++) = '-';
 		len++;
 	}

-- 
2.49.0


