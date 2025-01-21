Return-Path: <linux-kselftest+bounces-24859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D29A17E3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB1816978A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540EC1F237A;
	Tue, 21 Jan 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jW9DudGF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0B2E406;
	Tue, 21 Jan 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464491; cv=none; b=ny5DW1OaV1yJZWq4Y85iqBD0QssB+1jLHqSUF8EtRD2xEo3vYtb2pnmesfjHnjuRR6ha47gWV6la+AuxCncmCzjhnggYlJXi75RJbwmDBkhqDWAnk/O32uveLCUcnWe4p4uaNiDcMbw23YkJy2Ua1lE6tdXBFPu0sffrMsej7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464491; c=relaxed/simple;
	bh=MJp45RsaQFje74RpxQ5U4b2mNpr1YeoPxVG9xb8Ys0g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U5TKUcnuOE7I0RmbGqGJ8ijgaVFOvu5hhLz6AF87N9/WsQKr7AJVCW3yR8AMw3AKU3Ha/gtd+RevRgluyT5HngFZrTr6i8RtsAv/TqRPjJqimbArax4UthBasa+844IlG+qV2McgbvJ5o3LrEyM5xGwqXAz0DoE0Br2+vnjqvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jW9DudGF; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF1D41BF205;
	Tue, 21 Jan 2025 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737464486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Sa/0LkysZBdF2h/gx6EZZSqu8d0fEZn5s0devKhbTI=;
	b=jW9DudGFQOqo0UfjarUUXDF4hyhvgUIFve5WjUi1rdA4lmY4Gl32qZ6hpM3uYHLFyJTthv
	Uev3WWGG2mH0+sLD1mXVTYEOqytlzNOU4ebY833nqfHUFIh4adeflmdY6gJDTWf7Bhi5iG
	eYXN7E/0sBPqVuFRrCF7N2k2igJ7z1w3AyM9uWRibAhHDkAybGtDxukWGogr0oFHwg1Y0+
	rgCJUJ7jamvMzHXejGnyxgqJxtH42/nLMvdgCZNNP0yKrd2JNHvsST2PX1I/+NRsI7ZZAT
	S84MREA0wl3EuDwfI/ItKsINONm98dgMVKf6W0sIqIV+fSHEHpgAaGwXx/qZQw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next v2 00/10] selftests/bpf: Migrate
 test_xdp_redirect_multi.sh to test_progs
Date: Tue, 21 Jan 2025 14:01:22 +0100
Message-Id: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKaj2cC/12NQQ6CMBBFr0Jm7Zi2OC5ceQ/DgtKpTAKtaSvBE
 O5ugzuXLy///Q0yJ+EMt2aDxItkiaGCOTUwjH14MoqrDEYZUlq1mNhJ4qHg/J6KoLmQu3LvLTk
 NdfRK7GU9gg+wL4+B1wJdNaPkEtPneFr04X9Ro/+ji0aF1mjilrwnRXcbY5kknIc4Q7fv+xfHM
 ItGuAAAAA==
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
 - PATCH 1 to 5 rework test_xdp_veth to make it more generic and allow to
   configure different test cases
 - PATCH 6 adds test cases for 'classic' bpf_redirect_map()
 - PATCH 7 & 8 covers the broadcast flags
 - PATCH 9 covers the XDP egress programs
 - PATCH 10 removes test_xdp_redirect_multi.sh

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Changes in v2:
- Use serial_test_* to avoid conflict between tests
- Link to v1: https://lore.kernel.org/r/20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com

---
Bastien Curutchet (eBPF Foundation) (10):
      selftests/bpf: test_xdp_veth: Split network configuration
      selftests/bpf: Remove unused argument
      selftests/bpf: test_xdp_veth: Rename config[]
      selftests/bpf: test_xdp_veth: Add prog_config[] table
      selftests/bpf: test_xdp_veth: Add XDP flags to prog_configuration
      selftests/bpf: test_xdp_veth: Add new test cases for XDP flags
      selftests/bpf: Optionally select broadcasting flags
      selftests/bpf: test_xdp_veth: Add XDP broadcast redirection tests
      selftests/bpf: test_xdp_veth: Add XDP program on egress test
      selftests/bpf: Remove test_xdp_redirect_multi.sh

 tools/testing/selftests/bpf/Makefile               |   2 -
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 534 +++++++++++++++++----
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |  89 ++++
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c  |  41 +-
 .../selftests/bpf/test_xdp_redirect_multi.sh       | 214 ---------
 tools/testing/selftests/bpf/xdp_redirect_multi.c   | 226 ---------
 6 files changed, 553 insertions(+), 553 deletions(-)
---
base-commit: 349e0551b929b4712b4d6127f67dfa41ed48d5a2
change-id: 20250103-redirect-multi-245d6eafb5d1

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


