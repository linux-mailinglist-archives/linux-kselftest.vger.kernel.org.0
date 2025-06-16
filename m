Return-Path: <linux-kselftest+bounces-35105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944D4ADB69C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB441890C48
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A99820C030;
	Mon, 16 Jun 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifz+QRt0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F220FAA4;
	Mon, 16 Jun 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090886; cv=none; b=AnMnVUknBhyW8oLdL2MRMGthPYyv4li2WBzChjNsEE7cTqq3bxOa7bH0Xig7DqqgczffWzvSmNtIMGDbqzZLCsVT1wtWgVilOVHU8NciJ2JVVUHNuK3cHlJwxB621J1ROnG89f8/HpSRQ8ZWMKXaxX7/VNheD0dakOwSlB+bBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090886; c=relaxed/simple;
	bh=KY6IiRl6p2PlEPEvdZnbvsSCfFOcMhrTRPlkAhtYd20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=betKugUmLR9vZPBXL4140IVQQj+phBQv5G+/1V0ZUXWdyDHIp2+yXFJQ4uFv6BfPY/Ulk8BKgs08mj3tM6+rwuFK8cE+KtBHoGPuv42KtPN/nAk8CMFyFxb48t2jMc50srQIEM3t77fkzSX7k1LJS6yJgBK42REL7YaNkqs+M6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifz+QRt0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235ea292956so42141295ad.1;
        Mon, 16 Jun 2025 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750090883; x=1750695683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEUUsHlzqWUQPhx/paAUd1ykUlSo8UWhiWmoQqL46tk=;
        b=ifz+QRt0ZzkZVuWF6atohIrGyBhsqVBAkUbrcCxrbJE9lXLf0U1GviDt9nMkC6b9ya
         WEqP4MVjNNWO1lt/5746bnxRyriVEbLpqpOQAHJ2Uxw/HsQOXHiLXqtzepHpx3y3Zy8G
         NnxznBLO//OnpFT5dyBw4hsUUEabLuZ1UFA//vwde8RXFnTW5f7duslKOWQlKRMBYMVd
         I3Xv0ibSBnh6r3Y2TzxLmvPsCUi4zup2l/exeEfhzcgInFaZpmBeDPORp8OmO9TdWVel
         Fjjo3R3eh+smCeKV4KiEjPUttgArGaC0imOKYBendBGsaukPc9wg7kWiZIDTQh5OkGJR
         WrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090883; x=1750695683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEUUsHlzqWUQPhx/paAUd1ykUlSo8UWhiWmoQqL46tk=;
        b=b7G5IH/8norVPRkRzumSjv3kITANIlKVjNjMrYzu+NVEeNiy/li/U+pMrNzDt5POdN
         8DY3fao6Qsizbtjppa0KFSLKKfef2aK/dDEv/iCTFcq+d/Mzkego6n/aDBs44vnDyE3K
         wkz0OmP/SUmYWVI30KYIY/jFVpmROklXc0JUWqSLcDMZsz1ZIlDhxMuv6WGHVgLUHvYf
         brZpbt3oNoupuD4iBocp9RT0MafDfnGw3k8gBBahTh20dTchmcIZFqcaluRKfZMk1SvB
         fUHo3xnRrQc3/xneE4biCIlYCrbhkCmDJPrg8Ff9jK3xCMXDFcAf9oJgtDxc1oKYO2dD
         igRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBNGwECDy9qIAx9mS7gxXeXieT1MDKf3AFFJmeJMJ4BZcErTao/8Q/rlye5Cgjk4iTEVArMD4GNUUhejNmHiyA@vger.kernel.org, AJvYcCUpCKmQjXGZ9zrhGc9bd4FYwV6sUkL8U/Q039ZusZ0ia94CvM9KShOLxSKOdGg1AkDY9xHKf4LHsofLifM=@vger.kernel.org, AJvYcCX7TyYRBJYq4EHi25vei+7DTrcLxBAPzNC7u9Vx1IbagiXVwbkPa/NuDUS4NwdBfYmN7kztKQL0rCPcPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2M5ntLS4oz/ztxPmHfOFrekdroKlL2w8yTJPQpsdGbUyci/e
	w7k3zYm57/6LEJ/KfEtxYqyuCCK+tafxFtGWNyYCFfwQbuQqG1LkFyg/cFdc
