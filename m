Return-Path: <linux-kselftest+bounces-19560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16DA99AB14
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 20:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA991F22404
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 18:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB11CF5DF;
	Fri, 11 Oct 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVt8ugzr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FDD1C8FB7;
	Fri, 11 Oct 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671798; cv=none; b=XZxLajIs0JGy9gqsxh+3lQRQUYFmYySrM+R7VlYHTd+qjVweSICzkj0e71fQ9Rlwt6aJFKbpbTtybguJ5SA0X9I90ac9ELmWkv4J/fzshxs5wW8HW3ujjpzq/7uOkYQ8UMYFJiJr824C6hj4c4sA/JCHAZStWo4xViu2oNpV0U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671798; c=relaxed/simple;
	bh=ayPciMWY//VbPSzpp2VbZbk7uWTZGaXOBvAeQgtBwzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK9TyZVgjo/RbdnZAOvVU/Sx8YWpbi2dHMfgJtnZSEk+MYOoTw8n7ARpGm1tijSDMeV4m9FL6ynF1D++lEPkovuMrZyI/uO4cwl7WafzEehbwI/0XoHfWnfMtKX9VMKR/tkT1ApUSpl55mW6LAd55Lvc21A3Yu3wpqKK9YAKJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVt8ugzr; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2346f164cso20646957b3.3;
        Fri, 11 Oct 2024 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728671796; x=1729276596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0I/3yItTQ/jGPmVdy1AuiludxZJFxBg01l9+u4Pb+Q=;
        b=kVt8ugzrwd7atyJPCNjar/NfIf9ojRW7BIob9BPt3/WPtqBdn+9S2baLwqHWWi1PJQ
         QMnNefGwqLgGJMIpDn9KSfvnRaBQTngUDKLc411Iw+MzY2yownih37xfMj/+90Bh3ZXR
         QWCOo1p3pWmvjqPL8tDvg4UEtus6JTll7upcibSg1i/H89ylCU1AYQR4Nur4qPJ9BqgE
         JwDKUyyNI4m0bVtIFIge21QTtfN/Wa2m3NxktSONNLHGsqBy3iDE7tXoaz/FudNs/gRg
         GvGVGbtoY6Dmw65/sIGPxJplGUibuZ9VSOSMloj/fHdqzGmICcPaqqdFwK3TCoqau5sr
         VVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671796; x=1729276596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0I/3yItTQ/jGPmVdy1AuiludxZJFxBg01l9+u4Pb+Q=;
        b=omLotlVWFkd86uhmEnRjOjgnLhSglI7dCg5Ac1aLjvuH7ypyCdiwCWkyNB7X+cnmYO
         /awhhs70z9EPPEd/1v+GueyLb5unmLCYKyWS+FyaieP8gAowDa/Dw7DMMZFvTzUjMlwV
         ekOtT//vgPlaf7t3TGqU1Nbv4ri1evb+jffrgzkQ0bLuEUG2L7NZyJZF7Rq/E3hYR8BT
         2bSlKiWhd/552stP3x1D949vHSTET0QBPeqj9WjRxDCKPJbECMOJVFHidF071EDC6hZk
         KMpCmOivWJKn1RB5RtzaK3zJqfeUfE+kHrteP8kpE87oofh+7CSV0NORB4pvn4BTl9H7
         +iIA==
X-Forwarded-Encrypted: i=1; AJvYcCUbUW0g2u+6llfpq2ipsVcv+0BLBMsWurXDfCb23c5FmtqPcnDt3IREdgNomoqZELmSDUiyzaT5tZ34CqWcvNVh@vger.kernel.org, AJvYcCV80AF13tVvjS73zc/Y3M8+IZrGd3MBcPzAJ8NW+dCpmXvUekYbME5sBJ7xnGGWPh8mUhGKdBbxg4BaQuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EtCHbFqDVXeLsCbqFQRrOjZF3YnRXp7I+vaCSSi1bglOf0DI
	/qsVwbBXKtI1v8aAMAHgXNnovfuTvkOUB9+B0JffKgfUlIoMGcKz
X-Google-Smtp-Source: AGHT+IEkRojL52hJwweCx2O+wUTzR4I5MkaqX2ww+MF8GrcLEe5MjWVwn/h2w/MXIKyB1CbvEhASEQ==
X-Received: by 2002:a05:690c:9c05:b0:6e2:2600:ed50 with SMTP id 00721157ae682-6e3479ca9dcmr38458547b3.21.1728671796308;
        Fri, 11 Oct 2024 11:36:36 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b83e8dsm6983997b3.33.2024.10.11.11.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:36:36 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: drv-net: rss_ctx: add rss ctx busy testcase
Date: Fri, 11 Oct 2024 11:35:48 -0700
Message-ID: <20241011183549.1581021-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241011183549.1581021-1-daniel.zahka@gmail.com>
References: <20241011183549.1581021-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should be invalid to delete an rss context while it is being
referenced from an ntuple filter. ethtool core should prevent this
from happening. This patch adds a testcase to verify this behavior.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 9d7adb3cf33b..29995586993c 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -6,7 +6,7 @@ import random
 from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ne, ksft_ge, ksft_lt
 from lib.py import NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily
-from lib.py import KsftSkipEx
+from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import rand_port
 from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
@@ -606,6 +606,33 @@ def test_rss_context_overlap2(cfg):
     test_rss_context_overlap(cfg, True)
 
 
+def test_delete_rss_context_busy(cfg):
+    """
+    Test that deletion returns -EBUSY when an rss context is being used
+    by an ntuple filter.
+    """
+
+    require_ntuple(cfg)
+
+    # create additional rss context
+    ctx_id = ethtool_create(cfg, "-X", "context new")
+    ctx_deleter = defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
+
+    # utilize context from ntuple filter
+    port = rand_port()
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
+    ntuple_id = ethtool_create(cfg, "-N", flow)
+    defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
+
+    # attempt to delete in-use context
+    try:
+        ctx_deleter.exec_only()
+        ctx_deleter.cancel()
+        raise KsftFailEx(f"deleted context {ctx_id} used by rule {ntuple_id}")
+    except CmdExitFailure:
+        pass
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.ethnl = EthtoolFamily()
@@ -616,7 +643,8 @@ def main() -> None:
                   test_rss_context, test_rss_context4, test_rss_context32,
                   test_rss_context_dump, test_rss_context_queue_reconfigure,
                   test_rss_context_overlap, test_rss_context_overlap2,
-                  test_rss_context_out_of_order, test_rss_context4_create_with_cfg],
+                  test_rss_context_out_of_order, test_rss_context4_create_with_cfg,
+                  test_delete_rss_context_busy],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.43.5


