Return-Path: <linux-kselftest+bounces-13677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343392FC73
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 16:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8661F227E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9079617166E;
	Fri, 12 Jul 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhHJr2fY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BC13F439;
	Fri, 12 Jul 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794284; cv=none; b=gHb3hzRu0luoyrJlo/Ka+9qS89GwaHMmoxVmUnBtPA34aN8rVkZgDwxUllXb7in7GSEXYxLB8WAroeKU/I5c7lCVulPUci1nXb5OAuXGOx5WUP1FbstRNnX/h07s5zcX3GXoSBpVHVbYeT9pteAt3ASUBWRyY2K/D/buIkNZlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794284; c=relaxed/simple;
	bh=06ifw7SQRypt3Wn5ttQJBek4EMBqirRgHFBshtecyKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP+213lyOYANDTda21VFioz7s6Enk/pZjwh17br384jqIDhJAMJ7YhQT3bLND6jZvha2YsQUdJ9Zc9i5m+VwE5x3Iyeak/YQleyaaNiWht62t7w+V+XQNXZih+aA2pWDUt+lSMf8i4T8Nm4Wuo+f6CQcX+IAsVFAG5NN5b4WcyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhHJr2fY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A27C32782;
	Fri, 12 Jul 2024 14:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720794283;
	bh=06ifw7SQRypt3Wn5ttQJBek4EMBqirRgHFBshtecyKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhHJr2fY6WOYsyx66VG68oOKlorW0Z5Lz70FTz6zXSrfwBJF3n9vMCgLXgTSgcibU
	 Xw3sgRdLd8E0DLfc7d6v6fHr7WA0bCShejU9spKpdjsoBnePEbyQ+Gm9B9lhxseBdh
	 Uw162BaGqb6fDKOk5JcktcVo/DdCWI6Gla5OdOFomzjZEpLJa6sepOTJQx/VlM0Ow9
	 ZZYEvh2l4kI1u4VBjYVM9ikDzriWU9Xne6/l28bBcp0h1n9uIHWhCChTeeKfjZY8KT
	 hlTZU3EShSfuqRklZ6jO7Tjo+GLMnKvNXBL0PwXqXC/IJ9TJaFCj3Gbhki7p5HdDb9
	 V//w49rnGIfsA==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Drop duplicate ENOTSUPP definitions
Date: Fri, 12 Jul 2024 22:24:18 +0800
Message-ID: <e954fa2f0de2d2460f7265bb26cbe0a3edb9108c.1720791489.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720791488.git.tanggeliang@kylinos.cn>
References: <cover.1720791488.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

ENOTSUPP is defined in bpf/str_error.h now, so no need to redefine it
in so many places in bpf selftests.

This patch includes <bpf/str_error.h> in testing_helpers.h, which is
almost included by each tests. And drop all duplicate definitions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 4 ----
 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 4 ----
 tools/testing/selftests/bpf/prog_tests/sock_addr.c  | 4 ----
 tools/testing/selftests/bpf/test_maps.c             | 4 ----
 tools/testing/selftests/bpf/test_verifier.c         | 4 ----
 tools/testing/selftests/bpf/testing_helpers.h       | 1 +
 6 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 1d494b4453f4..676eb7cd7fb0 100644
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
index d55f6ab12433..1e882f408596 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <bpf/str_error.h>
 #include <time.h>
 
 #define __TO_STR(x) #x
-- 
2.43.0


