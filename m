Return-Path: <linux-kselftest+bounces-36138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DFEAEED48
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 06:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198B27AD2D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 04:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164A423E335;
	Tue,  1 Jul 2025 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEuaWSUe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC541F30A4;
	Tue,  1 Jul 2025 04:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751344236; cv=none; b=aBCZ5CfqU9sqqJAbIp2AHWCW7E7j9TdKGMcYYtuJzV1Yn40cICnb4YeJ9e/uqp02YSXz8A/dDDSL1fAKETZkUOHZdDvh/TxayOo+7RfniM7n2goUQcQg0WA7Y4LKow/K4eubw9kf+FAcPIaXpU68/4MwClPDIdNu4SsbjsrD9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751344236; c=relaxed/simple;
	bh=yUhVeNxdkmKD+O9VsLaYb0eZmmOxIaA8qvBCe1VT2GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifObpOO8hVmWILpA/c+Zw8PW9aycoeuexUOQtp785R7Z0uYxoK6ODfwwFE6PDqKNdYPkXpffLsEXqtU9zekaupSMZL/ruCGHk77a7DwerS85rJRH4Bie+TtJmwLFp1FKB98p8LKuUHSAUw0f7Sus8/TPy0bsILcIwTalOaF3dtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEuaWSUe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751344234; x=1782880234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUhVeNxdkmKD+O9VsLaYb0eZmmOxIaA8qvBCe1VT2GA=;
  b=HEuaWSUelAnnfkdmxbhB6DzzHtLpzj125th7proGw7RqPauhQxJKU613
   VNjxlrIa95hSrzvMqtIJEdm7IUFidgLua5wX3tquUySaAN6pLnJSWAmPR
   YoE21hsM+ghj1Fezchess8ByMSsNCR+2LiU5IhJ7lM8ebBKNfqbejRpkH
   KNpigsQftH4Km3w5xNZqOEPqGENjsjFmU+jZI9NeHC7mQqn5yzVy6F4iD
   O0zKL2t9Ac3SiHBnQHiQSP7Rwb337PmstLzmpbkrWO4gmRaf2ZeLHxaJZ
   WyrJqKk/PGgKacOtGgItspzur61TPprjx3Sj6OqOcIn46N3dH4NDTUewI
   g==;
X-CSE-ConnectionGUID: WoHD9zB3TMykQDQ2Cxs24Q==
X-CSE-MsgGUID: VXktZWvGT/yzd6Z6GT7mvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="56210258"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="56210258"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 21:30:33 -0700
X-CSE-ConnectionGUID: 1GVvgBZ+Q46TnzFyc3frmQ==
X-CSE-MsgGUID: 5XpjMaIaSZGPuyI+9+LpCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177309029"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jun 2025 21:30:28 -0700
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Enhance XDP Rx Metadata Handling
Date: Tue,  1 Jul 2025 12:29:40 +0800
Message-Id: <20250701042940.3272325-3-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701042940.3272325-1-yoong.siang.song@intel.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
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
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c |  2 +-
 tools/testing/selftests/bpf/progs/xdp_hw_metadata.c   | 10 +++++++++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c      |  8 +++++++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c         |  2 +-
 tools/testing/selftests/bpf/xdp_metadata.h            |  7 +++++++
 5 files changed, 25 insertions(+), 4 deletions(-)

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
index 330ece2eabdb..72242ac1cdcd 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -27,6 +27,7 @@ extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 SEC("xdp.frags")
 int rx(struct xdp_md *ctx)
 {
+	int metalen_used, metalen_to_adjust;
 	void *data, *data_meta, *data_end;
 	struct ipv6hdr *ip6h = NULL;
 	struct udphdr *udp = NULL;
@@ -72,7 +73,14 @@ int rx(struct xdp_md *ctx)
 		return XDP_PASS;
 	}
 
-	err = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
+	metalen_used = ctx->data - ctx->data_meta;
+	metalen_to_adjust = XDP_METADATA_SIZE - metalen_used;
+	if (metalen_to_adjust < (int)sizeof(struct xdp_meta)) {
+		__sync_add_and_fetch(&pkts_skip, 1);
+		return XDP_PASS;
+	}
+
+	err = bpf_xdp_adjust_meta(ctx, -metalen_to_adjust);
 	if (err) {
 		__sync_add_and_fetch(&pkts_fail, 1);
 		return XDP_PASS;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d52..a0ba4ef4bbd8 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -37,6 +37,7 @@ extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 SEC("xdp")
 int rx(struct xdp_md *ctx)
 {
+	int metalen_used, metalen_to_adjust;
 	void *data, *data_meta, *data_end;
 	struct ipv6hdr *ip6h = NULL;
 	struct ethhdr *eth = NULL;
@@ -73,7 +74,12 @@ int rx(struct xdp_md *ctx)
 
 	/* Reserve enough for all custom metadata. */
 
-	ret = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
+	metalen_used = ctx->data - ctx->data_meta;
+	metalen_to_adjust = XDP_METADATA_SIZE - metalen_used;
+	if (metalen_to_adjust < (int)sizeof(struct xdp_meta))
+		return XDP_DROP;
+
+	ret = bpf_xdp_adjust_meta(ctx, -metalen_to_adjust);
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


