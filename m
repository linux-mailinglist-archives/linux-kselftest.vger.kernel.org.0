Return-Path: <linux-kselftest+bounces-5739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB086E56A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE131F2600D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE673168;
	Fri,  1 Mar 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIIDja/+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F773164;
	Fri,  1 Mar 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310263; cv=none; b=nH0uCIeB2gADUwEcvw66eFc1L6ChdKlf7VIwLyFvUQZMxw+FX9v8GdQ6wOJP5xttzFbiZ4KY7Oo6un4Ig1l3uzWj+cmoQ6IkWm1Yb4pFodFIq8Svgv0Ea4qQIpUi/6+BqNzlSarhuTzrtmEBWWu/lgUgKOaVWhVXFArrbV+pXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310263; c=relaxed/simple;
	bh=PNkeetFswFigbWxmUl6UYDRRkyJ69Qs5VVQ+Oc2ktWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSb6aYGdHa2zatfm0+tFurWXUxOBUmNzL5gqxqKYGOyNosfX65NhPbWeKcxL9D9q1sy3F9PbadWfaex0PbrBMSRQGqN3tK6bfqTeODMyxuB5I3f3c+fPnuOGbZKwGrXav2gUuiI/wFjh8xh/u3tgpX1jtO6kSKKUAbl5XawXPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIIDja/+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709310259; x=1740846259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PNkeetFswFigbWxmUl6UYDRRkyJ69Qs5VVQ+Oc2ktWc=;
  b=YIIDja/+ndeq38tuTuQWsMCfF3EQr2OmPL35pOcNEw+ed8nd8xLcv3HI
   t1EeSVgmPzKytYFNZV6XLbtffT4SJxKBAwsSQ1EHMm8r72A2nOkn7mrLs
   Qs5G40hAZWYBHed1gu9Q9zEnPRUaBVWZP3J5nWvuDNxRw4WMpYbSPxELL
   4n7YImbI3MTBV3m1Q1B1zFWYfJG02Q96GLDpPZaknLSL6VRMeQUIxigmw
   JsICDk0AevoWEG5K0uCRylYhjiO2N08qexWTQYmMsEy37NJuEfYwHsVAV
   wvv7vuypkp5DZAZDRFtRrlAj+qey39EHJZBzkAohdrQE6Sm6iW1wona61
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7673225"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7673225"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 08:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8139509"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by fmviesa007.fm.intel.com with ESMTP; 01 Mar 2024 08:24:11 -0800
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
Subject: [PATCH iwl-next,v2 0/2] XDP Tx Hardware Timestamp for igc driver
Date: Sat,  2 Mar 2024 00:23:46 +0800
Message-Id: <20240301162348.898619-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implemented XDP transmit hardware timestamp metadata for igc driver.

This patchset is tested with tools/testing/selftests/bpf/xdp_hw_metadata
on Intel ADL-S platform. Below are the test steps and results.

Test Step 1: Run xdp_hw_metadata app
 sudo ./xdp_hw_metadata <iface> > /dev/shm/result.log

Test Step 2: Enable Tx hardware timestamp
 sudo hwstamp_ctl -i <iface> -t 1 -r 1

Test Step 3: Run ptp4l and phc2sys for time synchronization

Test Step 4: Generate 1000 UDP packets with 1ms interval
 sudo trafgen --dev <iface> '{eth(da=<mac addr>), udp(dp=9091)}' -t 1ms -n 1000

Result of last 3 packets:
poll: 1 (0) skip=50 fail=0 redir=998
xsk_ring_cons__peek: 1
0x55d7e76a02d0: rx_desc[997]->addr=96110 addr=96110 comp_addr=96110 EoP
rx_hash: 0x11A51182 with RSS type:0x1
HW RX-time:   1677795020447895823 (sec:1677795020.4479) delta to User RX-time sec:0.0000 (16.309 usec)
XDP RX-time:   1677795020447906552 (sec:1677795020.4479) delta to User RX-time sec:0.0000 (5.580 usec)
No rx_vlan_tci or rx_vlan_proto, err=-95
0x55d7e76a02d0: ping-pong with csum=ab19 (want 315b) csum_start=34 csum_offset=6
0x55d7e76a02d0: complete tx idx=997 addr=65010
HW TX-complete-time:   1677795020447961519 (sec:1677795020.4480) delta to User TX-complete-time sec:0.0001 (79.979 usec)
XDP RX-time:   1677795020447906552 (sec:1677795020.4479) delta to User TX-complete-time sec:0.0001 (134.946 usec)
HW RX-time:   1677795020447895823 (sec:1677795020.4479) delta to HW TX-complete-time sec:0.0001 (65.696 usec)
0x55d7e76a02d0: complete rx idx=1125 addr=96110

