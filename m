Return-Path: <linux-kselftest+bounces-39088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449EB27D49
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 11:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9A37B58B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ADC2F746B;
	Fri, 15 Aug 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmMO4WMs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1362F0C64;
	Fri, 15 Aug 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250819; cv=none; b=QNWqtOHuzM2/w7x/J9VdlY1v0Xt0aK1+BySPjOskwJCfJE1G8ulh2ncji6RzfuOM7Bh7zVDKQzFJpSR1JgkfeEmArzmzjuKqVhVloxWc3q2slR/XOgytIBJ6F0ZYdFDv8UhmhxW9P/undw3gK2fcN8dxatGvm6HTL0eSsBX4xdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250819; c=relaxed/simple;
	bh=whpeQLd/ONXc5d3w4EWvao23vVy7bdwGUSUQMFmelyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7o/WOW6zrgclxIy6BhQsZMI5pnciJtEXPM8rhgaMNLhnTNxM04oYD19n73ZBsgahIpjKPUf7gmxb/fYkQl5PilseXjulJUuht46n1eYr4czkR2qXuSTyTe+qVvRfCD9svnFpYUDtU/nCKAegemAN9y36d8G55OmUkFUuAgnlVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmMO4WMs; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47052620a6so2226666a12.1;
        Fri, 15 Aug 2025 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755250817; x=1755855617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb59vZc0r3SnxTBn3fpGLZ7jKF2s9oF0aj2fWUpQssE=;
        b=BmMO4WMsOh26ZvoonZPGmTEMJIr3XPBiOKcqcDIr1DcJFXnOfkmaVWY2rRXo79kype
         14DpFK+8Aju1l1w7y1Yu9hhAaQfeIV94uPvw7jdI/iLFT9da3BHPnLILhk8ZLxX/PbqD
         BT72pgGmOjpWLIaB42PPRqIQqgaTAV4Zw3hmiqSl7Ptn85K0DpJLlqSUasDqVSx7ecZN
         SujkJGrVC6ZpUi1SkjBTNjLkCYkqGBDV3hjCG+xGLDHriShYwxAU7Fli+ZxZckk8HthJ
         3Q1ovHHTnv0/lIiuPo4RZt6VOslbRT6cYQA/ot1aJ8tVN1puJq7i6Pxr46U04ygHk6lU
         r5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755250817; x=1755855617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb59vZc0r3SnxTBn3fpGLZ7jKF2s9oF0aj2fWUpQssE=;
        b=Ll8JDjyeMMOZNxLW7btjuhGRBtFHxSMhziqj2hRJnc86lAcpk2DRAbV4gYq3783afJ
         nNNj4E02Zl5XyA/obMssvo4gSTq53Tiz3pW+xE5KowKGx95reF2b6gJvU0CiqZnyobXy
         rPm4iSkKx5ZoxcW6tpeVWZnJzoyFeyWTReOXT7/HIm6bFLsiZ5dnY38jD//QEhmvegcW
         o38zuQa4liKA57t3YHBgqsvCXPJvD5DyjuaP8sv4z2o4nVmClE0KU1rg+SfFcFmF3nXF
         Pf0Srv+eH7VqfJgs4Z3q3sG83NM5D7KnArU1r+Bx8b58dpSPY7ctXwiHL14TXrD5Y4RQ
         WWtw==
X-Forwarded-Encrypted: i=1; AJvYcCVGiDrbrOqloOi1OPQmKNvjjyXv75eqMwYlpvTsAkOtKwj9Z3an9QNTMfkRUOKzhExOJLeeuPwXtcbSxGg=@vger.kernel.org, AJvYcCXc/2AXCb6A0pzicEJD0VQAenxJlaiiEajs0wx7eMFSDuLdM4+6k2Y6BGow8C+jer/0a/GGRXyA6DrO0j+f1dpc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5zA1hQdrHkvAozquf6H2veOvXUEJUPCAL4k/a3EMRxxi9nYQk
	kEn+nakELmYfr9dIFAweWRCk0tGAyfcd88JOPvwVqRv/z1PYrdH1IVBlUhV2aBZ9KvZ/fA==
