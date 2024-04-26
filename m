Return-Path: <linux-kselftest+bounces-8912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304168B364C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 13:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6781C2185E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00868144D2C;
	Fri, 26 Apr 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fC6mqdDL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC31448DF;
	Fri, 26 Apr 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129764; cv=none; b=Ndb8shDvZesjGqpgfuC8XNVjZd7nZGM73Z0juijzVxe4og15idJA/KRXhxVA2kWXCo7xjfZH7/oIchHWaa7j/IOYr7lt6Aj1qyVXukckC5t2oNFJzy35e409K37pHNLJhWube5jyuKax8JtaFGazUC2OGt9HdInlCotrTgbSrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129764; c=relaxed/simple;
	bh=9YJTYL0hFAFIxLg99RWUafnC/eaz4B750rx1oj19Es8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KR+aF59e+xsqoRggk8hR6E5e+fBpAIuV7yaEajkrazW/fQjXHtP3CIiqQm4fD6hbrqKo1faWsdiw409frhuZdkSJo6z/YwFHNUbzSYT5cJkBLEnErq5YJBvPPQOvSB0JyjegfGP3IDbtUqNdeIZ07bMVgLspiPlhx359JWqA6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fC6mqdDL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714129754;
	bh=9YJTYL0hFAFIxLg99RWUafnC/eaz4B750rx1oj19Es8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fC6mqdDL2aBKq7NvmWLnbLc1mAOzfFYqokstdr+KfkofTDsdLwYD5UQJQBIpJ9KLm
	 UBKCkjKPP5tSVGzC5MKVNktFyT838ShWW9UMtBdHQdiTy8AntZ38NTXluPBQrOHySa
	 mrvOXlecYNwLgKqgz+3nV7oomSIre4hsVs8+XKMQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 26 Apr 2024 13:08:58 +0200
Subject: [PATCH 3/3] selftests: kselftest: also use strerror() on nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240426-nolibc-strerror-v1-3-76a4c9c5271d@weissschuh.net>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
In-Reply-To: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714129753; l=969;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9YJTYL0hFAFIxLg99RWUafnC/eaz4B750rx1oj19Es8=;
 b=QHYxmeweV/vq0rJcOPRdfSZaB7V3GTzNrKTqnNthBNo2TPTt/tGEUh9Fj8PYuGyOf7K6Ks8m3
 ZH4O1EaBLqeCH8BaZn45Xge6ZmnJswb8t/fp+vdBWvqjWq8Fk9v6ji9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

nolibc gained an implementation of strerror() recently.
Use it and drop the ifdeffery.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/kselftest.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 541bf192e30e..f4bfe98c31e4 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -161,15 +161,7 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
 
 static inline void ksft_perror(const char *msg)
 {
-#ifndef NOLIBC
 	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
-#else
-	/*
-	 * nolibc doesn't provide strerror() and it seems
-	 * inappropriate to add one, just print the errno.
-	 */
-	ksft_print_msg("%s: %d)\n", msg, errno);
-#endif
 }
 
 static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)

-- 
2.44.0


