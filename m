Return-Path: <linux-kselftest+bounces-40723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF25B42F73
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 04:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8285E566319
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791D225390;
	Thu,  4 Sep 2025 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+jnR7lp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456E1FBEB0;
	Thu,  4 Sep 2025 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951835; cv=none; b=EF8lwyj1T5vqu9tz9ziMfMT4IAj0WBdqeFGX+OFLj6ztNWzGbvORpIifEAk5E63eSsL2SXPKk2UqvJ0i0l9zqlQKgMaK4dv2ZEAOUussEXMXZDrz3bqPQFaJPkaGYzEC6wi0SspMB1ygX/ImeHotAusmDrfqLCVPCNzrrcpAMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951835; c=relaxed/simple;
	bh=i7gSkUCwk/JiIR9BgJ4ibHddNjQt0Axni5e4z5GFIIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7mbe6zddj6ipWGs0bXFWOBOhrtxFI67o4sLA4RCfzO5gokJq7MXTjGyxjDIw7xOGT5Nj6ZDgfBb3nieO00hYAdNJaugyVWbp4wyRCpDBWCsacxjn+Ajo2ufFZv1MBvq3Mno6de660vIE4ojsZaPPaR1Dys+RcWXY8+C+9c4HPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+jnR7lp; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-772679eb358so520871b3a.1;
        Wed, 03 Sep 2025 19:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756951832; x=1757556632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lC+CeEUwLUwzxr+JN3oMfmOzLQazHlM77TzgOzfoiik=;
        b=a+jnR7lpvJpN82Xh2MCy+GjwNpZs5MbbgWVT3nBefw9Imk0kb/Usn5soXKpcfzD4QZ
         LKdKCV/AfSSiSjLjuTbAJ1o34zeG6DEyyjztAYiGUuObNmQ8oNtE1lZ8htLiIBBGbYfY
         RCVoAXoqdZWk/BApW2OggWXtYWTs/zBD2KyzG3niLxbqUb5iKYH6eRzDs4eDqQAglgdy
         uWZYLpjVT+jIUvQW+zhxiSvMrDfbZi/gYQ6NpMu79mfakSBp/TXwEiL4fnfMSzcqqhw3
         ejVpe+vYUo1ewz1NW/o7L+41+KPo7ngdP6JXQ/rUKgDpwDCCnfsrY2kJ/JWVLQ/ft+RQ
         b/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756951832; x=1757556632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lC+CeEUwLUwzxr+JN3oMfmOzLQazHlM77TzgOzfoiik=;
        b=FNWvhH5VeCW5VLEcvJ8CxpjCDyXZuhp8vwabA+27b/9uXuRfDPoKbrrUp2yJKvn2kb
         MUPz4Aqkd9AJ1Yuv5favjyyu7iXcgDTaZX06eg0MH4qigDnebzBedTkYpnj1T/Xo64Oy
         Qw3yoIUerYQsl8MQ1AfzXU1aP+axThu4l8BWz/3KQRHf0T4czKdWVOHFc0AUTHIMGVN3
         UFhPo5LsJ+KQfCgt6n48Nl2KAyVC8vT5M9gBbtImOU/L/aZ6U3Go/yKkSDEbftYzDgHP
         3Syubk318WAxhx+WQTImeHF0jR1Y16lc0zHFznCmjnXQr2yjrpBk0XGJA4UVC2K+b+U4
         KW0g==
X-Forwarded-Encrypted: i=1; AJvYcCU9T9wyF22I2PjVLUu1W6ulwzXsOltB02teQcQUu2eG0RIpNxet2L6uENVfc1L7bk8kX6U=@vger.kernel.org, AJvYcCUWV6MELlLjRQAx4qEvc8j+UsZoMg7OjmKM7rvutXTgsprDpRgC3BM252yBG3/E1SeWHsepyUsVG/AjUw6VKm2A@vger.kernel.org, AJvYcCVQD1kGCtj9CnYoxpFmkc2Ipei9lK2li1kv1On223qRKRc5eLi2y6xzIMT4wY3bnmWJegV3wkjryKr6fIz+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rP5/NzSfYajmwqMmHtagoG1fG1G6s4N/qnLXVq1eXMr9zTTZ
	922m/qZCSfcEZ0CCB/dqjKy208Bx+vafHnDZreCFYS9JzSLCygZjYP4/
X-Gm-Gg: ASbGnctFRsMzWIf+uJ/39iNsOOFtoKKSqwWP+UP0AeH4/1OC6v4Fo2R3lfoUqVSSmJU
	2S4c1hf1kqHa8LMMwafxyYO/iuweBNLw30j/2jxBA2ea6kOv9mskVAIfB62iRmfKiaFwNqeTh3F
	hwvQd19vvKCtxqJM0PPzpdWm5qFK1jBPY6EmYT38jq/U++rWc3hVh3A65wbnUlL3i/jvhlBKhQU
	MzA5IGv7bhR0tj//P+/uEivv4151Mk9fAgFmnav1/Qta8CKysQkPdu8gTPisHtKHkTwIGPUnkof
	0Ivap6+H7wKUSGiL3p2R6dxkUeYGsOsarldle1O4si8TbVGomQ7VHMJdPeuvUm6EL/5Wso7CObY
	cs0DdR7toDf4zE4pwsqEBPZ8=
X-Google-Smtp-Source: AGHT+IF3ScfQbgDCiAv09yjVDPwtLzoepZSQLLNcHdW+Ob8ALMBcNMdFHHoCFUYQeXhdVgf7MwXmlQ==
X-Received: by 2002:a05:6a20:3c8e:b0:23f:f712:411c with SMTP id adf61e73a8af0-243d6f02f4cmr26926525637.36.1756951832353;
        Wed, 03 Sep 2025 19:10:32 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727822817asm5143014b3a.98.2025.09.03.19.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:10:32 -0700 (PDT)
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
Subject: [PATCH RESEND bpf-next v3 2/3] selftests/bpf: skip recursive functions for kprobe_multi
Date: Thu,  4 Sep 2025 10:10:10 +0800
Message-ID: <20250904021011.14069-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904021011.14069-1-dongml2@chinatelecom.cn>
References: <20250904021011.14069-1-dongml2@chinatelecom.cn>
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


