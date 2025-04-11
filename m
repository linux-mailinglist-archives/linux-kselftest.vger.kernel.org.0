Return-Path: <linux-kselftest+bounces-30538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CABA85736
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B224A054E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D0429899F;
	Fri, 11 Apr 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hNWdPRT6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELMbWFGS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1C293B61;
	Fri, 11 Apr 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362110; cv=none; b=j8DA5+VJEDKsprTNppsVeYqdgXIGrGO8P9XmzhUGqSalz5L/o//HQdiqsXn1/nKKvLij/1gum9S1pN6tnnMQYSNtuW5uj8hKGTwjpYE3KOcyCRu5rRkZZUaVhok1LgqO8gLWMjuuP2ahXMJjViCU5wfzzhmFxyXpa23+/rDaZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362110; c=relaxed/simple;
	bh=3GiQDyFtPKhj9wJBDSnpRmP0HUHTpaKTigerUWM/y/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VsOLNQIx/SnWyXGGumJG5hDMasW++7dhavrQ40dyShtAs4jAtBqkIkNFE5SsPO0vsdeEND7pUW65hUGUqAK23NQBchzptXFABQ7Pk85U3DqeFz5ZUzQR7lKB3tYaKP0i6/4h0Mms9lW5yBkWQb0xmtIO/HwLXeCrOKF+DzuzLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hNWdPRT6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ELMbWFGS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cJJZUGfA/1w4r3/xI5UpOuuZxDVW61LV8w361vK0Hc=;
	b=hNWdPRT6eeXVWWaxv8u+MOQMt6TwyzstaLAik9FtmdGE+irmrVqL2Oc0caSeoz7RmT+sm1
	BARLmaSkLWXl29X19rtz3qF2oR6THlRHuMd+TVxqj849jpHtpuqOghBi6Y6EZ/2uJ5rWIj
	kHgS2eSqUExN9L2bkIPUlHNOekd3IvxTGvhthSkCULy9GAXJxuwOC114KTM6g3jVe8jUaO
	WJgy5JVHbYS22gjFrS5h6+nBWJ3NP9GZDxI0QBtrxY1NrExuXDP1xHoKcLj9ijwIlc07rc
	cOScjv/GJ+mmbqfqIpiTJ7dsff5jZxxawjmp+SPJnRx4t8mU34XrEz0RdhFXew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cJJZUGfA/1w4r3/xI5UpOuuZxDVW61LV8w361vK0Hc=;
	b=ELMbWFGSb+8PTGHSPrCBA4WbdColNHWp9BVsoNEpeNUNP4GFqsi8IvI2ZnkspHfOdfB4GS
	0zq2CqK7481YfFBw==
Date: Fri, 11 Apr 2025 11:00:27 +0200
Subject: [PATCH v3 03/32] selftests: harness: Ignore unused variant
 argument warning
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-3-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1638;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3GiQDyFtPKhj9wJBDSnpRmP0HUHTpaKTigerUWM/y/E=;
 b=5kVOZQzLLdgll0XcJ8nFCm09x00GzftfJDIecfLAEXe80QW3WYes9lpTa3BiW9g92KX5HUC/q
 1xa1R1/7s1MAfI6SapsFh3tK0/R89X3d+MR0XND3HiSM4/VoFeiWYz6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For tests without fixtures the variant argument is unused.
This is intentional, prevent to compiler from complaining.

Example warning:

    harness-selftest.c: In function 'wrapper_standalone_pass':
    ../kselftest_harness.h:181:52: error: unused parameter 'variant' [-Werror=unused-parameter]
      181 |                 struct __fixture_variant_metadata *variant) \
          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
    ../kselftest_harness.h:156:25: note: in expansion of macro '__TEST_IMPL'
      156 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
          |                         ^~~~~~~~~~~
    harness-selftest.c:15:1: note: in expansion of macro 'TEST'
       15 | TEST(standalone_pass) {
          | ^~~~

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index bac4327775ea65dbe977e9b22ee548bedcbd33ff..2b350ed60b2bf1cbede8e3a9b4ac5fe716900144 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -174,7 +174,7 @@
 	static void test_name(struct __test_metadata *_metadata); \
 	static inline void wrapper_##test_name( \
 		struct __test_metadata *_metadata, \
-		struct __fixture_variant_metadata *variant) \
+		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
 		_metadata->setup_completed = true; \
 		if (setjmp(_metadata->env) == 0) \

-- 
2.49.0


