Return-Path: <linux-kselftest+bounces-40045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BE3B3805B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 12:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD01B65965
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA934AAFF;
	Wed, 27 Aug 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMiMcPjb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A634A331;
	Wed, 27 Aug 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292105; cv=none; b=XvVr0HBRQ+nYDE/VnAxrVrvilPhXORdd89vd5UJIE1bMXzUePTQutal+NXNjRXHisCREepYCvVOvV8r7nHiJt78+PiFOISspV5Fmc/hd3lT/66hIQRXvdLwwuE4jJXjm2lcJrMiPn33zy1k869OXeDrIz8lViQZ0TDP4a7/08G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292105; c=relaxed/simple;
	bh=brtTeOq7t9D29DOEYbCG+995QksqWJLkIz1HRzKOgFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kaxtcrJmfP5KWxyyESwOKP/aAu5VgsylZJpPfibbMT9wQqbxFpDQIJjVCPQ6Us+T+mq8yTxtEYuosfzjjdQX9sZtibF6KXz6Pc5zCv94fohHalDDZX+qWHXPwFiurexTQslXaQ+lyhKiCGNtcWcBeAYY08ur6RNcBRQXIuulsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMiMcPjb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24646202152so52301235ad.0;
        Wed, 27 Aug 2025 03:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756292104; x=1756896904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDBhuoyCHEkjgWaDPbp519QDqLxjbIBjIvhNBom08HM=;
        b=AMiMcPjbrX/RA7PHWmNFNN3Q84pRMiWG79w5IhCn2aiKtHzVxwV5ZozoHVtaraZn9w
         guZWYDUv4PpIw29fA/a51oO8BUY57xsG1/jklBdF2wiBGjyByhzqkN5WdphWBObikwu/
         iaUmugg8qsIMYYzMhyQkTglljTlVuvVkY3FawDvImDxQXJMsbGzL532089yiPV6ZJO/s
         X/K1neARxxUHOQbGTbd7SzAikm0Jx29xNRoHR8coHtrNnaRgoM64pvmiDRCtJ58o7mng
         CazB0IxJE4d0A6h2G/yLFBr/4qU7tW75vGPN7vC1hwvIUzwfXl0DIQ22wIOFZmLzZlHH
         KN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292104; x=1756896904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDBhuoyCHEkjgWaDPbp519QDqLxjbIBjIvhNBom08HM=;
        b=ln7dRtf24NOj1x5/38up7sAsZ1SXoSDe8LsQkd/k7QpyuC4X3FeBThY8ymE5Fa1vzq
         EsRYZhMdfUO3/aMQsqYpHVfuQeUR9X5cNhzTmbSAwPinb9bE9CwgZJ/olV9KnhtbIGp1
         s699MfappF1Ylx2JdcgT3fJku/beshCosfb4oiKGqu66uHU05F7nnWYJ6cY6c7V3yAZa
         UwgbE5XUGsm/ouev7gHCHRUsihF8IY6k5Oyi0c8S1ENuoBpXSXCqYIyQ7jswyvjmWXnz
         hxirbOaZofzVfAoDrAIgoc2A1Kn6Bwq6B8LQInbfr/LRHAx945GurqAOlu0JmlRKxtMI
         Y5/w==
X-Forwarded-Encrypted: i=1; AJvYcCVhv97D/pYE9MFrwZ/CA9Up2cwdzyONR8YCrgv61PSNWKu/wwK97JigmJcz3kGhJvziCeBs3S7ljd/nuT0=@vger.kernel.org, AJvYcCXkbzyIwhWGj0puWcgx179p9yk5FY8lSYdwlUsZ8pIclb1nhP3AtVr3/Wg/WRQa1GZrW8fMUaujgyl08F34SwuH@vger.kernel.org
X-Gm-Message-State: AOJu0YyrFAOdWkhs3+P+FB2fT5MbrE5l71ljXISnpmc3gF2/MfPoJoep
	ZPWWQa05TRktXa0yc9lbc6bK9/7gxO3HXpzXSnTs1R4kv4mhrbT4wn7m
X-Gm-Gg: ASbGncs5NDY9JWAITuW+PQ6jACZhv0A2KpTWlDkDcTmmafZ6hitPLFQjvyAFmcmXMpr
	8uQqkLQjIVpL58QVfLbAp/mQbxw1ffXX8jKFoVSKIhmMapOlVVkQJ61CKuvwvVf4jWUwvhw6c3O
	3WtLP+ZvPm3e8hIYhVaM0QX3hYQKeUy82Z7y6WwddrgMwcxBko5rr4BVlJSgTOsXpADKeOC2qSP
	LMP0lOlbjLzCE5GrlrUL3JLfgy5sun7gl5wLrKqxGOUNqfGl084kdp9O/ENbyW5QlLpHzo4LkY2
	KqEMYjhY3Oar0/jOZ29mdsHbAx7jWJeLRz6s3oozEjjspvzAqi8Z+6blPC0kiN5oSMtF/G1GHuo
	mWJI9iMiZVREt9iNZeU9QkxcwKAZLKop0AwudxJ8KcP2maBcD
X-Google-Smtp-Source: AGHT+IEhirihpN1QSJ58xrmifvBkFp/Oy5ttrOOp4jBR4YeWiJAGvBREB33nGZkv2OirbOnMcYZQZw==
X-Received: by 2002:a17:902:dad1:b0:242:befb:b04e with SMTP id d9443c01a7336-2462ee9cbfcmr253453335ad.25.1756292103508;
        Wed, 27 Aug 2025 03:55:03 -0700 (PDT)
Received: from ti-am64x-sdk.. ([152.57.137.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668779f6csm119573885ad.26.2025.08.27.03.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:55:03 -0700 (PDT)
From: bhanuseshukumar <bhanuseshukumar@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	shuah@kernel.org
Cc: peterz@infradead.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	bhanuseshukumar@gmail.com
Subject: [PATCH v2] selftests: futex; Fix spelling in test messages
Date: Wed, 27 Aug 2025 16:24:12 +0530
Message-Id: <20250827105412.19113-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Correct few spelling mistakes in selftest output messages to improve
    readability

Signed-off-by: bhanuseshukumar <bhanuseshukumar@gmail.com>
---
 This fix is part of kselftest pre-requisite task for kernel mentorship fall 2025.

 --changes in v2 to v1
     grammar fix : instead -> instead of 
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index aea001ac4946..8a5735391f2e 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -132,7 +132,7 @@ static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
 	printf("  -c    Use color\n");
-	printf("  -g    Test global hash instead intead local immutable \n");
+	printf("  -g    Test global hash instead of local immutable \n");
 	printf("  -h    Display this help message\n");
 	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
 	       VQUIET, VCRITICAL, VINFO);
@@ -267,7 +267,7 @@ int main(int argc, char *argv[])
 	join_max_threads();
 
 	ret = futex_hash_slots_get();
-	ksft_test_result(ret == 2, "No more auto-resize after manaul setting, got %d\n",
+	ksft_test_result(ret == 2, "No more auto-resize after manual setting, got %d\n",
 			 ret);
 
 	futex_hash_slots_set_must_fail(1 << 29);
-- 
2.34.1


