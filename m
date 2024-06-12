Return-Path: <linux-kselftest+bounces-11778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DAD9057FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47E41F2319E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CEA18754D;
	Wed, 12 Jun 2024 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="eliLoaVM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qwQrhihj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E12181326;
	Wed, 12 Jun 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207979; cv=none; b=f1Lfb4Qf/S5W/SBgwM44b5Vt0JABKzyuxmHNAhIPXDFLijgd4jX1D7d0DJDNezwK5PCX9T5Y4e6Wn8lFOU/s7gXZdzxLONm9ETn851IWLPqOA61XDYtAhJYx9N4Fo90RJyNQCKFFq+MY7Mf1t6wdrNaMC8yrx3Y6gM6wVkrFL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207979; c=relaxed/simple;
	bh=TOFne6BN9+jp4V2XtWfmJB9qi/B/gw1rR+0HcAVMVvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgagkjMRN1xaVEpwnWvkZboJFSl5XpG9cEPDzE5CobqyjMYbiotvlh+X7ue58ziVVHJ29kwR+xfs4Q6tTXbvzoa1JYU+g8F3V2IkDg7Sc8uxEdiscTDdchjqv04RMy4i6zl+4cS0Xlqp4mnBrUgtkFQspXCcqMxhQ/WHZn5VLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=eliLoaVM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qwQrhihj; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id B6A632CC0185;
	Wed, 12 Jun 2024 11:59:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 11:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207975; x=
	1718215175; bh=NBRZD+tUpDA7hRgb1FdxgpatpLh/bjjqfKZS5VAHywE=; b=e
	liLoaVMxelbRHSY2KNxUfr0Zo1ncwSpU167os0IehP62611Ica5yNxgOsy6b2u0r
	qkNIICdjCL07qV3atOKiEOFavpk6Cgq3d7T0z0WAjpIUlTt9nAd6hXU1JlTK7tGd
	dA58/fgxebPTqgldckWz4P2yZtxpQZRRdRQ7nuw4NH4SlirxspVR4mYYlAi+OUKV
	0JopmzxuSJDoxta+GVt9uvCUgYfiFN67N6gKX02L84dD4d+Vv3tJ15zF6CBMtpPD
	rrxQTwkGsg5vDh3RKqf6Q1KMwS1R4dWPPLu2JNDzkP77B5XPY2QqQoHaJjIU0Mk2
	Gibmoq1Jj1FQvb9QdjY5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207975; x=
	1718215175; bh=NBRZD+tUpDA7hRgb1FdxgpatpLh/bjjqfKZS5VAHywE=; b=q
	wQrhihjNJNCsMO9cB68oxmWZI1wHTCo8eqNR82BJn7A/BXLQ3dSQyq2Y5zdyM23X
	jEqbhijvpMWkfcrfuv4aesa6XeMvQkD027KSxYcs7b7i/LOIXsfuxK3bN7KLb15t
	oVbblELqsEvwnCEJWOa08kvXSOZlsEkiNTZS/q4wlv4PVUrE5dLXd/FHsYKUI/TH
	VKdiou4r6H2UFpmXlYXxRbwxBzcN9shNtTHc3aNW8N46LtaLjwfFmbe9++CUkBjj
	2nmQz4Yn0zL8/vEGctyC4QuyWjpNAHKOfn3vDtT78rloCGUXkOcrzNnSPUOz6MTY
	YB31RTWTrxiE/3/brlpSw==
X-ME-Sender: <xms:58VpZpw4YYYClFZq7KpXgY6mfudMguwO1biD6A47eJf3kqWJ7Gcpwg>
    <xme:58VpZpReB1BEWKDIXemXytc5yGzDDRxyYoRuziwlLov--MXOTo-n0qw8I77w3R6Bf
    FBFdOOvUPLq4fMvBw>
X-ME-Received: <xmr:58VpZjWV7DHMNhHpym8KK1NDXMOREuRscXeP5OgONHNp5RYyFxvUo7Mdnl9TJ3bObqreNsp5zY9HtgVM8Bu_J4pHfdP7ITwhc74lKKrC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:58VpZriRiJdFY7-ErDuYiukEUkXCXfQWzJlE1Os6-gEXh16ueuyxLQ>
    <xmx:58VpZrAf9VmcUjlXEplfPZ4hu571XFlchWTJB1Bg20OZ0CJYDcYvug>
    <xmx:58VpZkI6_d5I4trR4SamqHoFq_tBuOOL8OctPwbXdT5-f5wW9PF2sA>
    <xmx:58VpZqCrntc2x5aJda7tJCB4hqOsqTsDD-QdhPX6oYZY_dpobMDvBw>
    <xmx:58VpZiUhvUidVyA4wsEGl7iL_ik4IONVIGYI3nzGxk3n0ad86TCWmR_7>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:33 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 11/12] bpf: selftests: xfrm: Opt out of using generated kfunc prototypes
Date: Wed, 12 Jun 2024 09:58:35 -0600
Message-ID: <afe0bb1c50487f52542cdd5230c4aef9e36ce250.1718207789.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718207789.git.dxu@dxuuu.xyz>
References: <cover.1718207789.git.dxu@dxuuu.xyz>
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


