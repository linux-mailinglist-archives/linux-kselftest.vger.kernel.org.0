Return-Path: <linux-kselftest+bounces-44528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC96C25EB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 989C5350A06
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E92EDD6B;
	Fri, 31 Oct 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w+hD89nl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B014F2E8E0B
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926129; cv=none; b=GkRIKjSmmSNO+rM9R+Sy9J1lQs79+TlhoG4Bdo9KiqhnlV5GDWx3c1Ex+yvico4VDqszLM6KE0kXFWISf1W4bflKsN9d6XgnsjlAaZhfDDnzn1xKMgFwwpTVvnXHzN4WRDiPVjn0FMO1oCl7tNdQZUUbJ5DP29BEjA4AJuFYQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926129; c=relaxed/simple;
	bh=y++OIs24NlL2poJhyuPT7wxHIdzikkTShu5iXdEikZ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=unN1Fybhrwg1XUX0JfDxBQDyWh58vgPImGmBzXQCwu4Mm6aw3iHE24KYg9Mo72RLbX5tgNZsxJJzdzma/Si/oXuaSJKv841QGluSs+GmgHSjzUVO4r6q0sNOYXkc02fZYGqkhW2OiO/XHf2OHAsw9UUq+BP9RuSp/bU5v7MgWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w+hD89nl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E58461A17AA;
	Fri, 31 Oct 2025 15:55:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA2A960704;
	Fri, 31 Oct 2025 15:55:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7462911818064;
	Fri, 31 Oct 2025 16:55:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761926122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=q63ieI5JMkLvB2SxtHax81YWUkC+9RQd84Qw6wY6yRY=;
	b=w+hD89nlOvccsSFAKqXY2LnxWzJDHaPe30pDVKl5EZDUkpLv4zgDM9KfHiCEFaqkClaobO
	96yyH/zVlROP6gL9d+JZ6nxtLs9t/on0+wcevwnWkKNmtIjvFViLj+jLQCT5gjs4zoSWOr
	a44lVdaFl/MfI8sHzvq2A4LFg7c2T25nu1KBywxS5eVtrGobkzMdLZjQd/Jx5dsttPWdcM
	bHWuR+a+aRagAc/qu5fyQJ4IZT8Y9KHTt//LuxbVc6p0UefBMesCA1uhbemQ6BbH3mY4NF
	1DnHzDBD/p75Q661/YKkSjOVa4iEwnJp9W/uGBLzieQGDReRcDNamezs+2GGQA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next 0/4] selftests/bpf: convert test_tc_edt.sh into
 test_progs
Date: Fri, 31 Oct 2025 16:55:12 +0100
Message-Id: <20251031-tc_edt-v1-0-5d34a5823144@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAODbBGkC/x3MQQqAIBRF0a3EHydoFkhbiQjLV/2JiUoI0d6Th
 gcu96GEyEg0Ng9F3Jz48hWqbWg7rT8g2FVTJ7tBSS1F3ha4LDSsgXHaqR5U4xCxc/lHE61hFx4
 l0/y+H1qQs05iAAAA
X-Change-ID: 20251030-tc_edt-3ea8e8d3d14e
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this is yet another conversion series, this time tackling the
test_tc_edt.sh. This one was at the bottom of our list due to the fact
that it is based on some bandwith measurement (and so, increasing the
risk to make it flaky in CI), but here is an attempt anyway, as it also
showcases a nice example of BPF-based rate shaping.

The converted test roughly follows the original script logic, with two
veths in two namespaces, a TCP connection between a client and a server,
and the client pushing as much data as possible during a specific
period. We then compute the effective data rate, shaped by the eBPF
program, by reading the RX interface stats, and compare it to the target
rate. The test passes if the measured rate is within a defined error
margin.

There are two knobs driving the robustness of the test in CI:
- the test duration (the higher, the more precise is the effective rate)
- the tolerated error margin

The original test was configured with a 20s duration and a 1% error
margin. The new test is configured with a 2s duration and a 2% error
margin, to:
- make the duration tolerable in CI
- while keeping enough margin for rate measure fluctuations depending on
  the CI machines load

This has been run multiple times locally to ensure that those values are
sane, and once in CI before sending the series, but I suggest to let it
live a few days in CI to see how it really behaves. 

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Alexis Lothoré (eBPF Foundation) (4):
      selftests/bpf: rename test_tc_edt.bpf.c section to expose program type
      selftests/bpf: integrate test_tc_edt into test_progs
      selftests/bpf: remove test_tc_edt.sh
      selftests/bpf: do not hardcode target rate in test_tc_edt BPF program

 tools/testing/selftests/bpf/Makefile               |   2 -
 .../testing/selftests/bpf/prog_tests/test_tc_edt.c | 274 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_tc_edt.c    |   9 +-
 tools/testing/selftests/bpf/test_tc_edt.sh         | 100 --------
 4 files changed, 279 insertions(+), 106 deletions(-)
---
base-commit: 1e2d874b04ba46a3b9fe6697097aa437641f4339
change-id: 20251030-tc_edt-3ea8e8d3d14e

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


