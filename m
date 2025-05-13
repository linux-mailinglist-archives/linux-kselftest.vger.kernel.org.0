Return-Path: <linux-kselftest+bounces-32904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D1AB5788
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 16:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745DB4A5267
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AAE1B4132;
	Tue, 13 May 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="VyDMt458"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DCE1A9B40
	for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147716; cv=none; b=i/Y5dIYimL1oUJqalyfzsyLCk3UvgPML3knEjq2x8ufSONEehHtiBCrqetr/hzqTi8UZv6cpK7IZ5T5T99C0sNQvsGtKnYzIGeMGB3Od77tZx7zA5lD36V68moHPB1NBm6ucLLOcNyyBRd1MlXtu4rUr7cHEii+ViyTVGXLbEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147716; c=relaxed/simple;
	bh=YT5xNS4r8xP8EivUfdR7P7lQuV3FIsANyZZmY8R7e5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qm171Gen4ClbSt66r+D6HVF7B5aX3qP8fqb2rKna/yLyR3ODhrWdL+xM4S5g+cSw1iLxZOKBxnoeiwJ2Pz5lDP/6Zs3Op4j807S3w39V7wFoQPBknd1W/Y8r89sEYw/wydccAzoX9Nb3yyjPS4PlmQ4VSP/tWpFThRzIjljYvQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=VyDMt458; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso60811725e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1747147711; x=1747752511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbBexokf21nG+m5XXQimUxHbfdz/gKFEIaDFzU/LUE8=;
        b=VyDMt4586Kiam+CQ+nxINCkTZZ1y3j+vw4Uy31bqP0ddJeGzEj14o3K5OzY3q8F+gc
         0VJZksAzuBEJrm7As4lZmB9t27KnWoA6B0wLObYpSgW0C27MdRVqa/7mXsYcI98N8qeN
         advqiI+XyQ9Fmk7ClxhXC6d84uU9RY6RhiR5aMswaRRuwij6rT8k63OIucuV8njM1uGY
         rINgaTDDDglSkAH0x9sKCg0UhbZA9gGeKxNvY0gMrN75uzBeQXSrg2pFq1geTxtOr8NR
         aMlawg+WgfrREY6gOTc9b70Hfv9tMFJtgWkN76DtLvUA//aQE8okj04Se20dAMJ2GM8c
         LufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147711; x=1747752511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbBexokf21nG+m5XXQimUxHbfdz/gKFEIaDFzU/LUE8=;
        b=DiNbaC1ld3J/BWuSA89SN6/U2wFUTcrfji793c/oQlCTMUNixT7qA/wFKVrWCaKEf7
         5DRoVfUDLcfhVFIdvwihgdo5IvRgjzVY3OL0D3ynGZiw9X2hC6ptWNLDukODbleafNvf
         eGQ/B/mb1xnsLYKgxaDrRisi/dNws7oZwofsyh1XjfXwh2+qwnvY+m9svZhxK8260OdN
         GKERx66b/594VWp40cC1MpMgcKkVoFBanyPnwzf8BRjLwAkU7//3M3liuARNLyHcDQeA
         w35rn9d/yrkhOdjqNW821hqby0xOaf3Gf14Ky7rHjypdmY0ms8KQerZ6FP9MVTgmqhUg
         GMSg==
X-Forwarded-Encrypted: i=1; AJvYcCUQzuzTO3A67en20TaL97mX0Hfv/oDBYcwnuXxJBDCC8zlEOFu6ItWrLbXXog1gEwEHUzHrW/uFDU2GU/yFtt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwmU5GaBdchomiLug2mf/Vx4k6cwTlsIw0j2vsqCoh0Zx+g/T
	ONv/wSzWEPTrVIS111B7o6Uzbc/taRrark9z3f/LnnPNBAo+LvNg9vxBd6patsg=
X-Gm-Gg: ASbGncsmjV+qipfjRYplIIWXD0Gt/sUIzBlECC9s0ilCZpQ8zWiTcVHplFVkHw5+FT6
	Ux6Yy8OlKnLwQ6NQjQGA9TkymPwqdonKLRiRFxBhZv3emMeWS0zHBNPeTzDd5nXy1ub0e7Uk00z
	6dJfuDZnuzlB6NH3Plf7CkqUZv46M2WrNTjUHh3ozzncHbUJ0ut1FDBAwb68jhBBdzOzpZ0LqFc
	5ox/f25MEuFq6mctll3e+yzs3fmtrGD3eNmU1D3oBSsqSpPNH4GuAq0zFJAbg3eFALNO15N+blp
	PWfcDBFsGXIrq1e0coexAmIBIDCXuWQKmsWDO4xLds4V3E2/0OQPFYu22HwfqLm7jOzwEd0wkvL
	q3rfNCJEQsF0qYfiTI+1UvcLOHWOxiA==
X-Google-Smtp-Source: AGHT+IFB3vwfvifBjKb4BRvj9BZyF3VmALZPU5U77ivyr56FeegCa9igR2q57C2VuHPX0hdhYeEJpg==
X-Received: by 2002:a05:600c:6612:b0:442:e147:bea6 with SMTP id 5b1f17b1804b1-442e17571f9mr97496445e9.11.1747147710206;
        Tue, 13 May 2025 07:48:30 -0700 (PDT)
Received: from pop-os.. (178-116-3-140.access.telenet.be. [178.116.3.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c7bsm172837185e9.4.2025.05.13.07.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:48:29 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH] selftests: fix "memebers" typo in filesystems/mount-notify
Date: Tue, 13 May 2025 16:48:16 +0200
Message-ID: <20250513144816.72566-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrects a spelling mistake "memebers" instead of "members" in 
tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c 

Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 59a71f22fb11..af2b61224a61 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -230,7 +230,7 @@ static void verify_mount_ids(struct __test_metadata *const _metadata,
 			}
 		}
 	}
-	// Check that all list1 memebers can be found in list2. Together with
+	// Check that all list1 members can be found in list2. Together with
 	// the above it means that the list1 and list2 represent the same sets.
 	for (i = 0; i < num; i++) {
 		for (j = 0; j < num; j++) {
-- 
2.43.0


