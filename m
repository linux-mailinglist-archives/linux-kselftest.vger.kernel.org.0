Return-Path: <linux-kselftest+bounces-42405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3402BA109C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81437AD883
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0C319870;
	Thu, 25 Sep 2025 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLslxPkv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298B2DCBF3
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825236; cv=none; b=UVfkGjjlPzRjlhjcyFIFjC+3hNjyDWkXEISGAUZFwSo4uGXhbkfvYsFCgVoT/3+JShiKUZ7jjAAxsuzrwgM9F53pUcgRWrq260ESlLvDOWu2FrO0pUysHUB5uBWobQkMGTBtfI+vPDVM6zZxGPjVG5Z7+jC2pKZjCA+TD3L1MIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825236; c=relaxed/simple;
	bh=2iQQ9N+hqqFkGc11JcpkVKmm0ucJF1+Pq7fwYXzoIvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1jfAAhlSC1uijlZDFzFdlp7Gg4q4LvfznbK7qnxI2aPUDAaJjaxv1lAbTeHznL4meW6CvJ3unVr7TTYlWrnhCRZqnd7fv3Qr6taC8W1w04oYtStG4zmUnZ9Gf4UD2PvuPa7ouqZ1vr4KeSXDoQ3P4ozAD/6iFDqX25BGTs9Izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLslxPkv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b33d785de7cso214798866b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825231; x=1759430031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vyAG4/3nkxbBA7ulPBbFBxUiSAsTlVg5XYBp62/PTIw=;
        b=HLslxPkvDnc2TQeSoq0zTP7LDMCS4w+mW0BfJroLXb5h6qbAaHTO6uFdH0rxeGTFpL
         Hrb97T3piTnvj3PUwrSrJFPpjZhCmYbf0I254ZVLMe9LXkrXzhC+bOPYMf5F9Zu1cXpa
         bcaPHGsBucF+FJnd5nApPHN9P1jHbJ9XEycfsaB/ls5xJrAof9qirGukv3cGdXpNTtjt
         swnrt3DEvRJy1IPDW2sKTV6x/FHHP01lTIKxxT/cEZZa/+EpKfGugDLqcY48noMpdpST
         evE7JabcY7+o5/Ocq4NRWXuJm6RQC+0gfE91wRzTIzVzw/ol/UF5OnirUxoJUzWLXOrW
         PSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825231; x=1759430031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyAG4/3nkxbBA7ulPBbFBxUiSAsTlVg5XYBp62/PTIw=;
        b=XFr6pHxc8pXTq/9fQFv67Xe7rbE5DPM+DN3OlIgnCbd3EN0p7LGzCycdBIYAdANsgB
         rdw1Jgu1BQO4DSCAyJmNNuxlzx6t3j+NQD34Bhwis3+MfCP09LNzw6EX6Kto0XuqkAzR
         lf3AWWpe+S8NjzvptD5U3FaCFz4IPr+gzztTCfXM02btoFKU3yTxBBf7hvZ1f8ZDEqhD
         PBaeUGtZkMtBCG26pNVXv//wnyGw+32+E5L3wQn9T5XykZgqON/jt2HMgqUOoAgWC9VV
         bgvyUGcaDTWZwIpqSwkBZPALjTUWxnx41Tn9GrjqplTv0uqhg0qHjlryoBcnWJsYHleg
         piwg==
X-Forwarded-Encrypted: i=1; AJvYcCVMIDxey2jhibiYL13F2RxpMrHkZh6TxpGjM2Xnzwoq0htE7BOiUd12IWyU6gBn/g/Z1FBh+N9UfO06ttpV3eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4e9+rZ5lbqOCsolyT14p5qZ6ioxzvG7AcLIZH6vnN0h3tWzd7
	/+hLwlXD9Bkvho6ODf/yy22AlS34YSwyNDJaYbxLer+kcZMPqIyXjvfa
X-Gm-Gg: ASbGncsQirv6jONwFeVtN/Gmpjl+kGsO2q/GJXJV8nLLarDzas5Kf0FGz5NQrEQTlqO
	pzdZo9TZ9AqVeYRular9Nw2FGWmfSqwSaICC7JZX8OCQ04ZbpfOYK5or8DcWZwbaCU4eMd1qR/o
	Yi2u47IIOcQSOj85rWjqpxaP1CvqiUBCMuvIa76Ns8z1rA48Y8N5PdALouphwLQTeciTBsQlBCS
	/F0DNCQO5y70fJqBbvIHq5VOqzsi9A/ifdL41HJi3/LDHcPdfjSiNkAapH0XeT1UHSr3hw7p6th
	FnL4XPAXk1IhGOYQ88w7IZVxqbIRqQ1AXD4tIuI6atgRd5BS0Ww+85RXe61qlP6Wrux4WE960m4
	EJdcwPAChdPKA3LQ0FnLT9Bya8g87ptZtAz1fBzOXtcewRe6kSwl41V1OB/I9pegp+9qwi0LuYT
	L8aWliCI/8ukb2wdVHAI05OBrbiJVP
X-Google-Smtp-Source: AGHT+IEH5f7r4fj5Qq/mvt86JXiPVzzUeoSOHZxoN/NvCH4QTNKBK2tQta7WjwUDnFctA/7aC+0DsA==
X-Received: by 2002:a17:907:3ccb:b0:afe:f92d:9178 with SMTP id a640c23a62f3a-b34bd932320mr468717666b.60.1758825231007;
        Thu, 25 Sep 2025 11:33:51 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa5048sm211304166b.31.2025.09.25.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:33:50 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [RFC PATCH v3 nf-next] selftests: netfilter: Add bridge_fastpath.sh
Date: Thu, 25 Sep 2025 20:33:41 +0200
Message-ID: <20250925183341.115008-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a script to test various scenarios where a bridge is involved
in the fastpath. It runs tests in the forward path, and also in
a bridged path.

The setup is similar to a basic home router with multiple lan ports.

It uses 3 pairs of veth-devices. Each or all pairs can be
replaced by a pair of real interfaces, interconnected by wire.
This is necessary to test the behavior when dealing with
dsa ports, foreign (dsa) ports and switchdev userports that support
SWITCHDEV_OBJ_ID_PORT_VLAN.

See the head of the script for a detailed description.

Run without arguments to perform all tests on veth-devices.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

This test script is written first for the proposed bridge-fastpath
patch-sets, but it's use is more general and can easily be expanded.

Changes in v3:

- Removed all warnings reported by shellcheck -x -e SC2317
- Improved del_pppoe(), check if interfaces are removed
- Added is_known_issue() to warn instead of error for known issues
- Link down and (hardware) interfaces to default netns at end of script
- Removed matching ip(v6) address

