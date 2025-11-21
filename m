Return-Path: <linux-kselftest+bounces-46160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC2BC76C29
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AFA835EABF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4432741BC;
	Fri, 21 Nov 2025 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UuuE6xoI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410326158C
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684478; cv=none; b=uHqY09F41PGY/SuwqCRm8QbPk2ntDS/BosA4gE9MtQoKc/DJc0eCdyJftaJxRw1WcUh8qJzr7rReih84PaKglwucUtpIcdg/Vn+l4k9M9WVNFJlXW0pl14L7ePNZyo8kQfDf/gCH638bq8wOWi4L5eMM5/2HngFqhDG5LLQxbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684478; c=relaxed/simple;
	bh=9BFFJg8nNLtvqAKvwLiruj6QwgROF+D5859DuEV3TPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvjVGE9WqNKk/dxfGbILFjOukxJw3P70XKMBthXX8pTHAnPVBx6muV56SwlGSegZeOZKqxedvc5mrPhB77miVZCWA4U4bn29gRbhuWEKwL22OTvqJwb4UB/puxs9c4N+3WA1wLkHDFybQgh+yeWUOGPenoOiZ9VS9H4EQ1YSSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UuuE6xoI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47774d3536dso11358505e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684474; x=1764289274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw81lX/31b9PIUINNIrCFipehydl9bqel06t/uLnLkw=;
        b=UuuE6xoIrmLgaN4/TuZy44QB4AsHqKetm346ff34PZH7/vqVkem51VsV7ow9ctgkqp
         Re586sxT797kMixzrzTzLbeF5sq51LJgYyRXZoXqf1DZr59MM0ouCCA5Hvq9sFz5A1zJ
         jqvsLs+laQHbS+qFkV6/1wWvAf/tVxNU6OUSzBslRYasq5ZOd/iLQXXPhzuaa+H8d57a
         Q66IpSegvEAVUBDwkaSZ2IeU+AnK1G9Wjn/u2hV+hwwg46CPw5r+TK8fuZaK7yJzhQ+t
         j7phcNM13xTsZ4Yhv0RUP/1cFE3UrbFjt2umJUXuSSnBkaFhu99f7MF2T2JMoQTAD4d/
         7LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684474; x=1764289274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uw81lX/31b9PIUINNIrCFipehydl9bqel06t/uLnLkw=;
        b=o0z7cgC97U6+sB8Gy41izWpNQXu5qAVJGwd+Icmb79K+eZvDKkzBcqjtdivwcMjkz3
         PR/DVP1Ca5hgo6Dr1w21GbM8JqSxFXzPXIII1cOajCSuYprHX3nI3WbXwbDS4JwEd4pA
         gZukK+6Y9Xyo4wlczbslkB/cavyS1h/+wWZzQv5CPs3mJtmfUlsZJkwXaMLfbEoVwoGa
         uPSPf8/1NBpeBaRr8L+nrZ7Goy/LX8qBE9aQSR6Ta/4hNWVFZtTPW2LIYXu+S34j8/ra
         SSoVGNx0yJoXkVurvBfSkQw7QYAsNOv6FPLBT7Bx9/DjALnXbvX5B9gJUPQW7jzZNYRv
         ej4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnD6iKs0Gkn0fF1VMCSKzMFwG1ZMWvSSgqyKxe3fpDrg68W4Mm2Jpef+GXsxPM+QSd6lYp0YzgO/cfSNnDqNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtEwnRbbyxOj7MKMbb0xRQMxFvd9PoMHdw6sKqITER6zokMRea
	1KimJdTfPBcAZHrsFHKURUoEfHOSLpLQje0YcjvHx4aKueai311O3d298iMxmQ0HDUAbw4UQlO+
	bcUyhEtUvIuCqL5ATWYEXyPVs7xZYs7qcHsbOSLpyCDj2GZR5M/zZI/enDlJiBg0=
