Return-Path: <linux-kselftest+bounces-18180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD4E97D8D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 19:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6081F24E7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC29C185920;
	Fri, 20 Sep 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bwW7vOG5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373118453E
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851769; cv=none; b=bgWuPaF+mwtYOft+d3b7od/eGtT/Uw6OTARy8j8e5g74UlZFWgKKtrZU4AEDFJvUGNUGj7OZVarQbWtfbmDMLvp/l13oH/56quuyCGNzQ74Gb9viHKwIaJoltHRRUdlHQZ49112KpqsK+4exfkagRTPCGj4abX0pdyz1IwTc67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851769; c=relaxed/simple;
	bh=6jsLEb0C8rdq7VDmohj4Ns2SNUA7feYh+nsP+pP6g2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBLsXZ0KsNiNTVxhZ1l1bygPIxCfjKCXkdgf/1uezCbmqmNksd9IQkhN6lEYvzx4iihbBue6qu2vcZBSoIiwmwjayqJiPuTFWiPAFWqRtkk+x/PosrBnFgY+Bt4lmYDQEtzTflCcfAgbIL9zH0BU7OtlL2805/9xTRgJti94cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bwW7vOG5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso27314575e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726851766; x=1727456566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SJJEI41L6DAw5qSjBYrpeTyLVVZdoMRJaxTx6iDMqc=;
        b=bwW7vOG5za4XECZQ5gxpZ0GwfAKnv3yuBfN2e1EOMMvJzqxGUX+RxWsZt4fElOZYdf
         aeiCRXi/DQReBe5ehwKfueEPenONov2eNozWF5jT4XvqUXxi6u9/bcxhTjJUXysBbnhU
         ncrS2oMoGgUA2sa6EFKr7KWWvkmULBQDATkBmAvXS/JwMAhFRABAZ+3Aa3id8LIUUMhW
         ow2XYjQLDJh76/+BbcwvKbM3QYMRv+jX/1eers3aaQuJWE2eT2CurPFmVKeZOK2B02oj
         CRWq18bZy9nBVJ0Rm9CQeOoRSTCk+zfBGZ1NTZFntrSjESSRHr6GZht4Idk819ZEFgFi
         OJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851766; x=1727456566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SJJEI41L6DAw5qSjBYrpeTyLVVZdoMRJaxTx6iDMqc=;
        b=IntSuGKQN0Vko3JrcQkJts64synPBdXrOhG+fX/XIAfWRguJK7zo6laGgU6wfKSRZM
         LEysrVqp6HTjud96OxZpWYy+U32Bwpj1bnhRfkOJ5T2ZJOfTZjzM3cp9DJj5kKb1KXep
         xrxOHkBOt6nRH5N1klboaFBmaK1uht25HXXAFwDJH1LxTyRqbtDV+/N0sS5ljUPFBAZL
         Y0YXcNtrEKmgrIrPgrhNUGmMvhvH3ntwd2280V4n/6LR2eoc5f0wPZV5gP+gMtINmLfN
         7KawlTMBJb/prB4+U9CtnNhbZkD9Jn3w3mp78CWKHtr55tdfz7pX+47EAugVcOIGWvjI
         zuSw==
X-Forwarded-Encrypted: i=1; AJvYcCXMUVHok4QEiTpZxo9zXvB12IBR1shg43goxGGbjVcwiuReiIej+qjZQtuoq1AaUwDzGCFkgW4Z29ILDAzc2fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjBukvoWldIIJ0RbMgMoBG2WVZ5P1r8wB/k0MmNHhxKh73VT1O
	cfvv4D9MU7GZQHl0UGKdTdpGWloziPEh1UDoaVJcmZNsr3n7byxtmvXUraBcysI=
X-Google-Smtp-Source: AGHT+IH/xVCKh+VVWbY69gd2wFgfenC/+h+2qOLYdNz5m9L1N+IiLpwVhUgpa5NRi45ntZBxsNIhpw==
X-Received: by 2002:a05:600c:4f0f:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-42e7ac4b1d4mr40135785e9.17.1726851766097;
        Fri, 20 Sep 2024 10:02:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:50ca:432::6b:72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ac2sm54237785e9.24.2024.09.20.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:02:45 -0700 (PDT)
From: Tiago Lam <tiagolam@cloudflare.com>
Date: Fri, 20 Sep 2024 18:02:14 +0100
Subject: [RFC PATCH v2 3/3] bpf: Add sk_lookup test to use ORIGDSTADDR
 cmsg.
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-reverse-sk-lookup-v2-3-916a48c47d56@cloudflare.com>
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
In-Reply-To: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, Tiago Lam <tiagolam@cloudflare.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.14.1

