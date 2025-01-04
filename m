Return-Path: <linux-kselftest+bounces-23901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8258A0146E
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBF8188457A
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC74196D8F;
	Sat,  4 Jan 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaFdqR9E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8A13C9D9;
	Sat,  4 Jan 2025 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995469; cv=none; b=hz4EltoOjGFxxBiyhF2XR/ILDTZBCJjLsjHPwXA8Den5A+g5BZ4kv2SimPZpTGEZOUbAwwzEWL568I7NEFDq9IK1YrBXV43zGwm67a7yrdEWPGKUh1id6rcaX40cm3QCdRg+CZzejbgBAV754ICcjXhE+cXiZblyvPQVrOlGwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995469; c=relaxed/simple;
	bh=78iDDWAiBGTMRDha9Obhylfd+VcFmHpySi4wHlZAMxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3BuKTs1v3dStrl57lepMJ/K+snbkLdNfNyYZ7abxrEqrca6BBQGy2kCkkkp7I/6HE7V+a7YiCE7hnPbDuIWGvr126lzkjUtFFScYtZC2ejOv237iB0E5THOiDQDJPyWoranuG3DA8bDM57Kb5/6z5y5iffqPxZqhgSMOgP2EX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaFdqR9E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216401de828so171698255ad.3;
        Sat, 04 Jan 2025 04:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995466; x=1736600266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utMz9TCdnLzB+35RCtS5XbaQfGf7lVYnJhgTvLhC8qc=;
        b=aaFdqR9EZKxzvbigGlIhXEkjzY4dZ/t0SffjNDBfTJw91eHRa6OIMDvb357NSBzuV5
         gw1s/qEcX77fk+rE8u6CNgJcG7ATjDlU0ZjjwEpd19eEbjNXmAAZhrBLmcpz1pFrKWun
         39IBAR4n3JnItH/AwBkbIzqb+41veKqjfApxRGe+ZRxL/CusiL702PCbue7TCRm2Jl/q
         YUNSxPiKM4b1lbmy2Br3Okjvz+1CIfl6l/uRDcTk9ltLSGO4c5z4VNRNCx46Uu97ELq6
         qd5aj/PzyfnfFNMth3UmFbK8Lbnw5wp4/mGwSys6hLpY0M9vKPYMj0pPFL6B4SNiZvKj
         1DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995466; x=1736600266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utMz9TCdnLzB+35RCtS5XbaQfGf7lVYnJhgTvLhC8qc=;
        b=lGxUGpBhyuZ70sv+kjZ2YIGle3AK59t+QJc4kgp6KpJ0PVpCcMmqMDyfaWHlbXN38p
         pePyMq/W12v9976NoFfcte80Z2YVHKUgdU5+ngf85BtO74wzvT0HK3Gb69O73eq2ngZr
         OzbpIEnkWwN0VE36tzl7ZWoiwb1QcAvoYNeTl1IkQcAYSFBOzt2b99lCG0Mgs76NlPpB
         gv/mOaeaeDcA2rIvNDeU+m9Pnox7C6sU9GxWvs+oMmvbrDs9SlKmxuO7SJfxy8IKxCEk
         o0nn+tbUZHI1jFqPlWOzDOqbMp4hAzIStjmF32ve3FVIkGTUk8kfQhlYwwF7mN1hOx0v
         /EWA==
X-Forwarded-Encrypted: i=1; AJvYcCUD/Zzs1vUe/Uc+0D5IPPuRTbku13+fCatXpNylDw7SE4rij/JKb1Sb88uyYAJvNJrZ3pe4BFk72Y5pUX/3Kug=@vger.kernel.org, AJvYcCUPzTkx6nSqMJjEC+yD222+R9/+k/MdirVBG7D9EtEggmqI7pG5E3I2oOpKOB7Nx6Qi1pLksmBqnx5Um3wF@vger.kernel.org, AJvYcCUQS7ZcRVi6hO0BvMwu+rTLdPOBasXZKUBUCRPwG6nyrWgLiNS2LK+dpZvbFSngiSTwIEIKKe6h6rnDXM2t3+1x@vger.kernel.org, AJvYcCUhxpDLRg+RzhudfVB+5+KKR9aYc33EYqbFQKNRAqeak7Jf3gvd8WuFGgVbB5zLmNjb8ddgfJl+ezfqww==@vger.kernel.org, AJvYcCXCK6CY5DSfaMXW6BkePYU5xSJiVFW84lLyf4bco8fdzCuNZnKcJOSXGqRI2f+MDQ1chG8=@vger.kernel.org, AJvYcCXJJhlP3ghOV0ARpfg7G8N46lkJRqHgkaUfgXdwknbiHFcC0l12VI59RZrK1Ve8NJEp3gQvqs2S6KUp@vger.kernel.org, AJvYcCXfRyTCixj/AO3bvoNQG6aR1UY3OM2aev1T7y5Di4mic9o8JFkc1n7bIhoAQ0Y1XrVrTgdhe1UFgv5V@vger.kernel.org, AJvYcCXxg1Y/AmIX0/YcOny47bA/Kd2iGL54WD8AHNefdXD6DLZORv1fF7gYsD7E8+6HkV4PRc1PlkfJ2yh5yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRikTfhMJDbOBibOTq/e80yeYF9WN786tWLFFBePp0usZB+oVw
	lp6RwZZn4oDSrFQ8mdBK6A1z5gXY47pYXPd2rYnRvNUkwhJxKK8YTgdoCnRqo5w=
