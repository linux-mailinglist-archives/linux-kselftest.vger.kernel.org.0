Return-Path: <linux-kselftest+bounces-14701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B146945AE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 11:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A369B215F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 09:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC841DB426;
	Fri,  2 Aug 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYaOuq6E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309231DAC67;
	Fri,  2 Aug 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590619; cv=none; b=BA7Yf8LoPM+MLkElumIqWslAa0Hqiw9sYk/7z+fER1Oes3vh99pU5YxWUdbtxvEjdtr2CU7d5Zm5O63unDSL7NkA+f2e0gW0qWMXhWV9OtBHTgRkpShUp6it0OHQHobDmo9YTobubN7xrn38Bo8iK5cV85VEv/gLlShnC/3KMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590619; c=relaxed/simple;
	bh=mi1pDYCuxz1nkrACatRNZAKrs0LHdi2usDp1c4EOazA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOz3bLljzKXXsxu7fvZxQzz8ttXlVN9ctePCTnwiThyZtzbXt5xnrSifrQidVUysuj9mfbyh8I7K/sS91NMM/I9t5qpOZ2v0uU1GafYambwcAdOadJYr4xmxSFcS34jHsKwWq2s0I/DZyDuXGb+0Yva5IllF+G0l7mVt9786J2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYaOuq6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF2B9C4AF0B;
	Fri,  2 Aug 2024 09:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722590618;
	bh=mi1pDYCuxz1nkrACatRNZAKrs0LHdi2usDp1c4EOazA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HYaOuq6EB7xndq92DjLGJI8wduqMOGpcP8EFsVqaRpZlrJ/5dpWjXyiVHeX5lKGD0
	 x3JybEIUT0fFw7Ls7LmvM4Yu+Narwe2bRSwyhqZ9mkAc810A759uUzxjSrFCzhzMtB
	 txymUgyTqwYdORb9G1R4O8iCmQt2bDdKfW53+xLBK8j3pdeeXfbTuwOhRzoiUAwxp1
	 pLpLdY9CrEu0+B1PDruoZyuWHvMBH5PWcDPUWEQFtWiRqcKiPk4vLtzULF7IYaZAkt
	 HXaTmkx1pashh8EuQ7NOcu8mEi5AHF250yKeMi3nz8bivn7eewCN8NsJhyqLg6k1Lc
	 5Hy924x32Ngtw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1495C3DA4A;
	Fri,  2 Aug 2024 09:23:38 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 02 Aug 2024 10:23:26 +0100
Subject: [PATCH net-next v2 2/7] selftests/net: Provide test_snprintf()
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-tcp-ao-selftests-upd-6-12-v2-2-370c99358161@gmail.com>
References: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
In-Reply-To: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722590616; l=2413;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=8+utKAlqfPj4BJg8ENUdZrxm7vNk3Rr7aXRZIl8U7xQ=;
 b=Gazk6+T+mX5ObKgPXNEiSh/s1rsyAJFS7MCVYkkKEqxpaWfULIIgRi6XNgFwcNQzlBZQP5lg2
 2akYMXRDEo5DT1laVEe1Rfdv7E64P6KoOUBrlikZMJuDHLc+rJo/I9E
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
index fbc7f6111815..60a63419cabb 100644
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



