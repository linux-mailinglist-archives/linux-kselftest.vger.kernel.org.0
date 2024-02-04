Return-Path: <linux-kselftest+bounces-4117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6F8848D8C
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 13:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E21D283323
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8067F22085;
	Sun,  4 Feb 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0cphIh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D442232B;
	Sun,  4 Feb 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707049537; cv=none; b=EyvpADD9WDz53XLMo3alsaD0XVbisuEjWqIlTvs1O6IGOJ0k7ENSGfdHPl4f/I4d+fjolOfHXB8L/p2A9dltc7MCVvRAIwWpzSwYShcwRI5QSeV7iK11QiE1XVHlaOTupiqJaqXy220JqNBt5cxevvsGYf4IAz2jXGlJjvCldZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707049537; c=relaxed/simple;
	bh=RcWzXKFZ0BaF1VMpi8ZTE1UoIl+8mFXHKZEXuhP55DE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rbtPj1RJ1tc+PzLLZD2jS0wgA2NH2q50cOBUlOskkCtOOjt1BY8TaKKaQB4uRuy71pvNi2L6HuaVGoR9YN0mRLktwmxausyPmHBaEzPefwDcO6liav9BPVQQMAGXRO0A9NpdtR4JiA4UbmsTiZ54YQiXIlRTIrK3LVpJNhis4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0cphIh9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so422626e87.0;
        Sun, 04 Feb 2024 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707049534; x=1707654334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BplI6VCWBZIVYNNfj0tYYl9gPuq2mTVb9lKtjAlMeVM=;
        b=Q0cphIh94LLKKCZENBGXvFI47O9WkyTiLHc4e7OgCodESI8hHrgZKZlsR4nx8vz2ct
         FQSRyi99cnDBObdbASmAbr31u2w4K8oTTKNf/e6q+AG9MliMRaerow7jFVjEkWLwUlpW
         iioQpPkgms/BlrN4fvIxkxCeZNKlxdpSaQ8Mo4JgPi4XS0+Nx+9rziCfFCSu5Z/uCr8x
         RyuS4Z0zJWKDPXzMFApBLG9FZGiiQRnnVtQ6grkrjsgq17zD/ekpTgfzzCx2X4am/v1u
         7OrWzd5PxtMdTCfkXPpNpvxHyMMzICGvqOxFBTTItTTvh/x7/Qb35gZB2hGkVzAPfeil
         VUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707049534; x=1707654334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BplI6VCWBZIVYNNfj0tYYl9gPuq2mTVb9lKtjAlMeVM=;
        b=CCTuvJ53the/UXHnnMZpOo/laFuGil+LWaDeCxJ/V+eXoTrIZS2tp1RuJZqO79Yz+1
         F52mJdWvLhEj5PuTSG2ZiWFgpE63CPyve3v/uiPZv924uBJoz6m0gj3Hn15bK7tWJbn8
         P3CKpCCLv/g3fDWDH6R1jQlEoYM2jKldDjGIheNiH3i8E8gVTmdNGp3qzOODj7blTalU
         WQcNSNl/QE0C2ln0YSXe9fU7pI++0NP0TPg94gWw7ljNG+hXliby/LWbAR5m0ADYYRVI
         8c8/vethERsk0mO91vBf+k64epNEWH8NHjnD1TWbHSb5h27D+/rX2+BJH/ys0mytUbL/
         n3UA==
X-Gm-Message-State: AOJu0Yy41BSY3cyRlaf5HTI4kYCgYmeeNbeGwJHTm6RTRkVlZ4gwV61x
	FXxVlmfubzQQa3+SxUth+16Oucvr6YM6mPWlnsJgEl8o9ozz+3T0
X-Google-Smtp-Source: AGHT+IEbsoTWM9dyrlnPq9Z+H/Kf1Nac+Pw5gAyKzB+tp0r8pKXcXmVlSkwOvvuj3qF9fmh7Ke9RhQ==
X-Received: by 2002:a05:6512:138f:b0:50e:7bc5:20d8 with SMTP id fc15-20020a056512138f00b0050e7bc520d8mr9529913lfb.4.1707049533433;
        Sun, 04 Feb 2024 04:25:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW3IYlv2/sOAGk5fWd07DfLb8K1AaQ4MBgBGJCkvJTBw8rhsRM+VdIc3aNXj3FUGhoe9cdNsiuf3oyRy1L8IrkUH5bEA14PoXLWLxjcrIRhW3Pq9/Awx/UYPp+4qS2qSce0V8EhNPKt3QxftOjgVLr6i5RniNIGARyBzQEw5rI9pEjq6whlcZu2oWhl2sEVJYE=
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id r13-20020ac24d0d000000b005114b8b2aabsm210243lfi.118.2024.02.04.04.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 04:25:32 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: shuah@kernel.org,
	sj@kernel.org
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: damon: fix minor typos in test logs
Date: Sun,  4 Feb 2024 13:25:23 +0100
Message-Id: <20240204122523.14160-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves a spelling error in the test log, preventing potential
confusion.

It is submitted as part of my application to the "Linux Kernel
Bug Fixing Spring Unpaid 2024" mentorship program of the Linux
Foundation.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py  | 2 +-
 .../damon/sysfs_update_schemes_tried_regions_wss_estimation.py  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
index 8c690ba1a573..28c887a0108f 100644
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
@@ -20,7 +20,7 @@ def main():
 
     err = kdamonds.start()
     if err != None:
-        print('kdmaond start failed: %s' % err)
+        print('kdamond start failed: %s' % err)
         exit(1)
 
     while proc.poll() == None:
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
index cdbf19b442c9..90ad7409a7a6 100644
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
@@ -23,7 +23,7 @@ def main():
 
     err = kdamonds.start()
     if err != None:
-        print('kdmaond start failed: %s' % err)
+        print('kdamond start failed: %s' % err)
         exit(1)
 
     wss_collected = []
-- 
2.34.1


