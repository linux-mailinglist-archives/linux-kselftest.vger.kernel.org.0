Return-Path: <linux-kselftest+bounces-47514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BACECCB969B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 18:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB363038F60
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5882D7DF8;
	Fri, 12 Dec 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Wm7JCvi4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EE26E719
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559832; cv=none; b=MFkyrZRrQU5mxcck5X+BOTNFfzVpTEB71Y9euI8Gzre7ssSqufEYAP4S9GnU4loPHYT/w1XLg6ZEfmUIs5r27z45ja3m0H3aECzO9iHy9TX2Szjw8RrYnqq1YC2OA4FhHaCA0w19huS7ESIfW8IMX8iJBH+ZYWX90Nqb4VHYoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559832; c=relaxed/simple;
	bh=OCxuEyv2nas70eB8lxzrmKzbwZmA0QEfOrxPlpwtsjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqBCO9m3FDVlabKbWYPfnSMW5Wac0f+4aEM0he46y5I/tGaP1qICmX/mzgGtMacMlnNUt8JTjj1otMv9GYD8VlvLIvQ0l59ao+DcFA0HaMDuHFIHy0I4Js54z4ujv0cijo8p0AaTctqeZXOlGREXpG4YYf5BvV4EurBo6CNrcIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Wm7JCvi4; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a07fb1527cso785985ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUEatCbGKBwWq9sjai5DOHkl1bVC/1UgUICmtg/O0zA=;
        b=Wm7JCvi4/NBSFYsrODbv48z54R+RKKp5q8854fJRK4biJ16UZXuEAtAuzOfc3yVSRH
         R2fKTo+PtXkKSrXPASt5VPom1xMOVFLMGhVvI2ciwixSwfbBMW8nONv8dgklr06P7M1Y
         rctkGkZUnhaHYR0+moyzFmUchZupH89hkdFqlFWIimURutXwocoBLDJ2uqkiGeA9NpBF
         E+Vqvw+TuWR2ZquIwdWYe0rzUtVycotqKpI5rPKFcvgTbuA4aF3KauyYGyyFFKVy5ESH
         3QBmM9IMGQOto9TUJ4ETmbeSq9THAcLInIIQPIj3YuwGVT7zvx2VCFTUu2shnzM0feOB
         y7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUEatCbGKBwWq9sjai5DOHkl1bVC/1UgUICmtg/O0zA=;
        b=voPV7ApN4icOUbKcVchNyTJejqKvdME8JUrW9Z+3Qm4doNY64FHlIDpfDCHgTtw2VE
         aXjjkLwAS0z99E54j3TpoxOmqhgiNFbDgoUPWr/JTxt9A7qfHZSrFjID7UKVtp12BGck
         tXidHbNnWsKhepV/v+GxclgGOBs/8aAqpYpyvBWfrtr3WwStQoGOwhI8nPerOnehCKZF
         mb1uQ4fCwKmqsteZ9pQ7rDYd91zG+Q6b90FgGGwmblbBrP1ZOeKvUxYgfsKJ9TBEzGmI
         bgqYnqCG/pPWdpRYAf1WjTiVTelp4kZdUubHxDUEUqxTXI5vvsq0nEzfR+nM0I/xu7i/
         /0ig==
X-Forwarded-Encrypted: i=1; AJvYcCViwUxCcaXnxYCnqSQzujpjyjt+IA+52nuOjP8do+OeDdQkMoaQuNWN1j29UHSzz9dSexTr4OP+0biYRFR8cWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEARYqFui7UZfREUVKkJMOiKMYb5sYZsVO9cwp4PQ9qXOje9NX
	jVWDJTEv8EtYco1aStls4hKQ3JoMq1fyH9x5pSCuSBPPKi6Pe6ktaLLVoJrwjrbVPwNGy7JD19o
	LF8hV2AXxWHCuvPb2Gx1i1t5CgwYLmnuXTy1ZX5suMFD5LlQvPSy4
