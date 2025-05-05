Return-Path: <linux-kselftest+bounces-32370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9BAA971F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903AF7A5F0A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808025DAF3;
	Mon,  5 May 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fn59vU+7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbjHCEaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF92512E3;
	Mon,  5 May 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458176; cv=none; b=clV2gBb0o6xRqMMXlq8ieVKuKHaljThw2qrQR+NLE2DpiSgalKg+XZ2HntlBdeQDkiwkfydS4IS8YhY4socXZL+U1JCv5t2kCysqqg/w+ovQ2GIrNZPk6Xi67vZiov0+0bnZilP9tHSc3V4O8g2adpCciaykbj7ZFu0/54jUE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458176; c=relaxed/simple;
	bh=yqkC7D613B/dIafgI34BREpd1HQGZ/eX+hozBTbheVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4nzNlFCUJlnifAHVtXIlX6ggev2wCRhgWoGs5KQCv+h/8nJ3hOf8HuqSESmEfQF8X6w4WySadzl3O93Ut14xRpiF7OgxrX3jM701yZ41WvK3yA0irim35Z059/b9+8bIFeLV7aU3TlhmoklxAS0J4RSOk3RRGN0Jy5/I0pgXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fn59vU+7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbjHCEaa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//BGu/k3hlFFdQ3pWCz2mCX1lpc3aAigLFz9qVSnyGw=;
	b=Fn59vU+7fZBvcMMi59lVzisP7K+Te/kiy2lzjUfAllZ+hU5rbPKpv5v7N+0A65VrecNghh
	Bc6cIF5Phh5fWrF30HNWfsaf9r7LC1aQVD9ElhJi9/EGehqVVyboHFsaYZiR9mX0onwPZw
	7zdY7aVgvWB3RUX1TLuKcxTPsrTs48xN/Sv0yx2vrbAWAb1ZEkKiVrdz3Q2YUmh3jcki15
	4977ygfbJEHkTk470/yCgRh1LAmZW9PowXGi6smPmaWbY/OM4i0rUQY/SLp72+UUgvY+y+
	K+fEp+ORlcbosQcSD6w03EeJ/3fF2l+WFj+6jXe86F6mX79NpEkEud9JZan1gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//BGu/k3hlFFdQ3pWCz2mCX1lpc3aAigLFz9qVSnyGw=;
	b=BbjHCEaaplrMokuA4qUSQVvjm+nm3gwqtZnhlnn7fQQkxLSLqi31sq8Mfkx2it1wWIb/c8
	pNcWBoy5jJMSXAAw==
Date: Mon, 05 May 2025 17:15:21 +0200
Subject: [PATCH v4 03/14] selftests: harness: Ignore unused variant
 argument warning
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-3-ee4dd5257135@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Mark Brown <broonie@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=1751;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yqkC7D613B/dIafgI34BREpd1HQGZ/eX+hozBTbheVU=;
 b=LDKfqsixK1+BJpdn4ujnlFThBPlGBZsrApu61b5YAp0J6CbMwCAPuO3mCGDjEKML58DaOnS6b
 8dVuCGrAeThD+n2dAVjDut1eIhalhWDtWfEuU4unOfKrHOUbUEWGVkA
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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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


