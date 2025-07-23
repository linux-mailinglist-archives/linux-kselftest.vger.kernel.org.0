Return-Path: <linux-kselftest+bounces-37896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A71B0FA79
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 20:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E61175FB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC42922F772;
	Wed, 23 Jul 2025 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSP9VB64"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B70B22B8D9;
	Wed, 23 Jul 2025 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296467; cv=none; b=QVjZ97JbckGODFmhUPdpgbfpPcbW1pW3CVVZbMKFdsg3lfTCGerwxG0fuz7Irp4Dgo8i88UMa9mYz722WScLoGxpz73WcKVcodM01JWejPLqQWEv4pa3+3+u7KtBQ1moEZZEBSdANPNirM2J8nbWvY2DabJ91SoqiWG6o0A5yxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296467; c=relaxed/simple;
	bh=UEXLEJG+1Xgg/hkMbWHRUYQfocp0nxf9O4kmdCyF/LM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opB86H5tzIfyoGdW+bc+qTGfuuPv5xVsYf/u/9uxhbxjYgf0qQtGAYEtuVEWgwQxujse34M5lyxuR+GlZ0/miObSSA/CVu2nOHLhEK/3pV1SkbVV06ombcSo5grRbyHi80QOn1gdhx15h/mIdRcB8jIBa9/hVh6Sk/VANQVohZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSP9VB64; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e75668006b9so112598276.3;
        Wed, 23 Jul 2025 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753296465; x=1753901265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQ7FY2X9SoZnFYZvkOyMuYiIybjoZLyzq75QRcZH/lY=;
        b=ZSP9VB64ixGYyvV32nmiLfo/h/7O+HAmwxU/XWf7l6g1TPkZm5hHA+EI/xQ88/OUyb
         c3NwWC4eDzO4Eodvvr4LacaoCEWx5EoK+diQoQiHa2L3275Z6taBLa1eY2EuJ3GMAi42
         AIm0dm0eaycK2nuAcUjbiANRWqYHuQ1BHIw3ab5PvcL0banF72YMTMtFgR6Aq178oZzl
         6cxy6uByVf5fmv5r1SKv66SX9LmWEmTdM/e0oZmObmLm+2r3ZW1QK+g2oUEUXKdOBa8M
         akIh8apjV+DkIJIxDS0dUmuThhEtWAudqgAoOV4E9mMVlaZp+CWkbOTnGdoi3EmzdyEG
         KWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296465; x=1753901265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ7FY2X9SoZnFYZvkOyMuYiIybjoZLyzq75QRcZH/lY=;
        b=w6JeLJz6TI0BMwCFSz+4O6tlPKSehalFT55WfHJAZv8lcoL4m+/JWbDRB+mkhfi/IU
         NzpRcF19CujUnxfSSIWAn4XwYC8RWqofpcBY2jpaIPH67miG39trBNLrOPTKmE/K5JDI
         KOXxMrx0iiRP04ijbLemLStBm+QN3DwCQ3K3ToQVNi0gFj1uZs1wRubx/F5xfpood8bo
         co6R51PrKzzTuRj4UC5YD0oHomKdBdFOIf6VuIJOxJ/6qAdkvwpPVA9uWC/JnL9q/sW5
         2P/fhKU2G/RV8/R7e+kks4fiqDNr8yzFTnowlfjw6wPUZ7VgLaRSG/Qvjxy97KxuqOPV
         UXgw==
X-Forwarded-Encrypted: i=1; AJvYcCU4XG1a+YJgg5LGnJQpt6KTm9m0zufphdHuXIV27YCHM5Uz5/YVCYvrvCXL0Mwq135/u2DAXMH/ib4Z5lMhrfo=@vger.kernel.org, AJvYcCWnequdUKd31JhQBEGmSedpWc4MNYGkSZuv6Fx/muCJ50d5rVih+RkuDuFCDoDbSLoTDirEmbrd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb8LG6spfN0BG8ZaVU5zMQU3PYsLgL1MbG/U4RPrH+rx8RE7nn
	C+ZFSi8PtNBagB9pxKtYiQwReSzfoL1lHaEkEAZS/ByClNPhCRogljiNyMAm0w==
X-Gm-Gg: ASbGncvtq1W5LJZj52Gyy6PsB4s2kQp8+s7HPtA2U2oLTbQOnpzAffWfG2NDsnRA1nH
	+Cdidju0YksJCT1KXfG7GlfAD5zNP82Ue1o8bN/r0roBRex5JDdFnMI8wyFWUIgUiLBjhGhzwwK
	LfKDRp3BrwAYfVIfPUrfAwIITT0UFeNWHRxEtzdimgXuYZFuJAV3Xmy27VR3oENVYVDEsD3v2kz
	7qInhtnfb1mA26yLGxTqLToyCS1uvlA9Umwf43ebwe2xcUFqOgEEL555MdbilcVuwP6hgwE9UKG
	ZUfvaCXDi/aC3QM3ogU29mklZzj3TBDfDkPqvLlVTjm0Lfgtf/GOafFAY3GlVBTf0YtoLFGxruX
	KB8xn07Lt1YRicjuZvp0C
