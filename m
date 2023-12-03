Return-Path: <linux-kselftest+bounces-1027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2AC8025AD
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291CE280D2C
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Dec 2023 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9B815AF5;
	Sun,  3 Dec 2023 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUG7p1KE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA96E5;
	Sun,  3 Dec 2023 08:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701622315; x=1733158315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lTyXJMsSPVluiy97P4qSM7nDpEehwOMAB+SjdzyXSkI=;
  b=kUG7p1KEz2nSZlXDuzwckmoVWIuFxDYmMgWSjtrK9xM7332MBNrXE8p8
   nX0Jr3ciCKIkBqyaBkt5Ts3YKvTN4AdtTdV1MjYfgKRjlbOnFP8liyqCE
   sP7f5Hb01KgNbit1DhW5ENJO8eGRvHGj6Y8kBGDBlPtijfvx7HDAlkDz9
   8Z7NJANubRWyOoZqN2G3lfOyh3Cq6mr5bBECIHTHV0/XotOFdJgWxDbWN
   s3ciFVOdq+/rqeGRUYmb9azqiobDiGScik8fXkdJT4TfsmXiQWVPKDK+p
   bD0X3MyxXck9XXgnPyorqfA5ATjC+ztn5TipZel/LjTNb6/OR/tMOaHJ5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="706802"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="706802"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 08:51:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="799345384"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="799345384"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2023 08:51:44 -0800
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
Subject: [PATCH bpf-next v3 0/3] xsk: TX metadata Launch Time support
Date: Mon,  4 Dec 2023 00:51:26 +0800
Message-Id: <20231203165129.1740512-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series expands XDP TX metadata framework to include ETF HW offload.

Changes since v1: (Willem)
- rename Time-Based Scheduling (TBS) to Earliest TxTime First (ETF)
- rename launch-time to txtime

Changes since v2: (Jesper & Willem)
- rename to use launch time
- change the default launch time in xdp_hw_metadata apps from 1s to 0.1s
  because some NICs do not support such a large future time.

v1: https://patchwork.kernel.org/project/netdevbpf/cover/20231130162028.852006-1-yoong.siang.song@intel.com/
v2: https://patchwork.kernel.org/project/netdevbpf/cover/20231201062421.1074768-1-yoong.siang.song@intel.com/

Song Yoong Siang (3):
  xsk: add Launch Time HW offload to XDP Tx metadata
  net: stmmac: add Launch Time support to XDP ZC
  selftests/bpf: add Launch Time request to xdp_hw_metadata

 Documentation/netlink/specs/netdev.yaml       |  4 ++++
 Documentation/networking/xsk-tx-metadata.rst  |  4 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 include/net/xdp_sock.h                        | 10 ++++++++++
 include/net/xdp_sock_drv.h                    |  1 +
 include/uapi/linux/if_xdp.h                   |  9 +++++++++
 include/uapi/linux/netdev.h                   |  3 +++
 net/core/netdev-genl.c                        |  2 ++
 net/xdp/xsk.c                                 |  3 +++
 tools/include/uapi/linux/if_xdp.h             |  9 +++++++++
 tools/include/uapi/linux/netdev.h             |  3 +++
 tools/net/ynl/generated/netdev-user.c         |  1 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 19 ++++++++++++++++++-
 14 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.34.1


