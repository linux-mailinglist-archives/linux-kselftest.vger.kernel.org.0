Return-Path: <linux-kselftest+bounces-35420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952EEAE17CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 11:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC316A3BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B4A283FEE;
	Fri, 20 Jun 2025 09:38:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154E280A5A;
	Fri, 20 Jun 2025 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412323; cv=none; b=Ow8Kkw3Y6Yq4mfztG7pDSyqazHAkJtKw4hxmEmToupdlqUlQFrQbc07negB4yAq1vKWiCi0m374fNIUdh7poMAWv5ZgmDwM9B1wSYNWmQG6hufVJqwbYVhJlPrxh6nYZB8t6wsNHA0DruaZSwi4kt8T5ZVUK2FEIHCXSzSguwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412323; c=relaxed/simple;
	bh=WSlXw0/bOIG6mT81w9Z8EW/mjBZOHoPkLYZ3TW3VflA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jl0RktlNkVEpC/eG5hP9RAKJawy4PDY/zQSpwSNQEmrM31r4CN1rj26zGHaD4xGBtq08M396033ZSKjZZ9rAQvPvPUXracDKSgStTX8apahfskfgexDg3PNGVhKiU1LQiQ2oJ1tx9eg40W+6MwwQZcsbaZMvc7Pt4jspRoOyxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ade48b24c97so270087666b.2;
        Fri, 20 Jun 2025 02:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412319; x=1751017119;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xr3dINH6U6XhF2MbphhQXLOTE3yd3JTsZEXI/iXG/Bk=;
        b=uwf9cCjqBxzL+yaYc08MFJn/rv5Qw9MjZMx2UcPJl4pVtFXX5AXFx8H2hmb8fGnqpS
         Na3wDm06klJ0JsvdCtwzkYhqfAnE09Decw533IUbrerRl8u2FhcLxGrDIoFXhY/VgzyQ
         9PILImCstqeBuEG4jZI81jIS8cRlFe/huqbwxl1ROXErA/gsTXhYPC+25bPNNu/Y3Aoc
         4/W8a1co6OLnodhZp0Q4WbGjUV6w31sFcUKgWEZjmkMaOy1wUfPyjAXgnfZ7cFGAWfiC
         iPej8r7mrHGjwSvrXQM8ttHr5sq30wbzzEDyJQJp92XLc5qEKE03MZz/s2VC7qgRIAeg
         V3yg==
X-Forwarded-Encrypted: i=1; AJvYcCUfH6DerjOZtCjbjFFmbRaHX2oRPXirlsfhUz6MWVLnutf3/ZWSac2DrT0FsPPsXLWBXrxjQ8Sq@vger.kernel.org, AJvYcCW5JbKvAa7X6r5ui4ZmJGZJaUlv82ANvmB/wCHT+OmCAwOYSHaXZls2W51CkPL87c3HIRTDuNzZgdNKGlqVsPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmv94lJHLycQQZD+Dv5hvJ7Pk+yzWv0YvDCU6JgnDovaOTjlCU
	uuE+Ae+zfbNRB6ETHF5oWmT5k+fI/+s60i3IbXQmuQoPAdNApzhJqTYfPomOaQ==
X-Gm-Gg: ASbGncs0z/GI/d3XneS5nKzHq0/dsQVu/o9XWNAQrPABR3HM/H4XlkRDxvuTLGVMOnI
	5QZfVQIJI14EdA13gVgOJ9o6sAO6RvVRp2P8Rnx61MGY9qETOGklfZaNIom9iSDgrsOsG/dWioX
	Eu2H8bXhOpYRFqERLV3u4/leuH7xHsmWQJiIs3ikwBqHhltsHhbO17tiL5XixFRgY2ALKI+kvbE
	06Co/BI3klf/tOuLJQ12bZkCbzdc87WIin/PMIW1nF6xogEyrFxoau1I+4Y154AIGrSKtK0ouDV
	eGyjgvxIxGOOTZCsU1HrSd/JXKi9T6/VZDcWtiQoAKbUPzWAUSGILQ==
X-Google-Smtp-Source: AGHT+IFp7sK2lfL/U46VEqnX6czUADvPChgpES2TxJ1tI8Zud3mkIjd7GGew8GZVFAWCZsuI4cXR/Q==
X-Received: by 2002:a17:907:9404:b0:ade:4593:d7cd with SMTP id a640c23a62f3a-ae0579bc240mr218208566b.13.1750412318857;
        Fri, 20 Jun 2025 02:38:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209ad2sm135111166b.148.2025.06.20.02.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 02:38:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 20 Jun 2025 02:38:31 -0700
Subject: [PATCH net-next] selftests: net: add netpoll basic functionality
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-netpoll_test-v1-1-5068832f72fc@debian.org>
X-B4-Tracking: v=1; b=H4sIABcsVWgC/23NQQqDMBRF0a2ENzbFxKRWR91HkWLNVz9IIkkQi
 7j3guOOL5x7IFFkSmjFgUgbJw4erVCFwDD3fiLJDq2ALrUt70pLT3kNy/LOlLLsVaWN06Wthwc
 KgTXSyPvFveApS097RlcIzJxyiN/rs6mr/yc3JZU0dW1G19imqsanow/3/hbihO48zx+4KNK/s
 wAAAA==
