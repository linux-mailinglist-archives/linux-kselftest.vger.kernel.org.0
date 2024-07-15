Return-Path: <linux-kselftest+bounces-13718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB649311B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 11:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6AB28561A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15D18732C;
	Mon, 15 Jul 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TphJjMly"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11606186289;
	Mon, 15 Jul 2024 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037250; cv=none; b=YPxno8qtHleeanXnZNf1C8CV8ZocNjs1nOwyQTO4J3k1tu1qdZrqbYiUvXkCYuERdt/d9z9HVJgRfWsI8vAadtxeAEIqVUzteQb7vBM3BaxHKSoDN19j8b8+VeQWRTMxz5iwPEzKzZiVEHAp3jXvWyhy/VQc/FHUsNPraoAMkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037250; c=relaxed/simple;
	bh=KSZN46K5NHraZVRQeAStXPt3z3x/a9hGQyfcaywP150=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jJjvzSeeLklQvJWYLIcqs7K5PFU+ZiGtAQNW5ZC+Z+/8Fw1jdZSumB8PNn/344AE/WQDxSmAMdSbILTRIBWYnAgPRgoRh+yJ5NApGjHfIwrSPjXbEUsTvcCB4aDctqKfv8ZNOVWZaNV9HvX+sS8loiRkzk6YWRa7Bt8zMVYyl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TphJjMly; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 230E51C0007;
	Mon, 15 Jul 2024 09:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721037245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YFAfwtBIgPY9mDDpDWTR3OVirdr3NZrvZYhoT99Crqc=;
	b=TphJjMlyTK9i3StZVG6FWlp27kHyeuw/M9duGpeFWK6jzCbVA0ejIcccutjCvaznL3YLvB
	i15OPg4Rp669lQkytCku4SVJ+Jr8B9heKqSUEgUuRZnyTXnROFYHK868y+jeYe3WDo27xt
	mNlc2AYUbR8ofyMeAq0oFAGRT0bk87cpy+g/cYtQsyewkykusfGaPHzHEMYMig9R8kevnZ
	zqa+nFuQ6A3HZE3W+PGgCFFUVfRcYHdmSADhlC92Rmor3RaAGdHR+j//i/i20gv3KPoOhX
	HzfRWkl3tjl/5f6e1ziqFWv1SPwHQjkg+b3x9wJ9QzXZKEheTYt/+UbIrnU2oA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH v2 0/2] selftests/bpf: convert test_xdp_veth to test_progs
 framework
Date: Mon, 15 Jul 2024 11:53:43 +0200
Message-Id: <20240715-convert_test_xdp_veth-v2-0-46290b82f6d2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKjxlGYC/3WNQQqDMBBFryJZN2USTCNd9R5FRMexDrSJJCFYx
 Ls3Fbrs8j34728iUmCK4lptIlDmyN4V0KdK4Ny7B0keCwsNugarQKJ3mULqEsXUrePSZUqzhBo
 RzGSMsaMo2yXQxOvRvbeFZ47Jh/dxk9XX/orqTzErCbK5ND3iAL3V9jZ4n57szuhfot33/QOgo
 6FTvAAAAA==
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
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

Hello everyone,

this small series is a first step in a larger effort aiming to help improve
eBPF selftests and the testing coverage in CI. It focuses for now on
test_xdp_veth.sh, a small test which is not integrated yet in test_progs.
The series is mostly about a rewrite of test_xdp_veth.sh to make it able to
run under test_progs, relying on libbpf to manipulate bpf programs involved
in the test.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Changes in v2:
- fix many formatting issues raised by checkpatch
- use static namespaces instead of random ones
- use SYS_NOFAIL instead of snprintf() + system ()
- squashed the new test addition patch and the old test removal patch
- Link to v1: https://lore.kernel.org/r/20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: update xdp_redirect_map prog sections for libbpf
      selftests/bpf: integrate test_xdp_veth into test_progs

 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 211 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |   6 +-
 tools/testing/selftests/bpf/test_xdp_veth.sh       | 121 ------------
 4 files changed, 214 insertions(+), 125 deletions(-)
---
base-commit: 4837cbaa1365cdb213b58577197c5b10f6e2aa81
change-id: 20240710-convert_test_xdp_veth-04cc05f5557d

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


