Return-Path: <linux-kselftest+bounces-16804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FE496640C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BCE28536F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B521B29CD;
	Fri, 30 Aug 2024 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iczwQk3G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049721A4AA1;
	Fri, 30 Aug 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027585; cv=none; b=nq7u2izlJ4NXT6/Z6bFXx+kFJk576cxlY0HY5/L4DN28oZytmz8VTLClGShJOo7e3peR4WXgDF699WJ+Ixce9uOPgMM7iOs3eN898LLeRfAaSFRQj4VFce+QCcu6uNc2WgDgIUUyEYKGaUn5LJjFCi8OVBky4oUhHfb9jjtNvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027585; c=relaxed/simple;
	bh=0ZWXXcdMHQD7yQhOFHjj1ApmLTmEwbfaGpySJmAc0GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSPe4s9st9IgvR2I+PqidBvOoD913gRPbJpkKO8nmwdl3wMTthWS+R1MwKVqcj0eitx11Lld7tEi1gyC9rJptHfExsUnx2obVPIsO/K23Ehsuic5M3KRX5FOsarrwPAVX+Lm7XgczJvezRTMGiDEoLKddBuSHUGsZn0scuGAPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iczwQk3G; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6b8f13f28fbso16544467b3.1;
        Fri, 30 Aug 2024 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725027583; x=1725632383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E28ANgGeyclkwdvrEsGewBjyWcjmIbB2+4duJTvxOC4=;
        b=iczwQk3G34k6zWyn87QU1hNS3kRm0iyvBw+k3p11MiyNx5TFoIGYi7ZN9J6cz0KmUq
         7KwWTCXOawM4hbMHafvxfkAiuVBr07033f4JL9L006w+chm8X4EYlbGDbIyh9ztYCBKU
         yRFNLZXwVJaLM7NUPEtgNW4lk9qgZTSMVFhMVa4B56gwtC6cuT/t1u6l6eH5iWbI/cSd
         8fWrCqdp2c44I+wxB1MNoxG5uGmkSXCftSViLAMh55pF/Hk6PO1ea23er8+eJNkBgUtH
         FRYwOnWIAc2nkl8pogPrfmMI66mIq4hUpTWAsYdu4MjAjrya9nvs35KAeVlJvkyr3+xS
         Eu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027583; x=1725632383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E28ANgGeyclkwdvrEsGewBjyWcjmIbB2+4duJTvxOC4=;
        b=j6TIejTFko3yl8ldnMWgZm2K4NQQH6QkLEbHkX7dbL5f8YcUoi+WOyo2dcFdY6ueuF
         f5BbeuIrupB2+tsAu85LNIH2Ndl9qpkY0fKRzKjdPZEGDN1xTvH1QROO42F/XmwjJniG
         NaF+Hhmojqjw5C0Nz/t7n4HEUAX7zncR2lk/5faamvOXpLww+WeTW0dugc8SFpIkmBYs
         vVTSTpZTT0XtbkGrNe7biqcJ+2pTBEss/7rQyuv6xt+F9HwDcMvjXfJZ1cbfYJBkXyPI
         as4CI1MeTVwNlvwvcys6goXKsa+Ztlmr+tT9AElXbdsLV+IgkUaUj/bY4/AnPvvTKOkW
         d6bA==
X-Forwarded-Encrypted: i=1; AJvYcCV4UX5fT0Ah/RNZk6XxJmb33gfJDi4dSBrhAxmxcKH+Op9kI1kuNWPbvdVLb6d3FVSj8baOQjJfswSqHWmTT8a6@vger.kernel.org, AJvYcCXLZ6yNYTgQWWNkyZAzgl9UvCwuzL5y/irNtXNCf8129BoRfbbse4cp0kO/lDk1wwOrb0+/xDkFsZd6B/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhYXVb/5jJwF2gEsKti+v9GkttZFBU/OEHgd0aAsTSZa9XIxc
	7slVjeqqmTHWsdH5gnLotJj6qlMHZnj9/QmyeAWKf6u+tiAlJUHm
