Return-Path: <linux-kselftest+bounces-31034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC8A91254
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 06:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4FF3B73E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 04:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F321D63D6;
	Thu, 17 Apr 2025 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dadbc207"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62B18871F
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865162; cv=none; b=s0lljcdFbN4M10ovLfNM1srMksGft4KfSoK28Y20Vm/iCkkDD7h/dS3Xq2vGJCGhLJie6i9do10kMe1/nLiYFukKawavUAKZ4m5rn70nkZc9QzdvAdSv8X88NpF39/zB8umz5VQtR3+nbXCJ7KYsDo5D5ZHgYtY3p6NpjdUwPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865162; c=relaxed/simple;
	bh=RPXZU/aP7WbMdeCTfBXzeiUmIUu7vsCmakN5UMy60VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVKOEzu+DoYmQFdkXk6m/+NxMdAuaPcKKQjy19leq9Uurdmt/eimncEYi175RjRCR2Pzl/X6+VFev+HFyEBW56LrIYiymIeLfh9W+Pt904OYS8F6cr1ANo70zHitxVM5CmPEDKj5BHwfetP++s4Q4rqtAYvUWnrgjVqKyVo0NpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dadbc207; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744865158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nu1ItUoeTVNPAi+YTEKwfobNfHWy8BGxvV0+PknfgOw=;
	b=dadbc20747aMlX8LMCtS5SYSYUTdkPiGHsSI6lEfGvJj2rbyiu+A3PunbjxwBYDyBkz1U/
	kGYmuiyI/o3Yf5ojMol3I/3PeRSmtj4SnMR5iTmswvexNWeXbtgUis/gZFUR4Yr8l77mMN
	6p33ZxbLaFvUAdPAg6Gl+eZjgN2nZDk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: andrii@kernel.org,
	martin.lau@linux.dev,
	bpf@vger.kernel.org
Cc: alexis.lothore@bootlin.com,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add link update test for cgroup_storage
Date: Thu, 17 Apr 2025 12:40:15 +0800
Message-ID: <20250417044041.252874-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250417044041.252874-1-jiayuan.chen@linux.dev>
References: <20250417044041.252874-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add link update test for cgroup_storage.

'./test_progs -a cgroup_storage_update'
test_cgroup_storage_update:PASS:create cgroup 0 nsec
setup_network:PASS:ip netns add cgroup_storage_ns 0 nsec
setup_network:PASS:open netns 0 nsec
setup_network:PASS:ip link set lo up 0 nsec
test_cgroup_storage_update:PASS:setup network 0 nsec
test_cgroup_storage_update:PASS:load program 0 nsec
test_cgroup_storage_update:PASS:attach no map program 0 nsec
test_cgroup_storage_update:PASS:bpf_link_update 0 nsec
test_cgroup_storage_update:PASS:first ping 0 nsec
test_cgroup_storage_update:PASS:second ping 0 nsec
test_cgroup_storage_update:PASS:third ping 0 nsec
61      cgroup_storage_update:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/cgroup_storage.c | 45 +++++++++++++++++++
 .../selftests/bpf/progs/cgroup_storage.c      |  6 +++
 2 files changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
index cf395715ced4..8478b08aa62a 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
@@ -94,3 +94,48 @@ void test_cgroup_storage(void)
 	close(cgroup_fd);
 	cleanup_cgroup_environment();
 }
+
+void test_cgroup_storage_update(void)
+{
+	struct cgroup_storage *skel;
+	struct nstoken *ns = NULL;
+	int cgroup_fd;
+	int err;
+
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (!ASSERT_OK_FD(cgroup_fd, "create cgroup"))
+		return;
+
+	if (!ASSERT_OK(setup_network(&ns), "setup network"))
+		goto cleanup_cgroup;
+
+	skel = cgroup_storage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load program"))
+		goto cleanup_network;
+
+	skel->links.bpf_prog_no_map =
+		bpf_program__attach_cgroup(skel->progs.bpf_prog_no_map,
+					   cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.bpf_prog_no_map, "attach no map prog"))
+		goto cleanup_progs;
+
+	err = bpf_link_update(bpf_link__fd(skel->links.bpf_prog_no_map),
+			      bpf_program__fd(skel->progs.bpf_prog), NULL);
+	if (!ASSERT_OK(err, "bpf_link_update"))
+		goto cleanup_progs;
+
+	err = SYS_NOFAIL(PING_CMD);
+	ASSERT_OK(err, "first ping");
+	err = SYS_NOFAIL(PING_CMD);
+	ASSERT_NEQ(err, 0, "second ping");
+	err = SYS_NOFAIL(PING_CMD);
+	ASSERT_OK(err, "third ping");
+
+cleanup_progs:
+	cgroup_storage__destroy(skel);
+cleanup_network:
+	cleanup_network(ns);
+cleanup_cgroup:
+	close(cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_storage.c b/tools/testing/selftests/bpf/progs/cgroup_storage.c
index db1e4d2d3281..33a6013ca806 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_storage.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_storage.c
@@ -21,4 +21,10 @@ int bpf_prog(struct __sk_buff *skb)
 	return (*counter & 1);
 }
 
+SEC("cgroup_skb/egress")
+int bpf_prog_no_map(struct __sk_buff *skb)
+{
+	return 1;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


