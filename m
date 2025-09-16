Return-Path: <linux-kselftest+bounces-41576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E49EB58FE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4830B7A3AD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96F28137A;
	Tue, 16 Sep 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaIe7kk6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8D1E7C08
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009704; cv=none; b=cmWK26iDqkTMo1nsL5M0HTYxNCvUsuYJ4PU72va9Fi05CsGAE7SwBiJFfDHgeDqfUynWqsesSZnmAeO++NRlj7ctr4x3KGuTabv4Q8VUM2dHTcpdxUXMxH8tGmApigkQ6v0Lbb+IiF9yl0+GeEyHR8sSVhBIvIvNyfIfaHAAN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009704; c=relaxed/simple;
	bh=jIPbYM76Be7XCwta1HhO/1JlpW706y9cF1GllizOnTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJLS0kVgqDCSZLNwQNsKACW403HNs0neBByYZsgZjNyelNerwhewV01/pgETpv9Wc0MxIhjylVaIxrkCpKo1MA+Z/iYA7Nb7iv7DrscJ5xXH3RklmLgCc5Zi0M/z/JAJLLjSUrAv0cgETEnnl6aB0uHrKEzJERPgDA4NpmJSDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaIe7kk6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so149738a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009702; x=1758614502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bYlsgdaKwvtuqZohQ4tCMqBlo1y5YM99SKTPt0q12M=;
        b=BaIe7kk60jV45Kvi03wcyS72eIXDwSxC1jRjOAGIh43iZJw/cwH72+/yGZOUYBLJkj
         RTdCzvI09medg0vRXGpKI1iaOO9cP2V0hKiNFoLUBQOfQKHGAmQxD6CrLPZ11ONRxHg6
         gE3x+T6V/YcYjQ/1LUgB+5ZQMuhwYvFBz2f/mHC6rfDb87hizRysL/fsg1ihlj+Juy2H
         pYr/LBlQxhDbdtl9hB2IOKviSJ0LeKCtVgt2PxkFO1btgtxP8Jnw6aaic79rPOgtj9jC
         59CC5ITjkvoNJsMFe7atEljHfTNI45+kL4wkzBjOYtJtVcuMk4iLwd6KRovcyf+s8KWl
         1S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009702; x=1758614502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bYlsgdaKwvtuqZohQ4tCMqBlo1y5YM99SKTPt0q12M=;
        b=eP1OKmLPA9Rm1f+cD7RGP2vFvpEg0UQJVXL/6d5l4+LIq2g4EgOHayRySgsRNMcafx
         MZaS2UL9mccL9fEREV6WXAM0GMopMRwtriCYIvkujErycZlbjuMR83IHnFzbEN9xtasP
         zUq/INblq7V1PrahlJLN1onEWRuP0SmULF1+O4y0894jkvw/YsWDhdMukZc2ckIqTQWJ
         U5KFBQCZ1rPh5uR9UyIoONPW+xULTr5DGwHVATXo0xVieVKwMw6Dvv0T97h0ya27OC4x
         bI4yiuEFQ9kjczRQvfvmC9m6VFZ/MprEHATErjft+VWRv/YtaVa6szp3vT7S0Z3PjTEC
         e/bw==
X-Forwarded-Encrypted: i=1; AJvYcCV0xx1C8KYTkvmK7mPwABJCl5XEYcc+6AA4n1gN+EHSmR2K+6D9cBOJEjCos4PAgWhUexlL1tgVpAdrGKCF4EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8LjCLA2m9ErgNSZjblGaEwy3pn2uFGj583yY00MaqmKJGu03H
	9rwmD/Ai0HZ8zzZqulY3a10pNILyv1rSOdEnMhUuBVBc512d58G+a6Hwuzdj4xubMNg=
X-Gm-Gg: ASbGncsKFSvOvrCcBX7OOet4Dbck3iMMH5oSkCXJ2DiDVO3HVT6FLlzsC6gljxeNGYy
	sbicTs57R3b0vYO7OObqkmAgMPAXCmAyFjboZSo7ttBU1Gef0cJJdkjnthLfKbaLBM7qhv0xvG2
	Qonp9docN1DSeOJXdRjR6UNgDmaxtgdXLNYwAPEiQlKCQWmV1EHZQzKg3+rvcoi38FK7GoM/sNh
	5i0EzQCHF1fSAOq91qYRmASj2kvAp+ulu7t5F6lxVLlDSo6OA1eJ5lVXZXrvyBXDK3XswWuSwpL
	o7fiXHSwjZ2JsvSUkCfOwlemkj/6W1u2G+QGqyU/Kog1SFEwqICZjv/K0hQCLDBRZokRJjgwdLd
	mRx2q3pQyQOLWOMzzFD12Mq/9r7kvAA7uZytMkezr/w==
