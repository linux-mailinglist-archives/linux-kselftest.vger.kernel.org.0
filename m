Return-Path: <linux-kselftest+bounces-25280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2405FA207DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4453A7DDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B9B19CC3E;
	Tue, 28 Jan 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dzF7FHyP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA2156C74;
	Tue, 28 Jan 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058263; cv=none; b=ef25TIiuzMAf7q3wT3LvOdttiBlOtWMdK22EgZOXvAYGkTsGXDqeyF9kL+0c9jSkk8GJx+FeekjyGHBtgQtlZXFiWAsA7ZmI3C1IAcFVVcMtJYcoUaAZqjOHa/YPi1J4gpaA2AHRTBUxg22TK9gPIbzN6Y6KEPm19Q9538/S8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058263; c=relaxed/simple;
	bh=MfLqQs6Ob1xdGl/kch1yEpsHGwBAOc9eAw+IopdXINI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H5UveCAhpK2lAkhPP5klxyNcrO/T3gdrTrV5l9B2aogmXn+UwfhOeqcZap/qqgDkIOiF/yLkkafFnSMoy/daEgE1Y5LgeQ1mrjoeG75jSKmaG6TOUD7A9bXw9avXDG6myf2ssKKdDq75xhsrayZS79784H6rHNbNyZcLVNiGC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dzF7FHyP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4062C1C0009;
	Tue, 28 Jan 2025 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738058258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JEGERsPll1RSOAbHDv5XGR3VGTOEbTxIv3nsk3OYgkQ=;
	b=dzF7FHyPs7DR2SnKOnJMYTPoO2BOTHwO9mp/d6cBF5ndRlIwpI8Mn7y0JTKzbLXgog+rm/
	SvjN7dwwFGeB1HBlDwLoduZYXP2hlmeQoxQvMJLFhwtLRhdpZKlZtk51TnDFvoz1cuStCp
	sfn607xo3XKh8Kmxe67sW/R47RdhD13NrbJjZkBi5i8VszSrL7Z1FRf958RI/RYAoLDUMs
	krqLof6ufthJMzCO9ZcQSwvnt/7cihcSaPvaxOMY97r/Ns0SMP+b1GgBeefAN4YoVP2NEu
	VLZ2zjwAZnSxXxH4yU4aTn5Ja66FTNJmtdgXHV/yAYAcDtAN2d+OIMwLZxAiOg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v3 00/14] selftests/bpf: Migrate
 test_xdp_redirect_multi.sh to test_progs
Date: Tue, 28 Jan 2025 10:57:24 +0100
Message-Id: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWqmGcC/33NTQ7CIBQE4Ks0rMUAlSa68h7GBT8P+5IWGkBS0
 /TuElzpwuVkMt9sJEFESOTSbSRCwYTB19AfOmJG5R9A0dZMBBOScdbTCBYjmEzn55SRipO0Ayi
 npeWkjpYIDtcG3oheHPWwZnKvzYgph/hqT4W3/oMK/osWThnVgkvopXOSyasOIU/ojybMDSviP
 yAq4MzZKKO0GbT4BvZ9fwNuDYVG+QAAAA==
X-Change-ID: 20250103-redirect-multi-245d6eafb5d1
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
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series continues the work to migrate the *.sh tests into
prog_tests framework.

test_xdp_redirect_multi.sh tests the XDP redirections done through
bpf_redirect_map().

This is already partly covered by test_xdp_veth.c that already tests
map redirections at XDP level. What isn't covered yet by test_xdp_veth is
the use of the broadcast flags (BPF_F_BROADCAST or BPF_F_EXCLUDE_INGRESS)
and XDP egress programs.

Hence, this patch series add test cases to test_xdp_veth.c to get rid of
the test_xdp_redirect_multi.sh:
 - PATCH 1 Add an helper to generate unique names
 - PATCH 2 to 9 rework test_xdp_veth to make it more generic and allow to
   configure different test cases
 - PATCH 10 adds test cases for 'classic' bpf_redirect_map()
 - PATCH 11 and 12 cover the broadcast flags
 - PATCH 13 covers the XDP egress programs
 - PATCH 14 removes test_xdp_redirect_multi.sh

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Changes in v3:
- Add append_tid() helper and use unique names to allow parallel testing
- Check create_network()'s return value through ASSERT_OK()
- Remove check_ping() and unused defines
- Change next_veth type (from string to int)
- Link to v2: https://lore.kernel.org/r/20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com

Changes in v2:
- Use serial_test_* to avoid conflict between tests
- Link to v1: https://lore.kernel.org/r/20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com

---
Bastien Curutchet (eBPF Foundation) (14):
      selftests/bpf: helpers: Add append_tid()
      selftests/bpf: test_xdp_veth: Remove unused defines
      selftests/bpf: test_xdp_veth: Remove unecessarry check_ping()
      selftests/bpf: test_xdp_veth: Use int to describe next veth
      selftests/bpf: test_xdp_veth: Split network configuration
      selftests/bpf: test_xdp_veth: Rename config[]
      selftests/bpf: test_xdp_veth: Add prog_config[] table
      selftests/bpf: test_xdp_veth: Add XDP flags to prog_configuration
      selftests/bpf: test_xdp_veth: Use unique names
      selftests/bpf: test_xdp_veth: Add new test cases for XDP flags
      selftests/bpf: Optionally select broadcasting flags
      selftests/bpf: test_xdp_veth: Add XDP broadcast redirection tests
      selftests/bpf: test_xdp_veth: Add XDP program on egress test
      selftests/bpf: Remove test_xdp_redirect_multi.sh

 tools/testing/selftests/bpf/Makefile               |   2 -
 tools/testing/selftests/bpf/network_helpers.c      |  11 +
 tools/testing/selftests/bpf/network_helpers.h      |  10 +
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 589 ++++++++++++++++-----
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |  89 ++++
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c  |  41 +-
 .../selftests/bpf/test_xdp_redirect_multi.sh       | 214 --------
 tools/testing/selftests/bpf/xdp_redirect_multi.c   | 226 --------
 8 files changed, 608 insertions(+), 574 deletions(-)
---
base-commit: e65d1a6e096af0648ffdbc9d7e8bd7a44dcc700b
change-id: 20250103-redirect-multi-245d6eafb5d1

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


