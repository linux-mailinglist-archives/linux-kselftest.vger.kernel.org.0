Return-Path: <linux-kselftest+bounces-44280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C3C1B043
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 14:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA07A34E9F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7662C0270;
	Wed, 29 Oct 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I7Uy3BYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD62C08AC;
	Wed, 29 Oct 2025 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745956; cv=none; b=GERQDCXGu+LzADEpAXjSdvIF1GDsh02KTX8zM64hQHnlg8PFal7tuppNebrXaAwIRhNwdpnMDIjUSfBn5ABftgA99KrYzk5XYAU2kzx6ydCpSpBBYWK3ci74gjgc1ObfykkfIa9iCjl+h9kLehmmoFtWIcbEn465xS2KlMvMT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745956; c=relaxed/simple;
	bh=rW3784dFwWK1ESSqmaBPg+kT0mzp+FqU2lvt8I3dmu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t2xfanb/gYIS4cGbu0hLYa37OKNHNinACbPBjsD272g03icRfpNUeLmMYIrs12SoZMOvzE/Tw0/zyNZUeFUhlionbdQnht22oUuGYZk7TXYpqO/t55ac57w6jOyDOglpLbTMmZiKvQThelAVI3WLHBPoYbWthumMLRbjFZPBVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I7Uy3BYV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8727C1A1748;
	Wed, 29 Oct 2025 13:52:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5778F606E8;
	Wed, 29 Oct 2025 13:52:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A263117F80EE;
	Wed, 29 Oct 2025 14:52:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761745951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=rhH66cXrlh+mBW9/j7oTqaX5K/p8LcUvQAyFmm6+5Q8=;
	b=I7Uy3BYV/Ou2rYMnDh1/hbLmhYDx1/ph/I5ohpr9w/G0N3i9SxBnYKHMBHwx5cfopu9avr
	Xq3vg2TbT0osKF5zTEKv82/yopurT8c8NTcGNl/ijT9MJskiz9eOawGpq0Pq4yFzU9rI+v
	95y+tRGSQQOkhp8Z6SgnFCzD7LrS2aZZ9YRuIQnHyCM439BGEAIvP6n3Paw1kNDrRgwBuX
	Dx6a91hs0BOhslhMx3KBN7LLeWLo8NH/9Yykcb0tqO5FFOsRnHdwcLiUeLNIZsMtOYwDmO
	+myXpz7eDahFuhdLvKc/qx6zu76DMar/M9ciSClSYcpff5ALg6ZgMPOBv3tj8Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v6 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
Date: Wed, 29 Oct 2025 14:52:21 +0100
Message-Id: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABUcAmkC/23NwU7DMAyA4VeZciYoseOk2Yn3QByW1GUR0ExNV
 RVNfXeiFMHEOFr29/sqCk+JizgermLiJZWUxzrYh4OI59P4yjL1dRaggBToTq7lTao4eMXeUa+
 NqJeXiYe0tsqzCJdBjrzO4qVuzqnMefps+UW3fSuhxlZatFTSoTMO/Mlj8E8h5/k9jY8xf7TCA
 r/KK9gVVKVdtGioJ9B0r/BWmV1hVZGxA0bUpvtHmRsF38pUBYrJEbrQOXuv6Edppe2uqCprIXr
 i0Cn159e2bV+O8hcnegEAAA==
X-Change-ID: 20250218-xsk-0cf90e975d14
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
are defined in xksxceiver.c. Since this script is used to test real
hardware, the goal here is to leave it as it is, and only integrate the
tests that run on veth peers into the test_progs framework.

I've looked into what could improve the speed in the CI:
- some tests are skipped when run on veth peers in a VM (because they
  rely on huge page allocation or HW rings). This skipping logic still
  takes some time and can be easily avoided.
- the TEARDOWN test is quite long (several seconds on its own) because
  it runs the same test 10 times in a row to ensure the teardown process
  works properly

With theses tests fully skipped in the CI and the veth setup done only
once for each mode (DRV / SKB), the execution time is reduced to about 5
seconds on my setup.
```
$ tools/testing/selftests/bpf/vmtest.sh -d $HOME/ebpf/output-regular/ -- time ./test_progs -t xsk
[...]
real    0m 5.04s
user    0m 0.38s
sys     0m 1.61s
```

