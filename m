Return-Path: <linux-kselftest+bounces-16988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB882968B91
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1DA1F21708
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CC41A3029;
	Mon,  2 Sep 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS6SOaTB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA81CB50C;
	Mon,  2 Sep 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293178; cv=none; b=AjivdQ8wMpl2CPmz09UfLh+cLSxwxZ/rCaZZerKLEQpbKZxLzhv3w1mg2ikdOntm14nfO/GEVR/Dhez6LVmRmd8AEQ9H2c2OrrNqGztJ598KsvvYiFCUrtNo3O/HzaC4sHFV6arMJf7KvEEk74iRoNaV8s/4MMZdteBXr9zdKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293178; c=relaxed/simple;
	bh=K13y1lO/8DhpALWh0nz5mt6WHW+qQOjSXmJvnUReN7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JiNoWEc1saWl3Hq4iDd98kOukxfIRjRcZvnD5xuiF+3+mWFEFTAR0EnbW3n5AIVSzhA0wCYxIXj1S5D0rdJ3R5aUPmrA2Tt83WEAVVMGJtzGHB75dBB8kvKXgrcRax5LCHvpivPEyYBmxwIoc0tO3woeT/KYqSHxPDsHiyYSJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS6SOaTB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so2773583a12.3;
        Mon, 02 Sep 2024 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725293176; x=1725897976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OI2uENxJ9aaY53VJ36Ne/siF10sE+6E3JhEPyeKfFJ0=;
        b=gS6SOaTBWfbMk3viTZn5fYZqViQaPFhdqhcazY7UL9aeo//F8WNkb9EnC+lc3c9yVM
         RNspuHsAozJbucx7tIxQDtHmEuayd2sSXdrOb+vBSg932YoTuVu3EsbkgC1jUeUa2w2W
         Xni0L1GVHEmW4HWN+GHYhMraEqzxWzYoKwgNSSMPw0IWlJt0KXMpNzw1DuLT7O7v4SkW
         rweUoNvIKw/ApNVTC5GflU3HzAVm3xOuyt2VmGZs6z9ooIToSx0jcPpn6pHoPX3VYfHO
         UagPe+naOsUhMzd6/4LF6sGmHOLhMyBDsrsea3YiXPbEEKpLK9IUyvdqNzkMqffdF6iF
         /Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293176; x=1725897976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OI2uENxJ9aaY53VJ36Ne/siF10sE+6E3JhEPyeKfFJ0=;
        b=WrcaMGPmPlrQPxwCpDB4xgppY0QCdZfP3fAuHF+G9y/a9SiZgfMp8I/j/rWl21/YSU
         Nl7BTqjvjsNtJQqdF5hrlgzqlURGIYYwN3a1/3k2aK0sSdD3z0HjQEVtshbeOYM/CWep
         DhpINuxciMNM+SFhGauiva1fAoUzqJJwvBKj7qFblEW5alJFzJ6XwUMkMK1KNlovn7P8
         hV/SqV0KpkBx++8soNegtwc4kkZPzsom6v+9q3VL/loi9wzLg9kSfGznasRkytcrJ3Ba
         f2npdHNPykn9uhaPRjgYnQztap72qYy2ZjI2U5H5qMejCeQZS6804JPfAdw1tZuygFZK
         QPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7vpjfn9PYcB/PrTHXhgYCA3tCnuDIxMuj0YqWrALRYAQXacnc8u2v5Hh0hHYjeyBNCdNiXAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2XL19ROIe8yq0/3VaQxC5dcciUZ+bhe7NxAIBjNr6hvG5BKB
	vmJsDrpdQ5PQX+YJIVETNwibLKLxc8L3r0AcweqnUAhgg+w+GulPeTlJUMo6
X-Google-Smtp-Source: AGHT+IGHfZbHnzuquOhDl2V3d/MmVRbrhimcfW7pnu4r/i6mtevwyQEyoZvJtjZtmpufU/zm13jP6g==
X-Received: by 2002:a17:902:daca:b0:202:54b8:72e5 with SMTP id d9443c01a7336-205444f14d9mr68676855ad.22.1725293176031;
        Mon, 02 Sep 2024 09:06:16 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20549df4909sm37713745ad.240.2024.09.02.09.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:06:15 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	jmaloy@redhat.com,
	sdf@fomichev.me,
	willemdebruijn.kernel@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2] selftests: add selftest for UDP SO_PEEK_OFF support
Date: Tue,  3 Sep 2024 00:06:10 +0800
Message-Id: <20240902160610.66332-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20240901051821.94956-1-kerneljasonxing@gmail.com/
1. update .gitignore (Stanislav)
2. use connect() < 0 as the test statement (Willem)

v1
Link: https://lore.kernel.org/all/9f4dd14d-fbe3-4c61-b04c-f0e6b8096d7b@redhat.com/
---
 tools/testing/selftests/net/.gitignore        |  1 +
 tools/testing/selftests/net/Makefile          |  2 +-
 .../{tcp_so_peek_off.c => sk_so_peek_off.c}   | 91 +++++++++++--------
 3 files changed, 57 insertions(+), 37 deletions(-)
 rename tools/testing/selftests/net/{tcp_so_peek_off.c => sk_so_peek_off.c} (58%)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 666ab7d9390b..923bf098e2eb 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -34,6 +34,7 @@ scm_pidfd
 scm_rights
 sk_bind_sendto_listen
 sk_connect_zero_addr
+sk_so_peek_off
 socket
 so_incoming_cpu
 so_netns_cookie
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
index df8a39d9d3c3..d87dd8d8d491 100644
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
+	if (connect(s[1], &a.sa, sizeof(a)) < 0) {
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


