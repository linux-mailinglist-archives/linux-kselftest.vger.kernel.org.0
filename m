Return-Path: <linux-kselftest+bounces-29198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66171A64833
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270BA170867
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147F226D0D;
	Mon, 17 Mar 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Px3F4wXs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21122ACD3;
	Mon, 17 Mar 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205181; cv=none; b=aCgtTK4Z/ulcwXogOvAFRrTODSZHxu3Apn/ys9hRIfTK/VSc4MyxBbhlU5a4buSzRpQ4jlP9ihqc3v8b7YCMuxuycm9Znj7BA2WWIw93vx7xgd9rR3Qr1mW+Jvdzlrvo5nctVcKrvs8JRUuE5MAs+uh4Nnaz/Xjl+NYGlGAHbgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205181; c=relaxed/simple;
	bh=ZG5kxGG80yT+wC6pgOpiIDlC4UZa5bpkuHW4Bf0jXLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUE72I22FincpDBhFKsO5owkBG2Vdx7fSMWbcIhL0lRwkjgurrK/qMQpgfx+r2yMRYQSofeShVpf9KyO7A1A08BGCmRQHZ0fag7QoZZCDq+ezIZfSGx7j4BKFFGMmtzyM/AtqPoaYDgtmieNCpr7SnhbpAHw4KEsCcZ6GaZZVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Px3F4wXs; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tu79S-00E8dI-Ae; Mon, 17 Mar 2025 10:52:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=aMx/ebEU2TmluYJADSJ8PMYLlDnHQ7biwjbfX3GHHD4=; b=Px3F4wXsRwoTyE69Z8/8odj6kn
	ji0Nc5ulI/ZftQWbCmgeCUafIFR14A2fFgyqe4omarS4j84uUJFqCGukl1o/o9A7Q4Tr6vxpnpufQ
	sKud9OEhYpih+byIhAMSFQDk9Qw8bupg5+U9gU8VYohzaO80xmiCGDB+c5CE2qxgFPJTCpVFvIFaB
	By4f4GzxjDy6KWxZ33HECY10HsWgD8C4MZNYgnMtU4tlL+cBCT//E+WhvVJv1NxVHhbITkXJrASDw
	1+a+LNG6T5biBaYrd/NeogNj7rxq4xsWN2i1L+bokpecr1fUYUPpLPCFjTeVXQ93amNVBjG2exYGT
	ciGVLIvg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tu79S-0006s8-00; Mon, 17 Mar 2025 10:52:54 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tu797-00DI8D-9p; Mon, 17 Mar 2025 10:52:33 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 17 Mar 2025 10:52:24 +0100
Subject: [PATCH net v4 2/3] selftest/bpf: Add test for AF_VSOCK connect()
 racing sockmap update
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-vsock-trans-signal-race-v4-2-fc8837f3f1d4@rbox.co>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
In-Reply-To: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Racing signal-interrupted connect() and sockmap update may result in an
unconnected (and missing vsock transport) socket in a sockmap.

Test spends 2 seconds attempting to reach WARN_ON_ONCE().

connect
  / state = SS_CONNECTED /
                                sock_map_update_elem
  if signal_pending
    state = SS_UNCONNECTED

connect
  transport = NULL
                                vsock_bpf_recvmsg
                                  WARN_ON_ONCE(!vsk->transport)

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1e3e4392dcca0e1722c1982ecc649a80c27443b2..2f8bba27866354848f1e30b5473cedb6a85244ff 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -3,6 +3,7 @@
 #include <error.h>
 #include <netinet/tcp.h>
 #include <sys/epoll.h>
+#include <linux/time64.h>
 
 #include "test_progs.h"
 #include "test_skmsg_load_helpers.skel.h"
@@ -1042,6 +1043,102 @@ static void test_sockmap_vsock_unconnected(void)
 	xclose(map);
 }
 
+#define CONNECT_SIGNAL_RACE_TIMEOUT 2 /* seconds */
+
+static void sig_handler(int signum)
+{
+	/* nop */
+}
+
+static void connect_signal_racer_cleanup(void *map)
+{
+	xclose(*(int *)map);
+}
+
+static void *connect_signal_racer(void *arg)
+{
+	pid_t pid;
+	int map;
+
+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
+			     sizeof(int), 1, NULL);
+	if (!ASSERT_OK_FD(map, "bpf_map_create"))
+		return NULL;
+
+	pthread_cleanup_push(connect_signal_racer_cleanup, &map);
+	pid = getpid();
+
+	for (;;) {
+		int c = *(int *)arg;
+		int zero = 0;
+
+		(void)bpf_map_update_elem(map, &zero, &c, BPF_ANY);
+
+		if (kill(pid, SIGUSR1)) {
+			FAIL_ERRNO("kill");
+			break;
+		}
+
+		if ((recv(c, NULL, 0, MSG_DONTWAIT) < 0) && errno == ENODEV) {
+			FAIL_ERRNO("recv");
+			break;
+		}
+	}
+
+	pthread_cleanup_pop(1);
+
+	return NULL;
+}
+
+static void test_sockmap_vsock_connect_signal_race(void)
+{
+	struct sockaddr_vm addr, bad_addr;
+	socklen_t alen = sizeof(addr);
+	sighandler_t orig_handler;
+	pthread_t thread;
+	int s, c, p;
+	__u64 tout;
+
+	orig_handler = signal(SIGUSR1, sig_handler);
+	if (!ASSERT_NEQ(orig_handler, SIG_ERR, "signal handler setup"))
+		return;
+
+	s = socket_loopback(AF_VSOCK, SOCK_SEQPACKET | SOCK_NONBLOCK);
+	if (s < 0)
+		goto restore;
+
+	if (xgetsockname(s, (struct sockaddr *)&addr, &alen))
+		goto close;
+
+	bad_addr = addr;
+	bad_addr.svm_cid = 0x42424242; /* non-existing */
+
+	if (xpthread_create(&thread, 0, connect_signal_racer, &c))
+		goto close;
+
+	tout = get_time_ns() + CONNECT_SIGNAL_RACE_TIMEOUT * NSEC_PER_SEC;
+	do {
+		c = xsocket(AF_VSOCK, SOCK_SEQPACKET, 0);
+		if (c < 0)
+			break;
+
+		if (connect(c, (struct sockaddr *)&addr, alen) && errno == EINTR)
+			(void)connect(c, (struct sockaddr *)&bad_addr, alen);
+
+		xclose(c);
+		p = accept(s, NULL, NULL);
+		if (p >= 0)
+			xclose(p);
+	} while (get_time_ns() < tout);
+
+	ASSERT_OK(pthread_cancel(thread), "pthread_cancel");
+	xpthread_join(thread, NULL);
+close:
+	xclose(s);
+restore:
+	ASSERT_NEQ(signal(SIGUSR1, orig_handler), SIG_ERR, "handler restore");
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1108,4 +1205,6 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_vsock_poll();
 	if (test__start_subtest("sockmap vsock unconnected"))
 		test_sockmap_vsock_unconnected();
+	if (test__start_subtest("sockmap vsock connect signal race"))
+		test_sockmap_vsock_connect_signal_race();
 }

-- 
2.48.1


