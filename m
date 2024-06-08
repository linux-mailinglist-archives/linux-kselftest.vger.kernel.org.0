Return-Path: <linux-kselftest+bounces-11494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E290137C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD871F21B28
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4322206E;
	Sat,  8 Jun 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="C/2UCxEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ekWp98Kd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCC6FC6;
	Sat,  8 Jun 2024 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881383; cv=none; b=LaiDAERb66VRcHzus4cXsKeCEFUj9Gu5FsqQt0NUgFn9WY0l7JlZcHp375YKn0Ofs2DZc2GZwK+kja1SQtBuMzzU9oA8p4GK90R606tSJErgAyUumYpT1t8BLyDSTJw3Z6EuILMmselF+gO83O0s35XZsdnP874G0xzaoN7zx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881383; c=relaxed/simple;
	bh=ILnuGu5r6cuHQ9wdUVbkAPXhJPVeZtLb6jYztlxoK3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTdccNit8euZF51MKXKObF1cPTlDm53YFUGXSFw8ACj/V66O8HqYEhfRttjVFpv724gRfkjP2jduzuOFHTBVA84RhWQdd3eIwua6X0qjemceM20Rb9DyLINXlt1uA5C7xXT9q0qw9XkJuZ14Do9VAqeRSDFnfd1OaqlzYpxSkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=C/2UCxEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ekWp98Kd; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 7C1F31C00091;
	Sat,  8 Jun 2024 17:16:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 08 Jun 2024 17:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1717881380; x=1717967780; bh=0YjzCY6kziUrd0juArDnY
	i2Mlm4V8ledwTgp3zoKTHM=; b=C/2UCxEcrta2pXIQsQBSLsP5dh3P/OXAmTLTF
	mYPK2tbDh9O5/BWTx/NXJ92yEdolAXahFJLFsXq3RnMzQJNQjYQkDgSSQYbt0FcH
	AGfluzboETbuhYl4dSBCibukN9wzGxzBmX74S1KpZ4qPh9YoZzsAMaBPtAd28Drq
	SN0gq2PUXqDZH6Iw8PXNG4AUwnkvxutxvPEXGuhxEB81wqGm93SJuzwlb43mRpql
	m3ERGu3cj3oArbBWBR436SeoBpnOcyt6rQv/gV0KM97HPHsKxlyC1XaPHnonUrTO
	KbtUTChrm0XH5nWmUHNIYFifHf7+xJrykdtEcp7xVlQGw20qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717881380; x=1717967780; bh=0YjzCY6kziUrd0juArDnYi2Mlm4V
	8ledwTgp3zoKTHM=; b=ekWp98Kdaj4NLFqyv137QlWn0Oq4q0VzN6XzuCs8a0qq
	MOmHo8VLWG5gOvu9CIUnb8Lrzh6pbU5Pq26GJaoYs17tI4plC+K7eSbZZXA/SuW/
	powdCyu+V34uTsI2Hh2ImtHO6D0OKCIKRU81g5ewFMqZFZKR8iTRRTzhyHfsaWfs
	th5gnmKlr7ZmxhFn2koA1HPGJQdJF5gihtR63MEgxFONLMeeXEIMCKXJdyK9sSeb
	rwe3m/2KJsgb3krIMsz0cyExxJEtHP0jfAm7WiYziREI2/wJBzNlVRV4S46RRicg
	FK698k+04raY/IhfsgH+LKgSNK5lLs7L2Y3WK4rLtg==
X-ME-Sender: <xms:I8pkZiPQzS0JXLGj4NDo3WVWzaVL9PqE3LCxpHna_WhYtwYF1w0vVQ>
    <xme:I8pkZg8t2-s7n2u7FViZ8CbEccF6qvHBSLy9yhQcR9l4-lERiTMpoPEiXyvehM0ub
    JzSZqLqQFQ3jMOckw>
