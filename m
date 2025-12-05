Return-Path: <linux-kselftest+bounces-47114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC70CA87E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AE583028C2E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B89033C1B4;
	Fri,  5 Dec 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShpiucD5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7D8330339
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954740; cv=none; b=OZmdsiMi5F3tQ+yOPimZfwTyu2k+HCMxE2whGqi3PqFjufgS69mC+iLXr2Oxi4ouIVJmGFgotm3ckJe0tyUmXLcrt7Ahdrktzwzo47083cX8iB/E1tmdO9A9HaLvAhfa517ULS7aD0jV3CEzQajzHqEPfWcHLOGsCFipLDw3y+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954740; c=relaxed/simple;
	bh=zQXdANrAyobWWcUFn+j7Tv5/akEdbk709MOA4NwiFNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAcNkZ5bN0h6gvYchpks/mQPZs1KlN15vWZePAFyoF3rpa0Pq8weYe2Rmigx/1bfa8JAVJxH4rf0ro8TCjEXvulvQBrYFTKgYzwkWIANwwZXEufRhQSHz7KwfuRA0JYRXQIE/KlDnO3KOc17/WgqdUi2vd5cUZO90TcobehaQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShpiucD5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso2832259b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954732; x=1765559532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGP855q8P483/tvMYnKD3q8c0QVPBAHakO/1UvcTEb8=;
        b=ShpiucD5CfH6RxTe1uOiHmjhJxOqvhW2w1po4HFvFUfjGI/pAp6RVV3JA5fOIig3C+
         agqJZ4DMGXun3iJpTMtrmfX9w5ohDBDvrOuThC4NKa/E5OlbkEI8tu+6Gnl5byhCNLHP
         bWD4KFNvutkrwaaXaCkSGxgH6uLWtiKOvj/3Qp3IGL/jk6+LFJDDKJFm9oaClJe0YgjB
         UGVj3I/kkh8krwY/v9yTYcZNOzWQdFXJyTOUvoOGjQYhvDawnVO+/J+qORctn7HWXxrP
         RANvACI+0+CUGHodyK3CWSL2/CvDWnRoL0oq7sdvW6zwOmilrpXdf7IMMQUdDCVsUMJ7
         qlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954732; x=1765559532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGP855q8P483/tvMYnKD3q8c0QVPBAHakO/1UvcTEb8=;
        b=TIbDeilxoLIBtcPRwNg5sI7/+TDZmFyKIQmtfK9WRUVoLXxdVek9O5CaP8HhiXY4pJ
         fG5z7/RdXwvU7NgeFuc17Bde+TSkh0kP4s9jO63vp+VE2dZlmFODeteOZ+H8hbH31zfe
         UYS3po5bxmuR9CdOOs0ckGixJSWTZ4g+BBhbGCzPOD0gUJj7WxLex/yWMhZe2HF8QZk2
         JAYgVgg/mpGGymBhqLKKRWfi3PyXp9S9MW59jW4V9eHUKgOKUAIQYqhfHuajBr1M+CKq
         H9caM1cTESgDkozRD24OZ9m1OvvSw9qN0m5d3U6PVaheLWwmGsTl/OkARJ+OUGTKPNeJ
         c0VA==
X-Forwarded-Encrypted: i=1; AJvYcCUJNrEGcp2a6YnYQRmQTyAx6MW3ujkABkaEtxh+cs8xdA7L4/NOdqIWOs7b6NEkvM3oj+cNSu+kRZHkgdDhv4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PbBvPg4BkkNfW3NOa5tvOC4N1UotSmFf4+WE4miPqd/bdA/Q
	TGx/Lgxu33RvOs7JU4dKSc5i/1FUm3m3uodZ/f6Tk6xvHNg8oUUmiyaz
X-Gm-Gg: ASbGncsoqInxCk3dzeOeoS6ozrHTJEtoue2hCk66Bx+64wyCHnLYG1WI9s93ZrtK599
	Xs96odUuCbEttPzFgn6efOS/3+WuHKSB0yHgWP4X+VArGGBS94sSqBHUWL/YQSSsVY/QS1tbRzn
	xA0744B/Gu0v/1dfBdDTRfL46WFxKZXWXH9QSCAybV7OcdF0yJUi6WXd7T7pWtBtj2cwmKKy0e4
	xPVyjVs8lw/Yfll8J91pF4e17oFaQmNkHec0b+2JYxYAA1kspuoe47+ABWVOI3+ZqK+6Ud2JpQm
	bG/jTEfINLuWMy9ik4OrdNFolYJ2jIKK3uQjGPTLBYiSAp1Ejf0+kUj8MIqtoxtZRO917pe1Pbq
	bA300lsZRzG1NAtApaIpByXgBi7xbn6wfwRhVDf0FTDVbIURjzRuiKYXH6F4tMg/FUP6BwCkNUU
	vsdlcn0tCPo47GljSQJ0A7Tik=
X-Google-Smtp-Source: AGHT+IHdTvay/STs3LNZkpmmMt8IstasmpTYD+N4EpMd1XG2nuq4zcxaDuN9vSlvYoOBreCnQRf4EQ==
X-Received: by 2002:a05:7022:258b:b0:119:e56c:189f with SMTP id a92af1059eb24-11df0c3bbe6mr8274625c88.7.1764954732270;
        Fri, 05 Dec 2025 09:12:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20697582c88.9.2025.12.05.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v2 02/13] selftests: ntsync: Fix build warnings
Date: Fri,  5 Dec 2025 09:09:56 -0800
Message-ID: <20251205171010.515236-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

ntsync.c:1286:20: warning: call to undeclared function 'gettid';
	ISO C99 and later do not support implicit function declarations
 1286 |         wait_args.owner = gettid();
      |                           ^
ntsync.c:1280:8: warning: unused variable 'index'
 1280 |         __u32 index, count, i;
      |               ^~~~~
ntsync.c:1281:6: warning: unused variable 'ret'
 1281 |         int ret;

by adding the missing include file and removing the unused variables.

Fixes: a22860e57b54 ("selftests: ntsync: Add a stress test for contended waits.")
Cc: Elizabeth Figura <zfigura@codeweavers.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes build
    warnings 

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
2.45.2


