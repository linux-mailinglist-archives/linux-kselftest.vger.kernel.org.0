Return-Path: <linux-kselftest+bounces-30194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871C3A7D492
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61224188E792
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2B227BA9;
	Mon,  7 Apr 2025 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQnGpQne";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6zgwhJ+r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08E22687C;
	Mon,  7 Apr 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008786; cv=none; b=W8Xg7BWohyfNq9WP0A8A1ZdASDAOrkn9OpyuVigU9W95Z3mbM8/+gvrp+2Lc1Lhm+Yc16MMQU11jhezmBoM9rKjU6smhaPMM0a1qbqmDOwJ7Gy5YtewVMjlSaQW7xlzWSq96OPYQKe6JWRQ+vrIPF+RghrxzAxH7RwqCtG5S5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008786; c=relaxed/simple;
	bh=DYq0rbz3jmlhEduwTAuGV0UE7Ds8U5rzr+9vob1udYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MT0U279lI+BAwvKMVP5UELWRq5TNjXbmYnWGisClkY9nzehOuRpx4elcxxzt2VZtcKwgRAXUdcKuUcGh9utVA86lkaJwt62sQMBieQ5GO/4KZTDDtG4fsV6nPj+dNsfh1leGBzZsp/+iiQCwkPVXOTA7hXvpyv40BFrHaJaEO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQnGpQne; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6zgwhJ+r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qg3M61XE6rp6LYbeiMFWtQMLhXgLKx330vGb2tHj74s=;
	b=oQnGpQnevP0CeDcXmzxn0LiqroYU/FJBBv/Gg/8fGf0XF0065l2Q2KrpgXTJQM6uQYNnN1
	6YnembfuHsCppMu5bfkOzwL/JXiZByZ+iqoOPdhTujtAWmiAPCXW6Dm4pT1chdIrHNPauh
	c3OCwGjN+Xln79D5EZpv9L0smh1Hl5P2a/dv7TnSGFX3sex4ezpjziEl6plxhGb8E5Ez8Q
	qmNw47pr4YdNY52t6FQZMQEhXnSbkAiF20MApSp+hck9GN7YPnJ+hFzVdxaZw1iyVHV/ba
	IR29HAwI1qlQ8C83sfLD0C6+YVy+SFD1huA+hJc0qZbUpz3RV+4DCyajM70Ghw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qg3M61XE6rp6LYbeiMFWtQMLhXgLKx330vGb2tHj74s=;
	b=6zgwhJ+r/XFeFsxlXpiRtUJ2VcOl8iIG1pCS8XxVklEFJPwTLjOTtN5X2/2oQG562wYum0
	UwMcEvxIyOWYJYDQ==
Date: Mon, 07 Apr 2025 08:52:31 +0200
Subject: [PATCH v2 08/32] selftests: harness: Don't set setup_completed for
 fixtureless tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-8-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=862;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DYq0rbz3jmlhEduwTAuGV0UE7Ds8U5rzr+9vob1udYk=;
 b=ieV2FmPcrKiLSRtiKwGOGYCIJxRKefKMzCPXw+6O8FU0DIsGdMK23K3CwnKCPn2Lo5aoi5UBX
 SWiq5I1qcZ1CX2RwRje5Nej8g1S+8RLnbTNSI8KKIf+APm0czSeANAq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This field is unused and has no meaning for tests without fixtures.
Don't set it for them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 1e459619fe8657d7d213a7b16d7bcbc58e76e892..905986debbfb0ce8c9659dbd52b6c67c6759cae7 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -178,7 +178,6 @@
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
-		_metadata->setup_completed = true; \
 		if (setjmp(_metadata->env) == 0) \
 			test_name(_metadata); \
 		__test_check_assert(_metadata); \

-- 
2.49.0