It still feels a bit long, but there are 24 tests run in both DRV and
SKB modes which means around 100ms for each one. I'm not sure I can make
it much faster without randomizing the tests so that not all of them run
in every CI execution.

PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
tests available to test_progs.
PATCH 2 to 7 fix small issues in the current test
PATCH 8 to 13 handle all errors to release resources instead of calling
exit() when any error occurs.
PATCH 14 isolates the tests that won't fit in the CI
PATCH 15 integrates the CI tests to the test_progs framework

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Changes in v6:
- Setup veth peer once for each mode instead of once for each substest
- Rename the 'flaky' table 'skip-ci' table and move the automatically
  skipped and the longest tests into it
- Link to v5: https://lore.kernel.org/r/20251016-xsk-v5-0-662c95eb8005@bootlin.com

Changes in v5:
- Rebase on latest bpf-next_base
- Move XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF to the flaky table
- Add Maciej's reviewed-by
- Link to v4: https://lore.kernel.org/r/20250924-xsk-v4-0-20e57537b876@bootlin.com

Changes in v4:
- Fix test_xsk.sh's summary report.
- Merge PATCH 11 & 12 together, otherwise PATCH 11 fails to build.
- Split old PATCH 3 in two patches. The first one fixes
  testapp_stats_rx_dropped(), the second one fixes
  testapp_xdp_shared_umem(). The unecessary frees (in
  testapp_stats_rx_full() and testapp_stats_fill_empty() are removed)
- Link to v3: https://lore.kernel.org/r/20250904-xsk-v3-0-ce382e331485@bootlin.com

Changes in v3:
- Rebase on latest bpf-next_base to integrate commit c9110e6f7237 ("selftests/bpf:
Fix count write in testapp_xdp_metadata_copy()").
- Move XDP_METADATA_COPY_* tests from flaky-tests to nominal tests
- Link to v2: https://lore.kernel.org/r/20250902-xsk-v2-0-17c6345d5215@bootlin.com

Changes in v2:
- Rebase on the latest bpf-next_base and integrate the newly added tests
  to the work (adjust_tail* and tx_queue_consumer tests)
- Re-order patches to split xkxceiver sooner.
- Fix the bug reported by Maciej.
- Fix verbose mode in test_xsk.sh by keeping kselftest (remove PATCH 1,
  7 and 8)
- Link to v1: https://lore.kernel.org/r/20250313-xsk-v1-0-7374729a93b9@bootlin.com

---
Bastien Curutchet (eBPF Foundation) (15):
      selftests/bpf: test_xsk: Split xskxceiver
      selftests/bpf: test_xsk: Initialize bitmap before use
      selftests/bpf: test_xsk: Fix __testapp_validate_traffic()'s return value
      selftests/bpf: test_xsk: fix memory leak in testapp_stats_rx_dropped()
      selftests/bpf: test_xsk: fix memory leak in testapp_xdp_shared_umem()
      selftests/bpf: test_xsk: Wrap test clean-up in functions
      selftests/bpf: test_xsk: Release resources when swap fails
      selftests/bpf: test_xsk: Add return value to init_iface()
      selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
      selftests/bpf: test_xsk: Don't exit immediately when gettimeofday fails
      selftests/bpf: test_xsk: Don't exit immediately when workers fail
      selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
      selftests/bpf: test_xsk: Don't exit immediately on allocation failures
      selftests/bpf: test_xsk: Isolate non-CI tests
      selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework

 tools/testing/selftests/bpf/Makefile              |   11 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2595 ++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/test_xsk.h |  298 +++
 tools/testing/selftests/bpf/prog_tests/xsk.c      |  151 ++
 tools/testing/selftests/bpf/xskxceiver.c          | 2696 +--------------------
 tools/testing/selftests/bpf/xskxceiver.h          |  156 --
 6 files changed, 3183 insertions(+), 2724 deletions(-)
---
base-commit: 4481a8590725400f37d3015f0ee0d53a2cdc1bd6
change-id: 20250218-xsk-0cf90e975d14

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


