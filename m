Return-Path: <linux-kselftest+bounces-33946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8730AC6DD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E23AA19C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C73028D8FA;
	Wed, 28 May 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pK06utRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6828CF5D
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449056; cv=none; b=t5Ro3M7MnGlXIWMRk0YTGiU+gfD7BcugZtwEULgBJw3rivQwuQLnwxmZ19MLsQgYLqICNZVsL4q5CpIFLFLRueTHQaMuezWM88mgT00i/eF3W4YOnSVOvUC7ZnJmqv2ebLLNH8Gzd2ehY5CIA388JQU1vO84I4rg1M1TQgflNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449056; c=relaxed/simple;
	bh=eoA47rogCFpNR9Tkp0qdf/QF8lVs8dsGQjdd9xff9mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9dCQBFmyEExXJIAfc28MTKM87rFX1cvjJmZuH+aibrc0KAfTLjqkaukDzEHS8SmLfJ2NE8mdZi5C5Kh1fkbAGu+Z9xrtOVgAAsUnk1GsY82YX3yCKEq5dHmwdbsn7UrZGTs00g9M96W5N5wOzb+/sNyLBhLu99SVUqvxKUNGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pK06utRe; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748449050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pn98AFuFJVRfrXheY2sIBg6u+lxsCC5KB/mfc1OY4Tc=;
	b=pK06utRe4sZNQgZl6s+J01SB4EAoD/2YJCoowUhDM3w+6jdLWZ9bptn16zfUHGblnkealE
	9nzOtsd5RsEyrRkKIAykY9VdTqypr/jZGD8cESst1SN+bjfYqNG0RBrpBhbMhbvz+MK3Im
	5PVmtOw6N5ncYeu0tQSRmxycn0WxTP8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Feng Yang <yangfeng@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 2/2] bpf/selftests: Add test cases for retrieving classid
Date: Thu, 29 May 2025 00:16:26 +0800
Message-ID: <20250528161653.55162-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250528161653.55162-1-jiayuan.chen@linux.dev>
References: <20250528161653.55162-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Covers all scenarios where classid can be retrieved with bpf.

./test_progs -a cgroup_get_classid
53/1    cgroup_get_classid/get classid from tc:OK
53/2    cgroup_get_classid/get classid from sysctl:OK
53/3    cgroup_get_classid/get classid from cgroup dev:OK
53/4    cgroup_get_classid/get classid from cgroup sockopt:OK
53      cgroup_get_classid:OK
Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/cgroup_classid.c | 212 ++++++++++++++++++
 .../selftests/bpf/progs/test_cgroup_classid.c |  51 +++++
 2 files changed, 263 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_classid.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup_classid.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_classid.c b/tools/testing/selftests/bpf/prog_tests/cgroup_classid.c
