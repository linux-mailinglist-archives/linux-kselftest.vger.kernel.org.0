Return-Path: <linux-kselftest+bounces-2627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65702823930
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 00:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F081C249B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 23:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338A1F614;
	Wed,  3 Jan 2024 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="lJYbtwRp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkEYNB6m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557D81F607;
	Wed,  3 Jan 2024 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 127D03200A61;
	Wed,  3 Jan 2024 18:32:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Jan 2024 18:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1704324729; x=1704411129; bh=fBlTY1O1StgZyteJRwSj0
	WOCCgegue7fpMlq4tQR6pE=; b=lJYbtwRpU+dVyyJzJZGCzGN92FAzyXisdOTyA
	hga+Tz/oNJxJ3/vh/ENWw6VHA+9HerOrPM2yWKDSKa04HVB3afWClfUwTaAtFILW
	OOVdYMb3RS7WYs0cPfNNo/UZh0rAW6MwxJFDMOxHBIHXACpAM3WNV/bs0rxvDBBj
	GGHGGty44rb3NCzCrLoYZRXL72lVlXj0gf3g6rWQUy1UjZo3Ifu4q9QhgmHzssry
	WN/qaTsiffEf1EDV1rHDW/plzF8viJ497gnxWhdrOnnKviF3QxnTaFMD8DHcWi4j
	+0GbOI3AcpHRe4idSw13HwvflHAZYyOVVWd+rhnaTiuXyjVvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704324729; x=1704411129; bh=fBlTY1O1StgZyteJRwSj0WOCCgeg
	ue7fpMlq4tQR6pE=; b=bkEYNB6mF2hRhn3oPBkxEv4MTis76LQX6kxIG4Z0a6O8
	23WlTBLrL4m/EbFGIxviTL79olTDxMSHWoK7u5IxthjrQXU02MP8fVR8cEHO+s3z
	h8von97bCIEtyKs9dVGqsTso2HX2723lGaEJ4DG9E3VuEupuwDZ9ImKTyv6mHiqP
	wuOuteLGQc8bzh+zQfHLyBvqgY03UkxiOnIeaQST+5haxhjaEnRa2cWZ0ZH2VtaB
	xJAiTBX7cdldtYW6XK3hKhIJwA2WtWLJps3e0b9RRiYcZfCwinXmUFCGzKY9UGcZ
	iRKgeAvxv5v7eXLQegka4wpUNzFHNkzVJlpd+Y9hfw==
X-ME-Sender: <xms:ee6VZb7nVEguWYMYGcsHeDfQzGSOkMaR910F5h5_TmodHTwiD3gTCw>
    <xme:ee6VZQ58ecOlJDLxO9xUG2RyHUBjmzzDeyXxPFYSsl0hQYEbGH4rsOw9xQlLBnzuT
    vvXCum2bPsN3CBkhA>
X-ME-Received: <xmr:ee6VZSe-dtivdRXsviJeY6ng4lQHZMCRz8IWSabTPNAqBqnMe4LBurFOoNG8A-3AhFklujKA1fjO7IkhP1LAuxJY96RzHZw2HFvb1CmYlV_Q4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ee6VZcJsPTwIypaABAx54mLUiDqR-eW4GzwFx7VZtovUCBL5U1HhmQ>
    <xmx:ee6VZfJe-ZA9i8lcfVslhcroQyOjo5igaaU6c31UT9YGkk1qQl0hXA>
    <xmx:ee6VZVx1eanecM8vnOIT199ezlrPTsbYNWWHs1kGu3CorWW_CdOwMg>
    <xmx:ee6VZQ5hX2kthjEX-X3ufwYaJnC9ulEG6gmoMS1iN5eth7eiyZ1LQQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 18:32:07 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: coreteam@netfilter.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kselftest@vger.kernel.org,
	fsverity@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/2] Annotate kfuncs in .BTF_ids section
Date: Wed,  3 Jan 2024 16:31:54 -0700
Message-ID: <cover.1704324602.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a bpf-treewide change that annotates all kfuncs as such inside
.BTF_ids. This annotation eventually allows us to automatically generate
kfunc prototypes from bpftool.

We store this metadata inside a yet-unused flags field inside struct
btf_id_set8 (thanks Kumar!). pahole will be taught where to look.

More details about the full chain of events are available in commit 2's
description.

Daniel Xu (2):
  bpf: btf: Support optional flags for BTF_SET8 sets
  bpf: treewide: Annotate BPF kfuncs in BTF

 drivers/hid/bpf/hid_bpf_dispatch.c              |  4 ++--
 fs/verity/measure.c                             |  2 +-
 include/linux/btf_ids.h                         | 17 ++++++++++++-----
 kernel/bpf/btf.c                                |  3 +++
 kernel/bpf/cpumask.c                            |  2 +-
 kernel/bpf/helpers.c                            |  4 ++--
 kernel/bpf/map_iter.c                           |  2 +-
 kernel/cgroup/rstat.c                           |  2 +-
 kernel/trace/bpf_trace.c                        |  4 ++--
 net/bpf/test_run.c                              |  4 ++--
 net/core/filter.c                               |  8 ++++----
 net/core/xdp.c                                  |  2 +-
 net/ipv4/bpf_tcp_ca.c                           |  2 +-
 net/ipv4/fou_bpf.c                              |  2 +-
 net/ipv4/tcp_bbr.c                              |  2 +-
 net/ipv4/tcp_cubic.c                            |  2 +-
 net/ipv4/tcp_dctcp.c                            |  2 +-
 net/netfilter/nf_conntrack_bpf.c                |  2 +-
 net/netfilter/nf_nat_bpf.c                      |  2 +-
 net/xfrm/xfrm_interface_bpf.c                   |  2 +-
 net/xfrm/xfrm_state_bpf.c                       |  2 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c     |  2 +-
 22 files changed, 42 insertions(+), 32 deletions(-)

-- 
2.42.1


