Return-Path: <linux-kselftest+bounces-11770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60379057D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F35288294
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357BE181D00;
	Wed, 12 Jun 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="HevoMQeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNgewxui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B807181CE2;
	Wed, 12 Jun 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207935; cv=none; b=jSy4EmMmDEZ2RIDC/BlT5oqQaxtGQR+GVbw7Qqjxem/x5b5pqTybVc396rChMNDDTDEPThhv+6e5VrmdQOj6XKvBFvs2sDt+8mQOEtq4BVfRXev6zhS3aLzH2iWcQ0iTa1JkGNyN9FJQybfGeUUJrb8bh65SRFSxY50kF8fVDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207935; c=relaxed/simple;
	bh=W+jeMBnxhS6jlPaTrEAMDVDFNqWeLN6ix77HMDsJyOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqvunDzDlYkB2WbvdbPTxqeDAaBh0Pq9l3yLzJG6542fr1Td9q2QaqR3fMxQkczxo0IM35ZQX+DfzI7lBEXM+BWDprF26p3+vozZzzM6YoPoCZZli6HggB16jjIQjF5DiK/p9vdLLpczkBMoVt3jF6Kb1EGoC0YT3FDiyFcpUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=HevoMQeH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pNgewxui; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id B0AF41C000FC;
	Wed, 12 Jun 2024 11:58:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 12 Jun 2024 11:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1718207931; x=1718294331; bh=lZNEnqp773uzAqziPN4z0
	qNlf0lINbmqCuH/tcesE+g=; b=HevoMQeHXigG+6FXskHzOBLCeauAiRxC8h389
	dej5hFVj6zR0aoICtH1AtSY+Ryt+tLMtszdrsDxP00dTkmqB7+9TtISMilMmBQIu
	9HkEbwSseUZ8zWLs39Pe2Y5Xdui7FAVsFjLRoFZs9U9obAFcOvABgWKB2MoLwwlM
	m2QJGfw/kjQbOqrwe2nvhYZBTZpoM+dMpBh+ncNo2dEdSSRS8QWdH8b6kKi6M61I
	quylEi3QeddM8x2ra2R8Av8oU586A5e+5fkMapHOyoSxVWM5UOzU4VoLA/cSuD9s
	Ma3tMuNyJt+mFPio/dIVZxzfYTY7fB+qpUMcwTZ8T0loBIJQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718207931; x=1718294331; bh=lZNEnqp773uzAqziPN4z0qNlf0lI
	NbmqCuH/tcesE+g=; b=pNgewxui531SonZy0q0p0krvK2Mlrb5HK89Ht4MzBaVb
	J/d0QC4zarry+HE7mfOOKkRCpLQROBmxtEL2xa+MRweTqtPrpDNThCpoiZH4NNAL
	58LxIwt/AsRkU/A2QRNG9NS8ipdJI/DtjSEu61whmv3iwroVsGFvfP3HDRwT/2HP
	SrzuiHmOF3rG7SawQ+hJMNigPT3SWHLTkTXhcXapYL87404PLwm3DoGgasI9aJDy
	28X26vh+up5KcXCrLrz/gK/rb3ZYqdVZBe6cS5amnJ/2nhGY3wzBm0XNEr9oZXLe
	tNgMtwxU3/c2apvUTKVgp5BRWoB8pbvXlVyFH2gTFw==
X-ME-Sender: <xms:u8VpZotBo2dKox_et4WZvAVIoUWMQjSyXlxY9Q_Tc2N7_QYcyHkzKw>
    <xme:u8VpZlfmfwvxgPi7cDSe3uhMSvw02DCblQ5oweV5Px06L8MTthKpBH3_zruaMvL5V
    JZVXDsueFRR2w6MYw>
