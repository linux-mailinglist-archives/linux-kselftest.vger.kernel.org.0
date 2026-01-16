Return-Path: <linux-kselftest+bounces-49091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA44D2BB9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 06:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E06503010BEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 05:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2334A791;
	Fri, 16 Jan 2026 05:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTL83YtJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C2346ACF
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539809; cv=none; b=sdmEGKkOocttmLmwrWnswaQBGSoRAFkGDx4lxGmC1oOoLYPE+L770xvU/M4sMFo8Dhsd5QU3tbdLSStUgFA1Djq/uFgHGZQfub7rt9JPXXKrmiHcPG5IXIIp4LpfTS18PdYaqlqq4C2Le7uBM5FHWQ+dMTl7VfFyyKnWE5/oXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539809; c=relaxed/simple;
	bh=c/RMTvI113l1hFS34MtbsQYRQNKpL3Sqqwbb3gjFmTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohdaNB44qTa4z/k8INlmJBnEp2mPa9RIPy2YpSCKWdPq7Ga5a+uiHkvfuHwTRRpX45uu2pDOkpa+awonKjcZsjc6CfzrHCJV7GcT8wnHhe31C2KkYR9XrHrM2kSorVGXV2CHkEPmPksbzQojTQeuSJMYBw3MRn70zZUpTo6MWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTL83YtJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78e6dc6d6d7so17448067b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 21:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768539802; x=1769144602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXwkpjnmiMoU36VnzxxQMbXTyAXIjsqE2khAXdKokBU=;
        b=UTL83YtJyPRozeJPQ+zbZaBeLx3mxtEB4NGFV6y2JBimPyOlfLCWsiQvagcAjrNGhi
         fZbsqqFiMw/ZsH+13Ddy+ExcpUHuyNC4zJKYzWjl24O+ylRX86U3b88R5KuD5Jy5OGcB
         m2TXk8iL0FSjuKCK3dYmdXoORI/n6IGtSCTv6EpcCCrcqDTfwX/BBkFY1D3Iu754HsAu
         IJan2+ZG04vDtgDyZJP/OMZCg6Olkjr99r4K/IeroOsQcjFiHauIHcqrPK1w3BNx8NOO
         90T+p3C+JzGkmzSozcLm+/2AIEPV7AV1u+CM2Bi7l/tYoN8VTbOIAJ9UZzD+jQjf9Olw
         nVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768539802; x=1769144602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kXwkpjnmiMoU36VnzxxQMbXTyAXIjsqE2khAXdKokBU=;
        b=gR2A03IeMA/rDFGDPhe9irOjyYriqGFzPneYWFfttSdJjbKtk05I2VOYryIK/o0xPN
         p/mASJK5I61ont47tOj9EnPZvYYLhsGZd5WgUW+3B+a6UvnT8h2y4SCgbMvKx5ybw/i+
         ejoIK5FpZaEv+eU4odLuXZp3/2a7RC3OEAYUHAOWGPZr3C6SbkEpNmFVqX+KwkfGIk/n
         Ya2Tib/VeZsI8yUwaSMAsQpSC6klnSTjasga4IaYzsYvkiUHzFiESw6d4/9I4Rsn4Ucn
         c6rk3+EboiclWce5milXctWlZ0aGGv5w8aZtm9J8F3BKLJwuZZtJ5FokMw/Dw3TjwKRt
         iz/w==
X-Forwarded-Encrypted: i=1; AJvYcCWrDHNZPIOcyH68uf3s8oNjbV1lkkoezFER2dnC41oatNpsbxhBtOh09wzs0dEqgx2jnq0tFzZvhKwuKybBPRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPskHykb8ub/QD+uQFJaM6Tfiks5ShQq8px4Eh8VatcaWzrwac
	gYEvFfDowsDvgdUSZkVlouhhAMUI9SDCEdZrVP7fs7gXq9nHruXtx7/m
X-Gm-Gg: AY/fxX5DXXW+cw8tm2+jac+VBFHNmkgFr6ZzPo9Nao3GtT/1w84ulk9/xfHjeor/3O2
	skqIfaF1FviJItiPDHhyaXvMHdR3bfmixWnHzbGBnzCfMltn9gQV0OTaFeNEwr7xI/r3kJpHb2/
	4dJgNoRkD8ekgcVxFJ+VHqLOOLAd6TK7l4VwNnLr/ie9OfUEnbedBIGRV43uVeiaZhFQq3Yfuqm
	NyqG2Lo/Jnjzqa7JLwB6IjGXUsbQ2L3nyV4BNmum6eoRR92yYRk6KlWHXDahqE8tQqXhFHOauU4
	1YY2TP5Cg+5mZjtFaoUnso00y8mki8gnCEX9PbRpnyiesQiFlJR9W0D9JLllnUoHeQfRjvPMygr
	0Yhpa5swdCR2WYPM6GLvDNldNXrWUAZzPfHX/Lz7MTWRvIKiMvFW2JAAK9Wxn1ccW8UEQHVFglE
	UfD1sj8a+EpA==
