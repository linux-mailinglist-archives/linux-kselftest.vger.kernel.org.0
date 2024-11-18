Return-Path: <linux-kselftest+bounces-22179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7C9D1301
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 15:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702DF284ABB
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F71A9B21;
	Mon, 18 Nov 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0qlIVGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78532199FBF;
	Mon, 18 Nov 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940397; cv=none; b=pWyis3rMWs2FM13Dch6Aim4ZGY3M0ejvmK5guvUQQXwmo5DcPH+98w9h7iy/77Ru+Yoo2jKLNCPuYPBBt1hQFxdI8uJLDdx3KxYxi00jfUpXE+MuQFLGKiZyYf78WDJHZEFQNqpxbP8zy3qcb6o0EfqZZZiysibsluJ5cMwxs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940397; c=relaxed/simple;
	bh=H5grSha4QDuPkq2DfKzCYvgmrrgrNiB2wWuyJ/9mn2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWSw8gWUq5rxZDl+j2qmBH/WmFNDTFuaHJ3T1Y2B0sbZlwEhKkInLQiDwxMNpgBoYDZp7gmKyVDSE8HiZ3if4ee4EFiL/w2uVCB4Qt6zQFoJN/2q2/6AY7ObihSltVZsmfctq+iNMl7j2Ntl1S+g8l0T+j9lFcQqnNEc5bF/Baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0qlIVGs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea2dd09971so2027142a91.3;
        Mon, 18 Nov 2024 06:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940394; x=1732545194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hNYrzSG3D47KB6oeOVj5/5Bj4MnSM/SMkHnb6rGgzb8=;
        b=e0qlIVGsMLM8FT78wMo79xJi1vm8piNj6ITqFkx6wfyGln9TMu1NQI5WW9NtlkN4Ln
         M6Qh8mawYnpuXdE3Wbpj+EYOIQphb90hhoQYJo+UwX+tfcFoI/C+aCcCvxGvFVOB2nC9
         8cBLHBn/cBVzcObTw60nm8LGoiPKfgw7xWAcc+tMZVjR3IhT3lItd7/XdCdllFj3QuTL
         4Wo8rBKeRLMdwAMqhcBDRRyHPjgyAAoYhgMojuBNwmoH02yxM1A+xhaqlrydyazQxR/+
         P2z43eDQ2k+1V4UT0VeD+ryLepU57riZrbFDjS5eteAQCsSROV5MuODKfC6Qx9uZFuPL
         qotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940394; x=1732545194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNYrzSG3D47KB6oeOVj5/5Bj4MnSM/SMkHnb6rGgzb8=;
        b=VUrqqRWQgSohqLsVqlmvFlo2+vA/0eul2amWETwJlrKeg0gYD9PjFjbPm6WxYPH3Ac
         oSL7bIGd6qTeDU8/Y4uUgnby95r7TXmMIXjiqooJv4xipAik9N19Pxo2hupqgdd81YHH
         5C35nkiFGVlGlFPh5U38I1CW4f48DfmRo1ok7e9+Q1mP0/oYCSQ35qtwR+SpMT27xH+4
         QOw57Ck1b5l6CHAn6oTbyw1ROu10mbwwBHqEbX6Q3XZRksCHWDvE15EsW775nV3mRj4J
         LyWy7L4wY+JGDRpeIHUA8N2BDneEf3op0RafUiYeUzZ1oZYafDpWmG0C3+WjNvWOnUvC
         t6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU78oywlQUJeGpH4+T7WuSB06wh1HxoD6qVPjrT/N7mbrSS3AZ5qE454nv8orJiTifNFtz+3V7/r7WVIAzi4CY=@vger.kernel.org, AJvYcCVKXnnr49KCsxRvw+s+zZZ3BVxAOM4K3rc81tIl0quMLTwOFrleSkc9CsN1/VlYf3vdrVVI+fYXaflsog==@vger.kernel.org, AJvYcCVWGbIVNfswvkRCLBnGFuynym4Ev/Hh2Q2dxk3aNkzSytBsdBACLanGg/3Jb87K+6o2XWV+LA1ZuRqk@vger.kernel.org, AJvYcCVuw29VBgLRdLApw6U3MUyisCv4HkyCmbvI6DzpDPaLdUUM8ueZqC4toNLdwSpRolMnwk7x6F6Zuh4N+g==@vger.kernel.org, AJvYcCW3I0qXwEXtVoM+fuio8W607eVFFQN99IMIwXGEUSZ6WSxVddtIIx7y47gd49C7BbyiWuw5Y73DT5x5YM7K@vger.kernel.org, AJvYcCWWGlKU2Gwp7ZlVdZjSrxYmBzmX6kMXFntLsvNH7i8wVAnW3GigvJTlmm9mcfmV8P2pa/ubd5u8G7iH@vger.kernel.org, AJvYcCX5KafhXLOytWOsPI+39SbE9LP5fDLNhsc7VHz5Vd99pkNbkSYLPCzqS0QRb2V+Z8VavO4=@vger.kernel.org, AJvYcCXz4NSTmmz7nRWf2hJNf/SJ5veWUDigAPgvd96MkAeLN0NbjP4PcRP+cR57X2F+b6EuxsZhM4TycZAw2uE9ODcE@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNYpWRAZRsX8plConqTKZqr3p3mzXq+Ja8vb+JJoWV7LoCB6k
	WRmWmYVGAI5dPVWQ+25SIwyohKM1NDvU8JEf6zqMVMWALP0mqGZPjdQQJn/Gz2s=
