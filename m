Return-Path: <linux-kselftest+bounces-13165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF28926FEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 08:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49457284CA0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C15E1A0728;
	Thu,  4 Jul 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFjFZHu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C0B1A0721;
	Thu,  4 Jul 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075707; cv=none; b=uF/AajG0VYg6K/q0RxAlLYKYMml5UaP24AFb7QMmHw/xb3J1kUlCl4ickBkKKP+lHUoM132Yj8Q4JcPES66wM1Fgqp5vUu7+Hr1mmfSu04FHVi39w9sa4ig/CnAOp0bBqyj5MxZQaYqgtoLtV8W5AQIjYDTWyHzPQ3fVfvDNQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075707; c=relaxed/simple;
	bh=ykZWrxE+n4/sVCNo5kafkiXafCpMooYXm2h/xWx50e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfMIwZFBkCKoqdbk3on+R9qkBYY6vU9GX2MVpyts/9Bkl3oF6k3rDXJPNVgkjFLM2H8bepah7FljhEt3mExZWPXC/JHF9ifDXW+Fo7ygZtNz7CyJ3VGr7exymCkjvCSd1AJVHbPE9WvmfXZBbF0Ip0ROBV02DTspqUbFMbNtN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFjFZHu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E230C3277B;
	Thu,  4 Jul 2024 06:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075706;
	bh=ykZWrxE+n4/sVCNo5kafkiXafCpMooYXm2h/xWx50e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFjFZHu06ItIp9mDDSPmKBwrzjO/tonM8g30oBILKmQeXzWeNeyY0ogVmHF+1s+V+
	 ai7cAF2OCWdmb6W4IS1dSI37g2tB3zmXlE8a98jOey2CG8lNE5fsFqvCKVl4hYXtHs
	 E37MYc7ou68xCLXLWIm1zFmBFvkXMIQ1uhew66hg4Vm+GuJSCkmSBtMgBcZ5in6UBS
	 xFXvv8s/EXJBy5E9AS6p7C7fhbhwUfHcgBM+4QPWsefmDjs4jGHXgipR4fcWhPpPc+
	 OZR384TQ4u8TuFV1swAskaegAhnapri9h/C14nZXQtoDP5JhLvHDC6hTsBkMTc0X+b
	 UqikAHObK9sEg==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/6] selftests/bpf: Define ENOTSUPP in testing_helpers.h
Date: Thu,  4 Jul 2024 14:48:01 +0800
Message-ID: <03d468d5f4c4b267905d8d3c5d697a9028245f22.1720075006.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720075006.git.tanggeliang@kylinos.cn>
References: <cover.1720075006.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

ENOTSUPP are defined in so many places in bpf selftests, this patch
moves this definition into testing_helpers.h, which is almost included
by each tests. And drop all other duplicate definitions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 4 ----
 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 4 ----
 tools/testing/selftests/bpf/prog_tests/sock_addr.c  | 4 ----
 tools/testing/selftests/bpf/test_maps.c             | 4 ----
 tools/testing/selftests/bpf/test_verifier.c         | 4 ----
 tools/testing/selftests/bpf/testing_helpers.h       | 4 ++++
 6 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index bceff5900016..fa2efb246d3b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -16,10 +16,6 @@
 #include "tcp_ca_kfunc.skel.h"
 #include "bpf_cc_cubic.skel.h"
 
-#ifndef ENOTSUPP
-#define ENOTSUPP 524
-#endif
-
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int expected_stg = 0xeB9F;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
index 130a3b21e467..6df25de8f080 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -10,10 +10,6 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 
-#ifndef ENOTSUPP
-#define ENOTSUPP 524
-#endif
-
 static struct btf *btf;
 
 static __u32 query_prog_cnt(int cgroup_fd, const char *attach_func)
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index b880c564a204..68d9255d2bb7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -23,10 +23,6 @@
 #include "getpeername_unix_prog.skel.h"
 #include "network_helpers.h"
 
-#ifndef ENOTSUPP
-# define ENOTSUPP 524
-#endif
-
 #define TEST_NS                 "sock_addr"
 #define TEST_IF_PREFIX          "test_sock_addr"
 #define TEST_IPV4               "127.0.0.4"
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index dfbab214f4d1..227d7d6eaf8e 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -26,10 +26,6 @@
 #include "test_maps.h"
 #include "testing_helpers.h"
 
-#ifndef ENOTSUPP
-#define ENOTSUPP 524
-#endif
-
 int skips;
 
 static struct bpf_map_create_opts map_opts = { .sz = sizeof(map_opts) };
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 610392dfc4fb..447b68509d76 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -42,10 +42,6 @@
 #include "../../../include/linux/filter.h"
 #include "testing_helpers.h"
 
-#ifndef ENOTSUPP
-#define ENOTSUPP 524
-#endif
-
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_EXPECTED_INSNS	32
 #define MAX_UNEXPECTED_INSNS	32
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d55f6ab12433..bad21e72dafc 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -9,6 +9,10 @@
 #include <bpf/libbpf.h>
 #include <time.h>
 
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
 #define __TO_STR(x) #x
 #define TO_STR(x) __TO_STR(x)
 
-- 
2.43.0