X-Gm-Gg: ASbGncumk3zTt2U9Whx6Q9kOOoVuJseAmh/AYMM6I6injqMqq7lOK5ibdGVJ77DLIiy
	zkR4/KAyYnNshSFnRG9/eTWQW3xSyNhkTAxiQGBwYemaokTl7nRw8g17mPnnJTBAbfZyDYtShtn
	oaRCmkJW4By/z6SdgJza2+PbFwQsOlRb2SYSwQOpLydrsLxMpHA9KFBKDi6Yllupeb23ip1AQwe
	e0ySVsv8uIs0oIEzCyoKkZ3X87qW3cPybgwO/xOGwA1kNGw/g/s5EV/krRvoQDKKQ8E7Jn0UJ5v
	D6+bZ3Q8GnkhzQy7xP6+HevdZzFj6wwKFdHUv9jTyMsySB6BbAHf/O7gWLd4ey+XkiYCTAGSfDJ
	8yigiMzJEPL8XJ5MouTwl08GAroSStphA/nDY05LY6w1onpYAatxuK0+TYuObx3HoRyv3+AeRRc
	FEbRLkFJNGNzi5UkR+RqRgwW54
X-Google-Smtp-Source: AGHT+IGjLI0Gl7OCtuANrW/m5xlb81Ii7nItQufGC4ZZ7XH+ylAa1+NYPE4qfFyoQjSJ1IqDGnPtDQ==
X-Received: by 2002:a05:600c:1d14:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-477c026ed62mr3979875e9.0.1763684474107;
        Thu, 20 Nov 2025 16:21:14 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:21:13 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 13/13] selftests: ovpn: add test for bound address
Date: Fri, 21 Nov 2025 01:20:44 +0100
Message-ID: <20251121002044.16071-14-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Add a selftest to verify that when a socket is bound to a local address,
UDP traffic from ovpn is correctly routed through that address.

This test extends test-bind.sh by binding to the addresses on each veth
pair and uses tcpdump to confirm that traffic flows as expected.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |   1 +
 tools/testing/selftests/net/ovpn/common.sh    |   6 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 202 +++++++++---------
 .../selftests/net/ovpn/test-bind-addr.sh      |  10 +
 tools/testing/selftests/net/ovpn/test-bind.sh |  52 +++--
 tools/testing/selftests/net/ovpn/test-mark.sh |   2 +-
 6 files changed, 152 insertions(+), 121 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-bind-addr.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index f219d87e2c44..7a5ad7a19273 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -26,6 +26,7 @@ LDLIBS += $(NL_LDLIBS)
 TEST_FILES = common.sh
 
 TEST_PROGS := \
