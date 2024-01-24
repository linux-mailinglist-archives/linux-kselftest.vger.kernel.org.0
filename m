Return-Path: <linux-kselftest+bounces-3471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C7E83B0E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8F91C22DA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DDD12A16C;
	Wed, 24 Jan 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="H60eTJkS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD012A168
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120398; cv=none; b=Ag4VHQ1fLCXIBRSrSWjvTWK7r/AKjFj4u+Bs4KIeweb4YcX6aRax9wv8En7jUXyvhh6gig/QuDiVatCHDH3f+DRfj6yZx4wTcxWV2lV9ikCDIQaA8GbWroN2se5cJHfa4DYHeA5xDxQSJZZZALAqZoXA2LoG54WcVsbvCt1fkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120398; c=relaxed/simple;
	bh=pQOrA7c8IcacL1fUQsE2uSC6rSNsb5lJxjB+TAL4fOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=La0eUfM7Sh34y3N1SI9DEhNKuFj0GwMX+Vl1bK/SXdzVV5sMXi/5rtxb4AJhc/zE256ooxp8V2kf3sCHv3j8mjGWdiIYuWeIVOiZIPTXv88JVm6smxs/HlCPA5bH7uoMUz99cp3pRGF91RdrzORpKJ9SjRlJJKo9+FIGKgiQ11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=H60eTJkS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d748d43186so25685135ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 10:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120396; x=1706725196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFBxT7xsVHh+8ayeAuuuih0ZuzmZPtNAj1TB2KnXVb0=;
        b=H60eTJkSCehlFB9RHNIgWcWDymyWFyKQV+2kudCVyAgBcw51qpOKlbTqcsYUcA6Gh9
         B+D/uK2zUemOKIot52I25UUTqbUG0H4HCXVKmK4g9ouq3RkbeonKOocSm7w7mRGfsJBx
         szkfLNSQmwYRT+oVwXsIdVcWCktlfSjbNStad7xcR9K8BSPTW0C7DPdMrApGCVDiw6hZ
         ihoiTkz49EwbbHfOEiJC8foKESbZNGcoUymICOkDvS6C8P5pWowe46iTaILsVY3PubgF
         +yoU6noNByEjomMAysveC39T8EBVHy6QE4hKBMU9KTxXDUvY9vRtYZiOrJbXHkh8qBZY
         04ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120396; x=1706725196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFBxT7xsVHh+8ayeAuuuih0ZuzmZPtNAj1TB2KnXVb0=;
        b=Ea5dxLmYoEd6WAIj/rgvvc5BCWrPxAmE+jXkRFcKzt+F26g/shf8L6JfX7W8UD6LWK
         D9OW0PwBk72eDW5/e4tEFk7E43R8jtx2VJaOgqIJ9l7OlgRD4qEcnos8e+jAsm5MQ0hJ
         53t8uQSqx1k7zoQwiPak0GQT+xY6KVbr1U0BUDb/tmypSRPWLBo+UONxvAFmBrnJ3Tts
         4b2H/ILd4CJeD5lo4I7TI5JLZFPIBa7RLCS+fBWHO6qTNKkcpahjDqaAmfQ6L0o14X/Y
         FQ7xtBn36nimIhG7zVMZ2YmSCUmS541zwx7eDYvRLbDGleZakci8Ox28tVVEP/34PuPq
         h0Dw==
X-Gm-Message-State: AOJu0YwrEf3tXmupAa9hpEMIEHkAb0mFjlwHvQBb8lyU0ybrzw3VvAna
	W/Oc6zDo89rGpGGmCYXEwLSjqjjQG/RzEkNbjhX72mxsU7XGDSYYTtEq+pynyw==
X-Google-Smtp-Source: AGHT+IEd6Wt/I3bXZmlWfCk17h95CFddyzKiIkQSqc0P8TG3O2iY0L79PoKudaTfDAgw/Mn9kguxJg==
X-Received: by 2002:a17:902:dac8:b0:1d7:4a66:87c1 with SMTP id q8-20020a170902dac800b001d74a6687c1mr1141175plx.50.1706120396439;
        Wed, 24 Jan 2024 10:19:56 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:19:56 -0800 (PST)
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
Subject: [PATCH net-next v2 2/5] selftests: tc-testing: check if 'jq' is available in taprio tests
Date: Wed, 24 Jan 2024 15:19:30 -0300
Message-Id: <20240124181933.75724-3-pctammela@mojatatu.com>
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

If 'jq' is not available the taprio tests might enter an infinite loop,
use the "dependsOn" feature from tdc to check if jq is present. If it's
not the test is skipped.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index 2d603ef2e375..12da0a939e3e 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -167,6 +167,7 @@
         "plugins": {
             "requires": "nsPlugin"
         },
+        "dependsOn": "echo '' | jq",
         "setup": [
             "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
             "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 clockid CLOCK_TAI",
@@ -192,6 +193,7 @@
         "plugins": {
             "requires": "nsPlugin"
         },
+        "dependsOn": "echo '' | jq",
         "setup": [
             "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
             "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 flags 0x2",
-- 
2.40.1


