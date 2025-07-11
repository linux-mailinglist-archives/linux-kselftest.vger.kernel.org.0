Return-Path: <linux-kselftest+bounces-37133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A57FB02131
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E53616BD9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC53E2F0E34;
	Fri, 11 Jul 2025 16:05:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682F2EF9DF;
	Fri, 11 Jul 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249929; cv=none; b=JoyW5Ld+JW3ZPG/whp9G9G4Qc1np06E/vZvqFwf4viSmu6A8yFX3OO7GFehI6bx5MsTRSfjb+q4b6kKDvvRKOz8NpuZdPf9ZWEnmkNYyXtU30T8Gm5Ke+epA4jXvsZDwxDAIzW1EnYNkPvU4OMXyk2lqKoY+kOKTYS+rPBAakD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249929; c=relaxed/simple;
	bh=HuTgKNiNzN7gfP3SZS19EdEf2Iptuunx9l7c6X91QSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utO1GDHxin8rdGhcRclHD0oPmRD9FLCc611RqsIGKEzemcQfj9OQSM40GoLkw35OmKWpPkgVHTN/lmcFyC0ct62IPn00ozhPKIZ/lSlAFon02siA1R3xJnmmtvXOzS20Ldua12nB3Y2CPvxZvvWvNCSgtx2b8XNFtxGaRQQxC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso3661862a12.2;
        Fri, 11 Jul 2025 09:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249926; x=1752854726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34tK3dA/g+Ec6FuI3ZK7zDdtJQ1B8nDAieH5jeaWgcI=;
        b=aTv5qOi7+Brx0E8QSgLXhr5cHudBr3hwMrh8oYRy4GGiYW7GO3N4nMuDgeXYWgDwbt
         MyOr/Dvb7kVG/ly1cJlFBeiLjiUxKPqmQcwUISrfLMGEBK+tr6MxFamNqcZDAQxBrNOm
         UR8UKDMTMVN1Tnlg2iGfU5zQVfUk5r9T/YkqSQ0PdmOhYUdICPSo6zgKlzRDQX+iTfqS
         UfufyA/a73g9kN0bDNg2NyWFjsAlPPOPbGqIj6yEsJholqBbtmx5e95SU/J6jk+WjJPr
         EYsZU/xD+My5xO8ZGjIdeLM0KG3vQrpHwnVz8VujIY+Na+ylSwmdkelUqixJjRk9+TlN
         G4oA==
X-Forwarded-Encrypted: i=1; AJvYcCUTDdUyUG/R0sXd9JOXMargdAL2sBQAWNhuX+jYToqfpH45r2DfA6Fq/GcTB8B0jaW20P847PhU59zJOk2PIkYq@vger.kernel.org, AJvYcCUiEYyfmdf9q5mCPWlAodkzMu3BWvImtLWbdbKL8baRi7ROz7V3ZLvEr3t+12k9BiUum50pzedV@vger.kernel.org, AJvYcCWyPkC0bRbytrBDdfnipdAuRE+AyFjq7mntsPvdHnSe5p5KfMzDBHaayJlmXrOHbT6Bmn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4mZv0LMkbqA4CbuSRc0PiHFo7VfVzg9KVaRs2+OgRNumehhZ
	yb+Cz0j09BZsGSk7/K/zVZK9Cc7IReYv7yGHNRn4TqiLZiXLZtAkSlbh6ijcgA==
X-Gm-Gg: ASbGnctrgxQmNR/w9qki8UE5ZjenW6toHrTxXsXh+r5hdzgK51Y5HihbmL7P8ooHuMR
	rOwiWPSfEm6hwHWrWIqBQR4tLHTIOV2mzSSI9BMMZlH3rkyz309Mel0naatrAQ+x2Kz5F/zgXOf
	EAfoNS0lrBoI+WVTTky3XErcArAEbxBN4LSu/OMLdXhCi8AJpi0Y2p7z9ZhE54FPtBrcq0E3GPG
	Rk7sUa2KL8B6hFT1RmgI7hjVmHySM6TI31UxatJtPDXGq7PId/iOe8da0a7q3gAlbs4kskB72g+
	VATUqz76l/tyipq9nDFGjXPwE8tQGUNG9tFn3hElPYUPiQ/edTQIlAqK3fU/ijXx7JVDsGQYY2P
	9UlS3BZ0rRqvbQQ==
