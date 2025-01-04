Return-Path: <linux-kselftest+bounces-23912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E08A014DD
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 14:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C14B18839A4
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFBD1D5176;
	Sat,  4 Jan 2025 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvczOAyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13621C3033;
	Sat,  4 Jan 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995558; cv=none; b=GRs1OH0ykLKWsx2Qf3q7lCXG2QQOUYDoQWllgK+Bh3LrsgVPldgRw6vY6kWgxOQVSx+f9/Ai+Quju6Uqrtn/aqIaeEOk6tjtP7UQatNtA4veY/bp2yYivzB+zBJ0wxWhkABhQ3shTi8IaK/qXr7CQMFp4iliUbS/r+fpJlOhLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995558; c=relaxed/simple;
	bh=0G+WJHelzbbjtgv/Zbgactw+yzF4V+X8MJldF12Uf7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdjA00VjUwXBn4ELMksrPWmPw0wggMvhnXG/G/XkIxnpf25njeZRVh1Ge5bGsypyQZyHzMQrCluswAohjfljHZyTOPIzRf16InmfeDr96+MGLPerDfxBaYS8ecm4KmgQdPy3+dDe4MnG1IU+l2WHZubD5NYlnAq4kmDW7+XP/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvczOAyZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21680814d42so156003385ad.2;
        Sat, 04 Jan 2025 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995555; x=1736600355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0TVXDX/Oq9IB0mhgmi61TXIFVtPNPu1PWKjPd5bzuM=;
        b=EvczOAyZtwqMmb2Id3htcmHkIeb2jtYmjTrmDvbDnY5/UDsfbVMnmGjpVCMYI121K5
         DvWLRNrXSQsCdwMTpNpDNIjoGaWAQCXSj2VxLQOYBVSl4BBn3FJRC5Oh19Xos/Kh2ZLL
         OpTZmp9EMIVM9N6Jw+9PN9Nun8oaFAJvMtJxiEZP2yXpEFpELiQevq6Xz5wfveEwXQ+c
         eMw4UuauR/ccZEFKl7+lVYvfX+sHTN/I/NhFuIXmVuRoECIsFJWzfFKZNpM11SAIfF7m
         QklAEspdKofle0ohEnJ5XEgEtVBqUyWICWd3QHLdTPC5MjhhC3x0I61f/EoQhm9cUGxq
         jqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995555; x=1736600355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0TVXDX/Oq9IB0mhgmi61TXIFVtPNPu1PWKjPd5bzuM=;
        b=Ike5tNutahEdrzFzMiTsV1uyypScXWbMbQVA5UNQuYkI/ZmPy344KFcY5nZtZgfMgf
         cAD0TFQO3/v2s5fH0rXVbjnhtzHDIbbINKdVyrvIwQ18aQzCvD3NKKWlKyQY1U0IeRl5
         LNNcDMOJnpYdeFZo4wOqO4iqdoCXOBEuGW3uzJw1O3NCdR/0AaA8Re/7PHiv6bLqhgIG
         jp4/nltzhgZ2se4p5j0O9Lj1wsulU54nIJWdTXkJMrAU6hsdmeK9VuT0DFO0ybEPuH7f
         3b0DlUL80TM6FT1aIg9YH87PdiHq4GnbLxYl+GI3qIN6H7aP0rqjWz2auEHkAbmVMHjw
         9DAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdm0FDJI6bixrVjZ+wgKPepNKtctZcVVbHyHeUz8HtS+d4l98HS3YYHydv6T0il50xH9IlYEHUXqWs@vger.kernel.org, AJvYcCV0IA0b6av8AiE6iYv6fuGmRL4DLcwwLxmEDpW2BS6S3bAgkEvA2TKDcpZX0tb59UCxF7hiV/iewHpmPw==@vger.kernel.org, AJvYcCVKvHfLcyo9a2LSPW3R3wdst7Df4u9qa2w69eTCrhKSOxjtI/7fMdkkBq4WPeQl5RkY9WrbMDlyNS6JDGjE7+dj@vger.kernel.org, AJvYcCVe1DczSD2T6B2NoS0BWQmvM40jf6ymhAQGmHwcfkH0Ii9xHE/2LaW16ai4AYGUxJQHQFB5Uw/kO/asLg==@vger.kernel.org, AJvYcCVxlgjpKH5+2L1Bg+uYhtdX7zhCd3LMOtzZT9HzH39qr5w3fHge6/7bfziRQ+7aUWDKY6Xw5O4fF88g431b@vger.kernel.org, AJvYcCW93OuHeFJmsXPaYW96S2GQB6fGb42NKT+IN53KlpBCB2SL//WEgkf0/qilnZXz4ccLjQe2b7rsuId2vlbGmq8=@vger.kernel.org, AJvYcCWWa4WCAYMAujh2XX4c9UJNZzY6O8FCZrBE09xm3VKhanKY3wh3AYjw/93GTYJqy1RstGA=@vger.kernel.org, AJvYcCXyCCQtCq+71SAPfegpsOeTV9GtULMhsCTh0VGaXsil5ue6EuB7vtvz8LvYBslTLIQtRyjaRhlS63Li@vger.kernel.org
