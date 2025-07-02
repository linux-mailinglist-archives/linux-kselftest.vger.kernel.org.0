Return-Path: <linux-kselftest+bounces-36349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB271AF5F45
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDCC3BD2D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DAA2E0418;
	Wed,  2 Jul 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSHOxZEC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376831DACB1;
	Wed,  2 Jul 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475523; cv=none; b=VeLAEoVIPmjVocnKBzgeqw4C27CKF2U7n0td0kFpWchCMNq3QvwEo3WJLWmg82IjIWTk5mpODMRmnVbtp6h3r6aR1LAbKKlpUljreKdzrf80DvDqgw3ODnFj8P6TcspzQOkQ4UecD4IgJjMJ3iAoSSEAFTooU6aor0aYkce1fcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475523; c=relaxed/simple;
	bh=/ef4CrFmebCh1AqCX+/iSl6DfpNGDmZ7ZDGmWGiqK8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g6UMd/sigIs/vdgQBAp3j95EUyNe5TRv6wbGdfMecyVgpDzqoPArQiQfnrQ2P2EP1dLQCcqF/+c1WbsdjWUDQjHY6EvVQntDpyCbAygYQ9z8pEqMr7vFJU3a3mSXLm/Il04O37vc8pcybbiCzzqIEcZmwSMFfI0HJjZEtCkChLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSHOxZEC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751475523; x=1783011523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/ef4CrFmebCh1AqCX+/iSl6DfpNGDmZ7ZDGmWGiqK8E=;
  b=RSHOxZECzkePmjIkf3SuP9X5TEBl+oECLEC79f5PVMK1N5WIb6anjXO9
   QgR/UWIoUKXan33D/1ES2AR1dzyAh8qfcIBOTpbO1oRDOete+fUY1Z0tf
   SRORQKrZIy6cIy35AxgI+mWlsYxBlEt2RPZ3im6MJbkEuLTZEAmfHVaLv
   ReNKIdjXkq2LnzySjZLjIRC0JYOc0c+iJXQbRNqOLcnlDida/4Grgf+CC
   JnKGyis3p9OBRAuR9+7y6sLErUY3+hftwg/04jiby+yUGdKiYXIZgVyJC
   +CF9uVpmFjg1RkIaszybWy8msNgImev0uGG5/DGpqTYbjRbZY2tQpUE9v
   Q==;
X-CSE-ConnectionGUID: VLW5SnE8SsCw5SwEiV+5xg==
X-CSE-MsgGUID: 3vB3Ur6QTcKnb3LBM+utVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65132604"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="65132604"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 09:58:42 -0700
X-CSE-ConnectionGUID: AZcKulOWRi+cKuI+6SBM1A==
X-CSE-MsgGUID: aYFH497xR6ehS/lwI7YwMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153538515"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2025 09:58:35 -0700
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
Subject: [PATCH bpf-next,v3 0/2] Clarify and Enhance XDP Rx Metadata Handling
Date: Thu,  3 Jul 2025 00:57:55 +0800
Message-Id: <20250702165757.3278625-1-yoong.siang.song@intel.com>
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
layout and METADATA_SIZE. The second patch enhances the BPF selftests to
make XDP metadata handling more robust across different NICs.

Prior to this patch set, the XDP program might accidentally overwrite the
device-reserved metadata.

V3:
  - update doc and commit msg accordingly.

V2: https://lore.kernel.org/netdev/20250702030349.3275368-1-yoong.siang.song@intel.com/
  - unconditionally do bpf_xdp_adjust_meta with -XDP_METADATA_SIZE (Stanislav)

V1: https://lore.kernel.org/netdev/20250701042940.3272325-1-yoong.siang.song@intel.com/

Song Yoong Siang (2):
  doc: enhance explanation of XDP Rx metadata layout and METADATA_SIZE
  selftests/bpf: Enhance XDP Rx metadata handling

 Documentation/networking/xdp-rx-metadata.rst  | 36 +++++++++++++++----
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  2 +-
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  2 +-
 .../selftests/bpf/progs/xdp_metadata.c        |  2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  2 +-
 tools/testing/selftests/bpf/xdp_metadata.h    |  7 ++++
 6 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.34.1


