Return-Path: <linux-kselftest+bounces-34831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80330AD7882
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 18:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE043B2E5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9112C29B77B;
	Thu, 12 Jun 2025 16:50:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBE19F13F;
	Thu, 12 Jun 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747012; cv=none; b=Kr4UzZOXkq+Nnhm8qJh6dZFi9Ui9IP3y0yD04JeUKncUsFlU0rxj21i3/eV6hmPMEvqE+hgaJnFBI+pZwQaydg2ewrIAllHc2isEO+shdHN4GLKiIhKuTB2zxISvxtK+aPqysw6P8BbBEEkplD38t5MO06MvVDe9TZGjiom+iqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747012; c=relaxed/simple;
	bh=y1pnc0K21RY6sKl7h4y4645XMHvqTAhb0rymQLHBub8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DSXTJCTR3zxdesNhuZfq1gcNL1icj6Cx12ABoh5PLbKLrum3W8AFrS9VenH/HlY84hvQBas1ZKBDDkXM2b2LvOn+1cyLgQAoA0/mSe4lh1O2JCUJ9BRqjlB6szuuJL95yq2s079KvezcASS4MeLC0IDLBp1KIJP3O3CaJNMdzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so2751618a12.3;
        Thu, 12 Jun 2025 09:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749747008; x=1750351808;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0Tmty3UQpCA8vJk36D3Bw0wv8HVcit3KWDw+f7inaU=;
        b=SOPg0e1UfetrzfV6zOU3xZg+4d6HyoEr4744e4MhvWWV0+rUGo4cxoSGU6coH2jkQ8
         Xm9fSI9QiBub5M0a4hiDuxv6Jz7XVzUA64VdUJVUQwr10ZyByIjcR93UOc8H3jsQk8AQ
         SStC6i46z835ECkeYVLJwSi2erUpirr3DVGYfRZmrVflqJFg+BRcj6ug2/Bp1sxkdUVm
         pmwFxhwjm+10G/C+oD7RPhCgj4MXMA9eurFAgtCJUbXy9QSk+PPZzgK2KLQ44ZaD6eJd
         TVGuvmICBtCwAXYRTWPi1FYSXpvCrqkmOCZBKfzAON5XJfOSV18zuxhqAvxjuAPzk1DS
         lrUg==
X-Forwarded-Encrypted: i=1; AJvYcCWwhcXyFqcWK0AVgtgSKboMqdSZBVHNbhsfSZguUb4XlQyMjjZYu8GP5UhJWdxHvKViqGGGpMmVB9JSTQkq96A=@vger.kernel.org, AJvYcCXigGnM9aMgox56zmySk+cOJ753zYCpIzspi4B3RIn41HOIZSXrLRzuQvJ3XGSJEjXNL+89hJns@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwDCXBplJUrIM9Atmt2nxDQup7WZjtwcGn1L6cDPiMeben14I
	bp5BMPPdIepMPDvZjQYvPU818SlbOU9JvhNTA6NCbxLCzxPaA4CKU2rd
X-Gm-Gg: ASbGnctYxd9E61Ibha+TT/lKpQ1ME+o1rG/WAhmt7TukhiZVfGklBFZktSenqt1AuVD
	Dl4NOLslj1CN/Ne1vPyHVfqzXYsseUZrcOJ86kdAMROhiuL7VK39znL2YQ/DctuMVXquDR0XNK/
	Zvw75lNFxrkmRowdqujGiXTsiT3QHRdpgFtrMhnb/36V5j/xwKmajU8xpij0JZFXIe5D4zHM94G
	Py4tbwAziIlrwbJ9e4x9hM+JAM8P17DDm32WJSGFbW8Ci7c2iXEnzEtV1UZL3JdQRVGIg87Hax9
	YxG9Vu7btbUTdWHP5psuw8j+E5ZdXxJfC4dQi4RLBSolKgRBFPek
X-Google-Smtp-Source: AGHT+IF3LMtcpwL937VNeRzfLL2J/62DAotrhEamawLJ2wUL4RZRoPr+Wfa7mtS4oOtpeIIgCo5Ccw==
X-Received: by 2002:a05:6402:3508:b0:608:3f9c:c69d with SMTP id 4fb4d7f45d1cf-608af85f18amr578482a12.33.1749747007294;
        Thu, 12 Jun 2025 09:50:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6086b1e249csm1411746a12.46.2025.06.12.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 09:50:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 12 Jun 2025 09:49:56 -0700
Subject: [PATCH net-next RFC] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
X-B4-Tracking: v=1; b=H4sIADMFS2gC/x3MQQrCQAwF0KuEv+7ATLQqsxV6ALciUtqogZKWm
 SCF0rsLvgO8DVWKSkWmDUW+WnU2ZEoNYfj09pagIzKBI7fxlDiY+DJP09OleujTgY8jx/Y8XNA
 QliIvXf/dHSYeTFanW3fFY99/47FqvGwAAAA=
