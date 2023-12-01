Return-Path: <linux-kselftest+bounces-940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 087AC8003BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 07:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8130CB20E25
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FC5C8DB;
	Fri,  1 Dec 2023 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zag7mclo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774FA1718;
	Thu, 30 Nov 2023 22:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701411883; x=1732947883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OrXONeV7YlBRhiTW3LB5rHkzQDQL8wPC8aPc0x4910w=;
  b=Zag7mclosS6/OwdbIaP6Xff5DAUvlz5TUY5nFCBZrpRXDa1a/PhvjlYt
   WSvVaAgfw1HJLiCrKcMyfTSYiztdJCuGxC6ga2XEseuX84lZy/yRxOHqS
   dSjTlB/ZyvLRwd1St35D5gg7sdUCn+CO0wlgvYnd041kb84oGWQ2qpn/b
   azFFCGJj0EPeVESlFvHQf/Ey2rhZRarQdwiVvmC6ebjRO34E9fpDKKyVM
   d+aX3lpBp7sg/bLoaDCkiPQy2uKKZ4rnbC2jIe6xg2vLQpijy+sSJVDDo
   tINh/0AgBbzRfn6o9UrENXwWM7JCO9LGn2pclK/H/OXyyQNuOvQd/8Yd+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="6722778"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="6722778"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 22:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803945044"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="803945044"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2023 22:24:31 -0800
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
Subject: [PATCH bpf-next v2 0/3] xsk: TX metadata txtime support
Date: Fri,  1 Dec 2023 14:24:18 +0800
Message-Id: <20231201062421.1074768-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series expands XDP TX metadata framework to include ETF HW offload.

Changes since v1:
- rename Time-Based Scheduling (TBS) to Earliest TxTime First (ETF)
- rename launch-time to txtime

v1: https://patchwork.kernel.org/project/netdevbpf/cover/20231130162028.852006-1-yoong.siang.song@intel.com/

Song Yoong Siang (3):
  xsk: add ETF support to XDP Tx metadata
  net: stmmac: Add txtime support to XDP ZC
  selftests/bpf: Add txtime to xdp_hw_metadata

 Documentation/netlink/specs/netdev.yaml        |  4 ++++
 Documentation/networking/xsk-tx-metadata.rst   |  5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 13 +++++++++++++
 include/net/xdp_sock.h                         |  9 +++++++++
 include/net/xdp_sock_drv.h                     |  1 +
 include/uapi/linux/if_xdp.h                    |  9 +++++++++
 include/uapi/linux/netdev.h                    |  3 +++
 net/core/netdev-genl.c                         |  2 ++
 net/xdp/xsk.c                                  |  3 +++
 tools/include/uapi/linux/if_xdp.h              |  9 +++++++++
 tools/include/uapi/linux/netdev.h              |  3 +++
 tools/net/ynl/generated/netdev-user.c          |  1 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c  | 18 +++++++++++++++++-
 14 files changed, 81 insertions(+), 1 deletion(-)

-- 
2.34.1


