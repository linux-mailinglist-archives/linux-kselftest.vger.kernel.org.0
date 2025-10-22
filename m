Return-Path: <linux-kselftest+bounces-43739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BBBFA9F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 09:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 334B634EE16
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 07:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122102FB620;
	Wed, 22 Oct 2025 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TnQpMobI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83C2FB095
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118822; cv=none; b=e0n4rXw9joTscSPFHqelPXZUmcVJxzGNtmRSubVATwnFodpg6SDxbyHXx1cezmr5CcgiG3J5ysg/Li1Gc5G5lSx2c1PFa4k9NmevdOgP2t6ng+08l1Knt/IMRJAAL7J+00PmlOH/mmT3nY43wju32Ej4wMiZvopJuEIkzR57bCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118822; c=relaxed/simple;
	bh=eY7bzdosuislIej4pNo5Bez1un/QO4W5oU4SWGD6ZQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N0W7oTxEW2Vmf3lMTkCHLGVbdvUtUzpBeBc+SMYjPiu3QjyAKNIuOcVVLAEilUryZdjFOB/VJyOvxrYxlCr78lkRQiQnpYGcDo7qSz7XNwATuX5C0dVZXQ7N9J7UygDE0xJIzjEAR37Hq0dw3IcGs1gs7gI5u9SJYgdyp6nFBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TnQpMobI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B12294E41269;
	Wed, 22 Oct 2025 07:40:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 81ACD606DC;
	Wed, 22 Oct 2025 07:40:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4247102F241B;
	Wed, 22 Oct 2025 09:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118817; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=E/GIhxiJGREabt5t6pmuINC6TuInwOz6srmToa66ACA=;
	b=TnQpMobIV+klL+FOU004G7Hde1d1JwU4TLBQ1npPkbnzerVtydwp5RTrn971dBZLwhriqf
	ijkLjVG3nlSiA+YqRMbxZwXRMaV7IJcY/ab8um91M0HVRTq4lBaW+zWnTkIhXsI7RWZxk9
	faLKwUenRlo21H5TxoKZvYW0v9jOV4yf6k4TO218SuiakwlKA1+eCJuyGbGnTgT1l4QIK4
	aLOtVhmF17EoBCSv96JnUEha6Zfdv7kiMZEEhIID8WS/w8GNTrepvQt4whelOFfDI0yunW
	FooibMlisd67ptpIjRo7K8wJl9KQkoH77eUnnasAjABfXJuTP+kOKYWa94UqeA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: convert test_tc_tunnel.sh
 to test_progs
Date: Wed, 22 Oct 2025 09:39:49 +0200
Message-Id: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEWK+GgC/02NwQrCMBBEf6Xs2Ug21Rg89T+kiE03dqEmJYmlU
 vrvxp68DDxmeLNCosiU4FqtEGnmxMEXUIcK7PDwTxLcFwYl1VkaRJHtPb+9p1FYjfVJaVM7NFD
 2UyTHy+66QTc54WnJ0JZm4JRD/OwnM+79z4cSL3++GYUUqjfaSFOyU00XQh7ZH214Qbtt2xejk
 DYergAAAA==
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
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this is the v2 of test_tc_tunnel conversion into test_progs framework.
test_tc_tunnel.sh tests a variety of tunnels based on BPF: packets are
encapsulated by a BPF program on the client egress. We then check that
those packets can be decapsulated on server ingress side, either thanks
to kernel-based or BPF-based decapsulation. Those tests are run thanks
to two veths in two dedicated namespaces.

- patches 1 and 2 are preparatory patches
- patch 3 introduce tc_tunnel test into test_progs
- patch 4 gets rid of the test_tc_tunnel.sh script

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
Changes in v2:
- declare a single tc_prog_attach helper rather than multiple,
  intermediate helpers
- move the new helper to network_helpers.c rather than a dedicated
  file
- do not rename existing tc_helpers.c/h pair (drop patch)
- keep only the minimal set of needed NS switches
- Link to v1: https://lore.kernel.org/r/20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (4):
      selftests/bpf: add tc helpers
      selftests/bpf: make test_tc_tunnel.bpf.c compatible with big endian platforms
      selftests/bpf: integrate test_tc_tunnel.sh tests into test_progs
      selftests/bpf: remove test_tc_tunnel.sh

 tools/testing/selftests/bpf/Makefile               |   1 -
 tools/testing/selftests/bpf/network_helpers.c      |  45 ++
 tools/testing/selftests/bpf/network_helpers.h      |  16 +
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 660 +++++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 107 +---
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |  95 ++-
 tools/testing/selftests/bpf/test_tc_tunnel.sh      | 320 ----------
 7 files changed, 776 insertions(+), 468 deletions(-)
---
base-commit: b92bbe400a50e4eb033b378252292d1cc19cabae
change-id: 20250811-tc_tunnel-c61342683f18

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


