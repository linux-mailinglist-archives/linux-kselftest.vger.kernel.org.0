Return-Path: <linux-kselftest+bounces-454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C177F4F7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 19:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB9EB20CAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66B15ABBC;
	Wed, 22 Nov 2023 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="GS/APCbr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="szbLNXMR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445AEA2;
	Wed, 22 Nov 2023 10:21:02 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 1BD265C0131;
	Wed, 22 Nov 2023 13:20:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Nov 2023 13:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1700677259; x=1700763659; bh=IXy9hEwDva
	zgBgsi6N7DtR+e9WjAm48zXkbX44TGPGQ=; b=GS/APCbrMj2F3EvQBvMqdGxB0m
	lU0U2qu2WVG+6csf0xBpIO5GR+iNDvatl2UrLabMtjjV4grTi/KwB+nDDbDE4Wpk
	TG0yiDVlzA0iWJvFlG0ySYigTtNDCuaDckG6qAExIGYAdILqrWwHcJia3jyRcQnu
	dMxzbakbDjcI7gEhMVwyU9R/Xsl1TQHtuMw5bjV0mwXQk6bpQMZcYqyigWeb3s1T
	UzRbjGjSVgoo3MYrk5x+S6WhSlrKDLP06Y89J8Z0VsJ6wsflvG4vwSaS+vpvXdZk
	/aN2S/s+KDJ5S0hH1/GUVEpk4B/igL1YLnOJ5kBLDHlYnmiQSOO+T9oeqXgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700677259; x=1700763659; bh=IXy9hEwDvazgB
	gsi6N7DtR+e9WjAm48zXkbX44TGPGQ=; b=szbLNXMRsBV1JbaczpHNx3zsmIhnk
	QDSvv6xRx5oA2cCrseTNNyZ1C6ELqe3HwIuQu1HGuP+IZJSZGWRJZ3Heehfg6FHo
	pLCcGjeru4izEzhI0sR0feZLBbT6Ylm267D5/N+hvzl8f3XhaMDZgukhn7Tkkx3c
	UXNuYfTQy7YTctFi74/M69vsytdZIPQCu8Us6RUFCLKv2yIwb5a7AhCCaQXxxKzA
	hohTyG1AGg65vPg+lG20IJDOq+zfRt70Zj2PZhy74QpdrShEVZZqjlhsRpYTCykJ
	6BOJe/Rz8GPDuiFrHZCV1JjKdnIKnxKAMPqsqmhFg4zUdIXfWb1GZc+pQ==
X-ME-Sender: <xms:ikZeZRA69fsvHlD-91jJp8i6LSJdbtglycXyxoVF5mRExJeH6fMMJg>
    <xme:ikZeZfg0Skj4tRRhmSd4oXUjGY9YtHOe55HatmKxXcqRvzw8F1rMTHMqhkYKT8su-
    -QQjkIGg1w7hEQmYw>
X-ME-Received: <xmr:ikZeZcm1L0-GhzkPVLPqwS4rneerAoAKrzsGl8uZlDvTWCMsGWHxvyxHfZINy3xcNAWzeP87Yh0vaXwvCDJEXDZ4w47ufp4R7iF-FtaElos1AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ikZeZbxo0rz_iAxlkNzfSmPoqdGaN3jmI4b__fs_TpN-Au_A60T-nQ>
    <xmx:ikZeZWREQ0H-cS1AXfjDkgS6wr8RaOj8v9wsaPswJqk-3DFnoNS-4Q>
    <xmx:ikZeZeaSLH4Sxx2sVvoPhJsFKEsxJ5IzzI98YmR8lu41-H8IZphkMA>
    <xmx:i0ZeZVFDZd7eMFlnhBQZ_ZpJIu3iAsuW0I8M5hjyMDU5wNXaov9_EQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:20:57 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com
Cc: devel@linux-ipsec.org
Subject: [PATCH ipsec-next v1 0/7] Add bpf_xdp_get_xfrm_state() kfunc
Date: Wed, 22 Nov 2023 11:20:21 -0700
Message-ID: <cover.1700676682.git.dxu@dxuuu.xyz>
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

Changes from RFCv2:
* Rebased to ipsec-next
* Fix netns leak

Changes from RFCv1:
* Add Antony's commit tags
* Add KF_ACQUIRE and KF_RELEASE semantics

Daniel Xu (7):
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
  bpf: selftests: test_tunnel: Use ping -6 over ping6
  bpf: selftests: test_tunnel: Mount bpffs if necessary
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: test_tunnel: Disable CO-RE relocations
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 ++
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 127 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    |  98 ++++++++------
 tools/testing/selftests/bpf/test_tunnel.sh    |  43 ++++--
 7 files changed, 227 insertions(+), 54 deletions(-)
 create mode 100644 net/xfrm/xfrm_state_bpf.c

-- 
2.42.1


