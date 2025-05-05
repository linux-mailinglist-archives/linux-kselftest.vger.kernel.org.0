Return-Path: <linux-kselftest+bounces-32374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F6AA9724
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063D817177B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D1262FF0;
	Mon,  5 May 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SxmuHd2/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GOCTMlts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC925E44D;
	Mon,  5 May 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458178; cv=none; b=JMUgfDLKJgybS2NU5hkpT4s1cy4f+ZebQ7BYTz6A/z0XMXnaMpIoCnzyQVCaeUd5O3Ij57JOiCQ78ehV+vyKbymSuUKhanp2EUUj603hxwCn/YTFR2dkVpM4mHe8zJyqkFB4jgOWN0fSFoT/E+i2qAZ7qXa/hUvZt/MdTtlEvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458178; c=relaxed/simple;
	bh=EcoIsakzwxxtqr1oW6zN3HUyXKmCSb1/2qQPJgbXT/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZK7oY1hZ3vkgj2Xv3qwejd7AvNK2qcQW8VOZagcuAiyG6zrQxecHrDtm7rqrhezKmJszuQAzMcD0AxxUgvxiHAdVxzvZPZQlW5298T2wXXJ3YTPr8jZ9y3es0m1QYMfzUXh35q4/55lKpVIuD9x2sG25xiIBFyjqPQFhkmUFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SxmuHd2/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GOCTMlts; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1cMkN+PUAmfn0XV9oyq76jSFHcdM8vUJ6DsamcpS9k=;
	b=SxmuHd2/+07D5ffZN16mk7JuR7pMNStXhDCWra3lEtkePfwENyNraLFO5azyRz6gHnGVwH
	avkhYC3PfUs87qzUDR1fB1F+yICSgibF4gfCCcoVZ5neJh0Dahh/CKqd+SbyPSmv1dwfM8
	ynp/W9LFYh9ih2U+6tf1HomS7FHVUIclm56HI+Bd++9GFoiMxwZe/Mauojx/jPVJLIj5oL
	beW/3ZT7up2wyIogSbrq2B+rVSluw7LYWiVIbv7V0Hkhw2hyiA1Xh2OSbMFvPNmde104JU
	RU0YsV0PQey9Sfaa95PG0qlDv03DZ7YRMj1qJmsCMTQMo6qFkCkvOOjyVj6C8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1cMkN+PUAmfn0XV9oyq76jSFHcdM8vUJ6DsamcpS9k=;
	b=GOCTMltsLcBElqLS4SXCMHSlwGg2NawBQlqFkIIHcx/jQwfuVaHLOt3v2R55nolsQhbc7D
	1llFeCoE0+DkBlDg==
Date: Mon, 05 May 2025 17:15:24 +0200
Subject: [PATCH v4 06/14] selftests: harness: Remove dependency on
 libatomic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-6-ee4dd5257135@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=1522;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=EcoIsakzwxxtqr1oW6zN3HUyXKmCSb1/2qQPJgbXT/Y=;
 b=nnDlfH69jdujv+9pK3GRPpZ87cHOyzBWiMKIHYIyvkqo+nDY+ODL1PokH3xSfTMOE5KFeN47a
 iGuYPxZqylvA0aZ7G13whDOx57RlH8DLhSX+0cUGbvwEaTeOYWRlzoN
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

__sync_bool_compare_and_swap() is deprecated and requires libatomic on
GCC. Compiler toolchains don't necessarily have libatomic available, so
avoid this requirement by using atomics that don't need libatomic.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kselftest_harness.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 222a4f51a8d704c41597e09a241ad887ef787139..7ec4f66d0e3d7f129f6c2a45ff58310dabe5d03f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -439,12 +439,12 @@
 		} \
 		if (child == 0) { \
 			if (_metadata->setup_completed && !fixture_name##_teardown_parent && \
-					__sync_bool_compare_and_swap(teardown, false, true)) \
+					!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
 				fixture_name##_teardown(_metadata, self, variant->data); \
 			_exit(0); \
 		} \
 		if (_metadata->setup_completed && fixture_name##_teardown_parent && \
-				__sync_bool_compare_and_swap(teardown, false, true)) \
+				!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
 			fixture_name##_teardown(_metadata, self, variant->data); \
 		munmap(teardown, sizeof(*teardown)); \
 		if (self && fixture_name##_teardown_parent) \

-- 
2.49.0


