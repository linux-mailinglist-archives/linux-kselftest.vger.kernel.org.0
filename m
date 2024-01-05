Return-Path: <linux-kselftest+bounces-2649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FBA824D24
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 03:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88B21F218E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AE320E6;
	Fri,  5 Jan 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="OcasozcO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SwtNdc1w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5D5243;
	Fri,  5 Jan 2024 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 141D23200AA6;
	Thu,  4 Jan 2024 21:45:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 21:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1704422759; x=1704509159; bh=shDcnJN57Ps6qaIAEkU8F
	J/na3mfjDv3/Jaj5tSn7IU=; b=OcasozcOKOlLR63MynS4l0InDlMwrPX2ZWPYJ
	sL9DX86SvCu8ClrOS4Ku1E/E8EBuEQzobGdM6lFoJ19nUzSTxgCKGITiBc0S39hY
	Pcx8qrwaDAdbdjb3cAHv+N28eqVEvlxez12Q/kXRn7DB5NKNh84BW7htzFfSHUzP
	t7C2OBWu+Z/fYToQmQ2HHxDFUG8sVPELu+y7Jy6YUqM9Rv3m1aZvoJ8b/eQ5Drd+
	6nh0dDlRQo78k717S8gTcLU5Pf5PoTfbmjVex4vtJCyQgJBOdz2/w8L/k+1/2sNd
	BqGTyLDGXN6qyiqRdThOXvXF8qsX5Gh5rCsPHobIjIAo0UgyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704422759; x=1704509159; bh=shDcnJN57Ps6qaIAEkU8FJ/na3mf
	jDv3/Jaj5tSn7IU=; b=SwtNdc1wjrGjwlkXJqmjjSKnRxeS8MdkZ363QWm36EgS
	mddXCYLacsTRIpi8y8SxIS8ae0Ml5kEBEC9RtfifypPk8QrFoKAPVc/f2lKvwzxR
	CHvnrpCZZmpkTsRWd75mn9PNlIAYzHMlITEX5pPs6j7V6ItrsrCJVjvsiRlugRKh
	M6sgk1g2xnckIxYNsFXOGm/0tahh05CI1YQNnusQhdwraz/k9WzJbgFlwrdMhDCV
	8R7vPIXZrlNYLrikmQG7eWU/6R6izLHa4rHmhyUB2v3ZJcbkDtfzXdPcQuL8hsIz
	GDxEtPW9f0fy/KfK0Wgne8WAkp7BxV5N0jt4XhgV7Q==
X-ME-Sender: <xms:Z22XZUIlEeMLUw4eZXushJMMPyaEa929ROSx9QpRmbZrWfO0_caOTQ>
    <xme:Z22XZUJFlPKG4VNtTOgMa0zpKuAYzMTXAU-J0V1zsNBFwSW5XHBcs-HePrqD7iAX_
    poZiYAzx0RGczuiGg>
X-ME-Received: <xmr:Z22XZUshk4uFI3tnHE6aJz1Jhu3SsjSdkhPNxxT1-5m7exUBEYcOBmdhQ4ZIhigtXY7XchBFgVWAu11CirM-dVF-pxN1ELQeKp9TjYr5eRqJSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeffffegjeduheelgfdtudekie
    ejgfegheehjefgieejveevteeiveeukefgheekjeenucffohhmrghinhepghhithhhuhgs
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Z22XZRb7lZ0XC9c6tko6WdioGTT3Z0Bn3BKhgNG-jAkKoTcA1oNxrw>
    <xmx:Z22XZbZw_aDZopiaWtoB7ZRtvFEw3EgGf4BGU8wK-vYEJR9L4_kfig>
    <xmx:Z22XZdAd23temfr2TZAASMVEg7nMo52uH5UCybPO6ETdyKrEtPpncQ>
    <xmx:Z22XZcLxJGdXT7eBJpfdLcdVP6mzmxdQhoOdVdsU5pMdrvTubM93TA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 21:45:58 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 0/3] Annotate kfuncs in .BTF_ids section
Date: Thu,  4 Jan 2024 19:45:46 -0700
Message-ID: <cover.1704422454.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

=== Description ===

This is a bpf-treewide change that annotates all kfuncs as such inside
.BTF_ids. This annotation eventually allows us to automatically generate
kfunc prototypes from bpftool.

We store this metadata inside a yet-unused flags field inside struct
btf_id_set8 (thanks Kumar!). pahole will be taught where to look.

More details about the full chain of events are available in commit 3's
description.

The accompanying pahole changes (still needs some cleanup) can be viewed
here on this "frozen" branch [0].

[0]: https://github.com/danobi/pahole/tree/kfunc_btf-mailed

=== Changelog ===

Changes from v1:
* Move WARN_ON() up a call level
* Also return error when kfunc set is not properly tagged
* Use BTF_KFUNCS_START/END instead of flags
* Rename BTF_SET8_KFUNC to BTF_SET8_KFUNCS

Daniel Xu (3):
  bpf: btf: Support flags for BTF_SET8 sets
  bpf: btf: Add BTF_KFUNCS_START/END macro pair
  bpf: treewide: Annotate BPF kfuncs in BTF

 drivers/hid/bpf/hid_bpf_dispatch.c            |  8 +++----
 fs/verity/measure.c                           |  4 ++--
 include/linux/btf_ids.h                       | 21 +++++++++++++++----
 kernel/bpf/btf.c                              |  4 ++++
 kernel/bpf/cpumask.c                          |  4 ++--
 kernel/bpf/helpers.c                          |  8 +++----
 kernel/bpf/map_iter.c                         |  4 ++--
 kernel/cgroup/rstat.c                         |  4 ++--
 kernel/trace/bpf_trace.c                      |  8 +++----
 net/bpf/test_run.c                            |  8 +++----
 net/core/filter.c                             | 16 +++++++-------
 net/core/xdp.c                                |  4 ++--
 net/ipv4/bpf_tcp_ca.c                         |  4 ++--
 net/ipv4/fou_bpf.c                            |  4 ++--
 net/ipv4/tcp_bbr.c                            |  4 ++--
 net/ipv4/tcp_cubic.c                          |  4 ++--
 net/ipv4/tcp_dctcp.c                          |  4 ++--
 net/netfilter/nf_conntrack_bpf.c              |  4 ++--
 net/netfilter/nf_nat_bpf.c                    |  4 ++--
 net/xfrm/xfrm_interface_bpf.c                 |  4 ++--
 net/xfrm/xfrm_state_bpf.c                     |  4 ++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  8 +++----
 22 files changed, 77 insertions(+), 60 deletions(-)

-- 
2.42.1


