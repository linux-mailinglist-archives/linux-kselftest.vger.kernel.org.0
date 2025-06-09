Return-Path: <linux-kselftest+bounces-34492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0C7AD23D4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF413AB10A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209121B191;
	Mon,  9 Jun 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/O/jKIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA32192F3;
	Mon,  9 Jun 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486347; cv=none; b=GnoCzFeKijZZOY5RIOngCZvCdGybQMZG7gRlpuPlAXVKvMXFZG01EV8xxHU1KQoGzI57b73kFGLYJVUwVkBY0kl9N7R9l6xV3X8PVOTqlkZr7MwAwrrqMru9yxmV9IpwxeLm7SDiRgWAUSFdkLb77FXHZdGJiYQX92w0HIMcgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486347; c=relaxed/simple;
	bh=mHhPOqinpFEERdGM+Rti2TVQdt9tAiHA9fEwsPLz4ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qithMixSSz2ptwi9g2iw71/qaBKB9cD8VwAFRPCSDEPVu/CraP/0OZaCUP3AY6baOTXUXLNWTE0BxzF84WwbBOETYDp/d8oyIz488khLe2LvgfO451EsAw3Rsb2Howhza5QpCBmJOdwQ/M3dyySzXQ7LH9P9Ooch0B+qG+UGduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/O/jKIB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c336fcdaaso36398695ad.3;
        Mon, 09 Jun 2025 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749486345; x=1750091145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcBIQof9ewBwA3bnnT7zG7+z04Cojvm1rhsE7IhHazI=;
        b=j/O/jKIBktjdmWtBQhMfGZGapDVS2JWTVox7iU06eu7BNpM27E1Ee5FCwpekG+dID0
         388PURw2+e9UXAyhHZ4kXrPRcjl3IWe72OV09cCScAq9aRzCW4Y5CfNIfywAb8YI+vvf
         RqDLYS5qx3EHCrQfJgYhIN0xKyym/G6AROEIQBPvPFCzNEsxhiAOHJRz5HykBlMCjlVO
         KS25LDDpicPi1y5DWXybD0VLU4YUm5kLh0j7i2kkmNveWLDi7YfbAbaKRZi6zoOvTyZx
         ISIiIjPx2hLP6OhwY8VuPXO+8zIxw9NcyuOLPz0OFJmtZBJ5/m/RNFb5tmdFDu9fCNSD
         /ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749486345; x=1750091145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcBIQof9ewBwA3bnnT7zG7+z04Cojvm1rhsE7IhHazI=;
        b=sYhJpYlKzZxze2f73qkH+qVdVA2fhjZEjgrf8Fb9ZA7bDJdIqrZGBgP6ok5nDPUeLe
         wqDkMTfCkpKq5d099k5ywt9hiremAFM9QjjrXCvsUavyHc0H97YjAlFRJg10tiR025O5
         3APCSjsQZbdOpZIfR6D4xfCa9rMPX4E/GCRl3jeXPKH2R5rjE92441b5d6qtCqggTz/O
         bwRWxd2ijCouadSofJHgn2GgabJuP5kCP+wmnUxM+41Tcyx047Mk6Lfb7LTgIcLDOydx
         K1qvNsdsx43odfIiyPxKtnU/0UuGBkf+4YTHjH8eIbiRHKzaoSLcHCzeFme9krsXTRAG
         3Kog==
X-Forwarded-Encrypted: i=1; AJvYcCVhbp5Fo99IXELNh72kFef5WayDb5zxGh50eYVH5FwYiFXCI2JizhA7wdKEVL+bj+/4VNA9kuDFR6e0yZdtMmF1@vger.kernel.org, AJvYcCWec5mCGqmnXKS9B598F3nL+0+ZgLQevSJPzv9HMmcDGyYZRmMYFn26erYAI7nmcEuuHVcaexzieBbiQA==@vger.kernel.org, AJvYcCWpDDD7N8HT3ihxDY7BXsLoTrZ/1CF5qLe+RD39rLBygJ2nJRIkXKaah/DzgeA1VoSHm7rZBtusev5GTmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLNUaVIdxBd03mimkaMTu0HpPubbz4Ryq4wZlnkmo5+ZvSqOf
	qTfqZDmQ00l/boOlfBtQcxxWUcv5/Hg8sI5dW7jSKckuV50AUX8DhPQu/RfQ
X-Gm-Gg: ASbGncscjNABvb9VcCIVKaXocmH1WQ0r/cv0tJvV5welh2rpQK4PODQCuegzyikn9xZ
	IPsNDgNBeFE1kSsike/8nnyGqZ4GE+t4Ub+V/NY8xOAYdPPUEPSopZxa7Vkpovc4+9CgM63JpdI
	jld6TC8d6mbikrrtRbS3Lm6vrqUaB+Jw1Z3tHKWcD+2dHTNESDnhR1c26iSikAu3bu/xqYFtrHh
	BCFIKcK3fKf+l3Fr54QCEvgEYWB/tlGFlAX+ysMN7+Hgk37yR/2upySqhP2SkKOpcYNe8rJ9GCc
	S5gWh22wIkQhWyqooWzIa5+TBiOxmnPUBsHhAKZQkS0A8O/TU2VmoDoY0tYKLGBoJbjmuw/1uq9
	7UFYmo6mawcrfR06U+fzL0B0=
