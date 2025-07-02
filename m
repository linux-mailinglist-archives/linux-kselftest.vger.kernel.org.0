Return-Path: <linux-kselftest+bounces-36350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCE4AF5F49
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C069F484D17
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEA22FF48E;
	Wed,  2 Jul 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1+lHhsR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202E1DACB1;
	Wed,  2 Jul 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475529; cv=none; b=bxFrL6a2QeHQHB3Qly4Ojx41MX5TYWFcFwUsSMkZ9ycjHmtptVWbckPNdmMmSC88UwUfP3GIiwwrOQEfCnTsqYk7DNV7e7QgVbx2DiM52g2kqBaZi/AkO1/3apeAOTmfimDEBn+TsiePTIVdPr2cOCBhnUO8otJHVeWqnk+ykPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475529; c=relaxed/simple;
	bh=0Y0rAgKbRmjp0aExcFCmCupQOJxS3kfg7p4YDyQlK4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXZ5kKchM1KVXmAb3IMkVRadwRvg0lMu0LDw+S7LlB4JbE3T4xhXc13kg22NPt5VTE7H7R+tmI9fo/vBECpVbpp+F1k1wpEI+OuJTEpVoAiRKonMRZHdYX8QW8XCpmS5pUWVA0jQHNt2OggYW3wpvj63Clw2s7XdKYLnQaOjPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1+lHhsR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751475528; x=1783011528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Y0rAgKbRmjp0aExcFCmCupQOJxS3kfg7p4YDyQlK4M=;
  b=A1+lHhsR3mGXJHdsr912UjRlTG2cYpaH9E+BVxwuf5KLiUQA7wHtZxk1
   OLyevugtlnQ1I41vpl96Hm4aquxrHSajv0fHlROx4RBaZX9nJrsNegwrn
   tH3+bOvxnLhNmRtpCbVrJcaO56mh1nRj6ZX3cIwOc0vT4/F1I6MlzxPN8
   wAhln/2FCNcreHTNVrTY1+iOJB0k8vIpGOH4LYvCbaBSQ8U7LOViOgEhl
   x/cz64UTENurKJ1ALSxY1Go6gDvAyoTZZSFcYL6N6q2b0mjtjwCHasKzi
   2b7qGvPYShREF+1bhZPdEfK0bRpI9GeE6s5pQRiruFv5WcGOMUGpb/sm0
   w==;
X-CSE-ConnectionGUID: 29zAYVn5RY+8IBYlVJkoNA==
X-CSE-MsgGUID: GuMIIhLRSsewbhYCcGBLKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65132640"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="65132640"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 09:58:48 -0700
X-CSE-ConnectionGUID: +TCAcKOZRJifDTqrOd9KYA==
X-CSE-MsgGUID: UMM4RcscRGuzeBLPs575eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153538539"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2025 09:58:41 -0700
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
Subject: [PATCH bpf-next,v3 1/2] doc: enhance explanation of XDP Rx metadata layout and METADATA_SIZE
Date: Thu,  3 Jul 2025 00:57:56 +0800
Message-Id: <20250702165757.3278625-2-yoong.siang.song@intel.com>
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

Add diagram to show metadata layout of devices that utilize the data_meta
area for their own purposes. Besides, enhance the documentation on
selecting an appropriate METADATA_SIZE for XDP Rx metadata, ensuring it
accommodates both device-reserved and custom metadata. It includes
considerations for alignment and size constraints. The updated guidance
helps users correctly allocate and access metadata in AF_XDP scenarios.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 Documentation/networking/xdp-rx-metadata.rst | 36 ++++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index a6e0ece18be5..65a1a6e0f7a2 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -54,6 +54,19 @@ area in whichever format it chooses. Later consumers of the metadata
 will have to agree on the format by some out of band contract (like for
 the AF_XDP use case, see below).
 
+It is important to note that some devices may utilize the ``data_meta`` area for
+their own purposes. For example, the IGC device utilizes ``IGC_TS_HDR_LEN``
+bytes of the ``data_meta`` area for receiving hardware timestamps. Therefore,
+the XDP program should ensure that it does not overwrite any existing metadata.
+The metadata layout of such device is depicted below::
+
+  +----------+-----------------+--------------------------+------+
+  | headroom | custom metadata | device-reserved metadata | data |
+  +----------+-----------------+--------------------------+------+
+             ^                                            ^
+             |                                            |
+   xdp_buff->data_meta                              xdp_buff->data
+
 AF_XDP
 ======
 
@@ -69,12 +82,23 @@ descriptor does _not_ explicitly carry the size of the metadata).
 
 Here is the ``AF_XDP`` consumer layout (note missing ``data_meta`` pointer)::
 
-  +----------+-----------------+------+
-  | headroom | custom metadata | data |
-  +----------+-----------------+------+
-                               ^
-                               |
-                        rx_desc->address
+             |<--------------METADATA_SIZE--------------->|
+  +----------+-----------------+--------------------------+------+
+  | headroom | custom metadata | device-reserved metadata | data |
+  +----------+-----------------+--------------------------+------+
+                                                          ^
+                                                          |
+                                                   rx_desc->address
+
+It is crucial that the agreed ``METADATA_SIZE`` between the BPF program and the
+final consumer is sufficient to accommodate both device-reserved metadata and
+the data the BPF program needs to populate.
+
+``bpf_xdp_adjust_meta`` ensures that ``METADATA_SIZE`` is aligned to 4 bytes,
+does not exceed 252 bytes, and leaves sufficient space for building the
+xdp_frame. If these conditions are not met, it returns a negative error. In this
+case, the BPF program should not proceed to populate data into the ``data_meta``
+area.
 
 XDP_PASS
 ========
-- 
2.34.1


