Return-Path: <linux-kselftest+bounces-10028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B48C2A30
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660772846F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9091E525;
	Fri, 10 May 2024 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bneyZqAc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B691A2C3A
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367772; cv=none; b=Dqk1HICd8YW+G6u+tscWdzWlJjEc1fUY9fUeWCXEZ3OyGixvvtAvQ5uyOpSE8tYSfoUESRJpAlwUsbDhTApF+3gihRFK5/Pn/Qym+JG3rpUOxw/m5bbxZn3GdvwoTYBiwrcdxVBh7BNNmbwzG/m5U6guo37Bd9GFukkqR7nUM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367772; c=relaxed/simple;
	bh=oAq7fpwbbfFZ61Uu45sOtwQXrRsEJ3Y5JqEG9Y1vxoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JKkP2+YLD9ZQBkFBqko9yPpvzcDmVQJaDOQnspv2G3AUdn5QMr1BhO6+LHoKpfHU7FmwmwNli2QqNTvDfG2+yCcupsgvEB/AdiMU7rpSJ0SzmtAAiXSe9/RU4KMt1JcQ6oU7nz3Hv/QYDlnsFLUjmBDSd6uBr/Dw56yIpDHB6sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bneyZqAc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be23bb01aso45741437b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367770; x=1715972570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKWeI4M6w/xktAVzpxohBVmT60Oq62Vxb0DU/Gw4TvA=;
        b=bneyZqAce5MLOURcs1d0U3tU7aDP+X1OI2zT99Et14mmnGTBrglaUBcxVJvbDJNQa7
         j91T94LQxMgzTcaaFasQUtJq7sTGQ5zMnndrbxAqcDOQQ6ptFst6roVWwibKuM4E0WKr
         jR6h/IlUzFgvukdV0UIDFE3D88nmy8L9hJngN2FEgzKqC8JWJr++UCNIQhE8Ld6GM5WQ
         tH6BWZa1D4B3bbeFyd0xWTQS+xzJI+6NBLxW3HU+66kV0PfmK2ds4U4Rb0yLsCeDUtD+
         X5eI0JLfxtmb0HIX7rU2lJmtulVuhAa1nSvq6RBwtVeSgPyRonRsUiisevPUQjoIsxGY
         z2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367770; x=1715972570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKWeI4M6w/xktAVzpxohBVmT60Oq62Vxb0DU/Gw4TvA=;
        b=CNLkp0ST6RFmjGApKpezWN9pE5Adxc9gxjd6CRde+9Qnx6HdvCvSfiuCWpLB7Tj3Uj
         MsRcPIBfdNIS0Xp82rt/Gz+xVypwgplgN/DJr+F/b9wcJczumC4KzgRW5FSd867skfwq
         8OwpHHIknPeRKAvy+syq54VWWnI6G4Fv+X7fn3Yzt8hZpY5MZr9URRXeD08gXoq7x4op
         LfUUT0JEbgy3XlXAK8E57IEojTE2oHpAivsOFIfwVsRZ1SRXROoOHxPlbL1KiGDOdUwh
         5jl6Eib8Rh5TC3KTCQYHoRCZ4drIX1UsORtDBl6GW2GOhRVItq5CShaewGfPUPRCTIBl
         1+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVRor+p3tnZgi1SOwAfBz3Dhe/FNHg5Gi9xVUPVDeVZxIY++bWwEMYYKCR0x/HuY2MiLQipnTC57+/qjO8KmAplJzx+zxEcoU7BEPnECFN5
X-Gm-Message-State: AOJu0YxdgAiP+OaWabEbvx2ZYre1rPB5BVQSqkonlijQxeBZZ/5mHv+3
	VifubeRvGx7sn0hQoStSeMw+X/JbQmQw2LIMTKYTy9bv9crnBhB4jTFm/z/YZ9BdSAsfI39BIA=
	=
X-Google-Smtp-Source: AGHT+IHA0jb54JeWUPzJsoNGtNdjo+1jDg2GxBwSeEG6DJy1RITQuxnlP0DcCPi19hmVKkJS4y7QRENq4A==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:690c:b10:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-622afcbec26mr9186507b3.0.1715367770380; Fri, 10 May 2024
 12:02:50 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:18 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-2-jrife@google.com>
