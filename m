Return-Path: <linux-kselftest+bounces-13553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A992E196
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 10:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF7F1F21436
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 08:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F8C152789;
	Thu, 11 Jul 2024 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bckoJdzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24315217F;
	Thu, 11 Jul 2024 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685423; cv=none; b=sEQV4TG2YtjfChMC9dYZ6+EBAYGhx0uanG/VmXdW7ccZSYKIYzOiPEDkPiQ8g1bHcX+gdvIR+zA2sy3tyljFTXGHLGEDMXO7OeFudZSFjC4kX9k+EM/j7dKz6d6Ci0adhLW3d7ghsORm1DDxNTkkP3vkPSMelzNnYDl4tSZ+6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685423; c=relaxed/simple;
	bh=CmNOZ0IZW32vucrdQqbvCc2FIJX2rBVqatIjrQKVLWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HAAbJYuVmO2EzOtPAFwKd+1GolDKsA1WrR5cqFwDTGLYwJzQfzOwYd27tEL+lOvuotkIA8TAu3MQA08hmxiQ2nwxC4InEYkLt1pgXard3Uy4RaQZU3xxCXA2q7tlo6AFJXh60GZi803ww0+TDQ7IVgSBHWYDcNwk1NjDSRhYe6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bckoJdzg; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9C18E0005;
	Thu, 11 Jul 2024 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720685413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XfvAB9w6sAmgiKWBoR1ts9qoQxawgr71uefwp3YcJQQ=;
	b=bckoJdzgt5qK7mTrvPmIOAIb/Whom/D3OIE5v0v2Uxf3krj2QeN42pm4bD39db6PyovLDx
	sUWXdj4MVYA1kdpHILQcO6bdH4Xg47fxCRNfZUZp7loAXG68H0UDcWCNmkiKwnfoBBBarZ
	fkC9mIte+tiIOxHX/k3gMK9dTls5uw6wCfyAzNOj4t5+r6xFUhxu5mepVcJw4Q7RjDpMcG
	nTlvmd3kPZCXn/AUUKsySPq5PQKLDQ7N189isDG9JAD583S4u/hKN6fyqDeRUze/clATUE
	xDbXJPHklpU9dnzFf7gxgg+pjRD2sry87jkI6c/n2c0vT3K94Z+ffVU57o0CPw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH 0/3] selftests/bpf: convert test_xdp_veth to test_progs
 framework
Date: Thu, 11 Jul 2024 10:09:33 +0200
Message-Id: <20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD2Tj2YC/x3MQQqAIBBA0avIrBMmSYSuEiGhY85GQ0WC6O5Jy
 7f4/4FKhanCKh4o1LlyTgPzJMDFI50k2Q+DQrWgmVG6nDqVZhvVZm9/2U4tSlycQx201sbDaK9
 Cge//u+3v+wGcdfMwZwAAAA==
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
Alexis Lothoré (eBPF Foundation) (3):
      selftests/bpf: update xdp_redirect_map prog sections for libbpf
      selftests/bpf: integrate test_xdp_veth into test_progs
      bpf/selftests: drop old version of test_xdp_veth.sh

 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 234 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |   6 +-
 tools/testing/selftests/bpf/test_xdp_veth.sh       | 121 -----------
 4 files changed, 237 insertions(+), 125 deletions(-)
---
base-commit: 4837cbaa1365cdb213b58577197c5b10f6e2aa81
change-id: 20240710-convert_test_xdp_veth-04cc05f5557d

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


