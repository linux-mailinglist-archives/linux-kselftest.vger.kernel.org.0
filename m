Return-Path: <linux-kselftest+bounces-39807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBD8B33009
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 15:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26F5481745
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 13:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B5623770A;
	Sun, 24 Aug 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkw1NFQr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47736A41;
	Sun, 24 Aug 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756041435; cv=none; b=D4AObZGBYL0WELzvGlnT8y/9H5UmKl0VVWoifSszMqEvlrdlNHrTCosLjili1anfWf3OYnRqIJDrALneuk5PwU29rhyVrl5qUxrdBioLHf0NONNexTehI52HBPGjcHTOi2xtZrLyeYZCZ0/QEhbS9TLR6mQtG7g/LLaIooP3U+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756041435; c=relaxed/simple;
	bh=aW2h0iy5gKk1+VvNp0eqYZTL0H7VitB+EhzBXV5jkvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUtEx+UuRkPGSRHHbbK/Yrj41W7vI5BcSGWtjbuxbUgTgZhutzNo69tTVMCQn5Xp20tIftuTomhaLu7BAfyDx0AQjBJPipokHRz/dtJUlDZNrNPyRwkP8aj9lw9t44NpGId55lHNGJvAICCSv/jpFyuWYWxYanWPEbCHrrK4G3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkw1NFQr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so21814915e9.1;
        Sun, 24 Aug 2025 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756041431; x=1756646231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2N4Xz/BxoJnUC9kUOnfvhJZVau4iCsVpuk+xhLKOTWE=;
        b=Dkw1NFQrr3/9ezjm97kaBOmhS9er3iGQzxWpyqZyAL16LP2nv8Unk7d4vnuBNigeGa
         B9Ry8Ugi2p57LU2MJZc7m6R2dI2QE4DELfyZrOvzBDFFqBqEuG84gPKt5Tke4gh6Nt7e
         6JmAXS/vjYVWpvHJ2jNHCtmRXanzoWMJvJnDgMvZPLmAK1xXub67gJ7CqtzzqrzZ70DU
         pjVZxLyszwiQ2YFX6y2ZKq5iQ4xUQIY90ErVm9mKUcsSg+jDqiSOmfgPXx2m2BtQ/JAb
         bSRJe2VfP99/MaNnrbMDHRpmyxLAU7tON3tvcCf9q0Jy91tM9rGCT/9aXuYBmRSsnsWZ
         epoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756041431; x=1756646231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N4Xz/BxoJnUC9kUOnfvhJZVau4iCsVpuk+xhLKOTWE=;
        b=E97l3w73Xyxcb0Lokxip99LZrFoaBa/uifWDhML4ViKejbYmP4AxcxmfooKt8+tO96
         MN5/DdGPZvFLkcXmVrkbNG/RDbZNEwoXev7MZzv0I2KGeW4L3Js3M9iqh+bvUXwUwzx8
         Nh0kO5HFVFZFoNAqij8ZDRYh+6pq8reH/J2fxCG6c8z7JjJfJc4qAHVcUVCjuERxlNAE
         6aFulpk2Er6TvZkYKrO9127njIG4NuZ+bejMIfYo/+eTycDzIghoqhnFb/k6Q/FtMHol
         hhrQeMgGxfs3zbg+ykfCw6DpCw+Ur3TBZgpPHBSiHUO9YinaHZiTzewiFJP93QJEQZda
         MQPA==
X-Forwarded-Encrypted: i=1; AJvYcCUE5hQmVThY21ql3cz4K/UtQG9V5JyNcfu1GXW6z3i9WUWyMss+jK0MqT0HijXpF7BuwqXPhdaE89zdZkJvvKJB@vger.kernel.org, AJvYcCVvq+ylNkLYiKT8h50SqDNScS9dBfMhTeqZrkbB4XcHsGIJws/vebCmXtXlhNAeaxtWrez6r4r1X3QhedQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF28uPGGiTfUTioVj5i8Yy+fXCJeYf996qsBHoMtQBY1WEdZyo
	OIcRHipLMRo32QxODRqahVKq3GaW76eafdw6VQBAgB4lGpoWO6XEGOuU
X-Gm-Gg: ASbGncu7sLyfKcs/UKiO02ooHtdSTMHXjfvRTKV0E3WjhEcSHdpZ6ypGl+9A0cOR+3o
	NGmy+5rVtAdSc37lvo5JjbR1JscqkHp+DhgjL3+AEVl8fiXSORmpe+iP+D2+jtJ7DJ3R8D9B7fc
	6bnyfQfN7ltLB+Ei6uHR1iPvZWAbv9LmRGugCDBdMlj2FDWlJVS1O8G3KappGyHdDym9fJwDSNZ
	g4Xj9vwblnwpfqEsefMVj2Bf6Lx31CKKgIwKyw92HtDTVWXSCFh1u6GAUXE3rgP8Ys7C3vs9WLG
	K7E+hDtg+1D4Nd1pro+LPQtBEs6L42024LBhL9ofAH0o8UiJmk2jSPudNMtuBWsM7WXOkK421x+
	j4kad6XlMGwWgFzrmS093lkUX6Fh/BG9ut2OibqzKwLp5AOFyQmaGDoWo2QhWWPm8LuBLlyVlpI
	o8LIgOHvI9pQ==
X-Google-Smtp-Source: AGHT+IF0p6X6DqMaft8bVb+xHZzWcrilM0oEkMehJr2d4YlsCBG5vyIsnO0FKQC5OMwp0lsuPqbhag==
X-Received: by 2002:a05:600c:198f:b0:459:d709:e5cf with SMTP id 5b1f17b1804b1-45b5179b710mr77565375e9.3.1756041431473;
        Sun, 24 Aug 2025 06:17:11 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e8f4552sm75658355e9.8.2025.08.24.06.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 06:17:11 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	ebiggers@google.com,
	martin.petersen@oracle.com,
	ardb@kernel.org,
	broonie@kernel.org,
	thiago.bauermann@linaro.org,
	linux-kselftest@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH] selftests/arm64: Fix typos in malloc return value check
Date: Sun, 24 Aug 2025 16:16:47 +0300
Message-ID: <20250824131647.490439-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix double "-ed" in malloc return value check

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
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


