Return-Path: <linux-kselftest+bounces-893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070CE7FF4BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 17:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2BA1F20F49
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13AE54FA6;
	Thu, 30 Nov 2023 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdksiZi8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E810F9;
	Thu, 30 Nov 2023 08:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701361320; x=1732897320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RxQigYZX0AwiQz5iF7nEbIkSvowYJwMREZVwWRXD5sM=;
  b=fdksiZi8seE9H/LblACmagwbZ3sX4Vvzhpk1CuqmzGqyyViVKBX+M4KE
   pfZ0VZEKvnfgq0MMn9/CRTZ1EEKnkf8xUCJUNoF0wJhQy5YaFOJYtQGLi
   mTAaMBP5Ztnof3SREo6opZH2sf9i0UlwMgVsSx48pIOg3qydrpCfJtNlv
   7FYd39Jey4tGZHbcciFQPRE+VL3NqWpaTE+SouhrbV+dVm/7SRY7MfUEp
   760GAeULNfMNjK1VEj17wmCa60kA2CZFvzME4tTDjSEWjiIUGJNDIIl2X
   BZkZCpvFuGQaxZacFmpAXYLBm0NQfhI17cTnh1lQae4YDw3jd5ekpn3wL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="383744595"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="383744595"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803758602"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="803758602"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2023 08:21:42 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	xdp-hints@xdp-project.net,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Song Yoong Siang <yoong.siang.song@intel.com>
Subject: [PATCH bpf-next 2/3] net: stmmac: Add launch time support to XDP ZC
Date: Fri,  1 Dec 2023 00:20:27 +0800
Message-Id: <20231130162028.852006-3-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130162028.852006-1-yoong.siang.song@intel.com>
References: <20231130162028.852006-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables launch time support to XDP zero copy via XDP Tx
metadata framework.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 686c94c2e8a7..e8538af6e207 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -105,6 +105,8 @@ struct stmmac_metadata_request {
 	struct stmmac_priv *priv;
 	struct dma_desc *tx_desc;
 	bool *set_ic;
+	struct dma_edesc *edesc;
+	int tbs;
 };
 
 struct stmmac_xsk_tx_complete {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c2ac88aaffed..c33517d3850a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2465,9 +2465,20 @@ static u64 stmmac_xsk_fill_timestamp(void *_priv)
 	return 0;
 }
 
+static void stmmac_xsk_request_launch_time(u64 launch_time, void *_priv)
+{
+	struct stmmac_metadata_request *meta_req = _priv;
+	struct timespec64 ts = ns_to_timespec64(launch_time);
+
+	if ((meta_req->tbs & STMMAC_TBS_EN) && launch_time > 0)
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
@@ -2545,6 +2556,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
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


