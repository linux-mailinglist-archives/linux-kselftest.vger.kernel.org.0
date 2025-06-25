Return-Path: <linux-kselftest+bounces-35776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35739AE81CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E641F3A8396
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D59260577;
	Wed, 25 Jun 2025 11:40:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA18282E1;
	Wed, 25 Jun 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851606; cv=none; b=uX48NdYwgcNn/e+YSPgXl3Vg9O8lGLIyzdNOye6X4++xLkZOPSbxIckfmEFkrOPyUTR58FUNUhIHhrljGRmeA5xAKV5ilv0jmw6J2EUd56l52qPMAf1Sw3jEhcx8TigECSMKqXQOkzCiGYDjievTAPAWskLzZZvJDoEohss5JgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851606; c=relaxed/simple;
	bh=1V77keAYAKO6PhvNwWxLz4ndN9mg0VbwyJete+lTLnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhuOQKjqL8TmP/ihIxYf2LweT7JJHwK+euybLH18CHjvah5Q3qCfGatfUzyw03zMk0xkra4RsTVElL1Ho2o6KW301TjX406VEDQ9C2p3arLD5SPkwaoqPN3NAC+VAxqoq6O32Ml5DsA8CDRlsWc1fkCYudo80SyU1YsKjvKFC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so160096166b.3;
        Wed, 25 Jun 2025 04:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750851602; x=1751456402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVW00fFHOK2coUP4Gz0tDc16N3MRKLw8p2gbcpvVlgE=;
        b=Jta7b60AWaI6pfnH57bkLqf+ImrK2GZjgKjLQ1Fyc3YRuvYVpNmmn8/beIItEQv+d/
         omtQWHG55HxHsjwbdu81DfOhB00KhzygoEWecQB6O+l91fAqv21t2Xth1BJNPhV3mr2W
         qUZTzr+9Cq9estkRmPwN1HXZagpmu0DbKfJuwlEFijyqlVZOkPCCZyhMgHTkxCaRxMyY
         HFGFFd/G3kxKa5wqtI9NqYIMWA/jAuX4iiLHi+7czQKG0ssBJl53y0THl1YNpxdIfDgb
         UEQaVUoBwVMTCmGCSThqE7//ccZPc4wGtDBJQ1h/Tla34e0UkFvID6AN8wlpFbRDLR9i
         SWug==
X-Forwarded-Encrypted: i=1; AJvYcCWL9lR5QaYRh0f7rKc7pFb+gTmBJySLaWsaU0o9VdcNqU10XkPRs5OzEMlSLpmXV22iHaEBlndHJsNVR2JJyWJU@vger.kernel.org, AJvYcCX+vdopMZEtyUl8QDoyEmriV8esp0kmmihl6HAXcgLehXNXyg9L6chG5t3xAhJrsvjQasWF0Jbv@vger.kernel.org, AJvYcCX4RddUxvd11QVknpAdq+stYjd0lVvTk2nbtb634AI93d6pBMVV22KXFE/g/mb94jkdGNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdcC9GZ+tHk2BzzHmXxMy0X3P88LQYXWPjljBfSFh8UCImItg
	OVQ1tDQv54qV4C8VOCDAkJkE254DDtCd/60EQrrv229pwfqsinJqyXdS
X-Gm-Gg: ASbGncu1cbP0+dvHtR95Xf7PDrWMaMvX6VFvkXKSBI+BmteI6SwL8RWJOHhn6hnSQy7
	H8II7sDoTly/58P47MA+Z0J9KRbSCazkA2/Z6JMHlzWCizSaXtYRiYhQ8rGgAQHEE7NnufjDOh8
	OHs30qxT/Ve3JZL8gwS/hXXOSsOASoIFLQ1bJwx+f41wONqVBQPd9v6mJHor/ll4QqghD3Rn1o3
	EkEoOGyzqviRjt67V+NACXKjRrfWNMnTRqvkDkzZ8meURTaJZt1Bpu4XZFDaU3ViQXrG45Ei9q0
	9fIhxtQNaSwqWDagv6p3X/YvcJIz8loSkyW9PNFKqY9qzmfnpg3O