X-Google-Smtp-Source: AGHT+IEgW/YjRV6I5AmJ/mBzBZGEWBcDxNEAGQpANYhMnRAlvyIjyPQThvC+SjMr0Xf12bRSa0kQgg==
X-Received: by 2002:a17:90b:52c6:b0:2ea:5dcf:6f74 with SMTP id 98e67ed59e1d1-2ea5dcf7122mr6227597a91.3.1731940393805;
        Mon, 18 Nov 2024 06:33:13 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:13 -0800 (PST)
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
Subject: [PATCH net-next v4 0/5] net: Improve netns handling in RTNL and ip_tunnel
Date: Mon, 18 Nov 2024 22:32:39 +0800
Message-ID: <20241118143244.1773-1-shaw.leon@gmail.com>
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

---

v4:
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


Xiao Liang (5):
  net: ip_tunnel: Build flow in underlay net namespace
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Decouple net namespaces in rtnl_newlink_create()
  selftests: net: Add python context manager for netns entering
  selftests: net: Add two test cases for link netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  | 11 ++++--
 drivers/net/amt.c                             | 13 ++++---
 drivers/net/bareudp.c                         | 11 ++++--
 drivers/net/bonding/bond_netlink.c            |  8 ++--
 drivers/net/can/dev/netlink.c                 |  4 +-
 drivers/net/can/vxcan.c                       | 11 ++++--
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 11 ++++--
 drivers/net/geneve.c                          | 11 ++++--
 drivers/net/gtp.c                             |  9 +++--
 drivers/net/ipvlan/ipvlan.h                   |  4 +-
 drivers/net/ipvlan/ipvlan_main.c              | 11 ++++--
 drivers/net/ipvlan/ipvtap.c                   |  7 ++--
 drivers/net/macsec.c                          | 11 ++++--
 drivers/net/macvlan.c                         |  8 ++--
 drivers/net/macvtap.c                         |  8 ++--
 drivers/net/netkit.c                          | 11 ++++--
 drivers/net/pfcp.c                            |  8 ++--
 drivers/net/ppp/ppp_generic.c                 | 10 +++--
 drivers/net/team/team_core.c                  |  7 ++--
 drivers/net/veth.c                            | 11 ++++--
 drivers/net/vrf.c                             |  7 ++--
 drivers/net/vxlan/vxlan_core.c                | 11 ++++--
 drivers/net/wireguard/device.c                |  8 ++--
 drivers/net/wireless/virtual/virt_wifi.c      | 10 +++--
 drivers/net/wwan/wwan_core.c                  | 15 +++++--
 include/net/ip_tunnels.h                      |  5 ++-
 include/net/rtnetlink.h                       | 34 +++++++++++++---
 net/8021q/vlan_netlink.c                      | 11 ++++--
 net/batman-adv/soft-interface.c               |  8 ++--
 net/bridge/br_netlink.c                       |  8 ++--
 net/caif/chnl_net.c                           |  6 +--
 net/core/rtnetlink.c                          | 29 +++++++++-----
 net/hsr/hsr_netlink.c                         | 14 ++++---
 net/ieee802154/6lowpan/core.c                 |  9 +++--
 net/ipv4/ip_gre.c                             | 27 ++++++++-----
 net/ipv4/ip_tunnel.c                          | 16 ++++----
 net/ipv4/ip_vti.c                             | 10 +++--
 net/ipv4/ipip.c                               | 10 +++--
 net/ipv6/ip6_gre.c                            | 28 +++++++------
 net/ipv6/ip6_tunnel.c                         | 16 ++++----
 net/ipv6/ip6_vti.c                            | 15 ++++---
 net/ipv6/sit.c                                | 16 ++++----
 net/xfrm/xfrm_interface_core.c                | 14 +++----
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/netns.py   | 18 +++++++++
 tools/testing/selftests/net/netns-name.sh     | 10 +++++
 tools/testing/selftests/net/netns_atomic.py   | 39 +++++++++++++++++++
 48 files changed, 377 insertions(+), 205 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.0


