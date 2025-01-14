Return-Path: <linux-kselftest+bounces-24454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BA6A10ACA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB299166986
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1A19007E;
	Tue, 14 Jan 2025 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wyz0TUN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB8232451;
	Tue, 14 Jan 2025 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868521; cv=none; b=dsjYQiQQ0Oaokg2Lgq3RHck8l3X3dhkAlTxntJtT8DAr4iIAD/nHGpxzJohf+lS9NCyUFfoYmzpqz9YBEeu/L20Be9q8i2ebLHlui74eexNYrV58ufKktd9VPwVGMX2C0oNiJhq1F59vGej21c7Fwx9VgSZOZkTqN7PX4bSza+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868521; c=relaxed/simple;
	bh=9+KLegP8sNJx/AWuSh92HNz42/bZNKEkWintQD1cKTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEdyQsWqAEmm+n33wjDX1cDgqt/XnJDUYpQ/ok91EeGPMeLSUhSE6bGcwzr9L12PcS1u4JUe5tquj5JNQ85YqgMFk0Y03XX1TkHTIBhIV8LOF17TEugPRMhg00IxnTTNx/I/20GXTZcvBuxaV1PmuNMIx/poBCkkGCpQz+mf1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wyz0TUN1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736868519; x=1768404519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9+KLegP8sNJx/AWuSh92HNz42/bZNKEkWintQD1cKTY=;
  b=Wyz0TUN1D1wAjFxBQutpTsJzxfPhWh2DJ45/64wLGPzLmMSU5rMCEwPI
   K36+EjMqEC5CoaLDI+YflA0+E87YohqrjRYiIhGJ/dgvP7lz2pCJXcWQz
   4wys5IaosB6yEycyIZ8VPiY8yU8lCTHai3hVfr9EVnnaMiKJFHg/wl8Ea
   OfqLDicET2mCJ/Xwmx8DJO4lGQ6sca5gq0K/2RCShIwu9TnP40Sf0r8BL
   RRVxXcAkhId6MVZ8H9HzwvW47seGdMJwcvdIFLGeAGTOFzMOupukbj9E5
   XrT6isFtflrfVQiZUsDGoZ47W4qWxzixINW6Lktw8H0uKUc9dprWoeO5H
   g==;
X-CSE-ConnectionGUID: kQ4Rqa+NSOaG3fL/g6HDgA==
X-CSE-MsgGUID: 6S2Pdj2uR0WCHjmwqrEoFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37325385"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="37325385"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 07:28:38 -0800
X-CSE-ConnectionGUID: qOQulmMURy6PgoQ3yFx8bA==
X-CSE-MsgGUID: 2sAFkagfRcG+YF1K4XpzPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142117695"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa001.jf.intel.com with ESMTP; 14 Jan 2025 07:28:27 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	xdp-hints@xdp-project.net
Subject: [PATCH bpf-next v5 3/4] net: stmmac: Add launch time support to XDP ZC
Date: Tue, 14 Jan 2025 23:27:17 +0800
Message-Id: <20250114152718.120588-4-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114152718.120588-1-yoong.siang.song@intel.com>
References: <20250114152718.120588-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable launch time (Time-Based Scheduling) support to XDP zero copy via XDP
Tx metadata framework.

This patch is tested with tools/testing/selftests/bpf/xdp_hw_metadata on
Intel Tiger Lake platform. Below are the test steps and result.

Test Steps:
1. At DUT, start xdp_hw_metadata selftest application:
   $ sudo ./xdp_hw_metadata enp0s30f4 -l 1000000000 -L 1

2. At Link Partner, send an UDP packet with VLAN priority 1 to port 9091 of
   DUT.

When launch time is set to 1s in the future, the delta between launch time
and transmit hardware timestamp is equal to 16.963us, as shown in result
below:
  0x55b5864717a8: rx_desc[4]->addr=88100 addr=88100 comp_addr=88100 EoP
  No rx_hash, err=-95
  HW RX-time:   1734579065767717328 (sec:1734579065.7677) delta to User RX-time sec:0.0004 (375.624 usec)
  XDP RX-time:   1734579065768004454 (sec:1734579065.7680) delta to User RX-time sec:0.0001 (88.498 usec)
  No rx_vlan_tci or rx_vlan_proto, err=-95
  0x55b5864717a8: ping-pong with csum=5619 (want 0000) csum_start=34 csum_offset=6
  HW RX-time:   1734579065767717328 (sec:1734579065.7677) delta to HW Launch-time sec:1.0000 (1000000.000 usec)
  0x55b5864717a8: complete tx idx=4 addr=4018
  HW Launch-time:   1734579066767717328 (sec:1734579066.7677) delta to HW TX-complete-time sec:0.0000 (16.963 usec)
  HW TX-complete-time:   1734579066767734291 (sec:1734579066.7677) delta to User TX-complete-time sec:0.0001 (130.408 usec)
  XDP RX-time:   1734579065768004454 (sec:1734579065.7680) delta to User TX-complete-time sec:0.9999 (999860.245 usec)
  HW RX-time:   1734579065767717328 (sec:1734579065.7677) delta to HW TX-complete-time sec:1.0000 (1000016.963 usec)
  0x55b5864717a8: complete rx idx=132 addr=88100

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b8d631e559c0..11f7b539c4b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -106,6 +106,8 @@ struct stmmac_metadata_request {
 	struct stmmac_priv *priv;
 	struct dma_desc *tx_desc;
 	bool *set_ic;
+	struct dma_edesc *edesc;
+	int tbs;
 };
 
 struct stmmac_xsk_tx_complete {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 70c8f60d34f2..1c08e913f526 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2453,9 +2453,20 @@ static u64 stmmac_xsk_fill_timestamp(void *_priv)
 	return 0;
 }
 
+static void stmmac_xsk_request_launch_time(u64 launch_time, void *_priv)
+{
+	struct stmmac_metadata_request *meta_req = _priv;
+	struct timespec64 ts = ns_to_timespec64(launch_time);
+
+	if (meta_req->tbs & STMMAC_TBS_EN)
+		stmmac_set_desc_tbs(meta_req->priv, meta_req->edesc, ts.tv_sec,
+				    ts.tv_nsec);
+}
+
 static const struct xsk_tx_metadata_ops stmmac_xsk_tx_metadata_ops = {
 	.tmo_request_timestamp		= stmmac_xsk_request_timestamp,
 	.tmo_fill_timestamp		= stmmac_xsk_fill_timestamp,
+	.tmo_request_launch_time	= stmmac_xsk_request_launch_time,
 };
 
 static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
@@ -2539,6 +2550,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		meta_req.priv = priv;
 		meta_req.tx_desc = tx_desc;
 		meta_req.set_ic = &set_ic;
+		meta_req.tbs = tx_q->tbs;
+		meta_req.edesc = &tx_q->dma_entx[entry];
 		xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops,
 					&meta_req);
 		if (set_ic) {
-- 
2.34.1


