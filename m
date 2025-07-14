Return-Path: <linux-kselftest+bounces-37231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEB2B03B86
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F704A0FC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DF8246BD2;
	Mon, 14 Jul 2025 09:57:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA38245014;
	Mon, 14 Jul 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487045; cv=none; b=LgWuBT9QqSFuOvhBKJn8pKWkT9ILcPHZ4stvIigHivhzrAZUj6zeTWVSk4HFloVId7AUTMuLnudUHkYh3uP9NW+uoi2WZ/vppbkwTk1yngBACYwR5Om/gCPc+oUc8XrgKAIF+vEhEf+XUW1McC6Y4xZ8xwq8UFhvte+dHKQSJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487045; c=relaxed/simple;
	bh=4PUUFQopNWdbDgg0u3YlG82u/hz7li2G4FaDvZ6YhcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gp3f3e73CpbcaJ78SpvKWXpwZ/l42My61KC7d3a2dQvm68Bn31fna8o6ObXlVK3eSssexkWqKhvyX+s5Mnp1neIte79q3RqdVrIZT17JmDjq2v46rynWhEyZ0AjMUW3qzVBCkDp4aD/5lLmHu9bhQLqFu5GPeYrOKvAccaXdK+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so6381020a12.1;
        Mon, 14 Jul 2025 02:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752487041; x=1753091841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iif/tPC1a66vRUitvjQII1Cjmas2fT1VMy6tpXIQwTo=;
        b=l4I1q82ckqIp9Uw0c5rujp4Nd/zYdcgAybU7cqfAXiHmoGpAdlOVXyGCWHC0c9qsKG
         7OSmulxX1YOEQEZFjRJQPkCU4Q7+ez/Qc3f4GI3RAYR8UB8ycbdE/8ddjdByheMbabIG
         +AKul1Allboueuc6WEPRLfEXlDIVdERHW68HgliVIsYV7MzAFJQgMaPbBGE9QuwEtDjd
         CAfnBmLQtn+zlGkwX59rkT5qrg+PhYLvLFEv9GL7NH6NlZ3J5z7a9MfS01UR+Y/TB43+
         vecVDeV/cA7bRNZBGkG0j8RYjWZPRbUS7V+XbUulQN1HGUH0/WvB34r6v86+pZJDUUro
         w4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXH7Ou3e3QOwkXKmZEjctR2mLWYoH490D19SnhseZR1bnb6dJawfF6PasbJLIh1UKTVIIfAbLJYjhqG9MPCdFNp@vger.kernel.org, AJvYcCXgADIDh1zBnZ9XbL6XDdwm0gueNKwld0qU5DzQvSRxjT11dhIuAfJgG5uiUdj9w8UHeCA=@vger.kernel.org, AJvYcCXrpJP8D3rgX3eP5vU4HWH2cOZ0GwPyN/RGJVti17DGPiwKoDfOckEc6nv4XudZaQSDW9gBwTwx@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQj/7HLSglrjoB+olcWsrA1o9baOy+RaIxHFggRLhCqVrJpT4
	MAUnGH755Ube89AmLaBrm1y3ZWm7L8YK7jg7e1Wuz0vv0FTYbO4eZDNM8ls3uw==
X-Gm-Gg: ASbGncv1/3PdDuC3lBYRfqO75fykNVFZo/SMmafPfOacy9voBXp1F0m/TKg0bvKq12O
	XAxWiHnmb2m/HO+Cg07iALrja4oAUDyHMCd0XUvG0PIYGv/BOTCkLOOHUbJBfw2jgM50cLgqr4I
	XpoSlG9mtPAyjYreD1ktClJnzpmJXXkeC7cDnHtf/8jX1LS01RKL2T/YTGXvHvxCXdJrxWHw0O9
	CMvod2SArcGYh8kQKFzW9Y3Adj/+W9hTheA+DVKg3gbGQc1hLopLD9BVUcqw37wFW8b9L49LBPu
	xeJKb4N7gfntfzA3bjVxWs3x9/oDiuGY2zT8NsxPRm9TNTUoALlJ31RaYbXGJbgj6eHiCKD/J2I
	ZjwhlgyhLTpLS
X-Google-Smtp-Source: AGHT+IHZr5zKTLSiWv3i4+7EBokAtcoOSjrhtZ2CWmjBbZcBCbH1Pp1i1PVzl/O/1AtTkQ3iifzISQ==
X-Received: by 2002:a17:907:1c26:b0:ae6:e0b1:9633 with SMTP id a640c23a62f3a-ae6fcbc2afcmr1208967066b.33.1752487040562;
        Mon, 14 Jul 2025 02:57:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645f2sm783781966b.89.2025.07.14.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:57:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Jul 2025 02:56:50 -0700
