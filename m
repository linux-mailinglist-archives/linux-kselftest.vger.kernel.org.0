Return-Path: <linux-kselftest+bounces-26958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C2DA3BEA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79758188C3EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6121E102A;
	Wed, 19 Feb 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvedAyzh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED91C7018;
	Wed, 19 Feb 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969457; cv=none; b=hi3Csvvb/hVjDk9MA8Gax2gi0hyljsB6JBajCfZwHCWc6jDs/XeLLvWPTtaW3ozdkAyh/1Lla/4YhVhbzMEog4OXMsknhBFqti7Nf4/AcoBCK2jzu7hd/ivEDK83OKcLNoJOapn2tYFjr2t/SVd0Y8wXdG0RPg5CdUXikbl/NlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969457; c=relaxed/simple;
	bh=xkr//DIeJXWeI9t9OGQRsHzzt0mLyQ9yOF0ugDqOfuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsbfHeGhhM7uxXSmluhMvvgJultVywv9SATUiAoIgXP3LvDctEn0P1sYO8k76HajmPyoyuBa3BdN56K4n3LpWnOM2lSCmNFNWzpH/dyMKtjWPBrdo4Tf035SgrCRj1hFnjpH7h3d2Ex+PDo57qj2ZZwfdu2xW+rTo2Kz7tga5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvedAyzh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22100006bc8so75662145ad.0;
        Wed, 19 Feb 2025 04:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969454; x=1740574254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOEjIz3jfJx7EGKo7QwRt3VtLNoT+pQ4mVUjPRekXyI=;
        b=cvedAyzhxJKfPPoc/Kuv3u2OTRFf2/XJbWdzYv0D5f2RrdoQ42WEWDV8UU9dRbqEJf
         Gh2KL0lpilrHhgr5iN8/tz8g8m0eULfQUm635HF/gnmbFnwrseV1uVRiEpiPdnE45blM
         IukNQtZpglSiuspoaxrFNOzYikw0rEc+RFqv7hIVqkizVB4n8B+S9R5iqPoJSf23gyBQ
         XBrBHIavd0OtvN0WZRg2/GcMetP2yFEteiXH1rIv+kuBq6RfMJE7hdbng3IaFphq9l0A
         i8s/7p8GzL8LxqUcVyPLB2hSifpnRFmDjH+zsU1m9htTNe81q9mFOIeaiQZO2um/9IGZ
         NHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969454; x=1740574254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOEjIz3jfJx7EGKo7QwRt3VtLNoT+pQ4mVUjPRekXyI=;
        b=t7FkwOqw1V+JWcWm+JfX1Y/AZNOU6I5qaaRsNLtAdtC3gGB6z2BCJ7UoZOCigb0VD3
         StL6t1uCeG0gBEYXYePuATqF28IXrqnBdWcfOXqzY2l1aAkjaIZetN4dNUpCsr+NKb78
         +m6LXrQR7rFHO6ItnfXgyu2E+LX2tdXUO0HXj+/5ePmOIz+Nh8IKgtOk/HyyRcGZRmXH
         /wOKv/v35x8V8lPCv8Luw1HIZuRkBhMBCABe7KjR3ERozWbx8uZ4VoqjaX/TUmVybzTF
         WvO17sWNqgngkXyakB7GN/FT9HiVsr8kz/XuSTx1prf3Ny0nZNQ5SWzs26Oo2QXIfnnO
         D6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU4wxo3/a4r4wJWyjpefVpQsnHbnRl4nKIXK2A0lpbf+eioMvQwedCqRz4EdMncis4zC/M=@vger.kernel.org, AJvYcCVMwPk4owKB05p7s6ZatJeKK/jerQWXkWCDRAqLXO/U4CR5YGE1mtjC9s8ECrdqcYAYZgyxv5lj1vri9z7DrNE=@vger.kernel.org, AJvYcCVixE6p8OvCHMLekk4/Ozqg1WedKfUHSdXRO9Uw4kSJk4kaPkKgDaxnCLHhMOcbn5VvEtseunekWOXe@vger.kernel.org, AJvYcCWQTRZIvlziMC8fY5MCibu37fMWy6qWwbEc/iZV60ItoPh7f00E1PrNI7zUSvQ56eZceSLYRn2ZEuem@vger.kernel.org, AJvYcCWSC0XV5y+T2aAsThw2tekdwwsz7c9yUYSfATDiCOF6jINYZtmcYRkfcZCEJllHSPuuMvMlkz8suLb+tsqP@vger.kernel.org, AJvYcCXcorfINW81uvLa6cVPzXOIcAkOk2AnqPs0p6CdbbS7bgmzQrrE/i+PzechFyYQ/RC2iruRir2k1aZkUg==@vger.kernel.org, AJvYcCXnpowksPKljH434+jxSGRxpZCYKqoIsf79HZ6zwt3Nv5/qMUW21an3B6heJ2EMYXtDlMJmQYVur7B/b5RebmBN@vger.kernel.org, AJvYcCXs07ZOPhsXWS/XJoDW/opgtnQY1efYyp37Fb9IpmJBFzQWy5bFIV2J7iJFAgvRvRJ4229DrD0GnA8LXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoktW+jWHB4HndiqMe9PL4EaIFcWtLKLqq0m7w4Qz3GuW/x7gz
	bd08vz+ThdwjLKd33miaW3/snGvBVH91+PCkNEnNqQ/IR5nslEWaie40/OEEshw=
