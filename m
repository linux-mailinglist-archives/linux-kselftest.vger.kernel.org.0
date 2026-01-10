Return-Path: <linux-kselftest+bounces-48662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA98D0CD43
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 03:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C22A330BEA56
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 02:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5162424E4C3;
	Sat, 10 Jan 2026 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbSdeyIe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF051269B1C
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011559; cv=none; b=cbSZrZS/axYIkgge6zsJuDRvVQWbrpVR3p7QZb0A0YLx3w85ZRp5D82JfSxrCsE0ej1fRBNgpCH9MpuYUz81KJPk4rkWZnN8deBxGQ0FH11fr9wOcDgUs7EweokvPJEvmxstBgfeNbmZDfzOJqYFJwF5yrxq9o5+GmN4yptCZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011559; c=relaxed/simple;
	bh=dy8VSMAomXo21WIjaY0wYi9sSGnjr0Ji79ClfNkKMS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0rZLROdAxVP5HpVKAsYPFBlyeslCFgV1Cd/n+cIC/ZlG0m3s4l7mSPXlc7sQHsD+tu1/p206yapCQIc3feIAQ5j3eSpdH5CONVlT7Pi1inkrQO2WKCNZiJY/pmO/d8Acr74iu2hqxLcEcS1rq4IoCq4B6GeZAtrw8TrYgqgyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbSdeyIe; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-644715aad1aso4486376d50.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 18:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768011545; x=1768616345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU6cZCgpG9GOAbb+tnZ37tmEGId4jQzirW7dllLFVzU=;
        b=dbSdeyIeAwAgxNNYNEDkqR8EXlFXsTZ9CREiQJKB5PWtVkDsYqfNVmR7Wb7r0mggPt
         0+25HsBymcm0EslWSBUCUm0a3syuNkPm19jvll/ptLCtYwDrAMabAg1hZuspSaDBY6WE
         TuDZ6o/VO+MjX5oFJg38+IqCnsYrzmPc31Mwvf5UpiLGzkr4fDNq5TYXRITjR6PRaV6J
         FRnhqUQ7zK4e0aqQpF/Vc7rqfsSvl12OqYwxdAsiDsr2igDtBGTPDi0Zhja7Zug61Xep
         //mg63YrPzT/sLp81eG7aRzq4eiOOqkfXqGfDHNY1loZWvcgX+lOMslJE5Mpl8dEWCc1
         4gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768011545; x=1768616345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rU6cZCgpG9GOAbb+tnZ37tmEGId4jQzirW7dllLFVzU=;
        b=Pq1kwSUcKWjDmyCj2aSLYJ1nFyVVt+muFNT2v/PJeqQ+C+2xu27WOtTnbdnhx6r5dq
         izF3dO2gBiQwzC/V6bgDeqPU27Hd7HTe5V55xAUukiftFUZ5gHBSl/NOtCg2ex5yNUg9
         FV5zk9qKZyem3yncIRoREPWiLaAIdNx9eeLQjOY7aRDZkmfyNd49UvADSQjWZ5TABtls
         T4Ie8jb3NLttBZN/r69MHJV2VbMvzC1SWowv3fA+uts/6MPimhQny8ran1deHoL9M33D
         eTkH7YlgtPe3mgyWMWI+rAXOIw+A+R9byCmbciNe4C7WR/Wln4/vYlVcR5qJ9Xx0SRzB
         Qtww==
X-Forwarded-Encrypted: i=1; AJvYcCVkJtDlZwqb3kM1uejv05w9wRtsrA2E5kJt1+1n3tK98F/sYwBiNAgNI0PdfksgLLtW0ikCKTPskP8xL8NLulg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7XX5BE1edJA+5yLe1V3bwerjRuQXXQzOZxPoNzmwVwHAaAyW/
	1hxF1kJ94TUnpX876Px06rEGoPNjOQQeEE7YgdxrZl6xknYEuRg9wZxb
X-Gm-Gg: AY/fxX5nUNplSCMMfACDkDzgezMDxqrdSzw7QfnoDliWav03wYV07V3pD01bvfQ5bZO
	ZbDObhgPD+/v2kXk51V/WufosfCh6gvyIMGHldOqV60EgqgeFwj3r6RXPYpkGkmf1rW6enXIiMV
	5vJncH3Fy+Wp95gOGlmafHUCk9MC7ektVmcFQw4M8lCDvrFNpLljd9njseirV+cyTm6sHxzFDEW
	1y/nMICp/yKH88jWaxyGwGwvPKSpi9cl3OsbhJEm1ZkrOX2oN01yPxrdFVMVukQYBrYGX4Gq3UY
	M1v147CB0C5wqQEYqrKfdyEG4xuwg2C5gtyD99TTarVY1ATk+xXg6LxypojWkDYxGg4V4vAC3as
	28Plh07xWRepRP06N+0rCfBaz/TtRe1P7/4p/3NBG7DNH/yXh/zhfdgS79Emj0COckR/bTbyPyP
	VitGs+DkOe
