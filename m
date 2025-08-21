Return-Path: <linux-kselftest+bounces-39422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64437B2EAD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 03:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C375C80C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0707254AE7;
	Thu, 21 Aug 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6BY0s0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6524BCF5;
	Thu, 21 Aug 2025 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740429; cv=none; b=DfakyjQEeDq2LoptzqXC9LoP1SCTEKUj0aqEhfSId3QJfnjJvVNOH4/N6Dub9hB5gKKG8Cm4ncDL4hr8HsehaVzti6phHtFCst7SEVyqjWmBbz8qxKqHG7id1hSHi/kmomZx8rUwFTJ8vQADh5fzvzhQeZguykMLdYXFNgUV+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740429; c=relaxed/simple;
	bh=uhzKWyCyiA1m+shtPH3WdnKRamFzSONaLd/W2qqDqCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJ2loALbq50nOXBPCnNS7mp4CfJS8OKdv2/FjRgzuWHWNn0AdHlpzFZ5QMfvGTGJ2SrkEycdJ1E1odwMknEBbc+5N/T+YnnGybo/8VyRgYYsg/l0yAIawJ/W/fO4C5isI24L816uCzSnISXb1HPKTtbpaDEXw7H8OUWQ2QjNpXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6BY0s0V; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-435de764e08so327078b6e.1;
        Wed, 20 Aug 2025 18:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755740427; x=1756345227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvbGA0H91JWmHvvVG3YszRgAvVOajrD7LtGs+/8l+78=;
        b=O6BY0s0VFnSbTKyQxMrxvBZysm7ZCXtM9/1lBAQ8F/HR/Nsnbmed7K1egTEu7xxgvn
         0aMh6wB4dKBpj2qxAD0MI+hRFpJVUO+zy5m3Ri7aQ9tLJoszhD7FVJtySKSiU+xHmN/p
         BymW/z4hSEjs8t31ghVwdjAiuFK3EEsi0+86DFoPkyM0g4qqGVoQbV35lKHjUdSvvkY2
         22M66XPxONG8xurvvRQb1alQUKebGt0rU+jqalwCRz2MKYt+oZw/YKthV9L+u7M92CWB
         JFQemc6H16/iWM1IhZkiipK+/MnvZXnkYYv3Qsy3qsHd/G5Fru7DZV1dxnocBm7kt+78
         BItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755740427; x=1756345227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvbGA0H91JWmHvvVG3YszRgAvVOajrD7LtGs+/8l+78=;
        b=kwPv+p6RlP/CGmpdQIaL8FpGzSf31fkb6vfYk4WchYE1S/yoeuTMDe+HmVKKHCFxqc
         MdWFNyyzMQnh22EXzP4VYWj+r4Jmosw1k4hBQhfz74ZQSAC91gpLHR8BUZibnEmclXbc
         LZxjXoLkh540KoIU3BnwsrytEeeq+1uy92xNU1Q52qtxH7aI3UfTRtDppPMSngCrLBOO
         VBGSTK4cC3il7vi1fHqcADzg7zwOXUu5oAH6ofbjHa5VXIStCNo34NtioxWkC5nV4yMx
         /eZIcUbAG8ZN0WjmeZ24mxfp1tmZ6JigvGSoQt0k6BwY3Vlv1IX5KKmpHVNPr3/ZDsx6
         MzQA==
X-Forwarded-Encrypted: i=1; AJvYcCVaaEBzKMjV6Gb95dkeefPyLMRURFDC3zp0Fui/mDFduhvaVlAqHaiXpBwnohI5UrK0LDGyUGAkKMpYxCow6JA=@vger.kernel.org, AJvYcCXDYRHkLi5RentFwVAJkXJBxt5OVkA4GRIb6ilvl4E4cyxzO3mfouxgZuDjP88dMnyb7h+HYpjW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/dG2FfH0SXEPonG8seNrkyl7Et+sKa2J79w0di2KgLhRRiUJ
	WztdGKsP77wrb6p/sCnx1g5c8Egv6IzcEFi8T1aGCMT1bKj6G9xj7Bm8
