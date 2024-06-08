Return-Path: <linux-kselftest+bounces-11502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C490139E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A211F210B5
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC406F2F4;
	Sat,  8 Jun 2024 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="CcNV3p3s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="If4OpJ7u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7816F2E8;
	Sat,  8 Jun 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881423; cv=none; b=ny2k8WamZQfrv9x0V50kIZ3MrFWIE7Upq6wTp9nO71OTInrjwMNByKyYOax5Gr/ow3Nnxw2Z/cTc6/Tut9yG/VZQpIyeZ43pnj9htHLcSGm+ndvMKfbBldnyYb+0T6GdGJm7pfxBKPrQ7rxMB7d/P06ciA15aOId3XuPJ677Kg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881423; c=relaxed/simple;
	bh=8wcWIDJV9i7uVZzCddioETI3Y4rYvL9XxaTQ0tokYQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boc2WpQ7dUs+e4Dt7DmsrQuXfB28nQ7GgfwwhtZPv/ilOfzuFtEnmifi67zirqXse8qtJdPpWbbPrbnqSVGF8n75bGFvOLDRjkj8pwNgoFp3Mph35zHQDufMZ+TwKWdN/JuXt2TabGwZj8CmGzKystsDHE94rc9Kubi6SzISmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=CcNV3p3s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=If4OpJ7u; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id E2B9F2CC011E;
	Sat,  8 Jun 2024 17:16:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 08 Jun 2024 17:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881419; x=
	1717888619; bh=rw3uf/fg2XLXP7lcRjaOwMtzCT7fUDyYAtYnSUPZFmc=; b=C
	cNV3p3s/eWMl4UxvEduML/8284ozg7gEr+LqFFxTgKt626JgTKZv5aqC1PpUuB0M
	sx3Y2L65Ui95N55JTVibsrz5NHmEcg7V3DNuRfNvpYKlFS9ZNNnULcImQC2vVMDT
	TJDPfLX+bQyfZVdANpmkVDRWh4aqFR/X/4Dh84CCXJ0CGYYpxSv2eHhJ62rfdl60
	COKChuVlk9pxoTWZhrn9mFCFY0yPz6WN3htAjGoY2S5Gejk1yxqoXzx4+b4WsxQo
	IEQnWKqsi+kV8+6SeB3cfF4QBaGeYNDPex2Q2bQ3ooIw5jAAtbLiJbLLAetTYZP9
	pUPnIcJZBWL7nbXgcMWTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881419; x=
	1717888619; bh=rw3uf/fg2XLXP7lcRjaOwMtzCT7fUDyYAtYnSUPZFmc=; b=I
	f4OpJ7uXjgE5l3MczCb0iCGduhsABFoZ9QLrnYQzGQpl6MaJ0utIraGTwQ4eG88N
	a80Pc9BxYqYXopLs6oXI5S3Ej2yxy9h11NkzC+C6jmGcxUNyFiG1f7PczOkG0/v1
	sIdiPgokpT11FffLskjSXuIHnM1ADDLCPY3CTbqB3ammHAOqCuTK4yGvCycMbfqu
	2E+0kK93fET/sng9yz22nxnZowQ5g6rJ5VGO2+XNQx6RLtm8QeRaaDDtrnB6hu2v
	/biQVnQerjEfu7BKJ2IskFt5P0NWgHaBShx7xCg3PiSDSANk4p4F/yhnfn6irsNp
	CTE5UI8Dxco9c2BqsRpuw==
X-ME-Sender: <xms:S8pkZgR74Y-nPsQ7528Mpp5JOfo_OAc4bEQyolrR2LJt0FrzFxVJmA>
    <xme:S8pkZtwULf9ZzxbskimXoWnRE08GA2bPsh_kLnK00eU_poI-9x5nZbQMjlSDvjmbL
    vn-gkrmbcqsbccLVA>
X-ME-Received: <xmr:S8pkZt3hHyEYihgb2J7hwzy--2zAFywU0DBju_ntTHO2tMSjU6XPHNniF3y90-4oT_ai96nZEOrDKy4HlbQqbsIsVFW17b8qgJq1IG6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:S8pkZkAlH-L4EGydtSKoUsf9q_ddwn6_l0TQw1euEenpwvjEZePkAg>
    <xmx:S8pkZpgg_lVZatuxjU2M1FR0qYdn4IuOWji1mozotZynHG1uoOwVpQ>
    <xmx:S8pkZgoNg0u9WwgG6Gaxetr5INzc12xaBylD4xe5GkbhT7rt42dkyg>
    <xmx:S8pkZsgaWQj3N5gCXUHEr5HtvMzdVUYGAMpu0dvT8PteNacuoUPYYw>
    <xmx:S8pkZtSiyQfMEQpRiN3WL2cydsgir0Q9gFbENhL20mmMhGBRMaXmJolX>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:57 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	davem@davemloft.net,
	daniel@iogearbox.net,
	hawk@kernel.org,
	kuba@kernel.org,
	john.fastabend@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 10/12] bpf: selftests: nf: Opt out of using generated kfunc prototypes
Date: Sat,  8 Jun 2024 15:16:06 -0600
Message-ID: <a36578b8d1534833dce0d1379fd696bf3ed41bfa.1717881178.git.dxu@dxuuu.xyz>
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

The bpf-nf selftests play various games with aliased types such that
folks with CONFIG_NF_CONNTRACK=m/n configs can still build the
selftests. See commits:

1058b6a78db2 ("selftests/bpf: Do not fail build if CONFIG_NF_CONNTRACK=m/n")
92afc5329a5b ("selftests/bpf: Fix build errors if CONFIG_NF_CONNTRACK=m")

Thus, it is simpler if these selftests opt out of using generated kfunc
prototypes. The preprocessor macro this commit uses will be introduced
in the final commit.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/test_bpf_nf.c       | 1 +
 tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c  | 1 +
 tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 0289d8ce2b80..f7b330ddd007 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define BPF_NO_KFUNC_PROTOTYPES
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c b/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
index 0e4759ab38ff..a586f087ffeb 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf_fail.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define BPF_NO_KFUNC_PROTOTYPES
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index 7ea9785738b5..f8f5dc9f72b8 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
+#define BPF_NO_KFUNC_PROTOTYPES
 #include "vmlinux.h"
 
 #include <bpf/bpf_helpers.h>
-- 
2.44.0


