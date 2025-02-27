Return-Path: <linux-kselftest+bounces-27767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D0A481B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8361188E3DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7FF238157;
	Thu, 27 Feb 2025 14:23:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F52356C3;
	Thu, 27 Feb 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666233; cv=none; b=cswQlfsuRTD3flMR7eS5wEB/cWDqMxVDFsQkl+ORXiyUAU/vxek3CbDPZxcgR45NwwCaLUxQ00gg2YMjNlE4IaBdNmLagvYm9EtsY8KfMoKKI6m9thpf4ckptwHI3NTDncFXL+hmkJWVluw1HuSc4Jl9U04eg8PCOetcy/44Yxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666233; c=relaxed/simple;
	bh=0IaIpNQPqlJpcNPqpuI5ilacR+4Qdg8rthFbmaUO0dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n14O3dnff5MwzlU5cZNWVPxU8hSMAvNpcZ5+BvsB3jZM6l7nnvkjInKyISpxvpMX8obinK4Vwe9NWWff3bZUyCCDLLkJGqktH4VmxhdkOTEgIWC/lrDRxveSZu0y6LuVQ8KMedG5c9eFPnUWv1BS5xSebkV7oTXXjLCuLs14bCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnenV-0005EQ-LE; Thu, 27 Feb 2025 15:23:33 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnenV-000B1d-2Q;
	Thu, 27 Feb 2025 15:23:33 +0100
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
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v4 0/6] XDP metadata support for tun driver
Date: Thu, 27 Feb 2025 14:23:24 +0000
Message-ID: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27562/Thu Feb 27 10:48:50 2025)

Hi all,

this series contains some improvements for the selftest patches. The other
patches remain unchanged. Please check the changelist below.

I have reverted the addition of the NOARP flag from the previous version,
as it was not effective and the CI was still failing occasionally because
of the race condition caused by foreign packets interfering with the veth
tests. This series contains an alternative solution by filtering all but
the test packets using the attached XDP program.

Successful pipeline:
https://github.com/kernel-patches/bpf/actions/runs/13552017584

---

v4:
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
 .../bpf/prog_tests/xdp_context_test_run.c     | 138 +++++++++++++++++-
 .../selftests/bpf/progs/test_xdp_meta.c       |  53 +++++--
 6 files changed, 223 insertions(+), 56 deletions(-)

-- 
2.43.0