X-Received: by 2002:a05:690c:c8c:b0:786:4fd5:e5c8 with SMTP id 00721157ae682-793c684d825mr12843487b3.57.1768539801685;
        Thu, 15 Jan 2026 21:03:21 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c8069sm5512017b3.6.2026.01.15.21.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 21:03:21 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 15 Jan 2026 21:02:16 -0800
Subject: [PATCH net-next v10 5/5] selftests: drv-net: devmem: add
 autorelease tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-5-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add test cases for autorelease and new edge cases.

A happy path check_rx / check_rx_autorelease test is added.

The test check_unbind_before_recv/_autorelease tests that after a connection
is accepted, but before recv is called, that unbind behaves correctly.

The test check_unbind_after_recv/_autorelease tests that after a connection
is accepted, but after recv is called, that unbind behaves correctly.

To facilitate the unbind tests, ncdevmem is changed to take an "unbind" mode.

The unbind modes are defined as the following:

UNBIND_MODE_NORMAL: unbind after done with normal traffic

UNBIND_MODE_BEFORE_RECV: Unbind before any recvmsg. The socket hasn't
become a user yet, so binding->users reaches zero and recvmsg should
fail with ENODEV. This validates that sockets can't access devmem after
the binding is torn down.

UNBIND_MODE_AFTER_RECV: Do one recvmsg first (socket becomes a user),
then unbind, then continue receiving. This validates that binding->users
keeps the binding alive for sockets that already acquired a reference
via recvmsg.

ncdevmem is also changed to take an autorelease flag for toggling the
autorelease mode.

TAP version 13
1..8
ok 1 devmem.check_rx
ok 2 devmem.check_rx_autorelease
ok 3 devmem.check_unbind_before_recv
ok 4 devmem.check_unbind_before_recv_autorelease
ok 5 devmem.check_unbind_after_recv
ok 6 devmem.check_unbind_after_recv_autorelease
ok 7 devmem.check_tx
ok 8 devmem.check_tx_chunks

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v10:
- add tests for "unbind before/after recv" edge cases

Changes in v8:
- removed stale/missing tests

Changes in v7:
- use autorelease netlink
- remove sockopt tests
---
 tools/testing/selftests/drivers/net/hw/devmem.py  | 98 ++++++++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 68 ++++++++++++++--
 2 files changed, 157 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 45c2d49d55b6..0bbfdf19e23d 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -25,7 +25,98 @@ def check_rx(cfg) -> None:
 
     port = rand_port()
     socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
-    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} \
+                  -c {cfg.remote_addr} -v 7 -a 0"
+
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+        wait_port_listen(port)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem.ret, 0)
+
+
+@ksft_disruptive
+def check_rx_autorelease(cfg) -> None:
+    """Test devmem TCP receive with autorelease mode enabled."""
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} \
+                  -c {cfg.remote_addr} -v 7 -a 1"
+
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+        wait_port_listen(port)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem.ret, 0)
+
+
+@ksft_disruptive
+def check_unbind_before_recv(cfg) -> None:
+    """Test dmabuf unbind before socket recv with autorelease disabled."""
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} \
+                  -c {cfg.remote_addr} -v 7 -a 0 -U 1"
+
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+        wait_port_listen(port)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem.ret, 0)
+
+
+@ksft_disruptive
+def check_unbind_before_recv_autorelease(cfg) -> None:
+    """Test dmabuf unbind before socket recv with autorelease enabled."""
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} \
+                  -c {cfg.remote_addr} -v 7 -a 1 -U 1"
+
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+        wait_port_listen(port)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem.ret, 0)
+
+
+@ksft_disruptive
+def check_unbind_after_recv(cfg) -> None:
+    """Test dmabuf unbind after socket recv with autorelease disabled."""
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} \
+                  -c {cfg.remote_addr} -v 7 -a 0 -U 2"
+
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
+        wait_port_listen(port)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem.ret, 0)
+
+
+@ksft_disruptive
+def check_unbind_after_recv_autorelease(cfg) -> None:
+    """Test dmabuf unbind after socket recv with autorelease enabled."""
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} \
+                  -c {cfg.remote_addr} -v 7 -a 1 -U 2"
 
     with bkg(listen_cmd, exit_wait=True) as ncdevmem:
         wait_port_listen(port)
