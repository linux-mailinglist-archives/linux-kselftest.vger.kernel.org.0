Return-Path: <linux-kselftest+bounces-1085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D880407A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 21:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327DC1C20B40
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57C35EFF;
	Mon,  4 Dec 2023 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="f0qpg284";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKTEbC2c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB009111;
	Mon,  4 Dec 2023 12:56:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 80A3B5C00B3;
	Mon,  4 Dec 2023 15:56:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Dec 2023 15:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1701723412; x=1701809812; bh=8GB/ov08iH
	jvBVcUgI6yH23procKO/e3iFK3yc6WqUI=; b=f0qpg284bJpVVw1nPh/TnrCzv3
	Gx2cCAU90XK8Vn4wuO26c1FdbQozmMDNw6d3By+luF4UAEclBr9QqmJJSNmoaWSe
	dghTKz7p5ao5uzWQ90LABJsuJqxZo3vblOBqenXnXYRMo4jsrJLTZbr+BSHN9juk
	F6mO5KJRC9PH2Gh4MgzKMLPE5a9NuWnCXR+aNudgkKzTnk2x2wouNWj0VG6m/1FY
	osZ692+6onWHgaKIiz9zhHUFsVMvyL8aM8JsSIeQywvDstLK10cFYBvUAlEyBfKW
	/nUBBhmdltV/avoZypJk0B8aqj0obuyz2/vM7Nr7G+GbGQDMKFQKHgms/9Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701723412; x=1701809812; bh=8GB/ov08iHjvB
	VcUgI6yH23procKO/e3iFK3yc6WqUI=; b=UKTEbC2c27b9X/4abi4DjkBrcB+03
	f+ducKIrmHS/cNvKIEtaWqz8KYtr3KieTOM9OgrSmNnvQJmqXdsZZoeBQjGnXCJd
	96c+Cv7eCfcgHRQSpbL9VXJxmJMHfVKt3YlEiUBuPYDbW0+w6nKFmC7vOuvPFXBZ
	f8gVpflf98HKM6/DM2zo5bo50SEkHYUieVZqhREYQWLfAjcKUEiOvyrHtva8wHoS
	NhS44dpbEcTSpbZSJGOrIklLC6xAYMy7PKeXNEV3skcX6UOhkmY/Gl7+492d/qPE
	bYeZScmVy5Jq8Hhp27Tqn8H4MWc6R3lZ4CbW/hIpaR2aLQhovy/38e1OQ==
X-ME-Sender: <xms:FD1uZYv_KetGYMWakHdAqH9jCWJN7W-oDkolZy2r5n8K8KFqCcHyVA>
    <xme:FD1uZVfMkkLL-dYVBYDo1Pc1-g3BPwuUqrZ6ALFwPG9BZtRv0JDm5-BQfq7dU1lwh
    5Jzn1ebJBZDqB2X_w>
X-ME-Received: <xmr:FD1uZTyDqwU8yuaaxqSxd5wDctbaAl-A6QyL5nJswiorb5IFYygsL0feLY57BdiyLgXa3nCH6Tx0mgZL_yuVMI1o_8s-QUh99K_8xmhe3-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:FD1uZbM0IsrvwIyX70QLs1E167i6An8PHqCk_KlHVn1jNrPbz1Nzkg>
    <xmx:FD1uZY8GMdeLBalgSYt343IglU5Ep0BSvPQ-Duvj05_hl-Ct1TnfnA>
    <xmx:FD1uZTXhfjqxYahnQxTJDzhD8Mzz1Xl-HcxP6dGo-3HrmdYS8fb8yg>
    <xmx:FD1uZTboSbWyQ3clRaELqJGRcLHUzDhj38AsKU66QLVwO6X9fV8yPw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:56:51 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: devel@linux-ipsec.org
Subject: [PATCH bpf-next v4 00/10] Add bpf_xdp_get_xfrm_state() kfunc
Date: Mon,  4 Dec 2023 13:56:20 -0700
Message-ID: <cover.1701722991.git.dxu@dxuuu.xyz>
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


Daniel Xu (10):
  xfrm: bpf: Move xfrm_interface_bpf.c to xfrm_bpf.c
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
  libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
  bpf: selftests: test_loader: Support __btf_path() annotation
  libbpf: selftests: Add verifier tests for CO-RE bitfield writes
  bpf: selftests: test_tunnel: Setup fresh topology for each subtest
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: Move xfrm tunnel test to test_progs
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 +
 net/xfrm/Makefile                             |   7 +-
 net/xfrm/xfrm_bpf.c                           | 232 ++++++++++++++++++
 net/xfrm/xfrm_interface_bpf.c                 | 110 ---------
 net/xfrm/xfrm_policy.c                        |   2 +
 tools/lib/bpf/bpf_core_read.h                 |  32 +++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 162 +++++++++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++-----
 .../bpf/progs/verifier_bitfield_write.c       | 100 ++++++++
 tools/testing/selftests/bpf/test_loader.c     |   7 +
 tools/testing/selftests/bpf/test_tunnel.sh    |  92 -------
 14 files changed, 624 insertions(+), 271 deletions(-)
 create mode 100644 net/xfrm/xfrm_bpf.c
 delete mode 100644 net/xfrm/xfrm_interface_bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c

-- 
2.42.1