X-Gm-Message-State: AOJu0YxYkGFcq3nx6BNc9s4RVJuIFH6QKAk6hnUj7LpJFBaxHG955lPW
	rQoJRkT774HLRUr4zpTTFoZ1vMgEffRvhCNZwi0wqtjwHpqJkHl+/IKhjQIi0T0=
X-Gm-Gg: ASbGnctxIrgYuE7M6PUJ2XTmnR1DJQwmwbiKvPb7KdjiZyyOpit/5eJPRW5uqYATKK9
	BI/GdgaOdt3cs7LDVcQ/F/9VhiJNN+RTe50NkmOxYZ7CRaMCe0QhkEmGDc1oQy2U75BcYCqa0zh
	Fcrixkog3NOqy9k+VcFXi/LLRr2CBF39FMPyKMcbRHszxl1gXHBhDRx36j5RBov6E7wgNcvJna6
	6uz/K9lD2Pi+9k1ml11krJh9kjcmqIxdkv3ZDaJGjPupME=
X-Google-Smtp-Source: AGHT+IEUXpwO+l/hEGdKf9OR2BDjiiFxnC7t4NGPTcXQ7io7HhNpF9KYbA9KthQzQ0Wr8hVvBSWkSg==
X-Received: by 2002:a05:6a21:1519:b0:1e1:cdff:5f18 with SMTP id adf61e73a8af0-1e5e044ef7fmr72396060637.4.1735995555179;
        Sat, 04 Jan 2025 04:59:15 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:59:14 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 11/11] selftests: net: Add test cases for link and peer netns
Date: Sat,  4 Jan 2025 20:57:32 +0800
Message-ID: <20250104125732.17335-12-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Add test for creating link in another netns when a link of the same
   name and ifindex exists in current netns.
 - Add test to verify that link is created in target netns directly -
   no link new/del events should be generated in link netns or current
   netns.
 - Add test cases to verify that link-netns is set as expected for
   various drivers and combination of namespace-related parameters.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/config        |   5 +
 tools/testing/selftests/net/link_netns.py | 141 ++++++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh |  10 ++
 4 files changed, 157 insertions(+)
 create mode 100755 tools/testing/selftests/net/link_netns.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 73ee88d6b043..df07a38f884f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -35,6 +35,7 @@ TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
