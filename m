Return-Path: <linux-kselftest+bounces-5740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E6086E570
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 17:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98924B24B1F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5A7351E;
	Fri,  1 Mar 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsfcyClN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296874267;
	Fri,  1 Mar 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310279; cv=none; b=l1etIH+qz2J0GMY1CDvZSOeovonr9dEjHnqg26YfcZw9UEY2E2gwIT3MosGVilnjlYUt8HqQoB7c8qkGYZYndEvIJqWoGNBJQqpl3405uByVw0mgYHAod/IFx/yayN6FCSU9kynSzSqZu6sNHxKqvL7/zDUs/pbp+CRN1PhieEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310279; c=relaxed/simple;
	bh=eIZMwz94SXNchV9CIz2BNTuvEAHotx8FG/pnszibmd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+bDOSbYpl2x7+PFcQ3LgAxa2HWk6IhzZ+8mZfvP8LhAHHcrNWhP93xrq7EyN1rD7w9R+uW7lUobSrFqcJL7Rzv3RYImVXxQwjbvnl40P0FkgzVjuPX+YkERksb3lZKch0Q7gKTkWlYUs5yUxtzNuEiW9K/IA1fCmIuXudoV0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsfcyClN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709310278; x=1740846278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eIZMwz94SXNchV9CIz2BNTuvEAHotx8FG/pnszibmd8=;
  b=gsfcyClNsyvfDIUj0udiK+uY+kr7csIxXogSOoZWIwX/Lf8rwNW/e04J
   5MvlyoSQBnciUnbUezwuyZJoSbL3wq+bV8pBm1ITsaOK+/rwsShWDK7gY
   xsmg9Re9A083t0FeL3hMJIdmFWmNnEGfeta31kHlE2ctddmL2RMGqPITZ
   wmS8jY35j8445bx8LZGuUxaJGt6ekDf4TfYKYFMs0t0Iao97JRU1nDH81
   AeyJS4sHxcL5fMyYZmZsPo+o9za/DnkjuJu04qYFVfATD8FGBDSDhpAxB
   VzY/2VWDxW7j8/nAM3xgbHXtDz7II8ChOcdRwmMzTsh0l3//URlT+4X/h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7673273"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7673273"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 08:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8139571"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by fmviesa007.fm.intel.com with ESMTP; 01 Mar 2024 08:24:30 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	xdp-hints@xdp-project.net
Subject: [PATCH iwl-next,v2 1/2] selftests/bpf: xdp_hw_metadata reduce sleep interval
Date: Sat,  2 Mar 2024 00:23:47 +0800
Message-Id: <20240301162348.898619-2-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301162348.898619-1-yoong.siang.song@intel.com>
References: <20240301162348.898619-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In current ping-pong design, xdp_hw_metadata will wait until the packet
transmition completely done, then only start to receive the next packet.

The current sleep interval is 10ms, which is unnecessary large. Typically,
a NIC does not need such a long time to transmit a packet. Furthermore,
during this 10ms sleep time, the app is unable to receive incoming packets.

Therefore, this commit reduce sleep interval to 10us, so that
xdp_hw_metadata able to support periodic packets with shorter interval.
10us * 500 = 5ms should be enough for packet transmission and status
retrival.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 878d68db0325..bdf5d8180067 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -480,7 +480,7 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 					for (int j = 0; j < 500; j++) {
 						if (complete_tx(xsk, clock_id))
 							break;
-						usleep(10*1000);
+						usleep(10);
 					}
 				}
 			}
-- 
2.34.1


