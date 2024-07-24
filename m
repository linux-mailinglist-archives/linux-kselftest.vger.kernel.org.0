Return-Path: <linux-kselftest+bounces-14147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0993B06A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 13:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D27B21DDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746DF158D83;
	Wed, 24 Jul 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="oEfu2Y9K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54391586FE;
	Wed, 24 Jul 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820834; cv=none; b=egPimP0mJXviQBjv5TvjV7ExpD85lwkNe5kw+QWeJhf+w+eEcKwDVVbSVxpgt1XVvSpdV9/ikGHdUfeM7+gOAje369ZvTQoUvMVduXRSlXkFmKzmPDnmXrkQKKZWOfgJ51PqXC0j8+Te5gf1ZsM7oHWpVgTshmVbtC8N92XUbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820834; c=relaxed/simple;
	bh=/9JY3OeEpMw0Z5aH0w6Kb1o4Vl9pHCADoDUMF4b8IVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n191Vj3/bK985FbAIzfC9J6AtsG2Hc2rIDW5XxKvehfa2GtIpAO2W3VangJfbyd18Q80RCGg5UbHHpZiI8C/IaoJnxEvCGegXepiG7ZukKNMqU+8th6W3lCXQ2bR1FSZOW3xEgpRMAgC4A94L1YVL7wUioBw3g2Fms8LbuekirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=oEfu2Y9K; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFb-006K1a-79; Wed, 24 Jul 2024 13:33:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=OPcSTjGJ8x+i82SsvkO5m3xrDrnaWvBVoQakBy6iybg=; b=oEfu2Y9Ki0CWmkqKZi4Zs971Xs
	ZAhviLZwyJe3jQ4BU1Xuo5ivACzQgRq7o9jtaehdTP+19DlANfKV6YbWnGwZqrVGzWk8+l5NtS4Pi
	G33UR8hK+SaTTg63VgHanPRHNP6gP7rOd/wiYAOH2df+1qoC2mPiV8Hm0eEcZGGNwdhxjKcOCvHQI
	Vg3fGuz5kJHceH0hdbq3vMjKaBXGJWulBTKU+j4cFImL1VJ2yJ/swP7mCZek4uQflAAXkbf8XA1iJ
	7hovRTp/NRUmfpa5HAVNS0ulafV0QKz/Yom5bKhfbJR6h4WgSIKhG5JaWyvks9vGVGOrMS5EoF6lb
	GUrFUT8g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFa-0004yH-RH; Wed, 24 Jul 2024 13:33:43 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sWaFL-00EK6H-AY; Wed, 24 Jul 2024 13:33:27 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 24 Jul 2024 13:32:37 +0200
Subject: [PATCH bpf 1/6] selftest/bpf: Support more socket types in
 create_pair()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-sockmap-selftest-fixes-v1-1-46165d224712@rbox.co>
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.0

Extend the function to allow creating socket pairs of SOCK_STREAM,
SOCK_DGRAM and SOCK_SEQPACKET.

Adapt direct callers and leave further cleanups for the following patch.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  19 +--
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 138 ++++++++++++++-------
 2 files changed, 96 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1337153eb0ad..5b17d69c9ee6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -451,11 +451,11 @@ static void test_sockmap_progs_query(enum bpf_attach_type attach_type)
 #define MAX_EVENTS 10
 static void test_sockmap_skb_verdict_shutdown(void)
 {
+	int n, err, map, verdict, c1 = -1, p1 = -1;
 	struct epoll_event ev, events[MAX_EVENTS];
-	int n, err, map, verdict, s, c1 = -1, p1 = -1;
 	struct test_sockmap_pass_prog *skel;
-	int epollfd;
 	int zero = 0;
+	int epollfd;
 	char b;
 
 	skel = test_sockmap_pass_prog__open_and_load();
@@ -469,10 +469,7 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
 
-	s = socket_loopback(AF_INET, SOCK_STREAM);
-	if (s < 0)
-		goto out;
-	err = create_pair(s, AF_INET, SOCK_STREAM, &c1, &p1);
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
 	if (err < 0)
 		goto out;
 
@@ -570,16 +567,12 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 
 static void test_sockmap_skb_verdict_peek_helper(int map)
 {
-	int err, s, c1, p1, zero = 0, sent, recvd, avail;
+	int err, c1, p1, zero = 0, sent, recvd, avail;
 	char snd[256] = "0123456789";
 	char rcv[256] = "0";
 
-	s = socket_loopback(AF_INET, SOCK_STREAM);
-	if (!ASSERT_GT(s, -1, "socket_loopback(s)"))
-		return;
-
-	err = create_pair(s, AF_INET, SOCK_STREAM, &c1, &p1);
-	if (!ASSERT_OK(err, "create_pairs(s)"))
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(err, "create_pair()"))
 		return;
 
 	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index e880f97bc44d..77b73333f091 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -3,6 +3,9 @@
 
 #include <linux/vm_sockets.h>
 
+/* include/linux/net.h */
+#define SOCK_TYPE_MASK 0xf
+
 #define IO_TIMEOUT_SEC 30
 #define MAX_STRERR_LEN 256
 #define MAX_TEST_NAME 80
@@ -312,54 +315,6 @@ static inline int add_to_sockmap(int sock_mapfd, int fd1, int fd2)
 	return xbpf_map_update_elem(sock_mapfd, &key, &value, BPF_NOEXIST);
 }
 