X-ME-Received: <xmr:u8VpZjyV-4-wxEqV0H4VULuGBundfv0mN98kowJNEwVJHbC0EneW63TYmv-5VziP5rOaw3Ed6PqA8YWfN4loBBv-_9GN_ev1EqNoHQjh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepiedtkefgudevteevvefgue
    fhgeeikeelgeehfedtkefffeejgfetteefueekgfeknecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:u8VpZrPeZTa0_BTThRb8TMjH7qs4h8HOVhf-2Umj9f937OGIpEZSTg>
    <xmx:u8VpZo9ovHLCV6UXcXBP1ronL5vDeMG-84e_n3TT3IS2zbD7W7P_ZA>
    <xmx:u8VpZjWb4warsTUProQ4pWrwXIpLZih59TIWQDGr2KNqKASBupsPdg>
    <xmx:u8VpZhdF1OklyRMXuRpJeZaExPEOjnv0QjR4zMbDa5yCnOD-x_YxHg>
    <xmx:u8VpZrfXblp_gbyAPaTMb2ZoUUdzO7haAFmQGBSYXW9QTMVagDJQvXJS>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:58:49 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fsverity@lists.linux.dev,
	andrii@kernel.org,
	jolsa@kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: kernel-team@meta.com
Subject: [PATCH bpf-next v5 00/12] bpf: Support dumping kfunc prototypes from BTF
Date: Wed, 12 Jun 2024 09:58:24 -0600
Message-ID: <cover.1718207789.git.dxu@dxuuu.xyz>
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
This requires v1.27 which was released on 6/11/24. With it, users will
be able to look at BTF inside vmlinux (or modules) and check if the
kfunc they want is available.

The final commit teaches bpftool how to dump kfunc prototypes. This
is done for developer convenience.

The rest of the commits are fixups to enable selftests to use the
newly dumped kfunc prototypes. With these, selftests will regularly
exercise the newly added codepaths.

Tested with and without the required pahole changes:

  * https://github.com/kernel-patches/bpf/pull/7186
  * https://github.com/kernel-patches/bpf/pull/7187

=== Changelog ===
From v4:
* Change bpf_session_cookie() return type
* Only fixup used fentry test kfunc prototypes
* Extract out projection detection into shared btf_is_projection_of()
* Fix kernel test robot build warnings about doc comments

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
  bpf: Make bpf_session_cookie() kfunc return long *
  bpf: selftests: Namespace struct_opt callbacks in bpf_dctcp
  bpf: verifier: Relax caller requirements for kfunc projection type
    args
  bpf: treewide: Align kfunc signatures to prog point-of-view
  bpf: selftests: nf: Opt out of using generated kfunc prototypes
  bpf: selftests: xfrm: Opt out of using generated kfunc prototypes
  bpftool: Support dumping kfunc prototypes from BTF

 fs/verity/measure.c                           |  5 +-
 include/linux/bpf.h                           |  8 +--
 include/linux/btf.h                           |  1 +
 kernel/bpf/btf.c                              | 13 ++++-
 kernel/bpf/crypto.c                           | 24 +++++---
 kernel/bpf/helpers.c                          | 39 +++++++++----
 kernel/bpf/verifier.c                         | 12 +++-
 kernel/trace/bpf_trace.c                      | 17 +++---
 net/core/filter.c                             | 32 +++++++----
 scripts/Makefile.btf                          |  2 +-
 tools/bpf/bpftool/btf.c                       | 55 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  2 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c | 36 ++++++------
 .../selftests/bpf/progs/get_func_ip_test.c    |  7 +--
 .../selftests/bpf/progs/ip_check_defrag.c     | 10 ++--
 .../selftests/bpf/progs/map_percpu_stats.c    |  2 +-
 .../selftests/bpf/progs/nested_trust_common.h |  2 +-
 .../testing/selftests/bpf/progs/test_bpf_nf.c |  1 +
 .../selftests/bpf/progs/test_bpf_nf_fail.c    |  1 +
 .../bpf/progs/verifier_netfilter_ctx.c        |  6 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  1 +
 tools/testing/selftests/bpf/progs/xfrm_info.c |  1 +
 22 files changed, 193 insertions(+), 84 deletions(-)

-- 
2.44.0