X-Google-Smtp-Source: AGHT+IGQdxmLttPJVBzfukIDHLiPWYei+u2V5fgA5lDCOfzMO8K0xig3Y0J1i8KVOTyDY8RGeSlAOw==
X-Received: by 2002:a17:90b:1802:b0:32e:38f5:e860 with SMTP id 98e67ed59e1d1-32e38f5ea82mr11048666a91.15.1758009701879;
        Tue, 16 Sep 2025 01:01:41 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37bf1c19sm6826371a91.22.2025.09.16.01.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:01:41 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net 2/2] selftests: bonding: add vlan over bond testing
Date: Tue, 16 Sep 2025 08:01:27 +0000
Message-ID: <20250916080127.430626-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250916080127.430626-1-liuhangbin@gmail.com>
References: <20250916080127.430626-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a vlan over bond testing to make sure arp/ns target works.
Also change all the configs to mudules.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v4: rebase to latest net
v3: do not switch all configs to module (Jakub Kicinski)
    redirect slowwait_for_counter output to /dev/null
v2: split the patch into 2 parts, the kernel change and test update (Jay Vosburgh)
---
 .../drivers/net/bonding/bond_options.sh       | 58 +++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |  1 +
 2 files changed, 59 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index e3f3cc803b56..187b478d0ddf 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -8,6 +8,7 @@ ALL_TESTS="
 	arp_validate
 	num_grat_arp
 	fail_over_mac
+	vlan_over_bond
 "
 
 lib_dir=$(dirname "$0")
@@ -508,7 +509,64 @@ fail_over_mac()
 	log_test "fail_over_mac 2" "failover: backup slave mac inherit"
 	check_first_slave_random_mac
 	log_test "fail_over_mac 2" "first slave mac random"
+}
+
+vlan_over_bond_arp()
+{
+	local mode="$1"
+	RET=0
+
+	bond_reset "mode $mode arp_interval 100 arp_ip_target 192.0.3.10"
+	ip -n "${s_ns}" link add bond0.3 link bond0 type vlan id 3
+	ip -n "${s_ns}" link set bond0.3 up
+	ip -n "${s_ns}" addr add 192.0.3.1/24 dev bond0.3
+	ip -n "${s_ns}" addr add 2001:db8::3:1/64 dev bond0.3
+
+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
+		"dev eth0.3 ingress" 101 ".packets" "-n ${c_ns}" &> /dev/null || RET=1
+	log_test "vlan over bond arp" "$mode"
+}
+
+vlan_over_bond_ns()
+{
+	local mode="$1"
+	RET=0
+
+	if skip_ns; then
+		log_test_skip "vlan_over_bond ns" "$mode"
+		return 0
+	fi
 
+	bond_reset "mode $mode arp_interval 100 ns_ip6_target 2001:db8::3:10"
+	ip -n "${s_ns}" link add bond0.3 link bond0 type vlan id 3
+	ip -n "${s_ns}" link set bond0.3 up
+	ip -n "${s_ns}" addr add 192.0.3.1/24 dev bond0.3
+	ip -n "${s_ns}" addr add 2001:db8::3:1/64 dev bond0.3
+
+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
+		"dev eth0.3 ingress" 102 ".packets" "-n ${c_ns}" &> /dev/null || RET=1
+	log_test "vlan over bond ns" "$mode"
+}
+
+vlan_over_bond()
+{
+	# add vlan 3 for client
+	ip -n "${c_ns}" link add eth0.3 link eth0 type vlan id 3
+	ip -n "${c_ns}" link set eth0.3 up
+	ip -n "${c_ns}" addr add 192.0.3.10/24 dev eth0.3
+	ip -n "${c_ns}" addr add 2001:db8::3:10/64 dev eth0.3
+
+	# Add tc rule to check the vlan pkts
+	tc -n "${c_ns}" qdisc add dev eth0.3 clsact
+	tc -n "${c_ns}" filter add dev eth0.3 ingress protocol arp \
+		handle 101 flower skip_hw arp_op request \
+		arp_sip 192.0.3.1 arp_tip 192.0.3.10 action pass
+	tc -n "${c_ns}" filter add dev eth0.3 ingress protocol ipv6 \
+		handle 102 flower skip_hw ip_proto icmpv6 \
+		type 135 src_ip 2001:db8::3:1 action pass
+
+	vlan_over_bond_arp "active-backup"
+	vlan_over_bond_ns "active-backup"
 }
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 4d16a69ffc65..832fa1caeb66 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -10,3 +10,4 @@ CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NLMON=y
 CONFIG_VETH=y
+CONFIG_VLAN_8021Q=m
-- 
2.50.1


