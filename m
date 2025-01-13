Return-Path: <linux-kselftest+bounces-24366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A19A0B99B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB9D3A6179
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A0A2451C6;
	Mon, 13 Jan 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opa9gMWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F522F169;
	Mon, 13 Jan 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779060; cv=none; b=pXA9grKE7W0XshdB0IcuPs+lnrlSR2LrQOmQbwwCQFZGzesC4Awq1TCPKCi+lJiORDUJ4vyzlc7mhxMptRSl3DYy/OKtXHVLFEHw90/5iafe9emSZglXZTxzakdVgjwkfQld8hk0Vx/h0uTtbQj3S28R9HvdJBWoJfkvYv+xiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779060; c=relaxed/simple;
	bh=16kL3RVzuXIueY/K9e2GktTYeQobat2MyiA31sOZcIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUDEjFF3y8eJnpG97cB6gvW9PllaIOu6TVp3B6RJHZ5En5jRjOu7Ax+VMDSej8Y2FQ6QNaQmv+8ArtXy8afLRB+IcDkNdIOeG1J2CA5L7pMfhlkZylcN/GijkmKpELhhhrRy+dzfj3FeLg2oAADx15mAyfCPX/yp4OF7T4Y9xwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opa9gMWf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21628b3fe7dso73443125ad.3;
        Mon, 13 Jan 2025 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779058; x=1737383858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1beorUTBDb9d2ovAB2s5mK/OAF8szMbbImDZC22QQM8=;
        b=Opa9gMWfj3RYOHeaddobAVWdrifv5kmnGJHZ63XyKLTg8VhusTIR+7U6JjuRTthz67
         vcqnK3ZNY0FkADw99L0SaZ/MeQPrW4fgq103LTzjSS6ozw47qgWViVwYmi1JOHfuchZs
         dOHDhBuwPZgmBnahFlRbK3krQTS6t3b6yYxw6aXC8pxx26zeZL7TbnUsuyaoFXm8/Ccd
         6H4AV5RtEUqcjl1xb7uA7cBOu3zImO90pTcqH42vc07hBChycOSpxWS2HcHGYPO/qLTN
         i0s/beqWTdfxis0iF60D6i3SOPMPAOVllFqgf5//BhBc7CQw1u8z3XALp3+Ea8/yONBs
         T2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779058; x=1737383858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1beorUTBDb9d2ovAB2s5mK/OAF8szMbbImDZC22QQM8=;
        b=us9FZszvpPv9wz9eeHBAKKqzLhFp2xkvbO4jwT39Ie7vnHmtlQZGJygTBLZrBvyd5p
         78HC/vLQsw4Ihe4uIq512P7L7dXAdkJUiYbjLuv4rHwqNi7AC/DInQNfDS6F8GZXtVtR
         F3dnhxUbguDn4Mh1wRDhP0oNrZ176SnJIQ1oEFWNvL9gMeYibx8OSLcZm2xvZo4uMXZG
         aBGCMhlvWrWZGQu1BC/W1lh4n2gIqf3aelWDvURy8juf73AGAIbldkBs+Dt+RcZCF0nR
         sux3WiXoA8IPowLCNc79peMm28rQYMICQno3lM5J5a1Wl6sZDryh9p8wsf6Tx57zktTS
         XjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/0Fv2ZXHEvl2IL0/in3JQfZHK7typWIqGahS6IaIYcIlDNFT8i43jH2/OpLOJd34amj1XsVvoz0hP@vger.kernel.org, AJvYcCUT5Ey1FNzctVIwJ+BMHtwxpZZTyIaUM1DWPUunsuvaDsrnvY9L/Vdx20BeHcOm+SdY811J0iQtaHb03q4i0ygO@vger.kernel.org, AJvYcCUwDJDWeDQDMFH5z+LCAGNMN/4uVhwcmVLmMQ53dqhVUfBor63zOX1qUYu7EgVh8S3jgPo=@vger.kernel.org, AJvYcCVivqiRVAgtUwoYBPBmStg0TP9k1cBu7WllYmlq3GYs2w7XCXulN1GCir8cnLYedko95uZXhSSAQEMQGA==@vger.kernel.org, AJvYcCX9EQ0h4jX70ZX/R04joFE8ZfULcbugB/k5xLqcolIyN1/ONrFiG1ZVjJXqf+pVIVRmCj7ObjY9k7VpcDqcJPg=@vger.kernel.org, AJvYcCXC+YsiUJYg5BgP2DqpKEvvHTAzYjGCTfsiT4MLZeQpFa7SPPsL7gvF0tW/0dJilIOD1qWo+nMIMzHm@vger.kernel.org, AJvYcCXchsVKqFv1iQNUgTgYPUcrG2PRvSG7hBVZr48ZW98xaSwWOmwHYwJY+8BiqWi78z6eUQcFKjJz0rLyTVLj@vger.kernel.org, AJvYcCXoIHX2MwI5GSCAl8Bpb+M5jvqfQEs88Zx0F9CSgg2LsrpiH3XjKw8QDdnjeUZwY7yTNFURcmqys/IY+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/j0ynsvs4j8kT0yTUJd9QuZl3XBM4I8SqBb0KXCOWkRIbkig
	w3UlqJiPiIcF5ZXaRDKY1fx7fopDzNMj+TSG4FzHP9tSt1o0yjq3o+8blh7UO4Q=
