Return-Path: <linux-kselftest+bounces-11503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E89013A1
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1FB22416
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A69674055;
	Sat,  8 Jun 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Qt2ZFZco";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIN54Bk8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B9B6F31D;
	Sat,  8 Jun 2024 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881427; cv=none; b=sGXI/u9Hwbmn80wyOGpFsM7xbNV1KqpeTY4NCRdG+qEF7WiRFQbDdJl6XVI8DTrGcuNwnZXydeTby+jnTcQ3y7KOR6zohK+ngFhjcu/xUT9t8sDrvmKviXptx/Ncam0XD3EjgNqAxTe74GdF+Yx0JEhfeHNLu3JosNtJKOTwRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881427; c=relaxed/simple;
	bh=TOFne6BN9+jp4V2XtWfmJB9qi/B/gw1rR+0HcAVMVvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnbZVct2Lf/7VRiGxrFyZzaFlyBBQIDR7j/X32Soxure5lCqj8ybApoDi4Y/MXzTpcwrp5si+YPcxLqXJ+4Kh7ALdy/LSVSJijZvQK7oyA1k4s631OJxM+qS4kEMYeIIRirh0GKVOq1u82ENhGjOoVG4yqNTSnFn/RNt4oC7gWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Qt2ZFZco; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIN54Bk8; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id D698C2CC0121;
	Sat,  8 Jun 2024 17:17:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 08 Jun 2024 17:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881423; x=
	1717888623; bh=NBRZD+tUpDA7hRgb1FdxgpatpLh/bjjqfKZS5VAHywE=; b=Q
	t2ZFZcoieHlaIp6SXK2XqhL/KrkGCqMkN+MnDLQxXc5Q0JP+PwWcnhoBcCEt3BPw
	+0epaVdMuyZz7F5dr6V+eJX3yEbvTZPgcE3nVkTDM2floiJvBNqtrCvzOc1Ujsmu
	netPRox+O5cZK/yadVT4Dbp9vgg350PqYJK1oO00N2GPN2HrJgJbC5qnCVcuy1nE
	OQ8VduoHt+hAUmHiwiylfC/ZcSVTNqCz4CZxYhLzt9UidND3GwMX9ckjItWdoBcL
	69JgLf13rhobypijpEmoqe5ozpNtWdRz99Tj8SfHNGZF+QEbszdqtnEWLJJgtSJS
	nf13Mrk+xh/x5pctEG6kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881423; x=
	1717888623; bh=NBRZD+tUpDA7hRgb1FdxgpatpLh/bjjqfKZS5VAHywE=; b=E
	IN54Bk8Is881T7yYbSg2jDeW4l1NVcSny1JbaM9XodDKsoXGl7ee+bOyjPac7V+2
	KNYfEukbIZjtqRrpFCh2e+zsPssVmeRv8u/nJqGXTpQMGxfl+FaR2q138j+qch2i
	4zIAuC1VouVrUhdRk74kAiTN3HTIfk4t4hQLW2hm8sWODvOYeat6D6l89UrMIRn5
	dTyC5qKS3GkKb9oGY0BmQPAvsFy2oZtBTc0p56WTqEPG9nUPsLu8hOjUSnpJWDtL
	E56ba8Bd6zBSFLPwCiUakgSW315SzMbDysQ1GfgNZ59Kb0GWJqzLNEE2BcsCgDlU
	yr44gpw0wBCvDUEEOmd0g==
X-ME-Sender: <xms:T8pkZiTypJKZdWiba5GpPXpU-8d3wAhEsgRU-ld0dgvtj6Mu6nwfzg>
    <xme:T8pkZnyN7VquzOQWHKQTdfcM_bGs-Ct9rCEvXjnlciJNjSuvERva1SWgSWGQyqV4L
    1-IUXT5B4n4aQSTZg>
X-ME-Received: <xmr:T8pkZv398hHX9CsqYqK6UO4n0q1lIlMDYyj7_Xog4ZX8eZdV6i82Ilpr4nMl3H9aRN9FL09N_qVeWPDIi1cqDVrEtUFAdGblwbz7Tzz2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:T8pkZuDexsRm1WLUmBTqzxpyVZbV5pYF0kRZBbMzt8d1UYJvB9dTpg>
    <xmx:T8pkZrjprWdYpiSIvXrI4SW8XBiojvkYMLKpRivZBL8D5_7RF0I9yw>
    <xmx:T8pkZqpvjuvH4-EIfLkp5v6GmlftR1_OneoFmsH9fIpGbst44pSreg>
    <xmx:T8pkZujYTRPSV57idhrqIJRmFLegDgyGiFbS_G2OW2k92__6CiM5rg>
    <xmx:T8pkZo0FnHBXvU2itoNHZm7AiPqpgkRszCMrIPBHYnT0p1yJOeHXZPo0>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:17:01 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 11/12] bpf: selftests: xfrm: Opt out of using generated kfunc prototypes
Date: Sat,  8 Jun 2024 15:16:07 -0600
Message-ID: <c7d70401a2d8f98bca9f06c7f79c0d8bd30eb773.1717881178.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717881178.git.dxu@dxuuu.xyz>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfrm_info selftest locally defines an aliased type such that folks
with CONFIG_XFRM_INTERFACE=m/n configs can still build the selftests.
See commit aa67961f3243 ("selftests/bpf: Allow building bpf tests with CONFIG_XFRM_INTERFACE=[m|n]").

Thus, it is simpler if this selftest opts out of using enerated kfunc
prototypes. The preprocessor macro this commit uses will be introduced
in the final commit.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/xfrm_info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/xfrm_info.c b/tools/testing/selftests/bpf/progs/xfrm_info.c
index f6a501fbba2b..a1d9f106c3f0 100644
--- a/tools/testing/selftests/bpf/progs/xfrm_info.c
+++ b/tools/testing/selftests/bpf/progs/xfrm_info.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define BPF_NO_KFUNC_PROTOTYPES
 #include "vmlinux.h"
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
-- 
2.44.0