X-Gm-Gg: ASbGncs7MReuxowS+vQiygzdlfMD72ChMT/1fPg736eL/dFKQSWuZOk8rotS0MQ4wzC
	MjxiHmTnhbTQGmiU+mviA9wDrLwgxoTCX9yC8J7J3oWQOyFeNvGJ0FCVoY6sGlToW0uolrk5fc+
	+ZW/CrAOIDMb6F8gFWxCYvfe3wHttxG6pWh3WiW96TpYv9p8a1srlTi/cnINZEulQEgEboc5DwZ
	S53t8/eGnt3QbE0o3YQn1PgRtMK6+wJW7BRX0ADiW6eNiZ+vd29kEL8HLlrK76gpHFNfx7KUU81
	x+ZAyqGl22HuorcqMkU+lBTBiC20zgjUcStpJxuoUgHc7nlGQJehlqWWlefXLIerbHuUy7aL/ib
	TP8ssF4sw/MEnGFTOFpRRRBsDX99jyL+TMDEevXHPgLAx+iyctXwgUg==
X-Google-Smtp-Source: AGHT+IF4s8vZ+UiJBxse2ETuu42pbherih7pTOd3GqJtWrEiYv5pQGik3DHXjIKSbfx73/CtvYgMvw==
X-Received: by 2002:a17:902:da82:b0:242:b138:8119 with SMTP id d9443c01a7336-2445988787emr87476215ad.26.1755250816863;
        Fri, 15 Aug 2025 02:40:16 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343962af1sm856597a91.3.2025.08.15.02.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:40:16 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: tglx@linutronix.de
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	mingo@redhat.com,
	peterz@infradead.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	shuah@kernel.org,
	bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] selftests/futex: fix typos and grammar in futex_priv_hash
Date: Fri, 15 Aug 2025 15:09:39 +0530
Message-ID: <20250815093942.8595-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix multiple typos and small grammar issues in help text,
comments and test messages in futex_priv_hash test.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../selftests/futex/functional/futex_priv_hash.c       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 2dca18fefedc..4a7dea008314 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -115,7 +115,7 @@ static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
 	printf("  -c    Use color\n");
-	printf("  -g    Test global hash instead intead local immutable \n");
+	printf("  -g    Test global hash instead of local immutable hash\n");
 	printf("  -h    Display this help message\n");
 	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
 	       VQUIET, VCRITICAL, VINFO);
@@ -180,7 +180,7 @@ int main(int argc, char *argv[])
 	if (ret != 0)
 		ksft_exit_fail_msg("pthread_join() failed: %d, %m\n", ret);
 
-	/* First thread, has to initialiaze private hash */
+	/* First thread, has to initialize private hash */
 	futex_slots1 = futex_hash_slots_get();
 	if (futex_slots1 <= 0) {
 		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
@@ -232,17 +232,17 @@ int main(int argc, char *argv[])
 
 	futex_hash_slots_set_verify(2);
 	join_max_threads();
-	ksft_test_result(counter == MAX_THREADS, "Created of waited for %d of %d threads\n",
+	ksft_test_result(counter == MAX_THREADS, "Created and waited for %d of %d threads\n",
 			 counter, MAX_THREADS);
 	counter = 0;
-	/* Once the user set something, auto reisze must be disabled */
+	/* Once the user set something, auto resize must be disabled */
 	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
 
 	create_max_threads(thread_lock_fn);
 	join_max_threads();
 
 	ret = futex_hash_slots_get();
-	ksft_test_result(ret == 2, "No more auto-resize after manaul setting, got %d\n",
+	ksft_test_result(ret == 2, "No more auto-resize after manual setting, got %d\n",
 			 ret);
 
 	futex_hash_slots_set_must_fail(1 << 29, 0);
-- 
2.43.0


