Return-Path: <linux-kselftest+bounces-36351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFCBAF5F50
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95574A6693
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4941301132;
	Wed,  2 Jul 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Va46DDik"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486B2F3C36;
	Wed,  2 Jul 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475535; cv=none; b=b39cmHt72u4N/Eqyg6305RYC0Qpy2qASnegX3mHyLV+JeojC2WFMsAGZcUEEU4wLO2HmqE3071fxuF/fvaqx+SbXXPPav/CkhzajFMq68HTSk9CuZK/ZgTddPn5K8ottYHrwhyphhIfGNve1J3CvKckw8gi4oY1hVi4CtKHBCio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475535; c=relaxed/simple;
	bh=NRCwcBa+605nVVuq9je4xdUTbE9ogB25Tw0Q/57qzjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fS/5xfHmCtBq2huTmZyUS9rfudB5MBVXXFZYHBgktV41BaQwpeJl/K8OMpqeG+UyzO+8Qefh6N1pLQz06DDDN5FKU52RTqU/uuJ4OP/ldLnIfmU5eGUr58AidIfP8fIsrzK56FXw+LDmNCbg0TvyZLOxOhsxU2vFq1PrI5lGru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Va46DDik; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751475534; x=1783011534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NRCwcBa+605nVVuq9je4xdUTbE9ogB25Tw0Q/57qzjo=;
  b=Va46DDikOrXIvfSbOucqM1atsEf6wuQZFPMhiuFjsRBgPxieIWJEuhq2
   K5MKInUEWn3IXCwkCKmr5mYJsoJ07xB3pLVzxnNkhWhfajsSUwCy3CBzn
   MYktuT7gUC/mb5bMkva+LGmvo7ZSEoXSaFfmAYdjYg506HMUaLFnNhWRI
   9oEsKozvvr+ZWiSCe2W2wW0Ny2ie9oXPnl9i+rYz4+FfiPO0K71MMohRh
   8SlaEtcOSxGzgFWBZ7itxzgLPcyHdKmZIt+PJpTqIKkxvtz6b9Xfmw4ID
   IbDBUoMKlPEMnjY+u29znO3SkEZafnlSHiQD2rkviifZJiC16Mw6HNv74
   g==;
X-CSE-ConnectionGUID: 12lNxwf/S0OsXOrdB8qR6A==
X-CSE-MsgGUID: QC5ondRCQEm5NZ4A3IbjCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65132676"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="65132676"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 09:58:54 -0700
X-CSE-ConnectionGUID: 1sbzCVlVTSCIMJVzDvo/3g==
X-CSE-MsgGUID: 5LYgvkbZQkqdQZuay9eh1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153538594"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2025 09:58:47 -0700
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
Subject: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata handling
Date: Thu,  3 Jul 2025 00:57:57 +0800
Message-Id: <20250702165757.3278625-3-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702165757.3278625-1-yoong.siang.song@intel.com>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the XDP_METADATA_SIZE macro as a conservative measure to
accommodate any metadata areas reserved by Ethernet devices.

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