X-Change-ID: 20250612-netpoll_test-a1324d2057c8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, ast@kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=9422; i=leitao@debian.org;
 h=from:subject:message-id; bh=y1pnc0K21RY6sKl7h4y4645XMHvqTAhb0rymQLHBub8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSwU9YX/FVcLUgswPPDuwuLa/agmYv4sW7k788
 i8cF/aSFL+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEsFPQAKCRA1o5Of/Hh3
 bdiGD/490fqDHJcwV6abFPs07jhgjyKiID36VuOD0Ib3bH3ddzsKxeyR8S+pbYEtysMYYqttCAO
 ozbto3ACBsOx59fHhq79m53gOu4DGpyUmvwh/tFZMErabNOKyYprdM6yOsCQll2FvB3KsVnWKw8
 SpDlx5RqlUrtIw6ohJrDmiV7L92liInnU5AXubLfny4KIoBjimqFR+Mlm+dqVDsl/O232oYuBFK
 73gijC4yyyOLXNyhp4mZ27hdmW1ylENk/jyslpEaYlqe4cdkAlB7UQtYHld+CUVXHuxTY7SjTNf
 lbrmhxbSXqR7eUVzHmqBxptR8UXy2JtamTJYs/4Vn/K2uWcIkY7GOLvdqz1j4UfoiucZyrYnsnn
 pgYecP0T7frDi484i7M4KJ/2SyHUgzoZ4XBWTAj5lnlwGsIcBBGUUBquMdYL13SmepXMLGIY3Fh
 /vrol3QzOuQsCok5EmsZL79/bmZO/yvtVaUiIOKtsY0hcH2fLY3q3SUxMwwwylTF8lT6Ddbeez+
 kbYW+5ikLHP496MD+N7nYcr1YhGHzQ6u9i5+f4uR8IGCei/KX7va9q0LyTJlF6auw5503WFlySB
 xcV1TF5l8aEga6KSdTjSzKRHIqngM5SK1AcKoTkxCj2AmAwXd+NSom2KR13x3FfVyM7YYR5inKx
 kmONqduiXVuhkQw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a basic selftest for the netpoll polling mechanism, specifically
targeting the netpoll poll() side.

The test creates a scenario where network transmission is running at
maximum sppend, and netpoll needs to poll the NIC. This is achieved by:

  1. Configuring a single RX/TX queue to create contention
  2. Generating background traffic to saturate the interface
  3. Sending netconsole messages to trigger netpoll polling
  4. Using dynamic netconsole targets via configfs

The test validates a critical netpoll code path by monitoring traffic
flow and ensuring netpoll_poll_dev() is called when the normal TX path
is blocked. Perf probing confirms this test successfully triggers
netpoll_poll_dev() in typical test runs.

This addresses a gap in netpoll test coverage for a path that is
tricky for the network stack.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Sending as an RFC for your appreciation, but it dpends on [1] which is
stil under review. Once [1] lands, I will send this officially.

Link: https://lore.kernel.org/all/20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org/ [1]
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/netpoll_basic.py | 201 +++++++++++++++++++++
 2 files changed, 202 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index be780bcb73a3b..70d6e3a920b7f 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS := \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
+	netpoll_basic.py \
 	ping.py \
 	queues.py \
 	stats.py \
