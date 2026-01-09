Return-Path: <linux-kselftest+bounces-48615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74944D0AFFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5039130574CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A1363C58;
	Fri,  9 Jan 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mm1147DI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603292EAB6E
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973057; cv=none; b=AKA5xyPmNzfysET6C9tfi+Ztj27DbuV/2vnVX89dig1eGh+BDGadg+9F75RCZvrhpMxI0qMRgn1DyeYY4/PDoxXijhIzGLlg+baqfB2EToltGW2BCdTysMVRMk5oqSXV11aIlHAKrRT/ddiO5a9tkMHIf1CKD4P51lkEZGcf6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973057; c=relaxed/simple;
	bh=olXGm4lhKZ/DUlPJ4xDJl2D4L2YZF2AiKKcbPFW+qYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrxFtC8yiXIDhTUkpFEcomdOW9YKSKEteaII0sI6oUA+oTI6XsWBrneozsvOCpT1ek8Xnjuz8Zjr6u9D6O9POGqJQj2O1s6DrNBM3J3MWUPcpJLRTZfSv+m60h4CCkP1iSUqeUxXu/ZkgHvbxgfLgIZ2mZaBfcU3wHSTchroVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mm1147DI; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767973053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGmQZRRwHlrtsRbft3WSiOCAz3aFQwD5zodc3tv48HM=;
	b=Mm1147DIHhLW7zP2EauxyHdsXI9RKxz3GC3qUwmoLQ4yuNjCPdidgxYYT9PcDapwg/HC7B
	MIvVhpXMv5LqUDNM6kDVe2b6YwJnRCuX5+WfKrlJoHQ8IOb6UHl2QQHnDRVNPXoNFbNqIf
	R0eRMuWuubcK/ROndIFPVPTrdcatV40=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add BPF_BRANCH_SNAPSHOT_F_COPY test
Date: Fri,  9 Jan 2026 23:34:20 +0800
Message-ID: <20260109153420.32181-4-leon.hwang@linux.dev>
In-Reply-To: <20260109153420.32181-1-leon.hwang@linux.dev>
References: <20260109153420.32181-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test for BPF_BRANCH_SNAPSHOT_F_COPY flag by adding flag to the
callsite of bpf_get_branch_snapshot helper.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/get_branch_snapshot.c      | 26 ++++++++++++++++---
 .../selftests/bpf/progs/get_branch_snapshot.c |  3 ++-
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
index 0394a1156d99..6b8ab1655ab0 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
@@ -73,7 +73,7 @@ static void close_perf_events(void)
 	free(pfd_array);
 }
 
-void serial_test_get_branch_snapshot(void)
+static void test_branch_snapshot(int flags)
 {
 	struct get_branch_snapshot *skel = NULL;
 	int err;
@@ -89,8 +89,14 @@ void serial_test_get_branch_snapshot(void)
 		goto cleanup;
 	}
 
-	skel = get_branch_snapshot__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "get_branch_snapshot__open_and_load"))
+	skel = get_branch_snapshot__open();
+	if (!ASSERT_OK_PTR(skel, "get_branch_snapshot__open"))
+		goto cleanup;
+
+	skel->rodata->flags = flags;
+
+	err = get_branch_snapshot__load(skel);
+	if (!ASSERT_OK(err, "get_branch_snapshot__load"))
 		goto cleanup;
 
 	err = kallsyms_find("bpf_testmod_loop_test", &skel->bss->address_low);
@@ -128,3 +134,17 @@ void serial_test_get_branch_snapshot(void)
 	get_branch_snapshot__destroy(skel);
 	close_perf_events();
 }
+
+void serial_test_get_branch_snapshot(void)
+{
+	test_branch_snapshot(0);
+}
+
+enum {
+	BPF_BRANCH_SNAPSHOT_F_COPY	= 1,	/* Copy branch snapshot from bpf_branch_snapshot. */
+};
+
+void serial_test_copy_branch_snapshot(void)
+{
+	test_branch_snapshot(BPF_BRANCH_SNAPSHOT_F_COPY);
+}
diff --git a/tools/testing/selftests/bpf/progs/get_branch_snapshot.c b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
index 511ac634eef0..47a1984bdf46 100644
--- a/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
+++ b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
@@ -6,6 +6,7 @@
 
 char _license[] SEC("license") = "GPL";
 
+volatile const int flags = 0;
 __u64 test1_hits = 0;
 __u64 address_low = 0;
 __u64 address_high = 0;
@@ -25,7 +26,7 @@ int BPF_PROG(test1, int n, int ret)
 {
 	long i;
 
-	total_entries = bpf_get_branch_snapshot(entries, sizeof(entries), 0);
+	total_entries = bpf_get_branch_snapshot(entries, sizeof(entries), flags);
 	total_entries /= sizeof(struct perf_branch_entry);
 
 	for (i = 0; i < ENTRY_CNT; i++) {
-- 
2.52.0


