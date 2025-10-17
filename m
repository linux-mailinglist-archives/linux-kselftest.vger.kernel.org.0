Return-Path: <linux-kselftest+bounces-43379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88ABE930B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7D11AA165B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4631236435;
	Fri, 17 Oct 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CxA/B1gW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511E339717;
	Fri, 17 Oct 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711369; cv=none; b=lqJ7UWRImI0j1kkvHs7FGjqlZIrGbWyEMvE2Tu801i4wMhZ0DHXJa9jqkh3oBv/ttBO17Dk5vQujaCHJRb01IzSaM7SFjBib0DGqlCcqzwpKwxM8TYMXCVPiIVc5Ve290VfyW+0LvFJJPFgnv5DlwZZhxbg89xZfLJ+dzAoVnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711369; c=relaxed/simple;
	bh=cMoPyBzHOOaYdy9c7FZ3cUwc3wSS3fmKj9pGVJ5s8mY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bxlRB1ahCNNI9Rdy/SFBTxlhkKTM+Nb6uUAmizdmL42T5tsaSLjihi7VKz1266PkkYxoLJXCiwKiElAw7NZCwVdJjCsuC+fEovZFYU6SDOQhXDQVhT9tqp9BMcgrNOAs9Gi1FS9FQVQTL3A8Trh4MMkMpTC4dKXvoRNeDf03FyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CxA/B1gW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0D5611A1482;
	Fri, 17 Oct 2025 14:29:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D365F606DB;
	Fri, 17 Oct 2025 14:29:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDE5D102F235A;
	Fri, 17 Oct 2025 16:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760711364; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=znCzD/kYw9OFiZjrwKyfivodrcDqa/97QljZggg0Y8o=;
	b=CxA/B1gWazID7ZBY4UgZ0MfMTAzqqK24wsPeX890YvWid3Y+ya50Sav9IGG40GIoCRjap+
	/pMMBp4NCEI3/yhyb2QeTkHrkYG1LtwLTcj6qr8ydePmV3SSu7JWR3YvgSYepQuAvgN4C/
	RqyJT6x2ngr07AJwXHrTxQ/jT9a3udJiJrj3uqXg/8cjl+4u/4X0A5Ifywm/RXvphYiscT
	9pMw5S7Hm9F93jH2jgrGjJIsUn4dzWon1woyntqWRzT02Oiu9EygCH4qyR/ahWEFlQGfZX
	Bq5kfWrJFdkDndBvoYvbEpYy1lyasqSNwnLFZjzJtsk17PilXEpKgKmdisNKwg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next 0/5] selftests/bpf: convert test_tc_tunnel.sh to
 test_progs
Date: Fri, 17 Oct 2025 16:29:00 +0200
Message-Id: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKxS8mgC/x3MSwqAMAwA0atI1hZM/VC8iohoTTUgUdoqgnh3i
 8sHwzwQyDMFaLMHPF0ceJcEzDOw6ygLKZ6TQRe6LgyiinaIpwhtyjZYVroxpUMDqT88Ob7/Vwf
 T4ZTQHaF/3w9oO2VjZQAAAA==
X-Change-ID: 20250811-tc_tunnel-c61342683f18
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this series aims to convert another test to the test_progs framework to
make sure that it is executed in CI for series sent on the mailing list.
test_tc_tunnel.sh tests a variety of tunnels based on BPF: packets are
encapsulated by a BPF program on the client egress. We then check that
those packets can be decapsulated on server ingress side, either thanks
to kernel-based or BPF-based decapsulation. Those tests are run thanks
to two veths in two dedicated namespaces.

- patches 1 to 3 are preparatory patches
- patch 4 introduce tc_tunnel test into test_progs
- patch 5 gets rid of the test_tc_tunnel.sh script

The new test has been executed both in some x86 local qemu machine, as
well as in CI:

  # ./test_progs -a tc_tunnel
  #454/1   tc_tunnel/ipip_none:OK
  #454/2   tc_tunnel/ipip6_none:OK
  #454/3   tc_tunnel/ip6tnl_none:OK
  #454/4   tc_tunnel/sit_none:OK
  #454/5   tc_tunnel/vxlan_eth:OK
  #454/6   tc_tunnel/ip6vxlan_eth:OK
  #454/7   tc_tunnel/gre_none:OK
  #454/8   tc_tunnel/gre_eth:OK
  #454/9   tc_tunnel/gre_mpls:OK
  #454/10  tc_tunnel/ip6gre_none:OK
  #454/11  tc_tunnel/ip6gre_eth:OK
  #454/12  tc_tunnel/ip6gre_mpls:OK
  #454/13  tc_tunnel/udp_none:OK
  #454/14  tc_tunnel/udp_eth:OK
  #454/15  tc_tunnel/udp_mpls:OK
  #454/16  tc_tunnel/ip6udp_none:OK
  #454/17  tc_tunnel/ip6udp_eth:OK
  #454/18  tc_tunnel/ip6udp_mpls:OK
  #454     tc_tunnel:OK
  Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (5):
      testing/selftests: rename tc_helpers.h to tcx_helpers.h
      selftests/bpf: add tc helpers
      selftests/bpf: make test_tc_tunnel.bpf.c compatible with big endian platforms
      selftests/bpf: integrate test_tc_tunnel.sh tests into test_progs
      selftests/bpf: remove test_tc_tunnel.sh

 tools/testing/selftests/bpf/Makefile               |   2 +-
 tools/testing/selftests/bpf/prog_tests/tc_links.c  |  46 +-
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c |  22 +-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |  40 +-
 .../bpf/prog_tests/{tc_helpers.h => tcx_helpers.h} |   6 +-
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 684 +++++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |  80 +--
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |  99 ++-
 tools/testing/selftests/bpf/tc_helpers.c           |  87 +++
 tools/testing/selftests/bpf/tc_helpers.h           |   9 +
 tools/testing/selftests/bpf/test_tc_tunnel.sh      | 320 ----------
 11 files changed, 884 insertions(+), 511 deletions(-)
---
base-commit: 22267893b8c7f2773896e814800bbe693f206e0c
change-id: 20250811-tc_tunnel-c61342683f18

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


