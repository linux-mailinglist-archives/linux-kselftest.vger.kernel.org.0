Return-Path: <linux-kselftest+bounces-36136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38169AEED3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 06:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9672B17EBBC
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 04:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8DE20AF98;
	Tue,  1 Jul 2025 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hm4wfT0z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518351862A;
	Tue,  1 Jul 2025 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751344225; cv=none; b=ZRwE0J8pSfKPuBNC0suyJLF46/oEU8Ytl/aZLru4MQm60mZbhzycbeG2OMYSldC3b91BIIshBjFQH2fa400qoKvGhsZ9e0EET77nBAwq+oKzjUvn7md0I5repuHXGGoe+km0sD9zXqJN00OTk9Eo9+f7Up4KlhYtZqh1XPWGCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751344225; c=relaxed/simple;
	bh=f3TlQ7GiBtQlnc2LsSVmB7Cz32Z2h4SA+nSMFSo0f/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Epy4EqIyMZQmNuM+kr/9+eU8n2Q++v3X1ZNN7oc8ZDNMXSaeyaTPP7N+N7fJ/TMg61qW3Irk1p2KtDCrkZdFDCAuCce5xP9IkN1tGeB2pMuwqj1MQSa2zHkHgf35MpdWYjnoZE5kQ5jFrOoyqp3UcSEp3TKC3CWyNBKUAYv49Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hm4wfT0z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751344223; x=1782880223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f3TlQ7GiBtQlnc2LsSVmB7Cz32Z2h4SA+nSMFSo0f/E=;
  b=Hm4wfT0z5FCPo7k+GW0t0+wBH3WtFyp0iD5Hi4oRQEvoUKlza393zzxt
   XoZ5jqdd0eNQhcX0O63ypcrjURsKrmQnYx/m297/egCQnmkCJoVw3awxD
   nONZc15R1zu5lHzix+0wJF4M/aMyltucKtP239Fyyk5o4+E2vfAdZjZQY
   rQeoD47KF5B+kclpubl26F90HsVt93fRvG+n2cvcteVpkfH+E7fdmCH/c
   iCXMyA7ibqbSYD9X0Oc2AJyAXHgFPHm9GL+MHMARHCQJjVgaVYfKYjB7Y
   L2EmJY8v32iOssE3vZ+0wZFvCOga0yYWHbLT65DOp7Ay7WEmqlpLpyJWV
   A==;
X-CSE-ConnectionGUID: MV+DzCFFTDy2sF5BQz6umw==
X-CSE-MsgGUID: 1mVU/a4NRC2gVjcNCbDUoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="56210209"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="56210209"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 21:30:22 -0700
X-CSE-ConnectionGUID: xTJoGmNUQei78wJYr+f3hw==
X-CSE-MsgGUID: vTlz7qJbQC+wlBuzbiE1dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177308997"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jun 2025 21:30:17 -0700
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
Subject: [PATCH bpf-next 0/2] Clarify and Enhance XDP Rx Metadata Handling
Date: Tue,  1 Jul 2025 12:29:38 +0800
Message-Id: <20250701042940.3272325-1-yoong.siang.song@intel.com>
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

Song Yoong Siang (2):
  doc: clarify XDP Rx metadata layout and bpf_xdp_adjust_meta usage
  selftests/bpf: Enhance XDP Rx Metadata Handling

 Documentation/networking/xdp-rx-metadata.rst  | 38 +++++++++++++++++++
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  2 +-
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 10 ++++-
 .../selftests/bpf/progs/xdp_metadata.c        |  8 +++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  2 +-
 tools/testing/selftests/bpf/xdp_metadata.h    |  7 ++++
 6 files changed, 63 insertions(+), 4 deletions(-)

-- 
2.34.1


