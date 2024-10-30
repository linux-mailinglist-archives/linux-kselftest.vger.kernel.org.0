Return-Path: <linux-kselftest+bounces-21114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B0C9B65CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87AB1F242C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E885D1F891B;
	Wed, 30 Oct 2024 14:27:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3951F7082;
	Wed, 30 Oct 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298454; cv=none; b=Rk39XR/hKYwWRBeo6ys4yd+hqDQB5OoG/2XmNcfn4yKRZac4mtWOYAUOIJBtKvx8J9T5rl6o4XPPBfT6gOVU5mbNn48ZNdhnBJWyNTLK7UIjd9oQj7WmyPt9PxXtskOlg5af6SS5kUKmHX59KTtTFTmWmFBTVIBwCV1PnJbk0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298454; c=relaxed/simple;
	bh=/9Aeg71P+WeuP/lJ/VnhMNWlAqelLsVbXCewlIWWuVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVL+qGPKOos23L4N71QW2IrMSewcQjpxLFzNlTAta3L9BMOWBfNkxMAytpM8SB3ep7IerFvULf7yky96nsI527RLi4b/KgEaSmio/F8s5Woz9qyx4pxHxpu0JtTqCdteyD/D27Qzjx8khUnW+oqn8opFcy78+35ICnqaBzJMZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cb7139d9dso65164865ad.1;
        Wed, 30 Oct 2024 07:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298451; x=1730903251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGFZk/edoAU0ji551OMPbJzhccOrkILDSWMyBZaA81E=;
        b=J/hXwXb7zzIpBAhdB4OrbOdEK6sNOn+faLplawf0DGvRuztjeiz0wwMD6ItKL5sYv+
         eciARKL/jqANjuIQf1etGkRQ4602VwdCtj0fUI4NI5BZr71IDTls0J4TF908kzFB0BZh
         /7JPFvzHfW/WhN6qKpTXHBuXtBWVhxhDJ8qxo2unlV1ZyIX5E5IbznJp3kaoNghF2IXW
         ZRWX8bXvGUtyot0r5H1/f6s0IxFU1VLUzz73zzSonvhVbFCYIwQyqfNfAroweYaR/pSb
         3E7WXUdlTW3fJk1BZ+K8InpLPTgh8mQ0weRzm1W97qILeQRcY8pGwy3flrvgovzzDhfp
         wLPg==
X-Forwarded-Encrypted: i=1; AJvYcCX6EN9dqPQEM/PigaI/fSrdUNLTOTpar0ktuQijebOrfAkCfQmyDBLXcAOjopo+3PUwS27FroDedqOehQ2zPsDu@vger.kernel.org, AJvYcCX7/OtZ/EBmlUzqYFyN6s1/1MEVCOZF9ST6pbfuCUS12SQgGMD7zM4TW32GeZ/hhFUNcRDf4+9kHxXb77s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1ZjkRPEGX7CXkwwlH+F7pTI3Yr+VE6qn3q1G9HVW6RAlkKbV
	imBIa78JREJ2SbO3ILHaEmOVvT9x5Q6BzpTu/n7txHehShIXaw/Xxtz6UsE=
X-Google-Smtp-Source: AGHT+IFTtAIbKvQ4WSBihFqCuysx6SerVOR0yHxJZyGQPpm1cBM+uEjEKheafjWJB3/8SGTrhMFuXg==
X-Received: by 2002:a17:902:e548:b0:20b:951f:6dff with SMTP id d9443c01a7336-210c673ae39mr188774055ad.0.1730298451479;
        Wed, 30 Oct 2024 07:27:31 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc03d50esm81347085ad.231.2024.10.30.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:31 -0700 (PDT)
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
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 06/12] selftests: ncdevmem: Switch to AF_INET6
Date: Wed, 30 Oct 2024 07:27:16 -0700
Message-ID: <20241030142722.2901744-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
References: <20241030142722.2901744-1-sdf@fomichev.me>
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
 tools/testing/selftests/net/ncdevmem.c | 85 +++++++++++++++++---------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 037fb6e97d29..8e4a0fe74bb1 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -242,13 +242,22 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 	return run_command("sudo ethtool -L %s rx %u tx %u", ifname, rx, tx);
 }
 
-static int configure_flow_steering(void)
+static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+	const char *server_addr = server_ip;
+	const char *type = "tcp6";
+
+	if (IN6_IS_ADDR_V4MAPPED(&server_sin->sin6_addr)) {
+		type = "tcp4";
+		server_addr = strrchr(server_ip, ':') + 1;
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
@@ -299,13 +308,43 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
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
+	if (ret < 0)
+		return -1;
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
@@ -317,9 +356,12 @@ int do_server(struct memory_buffer *mem)
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
 
@@ -328,7 +370,7 @@ int do_server(struct memory_buffer *mem)
 		error(1, 0, "Failed to configure rss\n");
 
 	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering())
+	if (configure_flow_steering(&server_sin))
 		error(1, 0, "Failed to configure flow steering\n");
 
 	sleep(1);
@@ -349,29 +391,16 @@ int do_server(struct memory_buffer *mem)
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
@@ -383,16 +412,16 @@ int do_server(struct memory_buffer *mem)
 
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


