Return-Path: <linux-kselftest+bounces-39925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919DB35657
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 10:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E41E244160
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473FD2F83AB;
	Tue, 26 Aug 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJiaaXXf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB402F7468;
	Tue, 26 Aug 2025 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195494; cv=none; b=oCVUkuirUb6TahOiFvwq51rOGz/DVbz0kxxNClr3SwvKDt7h4vl4WlAwufJBvIHOHNZ7zXJwX7zvQmOi9XQT7hjczt/QavsJ/TRF7ersCbbYSThbUTSxcbmTMHq82UErJfGl7/JECjrvFjgV7yd6Y2+Hjc6jbp57hka9i4BiI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195494; c=relaxed/simple;
	bh=i7gSkUCwk/JiIR9BgJ4ibHddNjQt0Axni5e4z5GFIIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXCQ5gGn1VVVFwIxnOcrUONVfOMRoGr15WXKTePGanMOIu6fEEQ6M81UnnVq/CiIxR+/KZJC4ffzx1VUWfI0rDN9SWq0MoSU4gKDoO26fyJksUBbEurw/R0r98hJV2b6qyyKyXXFGHiKefsXnGdqDT5pAmUSADRe4SdpwZCC9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJiaaXXf; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b4c1ed55930so1743321a12.1;
        Tue, 26 Aug 2025 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756195492; x=1756800292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lC+CeEUwLUwzxr+JN3oMfmOzLQazHlM77TzgOzfoiik=;
        b=mJiaaXXf0YMXtzdFNd+Lb5TPQ1vjEMO7ogo+CRIA+KyzetosO7hewp12C6dZZN53Wa
         fizvDVUn6aP1CqbZLlCrwzUnn+J32mYFfg+ztB5eqAkeJuuNXSCfNKPIdJPIXedOXdvS
         BhQqyp100SuTsgoX/23mzeOGN7iD44GYi4bBxVUncAC8yqRQm2i38hD/oKQ78LiR0MP2
         kf7gCBLzwRHGFS2Mxlwbvzqr9ijPEgpA8vkO/YVSktfCqZ7fi0aV7LZYoSag3nAXBS3N
         mOu15F31zWAGY2q4MRkyCdG4eXs66H4cUxKosxxF4aX0ha3kcxxTZCUXmrqRBbxt+AvQ
         BI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756195492; x=1756800292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lC+CeEUwLUwzxr+JN3oMfmOzLQazHlM77TzgOzfoiik=;
        b=kKPDx9m1LwCM/FaCfSaagsl6gu7an/brhQd9wXFdQvvUJv9iHB+PNZPp48+pgU3INF
         sjycP4UIg8ft7zw3qWAdzXYxiwlEffIle+gg8AtKdY8fZVN6I2KjGLXg5J/ztFuzC53b
         23rkL+5Z1jL3YXayrYxNPPC36qd9AO6+1224si+39HdBItH8q9KDT3r2yhm3/eU7+5bK
         waneQ4yoP29jBoR7r58D4Ec1/S16sRMN/8c0Ym3jpLN4sHI0yeFz8by1GFseJGdeFYEr
         jGI0LyMlhRAV270/aK1SE47oh60NP7nO17W/Wh61krVFIo3EmX4W5yZjEzM1EDdxTynU
         EGmg==
X-Forwarded-Encrypted: i=1; AJvYcCUEybLp6K6vkSMllY6o9ZJBIn8hsiskdsja0J2CEMbgfz7pk7nv9KvU4CIFM6AJsKoL+QG2CTnBZJRQ6FF0JFFK@vger.kernel.org, AJvYcCUR5027Tq/03sdEUVfjqvHWHCvT1TUtCk3piqyQBZDxTrxnEntgSHhQGFBTCHEN0npU+tFWN4L5ZIoV5UwG@vger.kernel.org, AJvYcCWCQY93pMci4UprdVcOtZ2rJHBm6J0SRnZ1jzVnXdmTq/HNWLA4aMVA5AyzKKBNpSSO+N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbfU4p6lEFRXS9vlrXdQVhAvAoGHnHjf4qaQ25kuDCB0iWay4c
	MSM+xRN/jInzgMHAzUJDUBAxjEQcktk5Xw3eJG/HwVmsPkslBHPJgXpr
X-Gm-Gg: ASbGncvVC1xIjlzJyTf/iv9R3uGCT5lNCGkz/7yjGLIfLXqmyvKzMymD6Ez9invCg0U
	dVsof0vCdSMcQ10qOpgKx0RF9LQB7KgRfeot9mFseBD8SErUY3BbeCpX1/rp2VQ1XrGkkj6NfBY
	FII5mlqEsD7BbaaXD/Jj/m875X+UWx1PbG5O64V8oRrIcZRnYIj9CodpeOWUD4sGir8joHnM7q+
	YqCsIkYpN1VecbueQaB4yG8OceZSL9AK5XVLTZJA1ARMezsx4KMEKPQCSgTjNEADZeRHV4WS02w
	EuJ5CUc8WO5F0TcZfdSjSowVLGnZEp6wv6plPy9/fAd4cJ5H7YiYCPeNov0EI7Pa2gA67HkY9wF
	6ZuPUeP7TwfeyJqeh2jT2sHg=
X-Google-Smtp-Source: AGHT+IECHXxlkLyrW9UP4jp/pq1qMKMifzPzvVUyPBfO10cmuZRkxMkCsFxvNvfln9a6joOVIVAy3g==
X-Received: by 2002:a17:903:2441:b0:240:2145:e53b with SMTP id d9443c01a7336-2462edabd75mr139402385ad.9.1756195491793;
        Tue, 26 Aug 2025 01:04:51 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466888037fsm88829485ad.125.2025.08.26.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:04:50 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yikai.lin@vivo.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: skip recursive functions for kprobe_multi
Date: Tue, 26 Aug 2025 16:04:29 +0800
Message-ID: <20250826080430.79043-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826080430.79043-1-dongml2@chinatelecom.cn>
References: <20250826080430.79043-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions is recursive for the kprobe_multi and impact the benchmark
results. So just skip them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- introduce trace_blacklist instead of copy-pasting strcmp
---
 tools/testing/selftests/bpf/trace_helpers.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index d24baf244d1f..9577979bd84d 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -19,6 +19,7 @@
 #include <gelf.h>
 #include "bpf/hashmap.h"
 #include "bpf/libbpf_internal.h"
+#include "bpf_util.h"
 
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
@@ -540,8 +541,20 @@ static bool is_invalid_entry(char *buf, bool kernel)
 	return false;
 }
 
+static const char * const trace_blacklist[] = {
+	"migrate_disable",
+	"migrate_enable",
+	"rcu_read_unlock_strict",
+	"preempt_count_add",
+	"preempt_count_sub",
+	"__rcu_read_lock",
+	"__rcu_read_unlock",
+};
+
 static bool skip_entry(char *name)
 {
+	int i;
+
 	/*
 	 * We attach to almost all kernel functions and some of them
 	 * will cause 'suspicious RCU usage' when fprobe is attached
@@ -559,6 +572,12 @@ static bool skip_entry(char *name)
 	if (!strncmp(name, "__ftrace_invalid_address__",
 		     sizeof("__ftrace_invalid_address__") - 1))
 		return true;
+
+	for (i = 0; i < ARRAY_SIZE(trace_blacklist); i++) {
+		if (!strcmp(name, trace_blacklist[i]))
+			return true;
+	}
+
 	return false;
 }
 
-- 
2.51.0


