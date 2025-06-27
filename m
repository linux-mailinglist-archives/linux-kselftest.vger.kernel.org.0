Return-Path: <linux-kselftest+bounces-35985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42DAEBE18
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10063564F02
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F322ED157;
	Fri, 27 Jun 2025 17:03:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26592EBDD7;
	Fri, 27 Jun 2025 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043818; cv=none; b=FNDir6LWr1OjLwmaQ5gp/v2NhIzlyJU1wp1jSsbottfUoC69cGRCVdrZqCO9TgOX1O5wGQO0cqAQ9HYA7pDxPDQkaWjkezldJyNy8ntd6E7jqdAljhx/OX5hDzEojhiN26nSJRZOWfeDgdh1tROol3YjMfbftR2whTsnK5nqqNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043818; c=relaxed/simple;
	bh=T2m9FFDSS2NveVwVaZZ11Z51W0+7UfcIzqPpQSpOnCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CK/Ip9o2NfIEw5ADeytB9AVFCQpi8xu2Cu0KAwSAS7/nwYMcrKvEJif1UV5kb0OeFGIy9ojzXKMNbEWJj0DfQ6HicOCFxWy7oaJRAnzdiSqgFY6DEakHcrVY4uA7JNHanDXn46hBYAsjdynlwCm/5Vi2aGIANIRo1M7KH1DANGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so6430066b.0;
        Fri, 27 Jun 2025 10:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043814; x=1751648614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRE5JMrl+AHADSewX7znwCNdFZigkW0b6fCb+g9m094=;
        b=d058LgK78qvCgd+br7IWmIJundYVRJfE8D3mt7MdR0Yi4J8oKja3qnmGU0pg8El5Re
         Efupp3109DwKglyc+M+QYi3vN0MElygQB1fd6GEJYUTR7XrCvjY6NyFiW6Q/LYXu1cx1
         FL+K0bZqf0snBqG0kv+bxQKcAihL3xUbCA7A8d/+tRo3f4DHAFuSw2QEWMcZhNYA/Za4
         N/8ODH16zo3xwmcwdyNefvFAjd7hxlzSYAXPSecwEeH48c/0KCON3aIwy6DtxuXuzxrl
         xSR4FYkdKRwg0810Vzk4KBB/aDN69HF3+NPqdPlEHRZSRbrP/B4JdWSnVVAJmEkERCFJ
         MMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVARjVEscpyqXulCI+1zqMsGVWpQJPW76RuUKIbHp29K1ToHI0i+3vgP1pj9SKu111K9RM=@vger.kernel.org, AJvYcCVtBxDRlkxmQmzPYmZtxjQWXsLJ+FSIBOvB7ZHHIYicwuGhqWTAkTu5ce4MHp8YFK5tivkvzQDvwdC46FH34JEL@vger.kernel.org, AJvYcCXKT+YZ3B3cqYDXpuq2mY/YTJjse1ueoBOu6gVBii2cyxrBBBvp2xP3MIDeq2FDEyWMUguNg4Et@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfnjVW3CoqmYrtAHmgVQxRbKjhDSw0CS7BphIxoTGZsOn9co1
	79PgBwLBYwL7+FKAoGpptAFQpCeF2GcLrVY0YeJAVo+xNY5ndqqtxVLd
X-Gm-Gg: ASbGnctK+UO6qKHhLQV8+lz9e73JhbLLGdBfFmFWt9+jzXV00XWQvMCJiQXBB2OE8s4
	0ufjfiLXKKwzOxrg4p4GvJk3KLEsjn7BinT9ga/+FjMhMREEYm6BNmp6/ysnEZo1XOtdDPxdBgH
	X+kj+EvqdJt9f/k9WSeSrj9Gigwl4kJbSYPblrEM172z4iTBmX7KwWyk3DiSYualBN2d1w+oatb
	tTIxYYnIwQq08SOLkD4nywikUJdY+onna6cEDqR54jWMpmBSU2hPBV/YTG3utwdiWZmyTK6rMxe
	ZsKkewiC/Q6nTcZBJKLk6F8TT/h4KQ9To/7N1NSor+Ha5lekeLP40w==
X-Google-Smtp-Source: AGHT+IH25kAdjvhDrubYsrBCmZET07g41DhxNurnndN7GT34toNvN4zWnG80gP0nzs+Izn1aYkL/nw==
X-Received: by 2002:a17:907:7292:b0:ae0:bbd2:68ce with SMTP id a640c23a62f3a-ae3500b8e7bmr332248466b.32.1751043813651;
        Fri, 27 Jun 2025 10:03:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1619sm153616866b.149.2025.06.27.10.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:03:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:03:11 -0700
