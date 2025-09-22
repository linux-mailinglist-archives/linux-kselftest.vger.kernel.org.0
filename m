Return-Path: <linux-kselftest+bounces-42067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19048B91118
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 14:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87473A6ADA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617C305E3A;
	Mon, 22 Sep 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWcLntuG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4062EDD50
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543023; cv=none; b=shQS9gOEez422AoYAuBFpNvRiCzc76gZ+wiAfxXCN+p8wimps1VuTASQFWiNQ7iWAv4kjvXdosQy9+OMts8emjQSouFU9qbC0bBLxQGHPD5kAN/drcm0iZ4EiFa+KI2PexGwDdd1RrHvx2SDAoUGU+8iJf3mujPqPr4FOTK2clM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543023; c=relaxed/simple;
	bh=D/clnD1hIlVnSt9RwqpAPzOANdJ2p5vqoO7F4SHQKHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oC6GsYSPxhhxmANqCBeH7Y+O/JBHyO29G270+XlS9rzt0zU5VIU7vpTXxe85a30sCmKFCCigLdcqeiZ3O/NtCuSCdZX3fBKdIPs8TRnRwgJI64qrjc7XNtxrmgT9L52PdCbaIAtbvEJT/Dr7wJZ7MMT9PiTUNAUpBuwQIcKBlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWcLntuG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-468973c184bso15336695e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758543020; x=1759147820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71jw5Qy/VkNLzHuH4x3iqTkdWQrjxtig66ummONYtOM=;
        b=MWcLntuGxb2GSltYe7nmE8qf/7WZA0gETFKw5/s3LjGLiRx8JM5pAHaM02mbQYl3XG
         1SW6cGtsLhpDL5D/1lUbf8aEv7hxYvo4H7OY3mJMx9TuSAGj7cYzrKdCP94GDLY0hsYd
         Kx/pVKFVVTZADei1ewDy7QxmN1pXJIGbOp7kjsW1ZdnhF8iE/gWijVcYluG3+DKDISwT
         KKSXZ13Qa67Rt8b/qM/5WSJyklaPMhgvNgYUaAbhbSlGzQFVs21JG0c3a/R7cRg99d1v
         /mSiKRzki5VIC6uIKbr328WP4PjOVxkBDSz99ACpvCYs5jTKvK9gC+Vrb/wU7KXPZj5h
         OXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758543020; x=1759147820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71jw5Qy/VkNLzHuH4x3iqTkdWQrjxtig66ummONYtOM=;
        b=cupCew31M2jxKTLmJu8sp3fJX9GIeuE+KQWWI1r0ENyspc26ON51iFTKxT9K+RqXks
         1iNf+KERjIqB9iv/8Sp7Ky91xQpx5bSj7gmnAxqh+kuQuwcQ4+udz0UHH8s74wuhDtoS
         p+CEHi5bsQb1tsG43uwoYhglKVKb6AUE0itQuxDFAlWe9VJtOq2rOlD+1loWda38XIgq
         yvGdghAivrvQkvvKSf8velIFL/vGO3aWGlqn0IY8uFXKu/PBckoM+Y1ZywMaNEZQf21z
         HgheGSwj4lspRPNXCSTa2rYhFZT+BpDOmoeb06Elu74DFd1pwj5Qnab4btN5Ouh0a+By
         3g4g==
X-Forwarded-Encrypted: i=1; AJvYcCW9MKoq4K+FZ3/i7l/qwxsGy/Ts4fJEB5hzPQN7vHv36ynJuUxP4hFxWA/87Kv4e8OLbaF+nmcZwBopc6y+AB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxiMAHp1A8n2pbE9+0gsistkVF9Rv164jaX+pq/DjMOVYMysC
	2Qqkxim4nL0+3kXhprC1/obc2PnnFPegwQvWifTY6QWpGN2VsdkoJfh+
X-Gm-Gg: ASbGncuOzY3O4QeBPGritWdATJBPs87IJ4AgIalDGHSUb/rA7G4h53YoGmP4921Y+qN
	elM6/fka0gFFq5yGrlRQe3yf+aeD9ZDDMmDIzBkfqbAOea+QleMZ88CuGtw1o9Djs8cuZzV+fIL
	wMdFbmMCAZwaoSo2XzQN/hBugGT+ms6aHVSBLRew/pwHCIvl/AQ/xUL+9avM+VPLQOMu58oJi3H
	rXCU4VQDzDFiFDCOxFzxQdHbBogMo1Ouj9LfQw3XZIOcbE/AiSOzrFQeMwr4UxHDkdyUrppz3RG
	5WSYcBQmJjPq7p3uYZI34wEHRBQSV7DnX/s2z1meOeqQTk4ghSWBiGlHazm1MXVPIm8T//BRTlc
	Gf+1THOV5dFtWLhg63XeO2w==
X-Google-Smtp-Source: AGHT+IGHW9CPoYUliHRmOI9QW83IwXhzxlqJRF4i5x3vsGF8rbB4SFo9J0Y/nPh3bivEr5ReaiyMtA==
X-Received: by 2002:a05:600c:468a:b0:45d:e326:96e7 with SMTP id 5b1f17b1804b1-467eaa86e42mr112243105e9.29.1758543020076;
        Mon, 22 Sep 2025 05:10:20 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f32141ae9sm131846735e9.5.2025.09.22.05.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:10:19 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH][next] selftests/clone3: Fix spelling mistake "supportd" -> "supported"
Date: Mon, 22 Sep 2025 13:09:30 +0100
Message-ID: <20250922120931.56786-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ksft_print_msg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/clone3/clone3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 05c3d2dcbf2a..385cf08f8cf8 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -71,7 +71,7 @@ static void test_shadow_stack_supported(void)
 	} else if ((void *)ret == MAP_FAILED) {
 		ksft_print_msg("Failed to map shadow stack\n");
 	} else {
-		ksft_print_msg("Shadow stack supportd\n");
+		ksft_print_msg("Shadow stack supported\n");
 		shadow_stack_supported = true;
 
 		if (!shadow_stack_enabled)
-- 
2.51.0


