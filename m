Return-Path: <linux-kselftest+bounces-38463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6746CB1D6DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 13:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4227B583539
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE4F10957;
	Thu,  7 Aug 2025 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXguS2hb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B7279359;
	Thu,  7 Aug 2025 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754566999; cv=none; b=GZVn3a+ennqSwOw9QtMD5+eQ8GK2+dBukcSRuJmByDZAfnNlzuqUPKDnXzVdARvaUve8Wx1yTDiTmtYVNzF2P/pFNr7c1SFsnxGoXcBXcbEU7n/S1IOOQLKuOB4KURaD9Azb2dLWZQ1Nh78k/DP3APLSAsiask1qmJWF93zP3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754566999; c=relaxed/simple;
	bh=w6QdDiq1J/nY2DgtOOLTOlq986UtCAp+weFPE8PWT8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPsNF44hGtfBZDQ8ewIfubFxUNQ1dBYOCpy9gipepW7G58MoxjhKemDiN0b73PfKz/Ht7QDkBi/ubnpw2GLAqfO68PHNUTDecyIiQoCYH0DQRGDXFcfrOEXzMiBi3ISvLaGdtDPgIrvbZMNRWYAFK8ts6h9Bg/tZkCEmKIICGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXguS2hb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23c8f179e1bso11436305ad.1;
        Thu, 07 Aug 2025 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754566997; x=1755171797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdlVCkRqpyT4stO0yYsnNwcVWyXxNhQoiEcxn+xkM94=;
        b=OXguS2hbcJN7pX4HLj1zV+4WA4/qc8MweFVFR8ceV7jYhN8UAuMh7uyoQLyvUVaktQ
         jaS6lyhVhxgd839fB+70ho5EsjiUOJtod+xR6aKz286FJ0dBePGZjEvwc/RmMWmjdStO
         MrQ4QCy0XLS0V0TegRnQ19FjJ9PlAzh1M3mFrDB+B9S/PXOzBNdu02sDE8mMjAR/Ax4m
         gkbanSfaG8XSMNYvg/CMbxPtFlFSH1IwCcgI3yk9Wvcpn1ImWd784GuFlYj9rJwzWU27
         K7ycofqW5H8R4IG4OIJJBXkWvmqcL+Jbt0njW81eOaLjyAGpCQ31kW1WtIAr029kdGKV
         cI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754566997; x=1755171797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdlVCkRqpyT4stO0yYsnNwcVWyXxNhQoiEcxn+xkM94=;
        b=VTsxZVKrxpaQ5ArZLZCmtG+bX84FKXDdTzppwsrE+Nd+db8kQTmu1RWj9omj26OdHJ
         pd92g01dyWWMEykc28hzly0Tp5bW7q/rJ+YhTdDLQRuAgy+0F/3SzsL7j1q8XqOsqKxL
         aNxpQASt2tNJ2AKvUeFTzIgHf9U+P6uVeB/iAZXnSvMSE9yKoUR3OLhN+/0OtTio/KiP
         YQ+3M+ViE1wsWKC15nH4Nv6FMLguGh5Lttcl6OpIL+ZW1b0X7UxVHQqyPJf7Rt5hB8Mc
         /cHmLPYriyd2NHjUjkFqWUj+MADKlnDewjU4RRC17c5aI1YoNNmREHS8K+S/uvQt5SEX
         93Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVoggBX5Ye2BZh644GQ9WkCOfo9N+DZ1wYiUK2XteViML0MB+t+T5wTkF65USghEw2o92mC1kdwLtYo0uA=@vger.kernel.org, AJvYcCXFaxqyHmRkswYsW7uRROEUARhciTAT3e0H/BZRb92486+c8ubE/KHf7xcjT+EaDdiBjhrjQA7RJsKKSgXPw8gI@vger.kernel.org
X-Gm-Message-State: AOJu0YyQB/ptHDaBW7IvMH7qkBp085MRAvBa9DO6BLrElhPtz+4aYElU
	Gan5vIeDtu3nLvaOLk7LIuOKgAcCNb4CJefKFgojD74F5QKVPmPVprRA
X-Gm-Gg: ASbGncu4m28v3Vqo0rJEfFl15NMaBjN4vivY6qhHJyoqfN/Oy3ZH9V8vQaSLOBQIXdx
	rxDwHLvVjECZCWU6RHIj+UHH+f/2i2mupexNwxsbJJNkIttgqNyJVCesl2XpwJyyBzttNSuocn+
	LHDpOFIfDYIr/A4fL42mqYsMtXolnmyzLwI4JAdwmufYW5DNzWejjQ9jhQWaqrAGcphUukSbHVu
	gHQxDHy+dZVGRadtUiB1nQo9IZNUpEKVZ6JPM2j9xGNYM0p+9qGvubH1a9tSrYCNQ4fhMOgLQ2K
	7CGGPd6OPRvGvHeuARUiTHPo0Xh94gmNa+2WFaU94hmgzDxJ5eTvyXWlhfRPCtNz0SSpKeQBlt8
	wrrLbn2GonUZ10X9ykNWemdOyvrvfzBYe
X-Google-Smtp-Source: AGHT+IE2hsYekMhLXI33VtBrvQam/zjpy9H9MOsiwWs+FoHJi4dQMfSq1UkXnmhWZTzFkbdUBV8TIg==
X-Received: by 2002:a17:902:f687:b0:240:aa0:1584 with SMTP id d9443c01a7336-242a0b8bc9fmr89417695ad.38.1754566996623;
        Thu, 07 Aug 2025 04:43:16 -0700 (PDT)
Received: from server.. ([103.251.57.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm185729405ad.73.2025.08.07.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:43:16 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: anshuman.khandual@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	broonie@kernel.org,
	yeoreum.yun@arm.com,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Subject: [PATCH v2] selftests: arm64: Fix -Waddress warning in tpidr2 test
Date: Thu,  7 Aug 2025 17:12:29 +0530
Message-ID: <20250807114247.5915-2-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807114247.5915-1-reddybalavignesh9979@gmail.com>
References: <005af416-66fa-4222-964d-e20bd2eccb7f@arm.com>
 <20250807114247.5915-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve compiler warning about always true condition in ksft_test_result
in tpidr2, passing actual function.

This silences -Waddress warning while maintaining test functionality.

Fixes compiler warning (similar for other functions):
warning: the address of 'write_read' will always evaluate as
'true' [-Waddress]

Fixes: 6d80cb73131d ("kselftest/arm64: Convert tpidr2 test to use kselftest.h")

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 tools/testing/selftests/arm64/abi/tpidr2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
index f58a9f89b952..4c89ab0f1010 100644
--- a/tools/testing/selftests/arm64/abi/tpidr2.c
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -227,10 +227,10 @@ int main(int argc, char **argv)
 	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
 	if (ret >= 0) {
 		ksft_test_result(default_value(), "default_value\n");
-		ksft_test_result(write_read, "write_read\n");
-		ksft_test_result(write_sleep_read, "write_sleep_read\n");
-		ksft_test_result(write_fork_read, "write_fork_read\n");
-		ksft_test_result(write_clone_read, "write_clone_read\n");
+		ksft_test_result(write_read(), "write_read\n");
+		ksft_test_result(write_sleep_read(), "write_sleep_read\n");
+		ksft_test_result(write_fork_read(), "write_fork_read\n");
+		ksft_test_result(write_clone_read(), "write_clone_read\n");
 
 	} else {
 		ksft_print_msg("SME support not present\n");
-- 
2.43.0