X-Gm-Gg: ASbGncvM7iv3qyys0QuvY18DRhzFN7j1SM28LGFqoP8rog4X2iIuxy/UMZz28M9yshp
	lECujsz8/DrmjRCTYTe4XcLxi4A9DOf+y87bD+QwhfcCXEtOh7sY8rq7HsujUdTp9xm2qxsm1ol
	2qDv1Z8ifC8YGfHdzz21nKeFpjtAzD3QryZ04ZQK4GQ/9bT1JoOMlRC0Dmn0GptfWLF+0fxXxBT
	kw6fT4cngKaslva+GOgjnPffSRdJl1N9Jk5knOvOwXHA0XQzfHXxovPNV2SpRholk/BWz/TJ21r
	HIA+xbBX4/DaJ/no78M3fajl971m5ZPp8qgCQbYOXfVn3mioxWmMgwY4Ta3LqAoJmxuxhrpZXcj
	UIUGG5LGGBjlmQCGprUMS2DM=
X-Google-Smtp-Source: AGHT+IFVtwHur230ABZ+F3dpDob/8VZnaMCzxdgSsvSbg8eDNxQGKmLOd+byj774QWmhx80wWzGP2w==
X-Received: by 2002:a17:902:e54a:b0:235:ef67:b5a0 with SMTP id d9443c01a7336-2366b14e37amr154528915ad.36.1750090882657;
        Mon, 16 Jun 2025 09:21:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365dea88desm63131615ad.150.2025.06.16.09.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:21:22 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	louis.peens@corigine.com,
	shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	mingo@kernel.org,
	ruanjinjie@huawei.com,
	idosch@nvidia.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	kuniyu@google.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v5 3/6] udp_tunnel: remove rtnl_lock dependency
Date: Mon, 16 Jun 2025 09:21:14 -0700
Message-ID: <20250616162117.287806-4-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616162117.287806-1-stfomichev@gmail.com>
References: <20250616162117.287806-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers that are using ops lock and don't depend on RTNL lock
still need to manage it because udp_tunnel's RTNL dependency.
Introduce new udp_tunnel_nic_lock and use it instead of
rtnl_lock. Drop non-UDP_TUNNEL_NIC_INFO_MAY_SLEEP mode from
udp_tunnel infra (udp_tunnel_nic_device_sync_work needs to
grab udp_tunnel_nic_lock mutex and might sleep).

Cover more places in v4:

- netlink
  - udp_tunnel_notify_add_rx_port (ndo_open)
    - triggers udp_tunnel_nic_device_sync_work
  - udp_tunnel_notify_del_rx_port (ndo_stop)
    - triggers udp_tunnel_nic_device_sync_work
  - udp_tunnel_get_rx_info (__netdev_update_features)
    - triggers NETDEV_UDP_TUNNEL_PUSH_INFO
  - udp_tunnel_drop_rx_info (__netdev_update_features)
    - triggers NETDEV_UDP_TUNNEL_DROP_INFO
  - udp_tunnel_nic_reset_ntf (ndo_open)

- notifiers
  - udp_tunnel_nic_netdevice_event, depending on the event:
    - triggers NETDEV_UDP_TUNNEL_PUSH_INFO
    - triggers NETDEV_UDP_TUNNEL_DROP_INFO

- ethnl_tunnel_info_reply_size
- udp_tunnel_nic_set_port_priv (two intel drivers)

