Return-Path: <linux-kselftest+bounces-9002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D68B504E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 06:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E30E1C21988
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 04:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDBABE62;
	Mon, 29 Apr 2024 04:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3ReCz15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980279F9;
	Mon, 29 Apr 2024 04:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365649; cv=none; b=qjfQFfrqZKFDz6qr7vFCXEhEu0QZnV6bqzSfzVjUdtr26gmdZvworWEBe5puA8WKdqTcK/zEWlxR/kQC4w0c5qL7n3ZMWt6jWAA56uxFr4MrxJA01PLhc/H3SU0SYbo5ukTQuNdjBy4K+t7sOuREAIl6/JwfPWgEp3Mj95NdBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365649; c=relaxed/simple;
	bh=5zPcB13L2TEYchA6zl5rtYTcXIkZ8sVxvp8s1ZUnN0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aXSAooukdYevsXNFGEbtSEhYhEiudBX1+wv1s1rDftDy9kzTB9qbCm8EUAjBgAq75bATycOd1hVbE7qVbEjAiNjr5xVyr9PHC1xaRMt6AYPPfmzqtTkO3Wt/JIELOVeNspXi+Vv5wRKainTFB2VotQMadJHYrT5WaEi57W233aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3ReCz15; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso23674005e9.1;
        Sun, 28 Apr 2024 21:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714365646; x=1714970446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=solEmZTLUT9rrgpr8rWc5di4N0OBO3L9+P0yMo2Rqts=;
        b=m3ReCz15GGDO2qU2SWxwHEQILMawEPijTerArl88Xh3gFsk5RgYs7Az+4yKwgIUjCz
         EYghO3rLQD4+6AA++v2S+Bccvus6/xJMyH4Htlx5Pi4VP9i2kp50e2+2oRnC4P/qcvLi
         JHMcu3U07YpQx05FG2FpOARBfbMAJBv+9bQvMn8gM5kZBujMa9w3n3cGmWcMg7nfj1dP
         xpOJgF6ahsC9kXuO44ZPvSbMa50tsR/wcMdCEuWemRnhQ8rkB4lolO9jDUoPjypzHOI3
         8P4Cgs/uoumCzBdh5iBA3pJfXJmNJt+6LuaQmVtv4ABP/H6Ef+bCZ3eeBPqUqlGW3yyK
         2+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714365646; x=1714970446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=solEmZTLUT9rrgpr8rWc5di4N0OBO3L9+P0yMo2Rqts=;
        b=Mg7EDxV7DCxo/UY1Pue5r0sWDVV2su5uE4F1jumysFPs9WogjBzSf5Yen+wmiJwTA8
         kNUDSVQooFuowuTVVPiGq5ReYglkz6p3OngGHKeVy32W91UfNnWA0/f/nQ4itp0u6/Dz
         5xNGmtaQC1/wpJ/AyaDM3avqB2XPYgm5xwKANfJP0WsipDGhnOXDZhmv9YMpNkdeVK4x
         2Rie/xGVb5Hw7ff7B91blc+DhVNVqT5GOLNzF9pJH38drS0CjUZKDYTEB9Cfii5T8vfp
         oMRVtT7AUlUh+maKFYRBcbQLXep/Dn2osVWeDgpEYCYycGzVV7zoDOoqPfslQ9BWZGSy
         BOeg==
X-Forwarded-Encrypted: i=1; AJvYcCU88cdtYK0BJLry8Eacf2t87sVGXrdlNJnPR9ItPpsD6aAvkKn5jfFMsNCs6Pdo5keSLtD1ZNp17QfZgomPHKKLLfV1HjuAeYqSfD3TLN0EajfyNdU/aTXz93zEoRm1eWP7zFGynhCbxps5uAw8
X-Gm-Message-State: AOJu0YwA9uV2rXNnXhSARHwWzHb/tVwNwnbFbR6A9lNtNAWD0ViQtTIQ
	npw+oUWaR9s0BoHRhMi9kUKUj1QL/KNQfCkCfs/y0LowCgBoUQxlR7X10ti/
X-Google-Smtp-Source: AGHT+IGLyIURNb/0G7vU9X1cZNkRP4t+/yiUDBQmcmDw3eUtAqWgWVXNvatw9THmMZMddpB4KawfaQ==
X-Received: by 2002:a05:600c:500c:b0:41b:e416:43d3 with SMTP id n12-20020a05600c500c00b0041be41643d3mr4112231wmr.35.1714365645751;
        Sun, 28 Apr 2024 21:40:45 -0700 (PDT)
