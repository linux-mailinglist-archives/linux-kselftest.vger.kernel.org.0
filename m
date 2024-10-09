Return-Path: <linux-kselftest+bounces-19329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139A09966B9
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858D3B29192
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2924218EFE0;
	Wed,  9 Oct 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fOIh2jjA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A017CA0B;
	Wed,  9 Oct 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468746; cv=none; b=upbfuRh5w8fozviX9du1zCg46Ktnr5SwxlqvD04Mz8dEplxKqPAbx5WSV+TKOrW6odLAcxAy3ojT9TKBMWozM7R85d+LBvuZRLusmUntr/Ci4sKheuNhs5WY8SCrND5n4ZmCy7vwW8SyX8E6AkQYFNuD1nFQqZx88hu0jYdRPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468746; c=relaxed/simple;
	bh=npGKvyeioLE06tBNL1YmPaUQnt8E9+OXJkchpa69dcA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EbBpDgMxIfI3Zsip1B0tUXrWUsCiMUKzj1fxlQxnMzQSYGqkv+5ytJh62eg0mRDvNaORKwxEwmfNX7gSEB/dxGFHuqP8QVB8saz3FkWyTTfB+syHUgX1GQUQwO8o+DYy9SqoBxIkP9cc/mTItblz1a1VWJS5XjgrljZMpTLigJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fOIh2jjA; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08283FF80A;
	Wed,  9 Oct 2024 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728468735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=au3WNM1NuptJfk9wL4AyL68aOJt4+58bPzDihYVGsZU=;
	b=fOIh2jjAxjyb8LuImtILl/w8+ctcXz0lqYq+Ode2HpZ10vzjj/aQwxT18H+QesHfEXwHy9
	86QCpwBvLkmhidUMszST3qOS1Y4dU0TFBZzzA2tyfA/O3ivNXiVgjVmsDywRUaA3ljJNI1
	5DSigRg9DF9oan+07cQgdGkmXz5eWlHrRjrEK5iuCvEyrwSxGwbowQeOIPG7fU2UU9EwGs
	1WfCaNoEivKTT2tZsm55iCKoXJCEnzqzGeijvdCKS+LOfvViXx2SzShP0bNB/8wlMtzKdD
	r9T0EoF3sqeD9y7Mgmap0frVK9S0lD01UC4tlDW689stQy1g7R29zSqfwSrr+w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v3 0/3] selftests/bpf: add coverage for
 xdp_features in test_progs
Date: Wed, 09 Oct 2024 12:12:06 +0200
Message-Id: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPZWBmcC/23OTQrDIBAF4KsE17X4k5imq96jlBB1bIRWg4qkh
 Ny94qqFLB+P+d5sKEKwENG12VCAbKP1rgR+apCaJ/cEbHXJiBHWkp4TrLzLENK46mVMEFPESmk
 hpAHOtUTlbglg7FrNO5KLwQ7WhB6lmW1MPnzqWKa1r+5AhgM3U0zxwDoJnZEAXN2k9+ll3Vn5d
 /Uy+zHo0W+ZFWNqBRe9GjThl39j3/cvxgVZtwIBAAA=
X-Change-ID: 20240730-convert_xdp_tests-ccd66bfe33db
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this small series aims to increase coverage of xdp features in
test_progs. The initial versions proposed to rework test_xdp_features.sh
to make it fit in test_progs, but some discussions in v1 and v2 showed
that the script is still needed as a standalone tool. So this new
revision lets test_xdp_features.sh as-is, and rather adds missing
coverage in existing test (cpu map). The new revision is now also a
follow-up to the update performed by Florian Kauer in [1] for devmap
programs testing.

[1] https://lore.kernel.org/bpf/20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de/

---
Changes in v3:
- Drop xdp_features rework commit
- update xdp_cpumap_attach to extend its coverage
- Link to v2: https://lore.kernel.org/r/20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com

Changes in v2:
- fix endianness management in userspace packet parsing (call htonl on
  constant rather than packet part)

The new test has been run in a local x86 environment and in CI:
 #560/1   xdp_cpumap_attach/CPUMAP with programs in entries:OK
 #560/2   xdp_cpumap_attach/CPUMAP with frags programs in entries:OK
 #560/3   xdp_cpumap_attach/CPUMAP attach with programs in entries on veth:OK
 #560     xdp_cpumap_attach:OK
 Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

---
Alexis Lothoré (eBPF Foundation) (3):
      selftests/bpf: fix bpf_map_redirect call for cpu map test
      selftests/bpf: make xdp_cpumap_attach keep redirect prog attached
      selftests/bpf: check program redirect in xdp_cpumap_attach

 .../selftests/bpf/prog_tests/xdp_cpumap_attach.c   | 130 +++++++++++++++++++--
 .../bpf/progs/test_xdp_with_cpumap_helpers.c       |   7 +-
 2 files changed, 129 insertions(+), 8 deletions(-)
---
base-commit: 058d7c3d1691e2e4a4963716ec6c047dff778637
change-id: 20240730-convert_xdp_tests-ccd66bfe33db

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


