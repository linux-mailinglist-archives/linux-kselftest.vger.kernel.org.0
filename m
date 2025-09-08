Return-Path: <linux-kselftest+bounces-40917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA74DB4842E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 08:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331CC1897026
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F8B231845;
	Mon,  8 Sep 2025 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+OZ3Dp0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589572F32;
	Mon,  8 Sep 2025 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312899; cv=none; b=sJs3ZQFiRfnNpGA4/A11Syjyngcr/rqxJ8Gq4T11XLKipEWe9EFS4EJfdCJ+Vk3FYDZUnLEthhyIP5oeSGqwFtsNkDmNff/erudrWtVhbawRrKuKUKuPvjGYean1c48SzQTsd46ds9aHN7WuKA1rYnbDIhtPjy1ZqzxqTGWYPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312899; c=relaxed/simple;
	bh=tKlsEbu9HDOYElRCUsWLC2XzJ6gWjtu9Q3ZfxnPBAIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlMgGa3mRfl/CZHaAGa3Sj7UCDwvY20kYNRQxmmVS8ui7hHtudCubvYaIhmEviuDqrxynXeebYofKK0m7yPQZj0ErmeIO+5AwFVGJKjb4OqjXdCu3/CiTvZAIHwxp0rE3ifp54v644NV4P5cLiIrdxF2E76Iz31SAONusfBo3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+OZ3Dp0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso3075532b3a.2;
        Sun, 07 Sep 2025 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757312897; x=1757917697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuOyzTTAq45ExTFXr1bmu2KD09m908J5cNHTTpfNEx8=;
        b=N+OZ3Dp09E92XM4bMX8+4NUZa7sSwyfBnRWLPn5UpOXPl2wRFb3tAN6v380h8lMuWw
         ZGskKc0nGW3l5NbnbeoUvlzWlLeX1WiBUPVWjeA3Oe3IsNRyv1KDa454QyXJXgeh92rF
         oRDfIT8L60NObkhDnxNRNLmMGwGtwRjOz6vf2TqUpAI0Xjtv54/SHlWJHA9DeDTh0Bvg
         RrHISFu+TijWnMLU3DXzMxk4HQKdaEIey23vdn44mBP2ivU5O7rW8Bhmg+lj6UWGE5jQ
         mzDIInvy2erOu4iALiAYo9rin0lmznbCVvKVW1kdawpiwITIj8BNpkNFgrLIA1hwBYXe
         8A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757312897; x=1757917697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuOyzTTAq45ExTFXr1bmu2KD09m908J5cNHTTpfNEx8=;
        b=hVPXrUiRfB0G8NeBVp4TKrWDeVS1DIv/xN5mBUuZQ43UdOGkzeV674l0uNDOBKcHJJ
         Q4FdNotp3RhQrQdnciT0DJFtIcdPGSF+e+3xooNTOZlHLHrEUgP1xjunJnazqNfY2HE5
         oDnA0nJovA+C4uPeFufB0dtAH0x/LDojYMjo+yOw9eiKFb9z8pJwYGn1uUqfZXt8tU55
         t6IKLlzH6NpS31VY8IbnyVPctCNRfXg1xImAOdc+Wm2zjO2XD8A9J21X3z9TDXguZhOX
         1u27LqeiQNKFHfkYCQdsTnr8Q16V0iCJi1EXB/ADamqVZYXRpqbOlS4FYkuVtDjWC4jI
         ZXtw==
X-Forwarded-Encrypted: i=1; AJvYcCUwlGU/NVGjytMbNLTSW3Wm3WdcCw16R09VaAQ6NBlaRtbo0myy0xKvQLEN7tb/yIzOwzFTE9zdVsGLSZ5rpKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVMpfPjgdkx2BtR7HyflpzlfG6qy31UBHob21SU/rOO/RL64O
	kcLQUtluBu3cNqa1IYZ9rPbIwr30h6ZlAIJYSyF6gjx8xOZq1LmmS8VY2L0GqEByilM=
