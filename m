Return-Path: <linux-kselftest+bounces-37895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F09B0FA76
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 20:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20E11CC33D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842B22D9F3;
	Wed, 23 Jul 2025 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7nH5Ijp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE32264B9;
	Wed, 23 Jul 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296466; cv=none; b=p5jh7ovymX/BoLLSJifjD9bCrlvH6NRkqFcRk6eMXMeurK/kLRM5rnp14sIS2Y1ZDgz5nGoIiw7KTzhZeuNXPj9IHMWGdTcxjc69+9BLlTo5LZy3a8APIfdrjAtyEVkTwHFjA1myKAn1qIJFYs7/A3grsNDiGvVq7F6Fc+77xsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296466; c=relaxed/simple;
	bh=g9/wOoQHg9dkZOlqepXYMEnTGXvVk9+BHLpYAdwnVfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7QiVhbZJFQ/1UC2z9MHOS0rbTJ5uTkI02havCcycxzxXF0u3IGV++YGS/QZDRUxWWGiUJLEkT+TfRvav9nDP5yOiZ0iuiENEQB5phiH7qOIuNtoRMZoxFAryk2iTNqgwQYazPbJ+tUOcHTt3vkCysNbeZZ0Cc8Eecc1MNhC+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7nH5Ijp; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e4043c5b7so2393987b3.1;
        Wed, 23 Jul 2025 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753296464; x=1753901264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMyLyZK4FRAE8c4WAEYz2AxmiFTTgtxOafXvlxiO9zc=;
        b=c7nH5IjpWUNQrwpE0BsR5UjxzPDJLhq/At8jbC4okihG5/HkwczvruI9fPxRPqEqL6
         uCM2GtsEsUl7RPnLTqZie2MCBB9qh6B+MNPIjs86H9wq1BkvcZkdRS02o56fI8rUCmDR
         wgYBF+ny5Eckjt/HnJWd92NDE0+Bve+xwwOfXCTVBrPnfzfNCeMIpmqDQDFRg3WM490O
         RJNDKpmaDhJj+LQx3YATU1qpTC9R1KL2laDQ7n0VAo2UEGNlWL60IzEE8j7SA6HCuQNK
         GOBn26N5NScWmNSxMNcwFJpok2C2EP9s+abfbNfgWd9GIdxD9rDsEHa9Oz42be9QaDjs
         rhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296464; x=1753901264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMyLyZK4FRAE8c4WAEYz2AxmiFTTgtxOafXvlxiO9zc=;
        b=mrs5WOjItSWLoT05piHKesDQRFyMfuaMzgz6/4Xm4YybHpVecVrlUOPpB691kvPm6I
         mhC91wDo8KkLNCiGK0+ibAdA1GK14IJnM4MBYX8iRwIE/8tJXMlQE2pThjiuGBNfg0mn
         o2GRfULxGTwSywG7Tt5kPy/rydL/Npyreh3SNCETjay3SoEdsmeHisIHd2vpnHEgpJ0n
         cxGda0mJbU1PmDA+S1WLs6UfN+/TsH/zZ/8xsLn8Xvdie6hzQnbaCXxDr8/Ulg+qiHHt
         8cwxWjmbiwQK3FW9j4INdDy1iaHKHfSG2mFzjeYGoKA6xFAxsOZaPUaOb7xqx5WFGvQ6
         D9tw==
X-Forwarded-Encrypted: i=1; AJvYcCWrzZbrZKN0ENNc6FHgVor+2zRdJd3O3hAzG0wr2EzUvdmzSP6A0En/fxPaGs2wBGVGJIEVHYIA@vger.kernel.org, AJvYcCXpmV6fhNZvBSb5MqLgM1PeMzOIlYEvhDbUxfQtWJH93MLSNK3pBU+zTn59/SRWyI3QhA/XOid1CDKuA2s9APE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfcO/Sx8TcKn2nAtvLNn7pE2toCtnzJYX2/IHudexayFEOgTpt
	4RitZ5vRhl5l/lssiyxjJPaa85PpkMNSVPmq1J+Tls+aUxB6p3rreAJv
X-Gm-Gg: ASbGncsVNGUINRcU3H0tDx9uAv9Xs5pkdSh3iIE+3djC/E7/k/wBZURDjOHaS6Yh/vZ
	7Nd+tcIMakVKk4cadJZ8isU3uGbnci/Xp5burTaMZDnb/2BfWovVkqKaJdM9K42a7sG/GIEv1wo
	oY2Z3COEHik8xranw18IM73BoYelAYhmh34L8MkNQR2ajLJiTHl5oi88114Ukh/bQdTRJ0uXeA6
	O2DgWLipFN9nRw53SrCqv/QWTGRdA9W7zTIw8N6B22M4ZaA7xpYLvwskBd7aW3jToJuDIQcx50H
	GieUUyMJKLcnFAWJgasYnYMz5p/4EPu5lRBYkIAVhllkQPVVCUZYr2rJzUP6Dca7tVpYjAW6p77
	pbj4y4/EL56J/Kjr+c1dj
