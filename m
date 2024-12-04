Return-Path: <linux-kselftest+bounces-22826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F47B9E39CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 13:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBABEB2A148
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 11:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A771B414E;
	Wed,  4 Dec 2024 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZC5Jdn01"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7A1ABEDC;
	Wed,  4 Dec 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313476; cv=none; b=tFnrzhRP5xTA1pj2UeiRd7fzdMdWiA/Lua8E79ExJ+vFEj8KfSwx2tgM+pELJqtmIjSQmKqh7WNJdV45jM8udrGscTgEceXh4myHOxIbMDqimI3Fc3/qkBc7oN5iT31qFjYlCt57+jYune1pA8sqJsErDFmZCWRHcimfK4gV2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313476; c=relaxed/simple;
	bh=oP0UxJ1SexpNYel+q3Ldy/dOEsfTJEnknxgC+x34Fcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kfeRNd2JT09sIbb0R0gqTXamZd2JGVvO2z18zdEWGu7STRMYjEzY3t4EdC5ybUw8Ed9anpalfQrI4cRAydrETzF97TAagXjtZajMtTZCDck8wZu1v8dUdKBongdO3VD0+9YBTVizLfQklFnfuVkcT4DQylyoXkzwpf4OXemt2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZC5Jdn01; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733313475; x=1764849475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oP0UxJ1SexpNYel+q3Ldy/dOEsfTJEnknxgC+x34Fcg=;
  b=ZC5Jdn01KkDQUj0F4dHlt/phetTpMx1hcQ7Uz08zM0vrlJyUxi28OWp/
   wgHIdeR/MmstgiUpmUlXPyJqGniqK8OGxqyoUpd2UrwnibQW5L1F2NtWE
   cucyRt957De8CwoaPQCVTfWDBLm7l5clzFfm32jlSAK3dFsu/zvCm61tj
   /MTEKwA/6Gm7PGBi6wBDY0UKQqT4BhSdvhqg+ER0qmPCvkJbLPTD+a4ki
   KP9colqr8FagHx1jKa1wVfTunEXz4hgg5rGZn9zlN1KkJBs0MfQFaX858
   YrDpIgRt+Be2vg9WiJbZJLiuZwuIQ1hKPi1YW+qTi2eYa1yjDx/h9tZ7y
   g==;
X-CSE-ConnectionGUID: VdvgeMheRj6HKrE9hGCuJw==
X-CSE-MsgGUID: YtPeAxwdR2C0dCELFpD/0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32934351"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32934351"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:57:49 -0800
X-CSE-ConnectionGUID: VLIkdnLkRE+Uu0b/lyEb2Q==
X-CSE-MsgGUID: svvCZBXNQPKFXMvy7bmjLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93639903"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orviesa009.jf.intel.com with ESMTP; 04 Dec 2024 03:57:44 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/1] selftests/bpf: Enable Tx hwtstamp in xdp_hw_metadata
Date: Wed,  4 Dec 2024 19:57:15 +0800
Message-Id: <20241204115715.3148412-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set tx_type to HWTSTAMP_TX_ON to enable hardware timestamping for all
outgoing packets.

Besides, set XDP_UMEM_TX_METADATA_LEN flag to reserve tx_metadata_len bytes
of per-chunk metadata.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 06266aad2f99..6f7b15d6c6ed 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -79,7 +79,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
-		.flags = XSK_UMEM__DEFAULT_FLAGS,
+		.flags = XDP_UMEM_TX_METADATA_LEN,
 		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 	};
 	__u32 idx = 0;
@@ -551,6 +551,7 @@ static void hwtstamp_enable(const char *ifname)
 {
 	struct hwtstamp_config cfg = {
 		.rx_filter = HWTSTAMP_FILTER_ALL,
+		.tx_type = HWTSTAMP_TX_ON,
 	};
 
 	hwtstamp_ioctl(SIOCGHWTSTAMP, ifname, &saved_hwtstamp_cfg);
-- 
2.34.1


