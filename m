Return-Path: <linux-kselftest+bounces-23852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B51A0076E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 11:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E093F3A3B02
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769521F9A92;
	Fri,  3 Jan 2025 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HBdDV+dy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BC1F941E;
	Fri,  3 Jan 2025 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899022; cv=none; b=IFvbjnVnzuJmGNE7Sa55AWBEJegFSJxJCgFExEsN/k8UoKXKqIlDCYfBNOzDOQ6qyr9/7faeAI36ORotQikZo9xDQ5sBbNjGZjtzlKTH7qY2tKSqvlmkX4MmZKu7Dyp539YV/HsqMRgCukB4rEV9N5ER+cd10xau7X6wR3LOP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899022; c=relaxed/simple;
	bh=tAR55VhUkI63ptJRyK7PAZrvGiav1QFbfBBRihjRyzM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uFO73htcy5SYz6AB3LqVsqoV9/jfbALZIxAwHSLpezpZdB8EQoyWmub09OaT4h+jONT0RAiLzu15ZXdS2tyKFmV2PXY8wF1NFOOmXmJc441wkF4iyE5vtE/syUWkM/BH2tarNJfOARRzbeVIGE8VSNRAGP+Aefb2nkGzDyUmn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HBdDV+dy; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B97CE40006;
	Fri,  3 Jan 2025 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735899012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QVnG460Vm88SbvJ3W/8jXiM9DHQIK6BiXRdRCPogPqk=;
	b=HBdDV+dyYe9fdqdO+sNlUk3DGgcEWEbb53uSDeGfeb4JLRLHl1h380WlkktkqO/dTWU/Qf
	BwB3O8DSPIXq9BXu4QAYFI35His1qnJwzsRWFwUNV/slzoLsXrbYt/3ttkGatuIPZvNVhA
	EN0sy1yQCW2FlEAOMGXloOxOJFa38+l777Hu4bgrQ8rKbDEMakzlAVm6rf1/hMCQFfitmB
	oA6sQqBJr8Xmxa+UND7F3Ml1burTRa5F5/fRF33lW5HDha4CCOU59xNWrViE1T1Y2IV+wG
	qjhZEUvkdZ3yj09YixJuAh7H/bLi9i41/1f9qXx1mP14QDPcfTps6aK++5Vn2Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH 0/3] selftests: bpf: Migrate test_xdp_redirect.sh to
 test_progs
Date: Fri, 03 Jan 2025 11:10:08 +0100
Message-Id: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIC3d2cC/x3MSwqAMAxF0a2UjC3YIPjZioho+9RMVFIRQbp3i
 8MzuPelCBVE6sxLiluiHHuGKwz5bdpXWAnZxCVXjl1rn3COiiAKf1meG/i6DZ4rUE5OxSLPv+u
 HlD4UXhYrXgAAAA==
X-Change-ID: 20241219-xdp_redirect-2b8ec79dc24e
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the *.sh tests into
prog_tests.

test_xdp_redirect.sh tests the XDP redirections done through
bpf_redirect().

These XDP redirections are already tested by prog_tests/xdp_do_redirect.c
but IMO it doesn't cover the exact same code path because
xdp_do_redirect.c uses bpf_prog_test_run_opts() to trigger redirections
of 'fake packets' while test_xdp_redirect.sh redirects packets coming
from the network. Also, the test_xdp_redirect.sh script tests the
redirections with both SKB and DRV modes while xdp_do_redirect.c only
tests the DRV mode.

The patch series adds two new test cases in prog_tests/xdp_do_redirect.c
to replace the test_xdp_redirect.sh script.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (eBPF Foundation) (3):
      selftests/bpf: test_xdp_redirect: Rename BPF sections
      selftests/bpf: Migrate test_xdp_redirect.sh to xdp_do_redirect.c
      selftests/bpf: Migrate test_xdp_redirect.c to test_xdp_do_redirect.c

 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     | 192 +++++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_do_redirect.c     |  12 ++
 .../selftests/bpf/progs/test_xdp_redirect.c        |  26 ---
 tools/testing/selftests/bpf/test_xdp_redirect.sh   |  79 ---------
 5 files changed, 204 insertions(+), 106 deletions(-)
---
base-commit: da86bde1e6d1b887efc46af5ee1f9bbccd27233e
change-id: 20241219-xdp_redirect-2b8ec79dc24e

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