+	test-bind-addr.sh \
 	test-bind.sh \
 	test-chachapoly.sh \
 	test-close-socket-tcp.sh \
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index c802e4e50054..5de42948d189 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -67,10 +67,12 @@ setup_listener() {
 
 add_peer() {
 	dev=${2:-"any"}
+	laddr=${3:-"any"}
 
 	if [ "${PROTO}" == "UDP" ]; then
 		if [ ${1} -eq 0 ]; then
-			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 ${dev} 1 ${UDP_PEERS_FILE}
+			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 ${dev} ${laddr} \
+				1 ${UDP_PEERS_FILE}
 
 			for p in $(seq 1 ${NUM_PEERS}); do
 				ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 \
@@ -82,7 +84,7 @@ add_peer() {
 			RPORT=$(awk "NR == ${1} {print \$4}" ${UDP_PEERS_FILE})
 			LPORT=$(awk "NR == ${1} {print \$6}" ${UDP_PEERS_FILE})
 			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${dev} ${TX_ID} ${1} \
-				${LPORT} ${RADDR} ${RPORT}
+				${laddr} ${LPORT} ${RADDR} ${RPORT}
 			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} ${TX_ID} 1 0 \
 				${ALG} 1 data64.key
 		fi
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 6d84380c76ad..7f7780a515d1 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -105,7 +105,7 @@ struct ovpn_ctx {
 	sa_family_t sa_family;
 
 	unsigned long peer_id, tx_id;
-	unsigned long lport;
+	const char *laddr, *lport;
 
 	union {
 		struct sockaddr_in in4;
@@ -470,59 +470,29 @@ static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
 	return 0;
 }
 
-static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
+static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int type)
 {
-	struct sockaddr_storage local_sock = { 0 };
-	struct sockaddr_in6 *in6;
-	struct sockaddr_in *in;
-	int ret, s, sock_type;
-	size_t sock_len;
-
-	if (proto == IPPROTO_UDP)
-		sock_type = SOCK_DGRAM;
-	else if (proto == IPPROTO_TCP)
-		sock_type = SOCK_STREAM;
-	else
-		return -EINVAL;
+	int ret, s;
 
-	s = socket(family, sock_type, 0);
+	s = socket(family, type, 0);
 	if (s < 0) {
 		perror("cannot create socket");
 		return -1;
 	}
 
-	switch (family) {
-	case AF_INET:
-		in = (struct sockaddr_in *)&local_sock;
-		in->sin_family = family;
-		in->sin_port = htons(ctx->lport);
-		in->sin_addr.s_addr = htonl(INADDR_ANY);
-		sock_len = sizeof(*in);
-		break;
-	case AF_INET6:
-		in6 = (struct sockaddr_in6 *)&local_sock;
-		in6->sin6_family = family;
-		in6->sin6_port = htons(ctx->lport);
-		in6->sin6_addr = in6addr_any;
-		sock_len = sizeof(*in6);
-		break;
-	default:
-		return -1;
-	}
-
 	int opt = 1;
 
 	ret = setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
 
 	if (ret < 0) {
 		perror("setsockopt for SO_REUSEADDR");
-		return ret;
+		goto close;
 	}
 
 	ret = setsockopt(s, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
 	if (ret < 0) {
 		perror("setsockopt for SO_REUSEPORT");
-		return ret;
+		goto close;
 	}
 
 	if (ctx->mark != 0) {
@@ -530,16 +500,17 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 				 sizeof(ctx->mark));
 		if (ret < 0) {
 			perror("setsockopt for SO_MARK");
-			return ret;
+			goto close;
 		}
 	}
 
 	if (family == AF_INET6) {
 		opt = 0;
-		if (setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &opt,
-			       sizeof(opt))) {
+		ret = setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, &opt,
+				 sizeof(opt));
+		if (ret < 0) {
 			perror("failed to set IPV6_V6ONLY");
-			return -1;
+			goto close;
 		}
 	}
 
@@ -547,45 +518,83 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 		if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE, ctx->bind_dev,
 			       strlen(ctx->bind_dev) + 1) != 0) {
 			perror("setsockopt for SO_BINDTODEVICE");
-			return -1;
+			goto close;
 		}
 	}
 
