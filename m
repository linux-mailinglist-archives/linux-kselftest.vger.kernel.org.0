Return-Path: <linux-kselftest+bounces-23039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A179E9811
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537C41886199
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086DA1A2390;
	Mon,  9 Dec 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo1QlyJu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62435971;
	Mon,  9 Dec 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752950; cv=none; b=Lz+3oGG15a7YMNKobOSXtZ0zVd2DWFloBdr31RSN6TLFP/gKqg/jpdJG8dFmZ5HZR9xgm9vd9xmWS5plCh2tGaiSXs8yH4M8ls9L61o2OsUoKSSz0IjMYn7582rkbbtAY5e9ALIMjhmseDgj2EG1V3vpRDljiEcXrqpluD7S0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752950; c=relaxed/simple;
	bh=03xiu9pYOCrdNfcv/qw+gwiZHTNUJB2+YIld69kTu/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYRgf5hx29N50KuLNLiVN89h/etY7Dcf5MY0SZPfjXCiRNzHcC66qbPdOFMVZitH/J1KY/hPl7eVYyfcnFKeO0hHc2G/rrujEi2f2hFUPe/gvHxDdF44M9VJ+eoaycnWquvD55Y/OjdnAq3O7Tfto8b6Ecfte3gHmOF0PRyrzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo1QlyJu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2165448243fso9431105ad.1;
        Mon, 09 Dec 2024 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733752948; x=1734357748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAhPp2pGpsvDTqVI2eQ221kABd4Y8/kh7k1mWyeQzTw=;
        b=Zo1QlyJu+XBbTOO3w8tdc1A3K2lJwyV/8N78TenKl/WSv6/43Mh7ynbcJQrT7vuJEB
         VZit3+tvX2NY/mI42fkzQoSLYEW3NT/9F2egqk0KFHPOCbC6N0K6X1e1r586nvaa2Yng
         Btx9WB9mwHnpmkyoB5eUWqQz1r8gNo4MmlxqhoGWoJapaff6XG/oBURLapB2gsYB/yKZ
         dE44RyCUSMneeMPQYUhg3wpdx73MVunOvpT+K+ThEnmI1lwrGGZqg3ybUXBJFkSr/h4U
         Y58cYcTR3OdBAR09eBO3kUrvEIbxNMdIPybE1boYdMKyQEzLCqKzPX43Qe7DNxizHkFz
         tmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752948; x=1734357748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAhPp2pGpsvDTqVI2eQ221kABd4Y8/kh7k1mWyeQzTw=;
        b=viUPrGf0LTdi2fKoIcPWM6KEiBrdjAbXkS7TyclAjmP5uaG4ASY5zbYncggROaOgWz
         AIw17krdv5HlX91kMP1v+AIBVIim3dVPaeaFFcatxTlkOc7xTmJ77ajDjTyKEPiAlppx
         zmrkbLl+PeVfhrQp+nUKzNfIWgtMfE4mQ6i1JIcNtV2mWpYfgVxtQG1D0lgRmQJVpSqh
         W0O12xyCmoMV58k/ErBXZrHNaN/Oi2yBDxaqAUDAcmIGfec3xLoHBizX1v5Sn1GXovm9
         4B39Klvm5eZXO9t7QX8IbcGmpXafpZSFaz5vHWZi4cJC6DoEwm1dnL87dpL8WpRQlDJM
         1KBA==
X-Forwarded-Encrypted: i=1; AJvYcCU0lTN3rPXi3GK74dAIoY+HvFm2QvDwqGRWibMh3iUyvuK8z9AtURRUTg1XrQuiJXnjuv8=@vger.kernel.org, AJvYcCU8zqng2OpiE4vF46u6tgfE0IiNPcMXclVlVkGR1a+l2E49IxSxOGK9HnZuHwVBiSrjexlQ5ZQ3yHq65Q==@vger.kernel.org, AJvYcCUut6kck6f7uekoEuNhbB+dMXd4pNcViDq+Xt0z+Q8bXjY7AGzwurKu4Li2rsGWmP6tjSNyIfrzWmq7TQP5@vger.kernel.org, AJvYcCVP5UPLy/lrrB+k231xlOjSzzsrEL0VSPAVimVEzQjKEQ/XekITzjBmddfFmNxRv/TASU7ctTSdh71Y/RzR0L0=@vger.kernel.org, AJvYcCVd87fNDyW6jeItN+eFfXEW3vY78KV05tGRUWfG9kTW6ptS8j/vAaplk4MDQEKUzcDSeX5OC+JV4nTE@vger.kernel.org, AJvYcCWTDJdpCu/thTEae5mrZaHodfTkRkdESIjSKkYYkKoRpfV/+9PCLlK2oEgK3i7dL4jYVNVRZD3V496uhQ==@vger.kernel.org, AJvYcCWeqcqxbgFTCL/2FbBgD0RIawwsIUdaUc2OKMjU+fCcVtNOn9m/DBpyoN0iGN/3OqPuZxVlUKEDKrEXlgFvknQ7@vger.kernel.org, AJvYcCWqr0rJjQoksMWKY1Rbp3RDMyUZRfRqzepzLYxuDUwdOaX9FHMMlL0gQ/5MaK0vHTR23IENwoaeUsqI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Y2iJ6sjZX0kqTyUavxQoPxS+LN7DE9T4BpL9iEH9f/ZtlDxe
	rLO+azhVPQKKYXayWI/Qo+U7nTHa64llceccduYhdUFZpeV1Kak8TIpUMdOfvnY=