X-Gm-Gg: ASbGncuX0pGytFyceAFsWGkUxHvWTNzUq4eTdvtvuj1kozZwh+lP21dH4nEWog2dR4X
	0i3xrLsJiF0+EnFpviulaeMKNyhDpFkUlzLI6LbzCK0p1CYLpFEnZy+i9gLcYs4HfXWPI0h5e3a
	y1cfivy1ByEqLnE1W/8gpRb0Vgc9oiNtkV7AyBRCFqAmOWIEzo7INPTQhGNzNLCDYeOsUDEwkJx
	qP1TMVNnmVyC7d9zR+w7xm7Vfp8aD0tKBrloSblvMAmuff4StDFhmYoWSCSxC9BLkDAJtiVdU/E
	MZfrxA9/6K/Nr0v26ylpm+smrMO1ZrnjIizySf1EIcopqCl2vTsrmocNtUEmII4wGKk/XQaP8Vx
	fs1wboGG9l76kwePnnQY6wSDpywgB3xYzxbdnaxLkkrRfHEKVsCYu
X-Google-Smtp-Source: AGHT+IE4xeQtkHamtFSTqnjiblGZaGxYwYBtK1ZMzcVuFng1mIvxG2PgFOeVw0lR1soKh/eU4LuxZQ==
X-Received: by 2002:a05:6a00:2ea8:b0:772:2fad:ff64 with SMTP id d2e1a72fcca58-7742dce028fmr9670666b3a.8.1757312897363;
        Sun, 07 Sep 2025 23:28:17 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77285bb2614sm13134974b3a.58.2025.09.07.23.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:28:16 -0700 (PDT)
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
Subject: [PATCHv2 2/2] selftests: bonding: add vlan over bond testing
Date: Mon,  8 Sep 2025 06:28:02 +0000
Message-ID: <20250908062802.392300-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908062802.392300-1-liuhangbin@gmail.com>
References: <20250908062802.392300-1-liuhangbin@gmail.com>
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

v2: split the patch into 2 parts, the kernel change and test update (Jay Vosburgh)

---
 .../drivers/net/bonding/bond_options.sh       | 59 +++++++++++++++++++
 .../selftests/drivers/net/bonding/config      | 21 +++----
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index 7bc148889ca7..b3eb8a919c71 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -7,6 +7,7 @@ ALL_TESTS="
 	prio
 	arp_validate
 	num_grat_arp
+	vlan_over_bond
 "
 
 lib_dir=$(dirname "$0")
@@ -376,6 +377,64 @@ num_grat_arp()
 	done
 }
 
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
+		"dev eth0.3 ingress" 101 ".packets" "-n ${c_ns}" || RET=1
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
+
+	bond_reset "mode $mode arp_interval 100 ns_ip6_target 2001:db8::3:10"
+	ip -n "${s_ns}" link add bond0.3 link bond0 type vlan id 3
+	ip -n "${s_ns}" link set bond0.3 up
+	ip -n "${s_ns}" addr add 192.0.3.1/24 dev bond0.3
+	ip -n "${s_ns}" addr add 2001:db8::3:1/64 dev bond0.3
+
+	slowwait_for_counter 5 5 tc_rule_handle_stats_get \
+		"dev eth0.3 ingress" 102 ".packets" "-n ${c_ns}" || RET=1
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
+}
+
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 4d16a69ffc65..cbd8b2769475 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -1,12 +1,13 @@
-CONFIG_BONDING=y
-CONFIG_BRIDGE=y
-CONFIG_DUMMY=y
+CONFIG_BONDING=m
+CONFIG_BRIDGE=m
+CONFIG_DUMMY=m
 CONFIG_IPV6=y
-CONFIG_MACVLAN=y
-CONFIG_IPVLAN=y
-CONFIG_NET_ACT_GACT=y
-CONFIG_NET_CLS_FLOWER=y
+CONFIG_MACVLAN=m
+CONFIG_IPVLAN=m
+CONFIG_NET_ACT_GACT=m
+CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_CLS_MATCHALL=m
-CONFIG_NET_SCH_INGRESS=y
-CONFIG_NLMON=y
-CONFIG_VETH=y
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NLMON=m
+CONFIG_VETH=m
+CONFIG_VLAN_8021Q=m
-- 
2.50.1


