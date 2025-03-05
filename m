Return-Path: <linux-kselftest+bounces-28344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26EFA50DA4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027BC1893686
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B080725A2C1;
	Wed,  5 Mar 2025 21:35:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D50257AF9;
	Wed,  5 Mar 2025 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210520; cv=none; b=DcSpauviVClv8GcCkOtj97LHMyp5OHPRHmWeMnXDInnQpHMk2w3lLF2en5F7eeN00iRGCj1ob5d2/A7hfS9rCnC7Q8+7wEMmvTg5VSKGK+2cOH4+zjYBT+Kpg573/ReMHNmDgxrEqI+M43t9T2i9Iu1eg3EQdIUMccmDNi8UqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210520; c=relaxed/simple;
	bh=ysJbOV8K+yOBK93YQxRBRFYQFpznMzwFl1VkpZNmKvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCeQ/mlOpwmRmuO2LW63W8mdJANVwfqPEAhHyzWyv1j8sO61JpwGfzzPnqOKxC3q6wxCHbjqdgddlDB2EGIgRNKhoUmdJHrlTAY3B0CC06jPCJzfG3DY8gTp7y+xzdCmRQDnXg0DjrZbH5wdFSvb+bJ7M22Wczmo0B9lsAd5bsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO2-000K1D-QC; Wed, 05 Mar 2025 22:34:43 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO1-000MHO-2g;
	Wed, 05 Mar 2025 22:34:42 +0100
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v5 0/6] XDP metadata support for tun driver
Date: Wed,  5 Mar 2025 21:34:32 +0000
Message-ID: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27568/Wed Mar  5 10:48:48 2025)

Hi all,

this v5 of the patch series is very similar to v4, but rebased onto the
bpf-next/net branch instead of bpf-next/master.
Because the commit c047e0e0e435 ("selftests/bpf: Optionally open a
dedicated namespace to run test in it") is not yet included in this branch,
I changed the xdp_context_tuntap test to manually create a namespace to run
the test in.

Not so successful pipeline: https://github.com/kernel-patches/bpf/actions/runs/13682405154

The CI pipeline failed because of veristat changes in seemingly unrelated
eBPF programs. I don't think this has to do with the changes from this
patch series, but if it does, please let me know what I may have to do
different to make the CI pass.

---

v5:
- rebase onto bpf-next/net
- resolve rebase conflicts
- change xdp_context_tuntap test to manually create and open a network
  namespace using netns_new

v4: https://lore.kernel.org/bpf/20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de/
- strip unrelated changes from the selftest patches
- extend commit message for "selftests/bpf: refactor xdp_context_functional
  test and bpf program"
- the NOARP flag was not effective to prevent other packets from
  interfering with the tests, add a filter to the XDP program instead
- run xdp_context_tuntap in a separate namespace to avoid conflicts with
  other tests

v3: https://lore.kernel.org/bpf/20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de/
- change the condition to handle xdp_buffs without metadata support, as
  suggested by Willem de Bruijn <willemb@google.com>
- add clarifying comment why that condition is needed
- set NOARP flag in selftests to ensure that the kernel does not send
  packets on the test interfaces that may interfere with the tests

v2: https://lore.kernel.org/bpf/20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de/
- submit against bpf-next subtree
- split commits and improved commit messages
- remove redundant metasize check and add clarifying comment instead
- use max() instead of ternary operator
- add selftest for metadata support in the tun driver

v1: https://lore.kernel.org/all/20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de/

Marcus Wichelmann (6):
  net: tun: enable XDP metadata support
  net: tun: enable transfer of XDP metadata to skb
  selftests/bpf: move open_tuntap to network helpers
  selftests/bpf: refactor xdp_context_functional test and bpf program
  selftests/bpf: add test for XDP metadata support in tun driver
  selftests/bpf: fix file descriptor assertion in open_tuntap helper

 drivers/net/tun.c                             |  28 +++-
 tools/testing/selftests/bpf/network_helpers.c |  28 ++++
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../selftests/bpf/prog_tests/lwt_helpers.h    |  29 ----
 .../bpf/prog_tests/xdp_context_test_run.c     | 145 +++++++++++++++++-
 .../selftests/bpf/progs/test_xdp_meta.c       |  53 +++++--
 6 files changed, 230 insertions(+), 56 deletions(-)

-- 
2.43.0


