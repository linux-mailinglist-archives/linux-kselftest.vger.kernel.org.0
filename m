Return-Path: <linux-kselftest+bounces-46792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92844C96A8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 11:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 126EB3443E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD6F305967;
	Mon,  1 Dec 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIE/ozVX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255163043BC
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584934; cv=none; b=ZVEPRXH7LVcRFacB11Wp+PihTFFVrMEmWsNNzunI0+pL8orLD7CBK/WBWMDKc0V8JcC/tQ1XQatiDoauMVpCGwk49L6IcpOu8NZBNJMXOlv3z7kKW6Ts7DcozN/RaChOElAXiyuV8WjbKFui3TH3sB77yt776I+WF3/jsty/Etw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584934; c=relaxed/simple;
	bh=bpfHyyspFf7vI7NmB9tWN+VXQOjDBGy/ulV1bMwtwkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbISKnE4l0mIS/GXsVE4DFXlx3js6jLic8miUtJGCUlyb0m6vKH80MdkkXh5u7ehDXIroABplKUBc3nL2MvvQaeE2mwkxuECX0ZYAmZ+dmsv/X7fxahRUH89FgKHxpuJLEJRGFwVyE9NKl3A3Y7t/WhGLiKDTvti0FStCYRNG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIE/ozVX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b73161849e1so960153466b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 02:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764584930; x=1765189730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r62uAAysvOeF+TQvBPK+HmpxuJJtN8BAOCCbeSMPZRw=;
        b=MIE/ozVXkW9Dqz28uyOPT9368AzPdlgymcW3jVzdu2V3Jk0VxYodGB/4EMVZkYSAW4
         SDXe/KZtHP5SlGzyE1LL/dkdqLDUCW9g0ahNAT/jhqfePnrX2QhdRfs8eJriShq145u+
         op+5DCZH3DDavteR3RwxZgeceZYdsVxxqAQHxuZE0QI4diHq/+lPBVaxdbWakOJfwOeR
         zOadRjKnfE5ykehZ7ezAWLa8b3J3WM3vAPca+bfx+QIIGSQHPv1yOcCnKRLgUnTrjTRt
         d4csxEt8XPsT7G7iA5uxF6woxLZSQSDuS+xr+WtVOEEAN7OJLAIRaWyMRblgQJ8Nw0dh
         uRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764584930; x=1765189730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r62uAAysvOeF+TQvBPK+HmpxuJJtN8BAOCCbeSMPZRw=;
        b=lI8+1pA8nF9ieWFMSmYA72cM2ULaAwuU/SOEgGzpsY9d2Da+Pm91OsdSJU6p8H2pGo
         jaaxEJed46TP1+yOlEDkzm01N6gEeMrBUyqGZOkSSKoYkt2olRMSAD97DvilKxGlOpKa
         maNBRzn8LeBtVe2ITlg+sv47JZWB9kAND1TyZwLfs5nqlqB7EQAB4n2mnHu55Mv5yVV4
         MVPsM0t7Rk/1is++J8CnOnMDhCrNzFcbRqv0O1YuMh18NQsGsoAjrG0nde+pPWcaf1/y
         8h+EzN8XR+0BPKl+1VSh+UFimmtiPcH1WtKLxCmhgjvtvknKACMkmGACH7k4YKqAQZrZ
         GKRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPIwXJZS7e6AisVFGd2TMYHGXaLe9vBWNJGHsf4oSKA3rElNrjsg6sj/4Y3oI1s/6TtKY96JCxdPNUr43jdOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykt8auzi4/lyPn8H9i87QiZMHGWRrVVN1snCcLumodeU037coJ
	g0/8g3V+uL4jSPttMBpZd0ezRjWIy6mImIHwxWD9hzdq2zOMRvp+cJLe
