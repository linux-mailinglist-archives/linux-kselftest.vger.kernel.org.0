Return-Path: <linux-kselftest+bounces-18923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A298E2CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 20:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BD02832AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8F2141CD;
	Wed,  2 Oct 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9xbvJP7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831012C54D;
	Wed,  2 Oct 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894843; cv=none; b=q2uWz3n4O6JVzgJdzmw21IwoGjPoSOIJKZJR1RkQtep2lp/8YdFQveuXZ2w0WfaUsarLybRAiR+seBgVB89vFfnipj/0Mngn4Egu+0gXuW9nOQeh/8GQt0l9PfIoBmT8DgKzhdfkR7U3PWToVGWtY1MDgNzQ9UTftDwbZwY2xuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894843; c=relaxed/simple;
	bh=YsSQ0UZQ42+HsQOmvt431Xeo+OAAE9Nt2Ug+vGbteyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpoDbj/zzTviLGTLNO/I2PrjmDzhfZyoUwBV/T0YQJHxOjQt0Ac5cc5iSpr26A3S0wWhAVjLj5MgqveZI1ExrHUoXfVoaPqQfAM6ZOB8EO5tMiV7l/YVodUAMxyq7A8WwBrArnkUVQDbg4X2l2bVAVdmfd6WZD1F6Es5ZnW0Vog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9xbvJP7; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e25c5ed057dso113400276.3;
        Wed, 02 Oct 2024 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727894841; x=1728499641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laEBf5vHi4hjshp/PRiToF+zF79bzXAlmMUWVmfjsT4=;
        b=X9xbvJP7O3HpYjDyTwTsl3y4rrR/Jl6y+WiVFSyxAsaZW4z5ez4y6/lL5MabGpLIeO
         DYFNClpc1jyEa1sb53oeXBjS7DlydIV1ePM30M2LpFGDEJZlfoVudZdcOmizOf27GlAx
         KUOmF/l4r2uBj3daUtQAOxaCyWeJbpXzJ17US0IIiUdU7TOXO2khfY8fT/8McHOJJcge
         sK9qVYYJcDnU1hCICYfz/eidV52debishN9EdE9RaC6dlMMXmKV63f8Z2H7KAGJHGARb
         1O57sko+nM1mdM6RO5vgQ6KOJZQPFmb7k6I9bm1p29m29cRAxxcPFbtKY25f/upyrTbx
         7NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894841; x=1728499641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laEBf5vHi4hjshp/PRiToF+zF79bzXAlmMUWVmfjsT4=;
        b=bdWWUQlyDkcbXGjO25yC9ViiF5kTBxHqIuHAj8OCNf2z10Ugn37PVQGjjsHmlV+gWb
         fvk3Ikujm0vMmWnN8tnU4TtQCzeJI+KgJy/5Ncsj8j0EM+5NoOTdFTh+oXHBfNKN0OS7
         WqlcXCTCBaoeVIJj8EwaHG1dabQYGHF8S/DD7fWaAltspjHrWK2GaS2QShcaJjYbTjiN
         nFRKLAQObJeYCjjBKAt5VpfUVakY3z3a831AF/Dg0bhlvbj/i86x6OEZRulseitXMqpH
         xJkeGMmlXHFOml5oXmQfcVe7Yug2ZENyvyS2McM7BSwFyPR+J54dvd72n2T5wGDvhJ1o
         bnPA==
X-Forwarded-Encrypted: i=1; AJvYcCXyJNBHnPITvQPPqsSiaSlAdZesckCaTer4PPUSr/s16ZnjJHqhTh9u5Xp3pF7+ZQ5VxzHim3/LrA7ZwLuM8L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZjUHZSFuZdpmZXpE1xTmQbaLEwkiP2sfevhMEdNKeRNmSioa
	PO1tvD4IaJTCEmoREmaN9gDWU/4YRKuzayP2rv8ulit0Ex9sIGCp
X-Google-Smtp-Source: AGHT+IFJ8hiGGrPFp1iTyqBASD6gCwMssBsiTgaftDz/GFSoMPb39u+qjfORwViKZyR/T1WN8nhYrw==
X-Received: by 2002:a05:690c:3006:b0:6d5:7b2f:60a0 with SMTP id 00721157ae682-6e2a306e1afmr30904847b3.34.1727894841136;
        Wed, 02 Oct 2024 11:47:21 -0700 (PDT)
Received: from localhost (fwdproxy-frc-002.fbsv.net. [2a03:2880:21ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2453981b0sm25664737b3.130.2024.10.02.11.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:47:20 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	shuah@kernel.org
Subject: [PATCH v4 2/2] cgroup/rstat: Selftests for niced CPU statistics
Date: Wed,  2 Oct 2024 11:47:17 -0700
Message-ID: <20241002184717.153302-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002184717.153302-1-joshua.hahnjy@gmail.com>
References: <20241002184717.153302-1-joshua.hahnjy@gmail.com>
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

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index dad2ed82f3ef..201ce14cb422 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -8,6 +8,7 @@
 #include <pthread.h>
 #include <stdio.h>
 #include <time.h>
+#include <unistd.h>
 
 #include "../kselftest.h"
 #include "cgroup_util.h"
@@ -229,6 +230,79 @@ static int test_cpucg_stats(const char *root)
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
+	if (nice_usec == -1)
+		ret = KSFT_SKIP;
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
+		char buf[64];
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (cg_write(cpucg, "cgroup.procs", buf))
+			goto cleanup;
+
+		/* Try to keep niced CPU usage as constrained to hog_cpu as possible */
+		nice(1);
+		hog_cpus_timed(cpucg, param);
+		exit(0);
+	} else {
+		waitpid(pid, &status, 0);
+		if (!WIFEXITED(status))
+			goto cleanup;
+
+		user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
+		nice_usec = cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
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
@@ -686,6 +760,7 @@ struct cpucg_test {
 } tests[] = {
 	T(test_cpucg_subtree_control),
 	T(test_cpucg_stats),
+	T(test_cpucg_nice),
 	T(test_cpucg_weight_overprovisioned),
 	T(test_cpucg_weight_underprovisioned),
 	T(test_cpucg_nested_weight_overprovisioned),
-- 
2.43.5


