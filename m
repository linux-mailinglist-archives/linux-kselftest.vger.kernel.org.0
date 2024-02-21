Return-Path: <linux-kselftest+bounces-5208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85585E481
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82351283579
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA183CB2;
	Wed, 21 Feb 2024 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFPdqD7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8E7F7EA;
	Wed, 21 Feb 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536247; cv=none; b=BqrLuvgKsZzfcV+U8FYxceDRYHc3g+YbuF75zLX13banCzi+VAFrZKSUwKsXndFXfrq+/FUWkP7FxZFhZnpckwJSfLhofJxgORkZ1h4/oi07wKYdC15rF2akznRipid49X4SgOsLW/Sf7I419pf9Nt6pMkvxYnpLZXCasA5EWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536247; c=relaxed/simple;
	bh=2gSFdXQslCcELEmt27ii408bUhhDY+Jb6gfi1b9Tkpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdo6W0XccmEg/0dnwx/cJUIUdx3XfEurMmwHqCqwAvzU7WquNxoPMPjTrBoTkcmCpkQ+qiSl8KqSW8c34uSFbbTTKj0ilCVQ97Wt3mN2uUR4uPtgafkBn0UG8YKgRJdCIN+oQcDQ3QqnZncX5HDfrSNqnTkVv7zB8Am+zuCsZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFPdqD7r; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e46e07ff07so2234161b3a.3;
        Wed, 21 Feb 2024 09:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708536245; x=1709141045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsPQKiy0Sm1aIRngHvDF4ALP8VICeSJz60rKu9HhQtM=;
        b=iFPdqD7rJlhrdq1rZ2iIIM5fne7PalZ2RGwItbpXO49N3kwHAKkWz6svs94iRLkwMy
         2nezhgz+L4XY+OCuLARTO1g991lMf5PPy3pkWHs83O/IIgaXYMwNETn6fJx+6VXo9l2H
         Pp5vvf2c/wWbCDqAbHjWkaDgTswvWcrlbsV6J6DvIprIAuX8LVIzmW+F3tKKfjO7Vu3i
         eSUPXtM5ixQV1m890sTJa9Li4x9G0auLdYzMeg5mB5n/foBSgzf3hj79Y8hFTM6qCrES
         Snt6MqjXPM1xKBu2sKu8NNCUBw7urrnJqy3t66xcxerT6+XsxFCifYVrBVWWrMI2Nq8h
         DNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708536245; x=1709141045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsPQKiy0Sm1aIRngHvDF4ALP8VICeSJz60rKu9HhQtM=;
        b=aonDHotImSBWkv6MystKNGAVJjK1/99Zu/XJmxSqBtWLy1TLOrpTPHxM3Nnty+knja
         0lmHJZHZ2T3+QQWgWZoA62q3Abz27zmyIhmC5mWCB78fOwDToHOZ2Oi1TSElSX/zOSyc
         k48G60oqCxb1RTbsIsFuFA2lAx2To7mnp7I4iK3s4V7mrdJdOlQWZln5r3OwM+vNoFtq
         Y9zpov0T4S4eJZrfmBLlc2NZdMbUVgAQ7LjOtjqif2CEI92w+JkDkkuoPwXbOxX/vz/E
         9EJnt1vav+Orj0VbE3tYtGJDt7epitprVvbfHKNn9fIQrmj3Fzqzvu6j7SVXgTxzzxmJ
         37YA==
X-Forwarded-Encrypted: i=1; AJvYcCXqOyPnp/b2kx3yexoNxY1SCZGW0hal5rjuI4eopNUlDZhoZ/f0n01bGpv+Z2s1XLlC4yH5FZt7KzezWk3oR4i76V4HACX9zubUuZE79JMnN38gI7kyxohqubAmm5VxgGGsOUwqNIOK1CRl9pHbhGer8bZh0K2vby6NN14kfCAET2Retnl+f4VdOswFIXW9GOfXqwT+Rtm7TUn4ZpVeOI83T5wd
X-Gm-Message-State: AOJu0YxutujlJBX/VerlDNOvD3kFmvya9bUZgiu1xYM+T52g6kYiHWEA
	LRWHRrWNw9fKbxo1jRgGy3U3YkdKlef4nRhZxiQuA06yO9xwZcRoqrqtylK5A4JsMQ==
X-Google-Smtp-Source: AGHT+IE2pFiY338XU8TevuAvOfaaljl4D74mPTJNZR7osicnvccdCwPz3FojZy2vOUYswhqDgFHi5g==
X-Received: by 2002:a05:6a00:a88:b0:6e0:f3f4:8da9 with SMTP id b8-20020a056a000a8800b006e0f3f48da9mr24499791pfl.4.1708536245357;
        Wed, 21 Feb 2024 09:24:05 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2000:500f:a246:8a16:bee7:140f])
        by smtp.gmail.com with ESMTPSA id fn15-20020a056a002fcf00b006e324e33ab8sm8640356pfb.218.2024.02.21.09.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:24:05 -0800 (PST)
From: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
To: oleksandr@natalenko.name
Cc: Perry.Yuan@amd.com,
	Xiaojian.Du@amd.com,
	alexander.deucher@amd.com,
	bp@alien8.de,
	deepak.sharma@amd.com,
	li.meng@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lucasleeeeeeeee@gmail.com,
	mario.limonciello@amd.com,
	nathan.fontenot@amd.com,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	shimmer.huang@amd.com,
	skhan@linuxfoundation.org,
	viresh.kumar@linaro.org,
	x86@kernel.org
Subject: [PATCH] [PATCH] amd_pstate: fix erroneous highest_perf value on some CPUs
Date: Thu, 22 Feb 2024 01:19:15 +0800
Message-ID: <20240221172404.99765-2-lucasleeeeeeeee@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221172404.99765-1-lucasleeeeeeeee@gmail.com>
References: <3868832.mvXUDI8C0e@natalenko.name>
 <20240221172404.99765-1-lucasleeeeeeeee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Ryzen 7840HS the highest_perf value is 196, not 166 as AMD assumed.
This leads to the advertised max clock speed to only be 4.35ghz
instead of 5.14ghz leading to a large degradation in performance.

Fix the broken assumption and revert back to the old logic for
getting highest_perf.

TEST:
Geekbench 6 Before Patch:
Single Core:	2325 (-22%)!
Multi Core:	11335 (-10%)

Geekbench 6 AFTER Patch:
Single Core:	2635
Multi Core:	12487

Signed-off-by: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
---
 drivers/cpufreq/amd-pstate.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 08e112444c27..54df68773620 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,7 +50,6 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
-#define AMD_PSTATE_PREFCORE_THRESHOLD	166
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
@@ -299,15 +298,12 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 				     &cap1);
 	if (ret)
 		return ret;
-
-	/* For platforms that do not support the preferred core feature, the
-	 * highest_pef may be configured with 166 or 255, to avoid max frequency
-	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
-	 * the default max perf.
+
+	/* Some CPUs have different highest_perf from others, it is safer
+	 * to read it than to assume some erroneous value, leading to performance issues.
 	 */
-	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
-	else
+	highest_perf = amd_get_highest_perf();
+	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
@@ -329,9 +325,11 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
-	else
+	/* Some CPUs have different highest_perf from others, it is safer
+	 * to read it than to assume some erroneous value, leading to performance issues.
+	 */
+	highest_perf = amd_get_highest_perf();
+	if (highest_perf > cppc_perf.highest_perf)
 		highest_perf = cppc_perf.highest_perf;
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-- 
2.43.2


