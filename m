Return-Path: <linux-kselftest+bounces-16897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D996751F
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 07:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4802282ABF
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 05:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE11F959;
	Sun,  1 Sep 2024 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK+yI5Py"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34018748A;
	Sun,  1 Sep 2024 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725167910; cv=none; b=W7qRTkOnvNhkskfhxyoO6wSzgapiXK0Zv7rGWlq5hUGYl1JS08nPrZL0qGPjVZAnd1GAl1HXyV/3SoIVdqxI6z2MtlhJMFg2jlEtvs44+hzPQKSCdbxtGGPZvv0/N3BkHCEtP7Cjj3K+Z0ucJfMICy0OY8L/afWgTf12hAhjXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725167910; c=relaxed/simple;
	bh=dNJlNA7FEKx8vGjbKAKwbl0RwTtDBfouxGcA971mtC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pkSNJeu0ycxCw9s12Er0SuE4cqGJyxCkOQjD6CjF0blYgy3xwvOtazlfzSihQutZL8vBplFj5QtcaFeh+WdUB7ZSOIX89PlcV5Yl+PpnFoi5Gl1STMwLD6AbuCipc2K2qaXEsK1mMBm0ljxG5+EBJuVspDIZl4bxkRcy46ONor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK+yI5Py; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5dc93fa5639so1922148eaf.1;
        Sat, 31 Aug 2024 22:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725167908; x=1725772708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rezF6iuLnPWFCk07aeciBJ4pDsFKzTvutSVVYnuI9tI=;
        b=XK+yI5PyQKHRWhjck5zT/cPeL9Ba1mAnsaS3qUUKjfIybwn5LjIWnQu/WTcv0e+M0Y
         nF+neUhYaq+w8f1GzopxDJym6C0g/EtTp5YAGnpynle20QQGNYhw1y73gwl47x5mwXFj
         olwOggTFhSLMZZBLO7HQacNmrvNq6BdmKiZGJ83MBxk3yUrclDeVcAgTEu9YSvui1n0+
         2KNVON4iMjyuJ/0UFToJA794D2jSmX8Rxv3PZ5nK8sLgdm4dka5C2/5UoXlb5f4AUrln
         RkQQ1Kaje3tZ5j8CfdYHhS99E/wScnHB7myBgAODmv9GPC/Qkrx7k8v+zBX/8eUAIn8u
         Z5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725167908; x=1725772708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rezF6iuLnPWFCk07aeciBJ4pDsFKzTvutSVVYnuI9tI=;
        b=atlM5s7hW5Gn0YasIh2LcPwCodMdshIGkTrqWrVONoChQ6coLaMTyew2ssa4cpfpLU
         ojF0u7PE/I5jUvBm66BMVwvvzJKwo5TIqFWAi1urm9rvyBeQzhKaTbpz3Bgfi+4fZKxU
         ClvEWKrSPswT0AgNnziH5wGRiieZ2DIyxDo7ZkoJxbyzrJI7k4R7EBLRd/VlJYGVdMPY
         ylkG9q66c0rgvaHEe7vksgCIGcqGaQaGpcIaoOpU9eHOsgGE1N2iBAKe2DqbRs67CMzM
         hraTWdaZC5thac5cft0kx/CnAgz3VqtwHi0WmxtQ4EJe8iGIlAOaykcojjhDPnqP8kFo
         WTgA==
X-Forwarded-Encrypted: i=1; AJvYcCWhNzze+OWb6hSTqHdt8iQ2nLyrCPeFc5SRtugi8V5ieGm3drOU36Fve6A/Y5hQY04e5RyVbfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCui/v6bQuyOeN8nkCLKPjffIBRybpEOpuQMwc0iNFr4KsEQo
	mGK0edsh8hPjMHDrebukGE6eJv532DQHaDDE5P4VL7XY937D9u3w
X-Google-Smtp-Source: AGHT+IFFxfSz5YdrMSwTF8ZLEw0BoVNNZhU67Du1QaRGdCIjh9Tps4fJ+lSmhU+4f4+6qb28UMj96A==
X-Received: by 2002:a05:6830:6683:b0:709:3015:fd08 with SMTP id 46e09a7af769-70f72d09868mr4634498a34.31.1725167908154;
        Sat, 31 Aug 2024 22:18:28 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8d06c92dcsm115497a91.30.2024.08.31.22.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 22:18:27 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	jmaloy@redhat.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] selftests: add selftest for UDP SO_PEEK_OFF support
Date: Sun,  1 Sep 2024 13:18:21 +0800
Message-Id: <20240901051821.94956-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add the SO_PEEK_OFF selftest for UDP. In this patch, I mainly do
three things:
1. rename tcp_so_peek_off.c
2. adjust for UDP protocol
3. add selftests into it