Changes in v2:

- Moved test-series to functions
- Moved code to set_pair_link() up/down
- Added conntrack zone to bridged traffic
- Test bridge chain prerouting in test without fastpath
   and bridge chain forward in tests with fastpath

Some example outputs of this last version of patches from different
hardware, without and with patches:

ALL VETH:
=========

./bridge_fastpath.sh -t
Setup:
            CLIENT 0
              veth0cl
                |
              veth0rt
               WAN
              ROUTER
          LAN1      LAN2
       veth1rt      veth2rt
           |          |
       veth1cl      veth2cl
      CLIENT 1      CLIENT 2

Without patches:

PASS:  unaware bridge, without encaps,             without fastpath
PASS:  unaware bridge, with single vlan encap,     without fastpath
WARN:  unaware bridge, with double q vlan encaps,  without fastpath: ipv4/6: established bytes 0 < 4194304
WARN:  unaware bridge, with 802.1ad vlan encaps,   without fastpath: ipv4/6: established bytes 0 < 4194304
WARN:  unaware bridge, with pppoe encap,           without fastpath: ipv4/6: established bytes 0 < 4194304
WARN:  unaware bridge, with pppoe-in-q encaps,     without fastpath: ipv4/6: established bytes 0 < 4194304
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
WARN:  forward,        without vlan-device, with vlan encap,    client1, with fastpath: ipv4/6: tcp broken
PASS:  forward,        with vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client1, with fastpath
PASS:  all tests passed

With patches:

PASS:  unaware bridge, without encaps,             without fastpath
PASS:  unaware bridge, without encaps,             with fastpath
PASS:  unaware bridge, with single vlan encap,     without fastpath
PASS:  unaware bridge, with single vlan encap,     with fastpath
PASS:  unaware bridge, with double q vlan encaps,  without fastpath
PASS:  unaware bridge, with double q vlan encaps,  with fastpath
PASS:  unaware bridge, with 802.1ad vlan encaps,   without fastpath
PASS:  unaware bridge, with 802.1ad vlan encaps,   with fastpath
PASS:  unaware bridge, with pppoe encap,           without fastpath
PASS:  unaware bridge, with pppoe encap,           with fastpath
PASS:  unaware bridge, with pppoe-in-q encaps,     without fastpath
PASS:  unaware bridge, with pppoe-in-q encaps,     with fastpath
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   without/without vlan encap, with fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/without vlan encap,    with fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   with/with vlan encap,       with fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  aware bridge,   without/with vlan encap,    with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client1, with fastpath
PASS:  all tests passed

BANANAPI-R3 (lan1 & lan2 are dsa):
============

Without patches:

./bridge_fastpath.sh -t -0 enu1u2,lan2 -1 enu1u1,lan1 -2 lan4,eth1
Setup:
            CLIENT 0
              enu1u2
                |
              lan2
               WAN
              ROUTER
          LAN1      LAN2
          lan1      eth1
           |          |
        enu1u1      lan4
      CLIENT 1      CLIENT 2

PASS:  unaware bridge, without encaps,             without fastpath
PASS:  unaware bridge, with single vlan encap,     without fastpath
WARN:  unaware bridge, with pppoe encap,           without fastpath: ipv4/6: established bytes 0 < 4194304
WARN:  unaware bridge, with pppoe-in-q encaps,     without fastpath: ipv4/6: established bytes 0 < 4194304
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
WARN:  forward,        without vlan-device, without vlan encap, client1, with fastpath: ipv4: counted bytes 2110480 > 2097152
WARN:  forward,        without vlan-device, without vlan encap, client1, with fastpath: ipv6: counted bytes 2116104 > 2097152
PASS:  forward,        without vlan-device, without vlan encap, client1, with hw_fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with hw_fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
WARN:  forward,        without vlan-device, with vlan encap,    client1, with fastpath: ipv4/6: tcp broken
WARN:  forward,        without vlan-device, with vlan encap,    client1, with hw_fastpath: ipv4/6: tcp broken
PASS:  forward,        without vlan-device, with vlan encap,    client2, without fastpath
WARN:  forward,        without vlan-device, with vlan encap,    client2, with fastpath: ipv4/6: tcp broken
WARN:  forward,        without vlan-device, with vlan encap,    client2, with hw_fastpath: ipv4/6: tcp broken
PASS:  forward,        with vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        with vlan-device, without vlan encap, client1, with hw_fastpath
PASS:  forward,        with vlan-device, without vlan encap, client2, without fastpath
WARN:  forward,        with vlan-device, without vlan encap, client2, with fastpath: ipv4: counted bytes 2122388 > 2097152
WARN:  forward,        with vlan-device, without vlan encap, client2, with fastpath: ipv6: counted bytes 2129280 > 2097152
WARN:  forward,        with vlan-device, without vlan encap, client2, with hw_fastpath: ipv4: counted bytes 2110428 > 2097152
WARN:  forward,        with vlan-device, without vlan encap, client2, with hw_fastpath: ipv6: counted bytes 2140144 > 2097152
PASS:  forward,        with vlan-device, with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client1, with hw_fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client2, without fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client2, with fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client2, with hw_fastpath
PASS:  all tests passed

With patches:

PASS:  unaware bridge, without encaps,             without fastpath
PASS:  unaware bridge, without encaps,             with fastpath
PASS:  unaware bridge, without encaps,             with hw_fastpath
PASS:  unaware bridge, with single vlan encap,     without fastpath
PASS:  unaware bridge, with single vlan encap,     with fastpath
PASS:  unaware bridge, with single vlan encap,     with hw_fastpath
PASS:  unaware bridge, with pppoe encap,           without fastpath
PASS:  unaware bridge, with pppoe encap,           with fastpath
PASS:  unaware bridge, with pppoe encap,           with hw_fastpath
PASS:  unaware bridge, with pppoe-in-q encaps,     without fastpath
PASS:  unaware bridge, with pppoe-in-q encaps,     with fastpath
PASS:  unaware bridge, with pppoe-in-q encaps,     with hw_fastpath
PASS:  aware bridge,   without/without vlan encap, without fastpath
PASS:  aware bridge,   without/without vlan encap, with fastpath
PASS:  aware bridge,   without/without vlan encap, with hw_fastpath
PASS:  aware bridge,   with/without vlan encap,    without fastpath
PASS:  aware bridge,   with/without vlan encap,    with fastpath
PASS:  aware bridge,   with/without vlan encap,    with hw_fastpath
PASS:  aware bridge,   with/with vlan encap,       without fastpath
PASS:  aware bridge,   with/with vlan encap,       with fastpath
PASS:  aware bridge,   with/with vlan encap,       with hw_fastpath
PASS:  aware bridge,   without/with vlan encap,    without fastpath
PASS:  aware bridge,   without/with vlan encap,    with fastpath
PASS:  aware bridge,   without/with vlan encap,    with hw_fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client1, with hw_fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, without fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with fastpath
PASS:  forward,        without vlan-device, without vlan encap, client2, with hw_fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, without fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client1, with hw_fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client2, without fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client2, with fastpath
PASS:  forward,        without vlan-device, with vlan encap,    client2, with hw_fastpath
PASS:  forward,        with vlan-device, without vlan encap, client1, without fastpath
PASS:  forward,        with vlan-device, without vlan encap, client1, with fastpath
PASS:  forward,        with vlan-device, without vlan encap, client1, with hw_fastpath
PASS:  forward,        with vlan-device, without vlan encap, client2, without fastpath
PASS:  forward,        with vlan-device, without vlan encap, client2, with fastpath
PASS:  forward,        with vlan-device, without vlan encap, client2, with hw_fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client1, without fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client1, with fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client1, with hw_fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client2, without fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client2, with fastpath
PASS:  forward,        with vlan-device, with vlan encap,    client2, with hw_fastpath
PASS:  all tests passed

 .../testing/selftests/net/netfilter/Makefile  |    1 +
 .../net/netfilter/bridge_fastpath.sh          | 1055 +++++++++++++++++
 2 files changed, 1056 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/bridge_fastpath.sh

