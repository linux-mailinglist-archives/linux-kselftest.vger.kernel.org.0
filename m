Return-Path: <linux-kselftest+bounces-11777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75439057F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2301C23425
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E41186E47;
	Wed, 12 Jun 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ng4Q4JRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jpj6nsGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963C186E24;
	Wed, 12 Jun 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207975; cv=none; b=c4BdOtblawXLcBAhT85UJTtkevhnU5SZb8cmupx/I9lC/U6L8v8pnV6BfEXrsLYi9kPA5hANyDmeCU9VGZLAQ+Zzt/KbaGt2xXYT9EDRbeAiSpjai7rp7By/iiZ+1czcBz/MtdhhRuYY4USEAJHxH9daNbK45Rna5KPup1sOThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207975; c=relaxed/simple;
	bh=8wcWIDJV9i7uVZzCddioETI3Y4rYvL9XxaTQ0tokYQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxifyPIIra/W4NNHDUuFkRjxLKTGBcY1W3F4ANuaZYp9kY2POIyI8DQZnbDXoDcrA/6UzFoFHl2MtQ4cZ383kLqS0wbYfnfYvgrx94+iAaPLRU/gCUsMAtVj5m8d3pQ7QER9BTuFx70REaY+wuDKFpk/Au2sBNIsfB4xV7h40ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ng4Q4JRj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jpj6nsGs; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id B1B932CC0180;
	Wed, 12 Jun 2024 11:59:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 12 Jun 2024 11:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207971; x=
	1718215171; bh=rw3uf/fg2XLXP7lcRjaOwMtzCT7fUDyYAtYnSUPZFmc=; b=n
	g4Q4JRjdnkfym/+aSZjd1RGZZ+vskkDnBVseuLOR1cXoX+3no3n9b2HUUYhVtCZm
	+nKpkXHgOR2ywogfI0idg+nln8cYcsvDAFJLzfWBqrCS0EvtK8rGjJKeZ+3IdUoJ
	v1vMZ/1puKsfL0CBx65gpz1a7pn5370VmAAGNL1nxcBAxKpBCFrhlH9KE3sPqB7F
	ENnpVFHUMDJL3mK4PKck1vIRaVnBQLD3QMZjZnlTL16PnEbo+dC8eVi6NAe8WdFa
	G79NODnlATgtjUrC1ss5aFWbPg0aH830yzWp2mtp284BhER/xvI+gU6F+izrkxFQ
	C9JO13KMv7AAQcvxlP5RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207971; x=
	1718215171; bh=rw3uf/fg2XLXP7lcRjaOwMtzCT7fUDyYAtYnSUPZFmc=; b=J
	pj6nsGsQcNpmpQA0zkMMQYHx6oebVCFRlhFOwXwbExRmBEHAhjoJuWdWr1/Ekk+p
	lSiscmKz8PDuyjfPRlEDAicBFFEhrl9SnFwFd2nhgwRCdGyiiiyaSYiQfREGbja7
	cWfq+XbdfzNppQhVfLjDiPFNDFuPwMI2zeg4T/GjJoVAyTyBpDB0w2TbYjT+lrKH
	ghjdNxh/lLidJ0XlP2A2KOo9MjjpOD+x5ghU28K1qkQTF7gxyJrgsegt6Ydblfvd
	uM6baI47SzUaM1tAk56NcinAiHRpeY6+6nLvGSCoyPuTCOQn9tjFOpizlfuPwSkJ
	zUrwO17Dvp/w+SL3rO/1g==
X-ME-Sender: <xms:48VpZp90qK2HiLXGUU8TzUWSXCif5jETKX0ExDck2z06MebNpIk6uQ>
    <xme:48VpZtudCvbt0wdslFhG4o8wqAmetr8BLaXtV9FE_4PmoPaNT_BbEkUiA7g9NxMUh
    WEsf9QprfePE4QAYw>
X-ME-Received: <xmr:48VpZnBQnLMatkbH4vi5eEItW2gS4Zu9qWePXK4Y0nwBtcq0i_WIrfoOl9hahSTIbZTu2RHT7gdhRC75zx4FkwxRwHORU2e0HjKVQVNj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:48VpZtdL9nWYf3Kea2zVhBvSZNatkbkdDikK_OB6N7dWj_p8MgAygg>
    <xmx:48VpZuM4eRqD3nLkaqbt5JkGfef715TyEXLbrGNCapQPXeODGlTtTg>
    <xmx:48VpZvnG4_ohNxEfmb75BB2kCfkLJ5D2r7UTUdi8JyPcF540NBYxlw>
    <xmx:48VpZov_6EXmjpPsH2R1QFPNj2r8efaKAowazSyqsn-2DDs47y2wEg>
    <xmx:48VpZlOXMsYj-IKMO46XIxccub8zJZd6I_6OzSlZNpMV64EEZR__-yKl>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:29 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kuba@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	eddyz87@gmail.com,
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
Subject: [PATCH bpf-next v5 10/12] bpf: selftests: nf: Opt out of using generated kfunc prototypes
Date: Wed, 12 Jun 2024 09:58:34 -0600
Message-ID: <044a5b10cb3abd0d71cb1c818ee0bfc4a2239332.1718207789.git.dxu@dxuuu.xyz>
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