X-Gm-Gg: ASbGnctrEWTDwY7Vz9pEqWUd0JC400PXfFmqJBl/E48nxX8tG7J1Xzexp202YDpBCy5
	FVGGw+pU9BzL+mJZvFl7AJ0VsS+Zn3ikOrJUrnBn9dhxXS1NAEL3M9WET4CNsmG9gHO1X/xmm0p
	xaks5Wcp5sZYE0qWdtaPtkIHseg52QM3yJLscMs+YPdo8SMPYylPl4whfsk3oiRYNfDBv4pKl0u
	F/BJtAGpV8X3O2Ax2gzOw7/6u9JN1gnkCQ0AMJJSXzLe2VJgvek6dFPzFKNGGrpA7L0EsFFkbNU
	ZJeI9MkLY4/VRnasQlr03+dUGX8DfEUesvNTSQoZ/zYNUAjT06Qb+LUwTBjVt66SkieWwPqY/DO
	Tv7OAgF9/3nH4kIfTLWJczcemRHkW
X-Google-Smtp-Source: AGHT+IF7GqWwzTIPKthIxY5iFNqjKd1QaUPAfG7I4GjLMZ2BJV2kiWVCrYaTR0o7AMvcspIE+u+i1g==
X-Received: by 2002:a05:6808:f16:b0:434:2d4:f198 with SMTP id 5614622812f47-4377d7be86amr310993b6e.31.1755740427386;
        Wed, 20 Aug 2025 18:40:27 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1e67d2sm3113461b6e.23.2025.08.20.18.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 18:40:27 -0700 (PDT)
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
Subject: [PATCH net-next 2/3] selftests: drv-net: xdp: Add a single-buffer XDP_TX test.
Date: Wed, 20 Aug 2025 18:40:22 -0700
Message-ID: <20250821014023.1481662-3-dimitri.daskalakis1@gmail.com>
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

Test single-buffer XDP_TX for packets with various payload sizes.
Update the socat TX command to generate packets with 0 length payloads.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index ea4da9024f9f..cea24c9b573e 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -314,8 +314,13 @@ def _test_xdp_native_tx(cfg, bpf_info, payload_lens):
 
         rx_udp = f"socat -{cfg.addr_ipver} -T 2 " + \
                  f"-u UDP-RECV:{port},reuseport STDOUT"
+
+        # Writing zero bytes to stdin gets ignored by socat,
+        # but with the shut-null flag socat generates a zero sized packet
+        # when the socket is closed.
+        tx_cmd_suffix = ",shut-null" if payload_len == 0 else ""
         tx_udp = f"echo -n {test_string} | socat -t 2 " + \
-                 f"-u STDIN UDP:{cfg.baddr}:{port}"
+                 f"-u STDIN UDP:{cfg.baddr}:{port}{tx_cmd_suffix}"
 
         with bkg(rx_udp, host=cfg.remote, exit_wait=True) as rnc:
             wait_port_listen(port, proto="udp", host=cfg.remote)
@@ -329,6 +334,21 @@ def _test_xdp_native_tx(cfg, bpf_info, payload_lens):
         ksft_eq(stats[XDPStats.TX.value], expected_pkts, "TX stats mismatch")
 
 
+def test_xdp_native_tx_sb(cfg):
+    """
+    Tests the XDP_TX action for a single-buff case.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    bpf_info = BPFProgInfo("xdp_prog", "xdp_native.bpf.o", "xdp", 1500)
+
+    # Ensure there's enough room for an ETH / IP / UDP header
+    pkt_hdr_len = 42 if cfg.addr_ipver == "4" else 62
+
+    _test_xdp_native_tx(cfg, bpf_info, [0, 1500 // 2, 1500 - pkt_hdr_len])
+
+
 def test_xdp_native_tx_mb(cfg):
     """
     Tests the XDP_TX action for a multi-buff case.
@@ -665,6 +685,7 @@ def main():
                 test_xdp_native_pass_mb,
                 test_xdp_native_drop_sb,
                 test_xdp_native_drop_mb,
+                test_xdp_native_tx_sb,
                 test_xdp_native_tx_mb,
                 test_xdp_native_adjst_tail_grow_data,
                 test_xdp_native_adjst_tail_shrnk_data,
-- 
2.47.3