X-Change-ID: 20250612-netpoll_test-a1324d2057c8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, gustavold@gmail.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=10258; i=leitao@debian.org;
 h=from:subject:message-id; bh=WSlXw0/bOIG6mT81w9Z8EW/mjBZOHoPkLYZ3TW3VflA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoVSwdm1Gy7bW7UHuGDg8GObI8K+9SmrmE0rsBz
 ryQ8pETyZaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFUsHQAKCRA1o5Of/Hh3
 bXM3D/93rQlEixpiUNMGYeZaL13ulABHViIOkFFC6CwEoW8hE++lY8Yft5/2X6YPAD8mVV4vXbU
 yw4iUgfiTzxQ3rMpPM3msc6zlqjlp8KLr/b2k5pRZMCu5YQwBMARpp3BAA8kSOGjboWauvpQCg7
 Bml80j2g6sPnDXYEPaWTLSlxFOIzN5wstB6FUeIhNdSqIdscPxsCoueuxi1Z5r4jXu65Whr2YJl
 vgxNBb+GR8FuO7gkOiDAECyjFYQO/VS4bWrpvMEtHX+VCfA+hXCFcjseGFl6/xIfw+VYk4o8iGN
 mbGKvhlFmot4NlLpNJAcNAPsyEg3cFpXkUlHU0w5Is26njPqK6k2+zTw88M/LM3ZuDPUUPbs9IM
 UBZFhN8yAZ+vK8XW1bD0aj1SWEO2Zov8CCbfY2zDyv9c9Xn650TDS1mGNAOBdW/ivAkROdSUbFD
 8KMiqBTtS/YvNuIdCDmLZDwMuyUBmJvyEkU1OvW00tGfaTQM+BTcpvfr/2W4tjejBA0pGkohgv/
 HfLRePovpXCuHKIvpwYscGnNvJieKm7FSpcStNeHCh9RxvFfxrBKRiXP0zUrWn9JE+lsHjB1Fr1
 ZCOV29ZmuJuhU7xKX7TEYwsH8kT7iQqWf0V35dk4rnuGEvp4uz5vFj5Cyx2DvJIgBc1W9wKRO6V
 8p4YjKZx+J3Oblg==
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
  5. Delete and create new netconsole targets after 5 iterations

The test validates a critical netpoll code path by monitoring traffic
flow and ensuring netpoll_poll_dev() is called when the normal TX path
is blocked. Perf probing confirms this test successfully triggers
netpoll_poll_dev() in typical test runs.

This addresses a gap in netpoll test coverage for a path that is
tricky for the network stack.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes since RFC:
- Toggle the netconsole interfaces up and down after 5 iterations.
- Moved the traffic check under DEBUG (Willem de Bruijn).
- Bumped the iterations to 20 given it runs faster now.
- Link to the RFC: https://lore.kernel.org/r/20250612-netpoll_test-v1-1-4774fd95933f@debian.org
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/netpoll_basic.py | 231 +++++++++++++++++++++
 2 files changed, 232 insertions(+)

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
index 0000000000000..2a81926169262
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
@@ -0,0 +1,231 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# This test aims to evaluate the netpoll polling mechanism (as in
+# netpoll_poll_dev()). It presents a complex scenario where the network
+# attempts to send a packet but fails, prompting it to poll the NIC from within
+# the netpoll TX side.
+#
+# This has been a crucial path in netpoll that was previously untested. Jakub
+# suggested using a single RX/TX queue, pushing traffic to the NIC, and then
+# sending netpoll messages (via netconsole) to trigger the poll. `perf` probing
+# of netpoll_poll_dev() showed that this test indeed triggers
+# netpoll_poll_dev() once or twice in 10 iterations.
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
+# being called at least once in 10 iterations. Having 20 to have some buffers
+ITERATIONS = 20
+DEBUG = False
+
+
+def generate_random_netcons_name() -> str:
+    """Generate a random target name starting with 'netcons'"""
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
+        os.makedirs(f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}", exist_ok=True)
+        ksft_pr(f"Created target directory: {NETCONSOLE_CONFIGFS_PATH}/{target_name}")
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
+        ksft_pr(f"Traffic per second {pkts_per_sec}")
+
+    return pkts_per_sec
+
+
+def do_netpoll_flush(
+    cfg: NetDrvEpEnv, netdevnl: NetdevFamily, ifname: str, target_name: str
+) -> None:
+    """Print messages to the console, trying to trigger a netpoll poll"""
+
+    set_netconsole(cfg, ifname, target_name)
+    for i in range(int(ITERATIONS)):
+        msg = f"netcons test #{i}."
+
+        if DEBUG:
+            pkts_per_s = check_traffic_flowing(cfg, netdevnl)
+            msg += f" ({pkts_per_s} packets/s)"
+
+        with open("/dev/kmsg", "w", encoding="utf-8") as kmsg:
+            kmsg.write(msg)
+
+        if not i % 5:
+            # Every 5 iterations, toggle netconsole
+            delete_netconsole_target(target_name)
+            set_netconsole(cfg, ifname, target_name)
+
+
+def test_netpoll(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> None:
+    """
+    Test netpoll by sending traffic to the interface and then sending
+    netconsole messages to trigger a poll
+    """
+
+    target_name = generate_random_netcons_name()
+    ifname = cfg.dev["ifname"]
+    traffic = None
+
+    try:
+        set_single_rx_tx_queue(ifname)
+        traffic = GenerateTraffic(cfg)
+        check_traffic_flowing(cfg, netdevnl)
+        do_netpoll_flush(cfg, netdevnl, ifname, target_name)
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
+def load_netconsole_module() -> None:
+    """Try to load the netconsole module"""
+    try:
+        os.system("modprobe netconsole")
+    except Exception:
+        # It is fine if we fail to load the module, it will fail later
+        # at check_dependencies()
+        pass
+
+
+def main() -> None:
+    """Main function to run the test"""
+    load_netconsole_module()
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
base-commit: 4f4040ea5d3e4bebebbef9379f88085c8b99221c
change-id: 20250612-netpoll_test-a1324d2057c8

Best regards,
--  
Breno Leitao <leitao@debian.org>


