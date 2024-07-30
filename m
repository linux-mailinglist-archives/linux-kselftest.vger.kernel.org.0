Return-Path: <linux-kselftest+bounces-14418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41331940438
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 04:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1628B20CC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1086934CDD;
	Tue, 30 Jul 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFEd7RV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A91773D;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305609; cv=none; b=dRDNJScNW70vmvLQkww0qaCgXI8AyQDel3mqUECFGBoW2DwuL9kVgqgerFdW9nHEdmrGLKKg8kWbZ5UG7q+q0h//ZTQb7NPEewicmaNT0/oGeubctuL/nkUbD5lU+ZK8zJCsgKNfb4s7HNUWOIeXHsc+qPooC9irhR/GN4mNN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305609; c=relaxed/simple;
	bh=xKJ531oeNGYJ3rhSQThy26hzbdbPUPpEuw0uOAhhf54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFF/T8VmcSw10tq1jB3lasLow2QHmJC3OsWEPddTeirB9xwXYuxtz5fmn//z50IVcUG+/D0QSfTCUL52s7m+JJvNMBtq1L3gV+pRuKACZkhNio0L4/6AsHii418bQdx20gPpHCh6ABRgkba7mLGHlHcBC6SxtEavDKWlPMiTolM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFEd7RV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 862E7C4AF0C;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305609;
	bh=xKJ531oeNGYJ3rhSQThy26hzbdbPUPpEuw0uOAhhf54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gFEd7RV9hyUy/cGSO+oPHaQJr8DIDJLQLp6HbUHuHYh+7Yr+DE8u3BOM0IdRpPIb1
	 mWefD11xppDBWbkJMdPn/J98sqoprR5R59mWWKhhcYL7mIaYymyARg0/tofJTwOB1P
	 3ow1L3oJKasUIMDmAKz8PxjtICqtfad5AYKaEyvnhaOcJafy+gz5uQrOpfnAbf3WxH
	 RimBNGzBDGITQogbRvF35SzD34IqBdz8EU+7FDoeFBLQcnQf7soMoeVFvwVhcd2IDO
	 /8GfAxQKO+GpJU6wIOe20bBKPisdbKMnLqiYj26QLyV11nGHuWa6WayEvxGl8gcft7
	 ecVfpGVemjpuQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76595C3DA4A;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Tue, 30 Jul 2024 03:12:16 +0100
Subject: [PATCH net-next 2/7] selftests/net: Provide test_snprintf() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-tcp-ao-selftests-upd-6-12-v1-2-ffd4bf15d638@gmail.com>
References: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
In-Reply-To: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722305607; l=1997;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=Hn2Bs9Fc12/AgT2T+RfB5ex9Lh+DmQaxL5WEBCBy03c=;
 b=vzbfnONCkUpmAXmtf052TLVJ0Gl9J9VN6abOlydRPRQDr1Itxrv4mqS6HUDMLSqZy3XOPh7jw
 kfNFciSa+TpDSZqlQYQsL0Fb436BuXK7b49538rgEMu3l5OV2WTCf7h
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Re-invented std::stringstream :-)

No need for buffer array - malloc() it.
It's going to be helpful of path concat printings.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/aolib.h | 56 ++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index fbc7f6111815..fdf44d176e0b 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -37,17 +37,59 @@ extern void __test_xfail(const char *buf);
 extern void __test_error(const char *buf);
 extern void __test_skip(const char *buf);
 
+static inline char *test_snprintf(const char *fmt, va_list vargs)
+{
+	char *ret = NULL;
+	size_t size = 0;
+	va_list tmp;
+	int n = 0;
+
+	va_copy(tmp, vargs);
+	n = vsnprintf(ret, size, fmt, tmp);
+	if (n < 0)
+		return NULL;
+
+	size = (size_t) n + 1;
+	ret = malloc(size);
+	if (ret == NULL)
+		return NULL;
+
+	n = vsnprintf(ret, size, fmt, vargs);
+	if (n < 0 || n > size - 1) {
+		free(ret);
+		return NULL;
+	}
+	return ret;
+}
+
+__attribute__((__format__(__printf__, 1, 2)))
+static inline char *test_sprintf(const char *fmt, ...)
+{
+	va_list vargs;
+	char *ret;
+
+	va_start(vargs, fmt);
+	ret = test_snprintf(fmt, vargs);
+	va_end(vargs);
+
+	return ret;
+}
+
 __attribute__((__format__(__printf__, 2, 3)))
 static inline void __test_print(void (*fn)(const char *), const char *fmt, ...)
 {
-#define TEST_MSG_BUFFER_SIZE 4096
-	char buf[TEST_MSG_BUFFER_SIZE];
-	va_list arg;
+	va_list vargs;
+	char *msg;
 
-	va_start(arg, fmt);
-	vsnprintf(buf, sizeof(buf), fmt, arg);
-	va_end(arg);
-	fn(buf);
+	va_start(vargs, fmt);
+	msg = test_snprintf(fmt, vargs);
+	va_end(vargs);
+
+	if (!msg)
+		return;
+
+	fn(msg);
+	free(msg);
 }
 
 #define test_print(fmt, ...)						\

-- 
2.42.2



