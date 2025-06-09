Return-Path: <linux-kselftest+bounces-34475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAA1AD1E85
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DE17A37BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144FD2580F7;
	Mon,  9 Jun 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bypAm1PR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32932571C2
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Jun 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474723; cv=none; b=BEEAeWKTQZ23+DXpnKW9B9S2sXGfgtvPNQsEaT53QEsu/DSFQiMMZgVva5TAfkVsksK87nYyEGrDm9FCBfX+dsZTC2zUI34nXIsH4JTP8gNiSgTY138BhjmHBHXsAMSnmqrthlSRKBy04YSPgkLXvqFGs9rEcqIGVaGPtxmo+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474723; c=relaxed/simple;
	bh=HemcbqMmgRHK16eJTLxADLZuI4x27GbGQS2CfbnVQpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQhwfRaWxIQYWN2M1ZeckTQhoYOH5B0hsFpQbgD2e++9Saa9REj3jsGesZcUTyDnseIezCakumngwFc0nUoPE2lAmlJoA9L7mhgGgG63oj5UTBugjD/gPCbS1hiFwkbxNRAxOdTEl/k9XoOe46KH6oZtTofRYXE7VFCyUixjwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bypAm1PR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a5123c1533so2353610f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Jun 2025 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749474718; x=1750079518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIDEZTcLMIX8NSBMninMC+pCHmUrBf8fr/oqws99Skw=;
        b=bypAm1PR8FOT4zciR0lACcksq/CnauXGx7j/7SNtaz5r+AL6xTPM7rVR9Vz1Z4cEno
         rDUvkBetVPMPKGuefIYt3zc7ukv12HkaGLpd660hiPAutAczrTutUuOVZLPyATe92cw1
         Cmu+kiDhCBpmAs7cEe4egaos3gTmmboNAPOy5uEgHR2SjVLcntYYrmZhE5gY6Erm1A5s
         CSNWZaAznW3dVSB8Npj1bdcpDc/FQ9dX418veI7twjlnWSVMbFS9Ibi1UxTYaE5NaCyq
         TeUJQolUv2UTOeqb4pWRokVSEJkgNraLKG1k77ewJe2ol653O2+QNufpMViAKRNzFUvv
         UvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749474718; x=1750079518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIDEZTcLMIX8NSBMninMC+pCHmUrBf8fr/oqws99Skw=;
        b=She8Uag3kMfZ65ZrONizJQ+a7/tPcQ8cm4N2TlC0p2wlf54jbbwK/qjWPjt8YJpsbB
         4OXz3qSPa0qauUSFgjAXQ++RJz24z96U+Q1YU0Na4DtV8xQVcMgwpyU1jswJgcXJDvj7
         M5tcEqXjFoXakyKkASa+/7178wwc12Swe6FoSPWulZ1qrv4UCmdH1XqC2CFcvh9GOXDA
         eovtfm4al0VtEVM1Bw99mZJAmlK94C1187HEjFC5ALnAeWYR46rQt9i2tjmaT83ku6Jc
         0VZGC7eP9DEgve7EM+yqRcPjQ7f/DWS80iZEBmFcZbnUdQLExL9pcpoZszZtLayyOe7n
         WxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR0j2+iKeOjpVhYiIla4fG+4Nv6yTI0OIeXr6/rKvtkpZ9azfM32hKXXwMV+dzSsusWJScbQllVlcl0FbAj2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9oIpqaXnxfh0x1GzPIBBYIJjIiXPJmUwWgP+9t1sicf8wRbm
	jbh4TIJQ0f/SMppQGRTk33cWHU+km7PQMsUnruGnXEztDPYPX6NZF2BvVNxQM1r6u8g=
X-Gm-Gg: ASbGncvc/h5sSTnYmO6a67llPbTE+cvsEZIaoITZFW2paykQxnS05Z6IYJefjQSfOeI
	igpJ3NDiG9dOMT5cecEgf/lRvGxX8UbWqPCclL/6FjcpOIx51/RurAJENu7rhFMVTaooIItn0Li
	nFkcA5hoJy1ilwaioDBFnVOXgQnVUjmYN3hVUjyRWpimV6kx3T69RmTYvxJLvWoPATnEflaCIrN
	IyfbdysJ/Mq9BpagjEITMNHK13aJXRUcT17zXJPIXh5qPQV351RRIMJp/B4+XHpdLKkxcWCVQW5
	w3U5zg4k1EtM8BIRHBMfp5Aa3QKQD2gPFApvJkv1H47AGAIXFpQXZtz5Q7nG4zpi3/pcHsCrLXK
	zNPmdZc/3f7cp2vANeq2sLrifbrtBZeq/jgHpzGulX+3vmJILkJ2ohuw2LoMQ
X-Google-Smtp-Source: AGHT+IGcP9WDP2sOnDqdsr1hUuGAfaqNH9xtyLz55f2uKfpJWh0O5VielrBpshkl/5AnNTfQlngdEg==
X-Received: by 2002:a05:6000:2dc9:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a531ce16b6mr9212551f8f.42.1749474718219;
        Mon, 09 Jun 2025 06:11:58 -0700 (PDT)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323c0819sm9396058f8f.45.2025.06.09.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 06:11:57 -0700 (PDT)
From: Terry Tritton <terry.tritton@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wei Gao <wegao@suse.com>
Cc: ttritton@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH] selftests/futex: Convert 32bit timespec struct to 64bit version for 32bit compatibility mode
Date: Mon,  9 Jun 2025 14:10:55 +0100
Message-Id: <20250609131055.84547-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Futex_waitv can not accept old_timespec32 struct, so userspace should
convert it from 32bit to 64bit before syscall in 32bit compatible mode.

This fix is based off [1] 

Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
Signed-off-by: Wei Gao <wegao@suse.com>
---

The original patch is for an identically named file and function in ltp
and we need the same fix in kselftest. The patch is near identical with
only a slight change to `syscall` instead of `tst_syscall`.

Is the way I have tagged this appropriate?


 .../testing/selftests/futex/include/futex2test.h  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index ea79662405bc..6780e51eb2d6 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -55,6 +55,13 @@ struct futex32_numa {
 	futex_t numa;
 };
 
+#if !defined(__LP64__)
+struct timespec64 {
+	int64_t tv_sec;
+	int64_t tv_nsec;
+};
+#endif
+
 /**
  * futex_waitv - Wait at multiple futexes, wake on any
  * @waiters:    Array of waiters
@@ -65,7 +72,15 @@ struct futex32_numa {
 static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
 			      unsigned long flags, struct timespec *timo, clockid_t clockid)
 {
+#if !defined(__LP64__)
+	struct timespec64 timo64 = {0};
+
+	timo64.tv_sec = timo->tv_sec;
+	timo64.tv_nsec = timo->tv_nsec;
+	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &timo64, clockid);
+#else
 	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+#endif
 }
 
 /*
-- 
2.39.5