diff --git a/tools/testing/selftests/net/netfilter/Makefile b/tools/testing/selftests/net/netfilter/Makefile
index a98ed892f55f..e0de04333a3f 100644
--- a/tools/testing/selftests/net/netfilter/Makefile
+++ b/tools/testing/selftests/net/netfilter/Makefile
@@ -8,6 +8,7 @@ MNL_LDLIBS := $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
 
 TEST_PROGS := br_netfilter.sh bridge_brouter.sh
 TEST_PROGS += br_netfilter_queue.sh
+TEST_PROGS += bridge_fastpath.sh
 TEST_PROGS += conntrack_dump_flush.sh
 TEST_PROGS += conntrack_icmp_related.sh
 TEST_PROGS += conntrack_ipip_mtu.sh
diff --git a/tools/testing/selftests/net/netfilter/bridge_fastpath.sh b/tools/testing/selftests/net/netfilter/bridge_fastpath.sh
new file mode 100755
index 000000000000..614497489edb
--- /dev/null
+++ b/tools/testing/selftests/net/netfilter/bridge_fastpath.sh
@@ -0,0 +1,1055 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check if conntrack, nft chain and fastpath is functional in setups
+# where a bridge is in the fastpath.
+#
+# Commandline options make it possible to use real ethernet pairs
+# instead of veth-device pairs. Any, or all, pairs can be tested using
+# real hardware pairs. This is can be useful to test dsa-ports,
+# switchdev (dsa) foreign ports and switchdev ports supporting
+# SWITCHDEV_OBJ_ID_PORT_VLAN.
+#
+# First tcp is tested. Conntrack and nft chain are tested using a counter.
+# When there is a fastpath possible between the interfaces then the
+# fastpath is also tested.
+# When there is a hardware offloaded fastpath possible between the
+# interfaces then the hardware offloaded path is also tested.
+#
+# Setup is as a typical router:
+#
+#           nsclientwan
+#               |
+#              nsrt
+#              |  |
+#      nsclient1  nsclient2
+#
+# Masquerading for ipv4 only.
+#
+# First check if a bridge table forward chain can be setup, skip
+# these tests if this is not possible.
+# Then check if a inet table forward chain can be setup, skip
+# these tests if this is not possible.
+#
+# Different setups of paths are tested that involve a bridge in the
+# fastpath. This can be in the forward-fastpath or in the bridge-fastpath.
+#
+# The first series, in the bridge-fastpath, using a vlan-unaware bridge.
+# Traffic with the following vlan-tags is checked:
+#  a. without vlan
+#  b. single vlan
+#  c. double q vlan  (only on veth-devices)
+#  d. 802.1ad vlan   (only on veth-devices)
+#  e. pppoe       (when available)
+#  f. pppoe-in-q  (when available)
+#
+# (for items c to f fastpath can only work when a conntrack zone is set)
+# (double tag testing results in broken tcp traffic on most hardware,
+#  in this test setup, use '-a' argument to test it anyway)
+# (pppoe testing takes place if pppd and pppoe-server are installed)
+#
+# The second series, in the bridge-fastpath, using a vlan-aware bridge.
+# Here we test all combinations of ingress/egress with or without single
+# vlan encaps.
+#
+# The third series, in the forward-fastpath, using a vlan-aware bridge,
+# without a vlan-device linked to the master port. We test the same combinations
+# of ingress/egress with or without single vlan encaps.
+#
+# The fourth series, in the forward-fastpath, using a vlan-aware bridge,
+# with a vlan-device linked to the master port. We test the same combinations
+# of ingress/egress with or without single vlan encaps.
+#
+# Note 1: Using dsa userports on both sides of eth-pairs client1 or client2
+# gives erratic and unpredictable results. Use, for example, an usb-eth device
+# on the client side to test a dsa-userport.
+#
+# Note 2: Testing the hardware offloaded fastpath, it is not checked if the
+# packets do not follow the software fastpath instead. A universal way to
+# check this should be added at some point.
+#
+# Note 3: Some interfaces to test on the router side, are netns immutable.
+# Use the -d or --defaultnsrouter option so that the interfaces of the router
+# do not have to change netns. The router is build up in the default netns.
+#
+
+source lib.sh
+
+checktool "nft --version" "run test without nft"
+checktool "socat -h" "run test without socat"
+checktool "bridge -V" "run test without bridge"
+
+NR_OF_TESTS=4
+VID1=100
+VID2=101
+BRWAN=brwan
+BRLAN=brlan
+BRCL=brcl
+LINKUP_TIMEOUT=10
+PING_TIMEOUT=10
+SOCAT_TIMEOUT=10
+filesize=$((2 * 1024 * 1024))
+
+filein=$(mktemp)
+file1out=$(mktemp)
+file2out=$(mktemp)
+pppoeserveroptions=$(mktemp)
+pppoeserverpid=$(mktemp)
+
+setup_ns nsclientwan nsclientlan1 nsclientlan2
+
+        WAN=0        ; LAN1=1        ; LAN2=2          ; ADWAN=3     ; ADLAN=4
+nsa=( "$nsclientwan" "$nsclientlan1" "$nsclientlan2" ) # $nsrt         $nsrt
+AD4=( '192.168.1.1'  '192.168.2.101' '192.168.2.102' '192.168.1.2' '192.168.2.1' )
+AD6=( 'dead:1::1'    'dead:2::101'   'dead:2::102'   'dead:1::2'   'dead:2::1'   )
+
+tests_string=$(seq 1 $NR_OF_TESTS)
+
+while [ "${1:-}" != '' ]; do
+	case "$1" in
+	'-0' | '--pairwan')
+		shift
+		vethcl[WAN]="${1%,*}"
+		vethrt[WAN]="${1#*,}"
+		;;
+	'-1' | '--pairlan1')
+		shift
+		vethcl[LAN1]="${1%,*}"
+		vethrt[LAN1]="${1#*,}"
+		;;
+	'-2' | '--pairlan2')
+		shift
+		vethcl[LAN2]="${1%,*}"
+		vethrt[LAN2]="${1#*,}"
+		;;
+	'-s' | '--filesize')
+		shift
+		filesize=$1
+		;;
+	'-p' | '--parts')
+		shift
+		tests_string=$1
+		;;
+	'-4' | '--ipv4')
+		do_ipv4=1
+		;;
+	'-6' | '--ipv6')
+		do_ipv6=1
+		;;
+	'-n' | '--noskip')
+		noskip=1
+		;;
+	'-d' | '--defaultnsrouter')
+		defaultnsrouter=1
+		;;
+	'-f' | '--fixmac')
+		fixmac=1
+		;;
+	'-t' | '--showtree')
+		showtree=1
+		;;
+	*)
+		cat <<-EOF
+		Usage: $(basename "$0") [OPTION]...
+		  -0 --pairwan  eth0cl,eth0rt  pair of real interfaces to use on wan side
+		  -1 --pairlan1 eth1cl,eth1rt  pair of real interfaces to use on lan1 side
+		  -2 --pairlan2 eth2cl,eth2rt  pair of real interfaces to use on lan2 side
+		  -s --filesize                filesize to use for testing in bytes
+		  -p --parts                   partnumbers of tests to run, comma separated
+		  -4|-6 --ipv4|--ipv6          test ipv4/6 only
+		  -d --defaultnsrouter         router in default network namespace, caution!
+		  -f --fixmac                  change mac address when conflict found
+		  -n --noskip                  also perform the normally skipped tests
+		  -t --showtree                show the tree of used interfaces
+		EOF
+		exit "$ksft_skip"
+		;;
+	esac
+	shift
+done
+
+for i in ${tests_string//','/' '}; do
+	tests[i]="yes"
+done
+
+if [ -n "$defaultnsrouter" ]; then
+	nsrt="nsrt-$(mktemp -u XXXXXX)"
+	touch "/var/run/netns/$nsrt"
+	mount --bind /proc/1/ns/net "/var/run/netns/$nsrt"
+else
+	setup_ns nsrt
+fi
+nsa+=("$nsrt" "$nsrt")
+
+cleanup() {
+	if [ -n "$defaultnsrouter" ]; then
+		umount "/var/run/netns/$nsrt"
+		rm -f "/var/run/netns/$nsrt"
+	fi
+	cleanup_all_ns
+	rm -f "$filein" "$file1out" "$file2out" "$pppoeserveroptions" "$pppoeserverpid"
+}
+
+trap cleanup EXIT
+
+head -c "$filesize" < /dev/urandom > "$filein"
+
+check_mac()
+{
+	local ns=$1
+	local dev=$2
+	local othermacs=$3
+	local mac
+
+	mac=$(ip -net "$ns" -br link show dev "$dev" | \
+		grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
+
+	if [[ ! "$othermacs" =~ $mac ]]; then
+		echo "$mac"
+		return 0
+	fi
+	echo "WARN: Conflicting mac address $dev $mac" 1>&2
+
+	[ -z "$fixmac" ] && return 1
+
+	for (( j = 0 ; j < 10 ; j++ )); do
+		mac="${mac::6}$(printf %02x:%02x:%02x:%02x $((RANDOM%256)) \
+		         $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))"
+		[[ "$othermacs" =~ $mac ]] && continue
+		echo "$mac"
+		ip -net "$ns" link set dev "$dev" address "$mac" 1>&2
+		return $?
+	done
+	return 1
+}
+
+is_link()
+{
+	local updown=$1
+	local ns=$2
+	local dev=$3
+
+	if ip -net "$ns" link show dev "$dev" "${updown,,}" 2>/dev/null | \
+				grep -q "state ${updown^^}"
+	then
+		return 0
+	fi
+	return 1
+}
+
+set_pair_link()
+{
+	local updown=$1
+	local all="${*:2}"
+	local lret=0
+	local i j
+
+	for i in $all; do
+		ns="${nsa[$i]}"
+		ip -net "$ns" link set "${vethcl[$i]}" "$updown"
+		lret=$((lret | $?))
+		ip -net "$nsrt" link set "${vethrt[$i]}" "$updown"
+		lret=$((lret | $?))
+	done
+	[ $lret -ne 0 ] && return 1
+
+	for j in $(seq 1 $((LINKUP_TIMEOUT * 5 ))); do
+		lret=0
+		for i in $all; do
+			ns="${nsa[$i]}"
+			is_link "$updown" "$ns" "${vethcl[$i]}"
+			lret=$((lret | $?))
+			is_link "$updown" "$nsrt" "${vethrt[$i]}"
+			lret=$((lret | $?))
+		done
+		[ $lret -eq 0 ] && break
+		sleep 0.2
+	done
+	return $lret
+}
+
+wait_ping()
+{
+	local i1=$1
+	local i2=$2
+	local ns1=${nsa[$i1]}
+	local j
+	local lret
+
+	for j in $(seq 1 $((PING_TIMEOUT * 5 ))); do
+		ip netns exec "$ns1" ping -c 1 -w $PING_TIMEOUT -i 0.2 \
+			-q "${AD4[$i2]}" >/dev/null 2>&1
+		lret=$?
+		[ $lret -le 1 ] && return $lret
+		sleep 0.2
+	done
+	return 1
+}
+
+add_addr()
+{
+	local i=$1
+	local dev=$2
+	local ns=${nsa[$i]}
+	local ad4=${AD4[$i]}
+	local ad6=${AD6[$i]}
+
+	ip -net "$ns" addr add "${ad4}/24" dev "$dev"
+	ip -net "$ns" addr add "${ad6}/64" dev "$dev" nodad
+	if [[ "$ns" == "nsclientlan"* ]]; then
+		ip -net "$ns" route add default via "${AD4[$ADLAN]}"
+		ip -net "$ns" route add default via "${AD6[$ADLAN]}"
+	elif [[ "$ns" == "nsclientwan"* ]]; then
+		ip -net "$ns" route add default via "${AD6[$ADWAN]}"
+	fi
+
+}
+
+del_addr()
+{
+	local i=$1
+	local dev=$2
+	local ns=${nsa[$i]}
+	local ad4=${AD4[$i]}
+	local ad6=${AD6[$i]}
+
+	if [[ "$ns" == "nsclientlan"* ]]; then
+		ip -net "$ns" route del default via "${AD6[$ADLAN]}"
+		ip -net "$ns" route del default via "${AD4[$ADLAN]}"
+	elif [[ "$ns" == "nsclientwan"* ]]; then
+		ip -net "$ns" route del default via "${AD6[$ADWAN]}"
+	fi
+	ip -net "$ns" addr del "${ad6}/64" dev "$dev" nodad
+	ip -net "$ns" addr del "${ad4}/24" dev "$dev"
+}
+
+set_client()
+{
+	local i=$1
+	local vlan=$2
+	local arg=$3
+	local ns=${nsa[$i]}
+	local vdev="${vethcl[$i]}"
+	local brdev="$BRCL"
+	local proto=""
+	local pvidslave=""
+
+	unset_client "$i"
+
+	if [[ "$vlan" == "qq" ]]; then
+		ip -net "$ns" link add link "$vdev" name "$vdev.$VID1" type vlan id $VID1
+		ip -net "$ns" link add link "$vdev.$VID1" name "$vdev.$VID1.$VID2" \
+			                                       type vlan id $VID2
+		ip -net "$ns" link set "$vdev.$VID1" up
+		ip -net "$ns" link set "$vdev.$VID1.$VID2" up
+		add_addr "$i" "$vdev.$VID1.$VID2"
+		return
+	fi
+
+	[[ "$vlan" == "none" ]] && pvidslave="pvid untagged"
+	[[ "$vlan" == "ad" ]] && proto="vlan_protocol 802.1ad"
+
+	# shellcheck disable=SC2086
+	ip -net "$ns" link add "$brdev" type bridge vlan_filtering 1 vlan_default_pvid 0 $proto
+	ip -net "$ns" link set "$vdev" master "$brdev"
+	ip -net "$ns" link set "$brdev" up
+
+	# shellcheck disable=SC2086
+	bridge -net "$ns" vlan add dev "$vdev" vid $VID1 $pvidslave
+	bridge -net "$ns" vlan add dev "$brdev" vid $VID1 pvid untagged self
+
+	if [[ "$vlan" == "ad" ]]; then
+		ip -net "$ns" link add link "$brdev" name "$brdev.$VID2" type vlan id $VID2
+		brdev="$brdev.$VID2"
+		ip -net "$ns" link set "$brdev" up
+	fi
+
+	if [[ "$arg" != "noaddress" ]]; then
+		add_addr "$i" "$brdev"
+	fi
+}
+
+unset_client()
+{
+	local i=$1
+	local ns=${nsa[$i]}
+	local vdev="${vethcl[$i]}"
+	local brdev="$BRCL"
+
+	ip -net "$ns" link del "$brdev" type bridge 2>/dev/null
+	ip -net "$ns" link del "$vdev.$VID1" 2>/dev/null
+}
+
+add_pppoe()
+{
+	local i1=$1
+	local i2=$2
+	local dev1=$3
+	local dev2=$4
+	local desc=$5
+	local ns1=${nsa[$i1]}
+	local ns2=${nsa[$i2]}
+
+	ppp1=0
+	while [ -n "$(ip -net "$ns1" link show ppp$ppp1 2>/dev/null)" ]
+	do ((ppp1++)); done
+	echo "noauth defaultroute noipdefault unit $ppp1" >"$pppoeserveroptions"
+	ppp1="ppp$ppp1"
+
+	if ! ip netns exec "$ns1" pppoe-server -k -L "${AD4[$i1]}" -R "${AD4[$i2]}" \
+		-I "$dev1" -X "$pppoeserverpid" -O "$pppoeserveroptions" >/dev/null; then
+		echo "ERROR: $desc: failed to setup pppoe server" 1>&2
+		return 1
+	fi
+
+	if ! ip netns exec "$ns2" pppd plugin pppoe.so nic-"$dev2" persist holdoff 0 noauth \
+		defaultroute noipdefault noaccomp nodeflate noproxyarp nopcomp \
+		novj novjccomp linkname "selftest-$$" >/dev/null; then
+		echo "ERROR: $desc: failed to setup pppoe client" 1>&2
+		return 1
+	fi
+
+	if ! wait_ping "$i1" "$i2"; then
+		echo "ERROR: $desc: failed to setup functional pppoe connection" 1>&2
+		return 1
+	fi
+
+	ppp2=$(tail -n 1 < "/run/pppd/ppp-selftest-$$.pid")
+
+	ip -net "$ns1" addr add "${AD6[$i1]}/64" dev "$ppp1" nodad
+	ip -net "$ns2" addr add "${AD6[$i2]}/64" dev "$ppp2" nodad
+
+	return 0
+}
+
+del_pppoe()
+{
+	local i1=$1
+	local i2=$2
+	local dev1=$3
+	local dev2=$4
+	local ns1=${nsa[$i1]}
+	local ns2=${nsa[$i2]}
+	local i serverpid clientpid
+
+	serverpid="$(head -n 1 < "$pppoeserverpid")"
+	clientpid="$(head -n 1 < "/run/pppd/ppp-selftest-$$.pid")"
+
+	[[ -n "$ppp1" ]] && ip -net "$ns1" addr del "${AD6[$i1]}/64" dev "$ppp1"
+	[[ -n "$ppp2" ]] && ip -net "$ns2" addr del "${AD6[$i2]}/64" dev "$ppp2"
+
+	for i in $(seq 1 $((PING_TIMEOUT * 5 ))); do
+		if ip -net "$ns2" link show dev "$ppp2" 1>/dev/null 2>/dev/null; then
+			kill -9 "$clientpid" 2>/dev/null
+		elif ip -net "$ns1" link show dev "$ppp1" 1>/dev/null 2>/dev/null; then
+			kill -SIGTERM "$serverpid" 2>/dev/null
+		else return 0
+		fi
+		sleep 0.2
+	done
+	echo "ERROR: failed to remove pppoe connection" 1>&2
+	return 1
+}
+
+listener_ready()
+{
+	local ns=$1
+	local ipv=$2
+
+	ss -N "$ns" --ipv"$ipv" -lnt -o "sport = :8080" | grep -q 8080
+}
+
+test_tcp() {
+	local i1=$1
+	local i2=$2
+	local dofast=$3
+	local desc=$4
+	local ns1=${nsa[$i1]}
+	local ns2=${nsa[$i2]}
+	local i=-1
+	local lret=0
+	local ads=""
+	local ipv ad a lpid bytes limit error
+
+	if    [ -n "$do_ipv4" ]; then ads="${AD4[$i2]}"
+	elif  [ -n "$do_ipv6" ]; then ads="${AD6[$i2]}"
+	else  ads="${AD4[$i2]} ${AD6[$i2]}"
+	fi
+	for ad in $ads; do
+		((i++))
+		if [[ "$ad" =~ ":" ]]
+		then ipv="6"; a="[${ad}]"
+		else ipv="4"; a="${ad}"
+		fi
+
+		rm -f "$file1out" "$file2out"
+
+		# ip netns exec "$nsrt" nft reset counters >/dev/null
+		# But on some systems this results in 4GB values in packet and byte count, so:
+		(echo "flush ruleset"; ip netns exec "$nsrt" nft --stateless list ruleset) | \
+			ip netns exec "$nsrt" nft -f -
+
+		timeout "$SOCAT_TIMEOUT" ip netns exec "$ns2" socat TCP$ipv-LISTEN:8080,reuseaddr \
+					STDIO <"$filein" >"$file2out" 2>/dev/null &
+		lpid=$!
+		busywait 1000 listener_ready "$ns2" "$ipv"
+
+		timeout "$SOCAT_TIMEOUT" ip netns exec "$ns1" socat TCP$ipv:"$a":8080 \
+					STDIO <"$filein" >"$file1out" 2>/dev/null
+
+		if ! wait $lpid; then
+			error[i]="tcp broken"
+			continue
+		fi
+		if ! cmp "$filein" "$file1out" >/dev/null 2>&1; then
+			error[i]="file mismatch to ${ad}"
+			continue
+		fi
+		if ! cmp "$filein" "$file2out" >/dev/null 2>&1; then
+			error[i]="file mismatch from ${ad}"
+			continue
+		fi
+
+		limit=$((2 * filesize))
+		bytes=$(ip netns exec "$nsrt" nft list counter $family filter "check" | \
+				grep "packets" | cut -d' ' -f4)
+		if [ -z "$dofast" ] && [ "$bytes" -lt "$limit" ]; then
+
+			error[i]="established bytes $bytes < $limit"
+			continue
+		fi
+		if [ -n "$dofast" ] && [ "$bytes" -gt "$((limit/2))" ]; then
+			# Significant reduction of bytes expected
+			error[i]="counted bytes $bytes > $((limit/2))"
+			continue
+		fi
+
+	done
+
+	if [ -n "${error[0]}" ]; then
+		if [[ "${error[0]}" == "${error[1]}" ]]; then
+			error[0]="$desc: ipv4/6: ${error[0]}"
+			error[1]=""
+		else
+			error[0]="$desc: ipv4: ${error[0]}"
+		fi
+	fi
+	if [ -n "${error[1]}" ]; then
+		error[1]="$desc: ipv6: ${error[1]}"
+	fi
+
+	for i in 0 1; do
+		if [ -n "${error[i]}" ]; then
+			if is_known_issue "$desc: ${error[i]}"; then
+				echo "WARN:  ${error[i]}" 1>&2
+				lret=$((lret | 1))
+			else
+				echo "ERROR: ${error[i]}" 1>&2
+				lret=$((lret | 2))
+			fi
+		fi
+	done
+	if [ $lret -eq 0 ]; then
+		echo "PASS:  $desc"
+	fi
+	return $(( lret & 2 ))
+}
+
+known_issues=(
+'*unaware bridge,*with double q vlan encaps,*without fastpath*established*'   # 1
+'*unaware bridge,*with 802.1ad vlan encaps,*without fastpath*established*'    # 1
+'*unaware bridge,*with pppoe encap,*without fastpath*established*'            # 1
+'*unaware bridge,*with pppoe-in-q encaps,*without fastpath*established*'      # 1
+'*forward,*without vlan-device, without vlan encap,*with *fastpath:*counted*' # 2
+'*forward,*without vlan-device, with vlan encap,*with *fastpath:*tcp broken*' # 3
+'*forward,*with vlan-device, without vlan encap,*with *fastpath:*counted*'    # 4
+)
+
+is_known_issue() {
+	local err=$1
+	for issue in "${known_issues[@]}"; do
+		# shellcheck disable=SC2053
+		[[ "$err" == $issue ]] && return 0
+	done
+	return 1
+}
+
+test_paths() {
+	local i1=$1
+	local i2=$2
+	local desc=$3
+	local ns1=${nsa[$i1]}
+	local ns2=${nsa[$i2]}
+
+
+	if ! setup_nftables "$i1" "$i2"; then
+		echo "ERROR: $desc: cannot setup nftables" 1>&2
+		return 1
+	fi
+	if ! test_tcp "$i1" "$i2" "" "$desc without fastpath"; then
+		return 1
+	fi
+
+	if ! setup_fastpath "$i1" "$i2" "" 2>/dev/null; then
+		return 0
+	fi
+	if ! test_tcp "$i1" "$i2" "fast" "$desc with fastpath"; then
+		return 1
+	fi
+
+	if ! setup_fastpath "$i1" "$i2" "hw" 2>/dev/null; then
+		return 0
+	fi
+	if ! test_tcp "$i1" "$i2" "fast" "$desc with hw_fastpath"; then
+		return 1
+	fi
+
+	return 0
+
+}
+
+add_masq()
+{
+	if [[ $family != "bridge" ]]; then
+		ip netns exec "$nsrt" nft -f - <<-EOF
+		table ip nat {
+		    chain postrouting {
+		        type nat hook postrouting priority 0;
+		        oifname ${BRWAN} masquerade
+		    }
+		}
+		EOF
+	else
+		return 0
+	fi
+}
+
+add_zone()
+{
+	local devs=$1
+
+	if [[ $family == "bridge" ]]; then
+		ip netns exec "$nsrt" nft -f - <<-EOF
+		table ${family} filter {
+		    chain preroutingzones {
+		        type filter hook prerouting priority -300;
+		        iif ${devs} ct zone set 23
+		    }
+		}
+		EOF
+	fi
+}
+
+setup_nftables()
+{
+	local devs="{ ${vethrt[$1]} , ${vethrt[$2]} }"
+	local i1=$1
+	local i2=$2
+
+	ip netns exec "$nsrt" nft flush ruleset
+
+	if ! add_masq; then
+		return 1
+	fi
+
+	add_zone "${devs}" 2>/dev/null
+
+	ip netns exec "$nsrt" nft -f - <<-EOF
+	table ${family} filter {
+	    counter check { }
+	    chain prerouting {
+	        type filter hook prerouting priority 0; policy accept;
+	        ct state established tcp dport 8080 counter name "check"
+	        ct state established tcp sport 8080 counter name "check"
+	    }
+	}
+	EOF
+}
+
+setup_fastpath()
+{
+	local devs="{ ${vethrt[$1]} , ${vethrt[$2]} }"
+	local arg=$3
+	local flags=""
+
+	[[ "$arg" == "hw" ]] && flags="flags offload"
+
+	ip netns exec "$nsrt" nft flush ruleset
+
+	if ! add_masq; then
+		return 1
+	fi
+
+	add_zone "${devs}" 2>/dev/null
+
+	ip netns exec "$nsrt" nft -f - <<-EOF
+	table ${family} filter {
+	    counter check { }
+	    flowtable f {
+	        hook ingress priority filter
+	        devices = ${devs}
+	        ${flags}
+	    }
+	    chain forward {
+	        type filter hook forward priority 0; policy accept;
+	        counter name "check"
+	        ct state established flow add @f
+	    }
+	}
+	EOF
+}
+
+test_unaware_bridge()
+{
+	local lret=0
+	local i
+
+	for i in $LAN1 $LAN2; do
+		set_client "$i" none
+	done
+
+	test_paths $LAN1 $LAN2 "unaware bridge, without encaps,            "
+	lret=$((lret | $?))
+
+	for i in $LAN1 $LAN2; do
+		set_client "$i" q
+	done
+
+	test_paths $LAN1 $LAN2 "unaware bridge, with single vlan encap,    "
+	lret=$((lret | $?))
+
+	for i in $LAN1 $LAN2; do
+		set_client "$i" qq
+	done
+
+	# Skip testing double tagged packets on real hardware
+	if [ -n "$lan_all_veth" ] || [ -n "$noskip" ]; then
+
+	test_paths $LAN1 $LAN2 "unaware bridge, with double q vlan encaps, "
+	lret=$((lret | $?))
+
+	for i in $LAN1 $LAN2; do
+		set_client "$i" ad
+	done
+
+	test_paths $LAN1 $LAN2 "unaware bridge, with 802.1ad vlan encaps,  "
+	lret=$((lret | $?))
+
+	fi
+	# End Skip testing double tagged packets
+
+	if [ -n "$(command -v pppd 2>/dev/null)" ] &&
+	   [ -n "$(command -v pppoe-server 2>/dev/null)" ]; then
+	# Start pppoe
+
+	for i in $LAN1 $LAN2; do
+		set_client "$i" none noaddress
+	done
+
+	if add_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL" "unaware bridge, with pppoe encap"; then
+		test_paths $LAN1 $LAN2 "unaware bridge, with pppoe encap,          "
+		lret=$((lret | $?))
+	fi
+
+	del_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL"
+	lret=$((lret | $?))
+
+	for i in $LAN1 $LAN2; do
+		set_client "$i" q noaddress
+	done
+
+	if add_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL" "unaware bridge, with pppoe-in-q encaps"; then
+		test_paths $LAN1 $LAN2 "unaware bridge, with pppoe-in-q encaps,    "
+		lret=$((lret | $?))
+	fi
+
+	del_pppoe $LAN1 $LAN2 "$BRCL" "$BRCL"
+	lret=$((lret | $?))
+
+	# End pppoe
+	fi
+
+	for i in $LAN1 $LAN2; do
+		unset_client "$i"
+	done
+	return $lret
+}
+
+test_aware_bridge()
+{
+	local lret=0
+	local i
+
+	for i in $LAN1 $LAN2; do
+		bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+		set_client "$i" none
+	done
+	test_paths $LAN1 $LAN2 "aware bridge,   without/without vlan encap,"
+	lret=$((lret | $?))
+
+	i=$LAN1
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1
+	set_client $i q
+
+	test_paths $LAN1 $LAN2 "aware bridge,   with/without vlan encap,   "
+	lret=$((lret | $?))
+
+	i=$LAN2
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1
+	set_client $i q
+
+	test_paths $LAN1 $LAN2 "aware bridge,   with/with vlan encap,      "
+	lret=$((lret | $?))
+
+	i=$LAN1
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1
+	bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	set_client $i none
+
+	test_paths $LAN1 $LAN2 "aware bridge,   without/with vlan encap,   "
+	lret=$((lret | $?))
+
+	i=$LAN1
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	unset_client $i
+	i=$LAN2
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1
+	unset_client $i
+
+	return $lret
+}
+
+test_forward_without_vlandev()
+{
+	local wo=$1
+	local lret=0
+	local i
+
+	[[ "$wo" == "" ]] && wo="without"
+
+	for i in $LAN1 $LAN2; do
+		bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1 pvid untagged
+		set_client "$i" none
+	done
+
+	test_paths $LAN1 $WAN "forward,        $wo vlan-device, without vlan encap, client1,"
+	lret=$((lret | $?))
+	if [ -z "$lan_all_veth" ] || [ -n "$noskip" ]; then
+	test_paths $LAN2 $WAN "forward,        $wo vlan-device, without vlan encap, client2,"
+	lret=$((lret | $?))
+	fi
+
+	for i in $LAN1 $LAN2; do
+	bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1 pvid untagged
+	bridge -net "$nsrt" vlan add dev "${vethrt[$i]}" vid $VID1
+	set_client "$i" q
+	done
+
+	test_paths $LAN1 $WAN "forward,        $wo vlan-device, with vlan encap,    client1,"
+	lret=$((lret | $?))
+	if [ -z "$lan_all_veth" ] || [ -n "$noskip" ]; then
+	test_paths $LAN2 $WAN "forward,        $wo vlan-device, with vlan encap,    client2,"
+	lret=$((lret | $?))
+	fi
+
+	for i in $LAN1 $LAN2; do
+		bridge -net "$nsrt" vlan del dev "${vethrt[$i]}" vid $VID1
+		unset_client "$i"
+	done
+	return $lret
+}
+
+test_forward_with_vlandev()
+{
+	test_forward_without_vlandev "with"
+	return $?
+}
+
+ret=0
+### Start Initial Setup ###
+
+for i in 4 6; do
+	ip netns exec "$nsrt" sysctl -q net.ipv$i.conf.all.forwarding=1
+done
+
+### Use brwan to make sure software fastpath is ###
+###         direct xmit in other direction also ###
+
+ip -net "$nsrt" link add $BRWAN type bridge
+ret=$((ret | $?))
+ip -net "$nsrt" link set $BRWAN up
+ret=$((ret | $?))
+if [ $ret -ne 0 ]; then
+	echo "SKIP: Can't create bridge"
+	exit "$ksft_skip"
+fi
+
+# If both lan clients are veth-devices, only test 1 in the forward path
+if [ -z "${vethcl[$LAN1]}" ] && [ -z "${vethcl[$LAN2]}" ]; then
+	lan_all_veth=1
+fi
+
+for i in $WAN $LAN1 $LAN2; do
+	ns="${nsa[$i]}"
+	if [ -z "${vethcl[$i]}" ]; then
+		vethcl[i]="veth${i}cl"
+		vethrt[i]="veth${i}rt"
+		ip link add   "${vethcl[$i]}" netns "$ns" type veth \
+		    peer name "${vethrt[$i]}" netns "$nsrt"
+		ret=$((ret | $?))
+	else # Use pair of interconnected hardware interfaces
+		ip link set "${vethrt[$i]}" netns "$nsrt"
+		ret=$((ret | $?))
+		ip link set "${vethcl[$i]}" netns "$ns"
+		ret=$((ret | $?))
+	fi
+done
+if [ $ret -ne 0 ]; then
+	echo "SKIP: (v)eth pairs cannot be used"
+	exit "$ksft_skip"
+fi
+
+if [ -n "$showtree" ]; then
+	cat <<-EOF
+	Setup:
+	            CLIENT 0
+	              ${vethcl[$WAN]}
+	                |
+	              ${vethrt[$WAN]}
+	               WAN
+	              ROUTER
+	          LAN1      LAN2
+	$(printf "%14.14s" "${vethrt[$LAN1]}")      ${vethrt[$LAN2]}
+	           |          |
+	$(printf "%14.14s" "${vethcl[$LAN1]}")      ${vethcl[$LAN2]}
+	      CLIENT 1      CLIENT 2
+
+	EOF
+fi
+
+for n in nsclientwan nsclientlan; do
+	routerside=""; clientside=""
+	for i in $WAN $LAN1 $LAN2; do
+		ns="${nsa[$i]}"
+		[[ "$ns" != "$n"* ]] && continue
+		mac=$(check_mac "$ns" "${vethcl[$i]}" "$routerside $clientside")
+		ret=$((ret | $?))
+		clientside+=" $mac"
+		mac=$(check_mac "$nsrt" "${vethrt[$i]}" "$clientside")
+		ret=$((ret | $?))
+		routerside+=" $mac"
+	done
+done
+if [ $ret -ne 0 ]; then
+	echo "SKIP: conflicting mac address"
+	exit "$ksft_skip"
+fi
+
+set_pair_link up $WAN $LAN1 $LAN2
+ret=$((ret | $?))
+if [ $ret -ne 0 ]; then
+	echo "SKIP: setting (v)eth pairs link up failed"
+	exit "$ksft_skip"
+fi
+
+i=$WAN
+ip -net "$nsrt" link set "${vethrt[$i]}" master $BRWAN
+set_client $i none
+add_addr $ADWAN "$BRWAN"
+
+family="bridge"
+if ! setup_nftables $LAN1 $LAN2 2>/dev/null; then
+	echo "INFO: Cannot add nftables table $family"
+	tests[1]=""; tests[2]=""
+fi
+family="inet"
+if ! setup_nftables $WAN $LAN1 2>/dev/null; then
+	echo "INFO: Cannot add nftables table $family"
+	tests[3]=""; tests[4]=""
+fi
+
+### End Initial Setup ###
+
+if [ -n "${tests[1]}" ]; then
+	# Setup brlan as vlan unaware bridge
+	family="bridge"
+	ip -net "$nsrt" link add $BRLAN type bridge
+	ip -net "$nsrt" link set $BRLAN up
+	for i in $LAN1 $LAN2; do
+		ip -net "$nsrt" link set "${vethrt[$i]}" master $BRLAN
+	done
+	test_unaware_bridge
+	ret=$((ret | $?))
+	ip -net "$nsrt" link del $BRLAN type bridge
+fi
+
+if [ -n "${tests[2]}" ] || [ -n "${tests[3]}" ] || [ -n "${tests[4]}" ]; then
+	# Setup brlan as vlan aware bridge
+	family="bridge"
+
+	ip -net "$nsrt" link add $BRLAN type bridge vlan_filtering 1 vlan_default_pvid 0
+	ip -net "$nsrt" link set $BRLAN up
+	bridge -net "$nsrt" vlan add dev $BRLAN vid $VID1 pvid untagged self
+	add_addr $ADLAN "$BRLAN"
+	for i in $LAN1 $LAN2; do
+		ip -net "$nsrt" link set "${vethrt[$i]}" master $BRLAN
+	done
+
+	if [ -n "${tests[2]}" ]; then
+		test_aware_bridge
+		ret=$((ret | $?))
+	fi
+
+	family="inet"
+
+	if [ -n "${tests[3]}" ]; then
+		test_forward_without_vlandev
+		ret=$((ret | $?))
+	fi
+
+	if [ -n "${tests[4]}" ]; then
+		# Setup vlan-device linked to brlan master port
+		del_addr $ADLAN "$BRLAN"
+		ip -net "$nsrt" link set $BRLAN down
+		bridge -net "$nsrt" vlan del dev $BRLAN vid $VID1 pvid untagged self
+		bridge -net "$nsrt" vlan add dev $BRLAN vid $VID1 self
+		ip -net "$nsrt" link add link $BRLAN name $BRLAN.$VID1 type vlan id $VID1
+		ip -net "$nsrt" link set $BRLAN up
+		ip -net "$nsrt" link set "$BRLAN.$VID1" up
+		add_addr $ADLAN "$BRLAN.$VID1"
+		test_forward_with_vlandev
+		ret=$((ret | $?))
+	fi
+
+	ip -net "$nsrt" link del $BRLAN type bridge
+fi
+
+### Finish tests ###
+
+ip -net "$nsrt" link del $BRWAN type bridge
+
+for i in $WAN $LAN1 $LAN2; do
+	unset_client "$i"
+done
+
+set_pair_link down $WAN $LAN1 $LAN2
+
+for i in $WAN $LAN1 $LAN2; do
+	ns="${nsa[$i]}"
+	if [[ "${vethcl[$i]:0:4}" != "veth" ]]; then
+		ip netns exec "$ns" ip link set "${vethcl[$i]}" netns 1
+	fi
+	if [[ "${vethrt[$i]:0:4}" != "veth" ]]; then
+		ip netns exec "$nsrt" ip link set "${vethrt[$i]}" netns 1
+	fi
+done
+
+if [ $ret -eq 0 ]; then
+	echo "PASS:  all tests passed"
+else
+	echo "ERROR: bridge fastpath test has failed"
+fi
+
+exit $ret
-- 
2.50.0


