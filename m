Return-Path: <linux-kselftest+bounces-40389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A05B3D7D8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 05:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D993BE5B3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 03:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D909242938;
	Mon,  1 Sep 2025 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN0pmb3s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E02405ED;
	Mon,  1 Sep 2025 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698194; cv=none; b=UQrMb/FpNHfeyAKjsDBMraG0FINudLuIXjUfB3+AoLIJYZY4gzVzzXFajH/GICqB1ek6s+534Fwhsp4oqfUGQrDaC/jQxn6/bVWXeCwcG22osKvWQQcwTF9KBsu0JNLCgxAAL4K9WpTOu4tFHKizQCITmbsJe5I+BFH9eIYwl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698194; c=relaxed/simple;
	bh=i7gSkUCwk/JiIR9BgJ4ibHddNjQt0Axni5e4z5GFIIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLrs2MTdEQRsXPUvnZkf3874UR1ktqBO7X02J0I2YheaPYijJDoXZgpT3flPddKvM1cO/zbWFEg9n7zOFiNeEmPOnVk2jHEID0tk7jeVYKd8ESEIV+rqVqXr9KVimJrq2G0Igb7Le6efCvj85UDTl3ixvFYEqzvVTrgd1F8DBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN0pmb3s; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2445824dc27so34677485ad.3;
        Sun, 31 Aug 2025 20:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756698192; x=1757302992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lC+CeEUwLUwzxr+JN3oMfmOzLQazHlM77TzgOzfoiik=;
        b=iN0pmb3sEChlDyD1UlnX6KKuUQwLHaCS2yO0NXSC9OvAI9OhZx4JD8eMURYGs46dkR
         cj6d+EqRNBdcZC84tWe3ybIuMfBUA2zTjDvcq5XGzRjRgAzxqjC9mtZlxKgcE9/KTlrm
         fgiLp7rfX4N5bdcXewGKqjxuUMhh3xmDZs6LyKBIDHit3ixTMiXM2A2qcYVfAq4FZsVt
         WlFMnYRSb2h8gNvqYQXFXMvKefrAvhk5ijLHgPDCZ/BzvJwDPzQoIvN7LmmGFHbtGESS
         2Lk9wW2JZIhDZS7gOKzLOXpxJb2PaYm5jxXW/I6/d4U24puVyiDpKMRqH3+hZy7qm7cF
         3sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756698192; x=1757302992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lC+CeEUwLUwzxr+JN3oMfmOzLQazHlM77TzgOzfoiik=;
        b=rt5ul1A4hHgVmAJIcJUUFrwyQSYsd0y+EAnMEk0vOZ4GWR7kvlwUhCfrKrmnZKsbpW
         Yi0b8GJAEhWOKi82w40oIvR9x0kPsUBX4HfSDiItCHkzY/KdrVaNiDL+E0bK9A/9SZnN
         seneXvXMRBJdYSkKRo1M3vWDY1gfMDMu58RUpRc+yimb12icGoEu+n3efnsUx1gP9mWK
         /aZcpLxqpzmE2WCblAn2lt2hTgujbWc2qeWU91FdN34Gfi6xVWCVXE1gggTbIj4LpyZJ
         ew72Slx7klS8DRMYzIwSMPUomNA/Ty8CC0LDIbTqrsPX7jbq4shyaehai+6IkW/TW1I0
         Zfyw==
X-Forwarded-Encrypted: i=1; AJvYcCUgBNCUFqj1hW99LnwbbT9iCTBe3oN69UoA16KH8rwSm1JddI9jdK3ZiryqGkeYk93U/4M=@vger.kernel.org, AJvYcCWHI6Fqv2KUjMR/Yu3RSKy9iXBxDlNEI5BNOfr4xT0MGJ0+3Vmjl8ANr0bbU29k85bGaiHMfPbc84fxZ7+k@vger.kernel.org, AJvYcCWtGn6Woqc2smg6muvEx0ABLtFRK+eo0u8DvWHqWNVlaOapfN18MHF7TV9fRGjKwwJpatbwdQ02cKyUkWPJXxxS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/9mKv4d7pW/Bdcp9dcuC9L2bFS+bAbWBdgbJr31AaWiZuhZ0
	akv1SPfxsczooSif+CINCMb8H2h9p0KWYcXNgbTq1SlB41AX1Q18OdVA
X-Gm-Gg: ASbGncvyvVzc5mpOW4k5MCXXUHBlrTRr5y7cBr+VDAoNYaCXu4Ypml5Z07mZWNuh6JV
	5jXMDU3UGaRpSXzDiVeWpG6Illz1ZvpbnYTsIqfk7Tk2SWKHhu4c1GuHzDB+M/xYCFUv4t1aWNH
	W0dUUML7B5wnD7xd+PAfJiMfQMuCcqmuDU4wk7rSZrnJ4icdJL/Il6vyqDp1l8FaTXytZbTE0I8
	Vgz/1C+jFevAwAOmaIaLtbto7KAJXmW8zkVGpB2fAEBsDqYslcOK8HnL7WRz1W0f1TgCzrrzD8W
	VVbu5XkZ9GM/wA02pGVoZEEdULUh6MJQ6v5gWy6MLKM9CUYtMbHjvD9qGAz55ue0UVIQE+L+UdM
	RRiSKoo8Amnd9tWmzrrGUPkVo2Ck2IH1qZA==
X-Google-Smtp-Source: AGHT+IGblknEv+mLfyYEXLt/vYhI9xwIFFuVT8EX7Gy7xcaIakUVhjJiOVP/FRs+P9qIqyPFBVqCtw==
X-Received: by 2002:a17:903:2302:b0:24a:aca0:7cfd with SMTP id d9443c01a7336-24aaca081f9mr56380085ad.18.1756698192032;
        Sun, 31 Aug 2025 20:43:12 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067de9f1sm88398265ad.151.2025.08.31.20.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 20:43:11 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	olsajiri@gmail.com
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
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: skip recursive functions for kprobe_multi
Date: Mon,  1 Sep 2025 11:42:51 +0800
Message-ID: <20250901034252.26121-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901034252.26121-1-dongml2@chinatelecom.cn>
References: <20250901034252.26121-1-dongml2@chinatelecom.cn>
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