-static inline int create_pair(int s, int family, int sotype, int *c, int *p)
-{
-	struct sockaddr_storage addr;
-	socklen_t len;
-	int err = 0;
-
-	len = sizeof(addr);
-	err = xgetsockname(s, sockaddr(&addr), &len);
-	if (err)
-		return err;
-
-	*c = xsocket(family, sotype, 0);
-	if (*c < 0)
-		return errno;
-	err = xconnect(*c, sockaddr(&addr), len);
-	if (err) {
-		err = errno;
-		goto close_cli0;
-	}
-
-	*p = xaccept_nonblock(s, NULL, NULL);
-	if (*p < 0) {
-		err = errno;
-		goto close_cli0;
-	}
-	return err;
-close_cli0:
-	close(*c);
-	return err;
-}
-
-static inline int create_socket_pairs(int s, int family, int sotype,
-				      int *c0, int *c1, int *p0, int *p1)
-{
-	int err;
-
-	err = create_pair(s, family, sotype, c0, p0);
-	if (err)
-		return err;
-
-	err = create_pair(s, family, sotype, c1, p1);
-	if (err) {
-		close(*c0);
-		close(*p0);
-	}
-	return err;
-}
-
 static inline int enable_reuseport(int s, int progfd)
 {
 	int err, one = 1;
@@ -412,5 +367,92 @@ static inline int socket_loopback(int family, int sotype)
 	return socket_loopback_reuseport(family, sotype, -1);
 }
 
+static inline int create_pair(int family, int sotype, int *p0, int *p1)
+{
+	struct sockaddr_storage addr;
+	socklen_t len = sizeof(addr);
+	int s, c, p, err;
+
+	s = socket_loopback(family, sotype);
+	if (s < 0)
+		return s;
+
+	err = xgetsockname(s, sockaddr(&addr), &len);
+	if (err)
+		goto close_s;
+
+	c = xsocket(family, sotype, 0);
+	if (c < 0) {
+		err = c;
+		goto close_s;
+	}
+
+	err = connect(c, sockaddr(&addr), len);
+	if (err) {
+		if (errno != EINPROGRESS) {
+			FAIL_ERRNO("connect");
+			goto close_c;
+		}
+
+		err = poll_connect(c, IO_TIMEOUT_SEC);
+		if (err) {
+			FAIL_ERRNO("poll_connect");
+			goto close_c;
+		}
+	}
+
+	switch (sotype & SOCK_TYPE_MASK) {
+	case SOCK_DGRAM:
+		err = xgetsockname(c, sockaddr(&addr), &len);
+		if (err)
+			goto close_c;
+
+		err = xconnect(s, sockaddr(&addr), len);
+		if (!err) {
+			*p0 = s;
+			*p1 = c;
+			return err;
+		}
+		break;
+	case SOCK_STREAM:
+	case SOCK_SEQPACKET:
+		p = xaccept_nonblock(s, NULL, NULL);
+		if (p >= 0) {
+			*p0 = p;
+			*p1 = c;
+			goto close_s;
+		}
+
+		err = p;
+		break;
+	default:
+		FAIL("Unsupported socket type %#x", sotype);
+		err = -EOPNOTSUPP;
+	}
+
+close_c:
+	close(c);
+close_s:
+	close(s);
+	return err;
+}
+
+static inline int create_socket_pairs(int s, int family, int sotype,
+				      int *c0, int *c1, int *p0, int *p1)
+{
+	int err;
+
+	err = create_pair(family, sotype, c0, p0);
+	if (err)
+		return err;
+
+	err = create_pair(family, sotype, c1, p1);
+	if (err) {
+		close(*c0);
+		close(*p0);
+	}
+
+	return err;
+}
 
 #endif // __SOCKMAP_HELPERS__

-- 
2.45.2


