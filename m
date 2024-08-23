Return-Path: <linux-kselftest+bounces-16183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B29595D7AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 22:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5735828553A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509121A2C05;
	Fri, 23 Aug 2024 20:13:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35F1A2542;
	Fri, 23 Aug 2024 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444003; cv=none; b=u5ecDM/jJqJDxDIubOGYDe5V3eDLp7vauvOp5I8fHvm3f38kHXSj2w1/EPzaKnyLkqbVkv+LN3M+lGdEEPVrFBRe0Hfq0PCpluMoscXAN4NHVv4RdsD+18acxIF6Fhsmz3SBC7N0OdODDUVLCHU2/5NITwEw/Tl2Ww8jFYDaNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444003; c=relaxed/simple;
	bh=0ZWXXcdMHQD7yQhOFHjj1ApmLTmEwbfaGpySJmAc0GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cm01Dq5iZQwrN1NeWH+8CwmCO9zrpeTiC75rAk05ysK9fdVGBxjnskirtStbKZDQdRgOGPO7pKCt6HbdKqmcK537dKhn+KmMCG+ZsFhCnUn+lqz2DyqSblNlpgbZcvFqhoPyc2/TlPO6Ikm8aH6pG8P0cGOHwF0kf6DbTjMczIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e162df8bab4so2255228276.0;
        Fri, 23 Aug 2024 13:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444000; x=1725048800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E28ANgGeyclkwdvrEsGewBjyWcjmIbB2+4duJTvxOC4=;
        b=B73mokvCa7dirUsYGe1xTyo2uWv5Q8iylEv/ERrjLXGJD9AKlGf3vslzc2GyR9TnzW
         QrhQdqSJy/Agy9nP4NayJuTVvKa+rx57KF4izdVfn1imzNzcL74xS6LtdsQqyuAHOgVO
         hGnpw3tX9/zQLVY5swU81RUhYNia6nue7oMAfLQTnqKpTJKplyXtdUt7WlPoRopYLXyY
         Mb53lBui0XNsxZtadonsRfIL+2RPPl4E1tDopY3fAQziUcU4rBbaB81qN5ZzFRbzscdw
         l5bDfUhwqjIvrogEPp2eZ4IxdyYVW8u0FlMH4Dk1taWJq2fx+j4XVWtU/q05oh//xRj+
         dyfw==
X-Forwarded-Encrypted: i=1; AJvYcCVHjwygxIiZPF565fZedLTF+xgEfnzc8RvPJHwNjQkQxW9tKLapiWNNK8ssVC/CczGj3wgu6v5AuM9nNNZfk99y@vger.kernel.org, AJvYcCWInrvk2Y5pusyhKO0mMzkLpChzebzH05Jan20AB0gJHquIDLN7oh/AMd2GGVtesnJJXb6a6q/1@vger.kernel.org, AJvYcCXN1+BqxABsKNZpl888l4XEsNfjz4VejN/0nQl2p5HR7XkUMNJIUL/R9tuSfgjCy1f6pOS0Di2lnqs7Fhgk@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkIa3PHSBJr/9okfcGW6Ja66zm3ryL1l7olTrwAnvU3Em+j4G
	EFExodHB1wk+EL5BCDeAKKaSEUyrVuRPMrgPZ58sqr10rK0pzKqC
X-Google-Smtp-Source: AGHT+IGRQdVgD+Z0XXzEDRPlmEXjVlDzfPqGLxw1CLnmBdevSGwx+4jtlizhbK6M3KfDcg/kNNj2ww==
X-Received: by 2002:a05:6902:2610:b0:e0b:2b6c:3cc with SMTP id 3f1490d57ef6-e17a868a7a4mr3678281276.51.1724444000416;
        Fri, 23 Aug 2024 13:13:20 -0700 (PDT)
Received: from localhost (fwdproxy-frc-020.fbsv.net. [2a03:2880:21ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e56a5f7sm812073276.44.2024.08.23.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:13:19 -0700 (PDT)
From: Joshua@web.codeaurora.org, Hahn@web.codeaurora.org,
	joshua.hahn6@gmail.com
To: tj@kernel.org
Cc: lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] Selftests for niced CPU statistics
Date: Fri, 23 Aug 2024 13:05:18 -0700
Message-ID: <20240823201317.156379-3-joshua.hahn6@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823201317.156379-1-joshua.hahn6@gmail.com>
References: <20240823201317.156379-1-joshua.hahn6@gmail.com>
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


