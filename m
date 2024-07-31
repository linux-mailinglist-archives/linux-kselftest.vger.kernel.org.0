Return-Path: <linux-kselftest+bounces-14521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C5942B7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A67282904
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA61AE878;
	Wed, 31 Jul 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="0/D5h1JS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E51AD9FE;
	Wed, 31 Jul 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420125; cv=none; b=ud9F70cgb9mgaflHVtmhUOamKiUaxryO8t2fNJhsifF0cIvQVaUSgLPY/knWdRHBjCEZdr6B6uitgpIsnWAatL9O0+oHgOKNTSdkmrS/NHnF/jCg0LFxbWZMhOw0MD5AsFQrOESzOjyzrorgLIsQZr9vTHSB0H1zvFAO4ZfWn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420125; c=relaxed/simple;
	bh=mAWtuOtGuJESjzvI0NFmi3RwM42Z3P+0llBnuHalf3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CyQtNxuWyCCZ/jkK+qx6GvqHcN66MxMdjRgoapsMk93cWiaf4uBD1Imi1NWtpXTm7BWAqbKwSEozjP5VyMNqmo+ekFF4cRsiONqqcp7LudTZkzVjBgNJWxMCd9JQu7wFTJhZMOevp4o2XhY/vC1EPd/yBa4MXw22cxsQPepzGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=0/D5h1JS; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69T-009FBt-JG; Wed, 31 Jul 2024 12:01:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=dUGV8QTuF9AS0RTuH4OvphKPP6WrA30a06ChdR64otk=; b=0/D5h1JSEg5eRuOWaToCRu+5dD
	6oZbf1wp2s3gWT5ySDpKgMJaGoTcecLFLC4FN1eI3Hsyym6v+1FAyd/GzMotHVBRhH2Er0J/Ui9dv
	22eouyRuh1DKNM190AS2wCsXEK0IwEqCXx1cz2JsbdCKs6hXDE6m23jp4OgvLzrAryyPjxtnJmB+T
	A5+Bc2hO4Fq7Jnff4qeGmilOZzvKAY7Y0QeYYB4LX3Wnu/iQ4XtgSMRfumJOhLwGuktdEhHifzo11
	Usz68JPIbJ6IYHshvnFGhrFe53g2tQb2VBopBuT+4htTUcn6tv3UFiTRdamjVarFW+1u/HyKX658z
	gkhFrSvw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69S-000213-WD; Wed, 31 Jul 2024 12:01:47 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sZ69H-006dO6-5w; Wed, 31 Jul 2024 12:01:35 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 31 Jul 2024 12:01:28 +0200
Subject: [PATCH bpf-next v2 3/6] selftests/bpf: Simplify inet_socketpair()
 and vsock_socketpair_connectible()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-selftest-sockmap-fixes-v2-3-08a0c73abed2@rbox.co>
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
In-Reply-To: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.1

Replace implementation with a call to a generic function.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 83 +---------------------
 1 file changed, 2 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index bfbc217637d1..ea2faacd146d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1490,49 +1490,7 @@ static void test_unix_redir(struct test_sockmap_listen *skel, struct bpf_map *ma
 /* Returns two connected loopback vsock sockets */
 static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)
 {
-	struct sockaddr_storage addr;
-	socklen_t len = sizeof(addr);
-	int s, p, c;
-
-	s = socket_loopback(AF_VSOCK, sotype);
-	if (s < 0)
-		return -1;
-
-	c = xsocket(AF_VSOCK, sotype | SOCK_NONBLOCK, 0);
-	if (c == -1)
-		goto close_srv;
-
-	if (getsockname(s, sockaddr(&addr), &len) < 0)
-		goto close_cli;
-
-	if (connect(c, sockaddr(&addr), len) < 0 && errno != EINPROGRESS) {
-		FAIL_ERRNO("connect");
-		goto close_cli;
-	}
-
-	len = sizeof(addr);
-	p = accept_timeout(s, sockaddr(&addr), &len, IO_TIMEOUT_SEC);
-	if (p < 0)
-		goto close_cli;
-
-	if (poll_connect(c, IO_TIMEOUT_SEC) < 0) {
-		FAIL_ERRNO("poll_connect");
-		goto close_acc;
-	}
-
-	*v0 = p;
-	*v1 = c;
-
-	return 0;
-
-close_acc:
-	close(p);
-close_cli:
-	close(c);
-close_srv:
-	close(s);
-
-	return -1;
+	return create_pair(AF_VSOCK, sotype | SOCK_NONBLOCK, v0, v1);
 }
 
 static void vsock_unix_redir_connectible(int sock_mapfd, int verd_mapfd,
@@ -1681,44 +1639,7 @@ static void test_reuseport(struct test_sockmap_listen *skel,
 
 static int inet_socketpair(int family, int type, int *s, int *c)
 {
-	struct sockaddr_storage addr;
-	socklen_t len;
-	int p0, c0;
-	int err;
-
-	p0 = socket_loopback(family, type | SOCK_NONBLOCK);
-	if (p0 < 0)
-		return p0;
-
-	len = sizeof(addr);
-	err = xgetsockname(p0, sockaddr(&addr), &len);
-	if (err)
-		goto close_peer0;
-
-	c0 = xsocket(family, type | SOCK_NONBLOCK, 0);
-	if (c0 < 0) {
-		err = c0;
-		goto close_peer0;
-	}
-	err = xconnect(c0, sockaddr(&addr), len);
-	if (err)
-		goto close_cli0;
-	err = xgetsockname(c0, sockaddr(&addr), &len);
-	if (err)
-		goto close_cli0;
-	err = xconnect(p0, sockaddr(&addr), len);
-	if (err)
-		goto close_cli0;
-
-	*s = p0;
-	*c = c0;
-	return 0;
-
-close_cli0:
-	xclose(c0);
-close_peer0:
-	xclose(p0);
-	return err;
+	return create_pair(family, type | SOCK_NONBLOCK, s, c);
 }
 
 static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,

-- 
2.45.2


