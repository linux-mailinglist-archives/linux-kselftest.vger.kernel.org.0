Return-Path: <linux-kselftest+bounces-36243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27A7AF08DD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075101C03E17
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC319AD8C;
	Wed,  2 Jul 2025 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hg+FzbO2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFF2770B;
	Wed,  2 Jul 2025 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425470; cv=none; b=H3Ca4+u6sCBkuDwvrbOpxq9HmY3f3Cx3XlyixS5EllFCgpZ6LGZ0xL2ujHTT7cbuNYn6raPrelc4c0ZuEbnbSL6QhdC54GRfdqeVPrWJZavonS/8qRNNtAZKqiMYU8jlOtr9GIOPZ0xfPnNsdizprAVz/jolaaeWx7Wr0yf3MXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425470; c=relaxed/simple;
	bh=O3rfVKsvccI6uQyYh//4AFptB8tUAcJndLZh8J0HwjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQ4X5WMBwp26VWji8soYIlM/hmXptcu1HdaXXNeayxh7SaYr1hricYCMNOTHeZmKZ6RbpOEUMyq1ut7jrXd7VYYkXjvHrhJ60RmXfjJyq203jrO02nbFuLSyJ2T2Vlo6kixk9dezQ5p47eOpus13gVOTDl1B98/r66NqgF1Kpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hg+FzbO2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751425468; x=1782961468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3rfVKsvccI6uQyYh//4AFptB8tUAcJndLZh8J0HwjY=;
  b=hg+FzbO24c8Wn3AX/i9YRuLI8YPtOR+sGle1VEvdUqLSkivpIhRSH1G6
   //N+SI+zgN2NbaTAwmsQSGSp2l/hWcsERvzJ5Lx2DL2sAOamGZk863+tD
   J+rSLZQOu+EtQVCXcloOKJRhe1OQ5N/O0Hsyq7wfzuE05roxWHkNmAx/7
   VvfV/8L+AY04nb2N7L8WycYntKT5GV9vqxVT0EmDcURyrm0NId4q9wJ2Y
   nJZPHz5muua+lQCMYj3CjUnZmxMfgDUgXqgJMfewgC5zu4Y46F1w38vrS
   ZgfuPVbcMoKVTsI13X4eVvuNyT78Fx2Pt507zqEKvmqr2o0xxM8dxwZyG
   Q==;
X-CSE-ConnectionGUID: XeuMerBHQQOWjbzVzpAK/A==
X-CSE-MsgGUID: gBudwoqbTO2il3t7x8E84Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71132790"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="71132790"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 20:04:27 -0700
X-CSE-ConnectionGUID: /fSFODvNS+GsdXXvubXrFw==
X-CSE-MsgGUID: WsPOGeWLTgmJt3NnWhl64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="153407624"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa006.jf.intel.com with ESMTP; 01 Jul 2025 20:04:19 -0700
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
Subject: [PATCH bpf-next,v2 0/2] Clarify and Enhance XDP Rx Metadata Handling
Date: Wed,  2 Jul 2025 11:03:47 +0800
Message-Id: <20250702030349.3275368-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set improves the documentation and selftests for XDP Rx metadata
handling. The first patch clarifies the documentation around XDP metadata
layout and the use of bpf_xdp_adjust_meta. The second patch enhances the
BPF selftests to make XDP metadata handling more robust and portable across
different NICs.

Prior to this patch set, the user application retrieved the xdp_meta by
calculating backward from the data pointer, while the XDP program fill in
the xdp_meta by calculating backward from data_meta. This approach will
cause mismatch if there is device-reserved metadata.

                        |<---sizeof(xdp_meta)--|
                        |                      |
                 struct xdp_meta               rx_desc->address
                        ^                      ^
                        |                      |
+----------+----------------------+------------+------+
| headroom |    custom metadata   |  reserved  | data |
+----------+----------------------+------------+------+
           ^                      ^            ^
           |                      |            |
    struct xdp_meta     xdp_buff->data_meta    xdp_buff->data
           |                      |
           |<---sizeof(xdp_meta)--|

V2:
  - unconditionally do bpf_xdp_adjust_meta with -XDP_METADATA_SIZE (Stanislav)

V1: https://lore.kernel.org/netdev/20250701042940.3272325-1-yoong.siang.song@intel.com/

Song Yoong Siang (2):
  doc: clarify XDP Rx metadata layout and bpf_xdp_adjust_meta usage
  selftests/bpf: Enhance XDP Rx Metadata Handling

 Documentation/networking/xdp-rx-metadata.rst  | 38 +++++++++++++++++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  2 +-
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  2 +-
 .../selftests/bpf/progs/xdp_metadata.c        |  2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  2 +-
 tools/testing/selftests/bpf/xdp_metadata.h    |  7 ++++
 6 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.34.1