@@ -68,7 +159,10 @@ def main() -> None:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
-        ksft_run([check_rx, check_tx, check_tx_chunks],
+        ksft_run([check_rx, check_rx_autorelease,
+                  check_unbind_before_recv, check_unbind_before_recv_autorelease,
+                  check_unbind_after_recv, check_unbind_after_recv_autorelease,
+                  check_tx, check_tx_chunks],
                  args=(cfg, ))
     ksft_exit()
 
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 3288ed04ce08..5cbff3c602b2 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -85,6 +85,13 @@
 
 #define MAX_IOV 1024
 
+enum unbind_mode_type {
+	UNBIND_MODE_NORMAL,
+	UNBIND_MODE_BEFORE_RECV,
+	UNBIND_MODE_AFTER_RECV,
+	UNBIND_MODE_INVAL,
+};
+
 static size_t max_chunk;
 static char *server_ip;
 static char *client_ip;
@@ -92,6 +99,8 @@ static char *port;
 static size_t do_validation;
 static int start_queue = -1;
 static int num_queues = -1;
+static int devmem_autorelease;
+static enum unbind_mode_type unbind_mode;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -679,7 +688,8 @@ static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 			 struct netdev_queue_id *queues,
-			 unsigned int n_queue_index, struct ynl_sock **ys)
+			 unsigned int n_queue_index, struct ynl_sock **ys,
+			 int autorelease)
 {
 	struct netdev_bind_rx_req *req = NULL;
 	struct netdev_bind_rx_rsp *rsp = NULL;
@@ -695,6 +705,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	req = netdev_bind_rx_req_alloc();
 	netdev_bind_rx_req_set_ifindex(req, ifindex);
 	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
+	netdev_bind_rx_req_set_autorelease(req, autorelease);
 	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
 
 	rsp = netdev_bind_rx(*ys, req);
@@ -872,7 +883,8 @@ static int do_server(struct memory_buffer *mem)
 		goto err_reset_rss;
 	}
 
-	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys)) {
+	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys,
+			  devmem_autorelease)) {
 		pr_err("Failed to bind");
 		goto err_reset_flow_steering;
 	}
@@ -922,6 +934,23 @@ static int do_server(struct memory_buffer *mem)
 	fprintf(stderr, "Got connection from %s:%d\n", buffer,
 		ntohs(client_addr.sin6_port));
 
+	if (unbind_mode == UNBIND_MODE_BEFORE_RECV) {
+		struct pollfd pfd = {
+			.fd = client_fd,
+			.events = POLLIN,
+		};
+
+		/* Wait for data then unbind (before recvmsg) */
+		ret = poll(&pfd, 1, 5000);
+		if (ret <= 0) {
+			pr_err("poll failed or timed out waiting for data");
+			goto err_close_client;
+		}
+
+		ynl_sock_destroy(ys);
+		ys = NULL;
+	}
+
 	while (1) {
 		struct iovec iov = { .iov_base = iobuf,
 				     .iov_len = sizeof(iobuf) };
@@ -942,11 +971,19 @@ static int do_server(struct memory_buffer *mem)
 		if (ret < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
 			continue;
 		if (ret < 0) {
+			if (unbind_mode == UNBIND_MODE_BEFORE_RECV &&
+			    errno == ENODEV)
+				goto cleanup;
+
 			perror("recvmsg");
 			if (errno == EFAULT) {
 				pr_err("received EFAULT, won't recover");
 				goto err_close_client;
 			}
+			if (errno == ENODEV) {
+				pr_err("unexpected ENODEV");
+				goto err_close_client;
+			}
 			continue;
 		}
 		if (ret == 0) {
@@ -1025,6 +1062,11 @@ static int do_server(struct memory_buffer *mem)
 			goto err_close_client;
 		}
 
+		if (unbind_mode == UNBIND_MODE_AFTER_RECV && ys) {
+			ynl_sock_destroy(ys);
+			ys = NULL;
+		}
+
 		fprintf(stderr, "total_received=%lu\n", total_received);
 	}
 
@@ -1043,7 +1085,8 @@ static int do_server(struct memory_buffer *mem)
 err_free_tmp:
 	free(tmp_mem);
 err_unbind:
-	ynl_sock_destroy(ys);
+	if (ys)
+		ynl_sock_destroy(ys);
 err_reset_flow_steering:
 	reset_flow_steering();
 err_reset_rss:
@@ -1092,7 +1135,7 @@ int run_devmem_tests(void)
 		goto err_reset_headersplit;
 	}
 
-	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys, 0)) {
 		pr_err("Binding empty queues array should have failed");
 		goto err_unbind;
 	}
@@ -1108,7 +1151,7 @@ int run_devmem_tests(void)
 		goto err_reset_headersplit;
 	}
 
-	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys, 0)) {
 		pr_err("Configure dmabuf with header split off should have failed");
 		goto err_unbind;
 	}
@@ -1124,7 +1167,7 @@ int run_devmem_tests(void)
 		goto err_reset_headersplit;
 	}
 
-	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
+	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys, 0)) {
 		pr_err("Failed to bind");
 		goto err_reset_headersplit;
 	}
@@ -1397,7 +1440,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:")) != -1) {
+	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:a:U:")) != -1) {
 		switch (opt) {
 		case 'l':
 			is_server = 1;
@@ -1426,6 +1469,12 @@ int main(int argc, char *argv[])
 		case 'z':
 			max_chunk = atoi(optarg);
 			break;
+		case 'a':
+			devmem_autorelease = atoi(optarg);
+			break;
+		case 'U':
+			unbind_mode = atoi(optarg);
+			break;
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;
@@ -1437,6 +1486,11 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	if (unbind_mode >= UNBIND_MODE_INVAL) {
+		pr_err("invalid unbind mode %u\n", unbind_mode);
+		return 1;
+	}
+
 	ifindex = if_nametoindex(ifname);
 
 	fprintf(stderr, "using ifindex=%u\n", ifindex);

-- 
2.47.3


