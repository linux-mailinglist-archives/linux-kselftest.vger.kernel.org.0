Return-Path: <linux-kselftest+bounces-18225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF01897ED1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D1B221B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD671A01D5;
	Mon, 23 Sep 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7uFLusb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70BD19FA98;
	Mon, 23 Sep 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101212; cv=none; b=sf8eu0MSGKh/XXph9CMkABLaWeThAz4JfSer642RfAgnTSeJKd0UzOXcnSD1GOGRnMGLoFdjGk46+LEIDv6SvutuhnjbLRQf47RCzb7Si32+KaOCnC34rKuqF6qv33elFSNUPD7EAyUkbqFd9QTYpkqtavF7+pH9EgKEipWwlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101212; c=relaxed/simple;
	bh=MrQdDdz0prrU43B4mtveKu0KTjaLjHkKON06RVGWtnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tulHyIE7pyRqZvvTMTEmpRdIOrIDILrRH53KXq++H4JI9IIxJ2RgA/bTDKf2D0k10w9+ctfJ+H6uxnXYl4PmLtVTvJEWI2S/hs7tjTHbiL42DLq5DovGCN0+KvYxqqMno55zlRoKVhMUk7sDpwAXeNxlJOPMja4MLdj50OHRuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7uFLusb; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d5893cd721so34733147b3.0;
        Mon, 23 Sep 2024 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727101210; x=1727706010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXSHKUklsmtE4dkxo0RabMltSbqgDxtpvJEt6KplT6Q=;
        b=Y7uFLusbMQfS2uVPnl79GCbGUMeR3KILBlC3zfs96cypbQeCpWIjbYbC0ctb04Ewhr
         1fObImoUdzWkGbFQ9p0QpCbXBi51U08Ko5BK1pGNyYqCOku2gXMMcM91ji7L8Z2BEpQg
         Ts2KjysghNrCtH0srucFNjZyUm3yroHZ4heJbydpDERM30VNNKoqMGnG3NVRB8ak5EI2
         1J8GCE++hyaAFW3tXdjHzLdKQHhHANI2UyXnuuxIjZuaIOuMFznVdczAnfZUEchrjvoa
         a5w+7Gm8FSa47GLGZwiYPfDyOUVRcqBqDe/su/ZGcsjUAOvQ5fWkmLfP80asHy0LT61r
         sEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727101210; x=1727706010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXSHKUklsmtE4dkxo0RabMltSbqgDxtpvJEt6KplT6Q=;
        b=j7ccYZVh4LDzbMvJI93T7ZQLDrL306+XSublSHQbQf8T/jhSl0s/8JsDl3nusIwEPg
         sbl7lbmBsJp+9DY7iCz8nL1geiq41P7WdIyzp3+vTks1B4E2Hb0vMXH/Ro8Sg2yDZlEG
         d4PvCsSpYUFkfbJ5DfXpVvS3I3mQ4gB43T0tWceVFPFhFKpw/q65GOrHZOtaLudAF7A8
         VlAY+haZKF+F2Qbj+f6F+T1exuzgcQHRiFnKmQdUja49SojdSIsLcTRU9bJxFetFUr2N
         9dl9XJ+hgrqhFNDEoi/S1uH+EnNnvKWznMDPdAObetyRRFUAvw2kzY+SgwCDNwJ78Ckb
         0iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1N9c8ioU3tRuk8f2vTEPEqirC7Ccl4sfJn4eel3g9E5obBpTBGQ6e/4LlRK8q/iHhoS7zRL5/VsdSjDw=@vger.kernel.org, AJvYcCWI7uPZRg6VTOeAaFmBX4ZcCHCnbzeDSsOes92GmlKAsca5E1ylbVenmDyeP2BezuFeCG6GEKN61pMLt24hRrsp@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFtm7EdCYbpY5hyR123G4wbrpkYZ6hRWIdMEUQwZXWN1nrg2s
	qscJBjtYbcTX0AUMgvNeCk+DOERZ8ZsLlsrDcvcg5qdYxGAswXWo
X-Google-Smtp-Source: AGHT+IH8aUIySqWT/FxzJQ+MJvGO6uFfncTFDtk+a6zgmeLzpcXAdZUl356rzZr8VY/UEAGq1i+9pA==
X-Received: by 2002:a05:690c:1d:b0:6be:92c7:a27e with SMTP id 00721157ae682-6dfeeec5870mr84330237b3.28.1727101209885;
        Mon, 23 Sep 2024 07:20:09 -0700 (PDT)
Received: from localhost (fwdproxy-frc-000.fbsv.net. [2a03:2880:21ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ddfa73bcacsm19150527b3.11.2024.09.23.07.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:20:09 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	shuah@kernel.org
Subject: [PATCH v3 2/2] cgroup/rstat: Selftests for niced CPU statistics
Date: Mon, 23 Sep 2024 07:20:06 -0700
Message-ID: <20240923142006.3592304-3-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
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


