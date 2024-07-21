Return-Path: <linux-kselftest+bounces-13976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F86D9385EE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 21:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671DC1C206A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869E16A954;
	Sun, 21 Jul 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SfonLoqH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D0322E;
	Sun, 21 Jul 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721590403; cv=none; b=oL0VTX57kmINGv0p/uOxsFXb/cjAvBh1QwjG1wnbHurOndt0lMfS+QRVUeE+ZQSPLF1UEuymvIifRrujnlcXzp8PmjBtJo5NSc2SW/xkoheLqicvCTr3p7teY78zEnFAnAapIx0g2xGKtsuj4LnjF/XGuHBE5BBiYbcsr3KqQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721590403; c=relaxed/simple;
	bh=AoT/Uut9stibicIDKBPjE/MdgHvySYO/zLsb99YiRDs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IgwG5KdY/qKSL9eUjlF1WTW5rkyfhJfDvLRJPsZ0GlDdSZ2Gu1pp9bCJ+4ix46FddtsKAyNTB6ulJaoZebCAc5icNmOTn4eCmE0MFlLV1YDhP2wEpAjbLyMwtVyQW/rRnk6PPnSl2h/9SFsqgLGVD60md11tbvYhsFIAj4Tb3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SfonLoqH; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97D3DE0003;
	Sun, 21 Jul 2024 19:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721590392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZQFTzEsP7Kp/6et5R0JPxrZOQS09vVWQIIZprfMMn4g=;
	b=SfonLoqHpUyoc7NI2/IpdNwWXebVrXILbM9wifHduS4ZsY9zaUOTlJA1jmbJi6aWx0cDzG
	+8nAjsRS8zbPSahyReUumG+LJaiJ6yV+ylPlK3O2HXi3x48gjAZAf72eIY6+zSqgdbwcGE
	I+atMstAk+3kK8MplwpTQ4B1dxDrofNhGrgM4Soe9ZM+ZljWTHRzn6Nd9sLl+HMyVXfbYW
	EzX2zf9VTr8+vEHkZxW1KrrjB0ebtpE6SO/uPZyLQ8AdaGLmAtrWimF9WiLCZkO4BuGxFI
	puLkbPu1IQfJfzAUEZDFzf77Dkf2x4bEHarrbZGCeST8m8iPKP19rvRv15BrHw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH v4 0/2] selftests/bpf: convert test_xdp_veth to test_progs
 framework
Date: Sun, 21 Jul 2024 21:33:02 +0200
Message-Id: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG5inWYC/3XN0QrCIBTG8VcZXmccdc6tq94jYkx31oSaQ0UWs
 XfPgqCIXf4/OL/zIAG9xUAOxYN4TDZYN+UodwUxYzddkNo+N+HAS1AMqHFTQh/biCG2Sz+3CeN
 IoTQG5CClVD3Jt7PHwS5v93TOPdoQnb+/3yT2Wj8i2xATo0Drqu6M0dApro7auXi10964G3mZi
 X87csvh2Skr3oCu+VD1/N8R30615YjsKA1M1A0Ko8Wvs67rE0tSm2RMAQAA
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
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
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
Changes in v4:
- add missing netns_close in an error path during programs attach
- Link to v3: https://lore.kernel.org/r/20240716-convert_test_xdp_veth-v3-0-7b01389e3cb3@bootlin.com

Changes in v3:
- Fix doc style in the new test
- Collect acked-by tags
- Link to v2: https://lore.kernel.org/r/20240715-convert_test_xdp_veth-v2-0-46290b82f6d2@bootlin.com

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
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 213 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |   6 +-
 tools/testing/selftests/bpf/test_xdp_veth.sh       | 121 ------------
 4 files changed, 216 insertions(+), 125 deletions(-)
---
base-commit: 4837cbaa1365cdb213b58577197c5b10f6e2aa81
change-id: 20240710-convert_test_xdp_veth-04cc05f5557d

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


