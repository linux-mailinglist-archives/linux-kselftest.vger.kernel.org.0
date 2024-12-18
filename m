Return-Path: <linux-kselftest+bounces-23498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D69F6686
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 14:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDE21893FD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC931B042F;
	Wed, 18 Dec 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHy1eaPo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3FA1B0422;
	Wed, 18 Dec 2024 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527370; cv=none; b=uxpi7yV+BtwwHZ9TOsqM2dHeNubKv5/q2MjK+s2k2ctIBe7JqeV20z7YLWzWZCbUpj/4Ia2N8AW8+Vhob9oVwNAvpLaBXuOspS8TxcJPBAs6bzCrU5H2mnFfnC0pX3/e1ZchEBFLuzxcpCHZKdZV8pV6dDEbtpk/eP9fVjZwbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527370; c=relaxed/simple;
	bh=8H4aPlHzanTRVMIUnxjQ3Gybrz297B10rZES1FqaXRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrGffxJzkzCOi7eWeOB2Z+H1ngBmxLPi0wxzabDhdI7uVqwNGMSujrXAaQTWcxAPiB1lXGSJeoE/8zKzrkWRmHwxuebVLhSH918Lw4ivCXTsPCIjgxVZ0qcnQ35dsKlhC85ROIyyJcbbJDLuoSEv6P9iH5REDGDuf+aSdvQ0ZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHy1eaPo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72764c995e5so3952573b3a.2;
        Wed, 18 Dec 2024 05:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527365; x=1735132165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6llrxywd5dEoVM0OKwihGrkHHqwNftGWmdHiygXfmj8=;
        b=jHy1eaPo/ggkULgS/rAxP+cgTHUjNAR+nocqJIQXB6xJ8Z9KwFvzTqpQV4N4jZZphM
         1wKdWxjeprcODu3eSRi7gYEFJKt54mm8DRnH0yjCWl4BeKEO4HOXAMZORupSy2RMCiQ/
         kfNqHC+RgUZl53z/KOVzpKGqW48QAoifgbvWgisOPvG3RDt3HaMiBR1EFZvHyliCJJJo
         DuWDt6hd7F4aVSUw+05G78W31K5mEC4FGxVHASY9ANufcMrL00BoP+dr2WvXiuzZTSt+
         stu/PA7LciPOwUF+pqFTR2B+o17Ih8jBJdLrZLBrobbidH95SrkWSSnbPdNwKMpHQzZP
         Md6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527365; x=1735132165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6llrxywd5dEoVM0OKwihGrkHHqwNftGWmdHiygXfmj8=;
        b=mULmVZGTpsNy5tGHacNx02VFVPsD3GfKMQUEf1K5ZajCJ8Uvgy72qdfAOyDb3HxUCf
         cb9UU/TpQR5W+qHETu5xIlMaWCBhJuo2aamujOQEyvxSXvnfo7hfDrurYGL2QaOK5Cd5
         XBptzNDhH0DDVe9e7ABW0C0TgGsdhPFfhM2YFY7X7Io1lKX1FQJxtkFK34p3liEcKS0b
         jnh+QdNenasb9Er2tXmjrfCmACW4aywH4vY3KxgEe2alXvhQ0QfXXUt8USqmeWNh0s45
         jO+KoffC9oWENo+p9DP+fMAhDMnIJPKqTIHdp1Mz92naTVzQ+GUAsMG9ztHVyf+7c+93
         NgnA==
X-Forwarded-Encrypted: i=1; AJvYcCUDoC735de2A3JHvo2fhw3TTWvog5uLql8bGmVmO2f4fwQMo315naiXragAgq5Pg0wZZz7PxXJyfU30@vger.kernel.org, AJvYcCUKjihy26KqEiZ0jEdEya2Sf7rHzam8Onb4Lk8R62UkJs0VFzOK7iAMRrX+6UKpbxhLbhEI3wpI3bot+9U+ToNS@vger.kernel.org, AJvYcCV7YMPpN1vz7ZOP2t3bec7tB2PpAnexfpS8qVQX6El9k7ibK/hCWpalKe/kepSJ60gpApqlQcWo95GR@vger.kernel.org, AJvYcCVNyxZS1GkLgm29bt1eQuNIUaiH2ZKvE+emIQ38JQOUtB43P5aCjF3UoHF4p1fcnRAwSZI=@vger.kernel.org, AJvYcCVd5JBm3EjP35BwyzlRNFiCHv5GPBnAsdnGVfCdFurFQ7AqoG8/9wmYoSWYqRU1s77vDsUuryBY8xx2EFWWRD8=@vger.kernel.org, AJvYcCWVqTmLsBMAw6kRnZFwg1gPMCZ4pJkXAkbXyhwMrfBw3SQr0gQHClHq5MF8vH2IPPxT3lZ351uxev1SOw==@vger.kernel.org, AJvYcCWfZN/WjhnGmVwACA9xMD+/4YJAKq5NJrkR48+r7/YuL54lhco2/pjj7lhafNL8+0iwGUtQ8j70JE7uRee7@vger.kernel.org, AJvYcCXaG4OQ+4DIgslVGB7Ip/LD65DAO6l6qLqJts20RZXbVFr6S37DvngU8P+uhO3j66CBcSBMWhhqtLlc8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyCA6StMdSecrWy1mcrlj9QMhkT2lSZODtGRmd++aKAAkbZdg3
	rcAvII8PyUFCyhZa/lTerF03lIu+RBEgAraGL8TrDLDEZ0MbIGmPp7emi7zP1zk=
X-Gm-Gg: ASbGncsJ6HGHhDz4lTC0Uel5u4wBREm8TPbgOQpdw9ljuGS98G14ZBwLxJSBQs1ehoq
	7KhDQ4x/FB3W7/ejI45ob4z1pue+/PaIUL9NeKNFm3+3Bh9qLMVgtPA7ZhKzyVrjT/CcPmIyWlQ
	LD1kOnQXbVFHmoDMPblIn/bCWeQHsuJfxYf73XJDccvr2R2RCKNlSRBryhU93kDlrQeHGHiWXXy
	jzNSZ48G80OOXpq5E80OscoQb7GnP4y/1gN63LSong391I=
X-Google-Smtp-Source: AGHT+IHxL0OHgUEQczY58g8XDBLqS8Ex4WTxtaZ2NUqH1g4R3asgqmGfw3HW/w2dfnMjfE/n2fJrPg==
X-Received: by 2002:a05:6a00:2313:b0:728:e906:e466 with SMTP id d2e1a72fcca58-72a8d2dc70cmr4546358b3a.21.1734527364845;
        Wed, 18 Dec 2024 05:09:24 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:09:24 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v6 00/11] net: Improve netns handling in rtnetlink
Date: Wed, 18 Dec 2024 21:08:58 +0800
Message-ID: <20241218130909.2173-1-shaw.leon@gmail.com>
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

Patch 01 servers for 1) to avoids link name conflict in different netns.

To achieve 2), there're mainly 3 steps:

 - Patch 02 packs newlink() parameters into a struct, including
   the original "src_net" along with more netns context.
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

v6:
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
 drivers/net/wwan/wwan_core.c                  |  25 ++-
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
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 142 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 48 files changed, 546 insertions(+), 226 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.47.1


