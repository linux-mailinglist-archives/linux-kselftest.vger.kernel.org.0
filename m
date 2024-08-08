Return-Path: <linux-kselftest+bounces-15042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104BC94C4AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414D71C25012
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 18:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31515E5AB;
	Thu,  8 Aug 2024 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZH4kkf7I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AC148308
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Aug 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142506; cv=none; b=YmosyMDChA6WCCBn16PFT3TwPVKsesv2LF4hbQBTnWeC3VMceVdfk58nWIFiM2BsbCmptnA++hYhC4uIBEtfLF/qRfHMeOx08nCSeUC3bU0orcjXl1Ly4+UHRYST+29Sz1eSTfPGxLU1BCSk3kZBgJdRaz3sFK1mSdG3289FIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142506; c=relaxed/simple;
	bh=oKVmgxAvtU08k7fXc2KY7/+qmgzTvGzLzIGlMP6cVUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QoO2AziHmqGIbF8S+GLDRYnAi2ozmsLD5QZa5P5BeHf0XiR2wAPyIY9kvJGHZRUi47BYLe5VwsPujs3jTSf0LF7kNSbpJzglnQDpzWOZXFj43mWBwoQLkrV53h9Aqb9Qr+O/CBbI/ZdNdeKhDoYrLaYBstf0rdNSq98Dalv5qLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZH4kkf7I; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc52394c92so12669195ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2024 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723142503; x=1723747303; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AG7o4n/MhCzESj2P+tLcsOrZ/Z0Rt0fnlAPDLYPYB3U=;
        b=ZH4kkf7I+JOgbKiBVIbC1fJwaNYxsglakqEGdMnXOnVFD22tlzgReiAUFT5P9NKU2E
         Zr7X9eZNiIojQvYFAD8b+H6h6324dRvYD6KeHYUZwGNtdM1fWHG2Ee+cxGcU4vVpSxqf
         f9FXGnzV1J8xqW8SejbY9omem+NYekV81Eym4URtMOdY+dHZmiVsMPCyONA+rhB0PSlA
         +QEUMRA67w0ElUhLcEe1A8iDP6VBiWkCFkQ4/rIfqKAPy8wybJ4QRP3R7lTShkyem6vQ
         JafbhILHYD2TDWFCKx14gdg9yvEWwVRgMHmomYY9pE6cTKgSLx6nrswD6YKXoPEJ+NpK
         b4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723142503; x=1723747303;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AG7o4n/MhCzESj2P+tLcsOrZ/Z0Rt0fnlAPDLYPYB3U=;
        b=mlZTzdxHjGX6iX72Dlq4TYFimvZHGB1JqofILuvn3/MWX5sB5mnSmaUqFCG4tNh5Iz
         T+zQ2uZAIui4CqrUH9wyW8+8xATPEv8lkUwQa7Kg7bA1cXJo62cZCkQDuguz64ALzhxY
         2PhqbBBk+SiBxsZjGGlymRGCriVrMJze9JvaRrokQ78JAgSAYAzb+Y2xlj4nLTm4ViXb
         nVUWUuA9u1KDFa2rpO4r7DzPsR73SmHgPSFonxu0glqGyUFohfPNafCZDCL8OaI3/Ure
         amBZSryOSVCcSoyzQQMhUk5N66gH7JMyzyCM/C9kc1IpRHfcYYkjLfPCmwrL+u0fBLQn
         ylKA==
X-Gm-Message-State: AOJu0YxQnZtIldpTbsYlKSkcJFwQZigKkwQLOGGdrA9bEIx+KLFYTHeV
	yW3xu4FTGts3f9FB2dCcvGqh1cIHr7CtfQ+V2K9QX9QhJFYbLvHB/G+xAbCehpFyYChaQZAgpja
	r
X-Google-Smtp-Source: AGHT+IHFYMrAf47hOMo+LBIFpOsA7X9Xf8/oax6Ra582HTcJd8AWpBMyQAjoYdlXCRtGRDVUHetLpw==
X-Received: by 2002:a17:902:d2c9:b0:1ff:39d4:1663 with SMTP id d9443c01a7336-200952ee879mr29883515ad.47.1723142502941;
        Thu, 08 Aug 2024 11:41:42 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5917a5f4sm127727315ad.211.2024.08.08.11.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:41:42 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 08 Aug 2024 11:41:40 -0700
Subject: [PATCH] selftests: riscv: Allow mmap test to compile on 32-bit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-mmap_tests__fixes-v1-1-b1344b642a84@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAGMRtWYC/x3LTQqAIBBA4avIrBNU+qOrRIjZVLPIxJEIorsnL
 T8e7wHGRMgwiAcSXsR0hgJdCfC7CxtKWorBKFOrXnXyOFy0GTmztSvdyLJttPdmblZ0C5QvJvx
 D2cbpfT9q1ny8YwAAAA==
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723142501; l=1481;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=oKVmgxAvtU08k7fXc2KY7/+qmgzTvGzLzIGlMP6cVUk=;
 b=FmFtK2qNAbnd0xcmjgZmgnNzTYYku7+c+IaE3mPTuKuwXBke5hIVWtsIfv89fURYD0pWwYHZC
 C/MJNLRhjn3CFJCPGLgLbHPFhh+EX7+3lgdYy2PP4qGzMKpoA+Hhwvl
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Macros needed for 32-bit compilations were hidden behind 64-bit riscv
ifdefs. Fix the 32-bit compilations by moving macros to allow the
memory_layout test to run on 32-bit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 73d05262a2ca ("selftests: riscv: Generalize mm selftests")
---
 tools/testing/selftests/riscv/mm/mmap_test.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 3b29ca3bb3d4..1c3313c201d5 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -48,11 +48,11 @@ uint32_t random_addresses[] = {
 };
 #endif
 
-// Only works on 64 bit
-#if __riscv_xlen == 64
 #define PROT (PROT_READ | PROT_WRITE)
 #define FLAGS (MAP_PRIVATE | MAP_ANONYMOUS)
 
+// Only works on 64 bit
+#if __riscv_xlen == 64
 /* mmap must return a value that doesn't use more bits than the hint address. */
 static inline unsigned long get_max_value(unsigned long input)
 {
@@ -80,6 +80,8 @@ static inline unsigned long get_max_value(unsigned long input)
 	})
 #endif /* __riscv_xlen == 64 */
 
+#define TEST_MMAPS do { } while (0)
+
 static inline int memory_layout(void)
 {
 	void *value1 = mmap(NULL, sizeof(int), PROT, FLAGS, 0, 0);

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240807-mmap_tests__fixes-651cc2b5fead
-- 
- Charlie


