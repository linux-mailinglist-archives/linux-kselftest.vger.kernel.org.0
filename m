Return-Path: <linux-kselftest+bounces-22587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A99DAF77
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 23:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D326B163EF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 22:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720AC204F96;
	Wed, 27 Nov 2024 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="nMENH7Z/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JqAZHXEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8C204F72;
	Wed, 27 Nov 2024 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748331; cv=none; b=YFSv9/5euaad+qBIlr/vfKvPZm8VYw974XbyLwo99yy7uCE1h9ZqHMYYkj1kdCvY8EjaXSOhjRUjQeYC6yachsX+cvNAkSFiIDNh+Ym57KnXRcD1qdIUSCX0ZK72tJRrcR+ZaWqFacr3C7/RJfLiYARMvMvcTm46A0AU4HJrM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748331; c=relaxed/simple;
	bh=gTut2Bb70dTdxhqs0TnBAg+jX/uvcRTbJJ983vhcCAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lih6aWlETQgbSvGgmQjS8weFQm3ZVGLg/qCiQw64wd1D1wxZxknUrhnXU0ZT2p1N4gk5a90V83jlRpbgprNKgj+assbxIOxt2d08XpEz5If71ymKYak2vo/5cs0Eqfpl2uFMWgY1eFHjt09WQ1ZTY/f9qZIfOYNTHgldYMAtkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=nMENH7Z/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JqAZHXEf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A14D71140194;
	Wed, 27 Nov 2024 17:58:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 27 Nov 2024 17:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1732748328; x=
	1732834728; bh=7a9iua5Ya9R/+yjRYkgQYBjKtp939sLnstLb3lP7qNs=; b=n
	MENH7Z/aeURLcISorl7O733uBq1WLnlotjL6DapvY0Bcr92CCDv2FE5kYza0cFji
	2IHEQp2EvK3W9Gt7r5SyL89Aafh3OEWadMROMlrBlIxptBH/u+3pNbJVA9n8BDRe
	mdbGr4OxMau3xY0qg7eB3GcTwR/0N0jQxgKCD9ruEQnHmIX4dpjfOLW51tZdrJCr
	T5LPvH6JyZEy6pCUocUaBxs92gpn9mZbUAsMDzdRmq/oWBv6/Hg+KwEE+rJBU4Tt
	9egDnS5NZL557sqDgTPd/minI29cI2EgNkFRMCZgjI8Rdwz7/fkTZlvT2fxnlnxR
	ZwpGY55w1qTzCyfOvZQTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1732748328; x=1732834728; bh=7
	a9iua5Ya9R/+yjRYkgQYBjKtp939sLnstLb3lP7qNs=; b=JqAZHXEfGB8e6xr4r
	VrFze/1jLgVthZG44SSL6UNyN6fTEbb20TzSL4hOYMZfQX+GQsPB6Ivhkqa7TZLx
	aD+Dbcdk3A3oN+ALLUadkP3gI4tkse7X6HA+yqb1VRz61Py74Vpq/Dei53fwkeu/
	npbB4Um8ybiE47WUxpL3VPDqH7BEkBagN9b3dcpO83VOoKKAmSxBOIJxUjRTnj4D
	vUpPRJ+TTEFBaTpSYRMIt7RFHM665sApvrOLTgfuQOzXgKCnc2yrWddeETBAaf1L
	H6UjvJKolaNLP8aMHqd/QxzOfXzx84Y/LYbkr0BC2CQ6FZHmtpvr0bMKcR1lDHtt
	6hftg==
X-ME-Sender: <xms:KKRHZ93LREqKl3uZtKn5kd2Mtw7FmUz-zHbaZeu2E_9hXAcci57B5A>
    <xme:KKRHZ0F3JUzBxVfeeduvkMNVZmgSYs2QR0yS3M2QQleyJNaFWQcF287cCPlj4Ku6I
    JAlAQRx1VoykxKmzw>
X-ME-Received: <xmr:KKRHZ96EZFry0SPvj60V9S3H6c1QOvTTwnTBhow5jligjA_UlaNmGuEHQhr9kjSYHF5ZAsSUzGAP1VWZNzDfPCgvMI7sRBJUV6wBYE7MUCmw68Ixbqmi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlrdgthhgrnhessg
    hrohgruggtohhmrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhig
    rdguvghvpdhrtghpthhtohepphgrvhgrnhdrtghhvggssghisegsrhhorggutghomhdrtg
    homh
X-ME-Proxy: <xmx:KKRHZ61ytxHXb-FMBa4MBmlz2XwmIvj1aI5C-zniWhcKnq7UReYv-w>
    <xmx:KKRHZwEG41UwW6AO8ZxJ2bK1guBHbRhh0kRX8uAvOrZ58Opo7pGu5A>
    <xmx:KKRHZ78Q4XA5w-3UMun8h_4El68ZlRFwlv770Rri5b5tICKy-WZn9w>
    <xmx:KKRHZ9lMkcnWn8KwAiyaNmrqmZiMOPmTfncOD18RhAe1sNa_VFwGsw>
    <xmx:KKRHZ9d33pi135AXOyG99oSkd_Uf1WYS4x9ZrPJeUu-kBz5kr7qwKZOT>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 17:58:46 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	shuah@kernel.org,
	kuba@kernel.org,
	michael.chan@broadcom.com,
	martin.lau@linux.dev,
	pavan.chebbi@broadcom.com,
	ecree.xilinx@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net v3 2/2] selftests: drv-net: rss_ctx: Add test for ntuple rule
Date: Wed, 27 Nov 2024 15:58:30 -0700
Message-ID: <759870e430b7c93ecaae6e448f30a47284c59637.1732748253.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1732748253.git.dxu@dxuuu.xyz>
References: <cover.1732748253.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the rss_ctx test suite to test that an ntuple action that
redirects to an RSS context contains that information in `ethtool -n`.
Otherwise the output from ethtool is highly deceiving. This test helps
ensure drivers are compliant with the API.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 0b49ce7ae678..ca8a7edff3dd 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -3,7 +3,8 @@
 
 import datetime
 import random
-from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ne, ksft_ge, ksft_lt
+import re
+from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ne, ksft_ge, ksft_lt, ksft_true
 from lib.py import NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily
 from lib.py import KsftSkipEx, KsftFailEx
@@ -96,6 +97,13 @@ def _send_traffic_check(cfg, port, name, params):
                 f"traffic on inactive queues ({name}): " + str(cnts))
 
 
+def _ntuple_rule_check(cfg, rule_id, ctx_id):
+    """Check that ntuple rule references RSS context ID"""
+    text = ethtool(f"-n {cfg.ifname} rule {rule_id}").stdout
+    pattern = f"RSS Context (ID: )?{ctx_id}"
+    ksft_true(re.search(pattern, text), "RSS context not referenced in ntuple rule")
+
+
 def test_rss_key_indir(cfg):
     """Test basics like updating the main RSS key and indirection table."""
 
@@ -459,6 +467,8 @@ def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
         ntuple = ethtool_create(cfg, "-N", flow)
         defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
 
+        _ntuple_rule_check(cfg, ntuple, ctx_id)
+
     for i in range(ctx_cnt):
         _send_traffic_check(cfg, ports[i], f"context {i}",
                             { 'target': (2+i*2, 3+i*2),
-- 
2.46.0