X-Gm-Gg: AY/fxX7b5wzIcq/r2Mk1Yn4GLnMj4AXHHWCZt/FfwM/mJTHtBKxQ4pimSOsZdHPTYtJ
	YGwfdWrUteIiuK0LeZOxFuokTpis/VYQ7RppqYfGpqboQJ0bNg+/1J+bJaRfZTLN2loLKcJTAWZ
	Hauozf9K7f/9OLtRScIKHMQvAP+UvcshOmHa52k8vW51xYrWqNLPmYrC9gsiuGlOXPLyxuagScb
	JLiOxUSUvVuWZwwanodHKentM/TisyjtVCvXk/I0N2gvQ6LEQILc1YEgYaLhvmNEmZi3k9nUW2+
	U0bYH9Kk+JLfMYjVifNTg6zGsPN1QwTCYtPAL7jelvSwVE0t0f9vujQ8MQY7Cz4PmV3PAfN/Lhq
	YhHV9vxyGH7NbvTfk4EGuc+jmzAs=
X-Google-Smtp-Source: AGHT+IHn2ulh+ZuwuN1vTN3PVxeOFgna9Rb1nC6ChWNZ0/CCmOhfBSYIXXuw9VcJ4K+kBBcLwkyXdHgn/Ed/
X-Received: by 2002:a17:902:e5cb:b0:29a:56a:8b81 with SMTP id d9443c01a7336-29f244b9b3fmr19693165ad.8.1765559829756;
        Fri, 12 Dec 2025 09:17:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29ee9dae935sm8900575ad.54.2025.12.12.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1A37B3404B4;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 17D86E4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] selftests: ublk: fix overflow in ublk_queue_auto_zc_fallback()
Date: Fri, 12 Dec 2025 10:16:59 -0700
Message-ID: <20251212171707.1876250-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

The functions ublk_queue_use_zc(), ublk_queue_use_auto_zc(), and
ublk_queue_auto_zc_fallback() were returning int, but performing
bitwise AND on q->flags which is __u64.

When a flag bit is set in the upper 32 bits (beyond INT_MAX), the
result of the bitwise AND operation could overflow when cast to int,
leading to incorrect boolean evaluation.

For example, if UBLKS_Q_AUTO_BUF_REG_FALLBACK is 0x8000000000000000:
  - (u64)flags & 0x8000000000000000 = 0x8000000000000000
  - Cast to int: undefined behavior / incorrect value
  - Used in if(): may evaluate incorrectly

Fix by:
1. Changing return type from int to bool for semantic correctness
2. Using !! to explicitly convert to boolean (0 or 1)

This ensures the functions return proper boolean values regardless
of which bit position the flags occupy in the 64-bit field.

Fixes: c3a6d48f86da ("selftests: ublk: remove ublk queue self-defined flags")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index fe42705c6d42..6e8f381f3481 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -388,23 +388,23 @@ static inline int ublk_completed_tgt_io(struct ublk_thread *t,
 	t->io_inflight--;
 
 	return --io->tgt_ios == 0;
 }
 
-static inline int ublk_queue_use_zc(const struct ublk_queue *q)
+static inline bool ublk_queue_use_zc(const struct ublk_queue *q)
 {
-	return q->flags & UBLK_F_SUPPORT_ZERO_COPY;
+	return !!(q->flags & UBLK_F_SUPPORT_ZERO_COPY);
 }
 
-static inline int ublk_queue_use_auto_zc(const struct ublk_queue *q)
+static inline bool ublk_queue_use_auto_zc(const struct ublk_queue *q)
 {
-	return q->flags & UBLK_F_AUTO_BUF_REG;
+	return !!(q->flags & UBLK_F_AUTO_BUF_REG);
 }
 
-static inline int ublk_queue_auto_zc_fallback(const struct ublk_queue *q)
+static inline bool ublk_queue_auto_zc_fallback(const struct ublk_queue *q)
 {
-	return q->flags & UBLKS_Q_AUTO_BUF_REG_FALLBACK;
+	return !!(q->flags & UBLKS_Q_AUTO_BUF_REG_FALLBACK);
 }
 
 static inline int ublk_queue_no_buf(const struct ublk_queue *q)
 {
 	return ublk_queue_use_zc(q) || ublk_queue_use_auto_zc(q);
-- 
2.45.2