X-ME-Received: <xmr:I8pkZpQBAtosIsPYcZ5iyafuJ_gd0ZxAoZfdkEfexMNhLJ8H4CE1dBy3VmFuHhi_RL29ZFlztxA8UNXGRU0BmglYlTlZ7sNraLB5rQSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:I8pkZisQmbH7y9ZoWwm7tgGLW_uvHYqOiyn_9unXpvQKE22eEMIDtg>
    <xmx:I8pkZqdImpCGCcFuRfXp5JcpUhBUGqbjLpZIzObtbvx3A-NbQCqVzw>
    <xmx:I8pkZm2V0XvkjKsAVr3t0CE6l3TyinwdoabJiUAQg8TdoUkFsNNlCw>
    <xmx:I8pkZu8elr2R4BiSBJWV_cmLSUaaies627q8TxqJHiMB5HDQFd4kgw>
    <xmx:JMpkZl1M1QfxBF7KARSxx2fP7fMSp_GZkkJq6ZennI4n0H607d478TUN>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:18 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	fsverity@lists.linux.dev,
	andrii@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: kernel-team@meta.com
Subject: [PATCH bpf-next v4 00/12] bpf: Support dumping kfunc prototypes from BTF
Date: Sat,  8 Jun 2024 15:15:56 -0600
Message-ID: <cover.1717881178.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset enables both detecting as well as dumping compilable
prototypes for kfuncs.

The first commit instructs pahole to DECL_TAG kfuncs when available.
This requires v1.27 or newer. v1.27 is nearing release at time of
writing. Following this, users will be able to look at BTF inside
vmlinux (or modules) and check if the kfunc they want is available.

The final commit teaches bpftool how to dump kfunc prototypes. This
is done for developer convenience.

The rest of the commits are fixups to enable selftests to use the
newly dumped kfunc prototypes. With these, selftests will regularly
exercise the newly added codepaths.

=== Changelog ===
From v3:
* Teach selftests to use dumped prototypes

From v2:
* Update Makefile.btf with pahole flag
* More error checking
* Output formatting changes
* Drop already-merged commit

From v1:
* Add __weak annotation
* Use btf_dump for kfunc prototypes
* Update kernel bpf_rdonly_cast() signature

Daniel Xu (12):
  kbuild: bpf: Tell pahole to DECL_TAG kfuncs
  bpf: selftests: Fix bpf_iter_task_vma_new() prototype
  bpf: selftests: Fix fentry test kfunc prototypes
  bpf: selftests: Fix bpf_cpumask_first_zero() kfunc prototype
  bpf: selftests: Fix bpf_map_sum_elem_count() kfunc prototype
  bpf: selftests: Fix bpf_session_cookie() kfunc prototype
  bpf: selftests: Namespace struct_opt callbacks in bpf_dctcp
  bpf: verifier: Relax caller requirements for kfunc projection type
    args
  bpf: treewide: Align kfunc signatures to prog point-of-view
  bpf: selftests: nf: Opt out of using generated kfunc prototypes
  bpf: selftests: xfrm: Opt out of using generated kfunc prototypes
  bpftool: Support dumping kfunc prototypes from BTF

 fs/verity/measure.c                           |  3 +-
 include/linux/bpf.h                           |  8 +--
 kernel/bpf/crypto.c                           | 24 +++++---
 kernel/bpf/helpers.c                          | 39 +++++++++----
 kernel/bpf/verifier.c                         | 12 +++-
 kernel/trace/bpf_trace.c                      |  9 ++-
 net/core/filter.c                             | 32 +++++++----
 scripts/Makefile.btf                          |  2 +-
 tools/bpf/bpftool/btf.c                       | 55 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  2 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  2 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c | 36 ++++++------
 .../selftests/bpf/progs/get_func_ip_test.c    | 14 ++---
 .../selftests/bpf/progs/ip_check_defrag.c     | 10 ++--
 .../bpf/progs/kprobe_multi_session_cookie.c   |  2 +-
 .../selftests/bpf/progs/map_percpu_stats.c    |  2 +-
 .../selftests/bpf/progs/nested_trust_common.h |  2 +-
 .../testing/selftests/bpf/progs/test_bpf_nf.c |  1 +
 .../selftests/bpf/progs/test_bpf_nf_fail.c    |  1 +
 .../bpf/progs/verifier_netfilter_ctx.c        |  6 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  1 +
 tools/testing/selftests/bpf/progs/xfrm_info.c |  1 +
 22 files changed, 183 insertions(+), 81 deletions(-)

-- 
2.44.0


