Return-Path: <linux-kselftest+bounces-40009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B3B3748D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0B83A2F14
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41FB285042;
	Tue, 26 Aug 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt+yYGMD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D7280325;
	Tue, 26 Aug 2025 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244990; cv=none; b=E5J9gg/7z47naOMhBH4+zP/2ljjwLSTcxcEKV8XyDLLTlyaZ1pLmWwV/MHI+XxuWzGthYVryJV5PALbZ0xLOtdJy8FHghnbnotVnpZn4m+rMWPTNTJfLXHGhoicC2VHSudmTUw9QYSErXHupr8HB5CjbAg/ngeUh/TjNa61k65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244990; c=relaxed/simple;
	bh=YTP7oljg0BII5171/1yq3+K9FoB8VehllhNiO9W07Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttl46UR3Ve3LvP/WAJT0EtPDCSWTBif4/Pj4Q2qsHvjQmYP2lbGRxki5N4UsUbm8QJA1oOYI+qGsMi1bSzcSRxbAKwXyTDMGjpwyLBmDUowS9D53Pzh1uGvqPxyYptK3mhfHNB97VH1VWBMzbZakPyo9eXZnJDA2YY1l/uLL+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt+yYGMD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so37296825e9.2;
        Tue, 26 Aug 2025 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756244987; x=1756849787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGxiUv+9T9MyXGrGc5hXaCPQg3e9+++0LsEZqWpGIE8=;
        b=Dt+yYGMD9lnM74K8A38gF/rPYyRVomKyh8ELDySN34jrIS4aLJTT5c3VD2kyOeepbt
         NCaaszPyQKASnnWcEF97vse38Yz+/D9R42+3llljfnjmRrIpE/IinIhAGwlLALxkyvrU
         unNUreOxLj+6f6qk6qhpCgdd3zswc2HHitk/591thXcX0EhQfYX/YdV4yTGXrb4kQIyL
         bF3/uUQ2RG5psRSSecbhqbXFRLIU3wEkzXvqYE0HIA9rewgPuwEylJkn0AdA45r6X88y
         0g8pM+DlvSqqFHcm+ghvhl6fRCrAlybhEo1G1s1MtuhCJ+uCv6+yzgWA5BRb+8uVsJFt
         RA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244987; x=1756849787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGxiUv+9T9MyXGrGc5hXaCPQg3e9+++0LsEZqWpGIE8=;
        b=ia8OTDqvmMjwCZZs5HzJycPUj3Zhk8AtuSOSvrEycpNE9vx4Y5zVjisy9g9rX3uHer
         iY+Auu9SunzSRSLZfXURGL2aX2EdfE67NgvgqqBMUtlDBdZTI23NhmZU0RPif3xv+LcN
         cKRAQe2aQYiGGe1PZYzx5J0G7WA5//5F9FZynqwgZzRF3pBVtzUQP7nKTxgcSQxnDsb2
         UzS5tKkFfZl7ZkwWsS+ZJO6ftb9Yb5dVOAqyr55eFXOlmmRASd8JYkqizDlq60/GY4Sr
         1SSkCYYACZqk/daeqDSZq0n4OFzJLQ00LK9BY6xuBNIq4fqCgQoHyTvAzRNF1l3tQ/JP
         KZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUIHaU8I9E+rw7qQlpKUgrHVl25bJneEZ721Wm7+gFBTsppwaqgkSAaRuPTEXubGRyNdQvE52KkGwrxfX4=@vger.kernel.org, AJvYcCVigapHFx7x9vUZ+HOt8W3cNXUc98dQO/26Uo0Z9Zh9OwyO3pPukXsKo+MIm2VIDLBWF1CTW0xweP2WnUmxFsYA@vger.kernel.org
X-Gm-Message-State: AOJu0YyKYroGUfXzwIF4HViu9Hl3IyIlxgfv5wdmtC7j/DDB+fIbr3mu
	voNkX7piEulsvSf6agETgdyfjoRJgxZBygJhl7URRt6/k/AhyUHdFZxQ
