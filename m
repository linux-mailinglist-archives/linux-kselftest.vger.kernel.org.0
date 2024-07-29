Return-Path: <linux-kselftest+bounces-14376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A017493F100
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D58284792
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FCC13F43E;
	Mon, 29 Jul 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guJPp+3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9DC139568;
	Mon, 29 Jul 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245123; cv=none; b=ckyqzDds7TlyJ/zRHc+VQQjOA+5uQCwjKbWRtTSvDbzxbGpG03kVCpCEX+G1KXwifd2k4B6gMbviNb8xcgZrPzF5zsqVmAg6yOWGHkMl4vK0nkD84oB4d8SiUmi4NLxzYyw7nx3jtt9v/QaO1t/tGrX3lO9Cm8C91QMZ4PLGCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245123; c=relaxed/simple;
	bh=S4CH8iGlwN8+2X01xU5p4ifa0Xxtjty5cyPwjOQSZb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOl6iRaHk7KRq8xZ9f8AEuQrLtuMDXLznpV0UG57t6c0fYaCMs4xD5V+KoV4PQ2XBgHMU1LXwrgYnhfMBCZM4NU2+71Is3LhLCQghArQxo1nGdE9bKT8oHWUmxYY5/aBeessTfaVrYtiBE9vdF4nJRkoSz6fN17Z4+vYLEEjAzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guJPp+3w; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd9e70b592so15841475ad.3;
        Mon, 29 Jul 2024 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245121; x=1722849921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97RFtqxKV1tDanXoh3iDjlFW9B65/Wlhvry0/woasgU=;
        b=guJPp+3wKsvXJbTulYrtbwoo09Xly1kZSwsUYjkH4uOHdsvormO9Rw+2uZar7DXYGL
         5ZI+JaBlOoNDY1FZNPUE88DOiT87OnYGND1xi5CGLc0qFHO11mo0mI0LJ+1aLS0guLB6
         NPQBXhNfiNbLJukLvx8Z9mlRU6OA/csM8Fab5LdwccVte78e7dRn9bEfyBDUqdZqUuMI
         qGf4jOqKZLVuqrTNwyCoiY01zYX8yoT2YBo2zeeY8LeJLFzbgwl/h1V2rDsoCizXPUOb
         ErumQw+mymx56D4pCKr+NceG8hTZW4Aow0Xcz7Aw4NeZ5quktkjBtLhHWY+YthSBE+Ns
         bTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245121; x=1722849921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97RFtqxKV1tDanXoh3iDjlFW9B65/Wlhvry0/woasgU=;
        b=hCMbIfPAgE7ay5cp83zlaEamGQcsmuSzSTTU7EUrkQWjROzx7LU8Hj6gqm9r/QAqJr
         M+pUMxRga2xDUxHDj7OhRlgr9WgkQL6VjwoF30uh/UPlpTzMdoGx1V2J+wuiIr+5ZOZH
         nDKG5oSlQH4af0+buWNzTrDbgaYmaH8TGRdknUvHEpMCipFB5WwtXLkR5ozyQFM00P73
         FxGH0FwbwHhcxdx2xfSFE8gUspypYRWzTOvQcZFcs/6LLLvN3iCGdRLeorxTvjo121bb
         VoKpvxwohPaFfQyhUl7mCwiV8hrQAyEVYBbfgPouMT+vudYei8kZtePWTHTgkfOHCxpk
         GVYw==
X-Forwarded-Encrypted: i=1; AJvYcCUxCaOQEmwe06qWrxwABM82R6NIhlGWUA27fqTovI36PX7uuA9bZJmG6ODII1Qrvdilxiwjd+NKvvHG/ZTlh4UU+EQHmWcmw9Ch9tmKTTQpS3xgE5PzO6oLL38fQhMzXmS+YrLbIu4N
X-Gm-Message-State: AOJu0YwLaXD+31Xh2WFNWUWWWflzs5UAtLOkNuKqajX2ycRpckJMBBw3
	TjctHric2OVHISWAr6xzHUcB/x/rUcgpxevDKyjfsXutjKNUmn+l/U1kv2Dy
X-Google-Smtp-Source: AGHT+IHp+J1QWRbn/WpF8YMiUiaSgf0ZS8cTUL9W412rawZYWAluLxNaQC6rABvsWFOvil0bWZuJ4w==
X-Received: by 2002:a17:902:c40e:b0:1fb:8797:befb with SMTP id d9443c01a7336-1ff047dd2edmr50976205ad.35.1722245121227;
        Mon, 29 Jul 2024 02:25:21 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c19dsm78119145ad.54.2024.07.29.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:25:20 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v2 6/8] selftests/bpf: Fix compile if backtrace support missing in libc
Date: Mon, 29 Jul 2024 02:24:22 -0700
Message-Id: <aa6dc8e23710cb457b278039d0081de7e7b4847d.1722244708.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722244708.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com> <cover.1722244708.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include GNU <execinfo.h> header only with glibc and provide weak, stubbed
backtrace functions as a fallback in test_progs.c. This allows for non-GNU
replacements while avoiding compile errors (e.g. with musl libc) like:

  test_progs.c:13:10: fatal error: execinfo.h: No such file or directory
     13 | #include <execinfo.h> /* backtrace */
        |          ^~~~~~~~~~~~
  test_progs.c: In function 'crash_handler':
  test_progs.c:1034:14: error: implicit declaration of function 'backtrace' [-Werror=implicit-function-declaration]
   1034 |         sz = backtrace(bt, ARRAY_SIZE(bt));
        |              ^~~~~~~~~
  test_progs.c:1045:9: error: implicit declaration of function 'backtrace_symbols_fd' [-Werror=implicit-function-declaration]
   1045 |         backtrace_symbols_fd(bt, sz, STDERR_FILENO);
        |         ^~~~~~~~~~~~~~~~~~~~

Fixes: 9fb156bb82a3 ("selftests/bpf: Print backtrace on SIGSEGV in test_progs")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 60c5ec0f6abf..d5d0cb4eb197 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -10,7 +10,6 @@
 #include <sched.h>
 #include <signal.h>
 #include <string.h>
-#include <execinfo.h> /* backtrace */
 #include <sys/sysinfo.h> /* get_nprocs */
 #include <netinet/in.h>
 #include <sys/select.h>
@@ -19,6 +18,21 @@
 #include <bpf/btf.h>
 #include "json_writer.h"
 
+#ifdef __GLIBC__
+#include <execinfo.h> /* backtrace */
+#endif
+
+/* Default backtrace funcs if missing at link */
+__weak int backtrace(void **buffer, int size)
+{
+	return 0;
+}
+
+__weak void backtrace_symbols_fd(void *const *buffer, int size, int fd)
+{
+	dprintf(fd, "<backtrace not supported>\n");
+}
+
 static bool verbose(void)
 {
 	return env.verbosity > VERBOSE_NONE;
-- 
2.34.1