Subject: [PATCH net-next v3 3/3] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_test-v3-3-575bd200c8a9@debian.org>
References: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
In-Reply-To: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 ast@kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=14118; i=leitao@debian.org;
 h=from:subject:message-id; bh=T2m9FFDSS2NveVwVaZZ11Z51W0+7UfcIzqPpQSpOnCQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXs7fZj9BtVY8JscDok9NwWzMkTW+JJ3baVE/L
 zGfAbtJUqyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7O3wAKCRA1o5Of/Hh3
 bSl2D/954/gIVuJi4NfZPWBDg6KikgEKH5yTQ8eSLhxCNBuJZI6kpphVNt8QF4SgPxW7Wm/oDWP
 tIxtNYtGrUBgk45+fLmPLs65gMgSjtuI8dZglmT2KCu3Acx8+EQlPXar50921ONvGGoArplwjOD
 OTJSi42dn5vnjStwNx+YMUsTpON/yBQ1Vy44XihjWcyGJAx3bhKvVWF8ql1tDPygZYnFt8p+OJZ
 Zlhps6/bWjVluabyewv+nemHJ5zs5o8yjImdF0FOIFkw+4hFfTMhWgLQg+PpVd2qXukkfFJvRRn
 DirpLQ/j7AtQf3QqgEEDW4oLADjOAzh2KcZp/8qkGs96jVsxXxRe7og/dDIrtocpvP9x6eal02X
 jrdguVp4tp+2oIlaHCXsy2n/dBrbEJzcwxCGEFSwx/mu8o07EoDKV23ESAqeLS0uVb60rFy4QMu
 qlxYN6es+2umRKZ7F3jxOwK2Tr4Qcug6HTkqo9CX7Hp3i2EC4+xNPPkutITmosLRndvT4CCvd0a
 cCQpHAKxgOBavNw8cmjcIdbIRzKxznMEgAP+2kFMVsNJx4PuBTv5lR5RyIRl1DKKVaMq9pqLxuV
 5X1cZpncjC+ZM9jiEeNJAs2jg1pCj1pnjPOXtf5451pH86myWglcN4+hRD7yarIzM4ea4k9Q+Zr
 /HX6Bs1y2Z6OfUw==
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
 .../testing/selftests/drivers/net/netpoll_basic.py | 345 +++++++++++++++++++++
 2 files changed, 346 insertions(+)

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
index 0000000000000..f523d5a1c707e
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
@@ -0,0 +1,345 @@
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
+    rx_queue = 0
+    tx_queue = 0
+
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
+    if not rx_queue or not tx_queue:
+        raise KsftSkipEx(
+            "Failed to read RX/TX queues numbers. Not going to mess with them."
+        )
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
+def do_netpoll_flush_monitored(cfg: NetDrvEpEnv, ifname: str, target_name: str) -> None:
+    """Print messages to the console, trying to trigger a netpoll poll"""
+    # Start bpftrace in parallel, so, it is watching
+    # netpoll_poll_dev() while we are sending netconsole messages
+    bpftrace_start()
+
+    do_netpoll_flush(cfg, ifname, target_name)
+
+    if bpftrace_any_hit(join=True):
+        ksft_pr("netpoll_poll_dev() was called. Success")
+        return
+
+    raise KsftSkipEx("netpoll_poll_dev() was not called. Skipping test")
+
+
+def do_netpoll_flush(cfg: NetDrvEpEnv, ifname: str, target_name: str) -> None:
+    """Print messages to the console, trying to trigger a netpoll poll"""
+    netcons_configure_target(cfg, ifname, target_name)
+    retry = 0
+
+    for i in range(int(ITERATIONS)):
+        if not BPF_THREAD.is_alive():
+            # bpftrace is done, stop sending messages
+            break
+
+        msg = f"netcons test #{i}"
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
+def test_netpoll(cfg: NetDrvEpEnv) -> None:
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
+        do_netpoll_flush_monitored(cfg, ifname, target_name)
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
+            f"Directory {NETCONSOLE_CONFIGFS_PATH} does not exist. CONFIG_NETCONSOLE_DYNAMIC might not be set."  # pylint: disable=C0301
+        )
+
+
+def main() -> None:
+    """Main function to run the test"""
+    netcons_load_module()
+    test_check_dependencies()
+    with NetDrvEpEnv(__file__, nsim_test=True) as cfg:
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