Received: from ubuntu-focal.zuku.co.ke ([197.237.50.252])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c138500b0041c5151dc1csm1409367wmf.29.2024.04.28.21.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 21:40:45 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dorine Tipo <dorine.a.tipo@gmail.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH] selftests:arm64: Test PR_SVE_VL_INHERIT after a double fork
Date: Mon, 29 Apr 2024 04:40:12 +0000
Message-Id: <20240429044012.5018-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new test, double_fork_test() to check the inheritance of the SVE
vector length after a double fork.
The `EXPECTED_TESTS` macro has been updated to account for this additional
test.
This patch addresses task 7 on the TODO list.

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
 tools/testing/selftests/arm64/fp/za-fork.c | 95 +++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/za-fork.c b/tools/testing/selftests/arm64/fp/za-fork.c
index 587b94648222..35229e570dcf 100644
--- a/tools/testing/selftests/arm64/fp/za-fork.c
+++ b/tools/testing/selftests/arm64/fp/za-fork.c
@@ -11,7 +11,7 @@

 #include "kselftest.h"

-#define EXPECTED_TESTS 1
+#define EXPECTED_TESTS 2

 int fork_test(void);
 int verify_fork(void);
@@ -69,6 +69,97 @@ int fork_test_c(void)
	}
 }

+int double_fork_test(void)
+{
+	pid_t newpid, grandchild_pid, waiting;
+	int ret, child_status, parent_result;
+
+	ret = prctl(PR_SVE_SET_VL, vl | PR_SVE_VL_INHERIT);
+	if (ret < 0)
+		ksft_exit_fail_msg("Failed to set SVE VL %d\n", vl);
+
+	newpid = fork();
+	if (newpid == 0) {
+		/* In child */
+		if (!verify_fork()) {
+			ksft_print_msg("ZA state invalid in child\n");
+			exit(0);
+		}
+
+		grandchild_pid = fork();
+		if (grandchild_pid == 0) {
+			/* in grandchild */
+			if (!verfy_fork()) {
+				ksft_print_msg("ZA state invalid in grandchild\n");
+				exit(0);
+			}
+
+			ret = prctl(PR_SVE_GET_VL);
+			if (ret & PR_SVE_VL_INHERIT) {
+				ksft_print_msg("prctl() reports _INHERIT\n");
+				return;
+			}
+			 ksft_print_msg("prctl() does not report _INHERIT\n");
+
+		} else if (grandchild_pid < 0) {
+			ksft_print_msg("fork() failed in first child: %d\n", grandchild_pid);
+			return 0;
+		}
+
+		/*  Wait for the grandchild process to exit */
+		waiting = waitpid(grandchild_pid, &child_status, 0);
+		if (waiting < 0) {
+			if (errno == EINTR)
+				continue;
+			ksft_print_msg("waitpid() failed: %d\n", errno);
+			return 0;
+		}
+		if (waiting != grandchild_pid) {
+			ksft_print_msg("waitpid() returned wrong PID\n");
+			return 0;
+		}
+
+		if (!WIFEXITED(child_status)) {
+			ksft_print_msg("grandchild did not exit\n");
+			return 0;
+		}
+
+		exit(1);
+		}
+	}
+	if (newpid < 0) {
+		ksft_print_msg("fork() failed: %d\n", newpid);
+
+		return 0;
+	}
+
+	parent_result = verify_fork();
+	if (!parent_result)
+		ksft_print_msg("ZA state invalid in parent\n");
+
+	for (;;) {
+		waiting = waitpid(newpid, &child_status, 0);
+
+		if (waiting < 0) {
+			if (errno == EINTR)
+				continue;
+			ksft_print_msg("waitpid() failed: %d\n", errno);
+			return 0;
+		}
+		if (waiting != newpid) {
+			ksft_print_msg("waitpid() returned wrong PID\n");
+			return 0;
+		}
+
+		if (!WIFEXITED(child_status)) {
+			ksft_print_msg("child did not exit\n");
+			return 0;
+		}
+
+		return WEXITSTATUS(child_status) && parent_result;
+	}
+}
+
 int main(int argc, char **argv)
 {
 	int ret, i;
@@ -86,11 +177,13 @@ int main(int argc, char **argv)
 	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
 	if (ret >= 0) {
 		ksft_test_result(fork_test(), "fork_test\n");
+		ksft_test_result(double_fork_test(), "double_fork_test\n");

 	} else {
 		ksft_print_msg("SME not supported\n");
 		for (i = 0; i < EXPECTED_TESTS; i++) {
 			ksft_test_result_skip("fork_test\n");
+			ksft_test_result_skip("double_fork_test\n");
 		}
 	}

--
2.25.1


