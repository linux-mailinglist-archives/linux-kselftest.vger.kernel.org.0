Return-Path: <linux-kselftest+bounces-36540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68387AF90BE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CC15450BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ED129344F;
	Fri,  4 Jul 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6DbDp1Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292E1F03D9
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625372; cv=none; b=c+wC+C4UdlWfdEHwavDcN+D1wkfdM64RIjpEc+q97D0tyVW5hQyhBqx7M0FLl4U4UTS8jSaNX7r0qF8zyv2SHdilR6LMDO8F+qrLUEi61PERKPZGxedmY3A1HoAVbFRkupV6uZFWz+nWOsjovCF/Nm80LUb4rpFre9DRQgjHUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625372; c=relaxed/simple;
	bh=EnclmXkL768RUK6FtMDP3RouWSylSMfpyZ2BrslR6ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DSW5ELJkooZYCtCcyOTk0wM4OI/Ecv9r5oVA2s9DMmpK6IGiCeNWrhDF6U+deDHsC/ABfrfV+tVImeUSTD48Pd7yZEXwnDFaB1bl80nbp+lqYSmTBEfBtt4INncrpNGTh/akWiauHYn2G3VhXZHVo2o+HotXikfAs3fYznchu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h6DbDp1Z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so472580f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jul 2025 03:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751625368; x=1752230168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AvqIU51AijbgIqnlAisdCOd3NWaWWsYi/xrBZ7oaVpc=;
        b=h6DbDp1ZZw1LiQZQ/cOJb3c05ApKB71VkZpcyGeAAPfdTkA/ZVDNIvMDB1nxGfSZY7
         h8XKEXfamrkJkM23UlSWv4K7dnERFjK7UNGyC9HGpwjQJrUM9GO9gpMYDfAnpfiKostr
         WcZtPtZaJ1srkqI/rqDjzORAmj912hglvdw2h8GtoJnFZwu1hz9yB/ZqRU/jGR/vgZcl
         TWdKTxLDbods3Fb7jheqsv3ftJAL499GMMPKAWuvD4ZKbbttbeZHslJkxhevm5jklSbf
         Scq/QFXfz5PlrRTGlUVdayKaJELrVCjPWHi6J9xsMUJDzZdauhqhAq76LjQUUd5QOcVO
         wg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751625368; x=1752230168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvqIU51AijbgIqnlAisdCOd3NWaWWsYi/xrBZ7oaVpc=;
        b=SgaNay5/csykAXJGsr8NDM03QC6xdUquADi6Eo+/SI+TUNJPAo25HeGgZqLrO1QEkT
         wvxZj5+Tg6IUhfzwHD1DCfwWLs0BMyS7tiK/uc3H7s7B69EXOl0Etk8KESXcSipwuxSo
         fumXr9gfMfHjE+j/Nvdg7iNEMDETzY67VOlsLSWLclPYvHSwCJPjiJOGWAp2Vu1h9m+L
         osmjepdRC8xWsM58DGStD8B+tkUV7rzLxpg59XbjI7GXTNYiaUn+j9QVN3jTe3ZVXgR4
         5FhiXVF9/3Fh5WLD2boeHZFF6xgxBpMW+cuaOwd0ADWLJ5QhOAFeM3CW3CVbUBu4uexp
         Q7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVKqxSegxsWmjBioMUnZLcUVLnVsdNVKc7jVuzgpBCmyFopHH+V6ps9Z23QI+WrHSWFE6XRZkF1x2URDlEY+CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwukaenIa9sSHUlCvgfaNL3ygu/bz4HWh86mK2RtKBUXs7uXl+c
	72l0/7lnwsqT1+OHLQ7e1j+E5FOVmcP2dtz0bOTRZSB12LqCRP84OS3XZnc5osowaCQ=
X-Gm-Gg: ASbGncsdV8X5R+P6/3UGGjGZJl1FeLQKkBinoLszFyy+eBjAs5AiKCBegWABqI4H7/J
	7idO9PQsnCJJEEGt9TcuqK/r/eLUi5f24bVU7cKLZ+LyrMIcrmPKjt9ofpTTtu5pCQlxE/3QBIV
	eploUGMq4gg/HqW4rUuTAGhZGuTyqq6lfosnK753nl952RULrzTsuU0dM6woqd9bcvmUXvWD+Lc
	NUXr6Gmx+UhaGBV30E0d5eKu8wfuhR+J90U/UXd5Z+nwrMvALp9dy8brvlrkGPnLw5AaqmZzGEJ
	I8AWACv1q9iyXE+wE+FZOTv4llJ/igOPw/p6RWWsUFyT57a0ZzHmibU0oJ9aKLKPNcERb/8mFO3
	a+7CzSedWGoS+0cYm2PKLSq2ANDWNjPin790Nt0wN/rrSNs+S8zh2Ui3V2nAurY5zOs6UO/A=
X-Google-Smtp-Source: AGHT+IHqfnStUll8QsR7mUsfnCLVHXTMrhweBdMDH1RvSFMNP1qReYTg59lxizhSyMSXkL25MsJ0UA==
X-Received: by 2002:a05:6000:4a04:b0:3a5:2b75:56cc with SMTP id ffacd0b85a97d-3b4964c5d3emr1434996f8f.23.1751625368383;
        Fri, 04 Jul 2025 03:36:08 -0700 (PDT)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d099esm2131581f8f.21.2025.07.04.03.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 03:36:07 -0700 (PDT)
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
Subject: [PATCH v4] selftests/futex: Convert 32bit timespec struct to 64bit version for 32bit compatibility mode
Date: Fri,  4 Jul 2025 11:35:21 +0100
Message-Id: <20250704103521.10124-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sys_futex_wait() can not accept old_timespec32 struct, so userspace should
convert it from 32bit to 64bit before syscall to support 32bit compatible mode.

This fix is based off [1]

Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]

Originally-by: Wei Gao <wegao@suse.com>
Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
Changes in v4:
- Change to use __kernel_timespec as suggested by tglx

Changes in v3:
- Fix signed-off-by chain but for real this time

Changes in v2:
- Fix signed-off-by chain

 tools/testing/selftests/futex/include/futex2test.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index ea79662405bc..af5b92ba04ad 100644
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
+        struct __kernel_timespec ts = { 
+                .tv_sec = timo->tv_sec, 
+                .tv_nsec = timo->tv_nsec, 
+        }; 
+ 
+        return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts, clockid);
 }
 
 /*
-- 
2.39.5


