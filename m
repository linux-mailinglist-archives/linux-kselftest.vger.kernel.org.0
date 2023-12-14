Return-Path: <linux-kselftest+bounces-1972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB62813DF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 00:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8444B2837C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 23:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFB46AB89;
	Thu, 14 Dec 2023 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="H5R9MNmL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RiYYGLAi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774EF66AC2;
	Thu, 14 Dec 2023 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 10BD53200AD1;
	Thu, 14 Dec 2023 17:56:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 14 Dec 2023 17:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1702594599; x=1702680999; bh=mAOtBUxiev8A1klFiszd1
	tSU2jSZmoDYflzMLZxURoo=; b=H5R9MNmL2zOf0n2xWsNYMU41KsDdpWzjXeRDj
	mvW9PKiduGR+64G1AB5NPGQmE+HgjjLZMKHxw8hK5HU/gISpr/y85tV2+K0PaJU/
	KMEGr476aQB+lcchXd5jDtx6bu517RnMTMWYtUOifiAQHt/uTcv3vFY5Iiau19i8
	15Ef/QSIAeulNlpxzFPU1HhMN1V5NQyHb7yvklfn7exuftT9NBYFgaBF2Mb8mNeb
	49BnkgvdgmsP75UIsQmedQ1neznrO1wmyaXyx1t1xvD74f/Js7Tr+AQGGcCwrlxt
	pfwNK82GfQ6iv3hMIgoaYQhPd4Px4vQ3sMvGrlMomC2FPBIgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702594599; x=1702680999; bh=mAOtBUxiev8A1klFiszd1tSU2jSZ
	moDYflzMLZxURoo=; b=RiYYGLAiuTtKuPBetHDYryXre7VYTFSn4Pyq3Iz+/ps4
	MmRQTcJ2p+LnzOhsDys9VfWQlqW3Lm//ViXw7kr6JwcnPEdyakiLyJs5LAUwwcnP
	734xUPatO0Xs+CoQtCnWnOdcHggwlgQz8e8mCUOQuZTfWKxV7PXmxg3V7WFOJRzJ
	Ahvj4WXrb3aMmFRQTZHyI+hri5z0g0iPyAMn/15wLTkir4hyu063UOVBXkFSVr1x
	bOWebBrPz2tZNctuTCI+DBphEpv+viNUE1RMEnz8R6MCp27EbMq80V5ykQQ/6yeq
	I3laUnvnQtOFq8Pu/deZm+CYvrhUQgI01Vnkd7nIbA==
X-ME-Sender: <xms:J4h7ZeQ3x4_KqAChIuQpfuN1ghoVPDcaZDFga_vRgjpPspSxAgDO4w>
    <xme:J4h7ZTzAL7ofxHg_hJIY4K3U-pFDfOd1eT5gWQKxJWy6Uf6sfdG6AshnPmX9j4Dwt
    yBt5HHB6cn3Xurp1g>
X-ME-Received: <xmr:J4h7Zb0Zu2OaS_zKRVW5QdBpSwvpWlHvwXpLS7-gXu29iq1D9VbJ3gRFJRLygXojHYqytIUwx4WuDmN_R9W0PdnhEFLNpK58fnL_4g2dh5lhAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:J4h7ZaAv6XT75HXL2LJ3xEi2FUVKYJwWwULe_456r-G9RW5reHbRHQ>
    <xmx:J4h7ZXjL1ivoEspBq-kq-U7m5S4c98JwQqBj6uZhIyCqjeatGRrhsg>
    <xmx:J4h7ZWoOyciAwECQuiUQfQ84kjRUdYihcWLF-86v6DR6E659t9bLeA>
    <xmx:J4h7ZUsX2ZJzhAxSOeQn4e0J2wFSMEr4Zqx4klVUzZ4gyVT7sGvF5A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 17:56:38 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/3] Various BPF exception improvements
Date: Thu, 14 Dec 2023 15:56:24 -0700
Message-ID: <cover.1702594357.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small improves to BPF exceptions in this patchset:

1. Allow throwing exceptions in XDP progs
2. Add some macros to help release references before throwing exceptions

Note the macros are intended to be temporary, at least until BPF
exception infra is able to automatically release acquired resources.

Daniel Xu (3):
  bpf: xdp: Register generic_kfunc_set with XDP programs
  bpf: selftests: Add bpf_assert_if() and bpf_assert_with_if() macros
  bpf: selftests: Test bpf_assert_if() and bpf_assert_with_if()

 kernel/bpf/helpers.c                          |  1 +
 .../testing/selftests/bpf/bpf_experimental.h  | 22 +++++++
 .../selftests/bpf/prog_tests/exceptions.c     |  5 ++
 .../testing/selftests/bpf/progs/exceptions.c  | 61 +++++++++++++++++++
 4 files changed, 89 insertions(+)

-- 
2.42.1


