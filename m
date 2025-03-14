Return-Path: <linux-kselftest+bounces-29051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09251A614AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 16:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CB617B7CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14C5202989;
	Fri, 14 Mar 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="SyABiwyg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F61FFC50;
	Fri, 14 Mar 2025 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965643; cv=none; b=hlL0U+9QjCPec7GZl+P85hK8A2Z3UOyBqYXcIGviJEeqrzcLtAcKmxvxxmOykSxqU87IW7PsCvhRIxJLJKIECLmZNSEf5PdcdFFIxt9ul4WwINMiTiEMlxtg2Pg1vdqsfg1BgglTbUwJ6TuS0IdjVa5mxp1tvxtTp53T/yAhW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965643; c=relaxed/simple;
	bh=L+KTJGvZZL6WNwZ6CkOfjghyQtuOOIuC3o33rScf4Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndiYMlmRGIOkW5sCVS40XEXRV9TCgBP0wYeHebeabHvi2NN9RC17dbFx1P44fuU3Kh6vJrlsRM3gCVPHNvYxjwKFpYtvj9KKobV20F3In4Js6ePxHmF73g8ThD4+OPWU1k8IDguajVIoUq76SJ+wNp/WRtiDWCX/P88MLW8jlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=SyABiwyg; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tt6pt-006FJv-7C; Fri, 14 Mar 2025 16:20:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=75aQS4EfbBkL1uqPvlHJ3IbPh6aVg1PW4sCCjIyt6CQ=; b=SyABiwyg3y0nW0o10MYkGiGD+7
	28/m8lG0cfTxXOSaZbC3zjJSVTvxQzl1BsznqpICN5TSaPSP4/rSE7YMT4rktiKA3W1DLaN+pDE33
	hdbUoBcI6pIGsY9FQGA0mtT5RV6Vs1h0NCQB6o98XpXLqNQU49SRmFP8bnMDGfEl3qPRM3/YugacX
	b44w1uj9GMxNHycB+OXP76Pxq3/wP7DyDw7pVSoS/nZJV71X5DAoD9TKi46OwZgweOkUaAtRohfCG
	O9D7AGM4gjVJkwr9MavKK2nbdmHDLAnnTRyZfeTL96sAYZdXf2yNKflX0L91JBQZoCSnJh8zJApK2
	8jRC7Nrw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tt6pn-0007cc-H8; Fri, 14 Mar 2025 16:20:27 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tt6pc-00H06E-2g; Fri, 14 Mar 2025 16:20:16 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 14 Mar 2025 16:19:35 +0100
Subject: [PATCH net v2 2/3] selftest/bpf: Add test for AF_VSOCK connect()
 racing sockmap update
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-vsock-trans-signal-race-v2-2-421a41f60f42@rbox.co>
References: <20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co>
In-Reply-To: <20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co>
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
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1e3e4392dcca0e1722c1982ecc649a80c27443b2..5c278353a924294a1452f650634cec0539804b1a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -3,6 +3,7 @@
 #include <error.h>
 #include <netinet/tcp.h>
 #include <sys/epoll.h>
+#include <linux/time64.h>
 
 #include "test_progs.h"
 #include "test_skmsg_load_helpers.skel.h"
@@ -1042,6 +1043,114 @@ static void test_sockmap_vsock_unconnected(void)
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
+	int map;
+
+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
+			     sizeof(int), 1, NULL);
+	if (!ASSERT_OK_FD(map, "bpf_map_create"))
+		return NULL;
+
+	pthread_cleanup_push(connect_signal_racer_cleanup, &map);
+
+	for (;;) {
+		int c = *(int *)arg;
+		int zero = 0;
+
+		(void)bpf_map_update_elem(map, &zero, &c, BPF_ANY);
+
+		if (kill(0, SIGUSR1)) {
+			FAIL_ERRNO("kill");
+			break;
+		}
+
+		pthread_testcancel();
+	}
+
+	pthread_cleanup_pop(1);
+
+	return NULL;
+}
+
+static void test_sockmap_vsock_connect_signal_race(void)
+{
+	struct sockaddr_vm addr = {
+		.svm_family = AF_VSOCK,
+		.svm_cid = VMADDR_CID_LOCAL,
+		.svm_port = VMADDR_PORT_ANY
+	};
+	struct sockaddr_vm bad_addr;
+	sighandler_t orig_handler;
+	pthread_t thread;
+	socklen_t alen;
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
+	alen = sizeof(addr);
+	if (xgetsockname(s, (struct sockaddr *)&addr, &alen) < 0)
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
+		if (!connect(c, (struct sockaddr *)&addr, alen) ||
+		    errno != EINTR)
+			goto retry;
+
+		if (!connect(c, (struct sockaddr *)&bad_addr, alen) ||
+		    errno != ESOCKTNOSUPPORT)
+			goto retry;
+
+		if ((recv(c, &(char){0}, 1, MSG_DONTWAIT) < 0) &&
+		    errno == ENODEV) {
+			FAIL_ERRNO("recv");
+			tout = 0;
+		}
+retry:
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
@@ -1108,4 +1217,6 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_vsock_poll();
 	if (test__start_subtest("sockmap vsock unconnected"))
 		test_sockmap_vsock_unconnected();
+	if (test__start_subtest("sockmap vsock connect signal race"))
+		test_sockmap_vsock_connect_signal_race();
 }

-- 
2.48.1


