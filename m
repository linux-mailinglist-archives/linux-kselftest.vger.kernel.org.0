Return-Path: <linux-kselftest+bounces-39797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628BB32B30
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 19:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2545EAC0136
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DDF1E1E12;
	Sat, 23 Aug 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXo8Ft7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEF3234;
	Sat, 23 Aug 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755968538; cv=none; b=uCjDCcZtUH2FVWofNOjhpqgaz6MYfVzs8SN7re1ilHFs4SlMy346Pqs+N6xdTLUOXlOyoEj7ltSHzbMaJPEwy7pC7wjEJKyV4Y4Po9jmremWETArp/GVkLFzo11RxzpUn1HlnKyde1JTRApV49Pf6IF5eKafHllHj5m/1Ewn3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755968538; c=relaxed/simple;
	bh=rLmYaUXKiJXYAlYBGXGFMvCWXOPdKhCoO6aZASFlBk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fsf3cf+VLc6ehUzFuEsj/V5245IXY+q3wfQLfuU/vncIZ4nsdVEfwdyqx5ApYgFBj4TGMujOHnESjMOBb6E75Psjl9n5puR7RYxsffhgTM2vncxgebBJHMLjU1TNYrbpQ6O13ZTUqTjj1glZd4KfdtduSpGlOKpmPoLER+Z78TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXo8Ft7o; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24664469fd9so9149515ad.2;
        Sat, 23 Aug 2025 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755968536; x=1756573336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hk+p5ghEzTAvQDShLGqOKKNyxsexSgFKL80k6vJGfUg=;
        b=GXo8Ft7oSetMYqAdBKlWW9vOSiR57Iwq93wdjvsmv9zi2vZlDuJIJBzU697HI5Mg+L
         a0a4aSCtOEb/hjSrU+mp3qamW3gE5wlvoArfR23O6UHU2tYLHx2kMdTr4tqaszxv4r9a
         khZsTGRHr0Qx9HLuISF8jvtfHOIujhkkrhIiHf79fpUBf6ghDBU1At6Us1TSKyu9Pc/r
         4U1qHg52tS8cRmk7qp8EZcDLw9heGv3O3uaMZmDmlxjXVmUIyPvciAhHU0/tFYNylqmR
         7+CTaUUN2DzfRN67r7pJhXRzHbqAhtXJU0AqRkCsrrPNQtsNJFqw7oPE/LPGMVmCjECz
         K4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755968536; x=1756573336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hk+p5ghEzTAvQDShLGqOKKNyxsexSgFKL80k6vJGfUg=;
        b=dv07/CGio5gCaCwp/9La41EONV/LrNwlG8SUVKd1FpF9bI7Sq8kQNq82SSmDJz6O9E
         kkGxi+jg3eF8G5yZS3i/ndtE4BIGiJ52pMOh97fUYCvW8q6hqUDcM9wtXxg+uNI6SnJ4
         LWF61bD/nWB59ycr3aj4/aderGwMz8ZluGzfQpmpTLeqS4mkwmW6NgtRdZPyzG1cVATg
         I5q9VdkHM6WLmNYPPe/Pm4pd9E08i5QWA5H/+d4MovDxzC3KZ+elsHq0YwkFoq1uE494
         fhBSk/4t0srVn7xnwAbhlrAaOkKZb2D2R3Y9xynfiGsdKEEC+e4aMu91ViWXfVRK6h+L
         0+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUnIq7WtsIAiUEBdOKnmjSmLnl2WAj7QDVVOoq2VCEw4ioXbJqEVQZYh3Rpk94CnIfkSEzpwz9v6CWGDJAWcXMG@vger.kernel.org, AJvYcCUue1CSw926uCTj+86dcge+AlYj2h6sFRZsotOH7fzyv6AKGs3dz5EvL80fqTJl/f2OyCu6rs4jWqfAzls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyahHdSpJv76j5/8b53rKac81IbZ4SqFPeDnM0FIjpMFiBh0JEL
	MBPeTnHNR+eBDqzUuEmotVj10KXBIfA5vhTX5Lg/+OgB8Z6jSdaDPJCl
X-Gm-Gg: ASbGncuqPqb+FRyNNgQoQElAKFIa5QqNO31DpCTo4rrNnIiGBmJghz+r7YqXU70h+1j
	5+x7mpPs2YwkyMI/g8SYMRp6B39Qxlqn5RcdIvv4s7EFsOtCR1u8hCcvNQUeLDqaKBRC9R4kP8X
	8UM36vJrjqMWBgMA8apJwHF3eQVS1SDduuZ8BtfDZlig9sdcXITAXFAxPy138xQG/kexx5HWpAI
	bTOGISrbeSQE5OhIpu8Ul8yeEZKEOEHBiUZ8GwvopioQidJGKFUd9rt7MtM02KzSsl6wb/o4nJG
	KM2YINF1ixtjr3oPAC2uZ4juVEDZcUgtYnHPPSI2ldWYQnCMf2v5bOixHqWWGsXVVXA3otyXVYB
	Mz/1zkRL3KoGgEp1tt3TGXre8ktJVEzPLer67xwOgOrItmWvAHzQhkvSUn+15
X-Google-Smtp-Source: AGHT+IH2ShbvDYkTHBSBnl1YUhuZP8E16J7gyLk2VDXODCN3OD494KKcUR6j+r39w3Xzpc8VsjYNAA==
X-Received: by 2002:a17:902:d486:b0:23f:cd6e:8d0f with SMTP id d9443c01a7336-2462ee1a473mr78779365ad.13.1755968535825;
        Sat, 23 Aug 2025 10:02:15 -0700 (PDT)
Received: from vicky-pop-os.. ([2401:4900:8fcf:2a2b:8899:f1d3:d5cd:752a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2467e3238fasm17808055ad.104.2025.08.23.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 10:02:14 -0700 (PDT)
From: ally heev <allyheev@gmail.com>
To: skhan@linuxfoundation.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org
Cc: ally heev <allyheev@gmail.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest: mm: fix typos in test_vmalloc.sh
Date: Sat, 23 Aug 2025 22:32:08 +0530
Message-Id: <20250823170208.184149-1-allyheev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: ally heev <allyheev@gmail.com>
---
 tools/testing/selftests/mm/test_vmalloc.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/test_vmalloc.sh b/tools/testing/selftests/mm/test_vmalloc.sh
index d73b846736f1..d39096723fca 100755
--- a/tools/testing/selftests/mm/test_vmalloc.sh
+++ b/tools/testing/selftests/mm/test_vmalloc.sh
@@ -47,14 +47,14 @@ check_test_requirements()
 	fi
 }
 
-run_perfformance_check()
+run_performance_check()
 {
 	echo "Run performance tests to evaluate how fast vmalloc allocation is."
 	echo "It runs all test cases on one single CPU with sequential order."
 
 	modprobe $DRIVER $PERF_PARAM > /dev/null 2>&1
 	echo "Done."
-	echo "Ccheck the kernel message buffer to see the summary."
+	echo "Check the kernel message buffer to see the summary."
 }
 
 run_stability_check()
@@ -160,7 +160,7 @@ function run_test()
 		usage
 	else
 		if [[ "$1" = "performance" ]]; then
-			run_perfformance_check
+			run_performance_check
 		elif [[ "$1" = "stress" ]]; then
 			run_stability_check
 		elif [[ "$1" = "smoke" ]]; then
-- 
2.34.1


