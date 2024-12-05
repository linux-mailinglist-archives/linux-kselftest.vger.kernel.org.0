Return-Path: <linux-kselftest+bounces-22854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44AB9E4D3B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 06:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426282818C7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 05:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E31925A3;
	Thu,  5 Dec 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcZbSuxP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDC11187;
	Thu,  5 Dec 2024 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733376007; cv=none; b=mCAzETT9YP09bO4EQNVgpUmsGYHxX7Anyiq6C7aIWZh17GaE+56RZi3rK7eXqETXBgXaGpMfkxq+Vt1rCkWaBni2txWg0t1vYOFIcZgph4AtittKQDvgdttdHqjC4EWtMCp1mVfFPetHQTtTpKltmJ5oICk+yIdKFM+0oXi2KDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733376007; c=relaxed/simple;
	bh=HQb7j+/16kk489X/223nxBvP8Rc4zUskXGT8RCaT5Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B36eDlQgEQVFag+38L4RsOhSmiN9s7Cga3ZjlyUH7IvZqrkDG7GfwmaJ/S3j7TasEbk0oHO3PQ8rcGogHE5pP57wdmd7GZOikFHBIeOkgvaNU2UWQbgW0OjmU6OaN6nB8FKwkBTaSCt8XsJbE7J7tEhAOa3nDXL91TJE/B2Lhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcZbSuxP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733376005; x=1764912005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HQb7j+/16kk489X/223nxBvP8Rc4zUskXGT8RCaT5Ds=;
  b=gcZbSuxPULu6z9AKPo0FwJGKH931r407v3GT81t2+RO+KGxDPgX+vm5o
   irvU8ZKSrkfJAUz0JINy/pF9yWrHOg1cC6h3IY+GKidW6hUBi9Egy0vkc
   FY88ss1TkUBWZfA4r2kveEyi6Nv36/r3DKU0U3dL9hzRA17e2RvqYteFN
   1xrl4UvM2wDD5kccIWJyGMdW8LkbuHJ07JTOVGu2Pet0dnczkCxfeWHYq
   f4isH9bsOkhw6yI/kRKZt4f1Kcf1AnlXFzaox1XJ14i/8qFSkbxFiD/jE
   pHuBCuwkC2VgrCAhUarLVQfd4p3s7uA0yNcsPK0UujEfMT78e54+lCzeT
   w==;
X-CSE-ConnectionGUID: Vdy3xPWIRBW1xp5/NjGdSg==
X-CSE-MsgGUID: TpH85J4MS6yUKKHAdrLE7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33552350"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="33552350"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 21:20:04 -0800
X-CSE-ConnectionGUID: +dqvxwhLQ3Gvv0O2KLAyeg==
X-CSE-MsgGUID: j4mmzRkpQkao/L9oJ5oDsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="94170928"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by fmviesa008.fm.intel.com with ESMTP; 04 Dec 2024 21:20:00 -0800
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
Subject: [PATCH bpf-next v2 1/1] selftests/bpf: Enable Tx hwtstamp in xdp_hw_metadata
Date: Thu,  5 Dec 2024 13:19:36 +0800
Message-Id: <20241205051936.3156307-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, user needs to manually enable transmit hardware timestamp
feature of certain Ethernet drivers, e.g. stmmac and igc drivers, through
following command after running the xdp_hw_metadata app.

sudo hwstamp_ctl -i eth0 -t 1

To simplify the step test of xdp_hw_metadata, set tx_type to HWTSTAMP_TX_ON
to enable hardware timestamping for all outgoing packets, so that user no
longer need to execute hwstamp_ctl command.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20241204115715.3148412-1-yoong.siang.song@intel.com/

v1->v2 changelog:
 - Add detail in commit msg on why HWTSTAMP_TX_ON is needed (Stanislav).
 - Separate the patch into two, current one submit to bpf-next,
   another one submit to bpf.
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 06266aad2f99..96c65500f4b4 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -551,6 +551,7 @@ static void hwtstamp_enable(const char *ifname)
 {
 	struct hwtstamp_config cfg = {
 		.rx_filter = HWTSTAMP_FILTER_ALL,
+		.tx_type = HWTSTAMP_TX_ON,
 	};
 
 	hwtstamp_ioctl(SIOCGHWTSTAMP, ifname, &saved_hwtstamp_cfg);
-- 
2.34.1


