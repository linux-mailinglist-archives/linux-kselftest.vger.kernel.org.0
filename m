Return-Path: <linux-kselftest+bounces-26171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772AA2EE65
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7B93A30D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82D723717B;
	Mon, 10 Feb 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nffdMbBG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A022F391;
	Mon, 10 Feb 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194320; cv=none; b=LiMp/ul9ghd8BpfBLLI0O3n2NFTiB7CQ9j2F59D48vlfN1CLN5OGxQaeXmR11xtlg3wES34m8H5dL+Ht/gWXQOdyHNV47X7iOKFEnBOFjtzUqn5FKrztUj+LCC1pp14Q/ZMREBsxYI9bFRH07IjsGMZQuOcW9/+cL3KESaK+1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194320; c=relaxed/simple;
	bh=S62S2UlhWL8rb4qI3arpOLtfToV24VE5G0QJtgwZSd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQWXBtUbYnThfG/6OAitlzsAJkwhJMESV/xx0bHz9AhJD4/BcWDYvERLKeOUDXnuR7BIcDzeDmN+OW7Q5RPjlAGtE+nP/TnLEw3AjBMYcwHZ6jkWjINbOnXycgMllofNljnH1dy9hhfmBVX4mVSZQflgbqbQCRkIi4Agodxplfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nffdMbBG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f2f386cbeso79691785ad.0;
        Mon, 10 Feb 2025 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194317; x=1739799117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk0dxyoWsu5lRO3R+Rz0JbRWJlXzABQyZSbO//NLaUs=;
        b=nffdMbBGq5lRsBHSKBMadMqqfvyNNIlS/Cwc0MJ8f5IjZ0ZM8CJ7MDNWwGKkIkPLwD
         sNoBNIOiI1IijsKGyf5LY6Y+C+5qhsDvy1UGnLTF/Duy4nMS5gddV4vec1jGHXSHWg6s
         3lkEXfN8NNhZFk4QQ8s9Ih0qRK1w6wiyPMM2lXv4yuIgZaSKFo5iEJHrtjDTkvO/C1U+
         zXGPLiaOJY3eCP0eey8tTDFg4SlZUIljtNUGx0ODDjT7JctZHM00Qnh0Mw2IxDxO1KEd
         lFr7THRh2MguPSVDWqrG99FzeT6AqvaLCgEB5AhQFFU3ObQXPskEWG/qKj7xhKLf+0Zd
         zoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194317; x=1739799117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jk0dxyoWsu5lRO3R+Rz0JbRWJlXzABQyZSbO//NLaUs=;
        b=Sh9kWjIkqyYtZ22e9ExP4Ov/74UYvtpEw1RZIRf/efSdISDm9H7v7rkFZocUtrqD38
         uvkO7M+1rHAzW0I+76wsxAzKKrgmjhXLkFpIgp0BUEqju5/eLqGMo4UFUWvNQsx/iTSP
         DsF5rE8MjuDH0uNH4KSibkyscog4TAbUgArFjBv35qrRImTwyTCCXhCKlxwQ1akRpU4H
         gs58jqSuslrHYHPY9L5hFxS3crDMQZ6RohZQG92SfLpfGZr8mInwBc1jQEruIfWApRuO
         cr1e7mqTBcnd4cE6r+Xzu/1shjut3znfcF14I/8+D4hqnGAC+5rOa2dYpNolENshCFn1
         m+8g==
X-Forwarded-Encrypted: i=1; AJvYcCUrK+VWuoYr6B/Ne4jB1R2ZUPbpyMS0YldA+a1u+J5VpPGZXAJBhWja8/HI8Ia2pNx6EFxFD2Mc+ARO@vger.kernel.org, AJvYcCVOJ61EGvPjXK6udrbZiqXTrfAYEOrXjv96hA887G1RS7DpzAUhibkPLparCSk2B/SGqSOTPu7YTvW//Ncokfn1@vger.kernel.org, AJvYcCW9QrpdJDp2XMn/coPc4/h0ex9HU6Ceq1AkVOSu2HP3mrRf4Dh6rEq2om4AdNyAIRA224U=@vger.kernel.org, AJvYcCWA3IQTOFw19Q6Id2o+2eyHuF2iWZmx+Wo7wsH4EeeTMeneszkBu7vAA5xVf/b/M4IbS3WzwyrMFXpnZQ==@vger.kernel.org, AJvYcCWRySya22sXNlPKrzo9fVmhjs9finoANLKgbAdaU0mS1AmJGQtTHe9HxDjU+DE8c7aJ4OKnQ1o0tVemaL9Y@vger.kernel.org, AJvYcCWrFw9uYdgUHpAZIWqjoQGokJGCysqoEcMAdbI8WoEcdbajJr6Ns3Ozh9Hia+d2NdJgEEaN48xj9kXmRw==@vger.kernel.org, AJvYcCX545YPGlgLOGcxOsqSPBvyB7I/8QklTCYXoCY8phm9K4fdAUWH2xftH8J99DgYr8zYqzG2PbOsrwP/lBsLt3k=@vger.kernel.org, AJvYcCXPM/5ENZCrCHopPOZDzn11LWCRT4ENN+T64+SDSTTGRExoTgY03cMmVqJWmQzpPUuMFpxvg3J1dgp4@vger.kernel.org
X-Gm-Message-State: AOJu0YwlylsSwM8ldxxANAExZ339B+4vX1jUewGqZxYAv9gMlKDgKsGc
	2jGBSZUdNyzQaefRl8IdsNmqeh3Po3Wk64YMWhdB/oMP0GyyxkuHorJPcQ34x7A=
X-Gm-Gg: ASbGncsY6uiUeM/oeYV3ChmbIgycsUXFyrQrOlNhUOE6FWKtOsfQh8FHZ9qsiCmwrnS
	ML4rm9MSF4kU92WVf/gy+ctkZP1vzU+qBMVbkZfQkuMag25JtCAUVfClMRJPG7JMDQWdROIgrbY
	ZelWqnAvsFWlXMSJV7UrLE5z5ZF9bKjYWxpXycCRHftztss7OkvxcgY84Ysc7SRYe3m8vFNjx8a
	CzmfrYymaX5FfwyPRk708YyJFDdN4BaoSk5mK0FH7pHuxLzh3Kh+RV7S5ATocB0RIeIYRrEWxZW
	3ky8wQ==
X-Google-Smtp-Source: AGHT+IFvHDtUC7UviecjfNl3hpHTbMhh0EOi41PhfMqFPmLkJsOvzu+7RGuTxjt6Zfs/TZjuhdiWxA==
X-Received: by 2002:a17:902:f60a:b0:21e:feac:8b99 with SMTP id d9443c01a7336-21f4e10da1bmr232900525ad.0.1739194317162;
        Mon, 10 Feb 2025 05:31:57 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:56 -0800 (PST)
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
Subject: [PATCH net-next v9 11/11] selftests: net: Add test cases for link and peer netns
Date: Mon, 10 Feb 2025 21:30:02 +0800
Message-ID: <20250210133002.883422-12-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
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
2.48.1


