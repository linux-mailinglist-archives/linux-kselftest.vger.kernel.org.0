Return-Path: <linux-kselftest+bounces-5797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E0D86F408
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 09:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CC91F21CE3
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAE79E1;
	Sun,  3 Mar 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YV/uARH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9BAB669;
	Sun,  3 Mar 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709454781; cv=none; b=E03YZpTOVyNG1/EeahePB+i8rjxxoMe9UMjwEpkMSrmuZe/5YYFYViKYycaxuyPC5J/tmus8QVUpo6EksOxfb4pclnhw3pJSgscWZjstfbYV043eLD8iAADY/rcItYK2qxrhIRUr7HBrCVyRjXkW7p6+BbzX6ipiFeMxvislbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709454781; c=relaxed/simple;
	bh=a9Icqs4XaEB3VNC9uusOctcAw+EqQqaKssugc4WBFfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hsMDPjp0YyM9qcY+YzR6A7yh/0KEH65ha+AHI1Rqwr7TldcVESZjOfsnSaNYjnXNRNkPZnl3YcI6SEA3uAWbeFilSHpwKIy8LwaDBQI1Tf1XdGmlC35Rr/otVr4CkPKHRWllYJDdO8r7UdWWF+aW3GaYkZVtIWqarWl7ODFeYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YV/uARH0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709454781; x=1740990781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a9Icqs4XaEB3VNC9uusOctcAw+EqQqaKssugc4WBFfg=;
  b=YV/uARH0MWswXqyHXzA7UOL046Ds+cx/OmnpjskvrvXfWKyMWtKGGyof
   PZBA0Vr3lPoAm482fV4fQlSFhjRTW3+YR/eRU+Khi7K91ZTEfR/VtQaBX
   s3zoulglSrVpxcvKyb/PqbWgk7jiIsqBrac27TfWDNLidXM9smy/LuHqo
   yu98JNK++vp6rT/wlrx8tDc0+NRosGmKPl1zBIK7vpQ1Kfsz9IOkJ+0R3
   BvZmrpiy1+Hh/ev2NuGFOgfrVIkbiK26rZVr6MM7bZcsv6AQp9quAxKNv
   ID7u0qI4j1x8tFKq86U6j/AhCIXnJvw0yqSDoA/PGKV4prE/+MarZxl1i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="7769300"
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="7769300"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 00:33:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="13357189"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orviesa005.jf.intel.com with ESMTP; 03 Mar 2024 00:32:51 -0800
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
Subject: [PATCH iwl-next,v3 1/2] selftests/bpf: xdp_hw_metadata reduce sleep interval
Date: Sun,  3 Mar 2024 16:32:24 +0800
Message-Id: <20240303083225.1184165-2-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240303083225.1184165-1-yoong.siang.song@intel.com>
References: <20240303083225.1184165-1-yoong.siang.song@intel.com>
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
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
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


