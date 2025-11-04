Return-Path: <linux-kselftest+bounces-44692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9319C2F6CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 07:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3338D4EE318
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 06:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5C12673AF;
	Tue,  4 Nov 2025 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="IdN+22Dp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03186262FC0
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237055; cv=none; b=uBIs20vyEVOOuql4RT4dDTLds4bXpFPrxbKX77hw/cUz2ppmfunFLAi0i1QY9zWsuIYmuZSIpMWxlf3M0ceLJLJA8tkEkXudxCYQqxjJ1lSQAACWK1JhIDWokRjb1GNk6mm6zMJ1kKNOffCmt69GDScLOT1zVhBa/iNV2uZEWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237055; c=relaxed/simple;
	bh=H0akFcysYtoQMTq6SLErZbIYDBnSs6SR33JYqUBHGPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPc9H8VFdWpnnb1VaTHDNuDeCFG9zRImA/b6Z5BZH9afzO4NABPEMDfqBzQukmgtVu1/L4e5cM2qVJM3MkuwrAz9Oftbajlld9vyDlUbYwV4qeCwnLwYQ0x92yayb+PIkiB1G/OZWBZQyolOGES9G3Isvdt+dkg/+p9w0BJowpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=IdN+22Dp; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202511040617279ee7c9095e000207d1
        for <linux-kselftest@vger.kernel.org>;
        Tue, 04 Nov 2025 07:17:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=kw0zFvKnv/CewtK+Xr1RXZdXV8kS1VzqX7ZfwO3TUrM=;
 b=IdN+22DpJWY88axdQwz0mu8PUj/V4i4pB69VdJtAzZ5VAxWJfuYo9BW8Z9Y5ZVM1GDvwQh
 sKfYs+dRda2STHlpTPto/AajshOdCBcEcUhz0rck5rnM1lDNUW59IPkVJNZ66P9rEipjosEv
 pq30S83CgZeIUanJ1kHZ4vCDkMVh26nIFcFOntlTmz7NGiVCZQECWp9H6S7w3oMjWgbCZYRa
 X3IOB7kYysx6alVzQi0qGZSK+LvpnAo9Tmp/XxI8ZhBPvFfuyF5TO5y+UypaUldu9VMSvZ4E
 vyCkd5mdPpFPuD3gTDz0GB62fjNjqpHv0d4rwW9BZQ688H5fcFqNBSaA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: local_termination: Wait for interfaces to come up
Date: Tue,  4 Nov 2025 07:17:21 +0100
Message-ID: <20251104061723.483301-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

It seems that most of the tests prepare the interfaces once before the test
run (setup_prepare()), rely on setup_wait() to wait for link and only then
run the test(s).

local_termination brings the physical interfaces down and up during test
run but never wait for them to come up. If the auto-negotiation takes
some seconds, first test packets are being lost, which leads to
false-negative test results.

Use setup_wait_dev() after corresponding simple_if_init() on physical
interfaces to make sure auto-negotiation has been completed and test
packets will not be lost because of the race against link establishment.

The wait has to be done in each individual test because the interfaces
have to be brough up first and only then we can wait for link (not
individually, because they are expected to be looped in pairs).

Fixes: 90b9566aa5cd3f ("selftests: forwarding: add a test for local_termination.sh")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 .../selftests/net/forwarding/local_termination.sh      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index ecd34f364125c..369c8b2c1f4a2 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -430,6 +430,8 @@ standalone()
 	h1_create
 	h2_create
 	macvlan_create $h2
+	setup_wait_dev $h1
+	setup_wait_dev $h2
 
 	run_test $h1 $h2 $skip_ptp $no_unicast_flt "$h2"
 
@@ -448,6 +450,8 @@ test_bridge()
 	bridge_create $vlan_filtering
 	simple_if_init br0 $H2_IPV4/24 $H2_IPV6/64
 	macvlan_create br0
+	setup_wait_dev $h1
+	setup_wait_dev $h2
 
 	run_test $h1 br0 $skip_ptp $no_unicast_flt \
 		"vlan_filtering=$vlan_filtering bridge"
@@ -480,6 +484,8 @@ test_vlan()
 	h1_vlan_create
 	h2_vlan_create
 	macvlan_create $h2.100
+	setup_wait_dev $h1
+	setup_wait_dev $h2
 
 	run_test $h1.100 $h2.100 $skip_ptp $no_unicast_flt "VLAN upper"
 
@@ -505,6 +511,8 @@ vlan_over_bridged_port()
 	h2_vlan_create
 	bridge_create $vlan_filtering
 	macvlan_create $h2.100
+	setup_wait_dev $h1
+	setup_wait_dev $h2
 
 	run_test $h1.100 $h2.100 $skip_ptp $no_unicast_flt \
 		"VLAN over vlan_filtering=$vlan_filtering bridged port"
@@ -536,6 +544,8 @@ vlan_over_bridge()
 	simple_if_init br0
 	vlan_create br0 100 vbr0 $H2_IPV4/24 $H2_IPV6/64
 	macvlan_create br0.100
+	setup_wait_dev $h1
+	setup_wait_dev $h2
 
 	if [ $vlan_filtering = 1 ]; then
 		bridge vlan add dev $h2 vid 100 master
-- 
2.51.1