X-Google-Smtp-Source: AGHT+IFIm5xwQM55KDFbyvZZAxshyKGuX+AI46yXYlQLFAUKzrEdwyc/niyynlVIbqoofYb/s81Tyw==
X-Received: by 2002:a05:690c:74c5:b0:717:bff8:4681 with SMTP id 00721157ae682-719b4226e73mr57637527b3.24.1753296464037;
        Wed, 23 Jul 2025 11:47:44 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71953141cbasm30634457b3.40.2025.07.23.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:47:43 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/3] selftests: drv-net: tso: fix vxlan tunnel flags to get correct gso_type
Date: Wed, 23 Jul 2025 11:47:37 -0700
Message-ID: <20250723184740.4075410-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723184740.4075410-1-daniel.zahka@gmail.com>
References: <20250723184740.4075410-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When vxlan is used with ipv6 as the outer network header, the correct
ip link parameters for acheiving the SKB_GSO_UDP_TUNNEL gso type is
"udp6zerocsumtx udp6zerocsumrx". Otherwise the gso type will be
SKB_GSO_UDP_TUNNEL_CSUM.

This bug was the reason for the second of the three possible
invocations of run_one_stream() invocations, so that can be deleted as
well. We only need to test with the feature off and on.

Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/hw/tso.py | 37 +++++++------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index f8386e3d88cd..6461a83b3d0e 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -102,7 +102,7 @@ def build_tunnel(cfg, outer_ipver, tun_info):
     remote_addr = cfg.remote_addr_v[outer_ipver]
 
     tun_type = tun_info[0]
-    tun_arg  = tun_info[2]
+    tun_arg  = tun_info[1]
     ip(f"link add {tun_type}-ksft type {tun_type} {tun_arg} local {local_addr} remote {remote_addr} dev {cfg.ifname}")
     defer(ip, f"link del {tun_type}-ksft")
     ip(f"link set dev {tun_type}-ksft up")
@@ -151,29 +151,17 @@ def test_builder(name, cfg, outer_ipver, feature, tun=None, inner_ipver=None):
             remote_v4 = cfg.remote_addr_v["4"]
             remote_v6 = cfg.remote_addr_v["6"]
 
-        tun_partial = tun and tun[1]
-        # Tunnel which can silently fall back to gso-partial
-        has_gso_partial = tun and 'tx-gso-partial' in cfg.hw_features
-
-        # For TSO4 via partial we need mangleid
-        if ipver == "4" and feature in cfg.partial_features:
-            ksft_pr("Testing with mangleid enabled")
-            if 'tx-tcp-mangleid-segmentation' not in cfg.hw_features:
-                ethtool(f"-K {cfg.ifname} tx-tcp-mangleid-segmentation on")
-                defer(ethtool, f"-K {cfg.ifname} tx-tcp-mangleid-segmentation off")
-
         # First test without the feature enabled.
         ethtool(f"-K {cfg.ifname} {feature} off")
-        if has_gso_partial:
-            ethtool(f"-K {cfg.ifname} tx-gso-partial off")
         run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso=False)
 
-        # Now test with the feature enabled.
-        # For compatible tunnels only - just GSO partial, not specific feature.
-        if has_gso_partial:
+        ethtool(f"-K {cfg.ifname} tx-gso-partial off")
+        ethtool(f"-K {cfg.ifname} tx-tcp-mangleid-segmentation off")
+        if feature in cfg.partial_features:
             ethtool(f"-K {cfg.ifname} tx-gso-partial on")
-            run_one_stream(cfg, ipver, remote_v4, remote_v6,
-                           should_lso=tun_partial)
+            if ipver == "4":
+                ksft_pr("Testing with mangleid enabled")
+                ethtool(f"-K {cfg.ifname} tx-tcp-mangleid-segmentation on")
 
         # Full feature enabled.
         ethtool(f"-K {cfg.ifname} {feature} on")
@@ -239,13 +227,14 @@ def main() -> None:
         query_nic_features(cfg)
 
         test_info = (
-            # name,       v4/v6  ethtool_feature              tun:(type,    partial, args)
+            # name,       v4/v6  ethtool_feature              tun:(type,     args)
             ("",            "4", "tx-tcp-segmentation",           None),
             ("",            "6", "tx-tcp6-segmentation",          None),
-            ("vxlan",        "", "tx-udp_tnl-segmentation",       ("vxlan",  True,  "id 100 dstport 4789 noudpcsum")),
-            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",  ("vxlan",  False, "id 100 dstport 4789 udpcsum")),
-            ("gre",         "4", "tx-gre-segmentation",           ("gre",    False,  "")),
-            ("gre",         "6", "tx-gre-segmentation",           ("ip6gre", False,  "")),
+            ("vxlan",       "4", "tx-udp_tnl-segmentation",       ("vxlan",  "id 100 dstport 4789 noudpcsum")),
+            ("vxlan",       "6", "tx-udp_tnl-segmentation",       ("vxlan",  "id 100 dstport 4789 udp6zerocsumtx udp6zerocsumrx")),
+            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",  ("vxlan",  "id 100 dstport 4789 udpcsum")),
+            ("gre",         "4", "tx-gre-segmentation",           ("gre",    "")),
+            ("gre",         "6", "tx-gre-segmentation",           ("ip6gre", "")),
         )
 
         cases = []
-- 
2.47.1