-	ret = bind(s, (struct sockaddr *)&local_sock, sock_len);
-	if (ret < 0) {
-		perror("cannot bind socket");
-		goto err_socket;
+	return s;
+close:
+	close(s);
+	return ret;
+}
+
+static int ovpn_setup_socket(struct ovpn_ctx *ctx, sa_family_t family,
+			     int socktype)
+{
+	struct addrinfo *list_ai, *curr_ai;
+	struct addrinfo hints;
+	int ret, socket;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_flags = AI_NUMERICHOST | AI_NUMERICSERV |
+			 (socktype == SOCK_STREAM ? 0: AI_V4MAPPED) |
+			 (ctx->laddr ? 0 : AI_PASSIVE);
+	hints.ai_family = family;
+	hints.ai_socktype = socktype;
+	ret = getaddrinfo(ctx->laddr, ctx->lport, &hints, &list_ai);
+	if (ret) {
+		fprintf(stderr, "laddr %s, lport %s, getaddrinfo on local address: %s\n", ctx->laddr, ctx->lport, gai_strerror(ret));
+		return ret;
 	}
 
-	ctx->socket = s;
-	ctx->sa_family = family;
-	return 0;
+	for (curr_ai = list_ai; curr_ai != NULL; curr_ai = curr_ai->ai_next) {
+		socket = ovpn_socket(ctx, family, socktype);
+		if (socket < 0)
+			continue;
 
-err_socket:
-	close(s);
-	return -1;
+		ret = bind(socket, curr_ai->ai_addr, curr_ai->ai_addrlen);
+		if (ret == 0)
+			break;
+
+		close(socket);
+	}
+
+	freeaddrinfo(list_ai);
+
+	if (ret < 0) {
+		perror("cannot setup socket\n");
+		return ret;
+	}
+
+	return socket;
 }
 
 static int ovpn_udp_socket(struct ovpn_ctx *ctx, sa_family_t family)
 {
-	return ovpn_socket(ctx, family, IPPROTO_UDP);
+	int socket = ovpn_setup_socket(ctx, family, SOCK_DGRAM);
+	if (socket < 0)
+		return socket;
+
+	ctx->sa_family = family;
+	ctx->socket = socket;
+	return 0;
 }
 
 static int ovpn_listen(struct ovpn_ctx *ctx, sa_family_t family)
 {
-	int ret;
+	int ret, socket = ovpn_setup_socket(ctx, family, SOCK_STREAM);
+	if (socket < 0)
+		return socket;
 
-	ret = ovpn_socket(ctx, family, IPPROTO_TCP);
-	if (ret < 0)
-		return ret;
-
-	ret = listen(ctx->socket, 10);
+	ret = listen(socket, 10);
 	if (ret < 0) {
 		perror("listen");
-		close(ctx->socket);
+		close(socket);
 		return -1;
 	}
 
+	ctx->sa_family = family;
+	ctx->socket = socket;
 	return 0;
 }
 
@@ -620,18 +629,13 @@ static int ovpn_accept(struct ovpn_ctx *ctx)
 	return ret;
 }
 
-static int ovpn_connect(struct ovpn_ctx *ovpn)
+static int ovpn_connect(struct ovpn_ctx *ctx)
 {
+	const sa_family_t family = ctx->remote.in4.sin_family;
 	socklen_t socklen;
-	int s, ret;
+	int ret, socket;
 
-	s = socket(ovpn->remote.in4.sin_family, SOCK_STREAM, 0);
-	if (s < 0) {
-		perror("cannot create socket");
-		return -1;
-	}
-
-	switch (ovpn->remote.in4.sin_family) {
+	switch (family) {
 	case AF_INET:
 		socklen = sizeof(struct sockaddr_in);
 		break;
@@ -642,20 +646,22 @@ static int ovpn_connect(struct ovpn_ctx *ovpn)
 		return -EOPNOTSUPP;
 	}
 
-	ret = connect(s, (struct sockaddr *)&ovpn->remote, socklen);
+	socket = ovpn_setup_socket(ctx, family, SOCK_STREAM);
+	if (socket < 0)
+		return socket;
+
+	ret = connect(socket, (struct sockaddr *)&ctx->remote, socklen);
 	if (ret < 0) {
 		perror("connect");
-		goto err;
+		close(socket);
+		return ret;
 	}
 
 	fprintf(stderr, "connected\n");
 
-	ovpn->socket = s;
-
+	ctx->sa_family = family;
+	ctx->socket = socket;
 	return 0;
-err:
-	close(s);
-	return ret;
 }
 
 static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
@@ -1702,7 +1708,7 @@ static void usage(const char *cmd)
 		"\tkey_file: file containing the symmetric key for encryption\n");
 
 	fprintf(stderr,
-		"* new_peer <iface> <dev> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
+		"* new_peer <iface> <dev> <peer_id> <tx_id> <laddr> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr,
 		"\tdev: transport interface name to bind to, supports 'any'\n");
@@ -1711,15 +1717,19 @@ static void usage(const char *cmd)
 		"\tpeer_id: peer ID found in data packets received from this peer\n");
 	fprintf(stderr,
 		"\ttx_id: peer ID to be used when sending to this peer\n");
