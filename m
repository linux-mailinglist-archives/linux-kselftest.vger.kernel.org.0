Return-Path: <linux-kselftest+bounces-22049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3B9C94AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B11328311B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08F31AF0AB;
	Thu, 14 Nov 2024 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RMedzhgu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBD76026;
	Thu, 14 Nov 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621075; cv=none; b=hC3PTjFM4W78uZq867umISczP4EKQQlMtLxXWbnYM3vMyOv3VVZhw9216L4WfM4WbGXOY3VajHjxCEC1kF4dX6y2UHOTIO+e+0fWj8MkyTr4XmMwRJgRBxWyoQM6gRmtVgWHOL1wtSYYy1uYbL+VopzTx5kUTbKjXoml0J6eEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621075; c=relaxed/simple;
	bh=WjZXsL/Ggv5UxmzL0W2lHjr1qDI30J7jiFurXL1yZN4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lB3oMVBSl1u27WxJBgWY4ISbNiYn2UgSpIyJq/9C+oi1lyP/1XJglkmVkUQJjKqbXvrHgLqh7eeShoGlXLwIZOzS//tSjFtef0F7XyivPgBeEHgXu7VL6Kf+myrCcE4eywDRtBK6RpPaxEoljvzhSlqd3kTtBM5TGXd6SYHrzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RMedzhgu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D6A520003;
	Thu, 14 Nov 2024 21:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n3bfEiuXzWiyxNpW5BbZa2NuPMpbT/vYsRPGYQ4Ljww=;
	b=RMedzhgu3sJZurlFt3wTLbZwSnVLYQLfXU1TtNlvI3EPOzi6cUGJQe1vaNUvJXmeZT65Bw
	22kGKeMLw2ZOC+PBhzMwrB+pgIsLONZSoUdTd4MJaHGUd/kl0K/XCHFundwPNnOrqqTq4T
	YgzTBGhsZaJNApguYsSLZ+0Uh1s9+mADWj5K0lj4a4QHw33ZjC8a1n4mSWR3TLGXtMrW0r
	jW2MPdAe79+zeP5+fQNR7D4/UCbyVAVSg4PJWWqbEO5Y4z+jzJysnqWawRDMOi5IhRjs+K
	r7Mz5niUKboLJ//BXEvts+YofQwKF5bxZBvWhQKYBLa4oHBPyWNPX/I1uG53hw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 00/13] selftests/bpf: migrate
 test_flow_dissector.sh to test_progs
Date: Thu, 14 Nov 2024 22:50:31 +0100
Message-Id: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKdwNmcC/12NQQrCMBBFryKzNpJJq6WuvIcUsZOJHahJSUqtl
 N7dkKXLx+e9v0HiKJzgetgg8iJJgs9gjgeg4elfrMRmBqNNjRpb5cbweVhJiWkOUVXca9KNI7x
 UkKUpspO1BO/QT055Xmfo8jJIysK3PC1Y9hJFrP6jCyqtTEO1dfrcGku3PoR5FH+i8IZu3/cfu
 Z1tlbgAAAA=
X-Change-ID: 20241019-flow_dissector-3eb0c07fc163
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this new series aims to migrate test_flow_dissector.sh into test_progs.
There are 2 "main" parts in test_flow_dissector.sh:
- a set of tests checking flow_dissector programs attachment to either
  root namespace or non-root namespace
- dissection test

The first set is integrated in flow_dissector.c, which already contains
some existing tests for flow_dissector programs. This series uses the
opportunity to update a bit this file (use new assert, re-split tests,
etc)
The second part is migrated into a new file under test_progs,
flow_dissector_classification.c. It uses the same eBPF programs as
flow_dissector.c, but the difference is rather about how those program
are executed:
- flow_dissector.c manually runs programs with BPF_PROG_RUN
- flow_dissector_classification.c sends real packets to be dissected, and
  so it also executes kernel code related to eBPF flow dissector (eg:
__skb_flow_bpf_to_target)

---
Changes in v2:
- allow tests to run in parallel
- move some generic helpers to network_helpers.h
- define proper function for ASSERT_MEMEQ
- fetch acked-by tags
- Link to v1: https://lore.kernel.org/r/20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (13):
      selftests/bpf: add a macro to compare raw memory
      selftests/bpf: use ASSERT_MEMEQ to compare bpf flow keys
      selftests/bpf: replace CHECK calls with ASSERT macros in flow_dissector test
      selftests/bpf: re-split main function into dedicated tests
      selftests/bpf: expose all subtests from flow_dissector
      selftests/bpf: add gre packets testing to flow_dissector
      selftests/bpf: migrate flow_dissector namespace exclusivity test
      selftests/bpf: Enable generic tc actions in selftests config
      selftests/bpf: move ip checksum helper to network helpers
      selftests/bpf: rename pseudo headers checksum computation
      selftests/bpf: add network helpers to generate udp checksums
      selftests/bpf: migrate bpf flow dissectors tests to test_progs
      selftests/bpf: remove test_flow_dissector.sh

 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   3 +-
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/network_helpers.h      |  64 +-
 .../selftests/bpf/prog_tests/flow_dissector.c      | 323 +++++++--
 .../bpf/prog_tests/flow_dissector_classification.c | 807 +++++++++++++++++++++
 .../selftests/bpf/prog_tests/xdp_metadata.c        |  24 +-
 tools/testing/selftests/bpf/test_flow_dissector.c  | 780 --------------------
 tools/testing/selftests/bpf/test_flow_dissector.sh | 178 -----
 tools/testing/selftests/bpf/test_progs.c           |  15 +
 tools/testing/selftests/bpf/test_progs.h           |  15 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  12 +-
 12 files changed, 1153 insertions(+), 1070 deletions(-)
---
base-commit: 9e71d50d3befb93a6394b0979f8ebd0dc9bd8d0f
change-id: 20241019-flow_dissector-3eb0c07fc163

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


