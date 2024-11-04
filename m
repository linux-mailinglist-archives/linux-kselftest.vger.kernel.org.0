Return-Path: <linux-kselftest+bounces-21399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B79BBD13
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E101F23684
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AAB1D1319;
	Mon,  4 Nov 2024 18:14:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAA1D094B;
	Mon,  4 Nov 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744081; cv=none; b=EdDhG5me7GFAe+Sj8iBawsFHiVcIn0BgM7Hd/JmAZHqF9XZDXuL0/VxbrlQfnYsftzq2Abg4SXLoUdBTIv5tFr53Q+eH5OAElzifJpTW78EX+yMxgbItmc8CFFJPITwoVLCnc0daSj1uvP7n50/F+IRUslXJlLRwzyeo08wyRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744081; c=relaxed/simple;
	bh=b0Dkv5Sy5ji+/9wdnjShe98xD6WGhX0x1ggGrQrv4Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MroVZiuzrGzQrIrvvSQs6L30TXGhErfUfgDmPTqdMTSJjUacgXV8asPRaS2jrhRADdHJqTBvbOXHtOQX3ORF6pMpei42sFIRbAchEe/sLhTH0kOZGu6MNgEEnOgAZJ5SZTNLN+IcysGmsQwxYhgGEhIF3fGcMNRj4G2pPSlgl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e467c3996so3847363b3a.2;
        Mon, 04 Nov 2024 10:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744079; x=1731348879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X35Ea0gz6V3qdg4j5NOe8UKNtP5acIZlBezrrhgypI=;
        b=MqbLcwR00g96DXRceNAt6HLx+PdCGihW9i5fI63mn5RKBCXXTLPwZlVDtbjYlpYmzJ
         /q8f2ijJG9/xoPD+UuuOqLF1bjhupuuVnBH3+kFXpAc6N4q5pkeM3GZoC6juvi+/Dwsh
         nlq+uA/I47+2ukjMiY9UsS7GJ/0bPlKMzl0xhfguZ/ZJyxxcvvV/ha8/N8UfiPKIp/UZ
         ym4iWyZWc/kFaoc5Zq8x+QS4VuAb3wLk/kF5favRIamA5UKq7U78iw62jb5XhtgRhPvd
         NfCLUIRTlzDlCp2pF7t47joI6S4lRw+MXaeRUOpTYtd5x1rQqFFEgyfw+pXz4tUVqJ7i
         aEEw==
X-Forwarded-Encrypted: i=1; AJvYcCX8QKOPZzcfbb0Pq/rup6jb59ijdO0qKUtEElq0qhjFEyesAGqvgqIXnKJQ6W7qi9EgaIeL4SCYxfy9iJPqZNBI@vger.kernel.org, AJvYcCXN+0pSPcIHSe7MQNFVKLCdQeA8Z/0hiSDxo4E7ul73SYAPiQu9cipz0Z42Qklzf8nNWQdLRAowmOdX4No=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIEL7mXtMhHw1Q9Hkb3zLs6EQS5hE0IH2gzLy5RXY7UT36ntNa
	8YMg0eptWL/8RsB1sJqo2k2y2VwcIarLK34qLHFwG5y0nLVzE+kdCxsY
X-Google-Smtp-Source: AGHT+IEWUiEq0a5bX1B33Rpzfhsz7vTOsBQVWJU64wJHkE+NBxwcLgeybNC9yB973pZ9nFMHpZWjxQ==
X-Received: by 2002:a05:6a00:3d0d:b0:71d:ee1b:c851 with SMTP id d2e1a72fcca58-72062f13bd9mr47350527b3a.7.1730744079429;
        Mon, 04 Nov 2024 10:14:39 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm8114424b3a.12.2024.11.04.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:38 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v7 06/12] selftests: ncdevmem: Switch to AF_INET6
Date: Mon,  4 Nov 2024 10:14:24 -0800
Message-ID: <20241104181430.228682-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104181430.228682-1-sdf@fomichev.me>
References: <20241104181430.228682-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dualstack socket to support both v4 and v6. v4-mapped-v6 address
can be used to do v4.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 99 ++++++++++++++++++--------
 1 file changed, 71 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 0feeca56c049..c4897b2bdc7c 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -242,13 +242,26 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 	return run_command("sudo ethtool -L %s rx %u tx %u", ifname, rx, tx);
 }
 
