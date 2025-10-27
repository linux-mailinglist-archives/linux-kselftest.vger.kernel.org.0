Return-Path: <linux-kselftest+bounces-44101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E13C0EA6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 910564E3909
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EBD2C21FB;
	Mon, 27 Oct 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="did5QFqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F2239567;
	Mon, 27 Oct 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576740; cv=none; b=Qm9rzMvzkeLTCfp8UCcXtGd7xJ2qgpTOZQajTl44WphAzx6Drm51rh/TEX3Z2dh8Ue6sVPqD/LSEiQR8aoY8d1cvdRs7NUjtqoiHMEU80lsBNvo+3KQUEufYaPg7VLkMO8oyPxNFwFPIIHw9iTydayP3sXgKhiczeRfmu7Mfi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576740; c=relaxed/simple;
	bh=5ORSopPHzqT+JQMXOWN/QIYFeXx9NCSwHQ9+XUHA56c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=icmjEtput0cz39LlwFFkYn0ijd7cblvtqFl0+y9jUaR58offJYy1ztD3dAuY9j3na/kDXnjbKVAn2gW8v1Y4+KuFnmZ4eWmAXss20ZUMrJOMlNoqruhg4fZwf2Ch8LOwtNC/n3cLCMXQukglqR2IfzBKmhI/3LBt34O/fF3f+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=did5QFqQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 579E44E4136F;
	Mon, 27 Oct 2025 14:52:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 26D0A6062C;
	Mon, 27 Oct 2025 14:52:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42DA2102F24D3;
	Mon, 27 Oct 2025 15:52:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761576733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=DuHkXePUk6nSfSYEkcrN/kO/hmAFgCdpDzG5ZHaMNZ4=;
	b=did5QFqQfV5fK6c2kzfEr3hbeKkU8TwiRbH00ElBxOpHW2BuT+Npt1XOUVgROzKpev9sik
	gAPLEeVsQMGWgrh0bm40vLcYI9Ej5m+FU3R+h2G9mCWGky7RUAaYCZN8dBx+zpLy+MEbdg
	6dEKUp+7c1Jkllp2seQoO0ZVO/c6dYBE0K6K1TbUNALyCWeELcRtMUA5Ev+dXYgd/Aj7XV
	M42s48u0ifdS6YvbbXy1unf4pJaBdaymKUYjAu4au7Qlm3drW8u4eQ7tWocMA8AfVhYsLp
	2OlUDpB/QIM3kOYj/xwRRoyVk1upMG0l3AwMj7Zp1DPtYfhvHxBinpQ1dzfdCg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v3 0/4] selftests/bpf: convert test_tc_tunnel.sh
 to test_progs
Date: Mon, 27 Oct 2025 15:51:52 +0100
Message-Id: <20251027-tc_tunnel-v3-0-505c12019f9d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAmH/2gC/12NywrCMBBFf6XM2khm+jC68j9EpElTG6hJSWKol
 P67saviZuBy7zmzQNDe6ACXYgGvkwnG2RzKQwFqaO1TM9PlDMSp5gKRRfWIb2v1yFSDZUWNKHs
 UkPeT172ZN9cN5NQzq+cI99wMJkTnP9uThFv/8yHH086XkHFGnWgEF/lKukrn4mjsUbnX5km0Y
 4n2LGW2raqWy66mM/9j13X9As7eAbTqAAAA
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
this is the v3 of test_tc_tunnel conversion into test_progs framework.
This new revision:
- fixes a few issues spotted by the bot reviewer
- removes any test ensuring connection failure (and so depending on a
  timout) to keep the execution time reasonable

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
Changes in v3:
- remove systematic "connection must fail" test part of each subtest
- also remove kernel-based decap test for subtests supposed to fail on
  kernel side
- fix potential fd leak if connection structure allocation fails
- fix wrong early return in run_test
- Link to v2: https://lore.kernel.org/r/20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com

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
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 674 +++++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 107 +---
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |  95 ++-
 tools/testing/selftests/bpf/test_tc_tunnel.sh      | 320 ----------
 7 files changed, 790 insertions(+), 468 deletions(-)
---
base-commit: ecdeefe65eaeb82a1262e20401ba750b8c9e0b97
change-id: 20250811-tc_tunnel-c61342683f18

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


