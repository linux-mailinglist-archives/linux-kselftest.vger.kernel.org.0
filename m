Return-Path: <linux-kselftest+bounces-31627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 765A0A9BE49
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 08:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEDD77AC05A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 06:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD68B22B8B9;
	Fri, 25 Apr 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nKeKcv2d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A378322ACF2
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560888; cv=none; b=nariSvy8G5auvJbF24jvi0UhmDLZ6HFi50YrH+ThQeuZojPd3ZaadfpC8nshTG6MWnj5jysbC2KhGPXFxQGtXRmmZs1cuUX+kk9w+97PXM4k37VnENZqhplh4rBmD/TKfKPA57mxU04I/go9cyXr4WtivGVlaC0UvJraRIa2dsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560888; c=relaxed/simple;
	bh=sA9Q/znoXHcWQsR+79qS0YGoQq7U9GSlRw37bCGWW44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zjr7/dP0IZ/+EUGWoEXuV6Sg+VwppQOJ3CBRsUaeiLIXYpbHGfnyvvPrr3vx64J+k+7HkfibAs/7OFW4SvIaHFnyZFt/ol2TuKAaUSZ05ejUDFUXzrWv4FbuQrUB8R+mft0R4+InG2BOb/UUzyil5V/vy00P9kOM+iwf2cKyq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nKeKcv2d; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745560884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zo0TboDVGXZ7xN4lEDDgR1Zc9tJYQZ0/Nurz8YEz4I=;
	b=nKeKcv2dL+7575VQeXNV0t5ax/uxZjoQpTh1PFwTt2pPt0CUnlMv+HYw90zz/Ag2yggC+9
	IvbcYm4yalF2vBr7PDMoUNyDvtFiP+GMaV9e0rbeA+KpECvh+UxKKAf45EvqYM9yhYiUpA
	XYeUcXwnKvvm5iXWX2fZukpxpVHep8M=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add test to cover sockmap with ktls
Date: Fri, 25 Apr 2025 13:59:58 +0800
Message-ID: <20250425060015.6968-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250425060015.6968-1-jiayuan.chen@linux.dev>
References: <20250425060015.6968-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The selftest can reproduce an issue where we miss the uncharge operation
when freeing msg, which will cause the following warning. We fixed the
issue and added this reproducer to selftest to ensure it will not happen
again.

------------[ cut here ]------------
WARNING: CPU: 1 PID: 40 at net/ipv4/af_inet.c inet_sock_destruct+0x173/0x1d5
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
Workqueue: events sk_psock_destroy
RIP: 0010:inet_sock_destruct+0x173/0x1d5
RSP: 0018:ffff8880085cfc18 EFLAGS: 00010202
RAX: 1ffff11003dbfc00 RBX: ffff88801edfe3e8 RCX: ffffffff822f5af4
RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff88801edfe16c
RBP: ffff88801edfe184 R08: ffffed1003dbfc31 R09: 0000000000000000
R10: ffffffff822f5ab7 R11: ffff88801edfe187 R12: ffff88801edfdec0
R13: ffff888020376ac0 R14: ffff888020376ac0 R15: ffff888020376a60
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556365155830 CR3: 000000001d6aa000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __sk_destruct+0x46/0x222
 sk_psock_destroy+0x22f/0x242
 process_one_work+0x504/0x8a8
 ? process_one_work+0x39d/0x8a8
 ? __pfx_process_one_work+0x10/0x10
 ? worker_thread+0x44/0x2ae
 ? __list_add_valid_or_report+0x83/0xea
 ? srso_return_thunk+0x5/0x5f
 ? __list_add+0x45/0x52
 process_scheduled_works+0x73/0x82
 worker_thread+0x1ce/0x2ae

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 76 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   | 10 +++
 2 files changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 49b85c1c7552..8f07168c9de6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -306,6 +306,80 @@ static void test_sockmap_ktls_tx_cork(int family, int sotype, bool push)
 	test_sockmap_ktls__destroy(skel);
 }
 
+static void test_sockmap_ktls_tx_no_buf(int family, int sotype, bool push)
+{
+	int c = 0, p = 0, one = 1, two = 2;
+	struct test_sockmap_ktls *skel;
+	unsigned char *data = NULL;
+	struct msghdr msg = {0};
+	struct iovec iov[2];
+	int prog_fd, map_fd;
+	int txrx_buf = 1024;
+	int iov_length = 8192;
+	int err;
+
+	skel = test_sockmap_ktls__open_and_load();
+	if (!ASSERT_TRUE(skel, "open ktls skel"))
+		return;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair()"))
+		goto out;
+
+	err = setsockopt(c, SOL_SOCKET, SO_RCVBUFFORCE, &txrx_buf, sizeof(int));
+	err |= setsockopt(p, SOL_SOCKET, SO_SNDBUFFORCE, &txrx_buf, sizeof(int));
+	if (!ASSERT_OK(err, "set buf limit"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy_redir);
+	map_fd = bpf_map__fd(skel->maps.sock_map);
+
+	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach sk msg"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &one, &c, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &two, &p, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p)"))
+		goto out;
+
+	skel->bss->apply_bytes = 1024;
+
+	err = init_ktls_pairs(c, p);
+	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
+		goto out;
+
+	data = calloc(iov_length, sizeof(char));
+	if (!data)
+		goto out;
+
+	iov[0].iov_base = data;
+	iov[0].iov_len = iov_length;
+	iov[1].iov_base = data;
+	iov[1].iov_len = iov_length;
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 2;
+
+	for (;;) {
+		err = sendmsg(c, &msg, MSG_DONTWAIT);
+		if (err <= 0)
+			break;
+	}
+
+out:
+	if (data)
+		free(data);
+	if (c)
+		close(c);
+	if (p)
+		close(p);
+
+	test_sockmap_ktls__destroy(skel);
+}
+
 static void run_tests(int family, enum bpf_map_type map_type)
 {
 	int map;
@@ -330,6 +404,8 @@ static void run_ktls_test(int family, int sotype)
 		test_sockmap_ktls_tx_cork(family, sotype, false);
 	if (test__start_subtest("tls tx cork with push"))
 		test_sockmap_ktls_tx_cork(family, sotype, true);
+	if (test__start_subtest("tls tx egress with no buf"))
+		test_sockmap_ktls_tx_no_buf(family, sotype, true);
 }
 
 void test_sockmap_ktls(void)
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
index e0f757929ef4..8bdb9987c0c7 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
@@ -6,6 +6,7 @@
 int cork_byte;
 int push_start;
 int push_end;
+int apply_bytes;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
@@ -24,3 +25,12 @@ int prog_sk_policy(struct sk_msg_md *msg)
 
 	return SK_PASS;
 }
+
+SEC("sk_msg")
+int prog_sk_policy_redir(struct sk_msg_md *msg)
+{
+	int two = 2;
+
+	bpf_msg_apply_bytes(msg, apply_bytes);
+	return bpf_msg_redirect_map(msg, &sock_map, two, 0);
+}
-- 
2.47.1