Cc: Michael Chan <michael.chan@broadcom.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  6 +-
 drivers/net/ethernet/emulex/benet/be_main.c   |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  1 -
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  3 +-
 .../net/ethernet/qlogic/qede/qede_filter.c    |  3 -
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  1 -
 drivers/net/ethernet/sfc/ef10.c               |  1 -
 drivers/net/netdevsim/udp_tunnels.c           |  4 -
 include/net/udp_tunnel.h                      | 87 ++++++++++++++-----
 net/core/dev.c                                |  2 +
 net/ipv4/udp_tunnel_core.c                    | 16 ++--
 net/ipv4/udp_tunnel_nic.c                     | 78 +++++++++++++----
 16 files changed, 142 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index c9a1a1d504c0..3ee4b848ef53 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -10219,8 +10219,7 @@ static int bnx2x_udp_tunnel_sync(struct net_device *netdev, unsigned int table)
 
 static const struct udp_tunnel_nic_info bnx2x_udp_tunnels = {
 	.sync_table	= bnx2x_udp_tunnel_sync,
-	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
-			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
+	.flags		= UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
 	.tables		= {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN,  },
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_GENEVE, },
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 869580b6f70d..7946586802af 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15573,8 +15573,7 @@ static int bnxt_udp_tunnel_unset_port(struct net_device *netdev, unsigned int ta
 static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
 	.set_port	= bnxt_udp_tunnel_set_port,
 	.unset_port	= bnxt_udp_tunnel_unset_port,
-	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
-			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
+	.flags		= UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
 	.tables		= {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN,  },
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_GENEVE, },
@@ -15582,8 +15581,7 @@ static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
 }, bnxt_udp_tunnels_p7 = {
 	.set_port	= bnxt_udp_tunnel_set_port,
 	.unset_port	= bnxt_udp_tunnel_unset_port,
-	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
-			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
+	.flags		= UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
 	.tables		= {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN,  },
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_GENEVE, },
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 3d2e21592119..f49400ba9729 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -4031,8 +4031,7 @@ static int be_vxlan_unset_port(struct net_device *netdev, unsigned int table,
 static const struct udp_tunnel_nic_info be_udp_tunnels = {
 	.set_port	= be_vxlan_set_port,
 	.unset_port	= be_vxlan_unset_port,
-	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
-			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
+	.flags		= UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
 	.tables		= {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN, },
 	},
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1156a5b3055c..3b4f59d978a5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15895,7 +15895,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pf->udp_tunnel_nic.set_port = i40e_udp_tunnel_set_port;
 	pf->udp_tunnel_nic.unset_port = i40e_udp_tunnel_unset_port;
-	pf->udp_tunnel_nic.flags = UDP_TUNNEL_NIC_INFO_MAY_SLEEP;
 	pf->udp_tunnel_nic.shared = &pf->udp_tunnel_shared;
 	pf->udp_tunnel_nic.tables[0].n_entries = I40E_MAX_PF_UDP_OFFLOAD_PORTS;
 	pf->udp_tunnel_nic.tables[0].tunnel_types = UDP_TUNNEL_TYPE_VXLAN |
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7959a65c0903..f8ef80069e3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4767,7 +4767,6 @@ int ice_init_dev(struct ice_pf *pf)
 
 	pf->hw.udp_tunnel_nic.set_port = ice_udp_tunnel_set_port;
 	pf->hw.udp_tunnel_nic.unset_port = ice_udp_tunnel_unset_port;
-	pf->hw.udp_tunnel_nic.flags = UDP_TUNNEL_NIC_INFO_MAY_SLEEP;
 	pf->hw.udp_tunnel_nic.shared = &pf->hw.udp_tunnel_shared;
 	if (pf->hw.tnl.valid_count[TNL_VXLAN]) {
 		pf->hw.udp_tunnel_nic.tables[0].n_entries =
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 281b34af0bb4..d2071aff7b8f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -2670,8 +2670,7 @@ static int mlx4_udp_tunnel_sync(struct net_device *dev, unsigned int table)
 
 static const struct udp_tunnel_nic_info mlx4_udp_tunnels = {
 	.sync_table	= mlx4_udp_tunnel_sync,
-	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
-			  UDP_TUNNEL_NIC_INFO_IPV4_ONLY,
+	.flags		= UDP_TUNNEL_NIC_INFO_IPV4_ONLY,
 	.tables		= {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN, },
 	},
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea822c69d137..ccde53f94045 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5303,8 +5303,7 @@ void mlx5e_vxlan_set_netdev_info(struct mlx5e_priv *priv)
 
 	priv->nic_info.set_port = mlx5e_vxlan_set_port;
 	priv->nic_info.unset_port = mlx5e_vxlan_unset_port;
-	priv->nic_info.flags = UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
-				UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN;
+	priv->nic_info.flags = UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN;
 	priv->nic_info.tables[0].tunnel_types = UDP_TUNNEL_TYPE_VXLAN;
 	/* Don't count the space hard-coded to the IANA port */
 	priv->nic_info.tables[0].n_entries =
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 932f59d70f41..132626a3f9f7 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2394,8 +2394,7 @@ static int nfp_udp_tunnel_sync(struct net_device *netdev, unsigned int table)
 
 static const struct udp_tunnel_nic_info nfp_udp_tunnels = {
 	.sync_table     = nfp_udp_tunnel_sync,
-	.flags          = UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
-			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
+	.flags          = UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
 	.tables         = {
 		{
 			.n_entries      = NFP_NET_N_VXLAN_PORTS,
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 985026dd816f..7e341e026489 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -987,20 +987,17 @@ static int qede_udp_tunnel_sync(struct net_device *dev, unsigned int table)
 
 static const struct udp_tunnel_nic_info qede_udp_tunnels_both = {
 	.sync_table	= qede_udp_tunnel_sync,
-	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP,
 	.tables		= {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN,  },
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_GENEVE, },
 	},
 }, qede_udp_tunnels_vxlan = {
 	.sync_table	= qede_udp_tunnel_sync,
-	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP,
 	.tables		= {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN,  },
 	},
 }, qede_udp_tunnels_geneve = {
 	.sync_table	= qede_udp_tunnel_sync,
-	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP,
 	.tables		= {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_GENEVE, },
 	},
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index eb69121df726..53cdd36c4123 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -486,7 +486,6 @@ static int qlcnic_udp_tunnel_sync(struct net_device *dev, unsigned int table)
 
 static const struct udp_tunnel_nic_info qlcnic_udp_tunnels = {
 	.sync_table	= qlcnic_udp_tunnel_sync,
-	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP,
 	.tables		= {
 		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN, },
 	},
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 47349c148c0c..fcec81f862ec 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -3985,7 +3985,6 @@ static int efx_ef10_udp_tnl_unset_port(struct net_device *dev,
 static const struct udp_tunnel_nic_info efx_ef10_udp_tunnels = {
 	.set_port	= efx_ef10_udp_tnl_set_port,
 	.unset_port	= efx_ef10_udp_tnl_unset_port,
-	.flags          = UDP_TUNNEL_NIC_INFO_MAY_SLEEP,
 	.tables         = {
 		{
 			.n_entries = 16,
diff --git a/drivers/net/netdevsim/udp_tunnels.c b/drivers/net/netdevsim/udp_tunnels.c
index 640b4983a9a0..10cbbf1c584b 100644
--- a/drivers/net/netdevsim/udp_tunnels.c
+++ b/drivers/net/netdevsim/udp_tunnels.c
@@ -112,12 +112,10 @@ nsim_udp_tunnels_info_reset_write(struct file *file, const char __user *data,
 	struct net_device *dev = file->private_data;
 	struct netdevsim *ns = netdev_priv(dev);
 
-	rtnl_lock();
 	if (dev->reg_state == NETREG_REGISTERED) {
 		memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
 		udp_tunnel_nic_reset_ntf(dev);
 	}
-	rtnl_unlock();
 
 	return count;
 }
@@ -181,8 +179,6 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
 		info->sync_table = NULL;
 	}
 
-	if (ns->udp_ports.sleep)
-		info->flags |= UDP_TUNNEL_NIC_INFO_MAY_SLEEP;
 	if (nsim_dev->udp_ports.open_only)
 		info->flags |= UDP_TUNNEL_NIC_INFO_OPEN_ONLY;
 	if (nsim_dev->udp_ports.ipv4_only)
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 2df3b8344eb5..0106e2dc2af1 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -130,22 +130,6 @@ void udp_tunnel_drop_rx_port(struct net_device *dev, struct socket *sock,
 void udp_tunnel_notify_add_rx_port(struct socket *sock, unsigned short type);
 void udp_tunnel_notify_del_rx_port(struct socket *sock, unsigned short type);
 
-static inline void udp_tunnel_get_rx_info(struct net_device *dev)
-{
-	ASSERT_RTNL();
-	if (!(dev->features & NETIF_F_RX_UDP_TUNNEL_PORT))
-		return;
-	call_netdevice_notifiers(NETDEV_UDP_TUNNEL_PUSH_INFO, dev);
-}
-
-static inline void udp_tunnel_drop_rx_info(struct net_device *dev)
-{
-	ASSERT_RTNL();
-	if (!(dev->features & NETIF_F_RX_UDP_TUNNEL_PORT))
-		return;
-	call_netdevice_notifiers(NETDEV_UDP_TUNNEL_DROP_INFO, dev);
-}
-
 /* Transmit the skb using UDP encapsulation. */
 void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
 			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
@@ -221,19 +205,17 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
 #define UDP_TUNNEL_NIC_MAX_TABLES	4
 
 enum udp_tunnel_nic_info_flags {
-	/* Device callbacks may sleep */
-	UDP_TUNNEL_NIC_INFO_MAY_SLEEP	= BIT(0),
 	/* Device only supports offloads when it's open, all ports
 	 * will be removed before close and re-added after open.
 	 */
-	UDP_TUNNEL_NIC_INFO_OPEN_ONLY	= BIT(1),
+	UDP_TUNNEL_NIC_INFO_OPEN_ONLY	= BIT(0),
 	/* Device supports only IPv4 tunnels */
-	UDP_TUNNEL_NIC_INFO_IPV4_ONLY	= BIT(2),
+	UDP_TUNNEL_NIC_INFO_IPV4_ONLY	= BIT(1),
 	/* Device has hard-coded the IANA VXLAN port (4789) as VXLAN.
 	 * This port must not be counted towards n_entries of any table.
 	 * Driver will not receive any callback associated with port 4789.
 	 */
-	UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN	= BIT(3),
+	UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN	= BIT(2),
 };
 
 struct udp_tunnel_nic;
@@ -324,6 +306,9 @@ struct udp_tunnel_nic_ops {
 	size_t (*dump_size)(struct net_device *dev, unsigned int table);
 	int (*dump_write)(struct net_device *dev, unsigned int table,
 			  struct sk_buff *skb);
+	void (*assert_locked)(struct net_device *dev);
+	void (*lock)(struct net_device *dev);
+	void (*unlock)(struct net_device *dev);
 };
 
 #ifdef CONFIG_INET
@@ -352,8 +337,29 @@ static inline void
 udp_tunnel_nic_set_port_priv(struct net_device *dev, unsigned int table,
 			     unsigned int idx, u8 priv)
 {
-	if (udp_tunnel_nic_ops)
+	if (udp_tunnel_nic_ops) {
+		udp_tunnel_nic_ops->lock(dev);
 		udp_tunnel_nic_ops->set_port_priv(dev, table, idx, priv);
+		udp_tunnel_nic_ops->unlock(dev);
+	}
+}
+
+static inline void udp_tunnel_nic_assert_locked(struct net_device *dev)
+{
+	if (udp_tunnel_nic_ops)
+		udp_tunnel_nic_ops->assert_locked(dev);
+}
+
+static inline void udp_tunnel_nic_lock(struct net_device *dev)
+{
+	if (udp_tunnel_nic_ops)
+		udp_tunnel_nic_ops->lock(dev);
+}
+
+static inline void udp_tunnel_nic_unlock(struct net_device *dev)
+{
+	if (udp_tunnel_nic_ops)
+		udp_tunnel_nic_ops->unlock(dev);
 }
 
 static inline void
@@ -395,17 +401,50 @@ static inline void udp_tunnel_nic_reset_ntf(struct net_device *dev)
 static inline size_t
 udp_tunnel_nic_dump_size(struct net_device *dev, unsigned int table)
 {
+	size_t ret;
+
 	if (!udp_tunnel_nic_ops)
 		return 0;
-	return udp_tunnel_nic_ops->dump_size(dev, table);
+
+	udp_tunnel_nic_ops->lock(dev);
+	ret = udp_tunnel_nic_ops->dump_size(dev, table);
+	udp_tunnel_nic_ops->unlock(dev);
+
+	return ret;
 }
 
 static inline int
 udp_tunnel_nic_dump_write(struct net_device *dev, unsigned int table,
 			  struct sk_buff *skb)
 {
+	int ret;
+
 	if (!udp_tunnel_nic_ops)
 		return 0;
-	return udp_tunnel_nic_ops->dump_write(dev, table, skb);
+
+	udp_tunnel_nic_ops->lock(dev);
+	ret = udp_tunnel_nic_ops->dump_write(dev, table, skb);
+	udp_tunnel_nic_ops->unlock(dev);
+
+	return ret;
+}
+
+static inline void udp_tunnel_get_rx_info(struct net_device *dev)
+{
+	ASSERT_RTNL();
+	if (!(dev->features & NETIF_F_RX_UDP_TUNNEL_PORT))
+		return;
+	udp_tunnel_nic_assert_locked(dev);
+	call_netdevice_notifiers(NETDEV_UDP_TUNNEL_PUSH_INFO, dev);
 }
+
+static inline void udp_tunnel_drop_rx_info(struct net_device *dev)
+{
+	ASSERT_RTNL();
+	if (!(dev->features & NETIF_F_RX_UDP_TUNNEL_PORT))
+		return;
+	udp_tunnel_nic_assert_locked(dev);
+	call_netdevice_notifiers(NETDEV_UDP_TUNNEL_DROP_INFO, dev);
+}
+
 #endif
diff --git a/net/core/dev.c b/net/core/dev.c
index 5baa4691074f..43f56b44f351 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10771,12 +10771,14 @@ int __netdev_update_features(struct net_device *dev)
 			 * *before* calling udp_tunnel_get_rx_info,
 			 * but *after* calling udp_tunnel_drop_rx_info.
 			 */
+			udp_tunnel_nic_lock(dev);
 			if (features & NETIF_F_RX_UDP_TUNNEL_PORT) {
 				dev->features = features;
 				udp_tunnel_get_rx_info(dev);
 			} else {
 				udp_tunnel_drop_rx_info(dev);
 			}
+			udp_tunnel_nic_unlock(dev);
 		}
 
 		if (diff & NETIF_F_HW_VLAN_CTAG_FILTER) {
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 2326548997d3..433283dd0e70 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -134,15 +134,17 @@ void udp_tunnel_notify_add_rx_port(struct socket *sock, unsigned short type)
 	struct udp_tunnel_info ti;
 	struct net_device *dev;
 
+	ASSERT_RTNL();
+
 	ti.type = type;
 	ti.sa_family = sk->sk_family;
 	ti.port = inet_sk(sk)->inet_sport;
 
-	rcu_read_lock();
-	for_each_netdev_rcu(net, dev) {
+	for_each_netdev(net, dev) {
+		udp_tunnel_nic_lock(dev);
 		udp_tunnel_nic_add_port(dev, &ti);
+		udp_tunnel_nic_unlock(dev);
 	}
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_notify_add_rx_port);
 
@@ -154,15 +156,17 @@ void udp_tunnel_notify_del_rx_port(struct socket *sock, unsigned short type)
 	struct udp_tunnel_info ti;
 	struct net_device *dev;
 
+	ASSERT_RTNL();
+
 	ti.type = type;
 	ti.sa_family = sk->sk_family;
 	ti.port = inet_sk(sk)->inet_sport;
 
-	rcu_read_lock();
-	for_each_netdev_rcu(net, dev) {
+	for_each_netdev(net, dev) {
+		udp_tunnel_nic_lock(dev);
 		udp_tunnel_nic_del_port(dev, &ti);
+		udp_tunnel_nic_unlock(dev);
 	}
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_notify_del_rx_port);
 
diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index b6d2d16189c0..ff66db48453c 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -29,6 +29,7 @@ struct udp_tunnel_nic_table_entry {
  * struct udp_tunnel_nic - UDP tunnel port offload state
  * @work:	async work for talking to hardware from process context
  * @dev:	netdev pointer
+ * @lock:	protects all fields
  * @need_sync:	at least one port start changed
  * @need_replay: space was freed, we need a replay of all ports
  * @work_pending: @work is currently scheduled
@@ -41,6 +42,8 @@ struct udp_tunnel_nic {
 
 	struct net_device *dev;
 
+	struct mutex lock;
+
 	u8 need_sync:1;
 	u8 need_replay:1;
 	u8 work_pending:1;
@@ -298,22 +301,11 @@ __udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 static void
 udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 {
-	const struct udp_tunnel_nic_info *info = dev->udp_tunnel_nic_info;
-	bool may_sleep;
-
 	if (!utn->need_sync)
 		return;
 
-	/* Drivers which sleep in the callback need to update from
-	 * the workqueue, if we come from the tunnel driver's notification.
-	 */
-	may_sleep = info->flags & UDP_TUNNEL_NIC_INFO_MAY_SLEEP;
-	if (!may_sleep)
-		__udp_tunnel_nic_device_sync(dev, utn);
-	if (may_sleep || utn->need_replay) {
-		queue_work(udp_tunnel_nic_workqueue, &utn->work);
-		utn->work_pending = 1;
-	}
+	queue_work(udp_tunnel_nic_workqueue, &utn->work);
+	utn->work_pending = 1;
 }
 
 static bool
@@ -554,12 +546,12 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
 	struct udp_tunnel_nic *utn;
 	unsigned int i, j;
 
-	ASSERT_RTNL();
-
 	utn = dev->udp_tunnel_nic;
 	if (!utn)
 		return;
 
+	mutex_lock(&utn->lock);
+
 	utn->need_sync = false;
 	for (i = 0; i < utn->n_tables; i++)
 		for (j = 0; j < info->tables[i].n_entries; j++) {
@@ -569,7 +561,7 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
 
 			entry->flags &= ~(UDP_TUNNEL_NIC_ENTRY_DEL |
 					  UDP_TUNNEL_NIC_ENTRY_OP_FAIL);
-			/* We don't release rtnl across ops */
+			/* We don't release utn lock across ops */
 			WARN_ON(entry->flags & UDP_TUNNEL_NIC_ENTRY_FROZEN);
 			if (!entry->use_cnt)
 				continue;
@@ -579,6 +571,8 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
 		}
 
 	__udp_tunnel_nic_device_sync(dev, utn);
+
+	mutex_unlock(&utn->lock);
 }
 
 static size_t
@@ -643,6 +637,33 @@ __udp_tunnel_nic_dump_write(struct net_device *dev, unsigned int table,
 	return -EMSGSIZE;
 }
 
+static void __udp_tunnel_nic_assert_locked(struct net_device *dev)
+{
+	struct udp_tunnel_nic *utn;
+
+	utn = dev->udp_tunnel_nic;
+	if (utn)
+		lockdep_assert_held(&utn->lock);
+}
+
+static void __udp_tunnel_nic_lock(struct net_device *dev)
+{
+	struct udp_tunnel_nic *utn;
+
+	utn = dev->udp_tunnel_nic;
+	if (utn)
+		mutex_lock(&utn->lock);
+}
+
+static void __udp_tunnel_nic_unlock(struct net_device *dev)
+{
+	struct udp_tunnel_nic *utn;
+
+	utn = dev->udp_tunnel_nic;
+	if (utn)
+		mutex_unlock(&utn->lock);
+}
+
 static const struct udp_tunnel_nic_ops __udp_tunnel_nic_ops = {
 	.get_port	= __udp_tunnel_nic_get_port,
 	.set_port_priv	= __udp_tunnel_nic_set_port_priv,
@@ -651,6 +672,9 @@ static const struct udp_tunnel_nic_ops __udp_tunnel_nic_ops = {
 	.reset_ntf	= __udp_tunnel_nic_reset_ntf,
 	.dump_size	= __udp_tunnel_nic_dump_size,
 	.dump_write	= __udp_tunnel_nic_dump_write,
+	.assert_locked	= __udp_tunnel_nic_assert_locked,
+	.lock		= __udp_tunnel_nic_lock,
+	.unlock		= __udp_tunnel_nic_unlock,
 };
 
 static void
@@ -710,11 +734,15 @@ static void udp_tunnel_nic_device_sync_work(struct work_struct *work)
 		container_of(work, struct udp_tunnel_nic, work);
 
 	rtnl_lock();
+	mutex_lock(&utn->lock);
+
 	utn->work_pending = 0;
 	__udp_tunnel_nic_device_sync(utn->dev, utn);
 
 	if (utn->need_replay)
 		udp_tunnel_nic_replay(utn->dev, utn);
+
+	mutex_unlock(&utn->lock);
 	rtnl_unlock();
 }
 
@@ -730,6 +758,7 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
 		return NULL;
 	utn->n_tables = n_tables;
 	INIT_WORK(&utn->work, udp_tunnel_nic_device_sync_work);
+	mutex_init(&utn->lock);
 
 	for (i = 0; i < n_tables; i++) {
 		utn->entries[i] = kcalloc(info->tables[i].n_entries,
@@ -821,8 +850,11 @@ static int udp_tunnel_nic_register(struct net_device *dev)
 	dev_hold(dev);
 	dev->udp_tunnel_nic = utn;
 
-	if (!(info->flags & UDP_TUNNEL_NIC_INFO_OPEN_ONLY))
+	if (!(info->flags & UDP_TUNNEL_NIC_INFO_OPEN_ONLY)) {
+		udp_tunnel_nic_lock(dev);
 		udp_tunnel_get_rx_info(dev);
+		udp_tunnel_nic_unlock(dev);
+	}
 
 	return 0;
 }
@@ -832,6 +864,8 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 {
 	const struct udp_tunnel_nic_info *info = dev->udp_tunnel_nic_info;
 
+	udp_tunnel_nic_lock(dev);
+
 	/* For a shared table remove this dev from the list of sharing devices
 	 * and if there are other devices just detach.
 	 */
@@ -841,8 +875,10 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 		list_for_each_entry(node, &info->shared->devices, list)
 			if (node->dev == dev)
 				break;
-		if (list_entry_is_head(node, &info->shared->devices, list))
+		if (list_entry_is_head(node, &info->shared->devices, list)) {
+			udp_tunnel_nic_unlock(dev);
 			return;
+		}
 
 		list_del(&node->list);
 		kfree(node);
@@ -852,6 +888,7 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 		if (first) {
 			udp_tunnel_drop_rx_info(dev);
 			utn->dev = first->dev;
+			udp_tunnel_nic_unlock(dev);
 			goto release_dev;
 		}
 
@@ -862,6 +899,7 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 	 * from the work which we will boot immediately.
 	 */
 	udp_tunnel_nic_flush(dev, utn);
+	udp_tunnel_nic_unlock(dev);
 
 	/* Wait for the work to be done using the state, netdev core will
 	 * retry unregister until we give up our reference on this device.
@@ -910,12 +948,16 @@ udp_tunnel_nic_netdevice_event(struct notifier_block *unused,
 		return NOTIFY_DONE;
 
 	if (event == NETDEV_UP) {
+		udp_tunnel_nic_lock(dev);
 		WARN_ON(!udp_tunnel_nic_is_empty(dev, utn));
 		udp_tunnel_get_rx_info(dev);
+		udp_tunnel_nic_unlock(dev);
 		return NOTIFY_OK;
 	}
 	if (event == NETDEV_GOING_DOWN) {
+		udp_tunnel_nic_lock(dev);
 		udp_tunnel_nic_flush(dev, utn);
+		udp_tunnel_nic_unlock(dev);
 		return NOTIFY_OK;
 	}
 
-- 
2.49.0


