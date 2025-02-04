Return-Path: <linux-kselftest+bounces-25626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3761A268E8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 01:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2287B161744
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 00:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C4F27456;
	Tue,  4 Feb 2025 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+xP6JZx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C10325A62E;
	Tue,  4 Feb 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630186; cv=none; b=VZvNQqQQ4aiDeC7jtkkgc1OIvHFlYlITS76BNJVe7CLuD8v2aNM+ODLPT5/woFY/xa7u4ITRloSVg8z4egmUnIM6FYrBLXY1KonvO4bLzm2DxAauKYp3/KPcjhoKru2Q8kN8bdEb3O4+9LWDk5eFeuWA/gZnMRqOdhwU5xrH/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630186; c=relaxed/simple;
	bh=2KzKPgEaxeySCBRJkboUarqwEgHBPRsk0j45K+3gc/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2QTYThVVcEHt6xqjihgpkt3sadn3OR26k8T5AH2yd6BGnwuM9XZLkR/kbdlGKh+cysZCWWSNNGz5zRW75SbnMUlfIr+tZ59QXefzc+0pdzhBJXAvVnUVn5+DhJiJ0GY03LZlG4Squbg1c6f5Tj7rztLkmDjwnIWFXZ36/V9VEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+xP6JZx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738630185; x=1770166185;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2KzKPgEaxeySCBRJkboUarqwEgHBPRsk0j45K+3gc/c=;
  b=f+xP6JZxa7L+X1SGlI5Fs07+SznE9fbOsictOR8G9SkfhBOcS9pjoYvS
   bOgPX8aKmScRtQrASg+C2vEun7uS0a3Q+I1IkPfacAuUl9+/BZtndXS5C
   MnQy5OZ1ByDyGGMB92GQPhMEvjE01s6uh0jieq3rpljnMZNcuB0yAbNH5
   hoYzS5763VvhAuF4hr5O/pRJoQXWY0Xf8BCTiUIjWdWdhS/Rv2S6jBHBJ
   4ARVZ667lw3n9zlx9gLULkvUWmMa2+W0kQxDD5aEMMS7FB1sdZdT6HV6S
   oIVQ85ahc5Pj7cIM2yqiIxkRxGr8xPZNNKLIEsHUP1Eb+aZmejGJewXcg
   Q==;
X-CSE-ConnectionGUID: jYqppEMoQLyEEa1nFDpsIw==
X-CSE-MsgGUID: KvWOzZX6ReCPlh0uFim2ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39296427"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="39296427"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 16:49:43 -0800
X-CSE-ConnectionGUID: wlLn7DXWQMqaEXAYJOk9BA==
X-CSE-MsgGUID: Jbpkn1X2TrOoyrkx37vZ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115605104"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa005.jf.intel.com with ESMTP; 03 Feb 2025 16:49:32 -0800
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
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bouska Zdenek <zdenek.bouska@siemens.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	xdp-hints@xdp-project.net
Subject: [PATCH bpf-next v7 0/5] xsk: TX metadata Launch Time support
Date: Tue,  4 Feb 2025 08:49:02 +0800
Message-Id: <20250204004907.789330-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series expands the XDP TX metadata framework to allow user
applications to pass per packet 64-bit launch time directly to the kernel
driver, requesting launch time hardware offload support. The XDP TX
metadata framework will not perform any clock conversion or packet
reordering.

Please note that the role of Tx metadata is just to pass the launch time,
not to enable the offload feature. Users will need to enable the launch
time hardware offload feature of the device by using the respective
command, such as the tc-etf command.

Although some devices use the tc-etf command to enable their launch time
hardware offload feature, xsk packets will not go through the etf qdisc.
Therefore, in my opinion, the launch time should always be based on the PTP
Hardware Clock (PHC). Thus, i did not include a clock ID to indicate the
clock source.

To simplify the test steps, I modified the xdp_hw_metadata bpf self-test
tool in such a way that it will set the launch time based on the offset
provided by the user and the value of the Receive Hardware Timestamp, which
is against the PHC. This will eliminate the need to discipline System Clock
with the PHC and then use clock_gettime() to get the time.