Subject: [PATCH v1 bpf-next 01/17] selftests/bpf: Migrate recvmsg* return code
 tests to verifier_sock_addr.c
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This set of tests check that the BPF verifier rejects programs with
invalid return codes (recvmsg4 and recvmsg6 hooks can only return 1).
This patch replaces the tests in test_sock_addr.c with
verifier_sock_addr.c, a new verifier prog_tests for sockaddr hooks, in a
step towards fully retiring test_sock_addr.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_sock_addr.c  | 37 ++++++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 70 -------------------
 3 files changed, 39 insertions(+), 70 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sock_addr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c4f9f306646ed..c60db8beeb734 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -66,6 +66,7 @@
 #include "verifier_sdiv.skel.h"
 #include "verifier_search_pruning.skel.h"
 #include "verifier_sock.skel.h"
+#include "verifier_sock_addr.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_spin_lock.skel.h"
 #include "verifier_stack_ptr.skel.h"
@@ -181,6 +182,7 @@ void test_verifier_scalar_ids(void)           { RUN(verifier_scalar_ids); }
 void test_verifier_sdiv(void)                 { RUN(verifier_sdiv); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
 void test_verifier_sock(void)                 { RUN(verifier_sock); }
+void test_verifier_sock_addr(void)            { RUN(verifier_sock_addr); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock_addr.c b/tools/testing/selftests/bpf/progs/verifier_sock_addr.c
new file mode 100644
index 0000000000000..5081fa723d3a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_sock_addr.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf_sockopt_helpers.h>
+#include "bpf_misc.h"
+
+SEC("cgroup/recvmsg4")
+__success
+int recvmsg4_good_return_code(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/recvmsg4")
+__failure __msg("At program exit the register R0 has smin=0 smax=0 should have been in [1, 1]")
+int recvmsg4_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/recvmsg6")
+__success
+int recvmsg6_good_return_code(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/recvmsg6")
+__failure __msg("At program exit the register R0 has smin=0 smax=0 should have been in [1, 1]")
+int recvmsg6_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index aa2198a0f24dd..40e33167bec20 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -94,8 +94,6 @@ static int connect4_prog_load(const struct sock_addr_test *test);
 static int connect6_prog_load(const struct sock_addr_test *test);
 static int sendmsg_allow_prog_load(const struct sock_addr_test *test);
 static int sendmsg_deny_prog_load(const struct sock_addr_test *test);
-static int recvmsg_allow_prog_load(const struct sock_addr_test *test);
-static int recvmsg_deny_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test);
@@ -373,64 +371,6 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SYSCALL_EPERM,
 	},
-
-	/* recvmsg */
-	{
-		"recvmsg4: return code ok",
-		recvmsg_allow_prog_load,
-		BPF_CGROUP_UDP4_RECVMSG,
-		BPF_CGROUP_UDP4_RECVMSG,
-		AF_INET,
-		SOCK_DGRAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		ATTACH_OKAY,
-	},
-	{
-		"recvmsg4: return code !ok",
-		recvmsg_deny_prog_load,
-		BPF_CGROUP_UDP4_RECVMSG,
-		BPF_CGROUP_UDP4_RECVMSG,
-		AF_INET,
-		SOCK_DGRAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		LOAD_REJECT,
-	},
-	{
-		"recvmsg6: return code ok",
-		recvmsg_allow_prog_load,
-		BPF_CGROUP_UDP6_RECVMSG,
-		BPF_CGROUP_UDP6_RECVMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		ATTACH_OKAY,
-	},
-	{
-		"recvmsg6: return code !ok",
-		recvmsg_deny_prog_load,
-		BPF_CGROUP_UDP6_RECVMSG,
-		BPF_CGROUP_UDP6_RECVMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		LOAD_REJECT,
-	},
 };
 
 static int load_insns(const struct sock_addr_test *test,
@@ -527,16 +467,6 @@ static int sendmsg_deny_prog_load(const struct sock_addr_test *test)
 	return xmsg_ret_only_prog_load(test, /*rc*/ 0);
 }
 
-static int recvmsg_allow_prog_load(const struct sock_addr_test *test)
-{
-	return xmsg_ret_only_prog_load(test, /*rc*/ 1);
-}
-
-static int recvmsg_deny_prog_load(const struct sock_addr_test *test)
-{
-	return xmsg_ret_only_prog_load(test, /*rc*/ 0);
-}
-
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 {
 	struct sockaddr_in dst4_rw_addr;
-- 
2.45.0.118.g7fe29c98d7-goog