This patch reuses the framework already in place for sk_lookup, allowing
it now to send a reply from the server fd directly, instead of having to
create a socket bound to the original destination address and reply from
there. It does this by passing the source address and port from where to
reply from in a IP_ORIGDSTADDR ancillary message passed in sendmsg.

Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 67 +++++++++++++++-------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ae87c00867ba..df780624c16c 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -75,6 +75,7 @@ struct test {
 	struct inet_addr listen_at;
 	enum server accept_on;
 	bool reuseport_has_conns; /* Add a connected socket to reuseport group */
+	bool dont_bind_reply; /* Don't bind, send direct from server fd. */
 };
 
 struct cb_opts {
@@ -363,7 +364,7 @@ static void v4_to_v6(struct sockaddr_storage *ss)
 	memset(&v6->sin6_addr.s6_addr[0], 0, 10);
 }
 
-static int udp_recv_send(int server_fd)
+static int udp_recv_send(int server_fd, bool dont_bind_reply)
 {
 	char cmsg_buf[CMSG_SPACE(sizeof(struct sockaddr_storage))];
 	struct sockaddr_storage _src_addr = { 0 };
@@ -373,7 +374,7 @@ static int udp_recv_send(int server_fd)
 	struct iovec iov = { 0 };
 	struct cmsghdr *cm;
 	char buf[1];
-	int ret, fd;
+	int fd;
 	ssize_t n;
 
 	iov.iov_base = buf;
@@ -415,26 +416,37 @@ static int udp_recv_send(int server_fd)
 		v4_to_v6(dst_addr);
 	}
 
-	/* Reply from original destination address. */
-	fd = start_server_addr(SOCK_DGRAM, dst_addr, sizeof(*dst_addr), NULL);
-	if (!ASSERT_OK_FD(fd, "start_server_addr")) {
-		log_err("failed to create tx socket");
-		return -1;
-	}
+	if (dont_bind_reply) {
+		/* Reply directly from server fd, specifying the source address
+		 * and/or port in struct msghdr.
+		 */
+		n = sendmsg(server_fd, &msg, 0);
+		if (CHECK(n <= 0, "sendmsg", "failed\n")) {
+			log_err("failed to send echo reply");
+			return -1;
+		}
+	} else {
+		/* Reply from original destination address. */
+		fd = start_server_addr(SOCK_DGRAM, dst_addr, sizeof(*dst_addr),
+				       NULL);
+		if (!ASSERT_OK_FD(fd, "start_server_addr")) {
+			log_err("failed to create tx socket");
+			return -1;
+		}
 
-	msg.msg_control = NULL;
-	msg.msg_controllen = 0;
-	n = sendmsg(fd, &msg, 0);
-	if (CHECK(n <= 0, "sendmsg", "failed\n")) {
-		log_err("failed to send echo reply");
-		ret = -1;
-		goto out;
+		msg.msg_control = NULL;
+		msg.msg_controllen = 0;
+		n = sendmsg(fd, &msg, 0);
+		if (CHECK(n <= 0, "sendmsg", "failed\n")) {
+			log_err("failed to send echo reply");
+			close(fd);
+			return -1;
+		}
+
+		close(fd);
 	}
 
-	ret = 0;
-out:
-	close(fd);
-	return ret;
+	return 0;
 }
 
 static int tcp_echo_test(int client_fd, int server_fd)
@@ -454,14 +466,14 @@ static int tcp_echo_test(int client_fd, int server_fd)
 	return 0;
 }
 
-static int udp_echo_test(int client_fd, int server_fd)
+static int udp_echo_test(int client_fd, int server_fd, bool dont_bind_reply)
 {
 	int err;
 
 	err = send_byte(client_fd);
 	if (err)
 		return -1;
-	err = udp_recv_send(server_fd);
+	err = udp_recv_send(server_fd, dont_bind_reply);
 	if (err)
 		return -1;
 	err = recv_byte(client_fd);
@@ -653,7 +665,8 @@ static void run_lookup_prog(const struct test *t)
 	if (t->sotype == SOCK_STREAM)
 		tcp_echo_test(client_fd, server_fds[t->accept_on]);
 	else
-		udp_echo_test(client_fd, server_fds[t->accept_on]);
+		udp_echo_test(client_fd, server_fds[t->accept_on],
+			      t->dont_bind_reply);
 
 	close(client_fd);
 close:
@@ -775,6 +788,16 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
 			.listen_at	= { INT_IP4, INT_PORT },
 			.accept_on	= SERVER_B,
 		},
+		{
+			.desc		= "UDP IPv4 redir different ports",
+			.lookup_prog	= skel->progs.select_sock_a_no_reuseport,
+			.sock_map	= skel->maps.redir_map,
+			.sotype		= SOCK_DGRAM,
+			.connect_to	= { EXT_IP4, EXT_PORT },
+			.listen_at	= { INT_IP4, INT_PORT },
+			.accept_on	= SERVER_A,
+			.dont_bind_reply = true,
+		},
 		{
 			.desc		= "UDP IPv4 redir and reuseport with conns",
 			.lookup_prog	= skel->progs.select_sock_a,

-- 
2.34.1