X-Gm-Gg: ASbGncsvKaEauNEkp7YJGR0GqweyjMuQTLNXLdzY1pJYHVUPZ0y2aZFcVQOH7Xg6KeQ
	lrc/8Spl/cZwJ2ziDtmpctQ84MPP/Fr/m/8TDI4ojllIcmbe18iix/O+EhbKHorrYvkFlikbNHv
	19+pYlW3ynojizldG5c/NNfe4viROb4IoKRtQ6o317o06jDflTzQuJbnL/T+BqqDSzTs06azLU1
	9vSgSIglPGrR3R7Fg2q5S4lK6PUINQ8m5FKqSS0fXylR2rqhruEVhY4k/DAqfqMph7V58rqbdXD
	holTQA==
X-Google-Smtp-Source: AGHT+IGTzmUs09YpyFPrUkefpGaoWuBh2+9iqLpiW9iEBwyuEmzG/kObjhneqUPTdxqOS7kfr/mohA==
X-Received: by 2002:a17:902:d58b:b0:216:2426:767f with SMTP id d9443c01a7336-221040cec77mr301871725ad.49.1739969453951;
        Wed, 19 Feb 2025 04:50:53 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:50:53 -0800 (PST)
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
Subject: [PATCH net-next v10 00/13] net: Improve netns handling in rtnetlink
Date: Wed, 19 Feb 2025 20:50:26 +0800
Message-ID: <20250219125039.18024-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Patch 01 avoids link name conflict in different netns.

To achieve 2), there're mainly 3 steps:

 - Patch 02 packs newlink() parameters into a struct, including
   the original "src_net" along with more netns context. No semantic
   changes are introduced.
 - Patch 03 ~ 09 converts device drivers to use the explicit netns
   extracted from params.
 - Patch 10 ~ 11 removes the old netns parameter, and converts
   rtnetlink to create device in target netns directly.

Patch 12 ~ 13 adds some tests for link name and link netns.

---

BTW please note there're some issues found in current code:

- In amt_newlink() drivers/net/amt.c:

    amt->net = net;
    ...
    amt->stream_dev = dev_get_by_index(net, ...

  Uses net, but amt_lookup_upper_dev() only searches in dev_net.
  So the AMT device may not be properly deleted if it's in a different
  netns from lower dev.

- In lowpan_newlink() in net/ieee802154/6lowpan/core.c:

    wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

  Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
  in link netns.

And thanks to Kuniyuki for fixing related issues in gtp and pfcp:
https://lore.kernel.org/netdev/20250110014754.33847-1-kuniyu@amazon.com/

---

v10:
 - Move link/peer net helper functions to from patch 02 to 03.
 - Remove redundant tunnel->net assignment for IPv4 tunnels (patch 05).
 - Initialize tunnel->net before calling register_netdevice() for IPv6
   tunnels (patch 07).
 - Coding style fixes.

v9:
 link: https://lore.kernel.org/all/20250210133002.883422-1-shaw.leon@gmail.com/
 - Change the prototype of macvlan_common_newlink().
 - Minor fixes of coding style and local variables.

v8:
 link: https://lore.kernel.org/all/20250113143719.7948-1-shaw.leon@gmail.com/
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


Xiao Liang (13):
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Pack newlink() params into struct
  net: Use link/peer netns in newlink() of rtnl_link_ops
  ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
  net: ip_tunnel: Don't set tunnel->net in ip_tunnel_init()
  net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
  net: ipv6: Init tunnel link-netns before registering dev
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
 drivers/net/gtp.c                             |  10 +-
 drivers/net/ipvlan/ipvlan.h                   |   3 +-
 drivers/net/ipvlan/ipvlan_main.c              |   8 +-
 drivers/net/ipvlan/ipvtap.c                   |   6 +-
 drivers/net/macsec.c                          |   9 +-
 drivers/net/macvlan.c                         |  21 +--
 drivers/net/macvtap.c                         |   6 +-
 drivers/net/netkit.c                          |  14 +-
 drivers/net/pfcp.c                            |   9 +-
 drivers/net/ppp/ppp_generic.c                 |   9 +-
 drivers/net/team/team_core.c                  |   6 +-
 drivers/net/veth.c                            |   7 +-
 drivers/net/vrf.c                             |   5 +-
 drivers/net/vxlan/vxlan_core.c                |   9 +-
 drivers/net/wireguard/device.c                |   7 +-
 drivers/net/wireless/virtual/virt_wifi.c      |   8 +-
 drivers/net/wwan/wwan_core.c                  |  16 +-
 include/linux/if_macvlan.h                    |   6 +-
 include/net/ip_tunnels.h                      |   5 +-
 include/net/rtnetlink.h                       |  40 ++++-
 net/8021q/vlan_netlink.c                      |   9 +-
 net/batman-adv/soft-interface.c               |   9 +-
 net/bridge/br_netlink.c                       |   6 +-
 net/caif/chnl_net.c                           |   5 +-
 net/core/rtnetlink.c                          |  34 +++--
 net/hsr/hsr_netlink.c                         |  12 +-
 net/ieee802154/6lowpan/core.c                 |   7 +-
 net/ipv4/ip_gre.c                             |  22 ++-
 net/ipv4/ip_tunnel.c                          |   7 +-
 net/ipv4/ip_vti.c                             |   9 +-
 net/ipv4/ipip.c                               |   9 +-
 net/ipv6/ip6_gre.c                            |  26 ++--
 net/ipv6/ip6_tunnel.c                         |  18 ++-
 net/ipv6/ip6_vti.c                            |  14 +-
 net/ipv6/sit.c                                |  20 ++-
 net/xfrm/xfrm_interface_core.c                |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   5 +
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 141 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 50 files changed, 486 insertions(+), 181 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.48.1


