Return-Path: <linux-kselftest+bounces-42193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9416CB9A568
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BD4C4E89
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A023081B8;
	Wed, 24 Sep 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xcbeB/MI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4517BA6;
	Wed, 24 Sep 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725405; cv=none; b=f2HO1rDqRD0fO53Oqk8aV6gY6+nG5r0yYTC1Ix03QUmdoiDrQngJPpH86xyZr10IakIKZme4m+UIU3ti5dEHIXrDQorUxOHJWxUJ3gDvtwpcaPc8LC2vXr2ikdA6/h028GErXUacfugmURqKuh6vez0XqYpvXzmW5GwbVaAwG4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725405; c=relaxed/simple;
	bh=nqIIO7txybV7R91UDPW32xrfVvjRQAGIDMf2qgiDNzM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oWFR1FSI+2AneeycI39dl4NRGu+EP0eJ35b8ivxI1YOfcdyLU0ZGjWbTvIAOwBK25RUIlYiituyDv3bgx8YH5E2AKMJNi5APq4yR4ZFY0WcBLD14068fTjvgB6S1Qt8rI2unr5MJZibCuHJeDs0bDq5GqhMUaHDiD9LEtfoap0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xcbeB/MI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3E0284E40D42;
	Wed, 24 Sep 2025 14:50:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 00BD460634;
	Wed, 24 Sep 2025 14:50:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C441E102F18D8;
	Wed, 24 Sep 2025 16:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725398; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5Yy6cV7CI+4JraO3JP09oFw2D7jO5gkDGtxirbXHjaM=;
	b=xcbeB/MI+amkstuwxBY1vgM1i16KDyFZwzbh1A3A0wKjy+8lBJpjX0CHaQU9iD15Y2vmgQ
	4n/6aK/Bf4p8sviXKJS0i2D9qVvcXqTZt5pz0R0ZQYhlTmIhSSr6iCxUoLLovmdn9IqMEL
	ovYGLtEkC6vzLM4Bh2G60xL5iTBUhn8bzrq8KnN5OE0VrbFkUSrws4/JPTHhbO0tg2M7g1
	67ylyYBvWDtD0jRExy1B4qLJF/sGNG8D4KuZmVW0Uhh7FtEIp8gOwougR5nJfBQHqLRFtP
	8WJUOnOqK5AcPBeMMS8Uv9fFGe7/GIbH4sP7aOyuijXyd9sIa2xntSZ3WzjgYA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v4 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
Date: Wed, 24 Sep 2025 16:49:35 +0200
Message-Id: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8E1GgC/2XMQQ6CMBCF4auYrq1pZ1pLXXkP4wLKII1KCSUEQ
 7i7TVlodDl58/0LizR4iuy0W9hAk48+dOlQ+x1zbdndiPs63QwEaAGy4HO8c+EaK8gaXUvF0mc
 /UOPnXLmwqm94R/PIrmlpfRzD8Mr5SeY9l1BiLk2SC27QKAO2tFjZcxXC+PDdwYVnLkzwUVbAp
 iApadwRla41SP2v8FupTWFSjrAAQpSq+FHrur4B2SMApw4BAAA=
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

Some tests are flaky so they can't be integrated in the CI as they are.
I think that fixing their flakyness would require a significant amount of
work. So, as first step, I've excluded them from the list of tests
migrated to the CI (cf PATCH 14). If these tests get fixed at some
point, integrating them into the CI will be straightforward.

I noticed a small error on a function's return value while investigating
on the report's summary issue pointed out by Maciej in previous iteration,
the new PATCH 3 fixes it.

PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
tests available to test_progs.
PATCH 2 to 7 fix small issues in the current test
PATCH 8 to 13 handle all errors to release resources instead of calling
exit() when any error occurs.
PATCH 14 isolates some flaky tests
PATCH 15 integrate the non-flaky tests to the test_progs framework

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
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
      selftests/bpf: test_xsk: Isolate flaky tests
      selftests/bpf: test_xsk: Integrate test_xsk.c to test_progs framework

 tools/testing/selftests/bpf/Makefile              |   11 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2595 ++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/test_xsk.h |  294 +++
 tools/testing/selftests/bpf/prog_tests/xsk.c      |  146 ++
 tools/testing/selftests/bpf/xskxceiver.c          | 2696 +--------------------
 tools/testing/selftests/bpf/xskxceiver.h          |  156 --
 6 files changed, 3174 insertions(+), 2724 deletions(-)
---
base-commit: 1bd67e08d0f3fcb8cc69a73fb7aab9f048be4b8e
change-id: 20250218-xsk-0cf90e975d14

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


