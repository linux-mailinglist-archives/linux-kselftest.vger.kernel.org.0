Return-Path: <linux-kselftest+bounces-21925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365A9C6FDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BD128A417
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5941DF267;
	Wed, 13 Nov 2024 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjzSmDnp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8C1DEFF6;
	Wed, 13 Nov 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502659; cv=none; b=AMl85MASIoWbZguwvOhIQwJN33wpUg9XrCKoaQZ8RSNnFP+0u8Owe20HPfd6XJzCHxlHEHo9zfqR10eyh3tObksJesYWS3DO+h6sFzbblig+bupqxzZYXPO4PK5piHxVKYHh789LrZZTr9/moF7dbDPlHOk/AKjUGkeX93E4AyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502659; c=relaxed/simple;
	bh=LGhloGeZIC0Mz+li19UMoWZ/7zMlCQSy38g2HbfQ70Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxF2iVQSO92x5lhc1E8XdrYNxU2w7JgUNuvdvwev+I0eYtED3lm+XK65v1iXRuRmvXm1C2smKLMNym6bYQ6Ogfr0dzYO38J7rzn7VuQ20qz98zmvWtWfzuobFanUJzEHLxRSeMVNAAkGRt63DVo3CkQqTDfEQKhwwcOQaN08CdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjzSmDnp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72458c0e0d5so566514b3a.1;
        Wed, 13 Nov 2024 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502656; x=1732107456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16RIG7XtmkaIMsGLfFdWcl8EYTUAA5lDQMgC+uoAVXA=;
        b=UjzSmDnpwXE41Xd2KIqsEuxJDaBCwJPB9vw19B/xyRF6xOFcSqSaKAJp40KW7kh5R7
         cGviJWk0qqKbUm0I1JGgUbJNjIMLyorki6ahqU/wECMF+wA/Hw2iAQiCty8MdXW63ZvS
         QUErb1N4VqXPkPPzwAIbYy9NhIYCCAT226CCmD7lw87FB6ttik9CLKfu+Ya/4mIKyl9u
         7H0QD/iXMAr7Qwcs75ue/lx6CKTAfmXa53YRwrd3dk3ByN763O54z3WFQxoEwwWysKMp
         dlLpcO7Fr/OgdUC6ngzwTu/VYst2KAO2QWHNfmQNMstQ7fo7TAKMDWlcEJox9+nHJ5b1
         UStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502656; x=1732107456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16RIG7XtmkaIMsGLfFdWcl8EYTUAA5lDQMgC+uoAVXA=;
        b=bDgfXcmBMoAjJg0urwLHbRFCu/fmt4JVWQwwOpBLS5/uV8AJWzQfon5348Gr6ApSo4
         098/kU2uYLwDzuh8r8hlssKaA0A9d5AS0+ZS+JnMNhsSyI3nijTv9n20kX3D/29KMyF+
         Ran/ERc8bXhTY3WGG+RJSELhgAuhPye+i8Uw7uB+2Bkf0q02DpFCpctYASd4XIbEHJ2f
         UlwDApbqoN71dTEDt3/pZzJAZUTad/+/lzVFmOmMjnPT/TvnQdogB3+tjRQAH3CIeKkP
         N8StZBrKvyJMFuErurzkuO9ZjNvALiFwevTABFKYxR8snFNtmsefiNx8FExgGCk37Ix6
         zQNA==
X-Forwarded-Encrypted: i=1; AJvYcCUGQ8GGbcYOKciM5No/nu6396j6Zsw6JVa1Bj/3k9HQPkMFPK2E5yC1ZOJeZaRHNS7X9Stl4dQ2Dh9LLw==@vger.kernel.org, AJvYcCULqAlWGm82M/N6dBaKZ07eJmp+AhJLgJqYPATY2qJNQEKKT3EB7iwo5ZqOTH/Px/kvZ/Yi/LHANaAM@vger.kernel.org, AJvYcCUoN2RkJt0kQ+ehTQPL+/I1FL8NmRqpPW4VfNVTjLLI6ACjFArx+g0kjXicFzzDKCgw5ZOOp5VWtyuP@vger.kernel.org, AJvYcCUxYmhqf5CGSkZLK5vQxP/zPLK4RDvusawvYt+f5Dhpmgh54LSOB/3SLafBwWxpOxQdJJz5mhcgWN8ZvOHa@vger.kernel.org, AJvYcCVDXeCuiF+Gux+afvyA8i3sfM7ImP5BcZQDR6r3POy404dSCe870SuNaaLOzY98d4I42r56qTih2f4AyaTQ1UNF@vger.kernel.org, AJvYcCVQW5iRhmrkqJtrIfG2U+ehBmrB/SUFZLtJX/La/cPiDWWF9s3vXKDEL41vo42Xqf2SFILZk8Bio3heGCN91gU=@vger.kernel.org, AJvYcCWA8D1JhXYu1/ghOT+HCbrjS6zo09k5NGwm6sC4mfRrHTIKrusWe02MgJo35x63SplZA442zU3dO8z1Xw==@vger.kernel.org, AJvYcCXHXe1n08eySLKK4QSTqCEbJNUKmxJ1cjuohBUWP/YaTomsWxtsbwrgKSMR3rkdb7NVExA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFaTOpeCygy+0DYLXCXJ83USyAXqce9F7kLGdDCwaGOD1cmTK
	iYurcismgEpBx7TOV9mKhtA27ugK7BKKz9TWDhQX66MofB8ttKKTFMED+Ct/VLg=
