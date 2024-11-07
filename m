Return-Path: <linux-kselftest+bounces-21633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B2E9C0D8A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E591C2357C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004E21858C;
	Thu,  7 Nov 2024 18:12:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE4217F4B;
	Thu,  7 Nov 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003143; cv=none; b=B4clmk6iIJv7GMpS2A7ZLJWbAc/LxG3TkUYXfJ7nN1qMGiw3gATsTjp5t1o31szJYVrJg0LtXEGR8PINT+sNxgcrv50RIS3Tt6utYmQLXGDIMC+Lcl+52iDYnVYCOtk40RwH1jKMsqufjyU0DqmwEPU5vmpTbP24qAYsSc46CCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003143; c=relaxed/simple;
	bh=iPzT6eQpRnHtKqTPuVl6lvCdUooVuLUt7jI+2VuHlrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+6NOiQoAid7zZsnvhE6OM2Q365di/uzsdLOsP1z3QDhD/BlsMB62KxJa/m0Vixud4FgaAwk0GYxTjiiew7Ut6tkkBs3121nWU3jXSS7LVVXGuyl2rhVQO6aT9igGzp9lNbHdwY14QbBXr0Uth0rrVTh17btYY4G8FXVNJRF/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cf3e36a76so13841815ad.0;
        Thu, 07 Nov 2024 10:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003140; x=1731607940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkoD+bxqtCPC7R806MtQ5rvDQ1QYwwjiPHDFKfL1vC8=;
        b=OpePH3ARmo6prGV6n1PaJrXLiJujXrE5xn/Jtue5bR9knfzVzjFJwVUHHYFrUzODdb
         o/jjaqUuqTM6IZtqlpMgGPHxxDGa4fog/ASxkjgy9sbh8zj8MbUUTVaRfP2bD2pe7TpL
         VO4PcGoNyNES+1fZLS9QOLE2C7RMgkEFZo29zo0LmVVpffstw617B8BXl/v0Q7JULihf
         NqTQm9Sf4n7k/unasqBc4JS8dQT9PKqyzLIX9df71jLVcqSMfZjx7ULRRoyoPnhPT1Oh
         EEwOGqumL4CT2BRAD66bwQc3rtszySowq/kLq7IhCY9Zr7xVfWlqqwTJO+NxuR6+uJb8
         eTuw==
X-Forwarded-Encrypted: i=1; AJvYcCU2VYZBo3sWRk5xL2cpLuqk3uWDDUpe4QBqFQg9ZFYSO5e7hdzYb2wSxoBf3eA2QxdX4AssqQJLpN0n6zDQax89@vger.kernel.org, AJvYcCWIqLf5zmItYSsgf5YqzgTs1Rx/GEeR56m1SwT64hTJmTzvUb3NVn1b71uA/YSZ6UgYP4i98atEqErB8Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8I0XEyyPBjiHpt11ptsOWIXHh2RO4URVOEUS1GTtHaZQlfH4
	ikG3K0YomYndFREms+l7g7IUxqwZoSozoy3pbl2r+qwzH5RNEE+inojO
X-Google-Smtp-Source: AGHT+IFfWMHmWKQt25HlMZkBuNTrZHct4RqK/6pujgP5Z9sdOvonYfOxwvO8UhuTSZsqhrZ1fdBgIw==
X-Received: by 2002:a17:903:41c9:b0:20b:b5d5:8072 with SMTP id d9443c01a7336-2118116ceb2mr11136765ad.2.1731003140395;
        Thu, 07 Nov 2024 10:12:20 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e49489sm15014015ad.136.2024.11.07.10.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:20 -0800 (PST)
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
	petrm@nvidia.com,
	jdamato@fastly.com
Subject: [PATCH net-next v8 06/12] selftests: ncdevmem: Switch to AF_INET6
Date: Thu,  7 Nov 2024 10:12:05 -0800
Message-ID: <20241107181211.3934153-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107181211.3934153-1-sdf@fomichev.me>
References: <20241107181211.3934153-1-sdf@fomichev.me>
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
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 97 ++++++++++++++++++--------
 1 file changed, 68 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 0feeca56c049..645ef0bb63ec 100644
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
+	char buf[40];
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
@@ -299,13 +312,51 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
+static void enable_reuseaddr(int fd)
+{
+	int opt = 1;
+	int ret;
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
+	if (ret)
+		error(1, errno, "%s: [FAIL, SO_REUSEPORT]\n", TEST_PREFIX);
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
+	if (ret)
+		error(1, errno, "%s: [FAIL, SO_REUSEADDR]\n", TEST_PREFIX);
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
@@ -317,9 +368,12 @@ int do_server(struct memory_buffer *mem)
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
 
@@ -328,7 +382,7 @@ int do_server(struct memory_buffer *mem)
 		error(1, 0, "Failed to configure rss\n");
 
 	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering())
+	if (configure_flow_steering(&server_sin))
 		error(1, 0, "Failed to configure flow steering\n");
 
 	sleep(1);
@@ -349,29 +403,14 @@ int do_server(struct memory_buffer *mem)
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
-	if (ret)
-		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+	enable_reuseaddr(socket_fd);
 
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
-		ntohs(server_sin.sin_port));
+		ntohs(server_sin.sin6_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
@@ -383,16 +422,16 @@ int do_server(struct memory_buffer *mem)
 
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


