Return-Path: <linux-kselftest+bounces-40046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0BB3806B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 12:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C48686BD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529DE34DCC2;
	Wed, 27 Aug 2025 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeDkd7CM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D434A331;
	Wed, 27 Aug 2025 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292255; cv=none; b=n2jMfizIouZ07IDuAQ4LqM7uQnv0ynSIupnMXNTaH1OxXKyAaebfKNXTJUtrlZTP9XBKNhVF41s7WScJrbS/A7SaECv1GdtE0Ng0GvunxYLQ8xobMKPnPN3WekZnoUrudjBS0PumchGAhkaygw1nCFvMSNUBwMrg2gaKS6jWHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292255; c=relaxed/simple;
	bh=0ZpmIIN0uu5nMw2RHk2QulZtCu0yMzmZ0nU8Is5Q9z0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UEB5z0xQTQGM2/HlU7FtFNqXiAOuL9OwyALNymmpGQghLIzn1hA2Ui4tBCS/HLbjx2taZxmovHNeEo78HfAVfzDLK3G7wnzMuvYvdXYaQqrbStAECjDprogZgGcSBVIyLtnayRdMxHRMW1BoWQPMBTnATmrTg/E/1AY5REK7nV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeDkd7CM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so6224912b3a.0;
        Wed, 27 Aug 2025 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756292252; x=1756897052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l2EpUNUryTNGX6oXQWNBchEosjC3dsxwJWjqftVi2/I=;
        b=BeDkd7CMEUW/9wDgdC18lRwyOtsHpmqb9E3s8sW6IQWIhUkUKyvMmr3N+Vi9LH0vkI
         Y+JoC2NWckb96Tj96WSi5dmD9i5lSLvcO74llC2HXXn9rq3jWC9jmJkfvdZcoBKw935X
         XhypXFBattdHlZJ7eyw3pijB6lf7+QyfohFNdhi5Vq3B2RqxTQ04Y885r9d7z2MQEqH0
         NVldPlb1PXjyr/QxIqVkqaMlo6hYdy3bIWclucUYVznfIMKjWt6tC01woJCCx9CLyjKk
         PBVSjCPy+6cRhUMCnvht2bwMpshV8QcKiy4uwqrtMqfvpKMEx7ncguJAV6uzHRMqx0bB
         XGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292252; x=1756897052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2EpUNUryTNGX6oXQWNBchEosjC3dsxwJWjqftVi2/I=;
        b=RU8QLnyU92zCTWNQbafJimZN5uDDxLeY5ctToRwdf7kvKXL3MmSq/zpWafjJLYYjYS
         02q1OKdj2ZthdG0n3EOKmx/lzY2TzqNretM2TeyzRwXqRf4w1PgUCxggCc8d2DlZ9AWT
         iwvbIrU+21Zvy/ZDss4Tn7ipRCsL5OUyQHAjaueoAfgsXmIMzPRUwBHV7vY+2bGzm+OV
         lxzPzLcvQbvASCSF+mMG9mCCeLT3pW69NF5z6tZ9RUW0hZXFqv/HeP6JyYB7yPDe63Wh
         mG6MEZkkfkAY6VUn/SZasuE2BSfbzFL7dbacqgiHKxk7e/RHUjt3cFerwx50zLnW+pZn
         EYiw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Hr7gAmW1F0ksT+GkZFthlW60exgvaRuzaM1wz6Y9+O4F3sQ8c5ysgcQBWuTWxCGMGmsCaoRpUhU2BnQKEHv5@vger.kernel.org, AJvYcCW4QSv43SvdKRk2e2DaemotoaDGjy8ub2CicI3Tx6gxZYGDCIFRfpFhppUQ7snfXEW3XIprVRNxuVrwjDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5wV2uNEt+7ctmjlrI75Huqos9RpKnQP+fHpBiFW/LA8PXfzl5
	mrLCW+hbG/xN+4iK7CccWh26Al/fUTiuo0r5RMcEyEHO9SOh5ZTsgjo70aKYYiRo
X-Gm-Gg: ASbGnculX96EYFeck8FglyHn5by7++BGmaJWJ0DnY4/lBgGRynf5oi3WocUVmTAizbu
	azxX9dAQ9+B0zs7dcjjndIckbXbO+oMPcNo+E66/bqSGKtoXn6WTLG2Nzz0ZvJTa1WDin3SYeto
	c07RBFmIAxlS3npOtJGMi5hZ1yhCCaOVMVxQWnGGYe2ng+kkEozVBblW2inNiUDQuZg3w4a6l0v
	7f09XrdmBFgAg7kkTQCLkHi+Lc5hwFwHjL3p9M/eybq7f/WsabVN4JPdF6hMVIb/kYdGcrC3ddx
	OwuCPKdEVZ70kPCyHihg6vODo/pBfEIj7ES8Ee+onm7WTLhV06ySzKwA4hINpjgYp8XRjufUSG2
	10vx5536otoqhjR39tWXbhFtMZlKMDQWfnOcJKw==
X-Google-Smtp-Source: AGHT+IFKSW5R5mt5f2yEqDcsOKOhySbivHHOjFqhMtMCcpw9s1O1H1GZwsOhvMfu5vBPWSHS4aXAlw==
X-Received: by 2002:a17:902:d2d1:b0:240:48f4:40f7 with SMTP id d9443c01a7336-2462ef423e2mr265865735ad.39.1756292251960;
        Wed, 27 Aug 2025 03:57:31 -0700 (PDT)
Received: from ti-am64x-sdk.. ([152.57.137.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b6a16ae3sm4277095ad.137.2025.08.27.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:57:31 -0700 (PDT)
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
Date: Wed, 27 Aug 2025 16:26:39 +0530
Message-Id: <20250827105639.19156-1-bhanuseshukumar@gmail.com>
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
     v1: https://lore.kernel.org/all/20250821154103.115110-1-bhanuseshukumar@gmail.com/      
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