Suggested-by: Jon Maloy <jmaloy@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
Link: https://lore.kernel.org/all/9f4dd14d-fbe3-4c61-b04c-f0e6b8096d7b@redhat.com/
---
 tools/testing/selftests/net/Makefile          |  2 +-
 .../{tcp_so_peek_off.c => sk_so_peek_off.c}   | 91 +++++++++++--------
 2 files changed, 56 insertions(+), 37 deletions(-)
 rename tools/testing/selftests/net/{tcp_so_peek_off.c => sk_so_peek_off.c} (58%)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 1179e3261bef..d5029f978aa9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -80,7 +80,7 @@ TEST_PROGS += io_uring_zerocopy_tx.sh
 TEST_GEN_FILES += bind_bhash
 TEST_GEN_PROGS += sk_bind_sendto_listen
 TEST_GEN_PROGS += sk_connect_zero_addr
-TEST_GEN_PROGS += tcp_so_peek_off
+TEST_GEN_PROGS += sk_so_peek_off
 TEST_PROGS += test_ingress_egress_chaining.sh
 TEST_GEN_PROGS += so_incoming_cpu
 TEST_PROGS += sctp_vrf.sh
diff --git a/tools/testing/selftests/net/tcp_so_peek_off.c b/tools/testing/selftests/net/sk_so_peek_off.c
similarity index 58%
rename from tools/testing/selftests/net/tcp_so_peek_off.c
rename to tools/testing/selftests/net/sk_so_peek_off.c
index df8a39d9d3c3..870a890138c4 100644
--- a/tools/testing/selftests/net/tcp_so_peek_off.c
+++ b/tools/testing/selftests/net/sk_so_peek_off.c
@@ -10,37 +10,41 @@
 #include <arpa/inet.h>
 #include "../kselftest.h"
 
-static char *afstr(int af)
+static char *afstr(int af, int proto)
 {
-	return af == AF_INET ? "TCP/IPv4" : "TCP/IPv6";
+	if (proto == IPPROTO_TCP)
+		return af == AF_INET ? "TCP/IPv4" : "TCP/IPv6";
+	else
+		return af == AF_INET ? "UDP/IPv4" : "UDP/IPv6";
 }
 
-int tcp_peek_offset_probe(sa_family_t af)
+int sk_peek_offset_probe(sa_family_t af, int proto)
 {
+	int type = (proto == IPPROTO_TCP ? SOCK_STREAM : SOCK_DGRAM);
 	int optv = 0;
 	int ret = 0;
 	int s;
 
-	s = socket(af, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
+	s = socket(af, type, proto);
 	if (s < 0) {
 		ksft_perror("Temporary TCP socket creation failed");
 	} else {
 		if (!setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &optv, sizeof(int)))
 			ret = 1;
 		else
-			printf("%s does not support SO_PEEK_OFF\n", afstr(af));
+			printf("%s does not support SO_PEEK_OFF\n", afstr(af, proto));
 		close(s);
 	}
 	return ret;
 }
 
-static void tcp_peek_offset_set(int s, int offset)
+static void sk_peek_offset_set(int s, int offset)
 {
 	if (setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, sizeof(offset)))
 		ksft_perror("Failed to set SO_PEEK_OFF value\n");
 }
 
-static int tcp_peek_offset_get(int s)
+static int sk_peek_offset_get(int s)
 {
 	int offset;
 	socklen_t len = sizeof(offset);
@@ -50,8 +54,9 @@ static int tcp_peek_offset_get(int s)
 	return offset;
 }
 
