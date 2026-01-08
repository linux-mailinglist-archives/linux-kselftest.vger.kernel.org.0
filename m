Return-Path: <linux-kselftest+bounces-48453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C4D00870
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 02:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F1AB3045380
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 00:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197BD2253B0;
	Thu,  8 Jan 2026 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyTuC3E4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123221254B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833928; cv=none; b=WcP98lZ33/ZnwimLhhCa12zowyO6adJUsjNT13GP+YnyjYoGnQI+Ubll8C8AkxkP7SH4WJd0jqBvJCtK2vpuoLApjqZhcGx0lhBHGi4A1pDC83wkr+8MVJmVXsZIv4cU9UQrRHW5HjF/qxvq6Px4zt1DjlvlCtqonYDo32AlmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833928; c=relaxed/simple;
	bh=9zuoNqEVnt8pH9cLp3BgUGvaCFtzCDZEoS7OzsXWbGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYwYua7j57oYBiSZiA712PbZzogojMLDoH9+/cf0SB87RULtGN9Nu0jRv87mL3weKLcoIyDAcBOWTyT3p0H4m7RZNKjYHJ+d/TWlISGCZUD8MqoFa42A/29kCxuaFNpftS2joVlwiEtZCbBOM02FT4VAVb/BnfJJyI7wKBys3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyTuC3E4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78e7ba9fc29so31265707b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 16:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767833923; x=1768438723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJperMXwTkIXRHW5+8MJDDWuaQbzVhWP/yMQKYVBdM8=;
        b=fyTuC3E4pezY9BYDbGJ1KJwuJzpO/0BJsMEn2b1waW5fV3U5gkWaQ9d8qluUr4S7yJ
         5YjoCto2c2c+p0SGQJZ4zTZZx7j+ShCnw5mBUrXFg9fbcrOd04vViPPZjVZajz+ZgCss
         tzQUi4nFVNhMbScvNgXlI7Y9iPCL0W7+z57FsDKzWCjPliNGT64dMBfqchGx7h/VfNQ+
         2awR3xKwEGP3jY2EFCOa180o6qD4F1Kof4BYn8AKw24vIDKCWPzQcCeAE8LYpJ6jbJgD
         /XVNguyt/7Yw4aIHoVeNInuF29U4sT7r07iqBswfm15aiSWTPKymT2PUjCTs/6Zf5Ryg
         GSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767833923; x=1768438723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJperMXwTkIXRHW5+8MJDDWuaQbzVhWP/yMQKYVBdM8=;
        b=W1e8MQBlyHk9/bRyjqbbW5vp/J5FtOpmkmntie764lVJyFL5oycV0rqhlmASk86B1F
         rLxZV2bAElJ72K8ClrgMA8SEryGA6QHHrmvre/hYbr0cWmaLBg3MizuUrMxGtWkpE4c/
         uOUWzHfs0OrZJUp4i4SI0oZbLR5qjweCgiUT4+6nFA381cUelfN0LyVoPzt40KwknZX0
         BRd/36usr39VTMWTUOavrE8aBGcZEyIOy6Q38W785y7FC4St5xecz4762SA5EvuGEDZm
         jro2peiqfDBHzAdmcGkRPxpmi/2gdGy0IBe1zlfclKRYhoBNADFRqFIbrxouVb3c6zw1
         dloQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbIdupKd9uT5qrbawjRwAmErXcyWNvApUGuyyBy6y1LXLc1XscnUfKLvUQbTxEUoxdIwOju228XDdaQgZlLxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6cEwiLS1tBw+C3fuQnSRIMS31mHwParIZrs0ZdRa6GYByqBs
	7A9JxhqETXqN46tnX6p9UDm4H6MqMObRYVxBV+VhunRfXOb0k8own191
X-Gm-Gg: AY/fxX5NFeaNnzyiC0AivN5QLizon8FDgmdgY7xoNSKgBS4cks8QdbZWrEfeUyMeDaM
	iRAClxjWYbIp68gJKm/9mXRD8XYguTAbVnHms4mcDmmArqTfKZDNtD+8bjvGV6UbEIv4C27G1b+
	m8DBoWVAEhOhMncc7GcI4TZLz+yRn9fFgvgLmATCRo7wFn8ZJZahLmNl96YptFREjjQ8kc0DyWB
	sBWr1S2GDAdS0JDoOjopzh6x+LprdgjpEYAWVJxFivgz6ZQgeTxZno3ggVTW5m7pL0mv/vT22e1
	aYuXlszY8uXp52NQL2k2m98mYYvENJ1+ANu5KdzRr/X0yPh5Hr/MCpZp9vC2ryQMsYEguSH9oaq
	DhIRxdeMa6+DfIaJhraDeCsqm2X0azlCNJzEXMgp1FZao3SCWmRQfC9zbGH4vBmfjncgbD/wKCx
	6g+Du09v9/OPA4EQLj9BOT
X-Google-Smtp-Source: AGHT+IH/YnHPsvQ1x53oyPoX/9tw6AKgXdHarFn5R1WyPsLd/nAJHMzuOnxNXLvoQ3gkbQA3OMlgNg==
X-Received: by 2002:a05:690c:630a:b0:78c:65e7:d226 with SMTP id 00721157ae682-790b567cda7mr46405997b3.32.1767833923479;
        Wed, 07 Jan 2026 16:58:43 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa55c77bsm24532427b3.3.2026.01.07.16.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:58:43 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 07 Jan 2026 16:57:39 -0800
Subject: [PATCH net-next v8 5/5] selftests: drv-net: devmem: add
 autorelease test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-5-92c968631496@meta.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
In-Reply-To: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
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
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add test case for autorelease.

THe test case is the same as the RX test, but enables autorelease.  The
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


