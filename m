Return-Path: <linux-kselftest+bounces-16189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6895D8F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 00:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDB11F22FF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1911C86F2;
	Fri, 23 Aug 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZegRegq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F0191F6B;
	Fri, 23 Aug 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450719; cv=none; b=Ybi4U/Fs9+nk4MgOrh8fb1Fb/+V3SDxWMKsY5LfOlgfM14fjbQlHz+qsjCGWG0oKpcL+xrR+y85pfGEVW67Necb9+lyNCvu+1NYWUpfYrsahvSlDIKWu+Eik8diTSzhcyDrEQs39HSCKtXw/9QHjzYWlJha6mPztz2E3CGL14JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450719; c=relaxed/simple;
	bh=Onq8ppUUvloA5Glur5TGcQiO25kv2LUNk3hc116TSwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYa/jQLKJQwkJBxHzIsvRMtaDU94qalsg3BC4mmJU6OQoFkjX1WSrxmCB+Dv3OybrK4o2MiXk/Sujv6kxbcEyTWn8WkchTa1qfV7WYNPaWui3lC2exF9G08IEm1MUg2qVr/Uun/BOcs+fIY0656sRecbM+omV9CF/uTljSkD/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZegRegq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97BDDC4AF09;
	Fri, 23 Aug 2024 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724450718;
	bh=Onq8ppUUvloA5Glur5TGcQiO25kv2LUNk3hc116TSwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LZegRegqpqwUmh9q6zGlbbi81wz9FwZmbU9OFsGp/SY6/7sSbxs0YLsQHAOlwMFe1
	 bktuwPxk8853IFM+iMsN6sj9olWjxafXSQ0PXiEtw150zdmDzqFMPpvMSs4MT6AxEy
	 WWb2+m23p7X+CrF8gD2XmKlQXuhYODtvrsyU9VBfDMdcmXfKcMCHTA3Kk+b7pi+rwM
	 P1p9AHyN331Pb/sOxl5a2mpH+U1b/o11u5P13X6C3YA9KLcmX89P+LmCdqkutoaqWP
	 sSCw2OkC8vuRRkVZ9WjB75D8/VvRDIIbnkOJX6dfcamkwr3FzTS/rvFNvOPQaGhjXk
	 eXcRqvBU+lCtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F10C5472F;
	Fri, 23 Aug 2024 22:05:18 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 23 Aug 2024 23:04:52 +0100
Subject: [PATCH net-next v4 2/8] selftests/net: Provide test_snprintf()
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-tcp-ao-selftests-upd-6-12-v4-2-05623636fe8c@gmail.com>
References: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com>
In-Reply-To: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724450716; l=2397;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=ZbClr+UedGcW2LCLFSk40qpau3vrKMfVrqON9GVCR4I=;
 b=1j9g8UMCJET1FNuW5DOcIX47DH4eVx1jpVNyMD+m/L7PeoEyqOPUnxzchmed7UwNaaqnbUCMZ
 8rjFC6eCju2BR3gdIK+tdvEGZe7eltefzvIPPhH47le8qAEdnZQr8kj
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Instead of pre-allocating a fixed-sized buffer of TEST_MSG_BUFFER_SIZE
and printing into it, call vsnprintf() with str = NULL, which will
return the needed size of the buffer. This hack is documented in
man 3 vsnprintf.

Essentially, in C++ terms, it re-invents std::stringstream, which is
going to be used to print different tracing paths and formatted strings.
Use it straight away in __test_print() - which is thread-safe version of
printing in selftests.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/aolib.h | 59 ++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index fbc7f6111815..78466863435f 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -37,17 +37,58 @@ extern void __test_xfail(const char *buf);
 extern void __test_error(const char *buf);
 extern void __test_skip(const char *buf);
 
-__attribute__((__format__(__printf__, 2, 3)))
-static inline void __test_print(void (*fn)(const char *), const char *fmt, ...)
+static inline char *test_snprintf(const char *fmt, va_list vargs)
 {
-#define TEST_MSG_BUFFER_SIZE 4096
-	char buf[TEST_MSG_BUFFER_SIZE];
-	va_list arg;
+	char *ret = NULL;
+	size_t size = 0;
+	va_list tmp;
+	int n = 0;
 
-	va_start(arg, fmt);
-	vsnprintf(buf, sizeof(buf), fmt, arg);
-	va_end(arg);
-	fn(buf);
+	va_copy(tmp, vargs);
+	n = vsnprintf(ret, size, fmt, tmp);
+	if (n < 0)
+		return NULL;
+
+	size = n + 1;
+	ret = malloc(size);
+	if (!ret)
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
+static __printf(1, 2) inline char *test_sprintf(const char *fmt, ...)
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
+static __printf(2, 3) inline void __test_print(void (*fn)(const char *),
+					       const char *fmt, ...)
+{
+	va_list vargs;
+	char *msg;
+
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



