Return-Path: <linux-kselftest+bounces-3472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AC183B0E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C602848EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F912A175;
	Wed, 24 Jan 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="V0VeGcbX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636212A173
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120402; cv=none; b=Otcia7f7BxNConSNw3F2aLjhF8uDxjSaONTqJN07NDeWW34J/AL5yplgyl56Fud0LrYBrQ8GkWhK/6SxlK1/7TrE0AH1tPj2YbWVCJVwKWq11C3ZOkP7NZDBecSsGB0N/fh0SKelRY8nEllUGgEm5oxmFieACRwEsfLImQ1HXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120402; c=relaxed/simple;
	bh=ewKXOUbu1Pyuh9x+cdnLLtObcxSdtkqTBHdNo9HRO8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocX8nbT44eizu+lnixHw3EfKtvKnoURWGEQ57FN9+O/XUQaHscef9JtsIH7n17QZQqOyRBxIrl2P71lrSQO2wiXe4lpeheHDgbQkvM1oGvqkmA6NyZ7mISA0qGok0sHt50ILbeNGCEHvvZb+ZH22bBOfNvYwoowF6Ejl4PANfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=V0VeGcbX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d427518d52so42031115ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120401; x=1706725201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk3nWSvAIa1Zh4Z+2SFhPhPRTodwriGnEQi3EvZJ3+I=;
        b=V0VeGcbX8sBoJA7zE+F0kxzLyje4LOFc369UJ1B6i2VJRsvur0UXuNeBEG+tuthoxt
         x+SisFI+H90TuOghZ2p+4+D6XyhaVKwDkYjQxeyW28/pjnADaQ7gIOTS8FHoOM5zjtY5
         tEpo14CCE/i5MogRr8TBlPTtVf5GxKxXCK8qqMbuEQnetKgbff+vSyPU0Y7AdDvrrdgy
         FhnSnIOpLpfxXQMLuCB1juUKt7eD5cRNKmMCuHWD9S9P5CNQBbV0prgkxTpo4vX0cPf7
         93q4lx04LwYyrqGwaLeL7N6KXDmPID7vVO/HQ2PuDG0+Z9LqGT0ILlj60xwV/eTEo3+6
         L6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120401; x=1706725201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk3nWSvAIa1Zh4Z+2SFhPhPRTodwriGnEQi3EvZJ3+I=;
        b=KCQTb5nkiqegW6mu6WF2QNd43k1jmorEjoJXX4LzUgTznaeKapa8kJp1kjudUb8rjA
         hTODwLCZjxRxaGo/rxPSidpdDk6S/Up+hg3srXI1CmBSGHwr0C71S9mxWEn+BAx9ytzP
         8iAy978/VmHQ+Ei5pwErfLJyypdySCbegmAIn7I+cHLg6742QAIsMaKfywOYG9+IaJPc
         FeyWVyF5D8mOuojKvIkQfP9zO9TLT9x7gFhkJ7cvM2BtkkinBb+RF/HeZ3h0HD7NHmTM
         ACj5fx2WrmCaQX1xpSoI0Wr6RHq3AO7vIqpqbNE5oaKzQKnQySkOEhjG6EWhjUDk2weL
         S0bw==
X-Gm-Message-State: AOJu0Yxh+iI46dkK4mQfZXV8VSjf/yoB8jnotc4bsN8OtrmY8btxzczn
	AetaHbRKMg2msydxKMHFwK+pITe7YFj6I+QvTRXlh/ocb7sbKGisWTfpfwhq6w==
X-Google-Smtp-Source: AGHT+IGNjvPbEbHmN1V5xIH0vtgWPNnfFzzz3VqFykrZ/bt62ErW9b1pl8zoqozEU+KHFWS4fZDp4Q==
X-Received: by 2002:a17:902:a58c:b0:1d7:8a03:e23 with SMTP id az12-20020a170902a58c00b001d78a030e23mr45943plb.65.1706120400828;
        Wed, 24 Jan 2024 10:20:00 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:19:59 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	dcaratti@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 3/5] selftests: tc-testing: adjust fq test to latest iproute2
Date: Wed, 24 Jan 2024 15:19:31 -0300
Message-Id: <20240124181933.75724-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>
References: <20240124181933.75724-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the fq verify regex to the latest iproute2

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
index be293e7c6d18..3a537b2ec4c9 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
@@ -77,7 +77,7 @@
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq quantum 9000",
         "expExitCode": "0",
         "verifyCmd": "$TC qdisc show dev $DUMMY",
-        "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p buckets.*orphan_mask 1023 quantum 9000b",
+        "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p.*quantum 9000b",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
-- 
2.40.1