X-Google-Smtp-Source: AGHT+IFqAUeGS3fSoQYRClaCLLvuhBszFYipmE9EIxwk8GX5j0l3xuZmsLsWYJV8IBz3HNxIn50cwg==
X-Received: by 2002:a05:690e:b85:b0:641:f5bc:692e with SMTP id 956f58d0204a3-6470d2f4d8emr10686850d50.39.1768011544827;
        Fri, 09 Jan 2026 18:19:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa67999fsm47779197b3.37.2026.01.09.18.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:19:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 09 Jan 2026 18:18:19 -0800
Subject: [PATCH net-next v9 5/5] selftests: drv-net: devmem: add
 autorelease test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-5-8042930d00d7@meta.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
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

Add test case for autorelease.

The test case is the same as the RX test, but enables autorelease.  The
original RX test is changed to use the -a 0 flag to disable autorelease.

TAP version 13
1..4
ok 1 devmem.check_rx
ok 2 devmem.check_rx_autorelease
ok 3 devmem.check_tx
ok 4 devmem.check_tx_chunks

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v8:
- removed stale/missing tests

Changes in v7:
- use autorelease netlink
- remove sockopt tests
---
 tools/testing/selftests/drivers/net/hw/devmem.py  | 21 +++++++++++++++++++--
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 19 +++++++++++++------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 45c2d49d55b6..dbe696a445bd 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -25,7 +25,24 @@ def check_rx(cfg) -> None:
 
     port = rand_port()
     socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
-    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7 -a 0"
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
+    require_devmem(cfg)
+
+    port = rand_port()
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} \
+                  -c {cfg.remote_addr} -v 7 -a 1"
 
     with bkg(listen_cmd, exit_wait=True) as ncdevmem:
         wait_port_listen(port)
@@ -68,7 +85,7 @@ def main() -> None:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
-        ksft_run([check_rx, check_tx, check_tx_chunks],
+        ksft_run([check_rx, check_rx_autorelease, check_tx, check_tx_chunks],
                  args=(cfg, ))
     ksft_exit()
 
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 3288ed04ce08..406f1771d9ec 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -92,6 +92,7 @@ static char *port;
 static size_t do_validation;
 static int start_queue = -1;
 static int num_queues = -1;
+static int devmem_autorelease;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -679,7 +680,8 @@ static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 			 struct netdev_queue_id *queues,
-			 unsigned int n_queue_index, struct ynl_sock **ys)
+			 unsigned int n_queue_index, struct ynl_sock **ys,
+			 int autorelease)
 {
 	struct netdev_bind_rx_req *req = NULL;
 	struct netdev_bind_rx_rsp *rsp = NULL;
@@ -695,6 +697,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	req = netdev_bind_rx_req_alloc();
 	netdev_bind_rx_req_set_ifindex(req, ifindex);
 	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
+	netdev_bind_rx_req_set_autorelease(req, autorelease);
 	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
 
 	rsp = netdev_bind_rx(*ys, req);
@@ -872,7 +875,8 @@ static int do_server(struct memory_buffer *mem)
 		goto err_reset_rss;
 	}
 
-	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys)) {
+	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys,
+			  devmem_autorelease)) {
 		pr_err("Failed to bind");
 		goto err_reset_flow_steering;
 	}
@@ -1092,7 +1096,7 @@ int run_devmem_tests(void)
 		goto err_reset_headersplit;
 	}
 
-	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys, 0)) {
 		pr_err("Binding empty queues array should have failed");
 		goto err_unbind;
 	}
@@ -1108,7 +1112,7 @@ int run_devmem_tests(void)
 		goto err_reset_headersplit;
 	}
 
-	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
+	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys, 0)) {
 		pr_err("Configure dmabuf with header split off should have failed");
 		goto err_unbind;
 	}
@@ -1124,7 +1128,7 @@ int run_devmem_tests(void)
 		goto err_reset_headersplit;
 	}
 
-	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
+	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys, 0)) {
 		pr_err("Failed to bind");
 		goto err_reset_headersplit;
 	}
@@ -1397,7 +1401,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:")) != -1) {
+	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:z:a:")) != -1) {
 		switch (opt) {
 		case 'l':
 			is_server = 1;
@@ -1426,6 +1430,9 @@ int main(int argc, char *argv[])
 		case 'z':
 			max_chunk = atoi(optarg);
 			break;
+		case 'a':
+			devmem_autorelease = atoi(optarg);
+			break;
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.47.3


