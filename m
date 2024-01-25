Return-Path: <linux-kselftest+bounces-3573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F283C6C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E242A1C22633
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A46A4F5EC;
	Thu, 25 Jan 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZjG8YMwP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C1224E8;
	Thu, 25 Jan 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196764; cv=none; b=SgN8uZUEtoXLXu398Nb1vq/Dqdv0w5P5lL7kRlYiyuTY8QZdr4qWRldQPhTonH6sSI5YpY5/J92VCOI0C8vVorcclevlnKoIhkqZmr7dLuoFzBetaPSoZfuBydbNZKp5pMwtWWzNMZ2VVCJe1kZ+Z7MWQUG2idR2iF6vqy9DESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196764; c=relaxed/simple;
	bh=gs5qf28Po9j52/Zx2iLlyDqdWcviI8xNbzxOm4LEDjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtXvQsPP/QtaTu7p4fak2OV5wYx2OhlI5uAHEB3XEq0ZLHgOy+klgZXs2BvrI+nvjqvV04OC821RSgcSTJwZZTBlSOpzY/WplmZYOwDzp+eejEuuWFgzl4MmNmr7pzCKjDzWlOHHmkQlo1cFcj3skjGX6W1t0WFeHPVmX2BPsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZjG8YMwP; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TLPw53jfmzJrP;
	Thu, 25 Jan 2024 16:32:37 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TLPw51DB7z3g;
	Thu, 25 Jan 2024 16:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1706196757;
	bh=gs5qf28Po9j52/Zx2iLlyDqdWcviI8xNbzxOm4LEDjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjG8YMwPhVxAKfQ8WsQ5vyi7XgsLsScoH3xxwqlMCyrjypt/7hfMObPWuL/VS5FIb
	 wVQcHPWLwSMYQOg1pcBHT3MRkN47U8PJH615H5pV8vsDG2s7aMmYABCkzkLrdumvGo
	 lkMs92MrLpvfL3uGfAMJeFDTatveqG6oyc2GFym4=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/landlock: Clean up error logs related to capabilities
Date: Thu, 25 Jan 2024 16:32:30 +0100
Message-ID: <20240125153230.3817165-3-mic@digikod.net>
In-Reply-To: <20240125153230.3817165-1-mic@digikod.net>
References: <20240125153230.3817165-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

It doesn't help to call TH_LOG() for every cap_*() error. Let's only
log errors returned by the kernel, not by libcap specificities.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/common.h | 39 ++++++-----------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 13597ebd3a64..36fca11958b2 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -131,31 +131,19 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 	cap_set_secbits(SECBIT_NOROOT);
 
 	cap_p = cap_get_proc();
-	EXPECT_NE(NULL, cap_p)
-	{
-		TH_LOG("Failed to cap_get_proc: %s", strerror(errno));
-	}
-	EXPECT_NE(-1, cap_clear(cap_p))
-	{
-		TH_LOG("Failed to cap_clear: %s", strerror(errno));
-	}
+	EXPECT_NE(NULL, cap_p);
+	EXPECT_NE(-1, cap_clear(cap_p));
 	if (!drop_all) {
 		EXPECT_NE(-1, cap_set_flag(cap_p, CAP_PERMITTED,
-					   ARRAY_SIZE(caps), caps, CAP_SET))
-		{
-			TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
-		}
+					   ARRAY_SIZE(caps), caps, CAP_SET));
 	}
 
 	/* Automatically resets ambient capabilities. */
 	EXPECT_NE(-1, cap_set_proc(cap_p))
 	{
-		TH_LOG("Failed to cap_set_proc: %s", strerror(errno));
-	}
-	EXPECT_NE(-1, cap_free(cap_p))
-	{
-		TH_LOG("Failed to cap_free: %s", strerror(errno));
+		TH_LOG("Failed to set capabilities: %s", strerror(errno));
 	}
+	EXPECT_NE(-1, cap_free(cap_p));
 
 	/* Quickly checks that ambient capabilities are cleared. */
 	EXPECT_NE(-1, cap_get_ambient(caps[0]));
@@ -179,22 +167,13 @@ static void _change_cap(struct __test_metadata *const _metadata,
 	cap_t cap_p;
 
 	cap_p = cap_get_proc();
-	EXPECT_NE(NULL, cap_p)
-	{
-		TH_LOG("Failed to cap_get_proc: %s", strerror(errno));
-	}
-	EXPECT_NE(-1, cap_set_flag(cap_p, flag, 1, &cap, value))
-	{
-		TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
-	}
+	EXPECT_NE(NULL, cap_p);
+	EXPECT_NE(-1, cap_set_flag(cap_p, flag, 1, &cap, value));
 	EXPECT_NE(-1, cap_set_proc(cap_p))
 	{
-		TH_LOG("Failed to cap_set_proc: %s", strerror(errno));
-	}
-	EXPECT_NE(-1, cap_free(cap_p))
-	{
-		TH_LOG("Failed to cap_free: %s", strerror(errno));
+		TH_LOG("Failed to set capability %d: %s", cap, strerror(errno));
 	}
+	EXPECT_NE(-1, cap_free(cap_p));
 }
 
 static void __maybe_unused set_cap(struct __test_metadata *const _metadata,
-- 
2.43.0


