Return-Path: <linux-kselftest+bounces-14145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E65093B061
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AEB4B2187D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D647158A02;
	Wed, 24 Jul 2024 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="VanKqZXM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A46156C74;
	Wed, 24 Jul 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820833; cv=none; b=Z3D8aGyo6uCuMcFCxzKpTBHXMSkRRhVwJV5FsrUPgZ040MfHb8wII52aohkGSgYId7hftKIoBUOWI/PWlBt1kHB+bKndvhUMjydPA5LkcgrmmleGuXmHa9+xX2p90IvvAGhvWMcimFDAp8jVWm0XJvjjb6TkvjFz0vC+T/WRUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820833; c=relaxed/simple;
	bh=mAWtuOtGuJESjzvI0NFmi3RwM42Z3P+0llBnuHalf3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtjYfLP5kRTnsW0EB0Xmnaj94ZyVWGPsZxBx4UpZaa4JL5F2vsmjJOjkCKeLjFYkLItSngWjzbaEif1oKIQ3PIV8WkrjVYnronXVof41FB4FbCKHlctHtKgI4J3AZ905ZmKAWzSYKhVsduSYB25b3+pcnf0hfxemeLYQS+Qlmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=VanKqZXM; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFY-006K1K-3v; Wed, 24 Jul 2024 13:33:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=dUGV8QTuF9AS0RTuH4OvphKPP6WrA30a06ChdR64otk=; b=VanKqZXMy4uiKZ0xW6+IIPRF6p
	MWoBuZyjxt79upwGnJmeu1Qp8KUSsp+g0Gp51X8ibat7/kYbhaMA+8A5r0qw9jXTFKsj1/WEgnOn9
	/hqdD7xYCyDC8ZlmeKlu4R5f/26PWg4+eCZCeLD2/blnfC9O2qfLdT5PeUisDtaq/lgwfeQ6G308o
	e1NiEzmlxT7uv1jwqpKqpnWCqc9X7HWJwicFeNMTMNGmyYyWMEqzldc39NI1AM5MdKXysuY96zkTm
	LWfcQsPaCeAm4mcDr2hZaveaLM1xhJtSA8wAroM5yzn8zJi6SJw1fvCpl2k+LTA35avBlGRTIArrr
	xK4/0ROg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFX-0003xr-Mp; Wed, 24 Jul 2024 13:33:39 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sWaFN-00EK6H-1f; Wed, 24 Jul 2024 13:33:29 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 24 Jul 2024 13:32:39 +0200
Subject: [PATCH bpf 3/6] selftest/bpf: Simplify inet_socketpair() and
 vsock_unix_redir_connectible()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-sockmap-selftest-fixes-v1-3-46165d224712@rbox.co>
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