new file mode 100644
index 000000000000..f00da952e52c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_classid.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+#include "test_cgroup_classid.skel.h"
+
+#define TEST_CGROUP "/cgroup_classid"
+
+static int test_cgroup_get_classid_from_tc(int cgroup_fd, int srv_fd, int srv_port, bool egress)
+{
+	struct test_cgroup_classid *skel;
+	int cli_fd = -1, ret = -1, expected;
+
+	LIBBPF_OPTS(bpf_tcx_opts, optl);
+
+	skel = test_cgroup_classid__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return ret;
+
+	skel->bss->classid = -1;
+	if (egress) {
+		expected = getpid();
+		skel->links.tc_egress =
+			bpf_program__attach_tcx(skel->progs.tc_egress, 1, &optl);
+	} else {
+		expected = 0;
+		skel->links.tc_ingress =
+			bpf_program__attach_tcx(skel->progs.tc_ingress, 1, &optl);
+	}
+
+	cli_fd = connect_to_fd_opts(srv_fd, NULL);
+	if (!ASSERT_GE(cli_fd, 0, "connect_to_fd_opts"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->classid, expected, "classid mismatch");
+	ret = 0;
+out:
+	if (cli_fd > 0)
+		close(cli_fd);
+
+	test_cgroup_classid__destroy(skel);
+	return ret;
+}
+
+static void test_cgroup_get_classid_tc(void)
+{
+	int srv_fd = -1, srv_port = -1;
+	int cgroup_fd = -1;
+
+	setup_classid_environment();
+	set_classid();
+	join_classid();
+
+	cgroup_fd = open_classid();
+	if (!ASSERT_GE(cgroup_fd, 0, "open_classid"))
+		goto out;
+
+	srv_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(srv_fd, 0, "srv_fd"))
+		goto out;
+
+	srv_port = get_socket_local_port(srv_fd);
+	if (!ASSERT_GE(srv_port, 0, "get_socket_local_port"))
+		goto out;
+
+	ASSERT_OK(test_cgroup_get_classid_from_tc(cgroup_fd, srv_fd, srv_port, 1), "egress");
+	ASSERT_OK(test_cgroup_get_classid_from_tc(cgroup_fd, srv_fd, srv_port, 0), "ingress");
+out:
+	if (srv_fd > 0)
+		close(srv_fd);
+	if (cgroup_fd > 0)
+		close(cgroup_fd);
+	cleanup_classid_environment();
+}
+
+static void test_cgroup_get_classid_cgroup_dev(void)
+{
+	struct test_cgroup_classid *skel = NULL;
+	int cgroup_fd = -1;
+
+	cgroup_fd = test__join_cgroup(TEST_CGROUP);
+	if (!ASSERT_GE(cgroup_fd, 0, "join cgroup"))
+		goto out;
+
+	if (!ASSERT_OK(setup_classid_environment(), "setup env"))
+		goto out;
+
+	if (!ASSERT_OK(set_classid(), "set_classid"))
+		goto out;
+
+	skel = test_cgroup_classid__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load program"))
+		goto out;
+
+	skel->links.cg_dev =
+		bpf_program__attach_cgroup(skel->progs.cg_dev, cgroup_fd);
+
+	if (!ASSERT_OK_PTR(skel->links.cg_dev, "attach_program"))
+		goto out;
+
+	skel->bss->classid = -1;
+	if (!ASSERT_OK(join_classid(), "join_classid"))
+		goto out;
+
+	open("/dev/null", O_RDWR);
+	ASSERT_EQ(skel->bss->classid, getpid(), "classid mismatch");
+out:
+	if (cgroup_fd > 0)
+		close(cgroup_fd);
+	test_cgroup_classid__destroy(skel);
+	cleanup_classid_environment();
+}
+
+static void test_cgroup_get_classid_sysctl(void)
+{
+	struct test_cgroup_classid *skel = NULL;
+	int cgroup_fd = -1;
+
+	cgroup_fd = test__join_cgroup(TEST_CGROUP);
+	if (!ASSERT_GE(cgroup_fd, 0, "join cgroup"))
+		goto out;
+
+	if (!ASSERT_OK(setup_classid_environment(), "setup env"))
+		goto out;
+
+	if (!ASSERT_OK(set_classid(), "set_classid"))
+		goto out;
+
+	skel = test_cgroup_classid__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load program"))
+		goto out;
+
+	skel->links.sysctl_tcp_mem =
+		bpf_program__attach_cgroup(skel->progs.sysctl_tcp_mem, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.sysctl_tcp_mem, "attach_program"))
+		goto out;
+
+	skel->bss->classid = -1;
+	if (!ASSERT_OK(join_classid(), "join_classid"))
+		goto out;
+
+	SYS_NOFAIL("cat /proc/sys/net/ipv4/tcp_mem");
+	ASSERT_EQ(skel->bss->classid, getpid(), "classid mismatch");
+out:
+	if (cgroup_fd > 0)
+		close(cgroup_fd);
+	test_cgroup_classid__destroy(skel);
+	cleanup_classid_environment();
+}
+
+static void test_cgroup_get_classid_sockopt(void)
+{
+	struct test_cgroup_classid *skel = NULL;
+	int cgroup_fd = -1, fd = -1, val, err;
+	socklen_t val_len;
+
+	cgroup_fd = test__join_cgroup(TEST_CGROUP);
+	if (!ASSERT_GE(cgroup_fd, 0, "join cgroup"))
+		goto out;
+
+	if (!ASSERT_OK(setup_classid_environment(), "setup env"))
+		goto out;
+
+	if (!ASSERT_OK(set_classid(), "set_classid"))
+		goto out;
+
+	skel = test_cgroup_classid__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load program"))
+		goto out;
+
+	skel->links.cg_getsockopt =
+		bpf_program__attach_cgroup(skel->progs.cg_getsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.cg_getsockopt, "attach_program"))
+		goto out;
+
+	skel->bss->classid = -1;
+	if (!ASSERT_OK(join_classid(), "join_classid"))
+		goto out;
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_OK_FD(fd, "socket"))
+		goto out;
+
+	val_len = sizeof(val);
+	err = getsockopt(fd,  SOL_SOCKET, SO_SNDBUF, &val, &val_len);
+	if (!ASSERT_OK(err, "getsockopt"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->classid, getpid(), "classid mismatch");
+out:
+	if (fd > 0)
+		close(fd);
+	if (cgroup_fd > 0)
+		close(cgroup_fd);
+	test_cgroup_classid__destroy(skel);
+	cleanup_classid_environment();
+}
+
+void test_cgroup_get_classid(void)
+{
+	if (test__start_subtest("get classid from tc"))
+		test_cgroup_get_classid_tc();
+	if (test__start_subtest("get classid from sysctl"))
+		test_cgroup_get_classid_sysctl();
+	if (test__start_subtest("get classid from cgroup dev"))
+		test_cgroup_get_classid_cgroup_dev();
+	if (test__start_subtest("get classid from cgroup sockopt"))
+		test_cgroup_get_classid_sockopt();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_cgroup_classid.c b/tools/testing/selftests/bpf/progs/test_cgroup_classid.c
new file mode 100644
index 000000000000..7a555ba6bb17
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cgroup_classid.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <sys/socket.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+int classid;
+
+SEC("tc/egress")
+int tc_egress(struct __sk_buff *skb)
+{
+	/* expecte real classid */
+	classid = bpf_get_cgroup_classid(skb);
+	return TCX_PASS;
+}
+
+SEC("tc/ingress")
+int tc_ingress(struct __sk_buff *skb)
+{
+	/* expecte 0 */
+	classid = bpf_get_cgroup_classid(skb);
+	return TCX_PASS;
+}
+
+SEC("cgroup/dev")
+int cg_dev(struct bpf_cgroup_dev_ctx *ctx)
+{
+	/* expecte real classid */
+	classid = bpf_get_cgroup_classid((struct __sk_buff *)ctx);
+	/* Allow all */
+	return 1;
+}
+
+SEC("cgroup/sysctl")
+int sysctl_tcp_mem(struct bpf_sysctl *ctx)
+{
+	/* expecte real classid */
+	classid = bpf_get_cgroup_classid((struct __sk_buff *)ctx);
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int cg_getsockopt(struct bpf_sockopt *ctx)
+{
+	/* expecte real classid */
+	classid = bpf_get_cgroup_classid((struct __sk_buff *)ctx);
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