-static int tcp_peek_offset_test(sa_family_t af)
+static int sk_peek_offset_test(sa_family_t af, int proto)
 {
+	int type = (proto == IPPROTO_TCP ? SOCK_STREAM : SOCK_DGRAM);
 	union {
 		struct sockaddr sa;
 		struct sockaddr_in a4;
@@ -62,13 +67,13 @@ static int tcp_peek_offset_test(sa_family_t af)
 	int recv_sock = 0;
 	int offset = 0;
 	ssize_t len;
-	char buf;
+	char buf[2];
 
 	memset(&a, 0, sizeof(a));
 	a.sa.sa_family = af;
 
-	s[0] = socket(af, SOCK_STREAM, IPPROTO_TCP);
-	s[1] = socket(af, SOCK_STREAM | SOCK_NONBLOCK, IPPROTO_TCP);
+	s[0] = recv_sock = socket(af, type, proto);
+	s[1] = socket(af, type, proto);
 
 	if (s[0] < 0 || s[1] < 0) {
 		ksft_perror("Temporary socket creation failed\n");
@@ -82,76 +87,78 @@ static int tcp_peek_offset_test(sa_family_t af)
 		ksft_perror("Temporary socket getsockname() failed\n");
 		goto out;
 	}
-	if (listen(s[0], 0) < 0) {
+	if (proto == IPPROTO_TCP && listen(s[0], 0) < 0) {
 		ksft_perror("Temporary socket listen() failed\n");
 		goto out;
 	}
-	if (connect(s[1], &a.sa, sizeof(a)) >= 0 || errno != EINPROGRESS) {
+	if (connect(s[1], &a.sa, sizeof(a))) {
 		ksft_perror("Temporary socket connect() failed\n");
 		goto out;
 	}
-	recv_sock = accept(s[0], NULL, NULL);
-	if (recv_sock <= 0) {
-		ksft_perror("Temporary socket accept() failed\n");
-		goto out;
+	if (proto == IPPROTO_TCP) {
+		recv_sock = accept(s[0], NULL, NULL);
+		if (recv_sock <= 0) {
+			ksft_perror("Temporary socket accept() failed\n");
+			goto out;
+		}
 	}
 
 	/* Some basic tests of getting/setting offset */
-	offset = tcp_peek_offset_get(recv_sock);
+	offset = sk_peek_offset_get(recv_sock);
 	if (offset != -1) {
 		ksft_perror("Initial value of socket offset not -1\n");
 		goto out;
 	}
-	tcp_peek_offset_set(recv_sock, 0);
-	offset = tcp_peek_offset_get(recv_sock);
+	sk_peek_offset_set(recv_sock, 0);
+	offset = sk_peek_offset_get(recv_sock);
 	if (offset != 0) {
 		ksft_perror("Failed to set socket offset to 0\n");
 		goto out;
 	}
 
 	/* Transfer a message */
-	if (send(s[1], (char *)("ab"), 2, 0) <= 0 || errno != EINPROGRESS) {
+	if (send(s[1], (char *)("ab"), 2, 0) != 2) {
 		ksft_perror("Temporary probe socket send() failed\n");
 		goto out;
 	}
 	/* Read first byte */
-	len = recv(recv_sock, &buf, 1, MSG_PEEK);
-	if (len != 1 || buf != 'a') {
+	len = recv(recv_sock, buf, 1, MSG_PEEK);
+	if (len != 1 || buf[0] != 'a') {
 		ksft_perror("Failed to read first byte of message\n");
 		goto out;
 	}
-	offset = tcp_peek_offset_get(recv_sock);
+	offset = sk_peek_offset_get(recv_sock);
 	if (offset != 1) {
 		ksft_perror("Offset not forwarded correctly at first byte\n");
 		goto out;
 	}
 	/* Try to read beyond last byte */
-	len = recv(recv_sock, &buf, 2, MSG_PEEK);
-	if (len != 1 || buf != 'b') {
+	len = recv(recv_sock, buf, 2, MSG_PEEK);
+	if (len != 1 || buf[0] != 'b') {
 		ksft_perror("Failed to read last byte of message\n");
 		goto out;
 	}
-	offset = tcp_peek_offset_get(recv_sock);
+	offset = sk_peek_offset_get(recv_sock);
 	if (offset != 2) {
 		ksft_perror("Offset not forwarded correctly at last byte\n");
 		goto out;
 	}
 	/* Flush message */
-	len = recv(recv_sock, NULL, 2, MSG_TRUNC);
+	len = recv(recv_sock, buf, 2, MSG_TRUNC);
 	if (len != 2) {
 		ksft_perror("Failed to flush message\n");
 		goto out;
 	}
-	offset = tcp_peek_offset_get(recv_sock);
+	offset = sk_peek_offset_get(recv_sock);
 	if (offset != 0) {
 		ksft_perror("Offset not reverted correctly after flush\n");
 		goto out;
 	}
 
-	printf("%s with MSG_PEEK_OFF works correctly\n", afstr(af));
+	printf("%s with MSG_PEEK_OFF works correctly\n", afstr(af, proto));
 	res = 1;
 out:
-	if (recv_sock >= 0)
+	if (proto == IPPROTO_TCP && recv_sock >= 0)
 		close(recv_sock);
 	if (s[1] >= 0)
 		close(s[1]);
@@ -160,24 +167,36 @@ static int tcp_peek_offset_test(sa_family_t af)
 	return res;
 }
 
-int main(void)
+static int do_test(int proto)
 {
 	int res4, res6;
 
-	res4 = tcp_peek_offset_probe(AF_INET);
-	res6 = tcp_peek_offset_probe(AF_INET6);
+	res4 = sk_peek_offset_probe(AF_INET, proto);
+	res6 = sk_peek_offset_probe(AF_INET6, proto);
 
 	if (!res4 && !res6)
 		return KSFT_SKIP;
 
 	if (res4)
-		res4 = tcp_peek_offset_test(AF_INET);
+		res4 = sk_peek_offset_test(AF_INET, proto);
 
 	if (res6)
-		res6 = tcp_peek_offset_test(AF_INET6);
+		res6 = sk_peek_offset_test(AF_INET6, proto);
 
 	if (!res4 || !res6)
 		return KSFT_FAIL;
 
 	return KSFT_PASS;
 }
+
+int main(void)
+{
+	int restcp, resudp;
+
+	restcp = do_test(IPPROTO_TCP);
+	resudp = do_test(IPPROTO_UDP);
+	if (restcp == KSFT_FAIL || resudp == KSFT_FAIL)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
-- 
2.37.3


