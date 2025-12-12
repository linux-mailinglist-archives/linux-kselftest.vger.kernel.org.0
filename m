Return-Path: <linux-kselftest+bounces-47510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78ACB9057
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 15:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 259853050CD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379B2E8DE2;
	Fri, 12 Dec 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="k1O/WETs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDB26CE33
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551513; cv=none; b=dtHppvPykN+xbVoGnB+NhiReXMv2apYzcjtdjvCmcAyOD3rxJyL7FgvKnQtWZFT4/sMinaabDGgEYdaXvxo/Swy2qsANZ7OHjkGmrVVJGI0q3xedJywU+6OWzyu9UitmseLbHwnpgBITmTphPPjnSrevIUc9NjE9CQXdLnqTHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551513; c=relaxed/simple;
	bh=lEOPbLZ8iK9A4EcSY6GtElHcm2Z2lNDMRR0j2H3qVSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxCQMvg7lPCG7HSAXnl2ihTk3r/vv3UzO7PnNTXYnG9e6SgaZFxcT14ZqqlCD4bMYxKnANzw1ZKYKxcaCKvw0h8GJylwa6uIlK/o0QfNEX7fN2GQdmFTW2IDm7LjR9f4Yw1FMW2cBtf4XrencJTsbkqZx02Aj2dSpmkM55Ucam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=k1O/WETs; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BCC73FB53
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765550985;
	bh=EoivPywf7QXsLeTHC8lXLQ+O9tet6+0xD7qUCbPDZtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=k1O/WETss1W1yE0mVYBu1vv2xO6Cor2Jei/t/Uyk9GXHVmXwsyDX/sWT65+Q4ttTP
	 FXCKmJ5wIZFi9sVQey88GDU/16M2wkScI3ceLvzNWLznSELLRzbFR23sHRdCIxZyzp
	 UrQi7sh3l88UMvHcgda3kACec188TDgkW7JKR7yIRj8rCvxvZUC1vTn/iV3pylTqvs
	 oFmvl3Z23NHEdPSR3503joz1QsXu2HX0zTzj6dkV6haccck/3mtVlEDUhgZioFhG0D
	 gpR6KZr07qSLI2a5miuvoyWO8mp/G9g5+uylnLyEMSkPMMsW76stt0Od9Fu/CQq+Zg
	 IwjGDA7lawRaI+Jj0iCZJ/ti4+v0+gZAW0BQUdV6JsPcdnzi6fXp2mUJlEsie+N13n
	 l1xVHru+BHJ/INJHrZ3V9m2oiBhLeRybKbykgZd0L2D/ufaR9A/5IQkAKc5Del5wdU
	 81yfuBuv+CqA5KFxuhAp7QVlQnl72WHGjOR02phakgPHlv9qTSx5mG19ABfj0AHZis
	 g0wb/k1aznfEAYHSjOE9131xynZA7fqmv8vp515Ghah45U5XxYDXCTJwCodv2u3q/k
	 g4gqmFNG6AHBZ0qi6YXVZqg9zCcodmJ0bmGc7hop5CjbKNl65DaGeFFQtzcqbFMyOe
	 CC+VZM8kJ5yHRyfmya3FowBk=
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8824d5b11easo23596756d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 06:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765550984; x=1766155784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoivPywf7QXsLeTHC8lXLQ+O9tet6+0xD7qUCbPDZtM=;
        b=GdGEC1O0cNvulrtThhoJbXkO5txCJVSAAYHnkUFtqo4tKhFW5GtSwn5Qa4vmEOo0QC
         uCFpYL3y1PmglxhII9u+c7WS4XqjRtF92eV6kf/keS27dG8JSbrPAIr1zaJYPXanZ8NG
         c5NFQTdfnZxaK56femrTTz3h2rLqS4ViHKvKbdbfMs37AEjIaevAMkMaYdY2dDT9D6e9
         dj1STXk2rMGcu6oIiBcS6bEK37Jj7aZcKfZW496866oJ7l6vpm1dBul0ilfUnlqKJS9U
         fCXt6Qn1bXoIB6thtOmGpZ298GViYlrrFgACgwhxjcEJdGQXw5qVQRkuSMQwL117EHkP
         rPQw==
X-Gm-Message-State: AOJu0YziF4eRgyD1XeQb9QsYYcQESVgy0I+UZ/ON80WVVA2TBXXbtEam
	Wmvky3BSRffEuMKE4RmWL7HMAGzOAdezGSyOCFy3fdo/tLdmOAcryjOQsKPNyNgil9/j2qtC7VW
	IDPwhylR33aGPX+AhxXDKDB8CFYG5KPvlCWEWMUbdIocJ6dvDkpMKTiP04EFDaMO9IClRQbWntn
	xBL5Fmux6yeE2pDzbgYw==
