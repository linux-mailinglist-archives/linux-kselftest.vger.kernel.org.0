Return-Path: <linux-kselftest+bounces-27356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8435BA42661
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 16:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD9D1892AC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6288424EF7C;
	Mon, 24 Feb 2025 15:29:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A823BCED;
	Mon, 24 Feb 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410984; cv=none; b=XiGeOFibbbGxxTp0A5hMsthwwQQtxOY0SeUKztHv4+JX9nRFDCIRQytTEJnZ0Nskf65dbeS/ciwQOUJEHK2cfxwwW1oDuy33PSjXeSxJAo3E3rppg+jiX39AtgRNFm5YWNaFvfjtZ9ccu/PqrqKR3/CEZeCQwK9tRXtlrHtG4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410984; c=relaxed/simple;
	bh=EEKXb2X93vFkM9nakFVbWhilY+DabOqF5cOX3onCBAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KaK3H3KTZ2BaZvIQ8CQValmmCXFuKHFNIncRc0QZePfBuM6i7hKgU5EsqwLtBiU+Bt7Qauwh+pAzNns+5DwWttpZtSAS7PFo0vVpQTG4vd3OBBVXURa7IemC2LSMpizK68p5tiRRzrjYRP6NWQ9hRpIu7y+ZoKy6xpppauzg7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tmaOQ-000A29-JS; Mon, 24 Feb 2025 16:29:14 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tmaOQ-0005Hj-0v;
	Mon, 24 Feb 2025 16:29:14 +0100
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
	marcus.wichelmann@hetzner-cloud.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf-next v3 0/6] XDP metadata support for tun driver
Date: Mon, 24 Feb 2025 15:29:03 +0000
Message-ID: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27559/Mon Feb 24 10:44:14 2025)

Hi,

thank you for your reviw. As promised, here is V3 of this patch series.

I noticed that the updated selftests were flaky sometimes due to the kernel
networking stack sending IPv6 multicast listener reports on the created
test interfaces.
This can be seen here:
https://github.com/kernel-patches/bpf/actions/runs/13449071153/job/37580497963

Setting the NOARP flag on the interfaces should fix this race condition.

Successful pipeline:
https://github.com/kernel-patches/bpf/actions/runs/13500667544

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>

---

v3:
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

 drivers/net/tun.c                             |  28 ++-
 tools/testing/selftests/bpf/network_helpers.c |  28 +++
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../selftests/bpf/prog_tests/lwt_helpers.h    |  29 ----
 .../bpf/prog_tests/xdp_context_test_run.c     | 163 ++++++++++++++++--
 .../selftests/bpf/progs/test_xdp_meta.c       |  56 +++---
 6 files changed, 230 insertions(+), 77 deletions(-)

-- 
2.43.0


