Return-Path: <linux-kselftest+bounces-36313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D80AF13B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF717B7F35
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5AB270ED2;
	Wed,  2 Jul 2025 11:21:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F926C396;
	Wed,  2 Jul 2025 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455276; cv=none; b=CudInG7Ypbn78CrtQGVl7evpiLeC9DBxtIJfekDmgW2Zdk4QwILuFHh/o6afnOif6dbosWdSKfUFd7v2JMr89RbPOWjk3OzKTs7ASeSdubwIbwabfSggUrN7z+X2/27b48qA2KyHGWB7N1qQKvGsR2xMncCS4V+xvn3oTS6cUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455276; c=relaxed/simple;
	bh=FRTEkYEmygM5jZbsnSMtXO9a4WVPx+t+RymFB6zRxWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGHKjnCDZwCipzS1SEfZOjcb3DxBnTfiGxWuEH4F1hXDjBdmIotNhf0hSSD8i3ubB14v7VJNRURNzEj04/YUjJcexWBEy4Ozbu4eO4CD+Dh8Z/ITYX9Jsf26aSuIREOE5yGW8pE9cgeYHCPZNbcXwXV/H7qyQlWaXO/P0hxHiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acb5ec407b1so767773866b.1;
        Wed, 02 Jul 2025 04:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455273; x=1752060073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyZYpgP+dO8O+GOplLj6ow/h6NOrDNtT4jFXzdZVmts=;
        b=Cc5GiMUexxfVL1Df+y0wXstyt5JYyLRpIi2vtpbnxqbryz6QvuWyeCN2rbgkLKBOSC
         bSemqs7Fl5qzzV3rKBygO0aSu2AWggYxg2mp1D/Zk99B51PEA8VHdXQ72XMIPVpYatUd
         e0x2vF7EB6wBCvOSpiReyCVQGgBF5vZzOS5cxS/gd4S680JRaSfD/NRCYrLQViXIaLPW
         Xb3MerIhbm4t7txhMnWSXVA4p0qM4PNXQFYKEtIGE08qX1gL2LaFglyyMdupb9SnGTmY
         ziinhQlLhjLc/4IgC56lOl+RkwdzSwRpA6l/haeZtPCCNzvLCwYnt/eJ3tk+9ufYVaKj
         xrjw==
X-Forwarded-Encrypted: i=1; AJvYcCX2MmAz6Ar8qwpoUIiwYIZfsVqpFYKbaZ4aMFdeqSQ7DinNac7ZA89HwLMuDwow6DBB1sQ=@vger.kernel.org, AJvYcCX43ZZ/jwtpBEIomBkgqUBfHvsguqtHCguKCds6J08mInQImT9A7vjMxzR1J2l7oE/P83/dulor@vger.kernel.org, AJvYcCXtX4gb90QM/YMXo9NoucawNWSFO/YnOyi5WId/6JSPL4Mrku8MZlSe8mb3vcBmqF4WVd4QWVeqD+yioYJzj7oX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjc3YU2y8a4QTwC9juOo+spFAlTT/XN+/Hm1cs/iUzriCZGM5N
	ltaxG2Gir3ZvNmS2aTdhqXWev6waKEmEm6QGXmn2HIBk5H0noioxvDB3
X-Gm-Gg: ASbGncu/jFlS2IQew6AK9VDI2/z95ZtUhcuBx/GMW9X3Qfexoxz2sHzdmiIqfOCEIk+
	FtKB9L9ioj3HJDJKPbb+OFoMEeIvJXLg4g3oTZIm68f33fA5qN93moeP3jcenfm/gcB5hZxWV24
	cmSqz0j7N5Pzy0pCYZs6Zc1usymo7NYmyqn5k8Qzq5FPWue9QdAr/u+gefw+nREdcDKC7dSAHYK
	dtNfYXL+Rj7ldoP0+lxxTZpOsuP2IEwG5jQGi7utL/V+ZmvILMUeG2Qzj4BK9BzhtWOUM7zcsyP
	csCHaGXOYZ6HHavuighAjEi8oVb0+DpzIzk+ECmqstshlNuEQGWn77j6gOndvEU=
