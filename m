Return-Path: <linux-kselftest+bounces-21933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA17C9C7174
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 14:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4422827C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC161F1301;
	Wed, 13 Nov 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kMTIZ52r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EF17C68;
	Wed, 13 Nov 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506039; cv=none; b=WBhwbRk8q0jYCPHNDroyfJU+Ymo2maq3wrLhOZlid8oUQGwzYvkJGXsRURa3/wkZlDuHR4tJS+r8oV/RFQGcEsj6sFFjFR+TWRuFcUVZAs+lU822VhD/YvMrapqtZkxSx01GoIeIiYlOycO4I9MSQeh0JuzpF9wcYuFmXk3qfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506039; c=relaxed/simple;
	bh=rpNgvwkUMNlgtsz7MLV0G9313l5cccxzMRdAkh6mXVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PvTNVGgJAsHRNBvWopBgvxcI2GuH+Facvjfi5GsJEll0iJomOoyexekIARVHoBnZwudtguB6kNmmQhj622NGdrLJGue7Xy6zYINeQqp41T43VQ7+5EU8SPtmywLc5FrF5cNdLoDr+4FWTmLJFIr8MVwdXQf8V/m8yvIkS1Ivc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kMTIZ52r; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45F372000D;
	Wed, 13 Nov 2024 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731506028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fN6Hxl4DEN2NRiCEypIuKC3K47Ano+rFiafHb3D4OZY=;
	b=kMTIZ52rug+wMUoUY8ITfzIcvkOZL1cNxYOxCh5IBNgCX0j97ha2yTQD/pDIRirUDJGQAZ
	UYdA5CmkugQ0JI9/lDat303YyglTD1XaksMm7rce3laBZ3m1dfG/Wg2kKkzDSHwtL1K5+n
	el0X83G+Lq4dUphnaDyKHQTLRMagOLPHbVOIhOwDFD8uvBK73pyrtmTRvPfbSc+8RENuJf
	fvL5u7iphhsC2WVvfFEaT8florHu3g6DH+0ViGKA3y12UdJQYD888piWyKdcU4yACvqv8R
	Ux1ADU0uNfThjFPZyq8ggXtl+xKeeapp2RnxqM9zWc4/0MBjepWyf3c5rlXQrg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next 00/10] selftests/bpf: migrate
 test_flow_dissector.sh to test_progs
Date: Wed, 13 Nov 2024 14:53:23 +0100
Message-Id: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFSvNGcC/x3M3wpAMBSA8VfRubbaHxGvIontjFPatCOUvLvl8
 nfxfQ8wJkKGrngg4UlMMWSosgC7TmFBQS4btNSVkqoVfovX6IgZ7RGTMDhLKxtvVW0gR3tCT/c
 /7GHevQh4HzC87weMDExgagAAAA==
X-Change-ID: 20241019-flow_dissector-3eb0c07fc163
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
Alexis Lothoré (eBPF Foundation) (10):
      selftests/bpf: add a macro to compare raw memory
      selftests/bpf: use ASSERT_MEMEQ to compare bpf flow keys
      selftests/bpf: replace CHECK calls with ASSERT macros in flow_dissector test
      selftests/bpf: re-split main function into dedicated tests
      selftests/bpf: expose all subtests from flow_dissector
      selftests/bpf: add gre packets testing to flow_dissector
      selftests/bpf: migrate flow_dissector namespace exclusivity test
      selftests/bpf: Enable generic tc actions in selftests config
      selftests/bpf: migrate bpf flow dissectors tests to test_progs
      selftests/bpf: remove test_flow_dissector.sh

 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   3 +-
 tools/testing/selftests/bpf/config                 |   1 +
 .../selftests/bpf/prog_tests/flow_dissector.c      | 307 ++++++--
 .../bpf/prog_tests/flow_dissector_classification.c | 851 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_flow_dissector.c  | 780 -------------------
 tools/testing/selftests/bpf/test_flow_dissector.sh | 178 -----
 tools/testing/selftests/bpf/test_progs.h           |  25 +
 8 files changed, 1107 insertions(+), 1039 deletions(-)
---
base-commit: 16e1d1c377aa4c56223701a31f3bfa88505e7e4f
change-id: 20241019-flow_dissector-3eb0c07fc163

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


