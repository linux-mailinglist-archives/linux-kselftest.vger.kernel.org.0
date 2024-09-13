Return-Path: <linux-kselftest+bounces-17925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C93977C67
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 11:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4448F1F20EE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E241D9342;
	Fri, 13 Sep 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gN9mRqbh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C91D88B3
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220370; cv=none; b=Rz3PoIerR1BnxWAW5be8v4T4oE6SC1vgl/Fq4+Wcq0BWuXipxQwhhXQzSg3bnKFLWRdAcY9iLNKwQhoPtOxmgp8Ps7VYs5AimlfctOMMIAPJ+c0Ax4qLTpS0nyrwhIMgpk1lvQTvvbyNC6wlRql9epWqjhkh2HcX5lwM8LhlTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220370; c=relaxed/simple;
	bh=kwVTA1xn2dlYAQ5FaOqW3WQio+O9v5ZocxxWoHtdcDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FU4vU7Y3Yea9Rtfcg08XxPesxZnRdbzOccz28gi/mVjZkxiacK7kidyZdDVkMzOzrCdu4n93o++YFwCaLyQyukcMCzEoLn9l9ApK+I/2weQCka9ZpvTrMXQDXkAt9GphdXel/FlCgQeu9WZKAjwH7eUmHj+H26Gd60OqeHKttR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gN9mRqbh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c6187b6eso1527801f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 02:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726220367; x=1726825167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lw0zQpZeq+FMh46boYtf1wMWWNki5/w8+fazi2fO7P0=;
        b=gN9mRqbhjam2T9IGTs5lMaq2b0xYNElZCBYrlIxpoFhGq75l+ouF3d3+vgPjZNP9Vb
         SQK56eUh1pXkA3R3wG1grYG6i9TOv9aHavtwufvKmBa2xO9w3pBBVXkGhhNr1EIPVV71
         iAdC1aIfySCOBS1hpuphDztkLTsgFeKhDnqTx4AY4SMiELeLYKlJJV+0lLRcigpqsPCw
         /QT15gPRIzWRb2lp51cvNq30ku7aoLD0Sp4u53xUYGSlUTo2L6vwN1NrM3jVYmr1zada
         YKg9CZntzErK8fVmE3cJNzHChmrcesJF7jfcq9ExmG3h4Ho5rSKSF7uDQztCaIzKCy31
         DaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726220367; x=1726825167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw0zQpZeq+FMh46boYtf1wMWWNki5/w8+fazi2fO7P0=;
        b=mPXhITJNY90fa35NBnuZaLg2i5kb6dzr4pLKy0FaPVHYMGQ4lD8QsqPN+oGOqVa8mU
         yI5dBnrBJDnH7jP88RfxPREZhCziSwddFiKOUEfq0SlGMjCgvemLLUxKPaUIotqVHk/a
         +ZC2mYXpPz5VJoTFCG2fYlXpjTYgSYvxTlJZngBkgDEjTLqXKxMLqte/enRgzKeOo6um
         BVOz1psY9GfyMMdAAehhd8uRdyx4onCOgPQGf59nQOIKE8yQmIqBFv3e1ay154zJgACY
         EEJKSP/6Y2xud9yHIpsq2GyL4zya2LqVCNKKbDeBHTH1o8hQWZySVyA8wJZjDjn2Oxpg
         OdDg==
X-Forwarded-Encrypted: i=1; AJvYcCVWG14l2vac2oxL3S2E5xAGzXhRdPmELmv4SLrzCrQVTvmqGz3V9XWQIsk8erC0cohny9V3QdG3f3pYrIn4G50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+v5LL8qMRlGQV4E2pdebOC86cIZYt+n6gf6kDymV4FKOP/F+
	oxyVYAYPu1SR1xkCWdVvTu97hSK2QNc0Oh0vM9fZ4cDLWKhMBGv3xvgFTs+d8Xw=
X-Google-Smtp-Source: AGHT+IGgG2ZTysSwmI61riKiy7WlPK0eMWG0eKUUV3q1+A4ChRBKjnQEymksqdsX8ZEbb5LITzFKGA==
X-Received: by 2002:adf:a407:0:b0:374:c90c:226 with SMTP id ffacd0b85a97d-378c2cfec60mr3448025f8f.9.1726220367026;
        Fri, 13 Sep 2024 02:39:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:3802:d2::15:37a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665548sm16474484f8f.34.2024.09.13.02.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:39:26 -0700 (PDT)
From: Tiago Lam <tiagolam@cloudflare.com>
Date: Fri, 13 Sep 2024 10:39:21 +0100
Subject: [RFC PATCH 3/3] bpf: Add sk_lookup test to use ORIGDSTADDR cmsg.
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reverse-sk-lookup-v1-3-e721ea003d4c@cloudflare.com>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
In-Reply-To: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
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
reply from in a IP_ORIGDSTADDR ancilliary message passed in sendmsg.

Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 70 +++++++++++++++-------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ae87c00867ba..b99aff2e3976 100644
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
@@ -415,26 +416,41 @@ static int udp_recv_send(int server_fd)
 		v4_to_v6(dst_addr);
 	}
 
-	/* Reply from original destination address. */
-	fd = start_server_addr(SOCK_DGRAM, dst_addr, sizeof(*dst_addr), NULL);
-	if (!ASSERT_OK_FD(fd, "start_server_addr")) {
-		log_err("failed to create tx socket");
-		return -1;
-	}
+	if (dont_bind_reply) {
+		/* Reply directly from server fd, specifying the source address and/or
+		 * port in struct msghdr.
+		 */
+		n = sendmsg(server_fd, &msg, 0);
+		if (CHECK(n <= 0, "sendmsg", "failed\n")) {
+			log_err("failed to send echo reply");
+			return -1;
+		}
+	} else {
+		/* Reply from original destination address. */
+		fd = socket(dst_addr->ss_family, SOCK_DGRAM, 0);
+		if (CHECK(fd < 0, "socket", "failed\n")) {
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
-	}
+		ret = bind(fd, (struct sockaddr *)dst_addr, sizeof(*dst_addr));
+		if (CHECK(ret, "bind", "failed\n")) {
+			log_err("failed to bind tx socket");
+			close(fd);
+			return ret;
+		}
 
-	ret = 0;
-out:
-	close(fd);
-	return ret;
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
+	}
 }
 
 static int tcp_echo_test(int client_fd, int server_fd)
@@ -454,14 +470,14 @@ static int tcp_echo_test(int client_fd, int server_fd)
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
@@ -653,7 +669,7 @@ static void run_lookup_prog(const struct test *t)
 	if (t->sotype == SOCK_STREAM)
 		tcp_echo_test(client_fd, server_fds[t->accept_on]);
 	else
-		udp_echo_test(client_fd, server_fds[t->accept_on]);
+		udp_echo_test(client_fd, server_fds[t->accept_on], t->dont_bind_reply);
 
 	close(client_fd);
 close:
@@ -775,6 +791,16 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
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


