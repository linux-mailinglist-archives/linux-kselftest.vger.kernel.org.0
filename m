Return-Path: <linux-kselftest+bounces-24377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB55A0BA0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397171881644
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DE5284A4B;
	Mon, 13 Jan 2025 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdhV9hqD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44622DFB1;
	Mon, 13 Jan 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779156; cv=none; b=sBNJGu8C+OFoEtVvyJ7hsQ0etH12VvX+5ykHpHNvcjxqQK4ceJhkBHYtwR4LbLHqWUBpQKQ9nxtwWMvMWMZwBm49UwFj8Vwwe6y1EfH9WKtxjrCW6eWZXOAcz53D2Ctv9NdiNvCgJDjQ6V0/5iCM4Vh1y/0tW3cC+n4mpPwwe54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779156; c=relaxed/simple;
	bh=0G+WJHelzbbjtgv/Zbgactw+yzF4V+X8MJldF12Uf7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOLWsJS5luNWaQ+/zuM/zTvfqBrZuPwxp5NB/Lrr4Ayks0T6L4MlWQh8bm1D7YCaxHP/MEem8HuToVskqs/rUEsWUg7gYFFaepO9cKzGReRsFE2Yz7nGG9HZxnm41LZAmdmmecRefsJqxIDcEcp966o6LFN93uCL3HJCUbu/VP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdhV9hqD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21644aca3a0so95936325ad.3;
        Mon, 13 Jan 2025 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779153; x=1737383953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0TVXDX/Oq9IB0mhgmi61TXIFVtPNPu1PWKjPd5bzuM=;
        b=mdhV9hqDkGVkVHMv0B5JnL14GjXjp3LSB6fFUzLsJUGCasBB8mLgesFEOKv28jfDQd
         Dzv9tytKyUQmeNmr0+wcbcXOgQNMFfYqZUI5zSj9chuix98ydumZFVItYR7h3Smk8JY6
         qy9WYM4CWnIklxZUKa2JhV5aXokm3Al7xOQSm7mWYdVmiVV+1TJqPaoICAo+SL/hCtu0
         CxxPKId7EHV4QmxfhygiXApf3kS57jsAH/+Sd0XgB2iliWc223bWim26um12wtE/LfMD
         w+VpxgfWK0BuRYPqQC8P0mCE8sevD/v8WCBPHiUMxbyMtMZNi945f2zAWPCU0dClTA+z
         5OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779153; x=1737383953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0TVXDX/Oq9IB0mhgmi61TXIFVtPNPu1PWKjPd5bzuM=;
        b=WiuFY5ERx4fZpmkVLLqT3P0vHJpVZTD4HhV2mAT1D0QBAnwulvqAvaNRcn64O5blyc
         hDj4RpT+Plp04Pu7UlmXy4MjtAGn2kNUQ61hmsC/OCSzVaA4s5Ze1zVwqwn5qvfsgWpr
         Pfr78T+22PAEgiES06BHBq9kn31SQTsW7eVc8hshLjM0qcpJDgoGEu6NpGdTdFMpU5Zz
         D7MVUMDRqz63KPY1fgKYHlrduGQiLzSYH08AUovaad12NMUc7EQcHF2plZ0ltC3c+d0v
         5p7Nz9b1ZICM4g6+cjkFfwU/c+izLfUAGhSLB8/1nqZV7jB5nwJx0ya24+p9abalJ2d0
         HuNA==
X-Forwarded-Encrypted: i=1; AJvYcCUFLHbYOydfU9es94NceemO6MeaBLSuau8MGS8Q5YQESD11JXXOC6rSc+YvLCR3Sm/AtRsdSlk2ET7xLVFg@vger.kernel.org, AJvYcCUH1F2mkybZW4CxDUuGB3TjgjLWxQydaIAE9tOJaQOi7MkoP/SfNHUdxjdW4qpAQUVoGNoa+FGzyN/GUKDUC/4D@vger.kernel.org, AJvYcCWTd2MAO6ANCPBs8qvzHuKtQr7/4ogS81msGHChhwaaOHylmBnmZEfpzWj/C2B3Wto1KaHxpg6R1mv90w==@vger.kernel.org, AJvYcCWjqDRNJI/jmkdmeioMn0CMfVjTK0VRKBw6M//Z3e7KCOGNSoK7rJiRJvIhJLX+FS4hekz2ZHpKtPMf+Q==@vger.kernel.org, AJvYcCWtBh8hPHYqbJoqQIYIihjXOAyYSagAbJi018tUytgJ7p/OowWk5/IwCB84dXwLc0vdo7Aw1uGolxVcuC44rE4=@vger.kernel.org, AJvYcCX/B+yT7GmPsoczL3aqi1Ex3PWFXFf2fwhq0bQr9Ju83Cme6A1xfCrGJsjdfbl4JhOGr4U67PP41/T+@vger.kernel.org, AJvYcCXGoICj+Ow8nY1RV5ZEW8Ggph/NaOfyzM7/vU//PECyYsVQnZIZ/FLkNup8ASnFgz7cdPCzfdCMSLy/@vger.kernel.org, AJvYcCXHOCpOX4LkVkZd5kinYzLin1oVXQ0qV5luP8ZG8OoSBCU0QLSE5VkZEBxMETIKIrOTGOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpaCXHld9uVlEVWr3bQ3IJQ4VPT89um+69Bp60rvdb1FGnt1J
	A/LqcgXWNaulD7HtHYQnzs/aYAYG83MQONpWAhkwBKdmTun6Ax1ojdA0tyVvWqw=
X-Gm-Gg: ASbGncuuf7feJL582A2xBsiBfUhssO5EqfS1JSB43mvXNmmx5ZE2+FugdrD+meMcQy0
	33I/DELTcM7BVkf37+aQxv9+BqRj2JU3OJUY6JhCzGjyfDWPvV8irsFxYCT60fQmyU+E8bDA9ra
	vlNzm+eqjvcN7it1Hxz9q53DPLxrfNgFSWfJvXCLf9PCehp/DfP3Mw5peDu/iWVk0CTkhJDix8V
	kotEJlHrksrYu7h3Sa+jyQNyZBqRrI7UO0oddpCDHCTBzg=
X-Google-Smtp-Source: AGHT+IFt4cEJz+p42bYm31EfJt3Zb0JLb+qW+6vXHsT58zE4AWUF4ed/u79zsBlznytyW2KBQMyVfw==
X-Received: by 2002:a17:902:d511:b0:215:6489:cfbf with SMTP id d9443c01a7336-21a83f48cc0mr313835205ad.11.1736779153175;
        Mon, 13 Jan 2025 06:39:13 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:39:12 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH net-next v8 11/11] selftests: net: Add test cases for link and peer netns
Date: Mon, 13 Jan 2025 22:37:19 +0800
Message-ID: <20250113143719.7948-12-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
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


