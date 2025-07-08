Return-Path: <linux-kselftest+bounces-36772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB942AFDA7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DED3AF01D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6C2522BA;
	Tue,  8 Jul 2025 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu9XXfdk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941E242D65;
	Tue,  8 Jul 2025 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012408; cv=none; b=kyZJYgRGKLWQ97Mh2oxn/n91KQuqvXfueF6JiGYuNR9ZA+GEvau+D+5Rrt+HpSU6YGcDT8GNUeeDUEFgYxGiZ55zZnY5rvMSypoMIppHaJFROqXOWBeGYKE80ck4gxVlt4iPLAtmvHJca86B4oECXYpxDxnP0cATQaGi55P38K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012408; c=relaxed/simple;
	bh=XFrJ61lGr+4bVVxkusVAUAshidgsBdkeH8G9lm+QjMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFnKq8JBYId9p1zAOwUchpv1+DKdEHKZ9ryDZ65/IsyXRCKTCoeWELqwAiCCWgVDO3p0SDmjXv7b7lh9naqTIanumYmyC3G+TMmYkqWse2EEQ0IiOz1t4RjYxqMzqQzUnoHgD0NH37axymCk/L4U4N97mcOIo7MhieElIjVeLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu9XXfdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D59EC4CEED;
	Tue,  8 Jul 2025 22:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752012408;
	bh=XFrJ61lGr+4bVVxkusVAUAshidgsBdkeH8G9lm+QjMI=;
	h=From:To:Cc:Subject:Date:From;
	b=Qu9XXfdkAzBQHF4qtf+sTatbnPjpnvvmH6AGv3OuWKMaYMEErSLsFCN0gFFqZ5vZt
	 7MwvHV+7M+YVVYw6Hccyobp23HPT7hOAvFZhzViP7F/RWY1mTROT1HVFfoG/vE8Yb6
	 CP42Ui/G84vU88iR8SPc8XvLSNd820MmlOoVp+AxNZcaErm8MTJMxdOc66U6iEQ+Ag
	 itI8tgoziba7s5JAZVBK4PgamqZgbOZZ29J33Tqp0MS/le9MGdQWyRVPtE2eZrJDld
	 E2eUvQ/eXCs1yp5ifDLpTerlwOu5K+UKEsM5zJIBW8n6EKy5Qh6ewXnBW1VzYxeee9
	 SH46HBiez7PNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	maxime.chevallier@bootlin.com,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] ethtool: rss: report which fields are configured for hashing
Date: Tue,  8 Jul 2025 15:06:35 -0700
Message-ID: <20250708220640.2738464-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading flow hash configuration via Netlink ethtool.

  $ ynl --family ethtool --dump rss-get
     [{
        "header": {
            "dev-index": 1,
            "dev-name": "enp1s0"
        },
        "hfunc": 1,
        "hkey": b"...",
        "indir": [0, 1, ...],
        "flow-hash": {
            "ether": {"l2da"},
            "ah-esp4": {"ip-src", "ip-dst"},
            "ah-esp6": {"ip-src", "ip-dst"},
            "ah4": {"ip-src", "ip-dst"},
            "ah6": {"ip-src", "ip-dst"},
            "esp4": {"ip-src", "ip-dst"},
            "esp6": {"ip-src", "ip-dst"},
            "ip4": {"ip-src", "ip-dst"},
            "ip6": {"ip-src", "ip-dst"},
            "sctp4": {"ip-src", "ip-dst"},
            "sctp6": {"ip-src", "ip-dst"},
            "udp4": {"ip-src", "ip-dst"},
            "udp6": {"ip-src", "ip-dst"}
            "tcp4": {"l4-b-0-1", "l4-b-2-3", "ip-src", "ip-dst"},
            "tcp6": {"l4-b-0-1", "l4-b-2-3", "ip-src", "ip-dst"},
        },
     }]

Jakub Kicinski (5):
  ethtool: rss: make sure dump takes the rss lock
  tools: ynl: decode enums in auto-ints
  ethtool: mark ETHER_FLOW as usable for Rx hash
  ethtool: rss: report which fields are configured for hashing
  selftests: drv-net: test RSS header field configuration

 Documentation/netlink/specs/ethtool.yaml      | 151 ++++++++++++++++++
 Documentation/networking/ethtool-netlink.rst  |   9 +-
 include/uapi/linux/ethtool.h                  |   4 +-
 .../uapi/linux/ethtool_netlink_generated.h    |  34 ++++
 net/ethtool/ioctl.c                           |   7 +-
 net/ethtool/rss.c                             | 145 +++++++++++++----
 tools/net/ynl/pyynl/lib/ynl.py                |   2 +
 .../selftests/drivers/net/hw/rss_api.py       |  47 ++++++
 8 files changed, 364 insertions(+), 35 deletions(-)

-- 
2.50.0


