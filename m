Return-Path: <linux-kselftest+bounces-36137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00EAEED45
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 06:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973A11BC08E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 04:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62F225A34;
	Tue,  1 Jul 2025 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qi/5YWO6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858672248BD;
	Tue,  1 Jul 2025 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751344230; cv=none; b=lWzE0NFH7qTclVXZrdDnkVGZ01CJGNkt8K0ZyKEypiPGEqSPKhUMA+SHzguqoeQ7poNgllJq7BXnfDCbTQTYT28ZpajCak3itHsCUyIp2wHQg4P6tlz3g32QgwwZNJQyGaanVbSiPnCOfwD/ca1ed7foJEorpFHzUcPB9iOLjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751344230; c=relaxed/simple;
	bh=6VzUIVl7rOqTKTEIjM22aIEwtpdRzAbHjfEmET9YvGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3wmWFD/g99NDiQ5p2at9lRRFmr4v/dBjCZtgpYM+yZ9955fYGWhCxC8t2iprIplmIl05yxqtr7yqn/PzyGkuB/eCo1lAUg0h3WmbnO0oYZYvlaJ1+CpA+ihP4PbWv2oAB6tPRwo6zbrbqomfhsjA1t/v/Qaq1cpJ+eXflLEPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qi/5YWO6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751344228; x=1782880228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6VzUIVl7rOqTKTEIjM22aIEwtpdRzAbHjfEmET9YvGU=;
  b=Qi/5YWO6jEOV5fNBun4kw98pv4at8s3oX2qizkUuMVtW5KLc+aaf8ChM
   ZBmIxHl45s1PnmZLpmyt+AW1Q6iTsl6KVYztGXinR8eyzPF5IDvjGvnf9
   1x5EOruzHlGTxMsWL4bk/H899Ql0ig5hCf410BaCHGJwFznVoMcmOMTSk
   kQBO+H0UUQvOktDiOQNt8KRw0p9rKsNaKS0wONXDLplXNvL6iWuAkhi8q
   2JW0XgY3Vmc/tm3gy7uroyPJN5KiEgNckA8IosfFmR8n1C4uLu2+NnlEf
   UhQb/vXGbTjh6J2QawnABZiv5wZs2AvMWDoL4FKyIXAx/OTWQpdlsL8X9
   A==;
X-CSE-ConnectionGUID: i+vO1p1UTm2zgZaea2UJzg==
X-CSE-MsgGUID: GSdUVkgsRnSxwuF62QLJ3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="56210238"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="56210238"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 21:30:28 -0700
X-CSE-ConnectionGUID: AwuugabBTd6VG6l3LFT9Qw==
X-CSE-MsgGUID: 3V4b/HrqTEG8mADT/u8qlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177309013"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jun 2025 21:30:23 -0700
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
Subject: [PATCH bpf-next 1/2] doc: clarify XDP Rx metadata layout and bpf_xdp_adjust_meta usage
Date: Tue,  1 Jul 2025 12:29:39 +0800
Message-Id: <20250701042940.3272325-2-yoong.siang.song@intel.com>
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

Expand the explanation of how METADATA_SIZE should be chosen to accommodate
both device-reserved and custom metadata. Additionally, add a diagram to
illustrate the calculation of the delta parameter for bpf_xdp_adjust_meta,
including alignment and size constraints.

These changes help users correctly allocate and access metadata in AF_XDP
use cases.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 Documentation/networking/xdp-rx-metadata.rst | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index a6e0ece18be5..61418f533e0e 100644
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
 
@@ -76,6 +89,31 @@ Here is the ``AF_XDP`` consumer layout (note missing ``data_meta`` pointer)::
                                |
                         rx_desc->address
 
+It is crucial that the agreed ``METADATA_SIZE`` between the BPF program and the
+final consumer is sufficient to accommodate both device-reserved metadata and
+the data the BPF program needs to populate. When calling
+``bpf_xdp_adjust_meta``, the input parameter ``delta`` should be calculated as
+``METADATA_SIZE - (xdp_buff->data - xdp_buff->data_meta)``.
+
+The diagram below provides a visual representation of the calculation of
+``delta`` and the overall metadata layout::
+
+             |<-------------------METADATA_SIZE------------------->|
+  +----------+--------------------------+--------------------------+------+
+  | headroom |      custom metadata     | device-reserved metadata | data |
+  +----------+--------------------------+--------------------------+------+
+             ^                          ^                          ^
+             |                          |                          |
+  new xdp_buff->data_meta    old xdp_buff->data_meta        xdp_buff->data
+             |                          |
+             |<----------delta--------->|
+
+``bpf_xdp_adjust_meta`` ensures that ``METADATA_SIZE`` is aligned to 4 bytes,
+does not exceed 252 bytes, and leaves sufficient space for building the
+xdp_frame. If these conditions are not met, it returns a negative error. In this
+case, the BPF program should not proceed to populate data into the ``data_meta``
+area.
+
 XDP_PASS
 ========
 
-- 
2.34.1