X-Google-Smtp-Source: AGHT+IFWeDT3WFcvAAUQ2yYtbpblEQUEljeqldWF+Glyck2/grkcGnp4zPYUorlpdUaDZe7lzpNtXQ==
X-Received: by 2002:a17:906:c14f:b0:ade:3bec:ea29 with SMTP id a640c23a62f3a-ae0be8942d4mr251406966b.25.1750851602212;
        Wed, 25 Jun 2025 04:40:02 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209349sm1036314866b.152.2025.06.25.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:40:01 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 25 Jun 2025 04:39:49 -0700
Subject: [PATCH net-next v2 4/4] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-netpoll_test-v2-4-47d27775222c@debian.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
In-Reply-To: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 gustavold@gmail.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=14021; i=leitao@debian.org;
 h=from:subject:message-id; bh=1V77keAYAKO6PhvNwWxLz4ndN9mg0VbwyJete+lTLnM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoW+AL6cjhhRMViKrBgizp0Kh0Xy/ViYLyqGc3D
 mrf/PlPvemJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFvgCwAKCRA1o5Of/Hh3
 bQ6jD/sFcz4/EAY3iJhC5jjZDeaaUfJMORjyaYrOrIbrugtBOomWE5YDN6vqLx2wSgdhDRcDnvG
 IZZ5qw7+7DgmT3QJiyOqj8TaneQgbiNY5qmQOux5ZIZA5x5Bfl3ipRpJ7FMSSa9YnyW1ryIVmgG
 sobwYGnZAMd+nu9/Smfh3XNBol23dsJJc7ux4qeFe0sHU+5lkQ1jX5IkGMMZdiAmGqSuKcb4P/9
 yOCPEcnICOOvYjp1tcoy41CDH3rmatXTs+fGzOue+i3r/L1WOX8qQ4ZK8QJiqz5YP8IplhhWnNn
 4BHU1YEp445nzDzr1AEq5VpHcgrIj0G4DYNF7x7NZ7KtdY5qdbI1RUIChC/czJUjq0deQE3Q/tq
 EMwGqVbsCSOC3MnwTlnIAmfdPaou4HjLZRubqosUiY3HJjkwHzgFCDRDJNlLWW16I5zR3ziFZrm
 guuXKUGqvecPs8OcGr27ZC/cjdpk8Mg0QwFJV+BjAUFt0FjiptjWokeyovqNQyr8Xlt2pf1kry9
 2J4UMr8jcUY6r8XAt66MdXYLLRrrqXE/+GXqzD5nEKGJBxgiPt59r7JZryMoslrr3M1/ClWt7M2
 jiuWChTrNV52x5tgGfk6GqvBCwCOxELWG+yvoZxTpMYYKK0cgajk+Pg6NlhFieyqCxByy6Zisy4
 DPLNI+3XS9SlWUw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a basic selftest for the netpoll polling mechanism, specifically
targeting the netpoll poll() side.

The test creates a scenario where network transmission is running at
maximum speed, and netpoll needs to poll the NIC. This is achieved by:

  1. Configuring a single RX/TX queue to create contention
  2. Generating background traffic to saturate the interface
  3. Sending netconsole messages to trigger netpoll polling
  4. Using dynamic netconsole targets via configfs
  5. Delete and create new netconsole targets after some messages
  6. Start a bpftrace in parallel to make sure netpoll_poll_dev() is
     called
  7. If bpftrace exists and netpoll_poll_dev() was called, stop.

The test validates a critical netpoll code path by monitoring traffic
flow and ensuring netpoll_poll_dev() is called when the normal TX path
is blocked.

This addresses a gap in netpoll test coverage for a path that is
tricky for the network stack.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/netpoll_basic.py | 344 +++++++++++++++++++++
 2 files changed, 345 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index bd309b2d39095..9bd84d6b542e5 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -16,6 +16,7 @@ TEST_PROGS := \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
+	netpoll_basic.py \
 	ping.py \
 	queues.py \
 	stats.py \