X-Gm-Gg: ASbGncuLkheJLjSSXneHtij58wEYl3LPqIBDvWAhqdKGhuFneT88b6udwis/213hCo7
	JLmjDohdAGEXbJi8ujOCvntyJYkIdjNkIQpFl5sfrREsOF3cTI2b1fyYsDcsS/uu1ljciAU/6oO
	qTbE4MLq3T+MXcaiDt92jmtqEcqgXzfh11vMp3gsOsGb5vnlOOG3i86RuYNNEIFBCNmHoi5ZMj/
	5gHoUUFPIOTg//NZHJiV8oeG/Cjibw2pFrJX3dNE1Lnme3XOawjUFrLNA+CmjmfA9OlKV8OvREq
	ZIv1Cj0AoXz4mnEJ6O7ergxkxu+acdzz38LNeGlrjYJfeF/N+BW/1V7NEdlCAhuAspQn5S8GRkR
	AU+iBXIqV5ahzY1c4BES1QMDk86OpIS0uSQZ+Zl93wgchJkdcjJnOW+u7Q6bbixUaSCvOEzYa5J
	6nFuJgF1dd+VtOeLhHTfRhjC0gee31rce4ruSXupqk5TvAYdHL1eWPYhhCpv6TcGbf7NU=
X-Google-Smtp-Source: AGHT+IFUMDNzleZaysdDaOIWKCLnv0W/7ORsWcveP6WOewtMC3bsi4ve1+dw0mBPOzG6hzY3eCvx5w==
X-Received: by 2002:a17:907:3f25:b0:b72:aaae:1b22 with SMTP id a640c23a62f3a-b767150b109mr4455364166b.12.1764584930328;
        Mon, 01 Dec 2025 02:28:50 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d3esm1199021666b.8.2025.12.01.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:28:49 -0800 (PST)
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
Subject: [PATCH RFC/RFT net-next v2 3/5] selftests: no_forwarding: test VLAN uppers on VLAN aware bridged ports
Date: Mon,  1 Dec 2025 11:28:15 +0100
Message-ID: <20251201102817.301552-4-jonas.gorski@gmail.com>
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

Add a test (mainly for switchdev implementors) to test that multiple
VLAN uppers on a VLAN aware bridge for the same VLAN do not enable
forwarding of that VLAN between those ports.

Since we are testing VLAN uppers, skip checking untagged traffic in
those cases.

Disallowing VLAN uppers on bridge ports is a valid choice for switchdev
drivers, so test if we can create them first and skip the tests if not.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* new patch

 .../selftests/net/forwarding/no_forwarding.sh | 89 ++++++++++++++-----
 1 file changed, 67 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index 694ece9ba3a7..c8adf04e1328 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="standalone two_bridges one_bridge_two_pvids"
+ALL_TESTS="standalone two_bridges one_bridge_two_pvids bridge_aware_vlan_uppers"
 NUM_NETIFS=4
 
 source lib.sh
