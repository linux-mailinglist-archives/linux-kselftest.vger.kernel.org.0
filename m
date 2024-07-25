Return-Path: <linux-kselftest+bounces-14221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0506593C018
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7B11F217A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9C1990C4;
	Thu, 25 Jul 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2YTQ3RB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BEF198E80;
	Thu, 25 Jul 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903973; cv=none; b=gBbaDvNfDqoa3cwnAmXoPUnW4B3s6b3ExBxIBgSlgigYO3tj9moShqFQRPXHG3pydfZPpu+Z7hBb2U8vQjzKv5SObRN4pWRGVN6UQl8V879o0flkXzALdmxNc3lKXR2Cn4sQsSpem7ncwUjBQ4onMsba4NfBPgaXOoZeQWFo7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903973; c=relaxed/simple;
	bh=ufi1u+2GjL41iAT6/Y6az0ws4bZBF2sCFl2jBCNqkiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNBTdboTjqbxkT3BBh30JikswjjCh8XaZpO8VZjRiCCWy+UlFCq2k7aSIE6sVzuZgPqUjFPNt7zwFdwMMuLrbmVZGOktlSnWt3+uhb4NjlMEge8o4TqSmbjvtYJ7xp2nICBTToZdEWOwli4svOBCy1nEacnYkgboX4tkua3qg/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2YTQ3RB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70eae5896bcso371729b3a.2;
        Thu, 25 Jul 2024 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903971; x=1722508771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHKVyWTDcnB+HXRDPNPGBu8CijBpCmOJA9/1QhMQ58E=;
        b=P2YTQ3RByoKr4kdNVEITItYkNvzY11eHbr8EhrxgxL0hGnytnqpJkVaBpepJoLJ3DQ
         bOUuKMP83IQ8AcsQ5NkogrEv5u3OYloyb+tuw08qzPthU9jJHe5poPF3OZgl9pWFENNf
         9IIi4sKM8ggVmHxRQ+gySdNEQ1J6X2Sn4123f/KBQB7oyZRTnFV3yMzPAGDAAGfnlfrX
         YgI1pHPHaVx1A/zYdwXLqX6rzw4mJXnvhmEzDR4nfDeEyM+gD8EVvrlyhayguxQEhMlz
         /CudYDE9xtuP4Wm1UiaDy35XtQN2m6JhcYZuYA0tBtW9n4sv77qzorEYGmTqNlPGLLoC
         OkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903971; x=1722508771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHKVyWTDcnB+HXRDPNPGBu8CijBpCmOJA9/1QhMQ58E=;
        b=hpcgWrBLZgUrhp3yuXPUPuDgA4BVOTPGvSmsWGVwtcJAWDb8gd/0q/WKqm1ZBCGj7L
         S/gI35ZoKtJbcf8uQ8DLjcJkNv3dyT7yTcOFcbxne8+VcXzTj39qXO7vbr7x+4NGh30k
         DaujsJFTqJFMFyzGqxeeqzgkmkL1HzOYzezdfyZuoKGMl78pZjRvKAOIszry0ZcZ8ZPJ
         VKGvZZFHMlurKcPiMvYcxcq57Z7f6O0JZzHmH3vg7dj1q4qmHbWR6e+BRqt3zQ98QHSE
         HCVvDVQe5zOj9IGtf0/j8gbmfN4vn78K7LWnCm/DMDptanTN9WdMdrCNTZKuWw9Itf9W
         kpTw==
X-Forwarded-Encrypted: i=1; AJvYcCUnxpUFITFavSXzlrjye29RrVyrPBX8esGYZEZJrjiQqOpn0OSuRK3TnUhbCbSvb+4S6Kjky+1W/iM1qQ7oM9Kk7f7tDf3pJMS4UaTORXhTlIJWKA/ryGMWYNTDAE0zv/zDsW1t07o0
X-Gm-Message-State: AOJu0YxqU2RHXpGHA5KlH0Fx6jceyEp6vAL3wY4DLGGFlxQwgvKygX7b
	xc6OI7qHhzDXLrAVndOPDWjuw2J0MCDRJR9EinV+INyijcUA8v2877Z74rhD
X-Google-Smtp-Source: AGHT+IH5l0RpFxREWyJ/JFlGvGcl8GjgZ0eumXvnjpC7zYH7OPJua00045dwkDPLHbVMRNe1OH/3Aw==
X-Received: by 2002:a05:6a20:12d3:b0:1bd:18ee:f145 with SMTP id adf61e73a8af0-1c472803abdmr3462337637.1.1721903971327;
        Thu, 25 Jul 2024 03:39:31 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f78491sm10991075ad.244.2024.07.25.03.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:39:31 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
Subject: [PATCH bpf-next v1 6/8] selftests/bpf: Fix compile if backtrace support missing in libc
Date: Thu, 25 Jul 2024 03:35:58 -0700
Message-Id: <472c94bd42cda20154a26ef384b73488abf026c0.1721903630.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721903630.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Use backtrace functions only with glibc and otherwise provide stubs in
test_progs.c. This avoids compile errors (e.g. with musl libc) like:

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
 tools/testing/selftests/bpf/test_progs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 60c5ec0f6abf..f6cfc6a8e8f0 100644
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
@@ -19,6 +18,14 @@
 #include <bpf/btf.h>
 #include "json_writer.h"
 
+#ifdef __GLIBC__
+#include <execinfo.h> /* backtrace */
+#else
+#define backtrace(...) (0)
+#define backtrace_symbols_fd(bt, sz, fd) \
+	dprintf(fd, "<backtrace not supported>\n", bt, sz)
+#endif
+
 static bool verbose(void)
 {
 	return env.verbosity > VERBOSE_NONE;
-- 
2.34.1


