Return-Path: <linux-kselftest+bounces-39423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B172DB2EAE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 03:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9AC1CC1F96
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685324BCF5;
	Thu, 21 Aug 2025 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/z0PWX2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1424DD13;
	Thu, 21 Aug 2025 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740432; cv=none; b=cG0/uRij1jom/kRG99TeCfuPmRQiHuNbkuQTff+ATw5LNx9/Q1PxCUadpyVjDobJYloASHf/9ud+eIw//OuA4KJYdK41orDVWP9+wku3B+ESAiFptWo+5ZAqFXjqqnwMPd7RzcMp7xP4rsY1D9vRWsZD2nzGTmHtFWNKFFo/i1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740432; c=relaxed/simple;
	bh=2/Ji98n+9biEmGe8hMAjt2yrcBp0TOki9UhWKzNZwUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIvjAIC9GOHuimQGRUnA55L7FSGoiIJzcskR6iayiQ1xbzA93PGJ1ulVkixeZNVvOxGkfnM2z8DxccyekWZel4XAkrnoVnbqr3GGTO+Phf8of+7KqyP0Qw6dBKdiQb1NHIttbFipRbVYNjweJEq3Di5tYVoLuXpTPI6mtY+Zg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/z0PWX2; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74381fbc6e3so238060a34.2;
        Wed, 20 Aug 2025 18:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755740430; x=1756345230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffMwEcBx9ct7kHEiHkKdKByr+A8oa/d2MWsEjPSAViI=;
        b=G/z0PWX2BLeV/wty0e1WHKxFIJ8BMoZ5ARllAFVizNXkmHGmdIpoP9C7FimuPQjibO
         VEW4zLUYJ+IQ3yeRLsMdxq9Oj4AEtVxiv8QJBDIoDRVXU4PVgjkSCkDmaGDvLq0nFKou
         0GeDju0Bb6fa4Cq/0q6uA8ah2AQx7UPnm3TC+zXJ+7fxRarVuA8689SbogCB41j/n83l
         3K+lXdE1r90JUyZklQhe6WrkUDE/jcEM/e4MfSlEaA0+pNrF9PdfR30aM8L2Rw7hbK+g
         HI06v5o15hHcABRlbpluTyaIqdapLccGUdiPu2nB452xQx7uBhBLWHEeC4gxkEn7RWvb
         ZBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755740430; x=1756345230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffMwEcBx9ct7kHEiHkKdKByr+A8oa/d2MWsEjPSAViI=;
        b=xJatMwmUtzBlIY+GUl8nE+bfERX9Af17ojVYs4GS6Hz9rf/m0Mr8njyF2KErWOXh2K
         9vl9rvFrpg7snI3kdrGA2V1bOHhpDBKRkFZXp+p9pNFVbqbFeNtQZgw1JwPuHBUMi2VY
         vNbh+/lK0syyRSkqjNq2gabsYqKgeJJDYHEfRoVyjrc8c3Bxgh87kPXwDjTo+ptywSAA
         EwUZb6VhxjVNAW8zHcITqiMe09LuczM54uOkYFNwv7VGsoD7anOEiBcco8Z5JhBXPtmG
         Ojj1329I+UynwxVAiVKvvoZ02dPJtfb3MN9E1XR9giILYRT5UJMrkMA1vXO3S6U4WM0p
         aCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlHyvfyz6zoJa6k2GB8Ct6F+OcBdR4TQEVh+FsPkU0n7WuLjkZcQCMR6CWKh5EqatXh/18N/Xc@vger.kernel.org, AJvYcCXPxJ5COBI2BIPn/BaP9Jpd/h5YRN5XLXITsZ1WTspe6+4I/Rplo+oVAdHt2iMB2Je3uZQTD6k73ClwdoToB1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YydtDL0dLDyFgkjMP26izSApZY3QCzlDaN1D46E37aipeicWwUQ
	hF/pPCZmm+ZUERSLd1ru9uBYH111nKIq/eptUI/WA+3wfp+wdYNQKiZq
X-Gm-Gg: ASbGncufkfMoVsXOGNrgM5XrepHz5xO67K94VPjBY06CGakJ2iv6ZCP+xqDqjqm1wfV
	ag9e6gfUAsAs0rMBbC3h9o6jITNqAcxbRTSyU+mKukKtQo/cGt8lm9M4kJUbHXCxg6VJFNCWm8n
	sTD40ob12HnWVn+RidFmoKyFTOXnonk+WJn8v3ma9WHohF667P6CXS6I/6FEtkwJdmEgSmflOQJ
	SWRQn/JgesSUJr1XkFQ4kdjMsGR8DenYOSNqMWEMfboo4suFWudouqqUXENtGMaQCGHwpLpslvf
	MfQYK9p37M+C7fQw69dyAFMna4UsIpYD3tNEfHoXb45+mqbnwbeTvNwSEs03t0qnjycZ8ZSfgX2
	rF6B/+aNpS5dmxsiDSfKh65/krhBX
X-Google-Smtp-Source: AGHT+IEOqTl6q7f7xWCYSM3EWZU2gd7ZItEEXIfpkaJld7KQQisyt5KrQ2lHDf5v40HF0f+3BUFXFA==
X-Received: by 2002:a05:6808:1686:b0:435:6bc7:e747 with SMTP id 5614622812f47-4377d79b157mr305698b6e.37.1755740430034;
        Wed, 20 Aug 2025 18:40:30 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1e772dsm3160060b6e.24.2025.08.20.18.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 18:40:28 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 3/3] selftests: drv-net: xdp: Validate single-buff XDP_TX in multi-buff mode
Date: Wed, 20 Aug 2025 18:40:23 -0700
Message-ID: <20250821014023.1481662-4-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821014023.1481662-1-dimitri.daskalakis1@gmail.com>
References: <20250821014023.1481662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that drivers with multi-buff XDP programs properly reinitialize
xdp_buff between packets.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index cea24c9b573e..35e9495cd506 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -358,7 +358,10 @@ def test_xdp_native_tx_mb(cfg):
     """
     bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o",
                            "xdp.frags", 9000)
-    _test_xdp_native_tx(cfg, bpf_info, [8000])
+    # The first packet ensures we exercise the fragmented code path.
+    # And the subsequent 0-sized packet ensures the driver
+    # reinitializes xdp_buff correctly.
+    _test_xdp_native_tx(cfg, bpf_info, [8000, 0])
 
 
 def _validate_res(res, offset_lst, pkt_sz_lst):
-- 
2.47.3


