Return-Path: <linux-kselftest+bounces-46059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0778DC72056
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 04:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5DAE32EC0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22EB309F1D;
	Thu, 20 Nov 2025 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c50ijRWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525330274C
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 03:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609839; cv=none; b=mXtfWvTjo9Zl+17DPcGiwSYVoTV4rh7ovSLuK9M8+JxsZz7WjjBRLs4P/hR18/6UJRDrfQNR/NRwymwk+uXfWSpVDbk18/Qs5IthiP2Dxuq+km9uuJjtAWqdB7R+GMkghEL91YADmmUxc7ep52ju2XBwWjjTra+Hxpb8hr34EH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609839; c=relaxed/simple;
	bh=o+TnvX8H67E39YgV1VzM4yPneveTtrGVWnzs7PTFEyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ns4D/AAmyxJ5NJm865gKVLDtHM4a6jnm1HZU7CNhjBR/jAcVogfnB3VOrLTBHTBNKF2aWBL5sORstUCLi6a7Cv/RNELunlRbx0OG6DFa/v8ZBnyO5zMpIdz3iVV9Ohgaa2s7ZXbcjpDDMqhYzcVG8xZGTDXbsrSJwH36itmtVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c50ijRWD; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-787f28f89faso4392207b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 19:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763609835; x=1764214635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dB9vGRQKOzD+0FIDq610kWqp5roY5Ews5Rp+LunXhtg=;
        b=c50ijRWDv6C4+bgjDgEntLElA/090B2lBIWQ/umM7rjkKgvMUfVLaWczs2DEj2Rbyx
         I2Mgxaiors/DmJAgoAkki5Yp8iYo6qaNIfe18qbZFMlNXnyel4IyEggprq4KIhCUYFh9
         Bm+3PjfIENhOZTyXldLtte3+qD4dvFuMMCUGwm1rMUeiij76QlSqlEiCCnnZF7kJ5BZe
         4iUe9LHarqM1jVzlwwYg4D8J61TCwd26KZejYV0GYmvc1qplkVnBMWVAlC/3VQ6aEcqF
         gyMUwQxdOyvxUG+CcLNJhg297RkK9mcREkxV+nLAF8yQJDS0JslUe6HU4TOWOl27kwIR
         uJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609835; x=1764214635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dB9vGRQKOzD+0FIDq610kWqp5roY5Ews5Rp+LunXhtg=;
        b=VL5mtW89wDncOF0dWl3NuRSa7gkV17MpOYHEIPXfjc/N3cHU+kz8jot0Xhw3r6vhHM
         5JSeTIIFDJLVvy4BtjccH/OVZ+yia5vzpkyXqEYfdcHDubfJZJ71XRUOtPFBZZ4W4Piu
         oJzWZ/0lBb885jyrtMc80O+pkAfjIWTpKWglxuEDls5oZ1o/QwdiFAME+UfMGRo/epAM
         sLOx3kasAZwetC7wFUJbdWFb63r4M6v0askIWxkeFB8ERZkiR1L/RAQZZHuLvJpBW+NR
         keBJhJFWmWQY0mOltnznaeC4SwsXy2vLRToe/2jbs9YqRgPEqM8yKTrhzLXe5ecv1pew
         kPvA==
X-Forwarded-Encrypted: i=1; AJvYcCUaGtchfXu1XsrFyBJ7w2ROO1T5ilREW1+JYIj1GUDOsKUh4MAF5cdTJBVZovo8eYMUx03rIeikQqn3wpAjo6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoK6juWCEbnGlXJT4YU8NKASwVdykdP9Q6BXvAOyp9pdbu0qSQ
	GBrxm99Fgsa9t5BZGrYt1goiWcehFvFbK9KMhOxaiCalRC7ablG5qPnz
X-Gm-Gg: ASbGnct5smt/diz6A9mkuvB+hlZR84cQ8G9NKIKR99UKg/Mwiug6ja6SmFux/+XwDIf
	qTkL10gQkwAonONtC/yCynQruSshhdA4SpZS/uEmguBBzqWrVSj3pXzlMtXIRpAX9kbNpgcyL1i
	jrqRYbfxZT3VDxy2P7h7XNRymeKZBEF2+s+NyAHPucN1wiyvtoxTCddhWxcGC6vgaQs4IhmQXX4
	oqi/IwUCFZsFczfru+JMHiJoyygyRortXhawQqdksZerOUujWsZ4JxGOZrFt+6wA4FS/TP5z7o6
	Lley8uv+Wltvd0ETnrOPDTNnBOmkrdBzmWlN7uDJZtZvRvxpeRZWrjOMTeZMaf6FXpplzVnEXEe
	dsEeGx6bPISd3ftuRSZa9oTiQPzYM4zGNUiUgLsgmvOn+vdheSE+uB66ID5TC5XIbpEQd5VMllV
	9TUYu7kDbJM3EHv9zgs2DDlg==
X-Google-Smtp-Source: AGHT+IH+ZvCrkl3kFqXJlHEtVfU0bYPG0c0dzdNLXfeCYjxXFUTZZPthcByghfwOu6Wk5tCc8cKAKg==
X-Received: by 2002:a05:690e:12cb:b0:63f:a324:bbf3 with SMTP id 956f58d0204a3-642f79d694dmr1177865d50.42.1763609835427;
        Wed, 19 Nov 2025 19:37:15 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:52::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-642f718bbbesm456461d50.21.2025.11.19.19.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:37:15 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 19 Nov 2025 19:37:12 -0800
Subject: [PATCH net-next v7 5/5] selftests: drv-net: devmem: add
 autorelease tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-5-1abc8467354c@meta.com>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests cases that check the autorelease modes (on and off).  The new
tests are the same as the old ones, but just pass a flag to ncdevmem to
select the autorelease mode.

Only for RX tests is autorelease checked, as the autorelease ncdevmem
flag is unused in the TX case and doesn't apply to TX bind operations.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Note: I tested successfully with kperf, but I'm troubleshooting
some mlx5 issues with ncdevmem so this patch, though simple, is not
fully validated. Will respond to this thread when solve the issue.

Changes in v7:
- use autorelease netlink
- remove sockopt tests
---
 tools/testing/selftests/drivers/net/hw/devmem.py  | 22 ++++++++++++++++++++--
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 19 +++++++++++++------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 45c2d49d55b6..dddb9d77cb28 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -25,7 +25,23 @@ def check_rx(cfg) -> None:
 
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
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7 -a 1"
 
     with bkg(listen_cmd, exit_wait=True) as ncdevmem:
         wait_port_listen(port)
@@ -68,7 +84,9 @@ def main() -> None:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
-        ksft_run([check_rx, check_tx, check_tx_chunks],
+        ksft_run([check_rx, check_rx_autorelease,
+                  check_tx, check_tx_autorelease,
+                  check_tx_chunks, check_tx_chunks_autorelease],
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


