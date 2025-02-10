Return-Path: <linux-kselftest+bounces-26160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7405CA2EDC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C721885473
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED3C22D4C2;
	Mon, 10 Feb 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZMbEjaN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F017BB6;
	Mon, 10 Feb 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194219; cv=none; b=YmNuM6CwIEH5ym4KOgrUrVE4m/ciSMIpbebhONHGHyitL80x/Wj54M57o11x3arhSj7ZHIVmkI+WNM42cQZ+OT1y7eyiSQ/IBG7z9AJNsyjuYqaN53owzqtUAfUaD7FQHq+YJwNLXGDAEtFwHAYWj1CjwtMK22N6JQbkqv+wNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194219; c=relaxed/simple;
	bh=JWT9jVfwqIPjzXgKMkQZPpiZ8wjCF2EonWQINvODLL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVd8+RlFtrPeMVIseaGS6Y8uzssSqo46ohfwMhgXtEkmx6DLNULWVPB8pOo8KjT7+Nd7A2AXcN0YlxtTYfe73dVd7iikRZaghsO8DJm7bwjk3EMXiuG0+MtuGK07Mto2b3IiZw20ezN80Mwy9CUno8PnPt493+GdNl01aiOOTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZMbEjaN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f62cc4088so40062675ad.3;
        Mon, 10 Feb 2025 05:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194217; x=1739799017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0kuY/qnmLWcTpq+Gs4oe5wYG4aWX3Vy2rs59JLm5Zc=;
        b=MZMbEjaNCLXUjEDHkeB1mWQKFwuK/jyJHzF39Pc2ZlVn/AXZi5mNxl5b9fLd3iOAjt
         92iQ4JMRoNkEsYwsT5iH97vi9o66ASe999wyNCgHIxm1Cpqyvr52CL0DwYbJxtAvfVYx
         Dwgwr1zS7GCNTfF6SidE6MH1LYw4ZaeQVNiW64xYNKRcxVlnZiVRGp1P7tEtZ6e1FGHv
         DYCldnEtveUp4eDpn7tD7TpwzrIbz5qoZybUPzdinJT/D6Gb24M+ZIu/LU6lSw2hif29
         biPs662hwRX9B6DCEjZLJf6a3c1vkfwBQPbmoiF7vPUD6ir4sPycGA2MpO8XwTX3l3sT
         bEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194217; x=1739799017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0kuY/qnmLWcTpq+Gs4oe5wYG4aWX3Vy2rs59JLm5Zc=;
        b=i9W3cXW89v5yEtpEH6J64ElvShiFI5ZP2qvoAIEAfO4k++EsVP7HPxEaW1F0Ka7w+0
         0Bnu1zwxFjBkHG1JIUYx88F2mY1OSMem/Aup5hqqyB03NsK3TvkzIoi7xUXbtLjhYDRX
         JOqQy1g8JO+04dtAN7x5Zbg7C6hzO4dNclZw30jpERpa1LQC0bOy3cmhuBQCpAcnKHWI
         4Ka3yUYPhdbhxWsB4Crw8yc67gu+OYOuySCNteWPRACLqfzigsGmopBJ6FbVl5UdfShB
         92F6cEsNd1Iy4EAlyUP6pxuWvWU4ZZgFDfz+aWCAWIktImidnJFqwW2iXo/NGXSypQTM
         UILw==
X-Forwarded-Encrypted: i=1; AJvYcCUjZcIWJRnik/kP+PEzjY6NfkONH1zA511L2wkdrdLCI+EQhMtz8FTmOhf9L23RFTzQxQBIcB8zoQoBIA==@vger.kernel.org, AJvYcCUmie4w87JpmwbqNsDdVPuZqJERkbwnGJyRDmDSQ7yWF/yKmL1QATf2M5GrOxI9yMdjsqym1YUumARNFufHOPQ=@vger.kernel.org, AJvYcCVCxkAGqNtSCUXtJ5O3tD9mIgvmmPenm+Z7dt1CCIFnJHooyS4oE2imvIVqsjk405dcME06IFbV8x8Yi7InoF3S@vger.kernel.org, AJvYcCVZNz4xNrJzFulQBGdFAQFiGr8GOxgz7gM+8xVztEj0wPQqj4AxktT0s7FsL9NuRQpnBBwFMPLZTV7ShOei@vger.kernel.org, AJvYcCVuMzQi4I1JflDazRSdxjDAdllCyC/+7Gt/Jfrd5dCY+rAFhy7NhfUuLFMBU354DULo53M=@vger.kernel.org, AJvYcCWeXavF7w4iKdRZyaSk31jtU/F3Jmuj2AeYzuekIvwBzod6e9eMEVYOKIkzgL/W7BKe9XRdp4dKM06S@vger.kernel.org, AJvYcCWrOKcQEFNZy5H79NSBvqGUXuWMxVK/ta+jOPD+RWzmlgkfznIglKZwR6A1832P3gB6shKG2K24ba+EWQ==@vger.kernel.org, AJvYcCXf3GOtaGR8TTovxp1VRiN6Sq2Wb/oaLxF2rKlwXlE8pE3VBR1A9qnieCf8WYJiifMgnFZ4xc9OSaWy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm56sd4b+Olxnu3JE3ORpe+nfEj3z0b5LOAvd1PbUGfKJXCY4L
	iJtkeLHtR6tyv21/oOIB7aUgBK4TWobXTViE8P17Oyy5d1c2PLAAhAYgopPD
X-Gm-Gg: ASbGncuy2GazpDX1qG9e98XjYbEZCNUvLYrOdCMz/1LIV6Zs19RRrZrG7/6yMsW5V1F
	/hEOpGpqDeobOepdbT+QUM4IzQ3y+W7u/j3u6Lh1tqXkdnPrB+m22ohd7S9KgnuYd6vsbFntTaC
	GsfBvgKD+wQC5Mo2JtHrO/lKo9yBsPaWtYi/Iis0N9pnj4kyohTwftgejjqq2b3+bVxKLqSKCZf
	r2zojv5nju/pby+37PduCG6dffBZM5Fvn2PNcDn2h52aW7nJbrUhIbrbiTvfz9M0Jn1dqz/huxQ
	Cw19sg==
X-Google-Smtp-Source: AGHT+IEH5QCCl4lI0axSO2k1baOf7QV120615EUg7vMmek14klRWGmTSu58W64P2a3hO1mcauSS1MQ==
X-Received: by 2002:a17:903:2309:b0:215:a04a:89d5 with SMTP id d9443c01a7336-21f4e1cf038mr233204165ad.2.1739194216829;
        Mon, 10 Feb 2025 05:30:16 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:30:16 -0800 (PST)
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
Subject: [PATCH net-next v9 00/11] net: Improve netns handling in rtnetlink
Date: Mon, 10 Feb 2025 21:29:51 +0800
Message-ID: <20250210133002.883422-1-shaw.leon@gmail.com>
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

- In lowpan_newlink() in net/ieee802154/6lowpan/core.c:

    wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

  Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
  in link netns.

And thanks to Kuniyuki for fixing related issues in gtp and pfcp:
https://lore.kernel.org/netdev/20250110014754.33847-1-kuniyu@amazon.com/

---

v9:
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
 50 files changed, 494 insertions(+), 179 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.48.1