diff --git a/tools/testing/selftests/drivers/net/netpoll_basic.py b/tools/testing/selftests/drivers/net/netpoll_basic.py
new file mode 100755
index 0000000000000..dfb52d6793466
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
@@ -0,0 +1,344 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Author: Breno Leitao <leitao@debian.org>
+"""
+ This test aims to evaluate the netpoll polling mechanism (as in
+ netpoll_poll_dev()). It presents a complex scenario where the network
+ attempts to send a packet but fails, prompting it to poll the NIC from within
+ the netpoll TX side.
+
+ This has been a crucial path in netpoll that was previously untested. Jakub
+ suggested using a single RX/TX queue, pushing traffic to the NIC, and then
+ sending netpoll messages (via netconsole) to trigger the poll.
+
+ In parallel, bpftrace is used to detect if netpoll_poll_dev() was called. If
+ so, the test passes, otherwise it will be skipped. This test is very dependent on
+ the driver and environment, given we are trying to trigger a tricky scenario.
+"""
+
+import errno
+import logging
+import os
+import random
+import string
+import threading
+import time
+
+from lib.py import (
+    bpftrace,
+    ethtool,
+    GenerateTraffic,
+    ksft_exit,
+    ksft_pr,
+    ksft_run,
+    KsftFailEx,
+    KsftSkipEx,
+    NetdevFamily,
+    NetDrvEpEnv,
+)
+
+# Configure logging
+logging.basicConfig(
+    level=logging.INFO,
+    format="%(asctime)s - %(levelname)s - %(message)s",
+)
+
+NETCONSOLE_CONFIGFS_PATH: str = "/sys/kernel/config/netconsole"
+NETCONS_REMOTE_PORT: int = 6666
+NETCONS_LOCAL_PORT: int = 1514
+# Max number of netcons messages to send. Each iteration will setup
+# netconsole and send 10 messages
+ITERATIONS: int = 20
+# MAPS contains the information coming from bpftrace
+# it will have only one key: @hits, which tells the number of times
+# netpoll_poll_dev() was called
+MAPS: dict[str, int] = {}
+# Thread to run bpftrace in parallel
+BPF_THREAD: threading.Thread = None
+# Time bpftrace will be running in parallel.
+BPFTRACE_TIMEOUT: int = 15
+
+
+def ethtool_read_rx_tx_queue(interface_name: str) -> tuple[int, int]:
+    """
+    Read the number of RX and TX queues using ethtool. This will be used
+    to restore it after the test
+    """
+    try:
+        ethtool_result = ethtool(f"-g {interface_name}").stdout
+        for line in ethtool_result.splitlines():
+            if line.startswith("RX:"):
+                rx_queue = int(line.split()[1])
+            if line.startswith("TX:"):
+                tx_queue = int(line.split()[1])
+    except IndexError as exception:
+        raise KsftSkipEx(
+            f"Failed to read RX/TX queues numbers: {exception}. Not going to mess with them."
+        ) from exception
+
+    return rx_queue, tx_queue
+
+
+def ethtool_set_rx_tx_queue(interface_name: str, rx_val: int, tx_val: int) -> None:
+    """Set the number of RX and TX queues to 1 using ethtool"""
+    try:
+        # This don't need to be reverted, since interfaces will be deleted after test
+        ethtool(f"-G {interface_name} rx {rx_val} tx {tx_val}")
+    except Exception as exception:
+        raise KsftSkipEx(
+            f"Failed to configure RX/TX queues: {exception}. Ethtool not available?"
+        ) from exception
+
+
+def netcons_generate_random_target_name() -> str:
+    """Generate a random target name starting with 'netcons'"""
+    random_suffix = "".join(random.choices(string.ascii_lowercase + string.digits, k=8))
+    return f"netcons_{random_suffix}"
+
+
+def netcons_create_target(
+    config_data: dict[str, str],
+    target_name: str,
+) -> None:
+    """Create a netconsole dynamic target against the interfaces"""
+    logging.debug("Using netconsole name: %s", target_name)
+    try:
+        os.makedirs(f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}", exist_ok=True)
+        logging.debug(
+            "Created target directory: %s/%s", NETCONSOLE_CONFIGFS_PATH, target_name
+        )
+    except OSError as exception:
+        if exception.errno != errno.EEXIST:
+            raise KsftFailEx(
+                f"Failed to create netconsole target directory: {exception}"
+            ) from exception
+
+    try:
+        for key, value in config_data.items():
+            path = f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{key}"
+            logging.debug("Writing %s to %s", key, path)
+            with open(path, "w", encoding="utf-8") as file:
+                # Always convert to string to write to file
+                file.write(str(value))
+                file.close()
+
+        # Read all configuration values for debugging purposes
+        for debug_key in config_data.keys():
+            with open(
+                f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{debug_key}",
+                "r",
+                encoding="utf-8",
+            ) as file:
+                content = file.read()
+                logging.debug(
+                    "%s/%s/%s : %s",
+                    NETCONSOLE_CONFIGFS_PATH,
+                    target_name,
+                    debug_key,
+                    content,
+                )
+
+    except Exception as exception:
+        raise KsftFailEx(
+            f"Failed to configure netconsole target: {exception}"
+        ) from exception
+
+
+def netcons_configure_target(
+    cfg: NetDrvEpEnv, interface_name: str, target_name: str
+) -> None:
+    """Configure netconsole on the interface with the given target name"""
+    config_data = {
+        "extended": "1",
+        "dev_name": interface_name,
+        "local_port": NETCONS_LOCAL_PORT,
+        "remote_port": NETCONS_REMOTE_PORT,
+        "local_ip": cfg.addr_v["4"] if cfg.addr_ipver == "4" else cfg.addr_v["6"],
+        "remote_ip": (
+            cfg.remote_addr_v["4"] if cfg.addr_ipver == "4" else cfg.remote_addr_v["6"]
+        ),
+        "remote_mac": "00:00:00:00:00:00",  # Not important for this test
+        "enabled": "1",
+    }
+
+    netcons_create_target(config_data, target_name)
+    logging.debug(
+        "Created netconsole target: %s on interface %s", target_name, interface_name
+    )
+
+
+def netcons_delete_target(name: str) -> None:
+    """Delete a netconsole dynamic target"""
+    target_path = f"{NETCONSOLE_CONFIGFS_PATH}/{name}"
+    try:
+        if os.path.exists(target_path):
+            os.rmdir(target_path)
+    except OSError as exception:
+        raise KsftFailEx(
+            f"Failed to delete netconsole target: {exception}"
+        ) from exception
+
+
+def netcons_load_module() -> None:
+    """Try to load the netconsole module"""
+    os.system("modprobe netconsole")
+
+
+def bpftrace_call() -> None:
+    """Call bpftrace to find how many times netpoll_poll_dev() is called.
+    Output is saved in the global variable `maps`"""
+
+    # This is going to update the global variable, that will be seen by the
+    # main function
+    global MAPS  # pylint: disable=W0603
+
+    # This will be passed to bpftrace as in bpftrace -e "expr"
+    expr = "BEGIN{ @hits = 0;} kprobe:netpoll_poll_dev { @hits += 1; }"
+
+    MAPS = bpftrace(expr, timeout=BPFTRACE_TIMEOUT, json=True)
+    logging.debug("BPFtrace output: %s", MAPS)
+
+
+def bpftrace_start():
+    """Start a thread to call `call_bpf` in parallel for 2 seconds."""
+    global BPF_THREAD  # pylint: disable=W0603
+
+    BPF_THREAD = threading.Thread(target=bpftrace_call)
+    BPF_THREAD.start()
+    if not BPF_THREAD.is_alive():
+        raise KsftSkipEx("BPFtrace thread is not alive. Skipping test")
+
+
+def bpftrace_stop() -> None:
+    """Stop the bpftrace thread"""
+    if BPF_THREAD:
+        BPF_THREAD.join()
+
+
+def bpftrace_any_hit(join: bool) -> bool:
+    """Check if netpoll_poll_dev() was called by checking the global variable `maps`"""
+    if BPF_THREAD.is_alive():
+        if join:
+            # Wait for bpftrace to finish
+            BPF_THREAD.join()
+        else:
+            # bpftrace is still running, so, we will not check the result yet
+            return False
+
+    logging.debug("MAPS coming from bpftrace = %s", MAPS)
+    if "hits" not in MAPS.keys():
+        raise KsftFailEx(f"bpftrace failed to run!?: {MAPS}")
+
+    return MAPS["hits"] > 0
+
+
+def do_netpoll_flush_monitored(
+    cfg: NetDrvEpEnv, netdevnl: NetdevFamily, ifname: str, target_name: str
+) -> None:
+    """Print messages to the console, trying to trigger a netpoll poll"""
+    # Start bpftrace in parallel, so, it is watching
+    # netpoll_poll_dev() while we are sending netconsole messages
+    bpftrace_start()
+
+    do_netpoll_flush(cfg, netdevnl, ifname, target_name)
+
+    if bpftrace_any_hit(join=True):
+        ksft_pr("netpoll_poll_dev() was called. Success")
+        return
+
+    raise KsftSkipEx("netpoll_poll_dev() was not called. Skipping test")
+
+
+def do_netpoll_flush(
+    cfg: NetDrvEpEnv, netdevnl: NetdevFamily, ifname: str, target_name: str
+) -> None:
+    """Print messages to the console, trying to trigger a netpoll poll"""
+    netcons_configure_target(cfg, ifname, target_name)
+    retry = 0
+
+    for i in range(int(ITERATIONS)):
+        msg = f"netcons test #{i}"
+
+        with open("/dev/kmsg", "w", encoding="utf-8") as kmsg:
+            for j in range(10):
+                try:
+                    kmsg.write(f"{msg}-{j}\n")
+                except OSError as exception:
+                    # in some cases, kmsg can be busy, so, we will retry
+                    time.sleep(1)
+                    retry += 1
+                    if retry < 5:
+                        logging.info("Failed to write to kmsg. Retrying")
+                        # Just retry a few times
+                        continue
+                    raise KsftFailEx(
+                        f"Failed to write to kmsg: {exception}"
+                    ) from exception
+
+            if bpftrace_any_hit(join=False):
+                # Check if netpoll_poll_dev() was called, but do not wait for it
+                # to finish.
+                ksft_pr("netpoll_poll_dev() was called. Success")
+                return
+
+        # Every 5 iterations, toggle netconsole
+        netcons_delete_target(target_name)
+        netcons_configure_target(cfg, ifname, target_name)
+        # If we sleep here, we will have a better chance of triggering
+        # This number is based on a few tests I ran while developing this test
+        time.sleep(0.4)
+
+
+def test_netpoll(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> None:
+    """
+    Test netpoll by sending traffic to the interface and then sending
+    netconsole messages to trigger a poll
+    """
+
+    target_name = netcons_generate_random_target_name()
+    ifname = cfg.dev["ifname"]
+    traffic = None
+    original_queues = ethtool_read_rx_tx_queue(ifname)
+
+    try:
+        # Set RX/TX queues to 1 to force congestion
+        ethtool_set_rx_tx_queue(ifname, 1, 1)
+
+        traffic = GenerateTraffic(cfg)
+        do_netpoll_flush_monitored(cfg, netdevnl, ifname, target_name)
+    finally:
+        if traffic:
+            traffic.stop()
+
+        # Revert RX/TX queues
+        ethtool_set_rx_tx_queue(ifname, original_queues[0], original_queues[1])
+        netcons_delete_target(target_name)
+        bpftrace_stop()
+
+
+def test_check_dependencies() -> None:
+    """Check if the dependencies are met"""
+    if not os.path.exists(NETCONSOLE_CONFIGFS_PATH):
+        raise KsftSkipEx(
+            f"Directory {NETCONSOLE_CONFIGFS_PATH} does not exist. CONFIG_NETCONSOLE_DYNAMIC might not be set."
+        )
+
+
+def main() -> None:
+    """Main function to run the test"""
+    netcons_load_module()
+    test_check_dependencies()
+    netdevnl = NetdevFamily()
+    with NetDrvEpEnv(__file__, nsim_test=True) as cfg:
+        ksft_run(
+            [test_netpoll],
+            args=(
+                cfg,
+                netdevnl,
+            ),
+        )
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.47.1