X-Gm-Gg: ASbGnctXUyQub1HFrrRBH6CTXm8itNsONq9vcqt69oirVGGpPMcZ1juYxLmjue0HPRT
	QTeG0c+g+KA4QuMfkD/1EyVRBB1ywkErQTkeUm75BZUIBu4DB4b1aJGPCOIwOcAwQ8AiUN9m8v9
	e8ymqlKq/OHqwgHRvV/FpEnUnqmEYUNYEpnxDNGN8u1xWRE+A8kCIA0sgIIAIi38zHh7L0eOQhg
	XC6H+tymh6FJj8+3GJVuzfD25MD22L5G20ZGCKNFXjzcQc=
X-Google-Smtp-Source: AGHT+IF50iamtynxwVleVNAyS8mxO44RNkBtHV9bN/5WAHxvooRDGqm4UnZoDFbT5fV4mFafHkIg+Q==
X-Received: by 2002:a17:903:1206:b0:216:59ed:1ab0 with SMTP id d9443c01a7336-21a83f5d8c3mr269255565ad.27.1736779057926;
        Mon, 13 Jan 2025 06:37:37 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:37:37 -0800 (PST)
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
Subject: [PATCH net-next v8 00/11] net: Improve netns handling in rtnetlink
Date: Mon, 13 Jan 2025 22:37:08 +0800
Message-ID: <20250113143719.7948-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes some netns-related improvements and fixes for
rtnetlink, to make link creation more intuitive:

 1) Creating link in another net namespace doesn't conflict with link
    names in current one.
 2) Refector rtnetlink link creation. Create link in target namespace
    directly.

So that

  # ip link add netns ns1 link-netns ns2 tun0 type gre ...

will create tun0 in ns1, rather than create it in ns2 and move to ns1.
And don't conflict with another interface named "tun0" in current netns.

Patch 01 serves for 1) to avoids link name conflict in different netns.

To achieve 2), there're mainly 3 steps:

 - Patch 02 packs newlink() parameters into a struct, including
   the original "src_net" along with more netns context. No semantic
   changes are introduced.
 - Patch 03 ~ 07 converts device drivers to use the explicit netns
   extracted from params.
 - Patch 08 ~ 09 removes the old netns parameter, and converts
   rtnetlink to create device in target netns directly.

Patch 10 ~ 11 adds some tests for link name and link netns.


BTW please note there're some issues found in current code:

- In amt_newlink() drivers/net/amt.c:

    amt->net = net;
    ...
    amt->stream_dev = dev_get_by_index(net, ...

  Uses net, but amt_lookup_upper_dev() only searches in dev_net.
  So the AMT device may not be properly deleted if it's in a different
  netns from lower dev.

- In gtp_newlink() in drivers/net/gtp.c:

    gtp->net = src_net;
    ...
    gn = net_generic(dev_net(dev), gtp_net_id);
    list_add_rcu(&gtp->list, &gn->gtp_dev_list);

  Uses src_net, but priv is linked to list in dev_net. So it may not be
  properly deleted on removal of link netns.

- In pfcp_newlink() in drivers/net/pfcp.c:

    pfcp->net = net;
    ...
    pn = net_generic(dev_net(dev), pfcp_net_id);
    list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);

  Same as above.

- In lowpan_newlink() in net/ieee802154/6lowpan/core.c:

    wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

  Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
  in link netns.


Kuniyuki has a patchset to address the issues of gtp and pfcp:
https://lore.kernel.org/netdev/20250110014754.33847-1-kuniyu@amazon.com/

---

v8:
 - Move dev and ext_ack out from param struct.
 - Validate link_net and dev_net are identical for 6lowpan.

v7:
 link: https://lore.kernel.org/all/20250104125732.17335-1-shaw.leon@gmail.com/
 - Add selftest kconfig.
 - Remove a duplicated test of ip6gre.

