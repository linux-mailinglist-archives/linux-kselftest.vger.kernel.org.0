Return-Path: <linux-kselftest+bounces-30241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B51A7DA9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95B97A545A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1AF21D3F9;
	Mon,  7 Apr 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7bKih9w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D637DA7F;
	Mon,  7 Apr 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020147; cv=none; b=l/fOOw+A6XZrPawt3R4TQXp//+FExPp+2Dm2pHuiHRYpJv6juItc5ay/GKleA7+U6oSYGltNUfG38zBt2wf2ZvLPORtGikkPofvMCcsAvOagQVAX3UhDuRiwFkE3qV41sxUq8Rqdc79MGfP/I4yq3kfp7mOzCpv6Z+jtz2bkTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020147; c=relaxed/simple;
	bh=cz0sFymjpfC/h77fzceNQsL/NvczhkEObHLXu7XO1kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU4k1B/FZkjpvIp9MhoVLG7YXbXR6FZRxKnTSahXYGt1uJZ7NtHZNJT4fjpDE6CClQhpEupRDf8wLG8i6XCr9qqHCbJt6lGjTrzepazOf3mTbaRGvaaa2QW7KXouWtgSRBj4NVEVnIGQNx1KWy4eNs8TDb19/R4mNwMIRhrG8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7bKih9w; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240b4de12bso53283595ad.2;
        Mon, 07 Apr 2025 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744020145; x=1744624945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsXm6MV5K5BRVbJnpoBwjC4UXp/lFGi2onPtWmwIMd4=;
        b=E7bKih9wB9GqlTpqgpLdAP6R2hTPWqinhTiCoKqCfGGcVZzR+as+9rnM76HIz8K1vk
         oBjypiDEfsQ0hZAvzl/Gf0XaC2p7Y4TP22RPZ9ORurBxlL44Ynqs2rMlXZAUzlD79wes
         THti9atmUmHlAUuc+s0pDv+y+vcNqMVmDs4hkNxRg2HGJ+JV19E9kTgu0QvqKY1+J+ON
         sRgvNmwGFDzpdlhBsoczJdc4NsLUNKSS4YqvQvfMSi7AHqkpKj58Uii2E0rhx5BTsgDt
         5xD1MTAHRN4NOkaon7Uuf32Xz8cJM250C1HtKyRFNwERHx8PX4AK/cLdduJawutCvjsg
         GMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744020145; x=1744624945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsXm6MV5K5BRVbJnpoBwjC4UXp/lFGi2onPtWmwIMd4=;
        b=J+ydsLBTXnoBxdSAnbe32dAPGG8M6L17/FQXyJV5y4QM+HOgyx16uc8n1wmVtXGHAk
         Nw5X1NtrihLM/NV3XnEXEFPz98fZId+FBtSYoCm4TaYbeKfQJdkpXN0dWKpvWXFIjhem
         W5Wo+aV1QyNEL/XGoB+yQ6psfeT/Dg5CQLWJZq+qCQDNcf3kLDeQq0sU3U8ZpVuVLgos
         s9hBJUeIgS1Vv9JO07t5b1pGFmO1myKTKcMJ64m8qDZ1zcM1M0hMQitDd1uTQCyYELct
         mw3vfLr8n5mbg3W8keMMRHydIxV+6v2e64S1O1T+7FMeiMEpLpZtLz6Y5n+CE8idcdPV
         PJFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoAFp6PBP0SECpThR7suYO5uJNc5c9TdkrWs9C+rkr7fq/wiD9A2sbK8HhNxqBr17/ir0=@vger.kernel.org, AJvYcCUyB7A7XUjsfnirx4TQBMtX+CNHMAIalzk6hHLp1XkPATVt/nawnHDs24sQESb9PetPdh97XDIVhVAFlty2VPAN@vger.kernel.org, AJvYcCXF80BFat9kuAIfPvJ1Gph3D7gp4wON8pozghR1M9vPDKTv9yhH1h4Sa4gmQ1fp0vD4HUWWJYz2Fo3TsWDQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtOqX7u7/vZ+jXNiHVTBUgDOFRhwR81Ek/oXOhGZURRdUhoJB
	lgD+jwIcr+oP+ciGHDS/LM4ZWG0RnOBCusRahm2+Qi9F7m7a1KOa
X-Gm-Gg: ASbGncuChG9CvXW73cZi+KWkXNFjrq/+iVDm7aUPmzbM2JUGrjG8WY+INyVHM5QtduG
	cvBg8vZGxjlcMl1D0jpy6yXA43qSSOtrkQxMxPbUsedOkxarCgsttNcCpeRMHnFMvJN2MPtt/3X
	a8nLrZryi7GgCXwzZJ0CIPmv+2vp7pBy9fvK2PtbzGNKjnT1xbeNjfGM38IxHv1bAO9iGsWxAEQ
	CwNX9mFGpHRSDiyrdE7vIQvKyfshA7RqzMuhNqkpmUm/tvFvP8jude2jM79/vB0YSjSr3/HOPNc
	smqulsR5gSQmPHuV5/MMPeh7B2LVBlbANN3HO1J7HAlUXoVR9KJ0TPlSl7bb1cy5RTxrqN+Dqny
	/UaNu7g3VcI5wUkImyfz6AzIaHG8=
X-Google-Smtp-Source: AGHT+IHKvXzsKCjD5FaoB2Koj4MfcM40WxteginhUmUPXspchTARG5Gc585RciLftr+zvxDdSPOxfw==
X-Received: by 2002:a17:902:d489:b0:21f:f3d:d533 with SMTP id d9443c01a7336-22a8a042586mr129525155ad.2.1744020144746;
        Mon, 07 Apr 2025 03:02:24 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785bfe40sm77080215ad.72.2025.04.07.03.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:02:24 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: Malaya Kumar Rout <malayarout91@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH v2] selftests/bpf: close the file descriptor to avoid resource leaks
Date: Mon,  7 Apr 2025 15:31:27 +0530
Message-ID: <20250407100132.439412-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAE2+fR992BprqDXkZTqi3Mgtq9WErSFvOtxvc16ZT9ufiBLNNQ@mail.gmail.com>
References: <CAE2+fR992BprqDXkZTqi3Mgtq9WErSFvOtxvc16ZT9ufiBLNNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static Analyis for bench_htab_mem.c with cppcheck:error
tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
error: Resource leak: fd [resourceLeak]
tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
error: Resource leak: tc [resourceLeak]

fix the issue  by closing the file descriptor (fd & tc) when
read & fgets operation fails.

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
 tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
index 926ee822143e..297e32390cd1 100644
--- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
+++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
@@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 	}
 
 	got = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
 	if (got <= 0) {
 		*value = 0;
 		return;
@@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 	buf[got] = 0;
 
 	*value = strtoull(buf, NULL, 0);
-
-	close(fd);
 }
 
 static void htab_mem_measure(struct bench_res *res)
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 0b9bd1d6f7cc..10a0ab954b8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -37,8 +37,10 @@ configure_stack(void)
 	tc = popen("tc -V", "r");
 	if (CHECK_FAIL(!tc))
 		return false;
-	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
+	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
+		pclose(tc);
 		return false;
+	}
 	if (strstr(tc_version, ", libbpf "))
 		prog = "test_sk_assign_libbpf.bpf.o";
 	else
-- 
2.43.0


