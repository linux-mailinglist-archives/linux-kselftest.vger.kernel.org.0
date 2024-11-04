Return-Path: <linux-kselftest+bounces-21394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961419BBD00
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E73B21BA6
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C11CBEAB;
	Mon,  4 Nov 2024 18:14:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723931CACDE;
	Mon,  4 Nov 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744075; cv=none; b=aFUjxpELGhzgm1qz5IDR388wnpgfARHRunCZYWCveuuSJ9+qB3GRiI4hxhDW/XOphjGblwaRPI9X05YZTIoIW91R81B5xKSd78sFIxJkGYVl/Bm7T8slI20nAIqUkdtEM+T+ReKycsCpPvvlb+gJJe0KsIA9nHQ7zVTG3kkbwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744075; c=relaxed/simple;
	bh=DbSfoMlzpZVhU+8FFsUY3AHTX/zbUMYdVXfjpyEzHfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTFcb05crRLy92cc4t49GeM1F+2i/5fddl86dI2TIxRagNgyPYPXt6vTRFRmlUM7RAX4WqVdnVMUXqjbeCvI1+7NX0GYBzwJmJstPuQJGzfzShk+ucOSxqwe3quWyn+TGmLAVofe9Zd8QqmgISsgMqLMViI2xYu5jxI+HO6nsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c9978a221so46386495ad.1;
        Mon, 04 Nov 2024 10:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744072; x=1731348872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYIgIfdOM+KXAHby1i+hfUVdj9h7/069nIsE/U1uz/s=;
        b=oVgp0Y95/ShZ1Vt+t38PjMD6xGGvRHTRaS5Zo1sHbqCqCyfWlH2mJYNf2nz7QIM94t
         YH66XjAQTlvr5cW8HTClwTiBdtnnyoCfi3GpTQ+h3k6Kt1oJUPyp6jyhaP1h8iNewxfo
         i14gZRYFjRn3EScwG7b5FBBwOy7k6HDqILuxtN65kUmyjltgz6Q0uDn+4mUYvSf/8FlM
         aAoT9TDmaN0S1RFn7SA+iKMJQ/OWCyy4VSXRipX0z66FJQG7T7V8lrexdJWMC+5s0XS/
         SQiteLH/R6U7oQLEODFl7TXiXK3TtvAXXn2gztknQixpjYzwVHSKJBuk8k5v/q0gOg3W
         OsLA==
X-Forwarded-Encrypted: i=1; AJvYcCVr65QvozzzWmRIYinic6jKN2mJLP9t7SVb9gdYbkYWYFG7NaRxqCfIHoDZQxdHm86ASCMDj2tho9fYLrg=@vger.kernel.org, AJvYcCWVTySELstQzev7JN+Fj1AxUTyb2SOL1pW8KXMKP9WzhmyLOVYHIAfnXiz7QhsKzlJEa1CZ0Fu+hJRgWV4M6e/8@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXFsbtsUCfc9ojk4Gd5zLn9ingt3X2hAMLzcEa3G00CamSbXN
	UZhtG/hHi/Kcm5MotPfCDLMY/Ex9gegtR1XBYHLbNqKiX02rGD5wl/Yt
X-Google-Smtp-Source: AGHT+IH5Hx5+8+j+5liP9xAPcP7HashQcWijPfR76kZPLAH59RNeYTmm2b1V3DjWdot+Rfx3zZjMIA==
X-Received: by 2002:a17:902:dad1:b0:20c:ecc9:c50b with SMTP id d9443c01a7336-210c6c6e9bamr435809395ad.42.1730744072446;
        Mon, 04 Nov 2024 10:14:32 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d8d4dsm63222975ad.270.2024.11.04.10.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:32 -0800 (PST)
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
Subject: [PATCH net-next v7 01/12] selftests: ncdevmem: Redirect all non-payload output to stderr
Date: Mon,  4 Nov 2024 10:14:19 -0800
Message-ID: <20241104181430.228682-2-sdf@fomichev.me>
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

That should make it possible to do expected payload validation on
the caller side.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 61 +++++++++++++-------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 64d6805381c5..9245d3f158dd 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -88,7 +88,6 @@ void print_nonzero_bytes(void *ptr, size_t size)
 
 	for (i = 0; i < size; i++)
 		putchar(p[i]);
-	printf("\n");
 }
 
 void validate_buffer(void *line, size_t size)
@@ -120,7 +119,7 @@ void validate_buffer(void *line, size_t size)
 		char command[256];                                      \
 		memset(command, 0, sizeof(command));                    \
 		snprintf(command, sizeof(command), cmd, ##__VA_ARGS__); \
-		printf("Running: %s\n", command);                       \
+		fprintf(stderr, "Running: %s\n", command);                       \
 		system(command);                                        \
 	})
 
@@ -128,22 +127,22 @@ static int reset_flow_steering(void)
 {
 	int ret = 0;
 
-	ret = run_command("sudo ethtool -K %s ntuple off", ifname);
+	ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
 	if (ret)
 		return ret;
 
-	return run_command("sudo ethtool -K %s ntuple on", ifname);
+	return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
 }
 
 static int configure_headersplit(bool on)
 {
-	return run_command("sudo ethtool -G %s tcp-data-split %s", ifname,
+	return run_command("sudo ethtool -G %s tcp-data-split %s >&2", ifname,
 			   on ? "on" : "off");
 }
 
 static int configure_rss(void)
 {
-	return run_command("sudo ethtool -X %s equal %d", ifname, start_queue);
+	return run_command("sudo ethtool -X %s equal %d >&2", ifname, start_queue);
 }
 
 static int configure_channels(unsigned int rx, unsigned int tx)
@@ -153,7 +152,7 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 
 static int configure_flow_steering(void)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d",
+	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d >&2",
 			   ifname, client_ip, server_ip, port, port, start_queue);
 }
 