v6:
 link: https://lore.kernel.org/all/20241218130909.2173-1-shaw.leon@gmail.com/
 - Split prototype, driver and rtnetlink changes.
 - Add more tests for link netns.
 - Fix IPv6 tunnel net overwriten in ndo_init().
 - Reorder variable declarations.
 - Exclude a ip_tunnel-specific patch.

v5:
 link: https://lore.kernel.org/all/20241209140151.231257-1-shaw.leon@gmail.com/
 - Fix function doc in batman-adv.
 - Include peer_net in rtnl newlink parameters.

v4:
 link: https://lore.kernel.org/all/20241118143244.1773-1-shaw.leon@gmail.com/
 - Pack newlink() parameters to a single struct.
 - Use ynl async_msg_queue.empty() in selftest.

v3:
 link: https://lore.kernel.org/all/20241113125715.150201-1-shaw.leon@gmail.com/
 - Drop "netns_atomic" flag and module parameter. Add netns parameter to
   newlink() instead, and convert drivers accordingly.
 - Move python NetNSEnter helper to net selftest lib.

v2:
 link: https://lore.kernel.org/all/20241107133004.7469-1-shaw.leon@gmail.com/
 - Check NLM_F_EXCL to ensure only link creation is affected.
 - Add self tests for link name/ifindex conflict and notifications
   in different netns.
 - Changes in dummy driver and ynl in order to add the test case.

v1:
 link: https://lore.kernel.org/all/20241023023146.372653-1-shaw.leon@gmail.com/



Xiao Liang (11):
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Pack newlink() params into struct
  net: Use link netns in newlink() of rtnl_link_ops
  ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
  net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
  net: ipv6: Use link netns in newlink() of rtnl_link_ops
  net: xfrm: Use link netns in newlink() of rtnl_link_ops
  rtnetlink: Remove "net" from newlink params
  rtnetlink: Create link directly in target net namespace
  selftests: net: Add python context manager for netns entering
  selftests: net: Add test cases for link and peer netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |   9 +-
 drivers/net/amt.c                             |  11 +-
 drivers/net/bareudp.c                         |   9 +-
 drivers/net/bonding/bond_netlink.c            |   6 +-
 drivers/net/can/dev/netlink.c                 |   4 +-
 drivers/net/can/vxcan.c                       |   7 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |   9 +-
 drivers/net/geneve.c                          |   9 +-
 drivers/net/gtp.c                             |   8 +-
 drivers/net/ipvlan/ipvlan.h                   |   3 +-
 drivers/net/ipvlan/ipvlan_main.c              |   8 +-
 drivers/net/ipvlan/ipvtap.c                   |   6 +-
 drivers/net/macsec.c                          |   9 +-
 drivers/net/macvlan.c                         |   7 +-
 drivers/net/macvtap.c                         |   7 +-
 drivers/net/netkit.c                          |   7 +-
 drivers/net/pfcp.c                            |   7 +-
 drivers/net/ppp/ppp_generic.c                 |   9 +-
 drivers/net/team/team_core.c                  |   6 +-
 drivers/net/veth.c                            |   7 +-
 drivers/net/vrf.c                             |   5 +-
 drivers/net/vxlan/vxlan_core.c                |   9 +-
 drivers/net/wireguard/device.c                |   7 +-
 drivers/net/wireless/virtual/virt_wifi.c      |   8 +-
 drivers/net/wwan/wwan_core.c                  |  16 +-
 include/net/ip_tunnels.h                      |   5 +-
 include/net/rtnetlink.h                       |  40 ++++-
 net/8021q/vlan_netlink.c                      |   9 +-
 net/batman-adv/soft-interface.c               |   9 +-
 net/bridge/br_netlink.c                       |   6 +-
 net/caif/chnl_net.c                           |   5 +-
 net/core/rtnetlink.c                          |  33 ++--
 net/hsr/hsr_netlink.c                         |  12 +-
 net/ieee802154/6lowpan/core.c                 |   7 +-
 net/ipv4/ip_gre.c                             |  24 ++-
 net/ipv4/ip_tunnel.c                          |  10 +-
 net/ipv4/ip_vti.c                             |   9 +-
 net/ipv4/ipip.c                               |   9 +-
 net/ipv6/ip6_gre.c                            |  30 ++--
 net/ipv6/ip6_tunnel.c                         |  19 ++-
 net/ipv6/ip6_vti.c                            |  15 +-
 net/ipv6/sit.c                                |  17 ++-
 net/xfrm/xfrm_interface_core.c                |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   5 +
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 141 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 49 files changed, 479 insertions(+), 165 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.47.1


