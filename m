Return-Path: <linux-kselftest+bounces-30332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A2A7F657
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 09:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351253AC535
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88318263C6D;
	Tue,  8 Apr 2025 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vAF6DArQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699D2638B8
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097531; cv=none; b=uG8ff8dpzizl9+pfLqDdq6xlTcdle6kvfUPwAZLLiVWut69hqo1tGzfx0JtbznyLvqQP3ElW30EWxvSn1XkW4N8l2fm7gP5I+rLmuQeblE3Mz75gAGZgbXMBtxnvMoLfli5E9P2fJbjZAr5TpbQU92jGlNc3hOYcI3MTsUdKzX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097531; c=relaxed/simple;
	bh=ZOHoR1DVLuoqBGux5wOEYgvMSK5hDjDDqM2npNWq+30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImWL0uZy/XCJ6MvRIxu0cIcVksNFj7hL/JM/QqzWP/AY1ugB49yJ2c4QJAaF6GK1CXVCR9vV/3SFgOdTPCnPwMJ8bVbAXTAB3ARZRT596y5uhDO7Wjydu8YJAoLec6UOOHdfXjWczcbH7tm9ICtwpWgNHQHtpzm8asaOB+1DaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vAF6DArQ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744097527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLSYPFz/nwodbHpxtrd6necAV0xMxciGJi0Eu7RL7/E=;
	b=vAF6DArQxICiHwPXm3kZnG6hCFPfTSX4JcMnXXDJ1UL60dr3mPnIXNE5zna9W9KVTAQuk3
	BC5omLqJaoKkUI53/UjzTIBU+a4JSPhJEVFbbgXGsJYb6Qs4TtJ++eq+2W1HdnV++Sxx/y
	jCc8DGGtk4d9o53hjXvnBLxd0Pl2ea8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Add edge case tests for sockmap
Date: Tue,  8 Apr 2025 15:29:54 +0800
Message-ID: <20250408073033.60377-4-jiayuan.chen@linux.dev>
In-Reply-To: <20250408073033.60377-1-jiayuan.chen@linux.dev>
References: <20250408073033.60377-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add edge case tests for sockmap.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/socket_helpers.h | 13 +++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 60 +++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 1bdfb79ef009..a805143dd84f 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -313,11 +313,22 @@ static inline int recv_timeout(int fd, void *buf, size_t len, int flags,
 
 static inline int create_pair(int family, int sotype, int *p0, int *p1)
 {
-	__close_fd int s, c = -1, p = -1;
+	__close_fd int s = -1, c = -1, p = -1;
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
 	int err;
 
+	if (family == AF_UNIX) {
+		int fds[2];
+
+		err = socketpair(family, sotype, 0, fds);
+		if (!err) {
+			*p0 = fds[0];
+			*p1 = fds[1];
+		}
+		return err;
+	}
+
 	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return s;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1e3e4392dcca..c72357f41035 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1042,6 +1042,59 @@ static void test_sockmap_vsock_unconnected(void)
 	xclose(map);
 }
 
+void *close_thread(void *arg)
+{
+	int *fd = (int *)arg;
+
+	sleep(1);
+	close(*fd);
+	*fd = -1;
+	return NULL;
+}
+
+void test_sockmap_with_close_on_write(int family, int sotype)
+{
+	struct test_sockmap_pass_prog *skel;
+	int err, map, verdict;
+	pthread_t tid;
+	int zero = 0;
+	int c = -1, p = -1;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &p, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	err = pthread_create(&tid, 0, close_thread, &p);
+	if (!ASSERT_OK(err, "pthread_create"))
+		goto out;
+
+	while (p > 0)
+		send(c, "a", 1, MSG_NOSIGNAL);
+
+	pthread_join(tid, NULL);
+out:
+	if (c > 0)
+		close(c);
+	if (p > 0)
+		close(p);
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1108,4 +1161,11 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_vsock_poll();
 	if (test__start_subtest("sockmap vsock unconnected"))
 		test_sockmap_vsock_unconnected();
+	if (test__start_subtest("sockmap with write on close")) {
+		test_sockmap_with_close_on_write(AF_UNIX, SOCK_STREAM);
+		test_sockmap_with_close_on_write(AF_UNIX, SOCK_DGRAM);
+		test_sockmap_with_close_on_write(AF_INET, SOCK_STREAM);
+		test_sockmap_with_close_on_write(AF_INET, SOCK_DGRAM);
+		test_sockmap_with_close_on_write(AF_VSOCK, SOCK_STREAM);
+	}
 }
-- 
2.47.1


