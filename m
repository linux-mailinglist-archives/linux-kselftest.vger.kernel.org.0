Return-Path: <linux-kselftest+bounces-2018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA4814904
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4BB282079
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750243064E;
	Fri, 15 Dec 2023 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3J3DmHD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D402DB7A;
	Fri, 15 Dec 2023 13:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A04C433CB;
	Fri, 15 Dec 2023 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646470;
	bh=OiQATbltZ0/hvGsWq6TWb70liL/l3FUkMOWyP1Vr7WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3J3DmHDGkGlqqoXYghd8eObO/cu/5hCSs1cC0VSFOTznOvU5aRzhfko5T6W6SM26
	 X2aZzVUk1A4/A5BFZJohAnDGZJOOyzMY/o/a686JYapDBdLiykFZlOgR6CtU96A1Ae
	 rzyG5xelRslzBEpYQxYPjOXwrg7J9O9nQ5GaLi+uqhl1+HsA5zp6C9VjtG8JvJ9Pl+
	 fz7B7bvakNpKjBLVExubjAwUrMEZhJfmdEE2asEgfzrJTqN0o+YNuMy4cEt+90YmX8
	 KATdmNRKum1r527KFkDAF9PARrBtcjSkvpfZLLt46233tN6hVmbNQKQSEF+2sbmxQF
	 Aj9llcnL8FXhQ==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH net-next v9 04/10] net: ethernet: am65-cpsw: Rename TI_AM65_CPSW_TAS to TI_AM65_CPSW_QOS
Date: Fri, 15 Dec 2023 15:20:42 +0200
Message-Id: <20231215132048.43727-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215132048.43727-1-rogerq@kernel.org>
References: <20231215132048.43727-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will use this Kconfig option to not only enable TAS/EST offload
but also other QoS features like Multiqueue priority descriptors
and MAC-Merge/Frame Preemption. TI_AM65_CPSW_QOS seems a more
appropriate Kconfig option name than TI_AM65_CPSW_TAS.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/Kconfig         | 12 ++++++------
 drivers/net/ethernet/ti/Makefile        |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-qos.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

Changelog:

v9: no change
v8: initial commit

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index e60b557d59b9..49cd96c4f532 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -134,14 +134,14 @@ config TI_K3_AM65_CPTS
 	  protocol, Ethernet Enhanced Scheduled Traffic Operations (CPTS_ESTFn)
 	  and PCIe Subsystem Precision Time Measurement (PTM).
 
-config TI_AM65_CPSW_TAS
-	bool "Enable TAS offload in AM65 CPSW"
+config TI_AM65_CPSW_QOS
+	bool "Enable QoS offload features in AM65 CPSW"
 	depends on TI_K3_AM65_CPSW_NUSS && NET_SCH_TAPRIO && TI_K3_AM65_CPTS
 	help
-	  Say y here to support Time Aware Shaper(TAS) offload in AM65 CPSW.
-	  AM65 CPSW hardware supports Enhanced Scheduled Traffic (EST)
-	  defined in IEEE 802.1Q 2018. The EST scheduler runs on CPTS and the
-	  TAS/EST schedule is updated in the Fetch RAM memory of the CPSW.
+	  This option enables QoS offload features in AM65 CPSW like
+	  Time Aware Shaper (TAS) / Enhanced Scheduled Traffic (EST).
+	  The EST scheduler runs on CPTS and the TAS/EST schedule is
+	  updated in the Fetch RAM memory of the CPSW.
 
 config TI_KEYSTONE_NETCP
 	tristate "TI Keystone NETCP Core Support"
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 9d7cd84d1e2d..d8590304f3df 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_TI_K3_CPPI_DESC_POOL) += k3-cppi-desc-pool.o
 
 obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o
 ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o cpsw_sl.o am65-cpsw-ethtool.o cpsw_ale.o
-ti-am65-cpsw-nuss-$(CONFIG_TI_AM65_CPSW_TAS) += am65-cpsw-qos.o
+ti-am65-cpsw-nuss-$(CONFIG_TI_AM65_CPSW_QOS) += am65-cpsw-qos.o
 ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index 898f13a4a112..be4987eb8c51 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -31,7 +31,7 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
 };
 
-#if IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS)
+#if IS_ENABLED(CONFIG_TI_AM65_CPSW_QOS)
 int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data);
 void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
-- 
2.34.1


