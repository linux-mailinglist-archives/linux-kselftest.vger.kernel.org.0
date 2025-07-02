Return-Path: <linux-kselftest+bounces-36245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12F0AF08E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC034E2CDA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4397C1C3C1F;
	Wed,  2 Jul 2025 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q96mLj3j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951071DE2A8;
	Wed,  2 Jul 2025 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425481; cv=none; b=f59r7sC1UaN456dyZTS9wmPnzBpfPLzJp2Wty/y+yJ9Oi+Xb9axlwabrP4Kj+wsCYB6KYm2EaSnjrj2odXZHCIgmxkN9tb88cz5KiBg1lethGU/xDr/0rHnf0ZcdjYvk4/WuwAqJjEsZIFJdOrHwsYqo8q91abEQx0pmvri1q1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425481; c=relaxed/simple;
	bh=N/Ju9CTx2ChR+SLX12GIxOTP4pPLBnK+s0QZSnEJQR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otWKRJEE93kNsz0v1NWcjnyvB47LK+RvWpttCSJgDkLwA9edKQG2umpzOxH0Vd+ASyJmpdbp01pXLY0cIlGyEc7ke+aQKZGdVB0PmQdvlVSEGnO/S52EFJjqfYBDzJTPxtHcpKQv3b4T5xVsFrAAW0PkiyWXUieEY5jHuELB+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q96mLj3j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751425479; x=1782961479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N/Ju9CTx2ChR+SLX12GIxOTP4pPLBnK+s0QZSnEJQR0=;
  b=Q96mLj3jWqZebQilcAze2g6pj3Pw3CbYDFxPEVmX8Naqmj9+JQK+MZYU
   r3+ukP68cq0x8yej1pP7j0F0/mot9hdC79lzrhdxCFYgICDOZT3QskF/y
   UG/jNwDlsjKte6Kd1YOSQDEWHwxdRjgakp8YAZd35UPQa87/1Oot6ysIJ
   xC95TDyndhR9m1dHlE6j6sCRVdnylaT8SXPA4HQqtmIkWeDmVBcdhb7Ly
   HHKmFC9hAXpH6GCtO1/NvWnoAifujTInJzAg3IADO8AVlvUz/LKCErRbQ
   vjyarRAJng6XEFwJ+ilF/v6pxEbvm+RuEYAwh2Swj9KpFISjcBQfLFzDk
   g==;
X-CSE-ConnectionGUID: JZJ8RwbZShekUO+NQ6kVnw==
X-CSE-MsgGUID: Gm2OtYstRQmqv/RaM4xwuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71132823"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="71132823"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 20:04:39 -0700
X-CSE-ConnectionGUID: g3knVLkyTzulmTRFrLkusw==
X-CSE-MsgGUID: UeiYLr6bTeu55Zvc68NCQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="153407683"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa006.jf.intel.com with ESMTP; 01 Jul 2025 20:04:33 -0700
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next,v2 2/2] selftests/bpf: Enhance XDP Rx Metadata Handling
Date: Wed,  2 Jul 2025 11:03:49 +0800
Message-Id: <20250702030349.3275368-3-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702030349.3275368-1-yoong.siang.song@intel.com>
References: <20250702030349.3275368-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the XDP_METADATA_SIZE macro to ensure that user applications can
consistently retrieve the correct location of struct xdp_meta.

Prior to this commit, the XDP program adjusted the data_meta backward by
the size of struct xdp_meta, while the user application retrieved the data
by calculating backward from the data pointer. This approach only worked if
xdp_buff->data_meta was equal to xdp_buff->data before calling
bpf_xdp_adjust_meta.

With the introduction of XDP_METADATA_SIZE, both the XDP program and user
application now calculate and identify the location of struct xdp_meta from
the data pointer. This ensures the implementation remains functional even
when there is device-reserved metadata, making the tests more portable
across different NICs.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 2 +-
 tools/testing/selftests/bpf/progs/xdp_hw_metadata.c   | 2 +-
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c         | 2 +-
 tools/testing/selftests/bpf/xdp_metadata.h            | 7 +++++++
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 19f92affc2da..8d6c2633698b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -302,7 +302,7 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 
 	/* custom metadata */
 
-	meta = data - sizeof(struct xdp_meta);
+	meta = data - XDP_METADATA_SIZE;
 
 	if (!ASSERT_NEQ(meta->rx_timestamp, 0, "rx_timestamp"))
 		return -1;
diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 330ece2eabdb..3766f58d3486 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -72,7 +72,7 @@ int rx(struct xdp_md *ctx)
 		return XDP_PASS;
 	}
 
-	err = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
+	err = bpf_xdp_adjust_meta(ctx, -(int)XDP_METADATA_SIZE);
 	if (err) {
 		__sync_add_and_fetch(&pkts_fail, 1);
 		return XDP_PASS;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d52..5cada85fe0f4 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -73,7 +73,7 @@ int rx(struct xdp_md *ctx)
 
 	/* Reserve enough for all custom metadata. */
 
-	ret = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
+	ret = bpf_xdp_adjust_meta(ctx, -(int)XDP_METADATA_SIZE);
 	if (ret != 0)
 		return XDP_DROP;
 
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 3d8de0d4c96a..a529d55d4ff4 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -223,7 +223,7 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 {
 	struct xdp_meta *meta;
 
-	meta = data - sizeof(*meta);
+	meta = data - XDP_METADATA_SIZE;
 
 	if (meta->hint_valid & XDP_META_FIELD_RSS)
 		printf("rx_hash: 0x%X with RSS type:0x%X\n",
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 87318ad1117a..2dfd3bf5e7bb 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -50,3 +50,10 @@ struct xdp_meta {
 	};
 	enum xdp_meta_field hint_valid;
 };
+
+/* XDP_METADATA_SIZE must be at least the size of struct xdp_meta. An additional
+ * 32 bytes of padding is included as a conservative measure to accommodate any
+ * metadata areas reserved by Ethernet devices. If the device-reserved metadata
+ * exceeds 32 bytes, this value will need adjustment.
+ */
+#define XDP_METADATA_SIZE	(sizeof(struct xdp_meta) + 32)
-- 
2.34.1


