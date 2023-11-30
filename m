Return-Path: <linux-kselftest+bounces-891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE027FF4AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 17:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C4DB20C91
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7754F87;
	Thu, 30 Nov 2023 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFzfS9av"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D1170B;
	Thu, 30 Nov 2023 08:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701361250; x=1732897250;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jmp58BhNqYVS6hDCJmPrbUZy8u/nlUohDAInUqFsi9A=;
  b=mFzfS9avtitnCyffQHB9EyviOXf0yDOqiuomP1f2R47HuV6++ZtfRP7X
   zGJ6RFq7QUQiZ8rl40qAXPJ6wG6tWkt0D1iyvJTBV3EyxU8CNd+TOMzR3
   z/VZCmEkhKel84axCSOWs3YCjxHCfKOzX6NBXvk/fivEP9pZhkQGMfSl/
   C4OeEks7WfpJmJbX6lU75mmtHLPTy274omq8fQ+mQLSwCmLPK01l2yBDL
   PsJXcI+jcA/XIaYTWnB+MYI59yjjSMbv/ABnb40b55PbLNdd2vQicasSK
   Q+OISi5n0xbrmH7BlOnCSg79c1ypGEJ7lGRZTOkT5EMXNUzF8Im8s9K5V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="383744345"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="383744345"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:20:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803757991"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="803757991"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2023 08:20:40 -0800
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
Subject: [PATCH bpf-next 0/3] xsk: TX metadata launch time support
Date: Fri,  1 Dec 2023 00:20:25 +0800
Message-Id: <20231130162028.852006-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series expands XDP TX metadata framework to include HW launch time offload.

Song Yoong Siang (3):
  xsk: add launch time support to XDP Tx metadata
  net: stmmac: Add launch time support to XDP ZC
  selftests/bpf: Add launch time to xdp_hw_metadata

 Documentation/netlink/specs/netdev.yaml        |  4 ++++
 Documentation/networking/xsk-tx-metadata.rst   |  5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 13 +++++++++++++
 include/net/xdp_sock.h                         | 10 ++++++++++
 include/net/xdp_sock_drv.h                     |  1 +
 include/uapi/linux/if_xdp.h                    |  9 +++++++++
 include/uapi/linux/netdev.h                    |  3 +++
 net/core/netdev-genl.c                         |  2 ++
 net/xdp/xsk.c                                  |  3 +++
 tools/include/uapi/linux/if_xdp.h              |  9 +++++++++
 tools/include/uapi/linux/netdev.h              |  3 +++
 tools/net/ynl/generated/netdev-user.c          |  1 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c  | 18 +++++++++++++++++-
 14 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.34.1