X-Gm-Gg: ASbGnctBGxIuuHea23PTPWc5f4DyGWAwoF3bMNmeVFQPdFLsRFel5u9+XHzTbs0WBmL
	pN6P6Kajc0u566qr9wTnIZKuaz9ijN7pp/mM/6lQW9QLeNilv7ax1kb9zYTPJykFVZUQ88z9ADG
	rg1xvLjH4Tn5s8hLBGOo+eI1XL0+ueW0jWays5PfJQ99WCQ3qba6b2hoBSfpFJ+/va9RLajvfoV
	tXJWj2lg2yZvzlOepOY5bAKUO+AHCz5VUmuxtzzfse+SqalCK1UQ7MzR0kXjjYFptKmhoCkm/Wr
	tE8B1Ls6/+OsXAItt/r/lC3hcaLcGRQGaKYnAlw4xo/CMelEGSebl9k6DMXGVQuSsXC8/aWyUwo
	i2fzVmdYPDpb00+fXGpFsmvNLw5u1whzZw9zvocrRuvZM5ljtDpuCbJdWVFXmGwMh
X-Google-Smtp-Source: AGHT+IHv+Wry+OjQYum2M7c57rs+J3M7hZ2o5axY1fUO2E8dRSkddQaT/i6JHD3BgXqPOrIfoE/gqg==
X-Received: by 2002:a05:600c:3b95:b0:459:df07:6db7 with SMTP id 5b1f17b1804b1-45b5179b2a1mr156669565e9.6.1756244987084;
        Tue, 26 Aug 2025 14:49:47 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211b19sm18309207f8f.39.2025.08.26.14.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:49:46 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: bagasdotme@gmail.com,
	Markus.Elfring@web.de,
	broonie@kernel.org
Cc: shuah@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	ebiggers@google.com,
	catalin.marinas@arm.com,
	martin.petersen@oracle.com,
	ardb@kernel.org,
	thiago.bauermann@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH v2] selftests/arm64: Fix grammatical error in string literals
Date: Wed, 27 Aug 2025 00:49:13 +0300
Message-ID: <20250826214913.866695-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix grammatical error in <past tense verb> + <infinitive>
construct related to memory allocation checks.
In essence change "Failed to allocated" to "Failed to allocate".

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
Changes in v2:
- More descriptive commit message

Original title is "Fix typos in malloc return value check"

 tools/testing/selftests/arm64/fp/fp-stress.c   | 2 +-
 tools/testing/selftests/arm64/fp/kernel-test.c | 4 ++--
 tools/testing/selftests/arm64/gcs/gcs-stress.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 74e23208b94c..ddc01efea3f9 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -549,7 +549,7 @@ int main(int argc, char **argv)
 
 	evs = calloc(tests, sizeof(*evs));
 	if (!evs)
-		ksft_exit_fail_msg("Failed to allocated %d epoll events\n",
+		ksft_exit_fail_msg("Failed to allocate %d epoll events\n",
 				   tests);
 
 	for (i = 0; i < cpus; i++) {
diff --git a/tools/testing/selftests/arm64/fp/kernel-test.c b/tools/testing/selftests/arm64/fp/kernel-test.c
index e3cec3723ffa..0c40007d1282 100644
--- a/tools/testing/selftests/arm64/fp/kernel-test.c
+++ b/tools/testing/selftests/arm64/fp/kernel-test.c
@@ -188,13 +188,13 @@ static bool create_socket(void)
 
 	ref = malloc(digest_len);
 	if (!ref) {
-		printf("Failed to allocated %d byte reference\n", digest_len);
+		printf("Failed to allocate %d byte reference\n", digest_len);
 		return false;
 	}
 
 	digest = malloc(digest_len);
 	if (!digest) {
-		printf("Failed to allocated %d byte digest\n", digest_len);
+		printf("Failed to allocate %d byte digest\n", digest_len);
 		return false;
 	}
 
diff --git a/tools/testing/selftests/arm64/gcs/gcs-stress.c b/tools/testing/selftests/arm64/gcs/gcs-stress.c
index bbc7f4950c13..cf316d78ea97 100644
--- a/tools/testing/selftests/arm64/gcs/gcs-stress.c
+++ b/tools/testing/selftests/arm64/gcs/gcs-stress.c
@@ -433,7 +433,7 @@ int main(int argc, char **argv)
 
 	evs = calloc(tests, sizeof(*evs));
 	if (!evs)
-		ksft_exit_fail_msg("Failed to allocated %d epoll events\n",
+		ksft_exit_fail_msg("Failed to allocate %d epoll events\n",
 				   tests);
 
 	for (i = 0; i < gcs_threads; i++)
-- 
2.50.1