-static int configure_flow_steering(void)
+static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+	const char *type = "tcp6";
+	const char *server_addr;
+	char buf[256];
+
+	inet_ntop(AF_INET6, &server_sin->sin6_addr, buf, sizeof(buf));
+	server_addr = buf;
+
+	if (IN6_IS_ADDR_V4MAPPED(&server_sin->sin6_addr)) {
+		type = "tcp4";
+		server_addr = strrchr(server_addr, ':') + 1;
+	}
+
+	return run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
 			   ifname,
+			   type,
 			   client_ip ? "src-ip" : "",
 			   client_ip ?: "",
-			   server_ip,
+			   server_addr,
 			   client_ip ? "src-port" : "",
 			   client_ip ? port : "",
 			   port, start_queue);
@@ -299,13 +312,53 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
+static int enable_reuseaddr(int fd)
+{
+	int opt = 1;
+	int ret;
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
+	if (ret)
+		return -errno;
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
+	if (ret)
+		return -errno;
+
+	return 0;
+}
+
+static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
+{
+	int ret;
+
+	sin6->sin6_family = AF_INET6;
+	sin6->sin6_port = htons(port);
+
+	ret = inet_pton(sin6->sin6_family, str, &sin6->sin6_addr);
+	if (ret != 1) {
+		/* fallback to plain IPv4 */
+		ret = inet_pton(AF_INET, str, &sin6->sin6_addr.s6_addr32[3]);
+		if (ret != 1)
+			return -1;
+
+		/* add ::ffff prefix */
+		sin6->sin6_addr.s6_addr32[0] = 0;
+		sin6->sin6_addr.s6_addr32[1] = 0;
+		sin6->sin6_addr.s6_addr16[4] = 0;
+		sin6->sin6_addr.s6_addr16[5] = 0xffff;
+	}
+
+	return 0;
+}
+
 int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
 	size_t non_page_aligned_frags = 0;
-	struct sockaddr_in client_addr;
-	struct sockaddr_in server_sin;
+	struct sockaddr_in6 client_addr;
+	struct sockaddr_in6 server_sin;
 	size_t page_aligned_frags = 0;
 	size_t total_received = 0;
 	socklen_t client_addr_len;
@@ -317,9 +370,12 @@ int do_server(struct memory_buffer *mem)
 	int socket_fd;
 	int client_fd;
 	size_t i = 0;
-	int opt = 1;
 	int ret;
 
+	ret = parse_address(server_ip, atoi(port), &server_sin);
+	if (ret < 0)
+		error(1, 0, "parse server address");
+
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
 
@@ -328,7 +384,7 @@ int do_server(struct memory_buffer *mem)
 		error(1, 0, "Failed to configure rss\n");
 
 	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering())
+	if (configure_flow_steering(&server_sin))
 		error(1, 0, "Failed to configure flow steering\n");
 
 	sleep(1);
@@ -349,29 +405,16 @@ int do_server(struct memory_buffer *mem)
 	if (!tmp_mem)
 		error(1, ENOMEM, "malloc failed");
 
-	server_sin.sin_family = AF_INET;
-	server_sin.sin_port = htons(atoi(port));
-
-	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
-	if (ret < 0)
-		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
-
-	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
+	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (socket_fd < 0)
 		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
-	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
-			 sizeof(opt));
-	if (ret)
-		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
-
-	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
-			 sizeof(opt));
+	ret = enable_reuseaddr(socket_fd);
 	if (ret)
-		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, reuseaddr]\n", TEST_PREFIX);
 
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
-		ntohs(server_sin.sin_port));
+		ntohs(server_sin.sin6_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
@@ -383,16 +426,16 @@ int do_server(struct memory_buffer *mem)
 
 	client_addr_len = sizeof(client_addr);
 
-	inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
+	inet_ntop(AF_INET6, &server_sin.sin6_addr, buffer,
 		  sizeof(buffer));
 	fprintf(stderr, "Waiting or connection on %s:%d\n", buffer,
-		ntohs(server_sin.sin_port));
+		ntohs(server_sin.sin6_port));
 	client_fd = accept(socket_fd, &client_addr, &client_addr_len);
 
-	inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
+	inet_ntop(AF_INET6, &client_addr.sin6_addr, buffer,
 		  sizeof(buffer));
 	fprintf(stderr, "Got connection from %s:%d\n", buffer,
-		ntohs(client_addr.sin_port));
+		ntohs(client_addr.sin6_port));
 
 	while (1) {
 		struct iovec iov = { .iov_base = iobuf,
-- 
2.47.0