+	fprintf(stderr,
+		"\tladdr: local UDP address to bind to, supports 'any'\n");
 	fprintf(stderr, "\traddr: peer IP address\n");
 	fprintf(stderr, "\trport: peer UDP port\n");
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr,
-		"* new_multi_peer <iface> <dev> <lport> <peers_file> [mark]: add multiple peers as listed in the file\n");
+		"* new_multi_peer <iface> <dev> <laddr> <lport> <peers_file> [mark]: add multiple peers as listed in the file\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr,
 		"\tdev: transport interface name to bind to, supports 'any'\n");
+	fprintf(stderr,
+		"\tladdr: local UDP address to bind to, supports 'any'\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
 		"\tpeers_file: text file containing one peer per line. Line format:\n");
@@ -2203,11 +2213,8 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		if (argc < 5)
 			return -EINVAL;
 
-		ovpn->lport = strtoul(argv[3], NULL, 10);
-		if (errno == ERANGE || ovpn->lport > 65535) {
-			fprintf(stderr, "lport value out of range\n");
-			return -1;
-		}
+		ovpn->laddr = NULL;
+		ovpn->lport = argv[3];
 
 		ovpn->peers_file = argv[4];
 
@@ -2221,6 +2228,9 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 
 		ovpn->sa_family = AF_INET;
 