@@ -187,7 +186,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 		goto err_close;
 	}
 
-	printf("got dmabuf id=%d\n", rsp->id);
+	fprintf(stderr, "got dmabuf id=%d\n", rsp->id);
 	dmabuf_id = rsp->id;
 
 	netdev_bind_rx_req_free(req);
@@ -314,8 +313,8 @@ int do_server(void)
 	if (ret)
 		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
-	printf("binding to address %s:%d\n", server_ip,
-	       ntohs(server_sin.sin_port));
+	fprintf(stderr, "binding to address %s:%d\n", server_ip,
+		ntohs(server_sin.sin_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
@@ -329,14 +328,14 @@ int do_server(void)
 
 	inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
 		  sizeof(buffer));
-	printf("Waiting or connection on %s:%d\n", buffer,
-	       ntohs(server_sin.sin_port));
+	fprintf(stderr, "Waiting or connection on %s:%d\n", buffer,
+		ntohs(server_sin.sin_port));
 	client_fd = accept(socket_fd, &client_addr, &client_addr_len);
 
 	inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
 		  sizeof(buffer));
-	printf("Got connection from %s:%d\n", buffer,
-	       ntohs(client_addr.sin_port));
+	fprintf(stderr, "Got connection from %s:%d\n", buffer,
+		ntohs(client_addr.sin_port));
 
 	while (1) {
 		struct iovec iov = { .iov_base = iobuf,
@@ -349,14 +348,13 @@ int do_server(void)
 		ssize_t ret;
 
 		is_devmem = false;
-		printf("\n\n");
 
 		msg.msg_iov = &iov;
 		msg.msg_iovlen = 1;
 		msg.msg_control = ctrl_data;
 		msg.msg_controllen = sizeof(ctrl_data);
 		ret = recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
-		printf("recvmsg ret=%ld\n", ret);
+		fprintf(stderr, "recvmsg ret=%ld\n", ret);
 		if (ret < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
 			continue;
 		if (ret < 0) {
@@ -364,7 +362,7 @@ int do_server(void)
 			continue;
 		}
 		if (ret == 0) {
-			printf("client exited\n");
+			fprintf(stderr, "client exited\n");
 			goto cleanup;
 		}
 
@@ -373,7 +371,7 @@ int do_server(void)
 			if (cm->cmsg_level != SOL_SOCKET ||
 			    (cm->cmsg_type != SCM_DEVMEM_DMABUF &&
 			     cm->cmsg_type != SCM_DEVMEM_LINEAR)) {
-				fprintf(stdout, "skipping non-devmem cmsg\n");
+				fprintf(stderr, "skipping non-devmem cmsg\n");
 				continue;
 			}
 
@@ -384,7 +382,7 @@ int do_server(void)
 				/* TODO: process data copied from skb's linear
 				 * buffer.
 				 */
-				fprintf(stdout,
+				fprintf(stderr,
 					"SCM_DEVMEM_LINEAR. dmabuf_cmsg->frag_size=%u\n",
 					dmabuf_cmsg->frag_size);
 
@@ -395,12 +393,13 @@ int do_server(void)
 			token.token_count = 1;
 
 			total_received += dmabuf_cmsg->frag_size;
-			printf("received frag_page=%llu, in_page_offset=%llu, frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu, dmabuf_id=%u\n",
-			       dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
-			       dmabuf_cmsg->frag_offset % getpagesize(),
-			       dmabuf_cmsg->frag_offset, dmabuf_cmsg->frag_size,
-			       dmabuf_cmsg->frag_token, total_received,
-			       dmabuf_cmsg->dmabuf_id);
+			fprintf(stderr,
+				"received frag_page=%llu, in_page_offset=%llu, frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu, dmabuf_id=%u\n",
+				dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
+				dmabuf_cmsg->frag_offset % getpagesize(),
+				dmabuf_cmsg->frag_offset,
+				dmabuf_cmsg->frag_size, dmabuf_cmsg->frag_token,
+				total_received, dmabuf_cmsg->dmabuf_id);
 
 			if (dmabuf_cmsg->dmabuf_id != dmabuf_id)
 				error(1, 0,
@@ -438,15 +437,15 @@ int do_server(void)
 		if (!is_devmem)
 			error(1, 0, "flow steering error\n");
 
-		printf("total_received=%lu\n", total_received);
+		fprintf(stderr, "total_received=%lu\n", total_received);
 	}
 
-	fprintf(stdout, "%s: ok\n", TEST_PREFIX);
+	fprintf(stderr, "%s: ok\n", TEST_PREFIX);
 
-	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
 		page_aligned_frags, non_page_aligned_frags);
 
-	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
 		page_aligned_frags, non_page_aligned_frags);
 
 cleanup:
@@ -551,7 +550,7 @@ int main(int argc, char *argv[])
 			ifname = optarg;
 			break;
 		case '?':
-			printf("unknown option: %c\n", optopt);
+			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;
 		}
 	}
@@ -559,7 +558,7 @@ int main(int argc, char *argv[])
 	ifindex = if_nametoindex(ifname);
 
 	for (; optind < argc; optind++)
-		printf("extra arguments: %s\n", argv[optind]);
+		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
 	run_devmem_tests();
 
-- 
2.47.0


