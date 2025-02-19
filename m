Return-Path: <linux-kselftest+bounces-26971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0759A3BF39
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 14:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C717A8A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6891EDA3B;
	Wed, 19 Feb 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4Zhxt4w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094891EDA1A;
	Wed, 19 Feb 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969573; cv=none; b=YHyqw72w0KYiMqtLgsyQTF/pGimH+gRIDU9G2bLkHKSyaH+87z8A4ak6/l1q3OoxR2PXY4Era4JpT9SMxuKQl7r8oJZgSYqrgFq4ohkAjWPEgVrd+76Vjw9OoZURiGl3+HBMnaxkBHzwkgIUD4x5rJECs9SC+Q3DErTqrRF9XJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969573; c=relaxed/simple;
	bh=jqz5blGUX5UncrsSac4ngco/AKqB1xIOiCjAuaEMTY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC9p6rrHOZP6U5EEm4Fdyom3DVFOBn3JndV+xApaj6ET9nH5ZLd6cvJkeFpsVMd08Ml0Ow9bATiDjL9pyr7U9rdRmvAAiw/UlS7XvGFF/knv+fWRJ0MENgSnOoBi/mmCJ+wOSC75WlDqigGwOdLHj3AxA6KrmyvOUOKi0UhZ7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4Zhxt4w; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8cf98bbso135197225ad.1;
        Wed, 19 Feb 2025 04:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969571; x=1740574371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx8bg1rA+gp6wNTCNpkIOzYNrMU90JwyPLUIFRVvz8E=;
        b=U4Zhxt4wkWLZNEUdriEmY4nt1U6QODPGEGdOWFd9SYyAS/nxTfidywYkZ6ubu3DG4+
         fxsNNL7dD2aK0EjlUsX6L/LFXNxuKAyahEASlZEzbscVVUnGXU97Q9nx7SM1CKXVxNuh
         qp0NFRZkXNgB9eNYubxXcpSK2IDla9H/bho2M81Dt7r5QM4IQ16sAf6HirYG5hFzQUxg
         3XgiCArjTeOFhXS1Kr0mgA6tmHGEt1t5GxQZxs4UN4sgHSfdUupBMD5X0n38rrds/TBy
         TVgXloxArrLyXw85Xlwqe8nEIPrwYnNAUmLKQ/0lg6wYNwMYwsUpzGYqmQLaLRbkhKP5
         xjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969571; x=1740574371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qx8bg1rA+gp6wNTCNpkIOzYNrMU90JwyPLUIFRVvz8E=;
        b=do/S6iYXwKn/lAiCEW9jhLeSnJ41LGKqFLz3uhNfP5h+lMx/lwJfhGrzWXzIo3Bgf+
         3Sc1o+r5vCAaXuAR8HDSFjuGhhk7Uwtk5t1dnyBCxBmQ9T3SjL/4aPjX8Y1pit2xpPpZ
         bZtJVpAcoyw0PCcU68AD4CFzku5gIOK43upSsMUElNv40SDl1LetcvtE35J24w6aJHOp
         uYsDl2tg3njcVZHHzBokMOT4l3CocGIwSUA4OY2hp43WlwD749NqMk8htsubbT9WuUqW
         A7xiRJdZx/Ks+wPkBUcG0pgxgKHCSoes9PjOWnaRtwUmqLV7HDdBVnrBQKaTkg1rYaO6
         Emqg==
X-Forwarded-Encrypted: i=1; AJvYcCUl4CSDdABPIYAP/mZBXAIZ9S+Ne6VZ7cwEuTJ7Xoc4Vj3WE0XRfCn7kbcdCOiFCGZLYJBjxSdCxBRv@vger.kernel.org, AJvYcCVg5ssw7cA5Y4/fYPCcT8jMvfAFCF+ne7zoeGrfjVj3Cc0oK9Zp9lks2k/0ErnL1trt3Puo/YkTROQFithgHExD@vger.kernel.org, AJvYcCVmCJ+TJCazkHIR1TNMvpRAPpkrTa1vcDeQ9PAiylf7sjLpt3POkfiCQie6XyaXo3D69oP6YhUSE4QSfA==@vger.kernel.org, AJvYcCVtaMhJlRGuZe1nY3lj3zQkxKBJq8sUfYnW1X64jFCSOeA+r3rf+7zWm5iop/ApBVZChPB4c/uV6bOmqw==@vger.kernel.org, AJvYcCWMQwUAelExnT2fjXH8vas4yuuZNjqqOfDMpZkWyXWoaJ3OOPsEHPeyuUGeORbMQCcqNXU=@vger.kernel.org, AJvYcCWYEuWdKNnLEq2CBvXkykJNu/TV48GCIjJpOM6gXPEFN6UDbCZfeiwLIz+xlbElz/YJWpX4CYHPZei3@vger.kernel.org, AJvYcCX9j6ndoyepFmcT2VLbLz5XlyXvLr5M493MNsT2Izm/1vZk27b1uwQXLiMiOFgWBSfKUHnWM1xAnvZxtC7T6W8=@vger.kernel.org, AJvYcCXQiX6EVq0pYLKEuooztkPIWwMinVspuRBY+VPA+ZCDUxP6ACMbmWuHK8X/XKGYqaKzxUEOTMolfV+4ZJId@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5R2C2JSYpTGvH3Oul56YBFuDCxBOHR5UpEqp5w1qZFUf30C7y
	Vwn26gm1J73ltiWcIAdr01qIqxsnku/+p5onmTUjJ7UM8xj2EsF8alW6YioT
X-Gm-Gg: ASbGnctoOTWBVPFFZYGKrvxQiBahIVCfLhX9XTZrpTR0l7CTKJPbHaeBhjRSBMGoZEt
	3cr0GvLuaWxYIXDGjF+fZbig9jG7/ewCUPc2XAfv0BeYkDFhW4khmnCWrWGR6l/IaVysUzrx0wm
	A74UWwrkicZkVCgxwmRck6MSsy/wLHAydNncAvyJe0VXvi6cyoXH8UKKF/kHWQygkklemlSNH2u
	hqb0NZ89HHFKKY3dtwUgx/l3o7g767tjmoEHtSvpNR6Cjub1JYJ79kptNT4Q9yzmw+T0PNbhwIU
	Yejx4g==
X-Google-Smtp-Source: AGHT+IFzy5Z/oqAXsIcnrbdGOPINebfA49h4xYVAFBGwVs0inyqERb0A/6qA2oCD1QD2DsUmBu7oEA==
X-Received: by 2002:a17:902:f706:b0:21f:35fd:1b57 with SMTP id d9443c01a7336-221040be680mr277312185ad.43.1739969570774;
        Wed, 19 Feb 2025 04:52:50 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:50 -0800 (PST)
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
Subject: [PATCH net-next v10 13/13] selftests: net: Add test cases for link and peer netns
Date: Wed, 19 Feb 2025 20:50:39 +0800
Message-ID: <20250219125039.18024-14-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
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
index 8d6116b80cf1..aeb96c085614 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -36,6 +36,7 @@ TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += test_so_rcv.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
+TEST_PROGS += link_netns.py
 TEST_PROGS += nl_netdev.py
 TEST_PROGS += rtnetlink.py
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
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
2.48.1


