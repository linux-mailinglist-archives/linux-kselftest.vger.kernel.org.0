Return-Path: <linux-kselftest+bounces-1608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C775B80DB64
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A10328175C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56CE53E0B;
	Mon, 11 Dec 2023 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BHKcWMQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z1V0zJn5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE4C4;
	Mon, 11 Dec 2023 12:20:32 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 57F015C03B9;
	Mon, 11 Dec 2023 15:20:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 11 Dec 2023 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1702326029; x=1702412429; bh=1LpLS1VeE5
	3pmJfvPFkbIaa6I4cSdrZgdy4B9FeKti0=; b=BHKcWMQaz4kdz0P9KrZj9tMljJ
	RpPJGDUGJr9DZLXC1QaVVSNcPPkPUSc99kZzUGHVbUavFvpgjxLKmqyAVc2qqkoJ
	XJw1QqiffmqvjmsMXGz2A445jgl8izocAknqfYfCKvLV831miPjNlzJaPvW7Uri0
	S+8kUU9qzr2eDkyI8tUYdiacKAKgA00/ds1wjgvL34j1/kgsySaFLviiOAbD6g44
	gZcEHV/OAi8iEsuDvimEZ63SZ6zHWamTjdxRX/LryDd8bRfsqAR3370Wfy8YGSkM
	5MU6VP0jS3BhAMK9TyaiOHG8jDru8zdlUly2y55rQSYo1D4l3+ExBVXgiOCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702326029; x=1702412429; bh=1LpLS1VeE53pm
	JfvPFkbIaa6I4cSdrZgdy4B9FeKti0=; b=z1V0zJn54JcQuSexGk6Ou7cLDXtLl
	eMmFguAAi68QbXZndhoi3zh+CcmjtgLv1xIvUZ7KguND97iJovL+k02LPd6i2JDV
	vmmazbhQm4bBycdu5vLL+g0kWStyOBKVLugzOMtjAM0kJelwmXQr1WDz9GV0M/EY
	U2yTdbn1UhymLWLSwI8201Fl9vXrxmc7MR8aKOPzpdWgapSCXuEpQevLb9mZDv6k
	PWVHdegp3v3e+ktQCG2p0fBIAQupDE6QmTEY4fRmjAastKcZyfXkNS7HuTEqXZPb
	XGC25ULvds3uqAvv40pYmZZ+n62NvAX0Be5rju9lFQaIKY04i4xSVewkA==
X-ME-Sender: <xms:DG93ZRtsaSCBRiTcLfKEycUOhm4idynzG28hntarWAnSni4LybHjXQ>
    <xme:DG93Zadl3d4bXAGrv9yBuIyO_mTbDkvj03ppP97LLut4n-57fkkewnUNq6Bg6VmBc
    0FxfMn3A9mX15gHfA>
X-ME-Received: <xmr:DG93ZUyq7EyuEr0yWtEm5M7WdHRxXMFlOBzHzsXu-GPyGyfA4pRQAcybCWBpM4ZKFsn20aq3FAECWrZYdIbDBGSqdg1Id7aqtaHpkK0hfhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:DG93ZYM2uIzV1Cn0VOboDaxh4IG6I4wlBujeANcxdMdsd2PcJVMICw>
    <xmx:DG93ZR-scIL8PLX32brlGjX3lwErkzRm42AIsaTbc0Oe66cHSjnq2Q>
    <xmx:DG93ZYW_F9Tuu2gjAx-g6RhDd8ipjexYD2h3mCruna9xZz2DvS2xpg>
    <xmx:DW93ZS2EZi5D85RdITfcjF2rnz7hYVaL6V_bCx0AuNuLCxESXThqkA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:27 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
Cc: devel@linux-ipsec.org
Subject: [PATCH bpf-next v5 0/9] Add bpf_xdp_get_xfrm_state() kfunc
Date: Mon, 11 Dec 2023 13:20:04 -0700
Message-ID: <cover.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds two kfunc helpers, bpf_xdp_get_xfrm_state() and
bpf_xdp_xfrm_state_release() that wrap xfrm_state_lookup() and
xfrm_state_put(). The intent is to support software RSS (via XDP) for
the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
on (hopefully) reproducible AWS testbeds indicate that single tunnel
pcpu ipsec can reach line rate on 100G ENA nics.

Note this patchset only tests/shows generic xfrm_state access. The
"secret sauce" (if you can really even call it that) involves accessing
a soon-to-be-upstreamed pcpu_num field in xfrm_state. Early example is
available here [1].

[0]: https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/03/
[1]: https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357d6ce2863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406

Changes from v4:
* Fixup commit message for selftest
* Set opts->error -ENOENT for !x
* Revert single file xfrm + bpf

Changes from v3:
* Place all xfrm bpf integrations in xfrm_bpf.c
* Avoid using nval as a temporary
* Rebase to bpf-next
* Remove extraneous __failure_unpriv annotation for verifier tests

Changes from v2:
* Fix/simplify BPF_CORE_WRITE_BITFIELD() algorithm
* Added verifier tests for bitfield writes
* Fix state leakage across test_tunnel subtests

Changes from v1:
* Move xfrm tunnel tests to test_progs
* Fix writing to opts->error when opts is invalid
* Use __bpf_kfunc_start_defs()
* Remove unused vxlanhdr definition
* Add and use BPF_CORE_WRITE_BITFIELD() macro
* Make series bisect clean

Changes from RFCv2:
* Rebased to ipsec-next
* Fix netns leak

Changes from RFCv1:
* Add Antony's commit tags
* Add KF_ACQUIRE and KF_RELEASE semantics


Daniel Xu (9):
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
  libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
  bpf: selftests: test_loader: Support __btf_path() annotation
  bpf: selftests: Add verifier tests for CO-RE bitfield writes
  bpf: selftests: test_tunnel: Setup fresh topology for each subtest
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: Move xfrm tunnel test to test_progs
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 +
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 130 ++++++++++++++
 tools/lib/bpf/bpf_core_read.h                 |  32 ++++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 162 +++++++++++++++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++++-------
 .../bpf/progs/verifier_bitfield_write.c       | 100 +++++++++++
 tools/testing/selftests/bpf/test_loader.c     |   7 +
 tools/testing/selftests/bpf/test_tunnel.sh    |  92 ----------
 13 files changed, 522 insertions(+), 155 deletions(-)
 create mode 100644 net/xfrm/xfrm_state_bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c

-- 
2.42.1


