Return-Path: <linux-kselftest+bounces-36601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DC2AF9AFB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 21:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6524168BAD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD23A1E9B29;
	Fri,  4 Jul 2025 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3gQnIvW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69520ED
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751655783; cv=none; b=p3zm5P3AwuxJN4Uxkc4Hier1LlYOq98Kw+VvnvhcNyhWpleGWG7trfOfW+d6Hb2gD9WKnEgn1tPut0qUHfq/bAt0QghigRasmIw/Avg8nvXuuIUcRHFs3558XPivsZOHkMDz3H9vimc2x7JmAZjGbGqLcCaRWDzFQDW6hNZ1rKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751655783; c=relaxed/simple;
	bh=/v6QItEjY2M41/Qa9fmYKxE5bdEX6yoFE70JLIG+fSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YiP6hHXgXrfAYJPB50UPdKZPGpnrBczrDR7pSGYfwvM9gelgdrvwmiztBPYiGyHBzc1EY/ARThUYCnTM9qeUPR3f/GM8kdne6Kcc0KGQvi/VuPg3vjUt/5wiA/s65I/F9tPMkop3FimnZ7PafHVujbgB9gTPZ7nCt304DxmDhwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3gQnIvW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so10566095e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jul 2025 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751655779; x=1752260579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBZoBb5JCYLVeVGhzIarMky5rZCEpXBsa3Bvtdfk3uM=;
        b=g3gQnIvWMBf1EnLBvdcHi0cRwpfqI1vAsbuiLQ8ns/4DDZTEZTqzmIZkqUauCE3oJU
         pFprCieK5523SpJ2uWUPlRCkcT7Z0S/B75Dhf1wXxrgP4x2TW0ky9jtFfWaB9z5xo4A5
         7TYxg3MlNLKJCj3pJifZgCizUvEr59MiJmFf0NBffycl6osK8MFwBCnPiBgAqrapc4ej
         uLFTWddEi+m3G+UNBj7LjWlQQwGnJ43Xeenv1CwmrfpBclbLP/v9CLurBa+o6Az9+gbG
         mBSgV9s0nEqyK+MvOMv4Kki2fnJBCuM9Vkc1hiVquc5Ws1lidkytBYN//ndXrB/XCRpX
         8vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751655779; x=1752260579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBZoBb5JCYLVeVGhzIarMky5rZCEpXBsa3Bvtdfk3uM=;
        b=ark2ZaGrDigHcJiMvtvaDgWRIRJ5q57ze/TeM3jyQ3Q5AWJS+5k9AUgPvpld3rz2gR
         mP2Q88b3Bocb9HQ8tNQGurKvK0WubnMFc6qEeZwHQEkbLeciTjN6EV7EqJbFFMyJpih+
         y5/rfpSpKHVZ8DRWD+zmWGRp3vCL8T4A5r3nuh7nOiOcX9CyBoagnbr49tNeQpSVTNl2
         1+ydWMcyotBng5zB3JZ+zQUzotdv8jmuxDL+dRghSUEKe5PBAPkWZHsteoTIUAldtUWR
         QZKw7lCF2NDebESUcJP5v1BZ/IH+M7jtIG349HMtj83DC+w5yN4rVHdcIL8oGLBP0ka7
         CkWA==
X-Forwarded-Encrypted: i=1; AJvYcCVIKfe31nHRJMw4JOtKEuTOp9CYW3u1aa7UUcHJFsppLP0Ki/fkVVi3JaZu1fkRWwiim/crQt7vP8K2GGwIRhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdikz0/zCWV+RFr8qmcp7R7mWBAqxUNhNGFySt54rcGv5Hhn9
	xDmQPjEGERNh7I3gXP0iodffeaC8EB+LxR9/Af/K4jHVCU/8oMqPZHNa0iNTSs/vOU0=
X-Gm-Gg: ASbGncu6g7LfZbC4Qznd0Rw3UZuGyEE64D7YvwRKMtuupuDVmpweNuR+abYsADGMXa1
	o42NwapjwErFUQmrxjSDruvj921yGAov83x5A7Q2uJ4Nk26Nu50JLTRVzA9c4pcT72hyKST57d9
	ywx8ixZIWVj+4kgIPLFhvVraulEU3bM7pzhydM6mBupA3Ks/pC6d2/NVDecf85HgMGndqEJdORf
	ubjSGaamTokw7+q45oIAnWzxu/hFLMgNkarzP1G8KIEenTvtdu6TpsXiReGcxSDPa6UWQpFmLe+
	EOkuHq84yL7qbNeA0O8Khrt8YkZGtx6oFe4fDThLjx/aO0qIgFnDkSO8ILF7A6BpF1EAE8w5hNy
	sRUpJiBIS7SwjXEbxpf/FrShQajwvTFq1UV7ivl7VNE5ETAw9Ojr/CAqgFMH5Ix50s07OrtY=
X-Google-Smtp-Source: AGHT+IHsW1Nk92FeuphcCxSTyljJ7SWSU/rzOCynLFyorepBd+U4hYT9fjCdNkZIa26bYhCJTJh2CA==
X-Received: by 2002:a05:600c:1c21:b0:453:7b2b:ed2e with SMTP id 5b1f17b1804b1-454b4eb7e77mr32347315e9.24.1751655779121;
        Fri, 04 Jul 2025 12:02:59 -0700 (PDT)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bde35dsm62220505e9.30.2025.07.04.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 12:02:57 -0700 (PDT)
From: Terry Tritton <terry.tritton@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: ttritton@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Terry Tritton <terry.tritton@linaro.org>,
	Wei Gao <wegao@suse.com>
Subject: [PATCH v5] selftests/futex: Convert 32bit timespec struct to 64bit version for 32bit compatibility mode
Date: Fri,  4 Jul 2025 20:02:34 +0100
Message-Id: <20250704190234.14230-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sys_futex_wait() can not accept old_timespec32 struct, so userspace should
convert it from 32bit to 64bit before syscall to support 32bit compatible
mode.

This fix is based off [1]

Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]

Originally-by: Wei Gao <wegao@suse.com>
Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
Changes in v5:
- Fixed checkpatch errors

Changes in v4:
- Change to use __kernel_timespec as suggested by tglx

Changes in v3:
- Fix signed-off-by chain but for real this time

Changes in v2:
- Fix signed-off-by chain
 tools/testing/selftests/futex/include/futex2test.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index ea79662405bc..ff9eebcc270c 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -5,6 +5,7 @@
  * Copyright 2021 Collabora Ltd.
  */
 #include <stdint.h>
+#include <linux/time_types.h>
 
 #define u64_to_ptr(x) ((void *)(uintptr_t)(x))
 
@@ -65,7 +66,12 @@ struct futex32_numa {
 static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
 			      unsigned long flags, struct timespec *timo, clockid_t clockid)
 {
-	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+		struct __kernel_timespec ts = {
+				.tv_sec = timo->tv_sec,
+				.tv_nsec = timo->tv_nsec,
+		};
+
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts, clockid);
 }
 
 /*
-- 
2.39.5