X-Google-Smtp-Source: AGHT+IFVvMNvJ8NxcQl3N5hgFKNwn6xPsKXcKewZRlcd1UR+aCHfmYDiRExaYuMfu6cxQzfO3Ba/5A==
X-Received: by 2002:a17:906:6a09:b0:ae3:53b3:b67d with SMTP id a640c23a62f3a-ae3c2b51dfdmr250631966b.1.1751455272438;
        Wed, 02 Jul 2025 04:21:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a000sm1041355466b.41.2025.07.02.04.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:21:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 04:21:02 -0700
Subject: [PATCH net-next v4 3/3] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_test-v4-3-cec227e85639@debian.org>
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
In-Reply-To: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=14972; i=leitao@debian.org;
 h=from:subject:message-id; bh=FRTEkYEmygM5jZbsnSMtXO9a4WVPx+t+RymFB6zRxWc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZRYi5yE6XDvitg6SSSuZRpPcJs3MOHJgBySDd
 L81Xku8jguJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUWIgAKCRA1o5Of/Hh3
 bZZeEACiyHoCTzJ+VoaUKTe11sAl+VFkeSo3vFFsJmHY22Tm8IGuAmrBTuNEoAJW5Te47MictmS
 K9xwkFwlrBd0auHUrrwdD5doHAoB++flRTJdkGCECJ+f3qffJTmA/wq7GJKVSnLSwrZhpvWrkZw
 2Ke9xTZyABIKtl8NIupp5djhEBdW9NtITwFvXA7hTbH9ZfVkElXQgzDV2JNHR2AtLUTuIIep7tY
 XrwY+fD+9ZIjmMBKIpPVnJukxvrtoMX2kvtMw/z9MLpspF3vMLpgrSRFoN2lu0wDruJaVBM+GSK
 qpV0JBp7I6KIb4lSEv+MF5JLFowXIAJTd92s8R+pbDfy5GV2vX1XvgFHkxlxcmizTnUfrF51iHE
 8s1l+MGc6gaXjhWmE2cP3Pd7HHLaZHxuqUeKNTmgBfV7bLDIOUoxvsC9hYvQERvNRsimjKy66SJ
 KaZFOk9AmJj47UVjE8WJl0MeBi5LbaPx0MnSozE0OmZDOcwbkTHwrsWdkuSK3MABhIUK/ljrJG6
 piGYi+oh9W4ZdQfpPsgdHA75tLLJcKKm9fZDFXcgy404+IKb7b7vnF4/vBl/xEA2BrbygT2sOQD
 3s2I8k7cvWXR7EATI9/EOnNcv17EjPtbkrh1LvlBcm4uvP3sscamiGwlhEIpsjmnIxQmNwqRrLc
 iO4wHoNq5iYFcCA==
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
 .../testing/selftests/drivers/net/netpoll_basic.py | 365 +++++++++++++++++++++
 2 files changed, 366 insertions(+)

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
index 0000000000000..398ac959151b3
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
@@ -0,0 +1,365 @@
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
+    ip,
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
+# toggle the interface up and down, to cause some congestion
+def toggle_interface(ifname: str) -> None:
+    """Toggle the interface up and down"""
+    logging.debug("Toggling interface %s", ifname)
+    try:
+        ip(f"link set dev {ifname} down")
+        # Send a message while the interface is down, just to
+        # cause more test scenarios. Netconsole should be
+        # going down here as well, giving the link was lost
+        with open("/dev/kmsg", "w", encoding="utf-8") as kmsg:
+            kmsg.write("netcons test while interface down\n")
+
+        ip(f"link set dev {ifname} up")
+    except Exception as exception:
+        raise KsftFailEx(f"Failed to toggle interface: {exception}") from exception
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
+        # Every 5 iterations, toggle the network and netconsole
+        toggle_interface(ifname)
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