Please note that AF_XDP lacks a feedback mechanism to inform the
application if the requested launch time is invalid. So, users are expected
to familiar with the horizon of the launch time of the device they use and
not request a launch time that is beyond the horizon. Otherwise, the driver
might interpret the launch time incorrectly and react wrongly. For stmmac
and igc, where modulo computation is used, a launch time larger than the
horizon will cause the device to transmit the packet earlier that the
requested launch time.

Although there is no feedback mechanism for the launch time request
for now, user still can check whether the requested launch time is
working or not, by requesting the Transmit Completion Hardware Timestamp.

V7:
  - split the refactoring code of igc empty packet insertion into a separate
    commit (Faizal)
  - add explanation on why the value "4" is used as igc transmit budget
    (Faizal)
  - perform a stress test by sending 1000 packets with 10ms interval and
    launch time set to 500us in the future (Faizal & Yong Liang)

V6: https://lore.kernel.org/netdev/20250116155350.555374-1-yoong.siang.song@intel.com/
  - fix selftest build errors by using asprintf() and realloc(), instead of
    managing the buffer sizes manually (Daniel, Stanislav)

V5: https://lore.kernel.org/netdev/20250114152718.120588-1-yoong.siang.song@intel.com/
  - change netdev feature name from tx-launch-time to tx-launch-time-fifo
    to explicitly state the FIFO behaviour (Stanislav)
  - improve the looping of xdp_hw_metadata app to wait for packet tx
    completion to be more readable by using clock_gettime() (Stanislav)
  - add launch time setup steps into xdp_hw_metadata app (Stanislav)

V4: https://lore.kernel.org/netdev/20250106135506.9687-1-yoong.siang.song@intel.com/
  - added XDP launch time support to the igc driver (Jesper & Florian)
  - added per-driver launch time limitation on xsk-tx-metadata.rst (Jesper)
  - added explanation on FIFO behavior on xsk-tx-metadata.rst (Jakub)
  - added step to enable launch time in the commit message (Jesper & Willem)
  - explicitly documented the type of launch_time and which clock source
    it is against (Willem)

V3: https://lore.kernel.org/netdev/20231203165129.1740512-1-yoong.siang.song@intel.com/
  - renamed to use launch time (Jesper & Willem)
  - changed the default launch time in xdp_hw_metadata apps from 1s to 0.1s
    because some NICs do not support such a large future time.

V2: https://lore.kernel.org/netdev/20231201062421.1074768-1-yoong.siang.song@intel.com/
  - renamed to use Earliest TxTime First (Willem)
  - renamed to use txtime (Willem)

V1: https://lore.kernel.org/netdev/20231130162028.852006-1-yoong.siang.song@intel.com/

Song Yoong Siang (5):
  xsk: Add launch time hardware offload support to XDP Tx metadata
  selftests/bpf: Add launch time request to xdp_hw_metadata
  net: stmmac: Add launch time support to XDP ZC
  igc: Refactor empty packet insertion into a reusable function
  igc: Add launch time support to XDP ZC

 Documentation/netlink/specs/netdev.yaml       |   4 +
 Documentation/networking/xsk-tx-metadata.rst  |  62 +++++++
 drivers/net/ethernet/intel/igc/igc_main.c     |  84 ++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  13 ++
 include/net/xdp_sock.h                        |  10 ++
 include/net/xdp_sock_drv.h                    |   1 +
 include/uapi/linux/if_xdp.h                   |  10 ++
 include/uapi/linux/netdev.h                   |   3 +
 net/core/netdev-genl.c                        |   2 +
 net/xdp/xsk.c                                 |   3 +
 tools/include/uapi/linux/if_xdp.h             |  10 ++
 tools/include/uapi/linux/netdev.h             |   3 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 168 +++++++++++++++++-
 14 files changed, 348 insertions(+), 27 deletions(-)

-- 
2.34.1


