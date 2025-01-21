Return-Path: <linux-kselftest+bounces-24846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8BA17B4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 11:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1461884F1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F31DEFF8;
	Tue, 21 Jan 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jmglL4ws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706671B4251;
	Tue, 21 Jan 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454943; cv=none; b=gOtuqDQCdVzJvYMii/27ZMg6Y0Qk8vFwFmN/IGjvCztZKGSx4weSkY3boPhY9aIliyuvVD6TxtCZP5MMFvSIMF4Pl4Y5MAQFq78MCBkHncOoAOG+6Wa/eR0ZlPmWlQKQulzIiGzGbah7PIgHi5sO7QQUnJZfTAigR4D3s44WxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454943; c=relaxed/simple;
	bh=ESdptXXVOfXAqsr9p18hJKUyWQhzRcjYpJjeZYOfC4A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XxIjtIsEYKdXc6P5SIDnA9igxUNJR1YiPA/JxTqL2bt3iATmTlcyNPvO3cNDhXiUsN4O1/Ob7SDOuAxE4g4Za8uSkS6/+uU4P/WeXFv2OLjf6fEp9BGPobFFr5LZUL8B+vb1AmwacYA048RuVs3QFMNALfC4D6fd2L9UPYwk8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jmglL4ws; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15D7B240003;
	Tue, 21 Jan 2025 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737454938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wBZ6J8YBUBEKBz+krzyV3uMHD2IyWDLli4c0/4yEHUU=;
	b=jmglL4wskwgHtYOATL20Jo30HlpW0s9PZhi+xQbwvf+Ma0c2z5fBGbTQ7N3G93Etd8z4Tu
	fxIXoSE/Xq+VKQwzUxt+DY8dB5GkRFsdxMyp6E5g7S+BfUh++xFW40vKDvocuRQTE4eJpz
	irni8c5h1o3SHs065B2bA/Hg1CNLdgNIjbo7qmXTd5Iv/OcuYkLcPBGXPCPrva58F5CDDG
	tnpiPtOW+3oYI/8BYRWCwpI0TrxHghky9F+y+U06ASOehNh10zqib/sPXVHODyjwOVi5k+
	nNf35DoliMozmwzB7tzUZqGaXGPou2COKGytaEbQ6Pn0aR3dJwWF7orWt/GW/A==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: [PATCH bpf-next 00/10] selftests/bpf: Migrate
 test_xdp_redirect_multi.sh to test_progs
Date: Tue, 21 Jan 2025 11:22:14 +0100
Message-Id: <20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFZ1j2cC/x3MQQqDMBBG4avIrDuQpKYLr1K6UPNHB2oqkyiCe
 PcGl9/ivZMyVJCpa05S7JLllyrso6Fx7tMEllBNzjhvrHmyIohiLLxs3yLsWh9e6OPgg6UarYo
 oxz1807BGTjgKfa7rD7O97wRqAAAA
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
base-commit: 075d2f15ddfc67f27601c8f861dd5d3b189af401
change-id: 20250103-redirect-multi-245d6eafb5d1

Best regards,
-- 
Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>