X-Google-Smtp-Source: AGHT+IFvP9iX5PgjA0qZtolo71nDPI7fhS39r0wgpkj3XRGGQnYnHscpU4aBJcy7odn2bsDb65c2gQ==
X-Received: by 2002:a17:903:2348:b0:235:f21d:6fce with SMTP id d9443c01a7336-23601dd787emr162761175ad.47.1749486344665;
        Mon, 09 Jun 2025 09:25:44 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603b6a5aasm56408125ad.112.2025.06.09.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 09:25:44 -0700 (PDT)
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
	mheib@redhat.com,
	ruanjinjie@huawei.com,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 1/4] udp_tunnel: remove rtnl_lock dependency
Date: Mon,  9 Jun 2025 09:25:38 -0700
Message-ID: <20250609162541.1230022-2-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609162541.1230022-1-stfomichev@gmail.com>
References: <20250609162541.1230022-1-stfomichev@gmail.com>
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

Cc: Michael Chan <michael.chan@broadcom.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  6 ++--
 drivers/net/ethernet/emulex/benet/be_main.c   |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  1 -
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  3 +-
 .../net/ethernet/qlogic/qede/qede_filter.c    |  3 --
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  1 -
 drivers/net/ethernet/sfc/ef10.c               |  1 -
 drivers/net/netdevsim/udp_tunnels.c           |  4 ---
 include/net/udp_tunnel.h                      |  8 ++---
 net/ipv4/udp_tunnel_nic.c                     | 30 +++++++++----------
 14 files changed, 24 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index f522ca8ff66b..fa7e5adf9804 100644
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
index d5495762c945..a3dadde65b8d 100644
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
index 120d68654e3f..3d3da9d15348 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15891,7 +15891,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pf->udp_tunnel_nic.set_port = i40e_udp_tunnel_set_port;
 	pf->udp_tunnel_nic.unset_port = i40e_udp_tunnel_unset_port;
-	pf->udp_tunnel_nic.flags = UDP_TUNNEL_NIC_INFO_MAY_SLEEP;
 	pf->udp_tunnel_nic.shared = &pf->udp_tunnel_shared;
 	pf->udp_tunnel_nic.tables[0].n_entries = I40E_MAX_PF_UDP_OFFLOAD_PORTS;
 	pf->udp_tunnel_nic.tables[0].tunnel_types = UDP_TUNNEL_TYPE_VXLAN |
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d97d4b25b30d..e309531f8c9d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4764,7 +4764,6 @@ int ice_init_dev(struct ice_pf *pf)
 
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
index 28997ddab966..14ba38bcb07b 100644
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
index 2df3b8344eb5..606168b0b64a 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -221,19 +221,17 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
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
diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index b6d2d16189c0..956a04c4bed4 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -34,6 +34,7 @@ struct udp_tunnel_nic_table_entry {
  * @work_pending: @work is currently scheduled
  * @n_tables:	number of tables under @entries
  * @missed:	bitmap of tables which overflown
+ * @lock:	protects entries
  * @entries:	table of tables of ports currently offloaded
  */
 struct udp_tunnel_nic {
@@ -47,6 +48,7 @@ struct udp_tunnel_nic {
 
 	unsigned int n_tables;
 	unsigned long missed;
+	struct mutex lock;
 	struct udp_tunnel_nic_table_entry *entries[] __counted_by(n_tables);
 };
 
@@ -298,22 +300,11 @@ __udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
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
@@ -554,12 +545,12 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
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
@@ -569,7 +560,7 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
 
 			entry->flags &= ~(UDP_TUNNEL_NIC_ENTRY_DEL |
 					  UDP_TUNNEL_NIC_ENTRY_OP_FAIL);
-			/* We don't release rtnl across ops */
+			/* We don't release utn lock across ops */
 			WARN_ON(entry->flags & UDP_TUNNEL_NIC_ENTRY_FROZEN);
 			if (!entry->use_cnt)
 				continue;
@@ -579,6 +570,8 @@ static void __udp_tunnel_nic_reset_ntf(struct net_device *dev)
 		}
 
 	__udp_tunnel_nic_device_sync(dev, utn);
+
+	mutex_unlock(&utn->lock);
 }
 
 static size_t
@@ -710,11 +703,15 @@ static void udp_tunnel_nic_device_sync_work(struct work_struct *work)
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
 
@@ -730,6 +727,7 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
 		return NULL;
 	utn->n_tables = n_tables;
 	INIT_WORK(&utn->work, udp_tunnel_nic_device_sync_work);
+	mutex_init(&utn->lock);
 
 	for (i = 0; i < n_tables; i++) {
 		utn->entries[i] = kcalloc(info->tables[i].n_entries,
-- 
2.49.0