X-Google-Smtp-Source: AGHT+IFqGycNIsOAm/6c3PE+Kd/IgjqtCLwXepAYWiZyWmCLovjq6UFnyvZdkD84cMkMOklpwxU5uQ==
X-Received: by 2002:a17:907:60d5:b0:ae3:a717:e90c with SMTP id a640c23a62f3a-ae6fc713cbcmr366869066b.23.1752249925032;
        Fri, 11 Jul 2025 09:05:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e94321sm321477366b.30.2025.07.11.09.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:05:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Jul 2025 09:05:11 -0700
Subject: [PATCH net-next v6 3/3] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-netpoll_test-v6-3-130465f286a8@debian.org>
References: <20250711-netpoll_test-v6-0-130465f286a8@debian.org>
In-Reply-To: <20250711-netpoll_test-v6-0-130465f286a8@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16141; i=leitao@debian.org;
 h=from:subject:message-id; bh=HuTgKNiNzN7gfP3SZS19EdEf2Iptuunx9l7c6X91QSE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBocTY+iQs8eb0MaQfUmpukJdMqVS9JqrpTA1V0P
 qSnG9cwwTCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHE2PgAKCRA1o5Of/Hh3
 bau3D/0SlGSq5C1p/d1T1cXinQTov000NXacCoFzxJt5spINlUkuAzlg8gFMgWD5vDjv9oK3DME
 YO/2vjNuGUGJw8G0ewK+DFjKoNdEyldssPuU/0h83NMfqqNZMu3xEF2kksHzOVHTY1K79wRP1ic
 1dP0xW9hWM8NE9tQV9Z5ohyZap7eHGxjwVfGWMzWmKaqZZAK6H6/yN5igImJjXOQvH4QT6OjXmb
 vbNRdfdaOIwHC+B5aKyrOBnX+U1AEXxc6WfJ2uFZsfOWzXyYAvOeWSMRhJjJuopoq3hgQp03yaM
 ApTnJ3dfxy9Oz2TWqniEZ5rz5VyUrFE/1nH+9AeYXIZ4T/RZlaYwucsOd0yXtChRX8uV/kFP8mZ
 s5C2L64pNrld+RcRduhu418/px2yt4oA53kA/C0rFJcOlaVIxCa787hQ/g+6QgVt76YsCDwxLXt
 t5RN43F7shK9yZdwtdI5VQOYN44jrtI06VQuLCV+pFkpc/T51HwotdmLouceQczle9mdFp9guto
 fMmf+qo+C5y5RqYEFVAkFaI0EX963PTx+ycktOwT50wwHP5EPjgeCvz2vtP4xVbXNvq2fe13mYY
 R9CvmzHOd2IKYZt0V1wpMvo5gjbV2C7+Ot76hoqekUbJK/4Tt7d+52c1BmmCIru4vvxD43TvChh
 O8FQ1vbUF69Icdg==
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
 .../testing/selftests/drivers/net/netpoll_basic.py | 411 +++++++++++++++++++++
 2 files changed, 412 insertions(+)

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
index 0000000000000..5fe2d931f7569
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
@@ -0,0 +1,411 @@
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
+def to_int(number: str) -> int:
+    """Convert str to int, or -1"""
+    try:
+        i = int(number)
+    except ValueError:
+        i = -1
+    return i
+
+
+def ethtool_get_ringsize(interface_name: str) -> tuple[int, int]:
+    """
+    Read the ringsize using ethtool. This will be used to restore it after the test
+    """
+    try:
+        ethtool_result = ethtool(f"-g {interface_name}", json=True)[0]
+        rxq = ethtool_result["rx"]
+        txq = ethtool_result["tx"]
+    except (KeyError, IndexError) as exception:
+        raise KsftSkipEx(
+            f"Failed to read RX/TX ringsize: {exception}. Not going to mess with them."
+        ) from exception
+
+    return rxq, txq
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
+    rxq = -1
+    txq = -1
+    combined = -1
+
+    try:
+        ethtool_result = ethtool(f"-l {interface_name}").stdout
+        for line in ethtool_result.splitlines():
+            if line.startswith("RX:"):
+                rxq = to_int(line.split()[1])
+            if line.startswith("TX:"):
+                txq = to_int(line.split()[1])
+            if line.startswith("Combined:"):
+                combined = to_int(line.split()[1])
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


