Return-Path: <linux-kselftest+bounces-11649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ACF902FD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 07:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF691C23371
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 05:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1FB170854;
	Tue, 11 Jun 2024 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi2fgt6n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569A170844;
	Tue, 11 Jun 2024 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083123; cv=none; b=K083jOWjL3/1IIdEllhjhuSIwj6FBLhotr0+TMn+pzYwvKCxlf5plNcD+B8iJRVe5RKU8ry4jt5bi9udNOqcBH+jQj1ZOyzcogb/Fos0owRwb/QfgaUsCJuClcImR7ak4V76fWJoPALZtNVxWfi+w2hT13/KFHc5IUzohpFpjPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083123; c=relaxed/simple;
	bh=YstzfgNOOOBumGQqgNHf30RBk+xS5QlP/PqWB/aeQBg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kpFGc+L4kGJFpLPhVSj5V5JF9SbIQ9wYUPEOYnc+kFcDsv1ahQ5+iiDX7ES/+3bW7UpFlTn/pGbHToPom4F6OtJ5+yusvyEzRBVviEqEHG5mpKQOA8D6hyrvtrQEPunsQYxkUmH44/nY/hTy0W+SDRdWsKScY2DuxXzfLQOjlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi2fgt6n; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2c2db1fc31fso470123a91.0;
        Mon, 10 Jun 2024 22:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718083121; x=1718687921; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAqq1AZbfLB4KlIns+O0fAjIRvY03AK8sH1SBKEy40M=;
        b=Vi2fgt6nZlvedK6wiIMda/kVj54J4gzCegSM+ZAn3e7zSoIqF0qmzRbsmu9Z/wUCDN
         vuqyw0JxomCr61QJtq8U4zZcW4fCSZRTHLGMphq5zlVqzPHYq5zvI59RgeTGhLIQOFTJ
         pdbyRj00dsKrgWm841RgK23viTxAg0n9rKYhMF6nmXjT95klxlOPKe6y/tkUDmCDjEHM
         Q+JSguLQhImo/Pp9CqvdgkmAEHqKPuaj5uo3umDrXuRaqf1netfe66xtmKZwL/S0IZ2w
         VUhZ9k4mwSA2d4n2kxEBgYW5++s9J55KjQJTPbGjGoBLwdUNnEWd9xlmXbHazHkbMZnv
         8wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718083121; x=1718687921;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAqq1AZbfLB4KlIns+O0fAjIRvY03AK8sH1SBKEy40M=;
        b=OUixWXHi7T/NR3D5JVgfrvIDAnoTruu+lQ4ohmDgOcZalK2LIjJlT8+cIb6C//8m8f
         kgorUTkGe8mVnq+W7ZNJPlRGHtKNOcKqnCqrBXPqfzRVXrdy5k8VqeHAU3wLKH55vcuR
         vll5b1I+EMUf9pO2lAhg7hK8ED5JrMm39N29BVjtpaOsnliwmsPvsfhuvqxXET4fhFri
         4yqnHk92az1A04BcZIKY+ZMT+BCnG6X8oKUrV1xPk7i6Rtl8/JiiKlAqikuxGnhYdUhp
         /s/sxWIu/O5pHnU1fmznQ3DVNrOp4ZF1L2BC+ldZiKC7h7P9jo8Fo+AGcunntxB5MlDV
         AZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1AvlsNuiexjkQj+s8kpmSoi7MPjklA6HfLxmCpy0RsAyGw+MoJozTc/aTM7Ht7OsXMjba2JIt2n+72gk+EU2+eFfBvlPDdjyLnNN2
X-Gm-Message-State: AOJu0YwugJtsEIA5KZ+efytaSrAdl91WQ59CvmHb4RkprE+I50thtl2A
	uHbFOEFFdW5MoKiJ7+5HiPCZbQs40GLqkICPsp7HDv0Q90/HW77RIhrhJPWhkKM97Q==
X-Google-Smtp-Source: AGHT+IHhiwb2Z1ce+DjKS+OfZ1A/APv6F1fEZZXYhFtflxOoMOPSDYKSt0oNuUd0F4WbiJo8xGdaqQ==
X-Received: by 2002:a17:902:d503:b0:1f3:10e8:1e0 with SMTP id d9443c01a7336-1f6d02e22d3mr124228485ad.2.1718083121094;
        Mon, 10 Jun 2024 22:18:41 -0700 (PDT)
Received: from localhost.localdomain ([117.147.90.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f7171ea36esm26564005ad.114.2024.06.10.22.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 22:18:40 -0700 (PDT)
From: aigourensheng <shechenglong001@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aigourensheng <shechenglong001@gmail.com>
Subject: [PATCH] selftests/sched: fix code format issues
Date: Tue, 11 Jun 2024 01:18:34 -0400
Message-Id: <20240611051834.2885-1-shechenglong001@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

There are extra spaces in the middle of #define. It is recommended
to delete the spaces to make the code look more comfortable.

Signed-off-by: aigourensheng <shechenglong001@gmail.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 62fba7356af2..52d97fae4dbd 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -42,11 +42,11 @@ static pid_t gettid(void)
 
 #ifndef PR_SCHED_CORE
 #define PR_SCHED_CORE			62
-# define PR_SCHED_CORE_GET		0
-# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
-# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
-# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
-# define PR_SCHED_CORE_MAX		4
+#define PR_SCHED_CORE_GET		0
+#define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
+#define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
+#define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
+#define PR_SCHED_CORE_MAX		4
 #endif
 
 #define MAX_PROCESSES 128
-- 
2.17.1


