Return-Path: <linux-kselftest+bounces-46794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE75C96A8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 11:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4612A3A2C12
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF1E306B21;
	Mon,  1 Dec 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFjvC3xT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0930597B
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584936; cv=none; b=ovpX6cJlZ8h9JsgHCSl6hyzjscC6k9AfKmdpI4pzUSqOXY8JqFqs5PkMYg3U+pZv2MVkWxkyuNvvscFgE3vaxdBcw8Bk6E1efr4s5mXvIIyyXXbOo126xdMN4unfbtyW9F2WkPfo4WjE1I1zqLMsst74NVTa7wzkz7cb92vshNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584936; c=relaxed/simple;
	bh=p8nrLd8JgHXvBOx3nRAE8e12DQJPDzMeaIvncxSjwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rylEw4QpbsL1EKPnwgvdqdQTh9pNwLjjw89WqN2b8OUbsO5+FnFSXSWzD/ceHbxQDHw1qDgsGUdpRY1aTKo+a5Gn59zv6PqczlfiQRXYLH4dFF2LFI31/1sU3xQYAkXwOGTRGbaIBaQJyy36wE0e0lhEQSOy8mHNwCd6JqEc3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFjvC3xT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so254140a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 02:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764584933; x=1765189733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygDjwJpJeLSApr9Yk+KRSHapU8CeVBWTNC852WoTWfU=;
        b=VFjvC3xTsWBsSA3KGtfWnloKFemE07SRzAyOjU8np52KCeAkkWa2PbqaiSJz1BrrEH
         +VO9EmVORcXr+VPb1jKlX4yIJH29fNyb54aTvDXf+SWN5KYZGaGPfkQVqEUu9WhBfkrX
         chHDBgx1MWjYQ6tqjZIhMuME6/y0YKM4Zkbl+XP9liali0AuStphCEVSSynfItZ9H0aV
         qTSSm6HGMzn1KYhN1CYGsuENe8gNI9qrG1TBYMPaVkmp/A0LFQ2uQUNS7UPi6WUFV6Q9
         cnqEKaVkvhyPyLznv1NypGT3LoP6EGzK86oqxpQNLFjK4B1yaRtsXyTr0dVj48rfAJVb
         kXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764584933; x=1765189733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygDjwJpJeLSApr9Yk+KRSHapU8CeVBWTNC852WoTWfU=;
        b=eeuKrEAichsRV93ZuWmCF2/nJkYyegvZC0P04dR3KyV3xgM6jyMUgA5XRA2BxY3sNo
         kEJ/kWAFrNpAMiOEToR3DVNa4fsJ2vncsZBjZrBTZblzIqD99B/tcc/rIzvE8I50YN+j
         EW7wnjomKNmwhotn+wObAQccizrXXdy9FC6AGzseUzrmmaE68J0ddKLb10wdsZS2zsIa
         lJ+osySZDM3VdK5j+imFAVqiZjbYn8Zkzzs5Arho6erpoulADBKM0EFmAEPob1LUS8VC
         /oFqnFEsoQfHOeQsy1lRSTGzr1ZxPzLiZsBFDdH2Wvn2pci0YDyu8x2BZVb0PagDi/JI
         WZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0kjaeCR45lhIDrYKMP7PJZ0td+isdhENhOYRMFcHM07baio73v5UGKnlN2sBYxQLbu9wGoUdDu1HzzdKwkwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhPBj+18Qi73maNo4X/pyE+CSVn9deTyyZj2FNHGKMt3tO/Qv
	2l7AC0dfHzLEwvPRLgHpcfU7A18RrPbrbU6djqspp5Ll44uMFHcLCeP6
X-Gm-Gg: ASbGncua9wTv24zDTne7SiZe4Kp2S0bY5mWeOigkKUS22NbIwzWa8npTfhwJkxOPIoA
	UWcVrXxNUFjTD7gBrw0OpXv7OcwlPu981EcwouyNg76IeybhgCQP8BWbkj1dDMfcLeID83kLQxY
	U6NECBqxISbYdYQ0/U2bPKCL14WflHlVPZCCk20lkhcxlXbV5OkX0bRiLu69WZ+SHsdlCLQGW59
	bY1vOJe1biFN/Ty96p9w5S9jhM4DjOKiIqCCKuKrWe3l8nLJiIn3LbnZpy451jTc3+fY5uMeDBL
	874TPvRaTzU3k9UxayFUcVSFV4YXwxyK56ipiuICKd0kMhNNfb4x4m/MfVfXth6X23MJKGA7vK0
	P96+u0tC7uC7UbAhLnV9AecBns+H25p6pGWMRJA/33kPGUM6NINJ0gTtyB2RZItynfRatLp6VuO
	AcdJM4sKtQi/FsHEcfegirfNJfeCrhtA8ev8z/rGzeRm1XSCvKFYn+Svp9wOvga+ueQtI=
X-Google-Smtp-Source: AGHT+IEeOymRIkFQOr4JB61bu2rSDxpP6cAksOESLtPWvBHBz4B7/Sh7AubPoUZ4gTkeiXgXOkHVKA==
X-Received: by 2002:a17:907:7245:b0:b76:339d:63ed with SMTP id a640c23a62f3a-b767183c00emr3758956666b.52.1764584932679;
        Mon, 01 Dec 2025 02:28:52 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d26sm1190495766b.3.2025.12.01.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:28:52 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC/RFT net-next v2 5/5] selftests: no_forwarding: test VLAN uppers on VLAN-unaware bridged ports
Date: Mon,  1 Dec 2025 11:28:17 +0100
Message-ID: <20251201102817.301552-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201102817.301552-1-jonas.gorski@gmail.com>
References: <20251201102817.301552-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A VLAN upper on a bridged port consumes the VLAN on this port and
inhibits forwarding of it.

Add a test that for VLAN-unaware bridges a single VLAN upper prevents
forwarding of that VLAN from that port. This is asymmetric "blocking",
as other ports' traffic can still be forwarded to this port. This is not
tested, as this is a no-forward test, not a forward test.

Since we are testing VLAN uppers, skip checking untagged traffic in
those cases.

Disallowing VLAN uppers on bridge ports is a valid choice for switchdev
drivers, so test if we can create them first and skip the tests if not.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* new patch

 .../selftests/net/forwarding/no_forwarding.sh | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index c8adf04e1328..d223b5b79a4f 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="standalone two_bridges one_bridge_two_pvids bridge_aware_vlan_uppers"
+ALL_TESTS="standalone two_bridges one_bridge_two_pvids bridge_unaware_vlan_upper bridge_aware_vlan_uppers"
 NUM_NETIFS=4
 
 source lib.sh
@@ -226,6 +226,24 @@ one_bridge_two_pvids()
 	ip link del br0
 }
 
+bridge_unaware_vlan_upper()
+{
+	ip link add br0 type bridge && ip link set br0 up
+	ip link set $swp1 master br0
+	ip link set $swp2 master br0
+
+	if ! ip link add name $swp1.10 link $swp1 type vlan id 10 2>/dev/null; then
+		ip link del br0
+		echo "SKIP: bridge does not allow vlan uppers on bridge ports"
+		exit "$ksft_skip"
+	fi
+	vlan_destroy $swp1 10
+
+	run_test "Switch ports in VLAN-unaware bridge with VLAN upper" 1
+
+	ip link del br0
+}
+
 bridge_aware_vlan_uppers()
 {
 	ip link add br0 type bridge vlan_filtering 1 vlan_default_pvid 0
-- 
2.43.0


