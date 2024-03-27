Return-Path: <linux-kselftest+bounces-6702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B257688DC0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 12:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D271C21FDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C3535A0;
	Wed, 27 Mar 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZM5fosM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC65576E;
	Wed, 27 Mar 2024 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537614; cv=none; b=pj8xDfMO2FtTiFXyevc5xFL+95QKK0HDZBtM7sy6rulIq0HqpNwYMhtlDc4djWhU3Mkz9eaot8+X6uuthgT3sVEGf0g/x5NMkfEiWkYjmKv4/RKfM8waIaiyigiGpX7/YnRBRtPCfhkmGtUS714OhuOeiuTaGtsYGv73/Cis4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537614; c=relaxed/simple;
	bh=H2svPUGEGfGthyz48UemkX8Im5kzGBnvGnjpVVS/7Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WMPySYqA3s+5QutO4+KwqNu9vk2CCqaOcPtE3smusp/59WLdTU41uWdehbuzO3/FvSORNnBq9fvcD31ndUMiF1Izag6IDu6+c0IWhduC31lNQXT/aVpex7es48RP/o0VcFL7Tu7vZoUIMIQlitQlpcUdT5nEeh6zovEUrTUeZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZM5fosM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ed6078884so410612f8f.1;
        Wed, 27 Mar 2024 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711537611; x=1712142411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JqPOcmUdthOBx+IbALRLQGxssaRzJRGfoQO1pZxEPU0=;
        b=DZM5fosMQsRH52eqya5VvPgm+BK87EwPtWqbrqwAijB/HYo7dWYAJJpPsb61ZKcOUI
         9G43UQtJans2Mrit9+lqOzwGlXWf396sTj/NbR3EDNf59R8f8eHL2GthXRiCdUtaOWHS
         GXIdQBew42usJdEjY/6wxO4eY4bSkUbRULmXrGIprnNuHMbmdv34MRxBDD1z7ZrmakZY
         cEvfJRwTlfDV6E7tj8IgFALp/rPR+gTCAUSOZblQ6kPgnrPntdF0ui2y6B27UefzmZD7
         gsvc/w7gbTch47HpeNEJ/qDANL/EWeSbNFurdybYxkCQNeLVWV8FMo/lRpcJfFbB4oMI
         iSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537611; x=1712142411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqPOcmUdthOBx+IbALRLQGxssaRzJRGfoQO1pZxEPU0=;
        b=avW0TzS818nweJjU1+CbTWxSxw0Ww22MVEeEzuGUhGl5Sft4yZW6HwaqTL4juz52CO
         3dPJOvBYVIHnotg4OmECLL+mbjZ8lKMUk27TTFJhKsQPZGqu0FX6+2+ogAPajaqS3zr+
         OARk3eeYm7S1RSfF8gyKLqi0hQSMfv/AkSZwxt9ucOLto3isrOG963LPFvt5381M/fYE
         hgAOpumEQrIGQHVlqTcyKvdMKqNSmZ0a0mLnSzvTtVpoGaU4ZDrAO+OhRnLGJVicpohb
         Y/N2VBdQHbGUVk/Vpw0KiJN8ZAJ4De1x368XCJ+679J7+P8EBfw+JnoQda0ZQfNtH6i6
         Th5A==
X-Forwarded-Encrypted: i=1; AJvYcCVhgFNrIjhXWDC3yhRkWCVecxVyIgZIb2x6QLGyP6cy6h9UxZ29ebT2UGdCTJ90Aqylpqk0c70+ref2oyi+leMVyZIo5HDAgBwFBbQKnKlDvEwamx9cmUzUERBgFEV+T6IkvjN6VLmTx68r141C
X-Gm-Message-State: AOJu0YxdRW2pW0ZnURG5GmbEcnyEBMj9mWG0H13U5mIBB0/++2BT9Jtp
	Wb43qCFbKtAD5hjZ2AdxpnKcCmIMAi5DqA0bZ7N1oNfnRjUg44CJgcB3WrNJoJs=
X-Google-Smtp-Source: AGHT+IFhmjHs/TSboDC2XUnvVSUZLq+c7Fo+e8BbugrAq+g8gcnimL8bSUHkRVT8c7afcnf/+Yig+A==
X-Received: by 2002:adf:dd89:0:b0:33e:d16c:4e1 with SMTP id x9-20020adfdd89000000b0033ed16c04e1mr3764814wrl.22.1711537610961;
        Wed, 27 Mar 2024 04:06:50 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id ez19-20020a056000251300b00341c88ab493sm9674003wrb.10.2024.03.27.04.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 04:06:50 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Kyle Huey <me@kylehuey.com>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/perf_events: Fix spelling mistake "sycnhronize" -> "synchronize"
Date: Wed, 27 Mar 2024 11:06:49 +0000
Message-Id: <20240327110649.283925-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/perf_events/watermark_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index 49dc1e831174..e03fe1b9bba2 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -75,7 +75,7 @@ TEST(watermark_signal)
 	if (waitpid(child, &child_status, WSTOPPED) != child ||
 	    !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) == SIGSTOP)) {
 		fprintf(stderr,
-			"failed to sycnhronize with child errno=%d status=%x\n",
+			"failed to synchronize with child errno=%d status=%x\n",
 			errno,
 			child_status);
 		goto cleanup;
-- 
2.39.2