poll: 1 (0) skip=50 fail=0 redir=999
xsk_ring_cons__peek: 1
0x55d7e76a02d0: rx_desc[998]->addr=98110 addr=98110 comp_addr=98110 EoP
rx_hash: 0x11A51182 with RSS type:0x1
HW RX-time:   1677795020448904440 (sec:1677795020.4489) delta to User RX-time sec:0.0000 (15.920 usec)
XDP RX-time:   1677795020448915139 (sec:1677795020.4489) delta to User RX-time sec:0.0000 (5.221 usec)
No rx_vlan_tci or rx_vlan_proto, err=-95
0x55d7e76a02d0: ping-pong with csum=ab19 (want 315b) csum_start=34 csum_offset=6
0x55d7e76a02d0: complete tx idx=998 addr=66010
HW TX-complete-time:   1677795020448969442 (sec:1677795020.4490) delta to User TX-complete-time sec:0.0001 (80.163 usec)
XDP RX-time:   1677795020448915139 (sec:1677795020.4489) delta to User TX-complete-time sec:0.0001 (134.466 usec)
HW RX-time:   1677795020448904440 (sec:1677795020.4489) delta to HW TX-complete-time sec:0.0001 (65.002 usec)
0x55d7e76a02d0: complete rx idx=1126 addr=98110

poll: 1 (0) skip=50 fail=0 redir=1000
xsk_ring_cons__peek: 1
0x55d7e76a02d0: rx_desc[999]->addr=99110 addr=99110 comp_addr=99110 EoP
rx_hash: 0x11A51182 with RSS type:0x1
HW RX-time:   1677795020449912415 (sec:1677795020.4499) delta to User RX-time sec:0.0000 (16.441 usec)
XDP RX-time:   1677795020449923362 (sec:1677795020.4499) delta to User RX-time sec:0.0000 (5.494 usec)
No rx_vlan_tci or rx_vlan_proto, err=-95
0x55d7e76a02d0: ping-pong with csum=ab19 (want 315b) csum_start=34 csum_offset=6
0x55d7e76a02d0: complete tx idx=999 addr=67010
HW TX-complete-time:   1677795020449977468 (sec:1677795020.4500) delta to User TX-complete-time sec:0.0001 (81.036 usec)
XDP RX-time:   1677795020449923362 (sec:1677795020.4499) delta to User TX-complete-time sec:0.0001 (135.142 usec)
HW RX-time:   1677795020449912415 (sec:1677795020.4499) delta to HW TX-complete-time sec:0.0001 (65.053 usec)
0x55d7e76a02d0: complete rx idx=1127 addr=99110

Besides, this patchset is tested with iperf3 to check the impact of holding tx completion.
Based on results below, the impact is not observable.

Result of iperf3 without trafgen command in step 4:
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-100.00 sec  27.4 GBytes  2.35 Gbits/sec    0             sender
[  5]   0.00-100.04 sec  27.4 GBytes  2.35 Gbits/sec                  receiver

Result of iperf3 running parallel with trafgen command in step 4:
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-100.00 sec  27.4 GBytes  2.35 Gbits/sec    0             sender
[  5]   0.00-100.04 sec  27.4 GBytes  2.35 Gbits/sec                  receiver

V1: https://patchwork.kernel.org/project/netdevbpf/patch/20231215162158.951925-1-yoong.siang.song@intel.com/

changelog:
V1 -> V2
- In struct igc_tx_timestamp_request, keep a pointer to igc_tx_buffer,
  instead of pointing xsk_pending_ts (Vinicius).
- In struct igc_tx_timestamp_request, introduce buffer_type to indicate
  whether skb or igc_tx_buffer pointer should be use (Vinicius).
- In struct igc_metadata_request, remove igc_adapter pointer (Vinicius).
- When request tx hwts, copy the value of cmd_type, instead of using
  pointer (Vinicius).
- For boolean variable, use true and false, instead of 1 and 0 (Vinicius).
- In igc_xsk_request_timestamp(), make an early return if none of the 4 ts
  registers is available (Vinicius).
- Create helper functions to clear tx buffer and skb for tstamp (John).
- Perform throughput test with mix traffic (Vinicius & John).

Song Yoong Siang (2):
  selftests/bpf: xdp_hw_metadata reduce sleep interval
  igc: Add Tx hardware timestamp request for AF_XDP zero-copy packet

 drivers/net/ethernet/intel/igc/igc.h          |  71 +++++++-----
 drivers/net/ethernet/intel/igc/igc_main.c     | 108 +++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_ptp.c      |  40 +++++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c |   2 +-
 4 files changed, 180 insertions(+), 41 deletions(-)

-- 
2.34.1


