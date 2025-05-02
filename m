Return-Path: <linux-kselftest+bounces-32167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9566AA711D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8689C18985E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99945248F55;
	Fri,  2 May 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="io6Wbuwn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f7d2yuh5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5F22D4DB;
	Fri,  2 May 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187439; cv=none; b=e+v/XfpssIqmblavT/VtwkEnivD/PwVJEwUKtBe4x/KMAWcZz8DZv/pTsynOCqCydW7SiFRSSoKNJN8Y9WSjXeVuhdXYOI9fp36RaZvEpslT6yeNRJ9imWTMOrN39VhyI1SojQh354caYurQhJl+pVEhkVY3wIn4U5B/wvC3DIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187439; c=relaxed/simple;
	bh=E3AueClkwR2N+GQSYCxK6LEoGj4sOArLMp5wfE67WKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZlhSBuaaghjqq4EK0BMzAD1iGAcLxxxPFC0rGWuC9csor0fwn8YkzUxWHAN0pj2Q0Kbe6GR3fsTZaYV4iL6Ki8Y3XOdXcVTrWIBC3bwaKoGP+JbCS10+QJEZ1kGVcBRBNX20POsFiBTT5iBa8BMHBdyKi/tJ1+YR9QyZnvdFZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=io6Wbuwn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f7d2yuh5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746187435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mabMKuekHMCjBzOW268flwwbg7jhcHcFTug4i1NeKhA=;
	b=io6WbuwnsyX3pWhy+Rt5zFTBefvCctPqE308jeIiShSqn5DnYObSopAmIDYrfOXP51HM5P
	fuhD+e70ikbritpq156jLHKsDsKpNl8iU73q3/BYc8lhHs1Gun076wWThGazcS8/1fW0y0
	mJsdA25qMUJ/yPREcVt49+TP8WpcTjuvc0CUqoL02rsZvJA1mV3lmYGbafbIRokFGnkxN6
	QKzkH91CTumaj6+gLFsOWZjn/WuXpq80FDxiiK+mLTXIsPMBBRX1BaIddebopwRD7dDtBl
	sBg2+V5sVtr0f8oN1l/o2XxSN1mo6OHBPC39V6XGanEgdoQR4A76U1rKB2BaVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746187435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mabMKuekHMCjBzOW268flwwbg7jhcHcFTug4i1NeKhA=;
	b=f7d2yuh5bAWYZZ4xQlh3gm0Kl9BN5DM9+0vojIv/vVTZyuk9N/OuPr3aqGAxhVVf2yWycC
	WnLOcOjhTzLPElDg==
Date: Fri, 02 May 2025 14:03:50 +0200
Subject: [PATCH 1/3] selftests/timens: Print TAP headers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-timens-fixes-v1-1-fb517c76f04d@linutronix.de>
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
In-Reply-To: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746187432; l=4907;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=E3AueClkwR2N+GQSYCxK6LEoGj4sOArLMp5wfE67WKQ=;
 b=mTdVCIciiLP7jSpIlh1fngftlcPTtZMdXYMnrSeUeaa706IgUMDYjmxdGXeybgBUBnCyvyyYZ
 vQmqm85IWp0CDaoc7DDDYoQKMKKtUgEx1mH6V9X7O2cdYDPW99ILjva
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The TAP specification requires that the output begins with a header line.
These headers lines are missing in the timens tests.

Print such a line.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/timens/clock_nanosleep.c | 2 ++
 tools/testing/selftests/timens/exec.c            | 2 ++
 tools/testing/selftests/timens/futex.c           | 2 ++
 tools/testing/selftests/timens/gettime_perf.c    | 2 ++
 tools/testing/selftests/timens/procfs.c          | 2 ++
 tools/testing/selftests/timens/timens.c          | 2 ++
 tools/testing/selftests/timens/timer.c           | 2 ++
 tools/testing/selftests/timens/timerfd.c         | 2 ++
 tools/testing/selftests/timens/vfork_exec.c      | 2 ++
 9 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
index 72d41b955fb2263ae74c34b446fb322d1bd50c6a..346bff3d128dfa8c8c743cc2eba74917994bb2f7 100644
--- a/tools/testing/selftests/timens/clock_nanosleep.c
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -115,6 +115,8 @@ int main(int argc, char *argv[])
 {
 	int ret, nsfd;
 
+	ksft_print_header();
+
 	nscheck();
 
 	ksft_set_plan(4);
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index d12ff955de0d8f6665fa957e81438e373af9f92c..a644162d56fdc86827b83a45f83c2597c253aa6a 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -36,6 +36,8 @@ int main(int argc, char *argv[])
 		return 0;
 	}
 
+	ksft_print_header();
+
 	nscheck();
 
 	ksft_set_plan(1);
diff --git a/tools/testing/selftests/timens/futex.c b/tools/testing/selftests/timens/futex.c
index 6b2b9264e851caed06a628589eda0bf81ff33f16..339633ae037a74d2026ca835ac8600cd0394ae01 100644
--- a/tools/testing/selftests/timens/futex.c
+++ b/tools/testing/selftests/timens/futex.c
@@ -66,6 +66,8 @@ int main(int argc, char *argv[])
 	pid_t pid;
 	struct timespec mtime_now;
 
+	ksft_print_header();
+
 	nscheck();
 
 	ksft_set_plan(2);
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
index 6b13dc277724126a9d2d5e17c805217760df72ad..d6658b7b754877fbf67237d6c22787a2a89066ce 100644
--- a/tools/testing/selftests/timens/gettime_perf.c
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -67,6 +67,8 @@ int main(int argc, char *argv[])
 	time_t offset = 10;
 	int nsfd;
 
+	ksft_print_header();
+
 	ksft_set_plan(8);
 
 	fill_function_pointers();
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 1833ca97eb247b1b45b7a86f0ca800d4a6e58c74..0a9ff90ee69a9327ed905428f1462fa189ffd830 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -180,6 +180,8 @@ int main(int argc, char *argv[])
 {
 	int ret = 0;
 
+	ksft_print_header();
+
 	nscheck();
 
 	ksft_set_plan(2);
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 387220791a052e6013bd0fb4162f123d85152183..a9c0534ef8f67184c34882ae163472c179f593e4 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -151,6 +151,8 @@ int main(int argc, char *argv[])
 	time_t offset;
 	int ret = 0;
 
+	ksft_print_header();
+
 	nscheck();
 
 	check_supported_timers();
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5b939f59dfa4d64e4c2e4dc8eb6a644d44211f13..51babe63e233bdaaef35c1cafbcb5b5cc91c021e 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -75,6 +75,8 @@ int main(int argc, char *argv[])
 	pid_t pid;
 	struct timespec btime_now, mtime_now;
 
+	ksft_print_header();
+
 	nscheck();
 
 	check_supported_timers();
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index a4196bbd6e33f41b6a3ae346070037aff1cf4087..e58bc8b64ce2738dccb8c2a2c88e592c237b55d5 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -82,6 +82,8 @@ int main(int argc, char *argv[])
 	pid_t pid;
 	struct timespec btime_now, mtime_now;
 
+	ksft_print_header();
+
 	nscheck();
 
 	check_supported_timers();
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index 5b8907bf451dde3f3e2699f87797c155b9115aab..b957e1a651243adde41ec5cd57bbd12a7cac9eeb 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -91,6 +91,8 @@ int main(int argc, char *argv[])
 		return check("child after exec", &now);
 	}
 
+	ksft_print_header();
+
 	nscheck();
 
 	ksft_set_plan(4);

-- 
2.49.0


