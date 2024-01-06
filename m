Return-Path: <linux-kselftest+bounces-2679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A6382610C
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6385B2254E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9CACA70;
	Sat,  6 Jan 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="nSlxfYqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3+3KpJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB7D517;
	Sat,  6 Jan 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id BEEB15C01F7;
	Sat,  6 Jan 2024 13:24:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 06 Jan 2024 13:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1704565489; x=1704651889; bh=O+QqJr2WAb6rnS5d3f3K/
	DUa8bao3pdF0ZTmvmSXi54=; b=nSlxfYqtTJQDcbNuLTrQgszS9JWQG78owNAi+
	zSEhkctan19C4FEG6xx31H7/uqLhr7cesA1k19u3yPWoTqEsjFQ9yXkYWzOwcrCc
	uVFm073ba2P4po8CIj0KsQmKiUvyewqrtgGGHYuCsQh9sG9wTVHadAUo0quCq9nh
	3wn4b3d1hbj+B/ZBZzqNQciP6TjHgoc98zJcDMj167R+hteCx5QxTdQFWmXVzzZW
	dLZHp2yX3SB79f2KkARUikb1eP9u23YNh795fdJ0UznpK3VR5tdEnA4s15gPY+yc
	m8kLTyYiJGEIqc1JEboSKWqEtD7xjep48oIUYT69ow17Gai6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704565489; x=1704651889; bh=O+QqJr2WAb6rnS5d3f3K/DUa8bao
	3pdF0ZTmvmSXi54=; b=b3+3KpJVeWQPqqPw2/XyIgSWVprhEDWFog7zIhj7juCB
	2fghtEDXjtChsmjRYm5But8IKubV1CNa4oc4t8RnFO9oYn0LRNPBXCZSj+uBMyoS
	hqCbZqfAaWnezgz2I9YNwPlBKGmW+OwMM5TKxf+m1k5XACoJwnYaulFkWJXWIeuC
	G4wTyt1bBYVR3EFQPep8tJMmwO2Z8w/GPAloXq3sTltOn9ht5D9dBpVImQ3kjoaF
	Kl0wD++fiJfxAfJraal4lPmjZxrlq5azZ6HzjJk0lPs0xKwIWbnwmcNllJA6r0i8
	Bziwb2eIGshtU8+n9i4yL+sn1ttsvey9hwKh4kj2eQ==
X-ME-Sender: <xms:8JqZZTa2LWzgZ0-GmgqS5LmLiABXTJV-q6m5pw2KEf52kA-_v2wfMA>
    <xme:8JqZZSY16TYAWdOZIuP8yKWF5XRgyCIaZj9hCtazJgvb_WXDJT9OoLmN_FIlP23Tb
    sL0h3wKj1DmLsm58g>
X-ME-Received: <xmr:8JqZZV8ddNHA1F0_QGF1cpRCX1fLuMSzgKqs_Fg3sXfaUgOpYFT_S3HHautwyc1OmhIwEyCsPi3RRo61vZxpwY8y-vSDxy2GkEZ98QEvFqVpPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffffgeejudehlefgtdduke
    eijefggeehheejgfeijeevveetieevueekgfehkeejnecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:8JqZZZpHSzujnehtNM-9w6SM6ebZxdJiLRzNQZcPYUXvIr1FXoFm8Q>
    <xmx:8JqZZeqcnauyVxfA1Rp6P8hO1PAbhin9VwCYuUjW_KX7IU7bSpqbDg>
    <xmx:8JqZZfSntMFC9PDiV8fngNBCBp68lp9CgFnySiCgnfTcNGT64YxhQQ>
    <xmx:8ZqZZSZbzVDin2kRmp_SLX1xW7XThP5VlZBJyX2zJfv-05ftzvGpwQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jan 2024 13:24:47 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-input@vger.kernel.org,
	coreteam@netfilter.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	fsverity@lists.linux.dev,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	cgroups@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 0/3] Annotate kfuncs in .BTF_ids section
Date: Sat,  6 Jan 2024 11:24:07 -0700
Message-ID: <cover.1704565248.git.dxu@dxuuu.xyz>
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

Changes from v2:
* Only WARN() for vmlinux kfuncs

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
 kernel/bpf/btf.c                              |  8 +++++++
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
 22 files changed, 81 insertions(+), 60 deletions(-)

-- 
2.42.1


