Return-Path: <linux-kselftest+bounces-29191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA94A64733
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E29189558C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A7E22422E;
	Mon, 17 Mar 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RNA2CAAn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16BE22259D;
	Mon, 17 Mar 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203423; cv=none; b=biZIsp/URFnalQ/glTyhT/VXiZDJ4FkAEjrC8xiGFU1vytMrpqKon+LsLZwMVxcG1pEQ3igzqbfLhxLU1RonjP+oWSXQ2c+zPSXwNy7Vww67bqwW7ObPJa/UDtPp70zRO5VZDPzKhh61b/xG/Ec05/xFk8HTJODmeBFN0Z71x/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203423; c=relaxed/simple;
	bh=ZOHoR1DVLuoqBGux5wOEYgvMSK5hDjDDqM2npNWq+30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKwCFQFZznTZ8OF9g/FGNjYDaVwrD7oHCfiwFqgZyROUs4kVn1HGfmGWLbwGjXpm+WuxHpR5woaWoVTYJUpZQba6BSSqHs/W4R0jRk8zdSI/siUBPcSJeeG2UOMcniSyQqq/oNGEPK219Hjcz5PMUdC3ZbT8iajTzV/Ka+5TtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RNA2CAAn; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742203419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLSYPFz/nwodbHpxtrd6necAV0xMxciGJi0Eu7RL7/E=;
	b=RNA2CAAnuPOFBDghPRo59PAWyHNhb/EZS0Iojw2W4OL9J7bW9AOp3MYTnEYVcExyrnymyM
	6xFpwefmKLIQY6JiKke1uaAlB764IntP1LH3Mq8LnS4puuSRhXKauBLXb9eyal2rJo3HeX
	wdhm4ypkvHh6qn+dmKe8Jy3AUNt2yms=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xiyou.wangcong@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add edge case tests for sockmap
Date: Mon, 17 Mar 2025 17:22:56 +0800
Message-ID: <20250317092257.68760-4-jiayuan.chen@linux.dev>
In-Reply-To: <20250317092257.68760-1-jiayuan.chen@linux.dev>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
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