X-Google-Smtp-Source: AGHT+IEPrI7de3sge5ZBRVxhZHeVGTtMGUTtY3ac6kjqnSITAAGtuNS8BSze+euKi6ssBr8aREq7Cw==
X-Received: by 2002:a05:690c:3386:b0:6ae:ce24:3d5 with SMTP id 00721157ae682-6d40e08366bmr26669877b3.17.1725027582807;
        Fri, 30 Aug 2024 07:19:42 -0700 (PDT)
Received: from localhost (fwdproxy-frc-005.fbsv.net. [2a03:2880:21ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d4485613sm6425717b3.70.2024.08.30.07.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:19:42 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	shuah@kernel.org
Subject: [PATCH v2 2/2] Selftests for niced CPU statistics
Date: Fri, 30 Aug 2024 07:19:39 -0700
Message-ID: <20240830141939.723729-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830141939.723729-1-joshua.hahnjy@gmail.com>
References: <20240830141939.723729-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hahn <joshua.hahn6@gmail.com>

Creates a cgroup with a single nice CPU hog process running.
fork() is called to generate the nice process because un-nicing is
not possible (see man nice(3)). If fork() was not used to generate
the CPU hog, we would run the rest of the cgroup selftest suite as a
nice process.
---
 tools/testing/selftests/cgroup/test_cpu.c | 72 +++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index dad2ed82f3ef..cd5550391f49 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -8,6 +8,7 @@
 #include <pthread.h>
 #include <stdio.h>
 #include <time.h>
+#include <unistd.h>
 
 #include "../kselftest.h"
 #include "cgroup_util.h"
@@ -229,6 +230,76 @@ static int test_cpucg_stats(const char *root)
 	return ret;
 }
 
+/*
+ * Creates a nice process that consumes CPU and checks that the elapsed
+ * usertime in the cgroup is close to the expected time.
+ */
+static int test_cpucg_nice(const char *root)
+{
+	int ret = KSFT_FAIL;
+	int status;
+	long user_usec, nice_usec;
+	long usage_seconds = 2;
+	long expected_nice_usec = usage_seconds * USEC_PER_SEC;
+	char *cpucg;
+	pid_t pid;
+
+	cpucg = cg_name(root, "cpucg_test");
+	if (!cpucg)
+		goto cleanup;
+
+	if (cg_create(cpucg))
+		goto cleanup;
+
+	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
+	nice_usec = cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
+	if (user_usec != 0 || nice_usec != 0)
+		goto cleanup;
+
+	/*
+	 * We fork here to create a new process that can be niced without
+	 * polluting the nice value of other selftests
+	 */
+	pid = fork();
+	if (pid < 0) {
+		goto cleanup;
+	} else if (pid == 0) {
+		struct cpu_hog_func_param param = {
+			.nprocs = 1,
+			.ts = {
+				.tv_sec = usage_seconds,
+				.tv_nsec = 0,
+			},
+			.clock_type = CPU_HOG_CLOCK_PROCESS,
+		};
+
+		/* Try to keep niced CPU usage as constrained to hog_cpu as possible */
+		nice(1);
+		cg_run(cpucg, hog_cpus_timed, (void *)&param);
+		exit(0);
+	} else {
+		waitpid(pid, &status, 0);
+		if (!WIFEXITED(status))
+			goto cleanup;
+
+		user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
+		nice_usec = cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
+		if (nice_usec > user_usec || user_usec <= 0)
+			goto cleanup;
+
+		if (!values_close(nice_usec, expected_nice_usec, 1))
+			goto cleanup;
+
+		ret = KSFT_PASS;
+	}
+
+cleanup:
+	cg_destroy(cpucg);
+	free(cpucg);
+
+	return ret;
+}
+
 static int
 run_cpucg_weight_test(
 		const char *root,
@@ -686,6 +757,7 @@ struct cpucg_test {
 } tests[] = {
 	T(test_cpucg_subtree_control),
 	T(test_cpucg_stats),
+	T(test_cpucg_nice),
 	T(test_cpucg_weight_overprovisioned),
 	T(test_cpucg_weight_underprovisioned),
 	T(test_cpucg_nested_weight_overprovisioned),
-- 
2.43.5


