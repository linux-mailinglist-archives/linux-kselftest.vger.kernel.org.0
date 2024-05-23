Return-Path: <linux-kselftest+bounces-10615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB138CD0C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C7D2827A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBBD13D51B;
	Thu, 23 May 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIP+zrvP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90A13CF97;
	Thu, 23 May 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461767; cv=none; b=ZBELFOLfsLT7HKvI2Yp5YEE24TKyZG5gf+ai87qmCHT0YHclyday6KWdJFr2iP5pdVAV29V0V4xOZulYOndy/fdrslWQLAajIHHgV8IC2U73xFHlkvvWxN105mKbVU/CYcc+ie237zV9UCXwUzk+Oksy3Vx1Ztprt/k2YqQGuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461767; c=relaxed/simple;
	bh=Xby4AOkuwTi84uYWbUJ8qz1B1ZgJbm2U5BkC6NizKEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DY3HZD1h9rMsx7AC1xdw/fA7xZWDky5f6lWZosWcswKNaQgOt6eVFbEOSmURvm+STqjYgyYepSK2aB241AfE3UQOMERKd2K0whUPLBn8fRMKnVN7BVMC6RFMIY6PUuttkeMh2RsP7Y38AlIDM5QlrgubMPnFW7pTSQMVZ6udhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIP+zrvP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso17814475e9.0;
        Thu, 23 May 2024 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716461764; x=1717066564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/YD8vs9t8a8JAFA2KhTs0rGuAGNmwdgDD+wjYjMsOps=;
        b=HIP+zrvPocazfq7vv/rWwgOe97L3Caw3dofJ+8s0HyTO8ciuw5Ic+cIcAGQEu88ZLZ
         m7i3iMWOzj8jJhUhw0no685pi29pHEsdlt8vUVII60YDyz+n33JSYuxpgmD8T/L76u2v
         dAeuysfbe8gnKGCgie8p/t57tAqSJeNF3wDOiN7po++9vMqxm7p6vGnlZrWh4R0wPoeH
         63/g96gSNDUG8xKtnbgd9K5ynsmKW9lC6/av6AsL9YqDGfIDGhX8s3KV1C5+EcFjPflR
         ES8AgI+Q15khhhbD2sFlooUB0vikgsuBlX1hhin4Q2H9MMzaS38cq/sll66s+mWQZBpz
         YVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716461764; x=1717066564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YD8vs9t8a8JAFA2KhTs0rGuAGNmwdgDD+wjYjMsOps=;
        b=teL4XHZIKBt146snN1Yvtr2tPEyhmuQqcMKBD/4q7L/ILqIEBarPB3s6lEe3CIY/5i
         C8bICq/nWcx8p7FekLeTkODHtSITA21CKzCTsodQIZffgNVpLon0TYDRa5cIb208qEeN
         n/dExv5z0CDmyNfxx9aGRRJ9ukT1urVUxE4alVSQX0KaPFjzXbB4ZRs/QEo2aTAUDKs/
         iJDxS+EW9ocVQRFjXJrkV5n8POcuuPUk8vLqWhW7Gznuy1gPgG0itNRIqMAaPt0X5k63
         D3BRCArT0/4kreI0yXII5ffyfhSQyMXDBfbbjJRztVLsEimH0hRJzhXp/ZLH1Bqr6f0l
         wr/g==
X-Forwarded-Encrypted: i=1; AJvYcCUuLWIiY45P4f0y3T/1oFff+eKJnrCOwHFIBTISvNRVB+XVTMwXoBEPP08C6sVwQoRbeh0lFamgBatUeSuQDh4GZokOyr0xqvki0ksZgp0PsoAq+MZuO/OeiErro2/i5600XeCeZuFz5aOMXVsd
X-Gm-Message-State: AOJu0YxOQUGy26C831uc2e/v4/AScwJIdwosmv5gpbOUM0uDmiMBv8ZC
	bhkqrVTrl1yFGMNr3h0TTh6XSxhLcMxSZemCoA9KOzq6+QwrRKSN
X-Google-Smtp-Source: AGHT+IH1RsI1HShio5nUIsG1rLG0BCsefwAyqPvGf0octJxxxdyE+POCgFEjgFI5+SFFziKTjm0m/Q==
X-Received: by 2002:a05:600c:3781:b0:419:f630:57c2 with SMTP id 5b1f17b1804b1-420fd37502emr38518755e9.37.1716461764323;
        Thu, 23 May 2024 03:56:04 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421010b9f45sm21527275e9.48.2024.05.23.03.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:56:03 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: mqueue: initialize array buf before using it
Date: Thu, 23 May 2024 11:56:03 +0100
Message-Id: <20240523105603.2183460-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently array buf is not being initialized and so garbage values
on the stack are being used in the mq_send calls. Initialize the
values in the array to zero.

Cleans up cppcheck warning:
mq_perf_tests.c:334:25: error: Uninitialized variable: buff [uninitvar]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/mqueue/mq_perf_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index 5c16159d0bcd..bd561dc785d8 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -322,7 +322,7 @@ void *fake_cont_thread(void *arg)
 
 void *cont_thread(void *arg)
 {
-	char buff[MSG_SIZE];
+	char buff[MSG_SIZE] = { };
 	int i, priority;
 
 	for (i = 0; i < num_cpus_to_pin; i++)
-- 
2.39.2