X-Google-Smtp-Source: AGHT+IG1llNssb9d3itpdlPx9GEqMX+Zp38UcErZg9PjxNGttUHCL6O3wsgZQ/zCnjJA57EpkRZP1g==
X-Received: by 2002:a17:90b:2789:b0:2e2:bb32:73e7 with SMTP id 98e67ed59e1d1-2e9b1f844damr30704968a91.15.1731502656393;
        Wed, 13 Nov 2024 04:57:36 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:35 -0800 (PST)
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
Subject: [PATCH net-next v3 0/6] net: Improve netns handling in RTNL and ip_tunnel
Date: Wed, 13 Nov 2024 20:57:09 +0800
Message-ID: <20241113125715.150201-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes some netns-related improvements and fixes for
RTNL and ip_tunnel, to make link creation more intuitive:

 - Creating link in another net namespace doesn't conflict with link names
   in current one.
 - Refector rtnetlink link creation. Create link in target namespace
   directly. Pass both source and link netns to drivers via newlink()
   callback.

So that

  # ip link add netns ns1 link-netns ns2 tun0 type gre ...

will create tun0 in ns1, rather than create it in ns2 and move to ns1.
And don't conflict with another interface named "tun0" in current netns.

Patch 1 from Donald is included just as a dependency.

---

v3:
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


Donald Hunter (1):
  Revert "tools/net/ynl: improve async notification handling"

Xiao Liang (5):
  net: ip_tunnel: Build flow in underlay net namespace
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Decouple net namespaces in rtnl_newlink_create()
  selftests: net: Add python context manager for netns entering
  selftests: net: Add two test cases for link netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |  6 ++-
 drivers/net/amt.c                             |  6 +--
 drivers/net/bareudp.c                         |  4 +-
 drivers/net/bonding/bond_netlink.c            |  3 +-
 drivers/net/can/dev/netlink.c                 |  2 +-
 drivers/net/can/vxcan.c                       |  4 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  5 +-
 drivers/net/geneve.c                          |  4 +-
 drivers/net/gtp.c                             |  4 +-
 drivers/net/ipvlan/ipvlan.h                   |  2 +-
 drivers/net/ipvlan/ipvlan_main.c              |  5 +-
 drivers/net/ipvlan/ipvtap.c                   |  4 +-
 drivers/net/macsec.c                          |  5 +-
 drivers/net/macvlan.c                         |  5 +-
 drivers/net/macvtap.c                         |  5 +-
 drivers/net/netkit.c                          |  4 +-
 drivers/net/pfcp.c                            |  4 +-
 drivers/net/ppp/ppp_generic.c                 |  4 +-
 drivers/net/team/team_core.c                  |  2 +-
 drivers/net/veth.c                            |  4 +-
 drivers/net/vrf.c                             |  2 +-
 drivers/net/vxlan/vxlan_core.c                |  4 +-
 drivers/net/wireguard/device.c                |  4 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  5 +-
 drivers/net/wwan/wwan_core.c                  |  6 ++-
 include/net/ip_tunnels.h                      |  5 +-
 include/net/rtnetlink.h                       | 22 ++++++++-
 net/8021q/vlan_netlink.c                      |  5 +-
 net/batman-adv/soft-interface.c               |  5 +-
 net/bridge/br_netlink.c                       |  2 +-
 net/caif/chnl_net.c                           |  2 +-
 net/core/rtnetlink.c                          | 25 ++++++----
 net/hsr/hsr_netlink.c                         |  8 +--
 net/ieee802154/6lowpan/core.c                 |  5 +-
 net/ipv4/ip_gre.c                             | 13 +++--
 net/ipv4/ip_tunnel.c                          | 16 +++---
 net/ipv4/ip_vti.c                             |  5 +-
 net/ipv4/ipip.c                               |  5 +-
 net/ipv6/ip6_gre.c                            | 17 ++++---
 net/ipv6/ip6_tunnel.c                         | 11 ++---
 net/ipv6/ip6_vti.c                            | 11 ++---
 net/ipv6/sit.c                                | 11 ++---
 net/xfrm/xfrm_interface_core.c                | 13 +++--
 tools/net/ynl/cli.py                          | 10 ++--
 tools/net/ynl/lib/ynl.py                      | 49 ++++++++-----------
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/netns.py   | 18 +++++++
 tools/testing/selftests/net/netns-name.sh     | 10 ++++
 tools/testing/selftests/net/netns_atomic.py   | 38 ++++++++++++++
 50 files changed, 255 insertions(+), 157 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.0