X-Google-Smtp-Source: AGHT+IHIVw+nIfo6IRSa7A9plDJ7N5VNHWtag9JcwwbLyGm6eiICivvXGre1meQYRqWdfjd4HuZCBQ==
X-Received: by 2002:a05:690c:6c86:b0:717:ca51:d781 with SMTP id 00721157ae682-719b4185488mr58422547b3.17.1753296465295;
        Wed, 23 Jul 2025 11:47:45 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195310af7esm30539437b3.15.2025.07.23.11.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:47:44 -0700 (PDT)
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
Subject: [PATCH net 3/3] selftests: drv-net: tso: fix non-tunneled tso6 test case name
Date: Wed, 23 Jul 2025 11:47:38 -0700
Message-ID: <20250723184740.4075410-4-daniel.zahka@gmail.com>
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

The non-tunneled tso6 test case was showing up as:
ok 8 tso.ipv4

This is because of the way test_builder() uses the inner_ipver arg in
test naming, and how test_info is iterated over in main(). Given that
some tunnels not supported yet, e.g. ipip or sit, only support ipv4 or
ipv6 as the inner network protocol, I think the best fix here is to
call test_builder() in separate branches for tunneled and non-tunneled
tests, and to make supported inner l3 types an explicit attribute of
tunnel test cases.

  # Detected qstat for LSO wire-packets
  TAP version 13
  1..14
  ok 1 tso.ipv4
  # Testing with mangleid enabled
  ok 2 tso.vxlan4_ipv4
  ok 3 tso.vxlan4_ipv6
  # Testing with mangleid enabled
  ok 4 tso.vxlan_csum4_ipv4
  ok 5 tso.vxlan_csum4_ipv6
  # Testing with mangleid enabled
  ok 6 tso.gre4_ipv4
  ok 7 tso.gre4_ipv6
  ok 8 tso.ipv6
  # Testing with mangleid enabled
  ok 9 tso.vxlan6_ipv4
  ok 10 tso.vxlan6_ipv6
  # Testing with mangleid enabled
  ok 11 tso.vxlan_csum6_ipv4
  ok 12 tso.vxlan_csum6_ipv6
  # Testing with mangleid enabled
  ok 13 tso.gre6_ipv4
  ok 14 tso.gre6_ipv6
  # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0

Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/hw/tso.py | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index 6461a83b3d0e..5fddb5056a20 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -227,14 +227,14 @@ def main() -> None:
         query_nic_features(cfg)
 
         test_info = (
-            # name,       v4/v6  ethtool_feature              tun:(type,     args)
-            ("",            "4", "tx-tcp-segmentation",           None),
-            ("",            "6", "tx-tcp6-segmentation",          None),
-            ("vxlan",       "4", "tx-udp_tnl-segmentation",       ("vxlan",  "id 100 dstport 4789 noudpcsum")),
-            ("vxlan",       "6", "tx-udp_tnl-segmentation",       ("vxlan",  "id 100 dstport 4789 udp6zerocsumtx udp6zerocsumrx")),
-            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",  ("vxlan",  "id 100 dstport 4789 udpcsum")),
-            ("gre",         "4", "tx-gre-segmentation",           ("gre",    "")),
-            ("gre",         "6", "tx-gre-segmentation",           ("ip6gre", "")),
+            # name,       v4/v6  ethtool_feature               tun:(type, args, inner ip versions)
+            ("",           "4", "tx-tcp-segmentation",         None),
+            ("",           "6", "tx-tcp6-segmentation",        None),
+            ("vxlan",      "4", "tx-udp_tnl-segmentation",     ("vxlan", "id 100 dstport 4789 noudpcsum", ("4", "6"))),
+            ("vxlan",      "6", "tx-udp_tnl-segmentation",     ("vxlan", "id 100 dstport 4789 udp6zerocsumtx udp6zerocsumrx", ("4", "6"))),
+            ("vxlan_csum", "", "tx-udp_tnl-csum-segmentation", ("vxlan", "id 100 dstport 4789 udpcsum", ("4", "6"))),
+            ("gre",        "4", "tx-gre-segmentation",         ("gre",   "", ("4", "6"))),
+            ("gre",        "6", "tx-gre-segmentation",         ("ip6gre","", ("4", "6"))),
         )
 
         cases = []
@@ -244,11 +244,13 @@ def main() -> None:
                 if info[1] and outer_ipver != info[1]:
                     continue
 
-                cases.append(test_builder(info[0], cfg, outer_ipver, info[2],
-                                          tun=info[3], inner_ipver="4"))
                 if info[3]:
-                    cases.append(test_builder(info[0], cfg, outer_ipver, info[2],
-                                              tun=info[3], inner_ipver="6"))
+                    cases += [
+                        test_builder(info[0], cfg, outer_ipver, info[2], info[3], inner_ipver)
+                        for inner_ipver in info[3][2]
+                    ]
+                else:
+                    cases.append(test_builder(info[0], cfg, outer_ipver, info[2], None, outer_ipver))
 
         ksft_run(cases=cases, args=(cfg, ))
     ksft_exit()
-- 
2.47.1


