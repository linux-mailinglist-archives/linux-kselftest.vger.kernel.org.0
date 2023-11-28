Return-Path: <linux-kselftest+bounces-732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F37FC0B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 18:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9087282B2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E865B5B4;
	Tue, 28 Nov 2023 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="FgQ9rBAe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wGBILsJv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306541710;
	Tue, 28 Nov 2023 09:54:50 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 412505C009E;
	Tue, 28 Nov 2023 12:54:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 Nov 2023 12:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1701194089; x=1701280489; bh=FjP7ejQHFE
	0z5ThOzRjLFxTQyIGpyVo9B05Q7w9eZpE=; b=FgQ9rBAeNZ0btzk/wx2ncsWp2b
	BPP5CDQ4I/RCQbLrznq924GuHcyGIMqctjjpp6uoWU9q8UjoxE+xxIYQddVUchvY
	6YZjofdT/M6Hq0TuisenRa6IpRtLTo2x1sQ3lOZ/UVn3s8wQ87wTXREV4I0t8HYp
	nTccLEz/aqTV1OJhj4khRZegn3sQsquOXqboNoyBxWrcQjpIvlkOG8/PQqBXoU0o
	s1FK5XUPvg6oK+BmAXg6KzSdknDtAgDz8LSLEYH6dh+/l/VHxnXoMNhOBHOt5ce4
	cHanTViTMcbo/6t9hN4MZxsNc7P13zfoVs/FDgYJZTAlpWEgdUKVia9eouxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701194089; x=1701280489; bh=FjP7ejQHFE0z5
	ThOzRjLFxTQyIGpyVo9B05Q7w9eZpE=; b=wGBILsJv5W9f56TAXM2r7CI+wXMWD
	JvFjad2ohIJAt/u1QplnXAhblqkIdF1VR4O1V6QZLtDF64ItOs3S5QsOj/gVZ3sF
	GfpCk+cTuRpQ5PrsYBTjZOcfFnEKNK4E8mKEJf6SkK0iHC7wweeHiK2xiJqkAhE0
	uIG5GtXnd5mPvDOcR/pG8Dsz/6qiH2FqB7eBrE8vo+omtFPuVKiDNxloJKpe+16A
	tReIJafyFoXBS+bQFZP1vT9hOeZuIg/y6wOZZ6/uUa1/NptiZwA30ahA5Wdapad7
	XInR5E0ftzStOY/gRpYK+aYDgiiwdmurfuH0EijVrX9Ahz0hndEnJvvRA==
X-ME-Sender: <xms:aClmZdV7vjRDSM3dt7DkssVxQwZmtBinoVL74hKtUn-ZPxmyVN-Pdg>
    <xme:aClmZdkzrr52FbHDzFLmL5QeTST_QswrhwZ01orZq8xpiGEPzc8x8GaYRMuvHPfVZ
    nf2hiXEtqAserWoAA>
X-ME-Received: <xmr:aClmZZZhLaSaM1LBCFyRU2Q0gJM4NSy3pDAmY4ZCa2AFWWgO_vTfoeEN4hxqkvDW-VE1ArvBn-w1vfiUdxu1ZiZk5Ox_3cZ1k9A5brf--IoKsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:aClmZQW9Kvw_AMEAedzkZ0LSJsdAnmhXAOHwwaO2vGMj01BwffF50w>
    <xmx:aClmZXm95JbzU-5jv4sLIMJIpKtCv46YIAxoC0HnF0sBIt5kJMCN7A>
    <xmx:aClmZdf-Edw2xh3eU1gk7PujVulbGZjoXOox7RjzA9UR9Jeybkdjjw>
    <xmx:aSlmZQgprf94_masvagbmK85pqD_LJYUEmm7PcBXA-TKlBL4upIzMw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 12:54:47 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: netdev@vger.kernel.org,
	llvm@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: devel@linux-ipsec.org
Subject: [PATCH ipsec-next v2 0/6] Add bpf_xdp_get_xfrm_state() kfunc
Date: Tue, 28 Nov 2023 10:54:20 -0700
Message-ID: <cover.1701193577.git.dxu@dxuuu.xyz>
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


Daniel Xu (6):
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
  libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: Move xfrm tunnel test to test_progs
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 +
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 128 +++++++++++++++
 tools/lib/bpf/bpf_core_read.h                 |  36 ++++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 155 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 138 +++++++++-------
 tools/testing/selftests/bpf/test_tunnel.sh    |  92 -----------
 9 files changed, 412 insertions(+), 150 deletions(-)
 create mode 100644 net/xfrm/xfrm_state_bpf.c

-- 
2.42.1