+TEST_PROGS += link_netns.py
 TEST_PROGS += nl_netdev.py
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 5b9baf708950..ab55270669ec 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -107,3 +107,8 @@ CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
+CONFIG_IPVLAN=m
+CONFIG_CAN=m
+CONFIG_CAN_DEV=m
+CONFIG_CAN_VXCAN=m
+CONFIG_NETKIT=y
diff --git a/tools/testing/selftests/net/link_netns.py b/tools/testing/selftests/net/link_netns.py
new file mode 100755
index 000000000000..aab043c59d69
--- /dev/null
+++ b/tools/testing/selftests/net/link_netns.py
@@ -0,0 +1,141 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import time
+
+from lib.py import ksft_run, ksft_exit, ksft_true
+from lib.py import ip
+from lib.py import NetNS, NetNSEnter
+from lib.py import RtnlFamily
+
+
+LINK_NETNSID = 100
+
+
+def test_event() -> None:
+    with NetNS() as ns1, NetNS() as ns2:
+        with NetNSEnter(str(ns2)):
+            rtnl = RtnlFamily()
+
+        rtnl.ntf_subscribe("rtnlgrp-link")
+
+        ip(f"netns set {ns2} {LINK_NETNSID}", ns=str(ns1))
+        ip(f"link add netns {ns1} link-netnsid {LINK_NETNSID} dummy1 type dummy")
+        ip(f"link add netns {ns1} dummy2 type dummy", ns=str(ns2))
+
+        ip("link del dummy1", ns=str(ns1))
+        ip("link del dummy2", ns=str(ns1))
+
+        time.sleep(1)
+        rtnl.check_ntf()
+        ksft_true(rtnl.async_msg_queue.empty(),
+                  "Received unexpected link notification")
+
+
+def validate_link_netns(netns, ifname, link_netnsid) -> bool:
+    link_info = ip(f"-d link show dev {ifname}", ns=netns, json=True)
+    if not link_info:
+        return False
+    return link_info[0].get("link_netnsid") == link_netnsid
+
+
+def test_link_net() -> None:
+    configs = [
+        # type, common args, type args, fallback to dev_net
+        ("ipvlan", "link dummy1", "", False),
+        ("macsec", "link dummy1", "", False),
+        ("macvlan", "link dummy1", "", False),
+        ("macvtap", "link dummy1", "", False),
+        ("vlan", "link dummy1", "id 100", False),
+        ("gre", "", "local 192.0.2.1", True),
+        ("vti", "", "local 192.0.2.1", True),
+        ("ipip", "", "local 192.0.2.1", True),
+        ("ip6gre", "", "local 2001:db8::1", True),
+        ("ip6tnl", "", "local 2001:db8::1", True),
+        ("vti6", "", "local 2001:db8::1", True),
+        ("sit", "", "local 192.0.2.1", True),
+        ("xfrm", "", "if_id 1", True),
+    ]
+
+    with NetNS() as ns1, NetNS() as ns2, NetNS() as ns3:
+        net1, net2, net3 = str(ns1), str(ns2), str(ns3)
+
+        # prepare link netnsid  and a dummy link needed by certain drivers
+        ip(f"netns set {net3} {LINK_NETNSID}", ns=str(net2))
+        ip("link add dummy1 type dummy", ns=net3)
+
+        cases = [
+            # source, "netns", "link-netns", expected link-netns
+            (net3, None, None, None, None),
+            (net3, net2, None, None, LINK_NETNSID),
+            (net2, None, net3, LINK_NETNSID, LINK_NETNSID),
+            (net1, net2, net3, LINK_NETNSID, LINK_NETNSID),
+        ]
+
+        for src_net, netns, link_netns, exp1, exp2 in cases:
+            tgt_net = netns or src_net
+            for typ, cargs, targs, fb_dev_net in configs:
+                cmd = "link add"
+                if netns:
+                    cmd += f" netns {netns}"
+                if link_netns:
+                    cmd += f" link-netns {link_netns}"
+                cmd += f" {cargs} foo type {typ} {targs}"
+                ip(cmd, ns=src_net)
+                if fb_dev_net:
+                    ksft_true(validate_link_netns(tgt_net, "foo", exp1),
+                              f"{typ} link_netns validation failed")
+                else:
+                    ksft_true(validate_link_netns(tgt_net, "foo", exp2),
+                              f"{typ} link_netns validation failed")
+                ip(f"link del foo", ns=tgt_net)
+
+
+def test_peer_net() -> None:
+    types = [
+        "vxcan",
+        "netkit",
+        "veth",
+    ]
+
+    with NetNS() as ns1, NetNS() as ns2, NetNS() as ns3, NetNS() as ns4:
+        net1, net2, net3, net4 = str(ns1), str(ns2), str(ns3), str(ns4)
+
+        ip(f"netns set {net3} {LINK_NETNSID}", ns=str(net2))
+
+        cases = [
+            # source, "netns", "link-netns", "peer netns", expected
+            (net1, None, None, None, None),
+            (net1, net2, None, None, None),
+            (net2, None, net3, None, LINK_NETNSID),
+            (net1, net2, net3, None, None),
+            (net2, None, None, net3, LINK_NETNSID),
+            (net1, net2, None, net3, LINK_NETNSID),
+            (net2, None, net2, net3, LINK_NETNSID),
+            (net1, net2, net4, net3, LINK_NETNSID),
+        ]
+
+        for src_net, netns, link_netns, peer_netns, exp in cases:
+            tgt_net = netns or src_net
+            for typ in types:
+                cmd = "link add"
+                if netns:
+                    cmd += f" netns {netns}"
+                if link_netns:
+                    cmd += f" link-netns {link_netns}"
+                cmd += f" foo type {typ}"
+                if peer_netns:
+                    cmd += f" peer netns {peer_netns}"
+                ip(cmd, ns=src_net)
+                ksft_true(validate_link_netns(tgt_net, "foo", exp),
+                          f"{typ} peer_netns validation failed")
+                ip(f"link del foo", ns=tgt_net)
+
+
+def main() -> None:
+    ksft_run([test_event, test_link_net, test_peer_net])
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
index 6974474c26f3..0be1905d1f2f 100755
--- a/tools/testing/selftests/net/netns-name.sh
+++ b/tools/testing/selftests/net/netns-name.sh
@@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &&
     fail "Can still find alt-name after move"
 ip -netns $test_ns link del $DEV || fail
 
+#
+# Test no conflict of the same name/ifindex in different netns
+#
+ip -netns $NS link add name $DEV index 100 type dummy || fail
+ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy ||
+    fail "Can create in netns without moving"
+ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found"
+ip -netns $NS link del $DEV || fail
+ip -netns $test_ns link del $DEV || fail
+
 echo -ne "$(basename $0) \t\t\t\t"
 if [ $RET_CODE -eq 0 ]; then
     echo "[  OK  ]"
-- 
2.47.1