X-Gm-Gg: ASbGncvT4vtOE3nJYWZzhvSf/xsuFhmXbmcOEWuKpbAgae6Dtc/WY1q/zZw8yw65iFq
	iKlooPPJE1cc+grS0rKaoCVdrpa6+rL3OLTctBwB56koLbRtTofkzdn/tI47k2OzxPdzkYrWssN
	l1rLpC/5ElH0lmP34DMBWD1BhwE6hOmp+UecQ22yxrj7uuDyI4AMtai07Xx7Gzj0RVTPJLHlzQU
	PcQbXKemkhmX2sceCS4pjKPmq2SUWmtwOqPqNfYvIfqTQ4=
X-Google-Smtp-Source: AGHT+IEziqjANISe8V7T1b1Vo9dS8nge43qoErTxjCtNhfTplDp9qnHGPIzO4tjQCtyFccSJFTBRCw==
X-Received: by 2002:a17:902:e74f:b0:216:4122:925f with SMTP id d9443c01a7336-21641229442mr90363145ad.14.1733752948110;
        Mon, 09 Dec 2024 06:02:28 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:02:26 -0800 (PST)
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
Subject: [PATCH net-next v5 0/5] net: Improve netns handling in RTNL and ip_tunnel
Date: Mon,  9 Dec 2024 22:01:46 +0800
Message-ID: <20241209140151.231257-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
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

v5:
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


Xiao Liang (5):
  net: ip_tunnel: Build flow in underlay net namespace
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Decouple net namespaces in rtnl_newlink_create()
  selftests: net: Add python context manager for netns entering
  selftests: net: Add two test cases for link netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  | 11 +++--
 drivers/net/amt.c                             | 13 +++---
 drivers/net/bareudp.c                         | 11 +++--
 drivers/net/bonding/bond_netlink.c            |  8 ++--
 drivers/net/can/dev/netlink.c                 |  4 +-
 drivers/net/can/vxcan.c                       |  9 ++--
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 11 +++--
 drivers/net/geneve.c                          | 11 +++--
 drivers/net/gtp.c                             |  9 ++--
 drivers/net/ipvlan/ipvlan.h                   |  4 +-
 drivers/net/ipvlan/ipvlan_main.c              | 11 +++--
 drivers/net/ipvlan/ipvtap.c                   |  7 ++-
 drivers/net/macsec.c                          | 11 +++--
 drivers/net/macvlan.c                         |  8 ++--
 drivers/net/macvtap.c                         |  8 ++--
 drivers/net/netkit.c                          |  9 ++--
 drivers/net/pfcp.c                            |  8 ++--
 drivers/net/ppp/ppp_generic.c                 | 10 +++--
 drivers/net/team/team_core.c                  |  7 +--
 drivers/net/veth.c                            |  9 ++--
 drivers/net/vrf.c                             |  7 +--
 drivers/net/vxlan/vxlan_core.c                | 11 +++--
 drivers/net/wireguard/device.c                |  8 ++--
 drivers/net/wireless/virtual/virt_wifi.c      | 10 +++--
 drivers/net/wwan/wwan_core.c                  | 15 +++++--
 include/net/ip_tunnels.h                      |  5 ++-
 include/net/rtnetlink.h                       | 44 ++++++++++++++++---
 net/8021q/vlan_netlink.c                      | 11 +++--
 net/batman-adv/soft-interface.c               | 12 ++---
 net/bridge/br_netlink.c                       |  8 ++--
 net/caif/chnl_net.c                           |  6 +--
 net/core/rtnetlink.c                          | 35 ++++++++-------
 net/hsr/hsr_netlink.c                         | 14 +++---
 net/ieee802154/6lowpan/core.c                 |  9 ++--
 net/ipv4/ip_gre.c                             | 27 ++++++++----
 net/ipv4/ip_tunnel.c                          | 16 ++++---
 net/ipv4/ip_vti.c                             | 10 +++--
 net/ipv4/ipip.c                               | 10 +++--
 net/ipv6/ip6_gre.c                            | 28 +++++++-----
 net/ipv6/ip6_tunnel.c                         | 16 +++----
 net/ipv6/ip6_vti.c                            | 15 +++----
 net/ipv6/sit.c                                | 16 +++----
 net/xfrm/xfrm_interface_core.c                | 14 +++---
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/netns.py   | 18 ++++++++
 tools/testing/selftests/net/netns-name.sh     | 10 +++++
 tools/testing/selftests/net/netns_atomic.py   | 39 ++++++++++++++++
 48 files changed, 385 insertions(+), 211 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.1