X-Gm-Gg: AY/fxX5OElb8LOeYJ2ChyUaqX5odSwDlrZf+8eqLAfEhVAqtvp06AnLBTfLOweRoy+8
	xUe1qGC7zi7INSyBOqFS+S+9SzLQ4hj/Rmeq7ByGT/BUe32lp+kqIfSiZvt9VdhOcdD0hmJSNLQ
	pfwud0FNtfNxv7ZDPAhUmS30OLp4C+B0hnJCza4fsshPQtLGa0hgxKCDtQT4pTbkHgPWaCr8k0K
	jA9fCm5KHj2CcQd1c9YTT4iJtap00MJDAOb1Ik7JBUPkcFlkz9XsZUQEw7fLPfZj6Yqcn21YF3z
	n6ASjyvNF5r6nQbV8JQiTvgg/8ESly2uRRNexVW70ec7kRd4Mcy8OmFC3ppMDIOmbGXFoifLTUH
	Ks0X4SsfICjDbr1wX+Pdm6zDlRa9c11zJ+VGk6xGgRGWdDIZP5gd8VrZa3cx++KRp
X-Received: by 2002:a05:6214:5b89:b0:888:633f:391e with SMTP id 6a1803df08f44-8887e46e988mr31021176d6.67.1765550983617;
        Fri, 12 Dec 2025 06:49:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9wmfgV3BJqpriF+99pAJs5NZio3o6jMd/99nKRfDWX1FmNlTIdtjSoVnEpsZJII6jI8LPjQ==
X-Received: by 2002:a05:6214:5b89:b0:888:633f:391e with SMTP id 6a1803df08f44-8887e46e988mr31020866d6.67.1765550983276;
        Fri, 12 Dec 2025 06:49:43 -0800 (PST)
Received: from localhost (modemcable137.35-177-173.mc.videotron.ca. [173.177.35.137])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-888818cd87asm12157646d6.30.2025.12.12.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 06:49:42 -0800 (PST)
From: "Alice C. Munduruca" <alice.munduruca@canonical.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	"Alice C. Munduruca" <alice.munduruca@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2] selftests: net: fix "buffer overflow detected" for tap.c
Date: Fri, 12 Dec 2025 09:49:21 -0500
Message-ID: <20251212144921.16915-1-alice.munduruca@canonical.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the selftest 'tap.c' is compiled with '-D_FORTIFY_SOURCE=3', the
strcpy() in rtattr_add_strsz() is replaced with a checked version which
causes the test to consistently fail when compiled with toolchains for
which this option is enabled by default.

 TAP version 13
 1..3
 # Starting 3 tests from 1 test cases.
 #  RUN           tap.test_packet_valid_udp_gso ...
 *** buffer overflow detected ***: terminated
 # test_packet_valid_udp_gso: Test terminated by assertion
 #          FAIL  tap.test_packet_valid_udp_gso
 not ok 1 tap.test_packet_valid_udp_gso
 #  RUN           tap.test_packet_valid_udp_csum ...
 *** buffer overflow detected ***: terminated
 # test_packet_valid_udp_csum: Test terminated by assertion
 #          FAIL  tap.test_packet_valid_udp_csum
 not ok 2 tap.test_packet_valid_udp_csum
 #  RUN           tap.test_packet_crash_tap_invalid_eth_proto ...
 *** buffer overflow detected ***: terminated
 # test_packet_crash_tap_invalid_eth_proto: Test terminated by assertion
 #          FAIL  tap.test_packet_crash_tap_invalid_eth_proto
 not ok 3 tap.test_packet_crash_tap_invalid_eth_proto
 # FAILED: 0 / 3 tests passed.
 # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0

A buffer overflow is detected by the fortified glibc __strcpy_chk()
since the __builtin_object_size() of `RTA_DATA(rta)` is incorrectly
reported as 1, even though there is ample space in its bounding buffer
`req`.

Using the unchecked function memcpy() here instead allows us to match
the way rtattr_add_str() is written while avoiding the spurious test
failure.

Fixes: 2e64fe4624d1 ("selftests: add few test cases for tap driver")
Signed-off-by: Alice C. Munduruca <alice.munduruca@canonical.com>
---
 tools/testing/selftests/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..dd961b629295 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -67,7 +67,7 @@ static struct rtattr *rtattr_add_strsz(struct nlmsghdr *nh, unsigned short type,
 {
 	struct rtattr *rta = rtattr_add(nh, type, strlen(s) + 1);
 
-	strcpy(RTA_DATA(rta), s);
+	memcpy(RTA_DATA(rta), s, strlen(s) + 1);
 	return rta;
 }
 
-- 
2.48.1


