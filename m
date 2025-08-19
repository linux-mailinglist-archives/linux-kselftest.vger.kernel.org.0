Return-Path: <linux-kselftest+bounces-39275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94834B2B75F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 05:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 620F34E157D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 03:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3143A1B423B;
	Tue, 19 Aug 2025 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEmhtA/a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDDE56A
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572487; cv=none; b=DVE1I2hNIBn0PBPt2nULrCvMbtiYJ5TQdP7RxPZTnbT0fSoBesFy+FwYpDL3Afvh2i4BoFzhEXr6tKE+BRwOYnv7u++iueMpqY5sZUSPUx9TiDmEMQVdiLrYqyRm/fckqvWoPVzz8icX9SVz+Tlmfe3VJyw2c+So9tics2r6DUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572487; c=relaxed/simple;
	bh=LIUlD0bOhl9LKp+DEmmBizXl3Wwv9AcVYNU8bGnJHI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wqw4Ori/eAzN9bLWOBS0LJkzCUrkzgAvFQXkp1cMPLxwdqD+8QqlSLmeaZZY7m9bVs6AhNFhgbW0PQe+lWDmg8YK8gEtptx0rALEtVYUM249mg/F7WezjdopYKw+zoB6zfSzPU0bf/CpijjcdnpuqBJ6GSF9uEhJEYktCynmQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEmhtA/a; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so2996599b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 20:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755572485; x=1756177285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJI3ZAK11NgguXE2fOYjbQz/OCmgh5JmGWFmHEPsM9M=;
        b=kEmhtA/ayrVkD1nJjRh/pQqRYmni1SkE1lgdGb4nlDIn6rjRLlp4kTr8KSdhcmVjkQ
         epTKQYtWqPTpOFEfT/p1e0x7NI6N6rTHAcXiI2HAwE1cHCyf4V7vKUF2XWRL7BlmMQeq
         iieTEenvg2T0NUMC2V4cggnwn8SBNigXHCAvYgim2otXV6hzBMOQ2zznERjsEPZR2l0p
         3vWKeEcFXH1Mpdm0XCE1x+RJRroU3pLgmVHxn5D56b3TaajR96FgyBkET+psnGWJPjFO
         vc2L/is8y8XZ7JlqchV0Ei8JVmSqo8ZG39XrtyIGnYqn3xTnIddqEnYhPZneaAjsrvg9
         b35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755572485; x=1756177285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJI3ZAK11NgguXE2fOYjbQz/OCmgh5JmGWFmHEPsM9M=;
        b=uDPQ/FD2khDLakBc9Nztapq0TrKSjBgeyjxbYyO4lhRH4Yy1/7WF4zXLP49Zszv5C+
         564Qm3ipNSUxqoykXUaJ/EHyfwvIiP4PrJMp5qFbztVDuwf6noXkQDwWs/zOLe6yH9OX
         eDSeIPbDRMOYDcP919OEgRNgy5EpEG/PhCGo2Vw8K0mDxZp5JpLIpec7smuztHgUr8rz
         nidjk1yXBYim2V78VCyvjM2ALMoB4RT//SG9jJtltui95kRo8Ns23hCPqyf88Q/iP6hG
         OdkkgDkJuG5LO174i5rOImsnQiBDG8oi58sPgmkPkL070x57MTdyJSZX6oszI9CphMx9
         mA7A==
X-Gm-Message-State: AOJu0Yxd+t4YNa/WX6FzSadsEIauq+tnReMVidSLoqTy+BNWv41DuDZn
	ujD5D9Ud6ZhIlEhEc1sONZaOjFFIWSI6/PDbo7oQU03tP2+ID/UX1cW0N6JwSkIYsGv2DDlr
X-Gm-Gg: ASbGnct4ljHhhiLvqO7yvgMCSzCZ/dRzpNtzBX8a9q6HTrCD9qvmGwWcav6d7mE/2sP
	5hMMthWNjpFTvFJC3P+CyBVu7GqD2ZWBzVojKvsji6efX+fCrfFIIpn7I2SB6l5P0bnTbpXdMD+
	jTWq9WveO4ZlL5UOOUj/rTi4R9l38fTCzajLlqttqwY6T+MdXGhueALcy4YTnDOxmp9Zxjt5UOe
	Pu86RTrK3Qc9n3jX8MYAZse7qMsjIZ50xvxNcgdKcojZ+O8WoTmKE9HG2GJ2FeqLcsvN1yfdTwQ
	g4/MSgM91WNFp7sjCcImXsDafQU9ofSu4ptnmWWToe3LSr2eBxmeQNC4awW/G07akFolgd1NKTS
	Uf2jkjUsx5Tz5hO2OgE3AHFf7tnGvZArVfipQv8tInO5ZxGUkA2k=
X-Google-Smtp-Source: AGHT+IGLpgy5TvyasZFI/Vtx4TN6UNximlO3d90vg7k7nAu1nnDWi5zDUi8y2Lx8PkZXhWjYVJxK+A==
X-Received: by 2002:a05:6a21:6d81:b0:23d:9cca:e710 with SMTP id adf61e73a8af0-2430d492bd2mr1133064637.44.1755572484615;
        Mon, 18 Aug 2025 20:01:24 -0700 (PDT)
Received: from localhost ([192.19.38.250])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e7d0d3990sm1021214b3a.10.2025.08.18.20.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 20:01:23 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	jhubbard@nvidia.com,
	amir73il@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Xing Guo <higuoxing@gmail.com>
Subject: [PATCH] selftests/fs/mount-notify: Fix typo memebers -> members
Date: Tue, 19 Aug 2025 11:01:12 +0800
Message-ID: <20250819030112.1136441-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I reviewed these 2 tests and found there's a typo.

Signed-off-by: Xing Guo <higuoxing@gmail.com>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c      | 2 +-
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 63ce708d93ed..18147594d619 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -208,7 +208,7 @@ static void verify_mount_ids(struct __test_metadata *const _metadata,
 			}
 		}
 	}
-	// Check that all list1 memebers can be found in list2. Together with
+	// Check that all list1 members can be found in list2. Together with
 	// the above it means that the list1 and list2 represent the same sets.
 	for (i = 0; i < num; i++) {
 		for (j = 0; j < num; j++) {
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 090a5ca65004..67c05bbc5e45 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -236,7 +236,7 @@ static void verify_mount_ids(struct __test_metadata *const _metadata,
 			}
 		}
 	}
-	// Check that all list1 memebers can be found in list2. Together with
+	// Check that all list1 members can be found in list2. Together with
 	// the above it means that the list1 and list2 represent the same sets.
 	for (i = 0; i < num; i++) {
 		for (j = 0; j < num; j++) {
-- 
2.50.1