+		ovpn->laddr = NULL;
+		ovpn->lport = "1";
+
 		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[5], argv[6],
 					  NULL);
 		if (ret < 0) {
@@ -2240,41 +2250,35 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 		break;
 	case CMD_NEW_PEER:
-		if (argc < 8)
+		if (argc < 9)
 			return -EINVAL;
 
 		ovpn->bind_dev = strcmp(argv[3], "any") == 0 ? NULL : argv[3];
 
-		ovpn->lport = strtoul(argv[6], NULL, 10);
-		if (errno == ERANGE || ovpn->lport > 65535) {
-			fprintf(stderr, "lport value out of range\n");
-			return -1;
-		}
+		ovpn->laddr = strcmp(argv[6], "any") == 0 ? NULL : argv[6];
+		ovpn->lport = argv[7];
 
-		const char *vpnip = (argc > 9) ? argv[9] : NULL;
+		const char *vpnip = (argc > 10) ? argv[10] : NULL;
 
-		ret = ovpn_parse_new_peer(ovpn, argv[4], argv[5], argv[7], argv[8],
+		ret = ovpn_parse_new_peer(ovpn, argv[4], argv[5], argv[8], argv[9],
 					  vpnip);
 		if (ret < 0)
 			return -1;
 		break;
 	case CMD_NEW_MULTI_PEER:
-		if (argc < 6)
+		if (argc < 7)
 			return -EINVAL;
 
 		ovpn->bind_dev = strcmp(argv[3], "any") == 0 ? NULL : argv[3];
 
-		ovpn->lport = strtoul(argv[4], NULL, 10);
-		if (errno == ERANGE || ovpn->lport > 65535) {
-			fprintf(stderr, "lport value out of range\n");
-			return -1;
-		}
+		ovpn->laddr = strcmp(argv[4], "any") == 0 ? NULL : argv[4];
+		ovpn->lport = argv[5];
 
-		ovpn->peers_file = argv[5];
+		ovpn->peers_file = argv[6];
 
 		ovpn->mark = 0;
-		if (argc > 6) {
-			ovpn->mark = strtoul(argv[6], NULL, 10);
+		if (argc > 7) {
+			ovpn->mark = strtoul(argv[7], NULL, 10);
 			if (errno == ERANGE || ovpn->mark > UINT32_MAX) {
 				fprintf(stderr, "mark value out of range\n");
 				return -1;
diff --git a/tools/testing/selftests/net/ovpn/test-bind-addr.sh b/tools/testing/selftests/net/ovpn/test-bind-addr.sh
new file mode 100755
index 000000000000..e33a433ceb4b
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-bind-addr.sh
@@ -0,0 +1,10 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2025 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+BIND_TYPE="ADDR"
+
+source test-bind.sh
diff --git a/tools/testing/selftests/net/ovpn/test-bind.sh b/tools/testing/selftests/net/ovpn/test-bind.sh
index fd7c3c8fdf63..b642f396c2a4 100755
--- a/tools/testing/selftests/net/ovpn/test-bind.sh
+++ b/tools/testing/selftests/net/ovpn/test-bind.sh
@@ -11,6 +11,8 @@ set -e
 PROTO=UDP
 source ./common.sh
 
+BIND_TYPE=${BIND_TYPE:-"DEV"}
+
 cleanup
 
 modprobe -q ovpn || true
@@ -61,17 +63,19 @@ run_bind_test() {
 	# close any active socket
 	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
 
-	ip netns exec peer1 ${OVPN_CLI} new_peer tun1 ${dev1} 1 10 1 ${raddr4_peer1} 1
+	ip netns exec peer1 ${OVPN_CLI} new_peer tun1 ${dev1} 1 10 ${raddr4_peer2} 1 ${raddr4_peer1} 1
 	ip netns exec peer1 ${OVPN_CLI} new_key tun1 1 1 0 ${ALG} 0 data64.key
-	ip netns exec peer2 ${OVPN_CLI} new_peer tun2 ${dev2} 10 1 1 ${raddr4_peer2} 1
+	ip netns exec peer2 ${OVPN_CLI} new_peer tun2 ${dev2} 10 1 ${raddr4_peer1} 1 ${raddr4_peer2} 1
 	ip netns exec peer2 ${OVPN_CLI} new_key tun2 10 1 0 ${ALG} 1 data64.key
 
 	ip netns exec peer1 ${OVPN_CLI} set_peer tun1 1 60 120
 	ip netns exec peer2 ${OVPN_CLI} set_peer tun2 10 60 120
 
-	timeout 2 ip netns exec peer1 tcpdump -i veth1 "${PROTO,,}" port 1 -n -q > /tmp/ovpn-bind1.log &
+	timeout 2 ip netns exec peer1 tcpdump -i veth1 "${PROTO,,}" and host ${raddr4_peer2} \
+		and port 1 -n -q > /tmp/ovpn-bind1.log &
 	tcpdump1_pid=$!
-	timeout 2 ip netns exec peer1 tcpdump -i veth2 "${PROTO,,}" port 1 -n -q > /tmp/ovpn-bind2.log &
+	timeout 2 ip netns exec peer1 tcpdump -i veth2 "${PROTO,,}" and host ${raddr4_peer2} \
+		and port 1 -n -q > /tmp/ovpn-bind2.log &
 	tcpdump2_pid=$!
 	sleep 0.5
 
@@ -81,21 +85,31 @@ run_bind_test() {
 	wait ${tcpdump2_pid} || true
 }
 
-run_bind_test veth1 any 10.10.10.2 10.10.10.1
-[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
-[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
-
-run_bind_test veth2 any 20.20.20.2 20.20.20.1
-[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
-[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
-
-run_bind_test any veth1 10.10.10.2 10.10.10.1
-[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
-[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
-
-run_bind_test any veth2 20.20.20.2 20.20.20.1
-[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
-[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
+if [ "${BIND_TYPE}" == "DEV" ]; then
+	run_bind_test veth1 any 10.10.10.2 10.10.10.1
+	[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
+	[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
+
+	run_bind_test veth2 any 20.20.20.2 20.20.20.1
+	[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
+	[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
+
+	run_bind_test any veth1 10.10.10.2 10.10.10.1
+	[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
+	[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
+
+	run_bind_test any veth2 20.20.20.2 20.20.20.1
+	[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
+	[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
+else
+	run_bind_test any any 10.10.10.2 10.10.10.1
+	[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
+	[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
+
+	run_bind_test any any 20.20.20.2 20.20.20.1
+	[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
+	[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
+fi
 
 cleanup
 
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index c2600bb22e2c..6f575f7b0635 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -26,7 +26,7 @@ for p in $(seq 0 3); do
 done
 
 # add peer0 with mark
-ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 any 1 ${UDP_PEERS_FILE} ${MARK}
+ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 any any 1 ${UDP_PEERS_FILE} ${MARK}
 for p in $(seq 1 3); do
 	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 data64.key
 done
-- 
2.51.2


