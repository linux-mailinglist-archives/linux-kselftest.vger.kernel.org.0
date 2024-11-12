Return-Path: <linux-kselftest+bounces-21841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4556F9C4C8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 03:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061D92836A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 02:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A5B207A35;
	Tue, 12 Nov 2024 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="unl2x5gt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c0BSVeg5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A2205E08;
	Tue, 12 Nov 2024 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378303; cv=none; b=ALikbiZC1LA5SjOj48jrJ5shs+bAmVT+uk3qwhQFMdIRq2jcxxfVT9dUYm6cuueX1K7i0qb38ehRytKh/WK4CBZ50GxiNyzMm8z0jl4hLP+iJK7trN75q+EDXcG/fH5BtCTHyvhEg+Bu9GSfFyUIW0SQAR9mx6yb6/Yreb9nSbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378303; c=relaxed/simple;
	bh=UE3vj6R4b14gmnIic/V4MuJDC9lLf6MMJSEQ2nOuG7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcHDgtLWUo+b1X/ykn3nPaeSOR9DmAXz/906980XC1qikTebNCK+OzdcDw4DbVgHDI6mUdYrhVoEzh+hja5/cYc8ihVdVIk2CdZX0UrmOsBvKMeO3TSMbjyqRZ2VgviGzMppD4HlIrD8PjgPqtIfOHM4uIfl5QXlA3YDhFvg/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=unl2x5gt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c0BSVeg5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAD3511401E8;
	Mon, 11 Nov 2024 21:25:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 21:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731378300; x=
	1731464700; bh=sd0kI9SctekWnjOScuar49C2YSEhrmC/Es+ie4cWrqs=; b=u
	nl2x5gtx85ZO+wxrUEPRNkDBm13v28WX9uUk9dm/ullXa8NaOeYnhW4bDi2IsMDY
	iR/MKNOfyGFdYHTeOy6pbBr5gs4vFPmztRNJTucsSzKxDADMbVn3lxBlj7hNEVoK
	DuhziB0wU6zpgjhRzs1tn4ezb7p5KYb5HXLvBc69+LSgWuvqU9EaCfQE5hsJSa98
	j8IkS363wxL/Zs/GxwTriXL0D930T6GVt+0z2qu0zQ7UksQ5J9qjk9yL1WCFRoMW
	4/5RXYUjDt/eAQbVi87/GOAs4ezmu7aes44Yb8z94tQ6eE53r6+7bgxLyIoPsM2M
	GSiuwQSKLeE1Wy8qulfEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731378300; x=1731464700; bh=s
	d0kI9SctekWnjOScuar49C2YSEhrmC/Es+ie4cWrqs=; b=c0BSVeg5O8d1fk2kW
	AKIxjfzAMcyACi7H64/Putf7tDJ3bXecTEtl5KLWL2Obx/OJjyt37wUfeHaY5p8M
	IjjUXDVKUw1k4I8tJEBcbjdeklBID8+bIB+hi4SM5YBvZdJvREnV9XQVRMWbwCz7
	qOXoKrC98u/5vWKpRIlGi6eEKcs6QqWVh3I//maV0hYY/pr/Rx1nitCHkYyI7Oyh
	/VCmFgzfe1n3mgYrV21l2x+uoVkotsArlmN7nshDn/xWBkjWn4VZuewLjmsbXrit
	A40VBLwmJ6AAV4ib9RTNKb5R2Q2jSCcFiMXv97X7/eArffL1OvTZ8boOLEVW3nkO
	9zXlg==
X-ME-Sender: <xms:fLwyZxj0Qob77aJ__7O21Nb8yiklijlXciTjj_q8aw037FdHWFaUdA>
    <xme:fLwyZ2Ca5W-uyRbIiFg6g4tzrpmRd7n2P7DFyk32FiyBlhen-EJYjZallXVnfH1HL
    KEfJU6CTN5y6SVtkQ>
X-ME-Received: <xmr:fLwyZxFTVXW8mH5v5DJz1Wv1FEW1F-Se3YAuF0pMbskOYZelIO9SlvW-493lLmo0PZn6HWVnE364Os0EVaGS_cAc2HQfBmb9qJ-AYuYlvT_VpPRZOCh5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlrdgthhgrnhessg
    hrohgruggtohhmrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhig
    rdguvghvpdhrtghpthhtohepphgrvhgrnhdrtghhvggssghisegsrhhorggutghomhdrtg
    homh
X-ME-Proxy: <xmx:fLwyZ2QQhTRIeDXZzJPmhZmPpwoq4E_DxmS2ej409bs-StFfFDSY_w>
    <xmx:fLwyZ-yW1fnt63GxoIvZ19nAXQNbCFO_14Yi0F7vsZmygV1Gh__EUg>
    <xmx:fLwyZ87m_4-SwXN7i7whe1otPKb0VcbonBsCSu_E_XTsm1X2eylLZA>
    <xmx:fLwyZzzr1xX5JJCcjj7Yg2X6keU8gG7aiT7zEoOHLrd94s4QyJWwYQ>
    <xmx:fLwyZzKpv7rcYfGiSNPReWwtzn6zEtfFFxar9AlYh4ebzIH7FQuEh6gK>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 21:24:59 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	shuah@kernel.org,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	michael.chan@broadcom.com,
	martin.lau@linux.dev,
	pavan.chebbi@broadcom.com
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for ntuple rule
Date: Mon, 11 Nov 2024 19:23:31 -0700
Message-ID: <dc4398dfe9a8e959245d2a8ffe5c2fcefbdd67f7.1731377399.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1731377399.git.dxu@dxuuu.xyz>
References: <cover.1731377399.git.dxu@dxuuu.xyz>
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
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 29995586993c..4fa158f37155 100755
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
@@ -96,6 +97,14 @@ def _send_traffic_check(cfg, port, name, params):
                 f"traffic on inactive queues ({name}): " + str(cnts))
 
 
+def _ntuple_rule_check(cfg, rule_id, ctx_id):
+    """Check that ntuple rule references RSS context ID"""
+    text = ethtool(f"-n {cfg.ifname} rule {rule_id}").stdout
+    pattern = f"RSS Context ID: {ctx_id}"
+    ksft_true(re.search(pattern, text, re.IGNORECASE),
+              "RSS context not referenced in ntuple rule")
+
+
 def test_rss_key_indir(cfg):
     """Test basics like updating the main RSS key and indirection table."""
 
@@ -433,6 +442,8 @@ def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
         ntuple = ethtool_create(cfg, "-N", flow)
         defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
 
+        _ntuple_rule_check(cfg, ntuple, ctx_id)
+
     for i in range(ctx_cnt):
         _send_traffic_check(cfg, ports[i], f"context {i}",
                             { 'target': (2+i*2, 3+i*2),
-- 
2.46.0


