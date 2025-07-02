Return-Path: <linux-kselftest+bounces-36297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B33DAF11AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEA5523614
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE06253953;
	Wed,  2 Jul 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYtr3UPI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E8254B18
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451737; cv=none; b=hcWcEfmRFnhs4ncCIZwEN8OaBcS8RKj2RZJNSVt0iZJ0j/h3HMtLTh2h34okFNb3WNYAjJFMtqHFt+C0/B+f1mzedORzlSfcj+aql0L5M9VnR3SbO3YzdQHtWSbdC3uaoJlwMfmVVf4N0P9LvAmUUFw+rwvZDLC+b7UtGvhnYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451737; c=relaxed/simple;
	bh=mkRBaO6sFEsyEwMWNKBmYyY+/tTAEW4N56/rVgdTsGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+jsxnsdsv1luI+1v/ZGlSIaidhYfouIo9YRtU9khWgd/YSk3+8roCT8sqj/a1sg9TXwFivmYulBKjoeCvHT7Hxx85XXtPUYCZfPXO19ksXC+PkGdIrZQxd0+07lfvMYKf3T2xZrxvWF2YgqDQmELTLwGmpI7Kb599cCs2leLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fYtr3UPI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54690d369so4004819f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Jul 2025 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751451733; x=1752056533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J3z7HDKWq14/Rf/7W5PSUqbSzAkGXyN4UWZk2FxpZbs=;
        b=fYtr3UPIysdb4iPSOot3HEGJ2msMf3WvGgojHrnMVa8MO6lcwZQTYrFHxNsi7Wovqf
         zRfQLAjE3R1ChKz0bdWwFrNjE3OYhZGfhUyOzfXmVW1pXJNmgiqVSwitxEvZElaPVnuo
         4i5hSkCQOOnBiPGUH8BtQ8bhGsuDuuhLtSBJVliXXLjCcIampBwuNlpDpgg240yvMA/a
         /TpuVZxey43c85KusVvqWt3yUlW482yMDaiF94VX1rkCWbKrwsLB52WWlzgzfotWpayO
         LnD6bMcS/71APzEFGrzQdH0D4L8gL2f2MBIXPGfMPF5am9vfUZmuML5NL1RZ36+yMz3r
         a2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451733; x=1752056533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3z7HDKWq14/Rf/7W5PSUqbSzAkGXyN4UWZk2FxpZbs=;
        b=ldX+NyfccKHftOMBlclsz+m5ZydW68ETPWr1IEMOH4Ts4Iipc9KR4D0H2mPQd6TyV4
         FQSB+Xz0gNqzak5zCUnSsXWUwrK1hlU/XtcLm9PaKmjSkeeginUMJVdNf8J1yCf+aCWP
         aEycMbIq3sOIcgFBlUMrfX60MVO6iOP4DWSQWZa8ceCc7jxQ3OuMyz1/oXcyA3nEo8Pu
         XGyqi+ohe/C+QRIkSHW26zU+gtMpSQB90Z2NnKL7WMVu/wx30Guod5dZy187Nnwwa5B3
         Lf3VIFo2grRZIFHeroicnPMKs/Wy9cePoCMFs3ef191PwHTKVExvGbjfCp9SUa8clnVR
         Fp6A==
X-Forwarded-Encrypted: i=1; AJvYcCVXELscxkxJSnBBVoG6sTVQacz6f7MgveABFYONEkDQZXgodtoi4eR1jo4PS8h/I1A9j3NSSlF7AzoOr2rcuVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRW8GIWqOPsOcJ9oVFJTP1DufzmgK4nAC0ZrzEDSA35ufsifde
	BDueYNkSuHHCTmwFVpp4Rkp+dYBkrviZe1LlVjJnI7G61hYgXOyp1Uez/xkjsyqysKU=
X-Gm-Gg: ASbGncvTKqXYZKI+3dxhJGXrvymrlqF6PrSNFw87tsHAUaChHxDsa+3fDy9AyaNIJBO
	nP1eEQATs1plGrvT+B7vEYh5uVLbOrOTR9nbjtpq8ietkude1utenSZ/nnK+Y1Ie0ILZai2Y30B
	bn6qxCy7X85uqR69cz+YCh0H4KbOqcZK7RPX1Uz2ZgRUqAMb3Xi5SApKS6EM/QzHl5Bc4jXIe4g
	JgkNpsQeJqmtv41bI7KGjDp3Icc40kF8Yh3G89KWu1IwgJYuV1Rq+mm6SXt55pI52vj2+sqyhU5
	2fEqCN0fkplHQECzhTve4r83BkXKWx7RMSpcWGM8qSI+yE3UG31vFXD5By+Jrq22fsE/yODKH8Y
	sp7CN5Yg6gQOcJREwg7vwJ9DvoABWAh7tIdOqbeInCgBszlf9W4L9uJbEplu9TPykRGXpdIA=
X-Google-Smtp-Source: AGHT+IHtRMzhbL6QsN9H974H+fxsiNS5bFCmumvbhYvPgTdjTPW4usMEO3Wmz4ct4XCnUJJtbPwGYg==
X-Received: by 2002:a05:6000:18ad:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3b201aacd01mr1888649f8f.59.1751451733312;
        Wed, 02 Jul 2025 03:22:13 -0700 (PDT)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5972bsm15840504f8f.68.2025.07.02.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:22:12 -0700 (PDT)
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
Subject: [PATCH v3] selftests/futex: Convert 32bit timespec struct to 64bit version for 32bit compatibility mode
Date: Wed,  2 Jul 2025 11:21:57 +0100
Message-Id: <20250702102157.5222-1-terry.tritton@linaro.org>
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

Originally-by: Wei Gao <wegao@suse.com>
Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
Changes in v3:
- Fix signed-off-by chain but for real this time

Changes in v2:
- Fix signed-off-by chain

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


