Return-Path: <linux-kselftest+bounces-36244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 619A8AF08E4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7877A1C071C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF151D6DA9;
	Wed,  2 Jul 2025 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itN7fcnY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14322770B;
	Wed,  2 Jul 2025 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425476; cv=none; b=RBUNlh6up//ikvpUDsHvRdFF781+WWJ01S4c93MdDhHSSttyJo3AS4qEhyJ5/luBCvfwLXNthFZQumQP8WXfzedSYhTf2kTCeAEE8Z9LuNF9UdDGqX3DhG2NREbn7jQBt7qxvD0iq6DtNBueP/RjOK6FP7UjMsxXYzyiEYdrWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425476; c=relaxed/simple;
	bh=6VzUIVl7rOqTKTEIjM22aIEwtpdRzAbHjfEmET9YvGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBV/XTTnXTy1bL3xft1+cNhItDED2wY4XwZkBccQTMgv540IvEs6WD5X/e9ewFQoucqUwaAgXNCpHdVbgPlhXC/CR68wGOTXAz8anyc9kezJFWJxOIpk7DNBn527QWh/aO4rnMNXjUEpUHK9F0uYmNunfUEYtLcRUf9zW1WGL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itN7fcnY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751425474; x=1782961474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6VzUIVl7rOqTKTEIjM22aIEwtpdRzAbHjfEmET9YvGU=;
  b=itN7fcnYf5hmA7xvzstfkLtheUfPzIy0ZA1LcpsFKEXQ3gRVLm9nCtG8
   RDThYRsmwTjMJRcgoypAnzJmfU/OeNVvoCcHZQDd484+LvS7/7NdIXut3
   6+PHmSlZ6EvX7/nRrBeNMAQLzkhbYR/ULGdpxN+oU2ck99wxP7xtBi3ud
   VmiCNmGq4FxKW2dzLm5LHnnU6y5u0SIM+QXJ6ZJKsLtHBRsQLVIoNDPzF
   XTrCMK7iI41szzKAzWJvN/7cqFDzDHugNr1NWZjyQ63arkaieiWEDdpFm
   JIcl7T68xh7Ms9fBrtC83owct3DgZ4ndU39+vuM3yM0TSMmpVVDB44IfO
   w==;
X-CSE-ConnectionGUID: mg33RTtWRoKo5NcbgyJktw==
X-CSE-MsgGUID: Bn5WnCJiToeCNSVSPKyd8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71132800"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="71132800"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 20:04:33 -0700
X-CSE-ConnectionGUID: 2tMagG+lR4aGZm6aEv6yQg==
X-CSE-MsgGUID: q0EbIHsITgu3t6MdqPfdCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="153407664"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa006.jf.intel.com with ESMTP; 01 Jul 2025 20:04:27 -0700
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
Subject: [PATCH bpf-next,v2 1/2] doc: clarify XDP Rx metadata layout and bpf_xdp_adjust_meta usage
Date: Wed,  2 Jul 2025 11:03:48 +0800
Message-Id: <20250702030349.3275368-2-yoong.siang.song@intel.com>
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


