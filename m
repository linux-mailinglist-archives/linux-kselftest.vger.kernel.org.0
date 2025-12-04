Return-Path: <linux-kselftest+bounces-47029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04929CA4840
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD243152954
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F4D3115BC;
	Thu,  4 Dec 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m76CdsSk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F530BB87
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865058; cv=none; b=NbKr4iFU5XX/epAckkmXHzOrxYyxZAZgkub4BCwO/hcj/EFf6zt/c9iL87Ha0m2gX/bx5X2QdIA8+las0Q5B8QUd/DMvUVMlJqy9whFG63W6t/OOkO4F2JNhLPs40IugoLwlTXGReFKULIxFSAmzqfpG49JGKla7IMrSi4iU50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865058; c=relaxed/simple;
	bh=AAfc1FTHUg7pFDTfmSnmLRJtRMoPx8CAYPklnRgrY6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQWYF6UJ8OKPfMgUDSusTxqPKAhf9I37mfEuC/iki9RiKgAt7tgtLOhMKVsMhCW6VG962El2mUHsHQ6p2xVeI8i6ETxGIuoNvka2xW5Ok2JhBbv5siBRzKk+Bt2mhwCMEtI8jXVGK1bgoNKpyO3U573qY5b6knJ9FBu894MV8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m76CdsSk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29d7b019e0eso13439905ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865056; x=1765469856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPSXK4QWZvrY6PEEMm54/MaPBa83AbH2NH2bvzL1wMY=;
        b=m76CdsSkhyAcC5hScfGv7GkTJ34TrqHYjYTq/A/9eCu1OraPqLKtEaMhS/nK/d1VeI
         AqBbDytbj4WsWWsXyqxfz9I4Jv8fssaBi2GzdjLCQMQEcdjvDy9i13HJ9rG10FpT3WeW
         Awvs5A2PAThTQk5LuePgitWjOw7lDeCpO7k0WfdF6o0w6WIz1ktyUgRJs+hoiOdC0FSE
         b/qRoQ35w1mGQfRwPd1T02TQk3hsI/tr92LDxoeK+zfUu54ylbi5NRUES2GmaUmkmC54
         Zaf+N3KOnG5Vyu3Lh7zP3F7xxF87V1pfkfXfly42rKGlLXQpmxtzfIQ4pj06r2nLZa95
         XFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865056; x=1765469856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPSXK4QWZvrY6PEEMm54/MaPBa83AbH2NH2bvzL1wMY=;
        b=DsZ5kdvf4n7Ej8dWSwpwZlgye5GVm6dEbAKu7yhwXF8d7dAGoiNOVyLmzU81A8LD4W
         6imtMzB+8W0/U5ZLVa7zITnF96bX6/fFzcdk+ajh7wT0RC/kQwNUyChlF/jHQMBEhUnQ
         dC5n/FzyJyDWEXsjgcOeyNkGRl02ZUKuWoKdHLaVn6S/YOUzm/9VyaTwPmWE+dx/3dyl
         XxoVEeAbnVS2ky6/EXZar9ZKlsmPZKxeJPd+MrgDY+g3hxPu29TnJOQjp7xYe2LPQEJu
         O0nyXf1f7jMbJJJfjugzyxXo/ShAZnWAWe3OeyDFmKtjQG5Gcsmp2ImYwKxGeoyPdnep
         /b7A==
X-Forwarded-Encrypted: i=1; AJvYcCWt6KudxjKBns9VBotB9cNAuoviis8an3MYSNpwri35s0YxcbyKnD/kgV1F6roAO7AhPSRSO0J094xF4tnVR64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/7yC8yHf7aXDBNPym3Ci7GXwgXKylIat8Dq9uJ2hTJVJYlfj
	iQajqMUQBvrIK+rzsmBiU8kb66+E18FM2jT6S24QUqdIN6BX758Jyn46
X-Gm-Gg: ASbGnctXXMweU5K8I6iY+lQer3ObMC0lk6cBkaQclvJM2MZqw8bmA5HPwwO0KNa9w88
	5vbuTSa8dsJ8S9AQq1kCM74oP+gNb/wSNd/5me0CdHzbYxB8SrdlD9fpmoED3slrjSKbY7kb0CU
	LZTSD2Pr2QMK1g79hO6o/z06ED2bOGPNKlA3B3g/yOFn7iXQmmKUFq21pSt654Lq96pZWVaVB97
	riYjAplLfyjLn6Nk5hC9uYd+KzKWpwF7eLIbMGX2UewnBn0V2I7qLbXLa3TFYM/hIPL5AHjE1E2
	Fc81nwQctHZVey5wpepquoZZPtJs+QFH+otmivbMtC4sbBwI0OJ2xnJnaB2Umcy0hgVvMxyRIvG
	ihv80bDHEAfXU3nO6AOvSgjLxvYI+YKOwbHO2tRURjFNOla1eklNDOlqGM3vrZ93S7ZaaJzm5lA
	SHoc4oB1veCaRJn2RtaygSY9c=
X-Google-Smtp-Source: AGHT+IF+E9CdNRVWiFV1Q082ZOrNiQdxmoZOMYs4fBD6jDUJHOWOaJ88Yx5928q27lnrpgUR2cVtHw==
X-Received: by 2002:a17:902:f712:b0:295:4d62:61a9 with SMTP id d9443c01a7336-29d68413f5amr90437015ad.38.1764865056469;
        Thu, 04 Dec 2025 08:17:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f223sm24183665ad.62.2025.12.04.08.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/13] selftests: ntsync: Fix build errors -seen with -Werror
Date: Thu,  4 Dec 2025 08:17:16 -0800
Message-ID: <20251204161729.2448052-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

ntsync.c:1286:20: error: call to undeclared function 'gettid';
	ISO C99 and later do not support implicit function declarations
 1286 |         wait_args.owner = gettid();
      |                           ^
ntsync.c:1280:8: error: unused variable 'index'
 1280 |         __u32 index, count, i;
      |               ^~~~~
ntsync.c:1281:6: error: unused variable 'ret'
 1281 |         int ret;

by adding the missing include file and removing the unused variables.

Fixes: a22860e57b54 ("selftests: ntsync: Add a stress test for contended waits.")
Cc: Elizabeth Figura <zfigura@codeweavers.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 tools/testing/selftests/drivers/ntsync/ntsync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 3aad311574c4..d3df94047e4d 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -11,6 +11,7 @@
 #include <fcntl.h>
 #include <time.h>
 #include <pthread.h>
+#include <unistd.h>
 #include <linux/ntsync.h>
 #include "../../kselftest_harness.h"
 
@@ -1277,8 +1278,7 @@ static int stress_device, stress_start_event, stress_mutex;
 static void *stress_thread(void *arg)
 {
 	struct ntsync_wait_args wait_args = {0};
-	__u32 index, count, i;
-	int ret;
+	__u32 count, i;
 
 	wait_args.timeout = UINT64_MAX;
 	wait_args.count = 1;
-- 
2.43.0


