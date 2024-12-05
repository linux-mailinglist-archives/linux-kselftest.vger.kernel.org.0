Return-Path: <linux-kselftest+bounces-22853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028D9E4D10
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 05:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29CA2859D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 04:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC7D1922D4;
	Thu,  5 Dec 2024 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMfzADM7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1432119;
	Thu,  5 Dec 2024 04:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733373807; cv=none; b=ScgwUNo4QR4cQZ/5dnptG09k4LUKuuiPu4AcLOaMMf+oW2Y0+U7SiHDUMIrbTkhmhnlNu52xkQ2eRmtiyglJgaKfiXF+28OwSBzsTuewhsxLsjR72zHXTEEVxXkA+of37yxNGkgJ9r6D+i5d55gGK2qWB2kfV/l5I29dsxHwnEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733373807; c=relaxed/simple;
	bh=CtuKv6ecMYWPznk8CcN+oHQB1GyUQEbKfo7aY/0tl4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PYm6oSBH+0G8j5fC6kgkHPTzWJWbnklnpuv4I2PSLhxHpkdflnU8WCl9E3Ay5KeAH2oLIF9r3KfTGlaifjL0Aub/5ZV3SuWT5mcPHEb+LvuE9BkLW5HnhHWDJH+iEvsyNGPUFYRm27Fd+cC4hDw6/fzlSlwtlB/OnMRquXwsxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMfzADM7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733373806; x=1764909806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CtuKv6ecMYWPznk8CcN+oHQB1GyUQEbKfo7aY/0tl4g=;
  b=dMfzADM7mbjjBvN0TW/0I7PDuHIJVBMN8Qesmjlm6KASe5TRPpGLN1EL
   oAQUl6TxoV+WD0gxpnwYb4JvxvfNMREfxEgdkSzkR9GwMsXxOmZ2CDtD7
   zrjpCMjJlxbmdup2STxFwtSb/nuBErzh8CmShqDig1Xuq4n/N2an+Gy01
   nJ1TjKZ6MM0a90+7qK2ukOPYGQ25SgcOx9D4rgFESME2VdymV4F/poGYt
   R7UrruUuWybRhC52A9MhDKVAKBbafw6Hyl8/cCRMn0RpMqfLAvX7ie0AF
   5IKMxQQwmUckMr8tCIwiOuIuwzL0BHOv0B0799VlBXeBkfde5ciM6Cdfx
   Q==;
X-CSE-ConnectionGUID: Z5+z/bUeQ8KHDcotNqw95w==
X-CSE-MsgGUID: 0mRmy3TZSLaKm2l3tdXRjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44145927"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="44145927"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 20:43:24 -0800
X-CSE-ConnectionGUID: zxSN6iOVSrqsrOt4N4h05Q==
X-CSE-MsgGUID: xB/l3wD2T9a/kH3R02IZJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="93870997"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orviesa009.jf.intel.com with ESMTP; 04 Dec 2024 20:43:20 -0800
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
	Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 1/1] selftests/bpf: Actuate tx_metadata_len in xdp_hw_metadata
Date: Thu,  5 Dec 2024 12:42:58 +0800
Message-Id: <20241205044258.3155799-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set XDP_UMEM_TX_METADATA_LEN flag to reserve tx_metadata_len bytes of
per-chunk metadata.

Fixes: d5e726d9143c ("xsk: Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len")
Cc: stable@vger.kernel.org # v6.11
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20241204115715.3148412-1-yoong.siang.song@intel.com/

v1->v2 changelog:
 - Add Fixes tag (Stanislav).
 - Add stable@vger.kernel.org in email cc list.
 - Separate the patch into two, current one submit to bpf,
   another one submit to bpf-next.
 - Update the commit title.
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6f9956eed797..ad6c08dfd6c8 100644
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
-- 
2.34.1