@@ -90,6 +90,7 @@ check_rcv()
 run_test()
 {
 	local test_name="$1"
+	local swp_uppers=${2:0}
 	local smac=$(mac_get $h1)
 	local dmac=$(mac_get $h2)
 	local h1_ipv6_lladdr=$(ipv6_lladdr_get $h1)
@@ -99,16 +100,24 @@ run_test()
 
 	tcpdump_start $h2
 
-	send_non_ip $h1 $smac $dmac
-	send_non_ip $h1 $smac $NON_IP_MC
-	send_non_ip $h1 $smac $BC
-	send_uc_ipv4 $h1 $dmac
-	send_mc_ipv4 $h1
-	send_uc_ipv6 $h1 $dmac
-	send_mc_ipv6 $h1
+	if [ "$swp_uppers" -eq 0 ]; then
+		send_non_ip $h1 $smac $dmac
+		send_non_ip $h1 $smac $NON_IP_MC
+		send_non_ip $h1 $smac $BC
+		send_uc_ipv4 $h1 $dmac
+		send_mc_ipv4 $h1
+		send_uc_ipv6 $h1 $dmac
+		send_mc_ipv6 $h1
+	fi
 
 	for vid in "${vids[@]}"; do
 		vlan_create $h1 $vid
+		if [  "$swp_uppers" -ge 1 ]; then
+			vlan_create $swp1 $vid
+		fi
+		if [  "$swp_uppers" -ge 2 ]; then
+			vlan_create $swp2 $vid
+		fi
 		simple_if_init $h1.$vid $H1_IPV4/24 $H1_IPV6/64
 
 		send_non_ip $h1.$vid $smac $dmac
@@ -120,6 +129,12 @@ run_test()
 		send_mc_ipv6 $h1.$vid
 
 		simple_if_fini $h1.$vid $H1_IPV4/24 $H1_IPV6/64
+		if [  "$swp_uppers" -ge 2 ]; then
+			vlan_destroy $swp2 $vid
+		fi
+		if [  "$swp_uppers" -ge 1 ]; then
+			vlan_destroy $swp1 $vid
+		fi
 		vlan_destroy $h1 $vid
 	done
 
@@ -129,26 +144,28 @@ run_test()
 
 	tcpdump_stop $h2
 
-	check_rcv $h2 "$test_name: Unicast non-IP untagged" \
-		"$smac > $dmac, 802.3, length 4:"
+	if [ "$swp_uppers" -eq 0 ]; then
+		check_rcv $h2 "$test_name: Unicast non-IP untagged" \
+			"$smac > $dmac, 802.3, length 4:"
 
-	check_rcv $h2 "$test_name: Multicast non-IP untagged" \
-		"$smac > $NON_IP_MC, 802.3, length 4:"
+		check_rcv $h2 "$test_name: Multicast non-IP untagged" \
+			"$smac > $NON_IP_MC, 802.3, length 4:"
 
-	check_rcv $h2 "$test_name: Broadcast non-IP untagged" \
-		"$smac > $BC, 802.3, length 4:"
+		check_rcv $h2 "$test_name: Broadcast non-IP untagged" \
+			"$smac > $BC, 802.3, length 4:"
 
-	check_rcv $h2 "$test_name: Unicast IPv4 untagged" \
-		"$smac > $dmac, ethertype IPv4 (0x0800)"
+		check_rcv $h2 "$test_name: Unicast IPv4 untagged" \
+			"$smac > $dmac, ethertype IPv4 (0x0800)"
 
-	check_rcv $h2 "$test_name: Multicast IPv4 untagged" \
-		"$smac > $MACV4_ALLNODES, ethertype IPv4 (0x0800).*: $H1_IPV4 > $IPV4_ALLNODES"
+		check_rcv $h2 "$test_name: Multicast IPv4 untagged" \
+			"$smac > $MACV4_ALLNODES, ethertype IPv4 (0x0800).*: $H1_IPV4 > $IPV4_ALLNODES"
 
-	check_rcv $h2 "$test_name: Unicast IPv6 untagged" \
-		"$smac > $dmac, ethertype IPv6 (0x86dd).*8: $H1_IPV6 > $H2_IPV6"
+		check_rcv $h2 "$test_name: Unicast IPv6 untagged" \
+			"$smac > $dmac, ethertype IPv6 (0x86dd).*8: $H1_IPV6 > $H2_IPV6"
 
-	check_rcv $h2 "$test_name: Multicast IPv6 untagged" \
-		"$smac > $MACV6_ALLNODES, ethertype IPv6 (0x86dd).*: $h1_ipv6_lladdr > $IPV6_ALLNODES"
+		check_rcv $h2 "$test_name: Multicast IPv6 untagged" \
+			"$smac > $MACV6_ALLNODES, ethertype IPv6 (0x86dd).*: $h1_ipv6_lladdr > $IPV6_ALLNODES"
+	fi
 
 	for vid in "${vids[@]}"; do
 		check_rcv $h2 "$test_name: Unicast non-IP VID $vid" \
@@ -209,6 +226,34 @@ one_bridge_two_pvids()
 	ip link del br0
 }
 
+bridge_aware_vlan_uppers()
+{
+	ip link add br0 type bridge vlan_filtering 1 vlan_default_pvid 0
+	ip link set br0 up
+	ip link set $swp1 master br0
+	ip link set $swp2 master br0
+
+	if ! ip link add name $swp1.10 link $swp1 type vlan id 10 2>/dev/null; then
+		ip link del br0
+		echo "SKIP: vlan-aware bridge does not allow vlan uppers on bridge ports"
+		exit "$ksft_skip"
+	fi
+
+	if ! ip link add name $swp2.10 link $swp2 type vlan id 10 2>/dev/null; then
+		vlan_destroy $swp1 10
+		ip link del br0
+		echo "SKIP: vlan-aware bridge does not allow multiple vlan uppers per VLAN on bridge ports"
+		exit "$ksft_skip"
+	fi
+
+	vlan_destroy $swp1 10
+	vlan_destroy $swp2 10
+
+	run_test "Switch ports in VLAN-aware bridge with VLAN uppers" 2
+
+	ip link del br0
+}
+
 h1_create()
 {
 	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
-- 
2.43.0