diff --git a/tools/testing/selftests/drivers/net/netpoll_basic.py b/tools/testing/selftests/drivers/net/netpoll_basic.py
new file mode 100755
index 0000000000000..8abdfb2b1eb6e
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
@@ -0,0 +1,201 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# This test aims to evaluate the netpoll polling mechanism (as in netpoll_poll_dev()).
+# It presents a complex scenario where the network attempts to send a packet but fails,
+# prompting it to poll the NIC from within the netpoll TX side.
+#
+# This has been a crucial path in netpoll that was previously untested. Jakub
+# suggested using a single RX/TX queue, pushing traffic to the NIC, and then sending
+# netpoll messages (via netconsole) to trigger the poll. `perf` probing of netpoll_poll_dev()
+# showed that this test indeed triggers netpoll_poll_dev() once or twice in 10 iterations.
+
+# Author: Breno Leitao <leitao@debian.org>
+
+import errno
+import os
+import random
+import string
+import time
+
+from lib.py import (
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
+NETCONSOLE_CONFIGFS_PATH = "/sys/kernel/config/netconsole"
+REMOTE_PORT = 6666
+LOCAL_PORT = 1514
+# Number of netcons messages to send. I usually see netpoll_poll_dev()
+# being called at least once in 10 iterations.
+ITERATIONS = 10
+DEBUG = False
+
+
+def generate_random_netcons_name() -> str:
+    """Generate a random name starting with 'netcons'"""
+    random_suffix = "".join(random.choices(string.ascii_lowercase + string.digits, k=8))
+    return f"netcons_{random_suffix}"
+
+
+def get_stats(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> dict[str, int]:
+    """Get the statistics for the interface"""
+    return netdevnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+
+
+def set_single_rx_tx_queue(interface_name: str) -> None:
+    """Set the number of RX and TX queues to 1 using ethtool"""
+    try:
+        # This don't need to be reverted, since interfaces will be deleted after test
+        ethtool(f"-G {interface_name} rx 1 tx 1")
+    except Exception as e:
+        raise KsftSkipEx(
+            f"Failed to configure RX/TX queues: {e}. Ethtool not available?"
+        )
+
+
+def create_netconsole_target(
+    config_data: dict[str, str],
+    target_name: str,
+) -> None:
+    """Create a netconsole dynamic target against the interfaces"""
+    ksft_pr(f"Using netconsole name: {target_name}")
+    try:
+        ksft_pr(f"Created target directory: {NETCONSOLE_CONFIGFS_PATH}/{target_name}")
+        os.makedirs(f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}", exist_ok=True)
+    except OSError as e:
+        if e.errno != errno.EEXIST:
+            raise KsftFailEx(f"Failed to create netconsole target directory: {e}")
+
+    try:
+        for key, value in config_data.items():
+            if DEBUG:
+                ksft_pr(f"Setting {key} to {value}")
+            with open(
+                f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{key}",
+                "w",
+                encoding="utf-8",
+            ) as f:
+                # Always convert to string to write to file
+                f.write(str(value))
+                f.close()
+
+        if DEBUG:
+            # Read all configuration values for debugging
+            for debug_key in config_data.keys():
+                with open(
+                    f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{debug_key}",
+                    "r",
+                    encoding="utf-8",
+                ) as f:
+                    content = f.read()
+                    ksft_pr(
+                        f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{debug_key} {content}"
+                    )
+
+    except Exception as e:
+        raise KsftFailEx(f"Failed to configure netconsole target: {e}")
+
+
+def set_netconsole(cfg: NetDrvEpEnv, interface_name: str, target_name: str) -> None:
+    """Configure netconsole on the interface with the given target name"""
+    config_data = {
+        "extended": "1",
+        "dev_name": interface_name,
+        "local_port": LOCAL_PORT,
+        "remote_port": REMOTE_PORT,
+        "local_ip": cfg.addr_v["4"] if cfg.addr_ipver == "4" else cfg.addr_v["6"],
+        "remote_ip": (
+            cfg.remote_addr_v["4"] if cfg.addr_ipver == "4" else cfg.remote_addr_v["6"]
+        ),
+        "remote_mac": "00:00:00:00:00:00",  # Not important for this test
+        "enabled": "1",
+    }
+
+    create_netconsole_target(config_data, target_name)
+    ksft_pr(f"Created netconsole target: {target_name} on interface {interface_name}")
+
+
+def delete_netconsole_target(name: str) -> None:
+    """Delete a netconsole dynamic target"""
+    target_path = f"{NETCONSOLE_CONFIGFS_PATH}/{name}"
+    try:
+        if os.path.exists(target_path):
+            os.rmdir(target_path)
+    except OSError as e:
+        raise KsftFailEx(f"Failed to delete netconsole target: {e}")
+
+
+def check_traffic_flowing(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> int:
+    """Check if traffic is flowing on the interface"""
+    stat1 = get_stats(cfg, netdevnl)
+    time.sleep(1)
+    stat2 = get_stats(cfg, netdevnl)
+    pkts_per_sec = stat2["rx-packets"] - stat1["rx-packets"]
+    # Just make sure this will not fail even in slow/debug kernels
+    if pkts_per_sec < 10:
+        raise KsftFailEx(f"Traffic seems low: {pkts_per_sec}")
+    if DEBUG:
+        ksft_pr(f"Traffic per second {pkts_per_sec} ", pkts_per_sec)
+
+    return pkts_per_sec
+
+
+def do_netpoll_flush(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> None:
+    """Print messages to the console, trying to trigger a netpoll poll"""
+    for i in range(int(ITERATIONS)):
+        pkts_per_s = check_traffic_flowing(cfg, netdevnl)
+        with open("/dev/kmsg", "w", encoding="utf-8") as kmsg:
+            kmsg.write(f"netcons test #{i}: ({pkts_per_s} packets/s)\n")
+
+
+def test_netpoll(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> None:
+    """Test netpoll by sending traffic to the interface and then sending netconsole messages to trigger a poll"""
+    target_name = generate_random_netcons_name()
+    ifname = cfg.dev["ifname"]
+    traffic = None
+
+    try:
+        set_single_rx_tx_queue(ifname)
+        traffic = GenerateTraffic(cfg)
+        check_traffic_flowing(cfg, netdevnl)
+        set_netconsole(cfg, ifname, target_name)
+        do_netpoll_flush(cfg, netdevnl)
+    finally:
+        if traffic:
+            traffic.stop()
+        delete_netconsole_target(target_name)
+
+
+def check_dependencies() -> None:
+    """Check if the dependencies are met"""
+    if not os.path.exists(NETCONSOLE_CONFIGFS_PATH):
+        raise KsftSkipEx(
+            f"Directory {NETCONSOLE_CONFIGFS_PATH} does not exist. CONFIG_NETCONSOLE_DYNAMIC might not be set."
+        )
+
+
+def main() -> None:
+    """Main function to run the test"""
+    check_dependencies()
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

---
base-commit: 5d6d67c4cb10a4b4d3ae35758d5eeed6239afdc8
change-id: 20250612-netpoll_test-a1324d2057c8

Best regards,
-- 
Breno Leitao <leitao@debian.org>


