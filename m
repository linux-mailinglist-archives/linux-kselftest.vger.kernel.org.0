Return-Path: <linux-kselftest+bounces-4916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D688597C2
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Feb 2024 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF45B20E65
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Feb 2024 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40C6D1C4;
	Sun, 18 Feb 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPQCIfzf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FE6D1B7;
	Sun, 18 Feb 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708272909; cv=none; b=HUPcLOnPmpBNYxtDD5dScxHupa+Ibjz2J4pC/zx+b1PlImRdF4Gq4JWpazIcYOFHTXcgTLD5ctQeFCqEh2QbDHkTdPg7HQW2ohP/NZCJZHz/wcgPVOCe6NpdmyRVxYlU9RsvFGfn1KCcO+ANCVNQNf2lmWwXTUP+waThY5Z8vNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708272909; c=relaxed/simple;
	bh=crYDsTu/Q8z/SY44ZdcbWRzwpyUgHxlte4VZaTnPqNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgpDXp9bFypaRfk83phGnYVa02EDE385UvON4CJI8ECBt+g44liwfCyRiWq+OG8Sffinp1Ff3LeiolryuKfIY4sUd5A8u83fC6X3iJFy1K9UkFG8MoEP0Dcv7A6cXckAftTBJa8lCzNo7DZ7T6yV+0aAqxcBnXQTjLa1g/+lbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPQCIfzf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7393de183so28258685ad.3;
        Sun, 18 Feb 2024 08:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708272907; x=1708877707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBEJEQMmiSyOiBfdxdCLolpOwFxsaEhAkf01EcWWZrk=;
        b=iPQCIfzfexzl3xlBouQKCaBQisZOMcXvBAmxYwSvfEOTRTeZe7LdIIfjiQUB5KIxc2
         xfS++ZgLTVKA4kNk/82bMSyZfXm5GBg7gEt9J7jHgvMBoNw+/Ynt6f5htYuXPGp8c4gJ
         2apNm9H2V65kO9j8L5V2Kf5VWAnVEo0fzSM3B63kQ0KKH7hRWWHjykP0c50ZVu6HAbAK
         D59F0+HPbHooc9vP0HB6OT1p8wmI4i/obyHAb1hHG5v/D4FhgP7kD5Et+JClXw70dM7+
         TRTXtJg0wGJcMIIEYplbRlAdIVMpChN0uiFuft027zvgZjnou1dLT/RbxcpI4aK1zYav
         Yg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708272907; x=1708877707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBEJEQMmiSyOiBfdxdCLolpOwFxsaEhAkf01EcWWZrk=;
        b=BWKBIdGgjEEwJGU3Ef2blr1ofNnB+BXEadkEa0oljjyq033jdSPR/sOt/kPYoU6rUv
         6/3Kg3kiTLGHvK5131jhKhw9+Yj0yvEncSZfbnoqt9Mz1PNPSXxLJ2pJSqQHGogn7siG
         wbzQNHfYW54O1Jw7RM1SC87+XRoragR+T9pn7mJyKFiReiBkzX7dHTTU8SilFaleQpPR
         1BnN0RgHnWLJJk4seUIRH0s6uNxuc/OCAkTc8Inypo2oUGHiobGlggJSOXVpaLkNSKha
         kYUDUyLXGcFrbGui8BnLhj9V45kCeQe8eBV+ScvBtyFJqhtPZPSpGLYTruQs82T9jvP9
         H5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWoRbflmZMA7gOxYlXDIz74inoiyOZURtqDQVc91kPCfia6vGn11AOHezZU2M8TeTbp6x/ur+roZho/cPqP9w66CI/dBthphp0AVnFFGdDTLfr2FNTb/fcOXYWSUTdmCEibxv1T3rsP3Miq0g4FruUB2fqhMSbCfZh6cCLcx7l/kwjgZ7wH9qFr8xYIzcMR3GYQa5eAIE1ZivTaMrBzrV4FEpUB
X-Gm-Message-State: AOJu0YxMp5Uce6cguR25qGtzXtzs5IAm4O37FBpnKN6tVOIQJTUoz3wX
	cUClf8jnzc3zzaJ59lhexw5osTtiYGBrR4YRL4DtPb/W5Zz9hqxo3oxmKv9piVQKqA==
X-Google-Smtp-Source: AGHT+IF8bGY9SfrUAjKSmDkVGlgnK6BHbIgYWIG3SBNGhP9To0DBE4skKON13Q253wX14A1HBKuO8A==
X-Received: by 2002:a17:902:ea0e:b0:1db:f371:dca3 with SMTP id s14-20020a170902ea0e00b001dbf371dca3mr496043plg.48.1708272906869;
        Sun, 18 Feb 2024 08:15:06 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2000:500f:a246:8a16:bee7:140f])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001db4caef8d6sm2849500plb.161.2024.02.18.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 08:15:06 -0800 (PST)
From: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
To: rafael@kernel.org
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
	mario.limonciello@amd.com,
	nathan.fontenot@amd.com,
	oleksandr@natalenko.name,
	rafael.j.wysocki@intel.com,
	ray.huang@amd.com,
	shimmer.huang@amd.com,
	skhan@linuxfoundation.org,
	viresh.kumar@linaro.org,
	x86@kernel.org,
	Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
Subject: [PATCH] [PATCH] amd_pstate: fix erroneous highest_perf value on some CPUs
Date: Mon, 19 Feb 2024 00:10:31 +0800
Message-ID: <20240218161435.38312-2-lucasleeeeeeeee@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218161435.38312-1-lucasleeeeeeeee@gmail.com>
References: <CAJZ5v0hRk3tME7yeC+1r0RM4-oPPrnSu2=JCsOshBbJp_Nq2Hg@mail.gmail.com>
 <20240218161435.38312-1-lucasleeeeeeeee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Ryzen 7840HS the highest_perf value is 196, not 166 as AMD assumed.
This leads to the advertised max clock speed to only be 4.35ghz instead of 5.14ghz , leading to a large degradation in performance.

Fix the broken assumption and revert back to the old logic for getting highest_perf.

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
+	if(highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
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
+	if(highest_perf > cppc_perf.highest_perf)
 		highest_perf = cppc_perf.highest_perf;
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-- 
2.43.2