X-Gm-Gg: ASbGnctak/GXNTkAPJsVGyfHpF+m8AyKahvuDjfWJ/yhn4Z+cjXOxfxGMZAUeYQtCFs
	rN9GLicb2EyJs3+1AQzdgsm0/xpR/pjORRl8zGr8RHJ7KePNNpZCmhcXZWxuVcXU13VbAYXxWD4
	Vo3JYmAFN1B8LFRxMejJHBQvV9lOevXQWsCJFgURLf7//MuL0TJUbKw87rTIiRDtWJdL+glS1HY
	ZprBSg22CKq+SL7U+XuWXLeWR1wVOgm0tH2DwaOBLkZ+mw=
X-Google-Smtp-Source: AGHT+IGcOHb1dyLQmVkG8bow/TLK/QHadko/AX65rHfAErCpy6bKIwin2B23ApYOFwq4e4AHjEiARA==
X-Received: by 2002:a05:6a00:3a02:b0:724:bf30:147d with SMTP id d2e1a72fcca58-72abddb20cfmr61551219b3a.11.1735995466219;
        Sat, 04 Jan 2025 04:57:46 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:57:45 -0800 (PST)
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
Subject: [PATCH net-next v7 00/11] net: Improve netns handling in rtnetlink
Date: Sat,  4 Jan 2025 20:57:21 +0800
Message-ID: <20250104125732.17335-1-shaw.leon@gmail.com>
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

---

v7:
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
  ieee802154: 6lowpan: Use link netns in newlink() of rtnl_link_ops
  net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
  net: ipv6: Use link netns in newlink() of rtnl_link_ops
  net: xfrm: Use link netns in newlink() of rtnl_link_ops
  rtnetlink: Remove "net" from newlink params
  rtnetlink: Create link directly in target net namespace
  selftests: net: Add python context manager for netns entering
  selftests: net: Add test cases for link and peer netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |  11 +-
 drivers/net/amt.c                             |  16 +-
 drivers/net/bareudp.c                         |  11 +-
 drivers/net/bonding/bond_netlink.c            |   8 +-
 drivers/net/can/dev/netlink.c                 |   4 +-
 drivers/net/can/vxcan.c                       |   9 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  11 +-
 drivers/net/geneve.c                          |  11 +-
 drivers/net/gtp.c                             |   9 +-
 drivers/net/ipvlan/ipvlan.h                   |   4 +-
 drivers/net/ipvlan/ipvlan_main.c              |  15 +-
 drivers/net/ipvlan/ipvtap.c                   |  10 +-
 drivers/net/macsec.c                          |  15 +-
 drivers/net/macvlan.c                         |   8 +-
 drivers/net/macvtap.c                         |  11 +-
 drivers/net/netkit.c                          |   9 +-
 drivers/net/pfcp.c                            |  11 +-
 drivers/net/ppp/ppp_generic.c                 |  10 +-
 drivers/net/team/team_core.c                  |   7 +-
 drivers/net/veth.c                            |   9 +-
 drivers/net/vrf.c                             |  11 +-
 drivers/net/vxlan/vxlan_core.c                |  11 +-
 drivers/net/wireguard/device.c                |  11 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  14 +-
 drivers/net/wwan/wwan_core.c                  |  25 +++-
 include/net/ip_tunnels.h                      |   5 +-
 include/net/rtnetlink.h                       |  44 +++++-
 net/8021q/vlan_netlink.c                      |  15 +-
 net/batman-adv/soft-interface.c               |  16 +-
 net/bridge/br_netlink.c                       |  12 +-
 net/caif/chnl_net.c                           |   6 +-
 net/core/rtnetlink.c                          |  35 +++--
 net/hsr/hsr_netlink.c                         |  14 +-
 net/ieee802154/6lowpan/core.c                 |   9 +-
 net/ipv4/ip_gre.c                             |  27 ++--
 net/ipv4/ip_tunnel.c                          |  10 +-
 net/ipv4/ip_vti.c                             |  10 +-
 net/ipv4/ipip.c                               |  14 +-
 net/ipv6/ip6_gre.c                            |  42 ++++--
 net/ipv6/ip6_tunnel.c                         |  20 ++-
 net/ipv6/ip6_vti.c                            |  16 +-
 net/ipv6/sit.c                                |  18 ++-
 net/xfrm/xfrm_interface_core.c                |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   5 +
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 141 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 49 files changed, 550 insertions(+), 226 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.47.1