Subject: [PATCH net-next v7 3/3] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-netpoll_test-v7-3-c0220cfaa63e@debian.org>
References: <20250714-netpoll_test-v7-0-c0220cfaa63e@debian.org>
In-Reply-To: <20250714-netpoll_test-v7-0-c0220cfaa63e@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=15746; i=leitao@debian.org;
 h=from:subject:message-id; bh=4PUUFQopNWdbDgg0u3YlG82u/hz7li2G4FaDvZ6YhcQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBodNR6xU6Xjp9WkrQsyehYyS/dIKJ879xpLJQbA
 7lEWetWbcuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHTUegAKCRA1o5Of/Hh3
 bT94D/49bWePQ+FL9co/oZTEg8BlN7hGFhOzi63ipZOGNVKN3T8biLgT7yR+z8bm++DOoAsOde7
 DO5SqMdLxbdAR25Uzp3fV95zTDGLQmcC0SG8ruUk4DdzTohUtfqNvOQdIYYRKVOeICji3glsg9+
 nbrnNSuHMEEPFe+hO6dgX6DjaNWnvwSiggTm1K01ZFscuziVvnzu+PRydWJYMIAAziB2lyFtqzX
 SqN4YbNjjVRwY4oscIYiLmkc5Im7lKUtQDYb3yuJFghR4JX3wqQAoDRm6I3Alr/dNFGEaDP05mR
 y74hoREUOnULIr757SRm/LDGq8wmkpF1Z+/PJ1seIZzKOChEDWX4vTAgUwnRocBMptXNv5y9iGp
 n8jart3ysi2acvgRCVYrzOQpC13FmSXk0Z5EWGQt201tXHzPBG3DiubS2xxsYDkRStHnFRQlkiO
 Cvp2zn2YjYSdpbCO+cO/uD7echyFEdhdEk02tyh8koTe4FLn4WovlRfHC2syQZby9QDnvaAnCu4
 HbhSD6yZ2y5JBD+M/els/rF3MKplEj48/9tbStYsIY0XwMZElqt6AHKooRVA9KPm8gcypuNYmJu
 pv50m8N+SL32i7ZcLg4NQfXBkcFcwLTHx3PNWl29AogSo9gARwSKBX46Uy/1lbASQfBAmuxgiII
 JClf/ivnXjqf33A==
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/netpoll_basic.py | 396 +++++++++++++++++++++
 2 files changed, 397 insertions(+)

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
index 0000000000000..408bd54d67798
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
@@ -0,0 +1,396 @@
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
+from typing import Optional
+
+from lib.py import (
+    bpftrace,
+    CmdExitFailure,
+    defer,
+    ethtool,
+    GenerateTraffic,
+    ksft_exit,
+    ksft_pr,
+    ksft_run,
+    KsftFailEx,
+    KsftSkipEx,
+    NetDrvEpEnv,
+    KsftXfailEx,
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
+
+# Max number of netcons messages to send. Each iteration will setup
+# netconsole and send MAX_WRITES messages
+ITERATIONS: int = 20
+# Number of writes to /dev/kmsg per iteration
+MAX_WRITES: int = 40
+# MAPS contains the information coming from bpftrace it will have only one
+# key: "hits", which tells the number of times netpoll_poll_dev() was called
+MAPS: dict[str, int] = {}
+# Thread to run bpftrace in parallel
+BPF_THREAD: Optional[threading.Thread] = None
+# Time bpftrace will be running in parallel.
+BPFTRACE_TIMEOUT: int = 10
+
+
+def ethtool_get_ringsize(interface_name: str) -> tuple[int, int]:
+    """
+    Read the ringsize using ethtool. This will be used to restore it after the test
+    """
+    try:
+        ethtool_result = ethtool(f"-g {interface_name}", json=True)[0]
+        rxs = ethtool_result["rx"]
+        txs = ethtool_result["tx"]
+    except (KeyError, IndexError) as exception:
+        raise KsftSkipEx(
+            f"Failed to read RX/TX ringsize: {exception}. Not going to mess with them."
+        ) from exception
+
+    return rxs, txs
+
+
+def ethtool_set_ringsize(interface_name: str, ring_size: tuple[int, int]) -> bool:
+    """Try to the number of RX and TX ringsize."""
+    rxs = ring_size[0]
+    txs = ring_size[1]
+
+    logging.debug("Setting ring size to %d/%d", rxs, txs)
+    try:
+        ethtool(f"-G {interface_name} rx {rxs} tx {txs}")
+    except CmdExitFailure:
+        # This might fail on real device, retry with a higher value,
+        # worst case, keep it as it is.
+        return False
+
+    return True
+
+
+def ethtool_get_queues_cnt(interface_name: str) -> tuple[int, int, int]:
+    """Read the number of RX, TX and combined queues using ethtool"""
+
+    try:
+        ethtool_result = ethtool(f"-l {interface_name}", json=True)[0]
+        rxq = ethtool_result.get("rx", -1)
+        txq = ethtool_result.get("tx", -1)
+        combined = ethtool_result.get("combined", -1)
+
+    except IndexError as exception:
+        raise KsftSkipEx(
+            f"Failed to read queues numbers: {exception}. Not going to mess with them."
+        ) from exception
+
+    return rxq, txq, combined
+
+
+def ethtool_set_queues_cnt(interface_name: str, queues: tuple[int, int, int]) -> None:
+    """Set the number of RX, TX and combined queues using ethtool"""
+    rxq, txq, combined = queues
+
+    cmdline = f"-L {interface_name}"
+
+    if rxq != -1:
+        cmdline += f" rx {rxq}"
+    if txq != -1:
+        cmdline += f" tx {txq}"
+    if combined != -1:
+        cmdline += f" combined {combined}"
+
+    logging.debug("calling: ethtool %s", cmdline)
+
+    try:
+        ethtool(cmdline)
+    except CmdExitFailure as exception:
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
+                    content.strip(),
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
+        "local_ip": cfg.addr,
+        "remote_ip": cfg.remote_addr,
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
+    expr = "kprobe:netpoll_poll_dev { @hits = count(); }"
+
+    MAPS = bpftrace(expr, timeout=BPFTRACE_TIMEOUT, json=True)
+    logging.debug("BPFtrace output: %s", MAPS)
+
+
+def bpftrace_start():
+    """Start a thread to call `call_bpf` in a parallel thread"""
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
+    if not BPF_THREAD:
+        raise KsftFailEx("BPFtrace didn't start")
+
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
+    logging.debug("Got a total of %d hits", MAPS["hits"])
+    return MAPS["hits"] > 0
+
+
+def do_netpoll_flush_monitored(cfg: NetDrvEpEnv, ifname: str, target_name: str) -> None:
+    """Print messages to the console, trying to trigger a netpoll poll"""
+    # Start bpftrace in parallel, so, it is watching
+    # netpoll_poll_dev() while we are sending netconsole messages
+    bpftrace_start()
+    defer(bpftrace_stop)
+
+    do_netpoll_flush(cfg, ifname, target_name)
+
+    if bpftrace_any_hit(join=True):
+        ksft_pr("netpoll_poll_dev() was called. Success")
+        return
+
+    raise KsftXfailEx("netpoll_poll_dev() was not called during the test...")
+
+
+def do_netpoll_flush(cfg: NetDrvEpEnv, ifname: str, target_name: str) -> None:
+    """Print messages to the console, trying to trigger a netpoll poll"""
+    netcons_configure_target(cfg, ifname, target_name)
+    retry = 0
+
+    for i in range(int(ITERATIONS)):
+        if not BPF_THREAD.is_alive() or bpftrace_any_hit(join=False):
+            # bpftrace is done, stop sending messages
+            break
+
+        msg = f"netcons test #{i}"
+        with open("/dev/kmsg", "w", encoding="utf-8") as kmsg:
+            for j in range(MAX_WRITES):
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
+        netcons_delete_target(target_name)
+        netcons_configure_target(cfg, ifname, target_name)
+        # If we sleep here, we will have a better chance of triggering
+        # This number is based on a few tests I ran while developing this test
+        time.sleep(0.4)
+
+
+def configure_network(ifname: str) -> None:
+    """Configure ring size and queue numbers"""
+
+    # Set defined queues to 1 to force congestion
+    prev_queues = ethtool_get_queues_cnt(ifname)
+    logging.debug("RX/TX/combined queues: %s", prev_queues)
+    # Only set the queues to 1 if they exists in the device. I.e, they are > 0
+    ethtool_set_queues_cnt(ifname, tuple(1 if x > 0 else x for x in prev_queues))
+    defer(ethtool_set_queues_cnt, ifname, prev_queues)
+
+    # Try to set the ring size to some low value.
+    # Do not fail if the hardware do not accepted desired values
+    prev_ring_size = ethtool_get_ringsize(ifname)
+    for size in [(1, 1), (128, 128), (256, 256)]:
+        if ethtool_set_ringsize(ifname, size):
+            # hardware accepted the desired ringsize
+            logging.debug("Set RX/TX ringsize to: %s from %s", size, prev_ring_size)
+            break
+    defer(ethtool_set_ringsize, ifname, prev_ring_size)
+
+
+def test_netpoll(cfg: NetDrvEpEnv) -> None:
+    """
+    Test netpoll by sending traffic to the interface and then sending
+    netconsole messages to trigger a poll
+    """
+
+    ifname = cfg.ifname
+    configure_network(ifname)
+    target_name = netcons_generate_random_target_name()
+    traffic = None
+
+    try:
+        traffic = GenerateTraffic(cfg)
+        do_netpoll_flush_monitored(cfg, ifname, target_name)
+    finally:
+        if traffic:
+            traffic.stop()
+
+        # Revert RX/TX queues
+        netcons_delete_target(target_name)
+
+
+def test_check_dependencies() -> None:
+    """Check if the dependencies are met"""
+    if not os.path.exists(NETCONSOLE_CONFIGFS_PATH):
+        raise KsftSkipEx(
+            f"Directory {NETCONSOLE_CONFIGFS_PATH} does not exist. CONFIG_NETCONSOLE_DYNAMIC might not be set."  # pylint: disable=C0301
+        )
+
+
+def main() -> None:
+    """Main function to run the test"""
+    netcons_load_module()
+    test_check_dependencies()
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run(
+            [test_netpoll],
+            args=(cfg,),
+        )
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.47.1


