Return-Path: <linux-kselftest+bounces-41102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7C7B50C44
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 05:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6514F4687A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 03:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104825C70D;
	Wed, 10 Sep 2025 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl1h7vq7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CB25B69F;
	Wed, 10 Sep 2025 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474408; cv=none; b=AIVV6KTkhUmloxxYg5btf1D6oD3UVSyT4cuvJiDiaeL2fqIo3dbXuVpKIZu7JLbfmbVKczsqCNutkUkOLgzNhO5wcxwjElMDT5E27+2lap5gYwavrrTy0YKV/TNsLFW0lAHP30otImC04p8YC2UwUiiZwYWDQgboLldk2sI8BEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474408; c=relaxed/simple;
	bh=K4i/CRYPaRsjkvjxZrHaL973nmK6XktQZbB6np5l2JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cooHUn/e58hIom9nTfzQ5SCudApGK47lC93JiOXhAaB0La3QVDdrchMQsUX/RTwEyAYvY/gp4bdrcjuGYHhiXJToL2Ap/P5AJN5jU1FjIZWzlMmDLSHyQ1KFoUIm6kO1l2t+BROh8WK5ct20DfwNrs8GVEpJu1y6YyybCWhPtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl1h7vq7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77459bc5d18so2122508b3a.2;
        Tue, 09 Sep 2025 20:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757474406; x=1758079206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQu78XnLIIXtRGzyeMrjDmxrglcfot32KmBpyvuFvU4=;
        b=Tl1h7vq7pGTxhZmj59Ydss8PPeDdRdbITaMRCzFIDXcvSURVpSN9BT+qB4qvv3nFSb
         ChuEJI6bCwphU+PBNbpi/2laGAfcFEnNRFd3KXa1yguQfqTZ8f08B2apNnSDpAQvglL/
         FwEnCnUP88g91+MDB9kKJ80XG9a+SoOC1iMT24RD7eup0B58+gurN8goiXPGgKPYUNaE
         QRRmeufZCwntTYM5LTBQhA8FoAd6Qj6qjpcHF0vagTYmctGOeuIJVutAXQQOih2fVmB1
         A/iY5EHb48gZMledLacFnYasupdTuPkNz3wFu2SKBQy5+RBvrl78/Ih1y1oamTNs/roi
         UNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757474406; x=1758079206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQu78XnLIIXtRGzyeMrjDmxrglcfot32KmBpyvuFvU4=;
        b=pj0mhAmAg+kAz6fUlvA9Tas7GugVpCe5heNTNpVGJ7ztSd1hRWnteA3gcIh8+22JQa
         vPGtZjWDP99JoTdSzdiOmFwV2xm6n9cPSlxRS6dK+YM+/6kv3o+oBP6aVdcCSmxxBtWY
         1nQQ1lsMF79cG+LiCa01yrgqP/s4n+SPoLRyemJQuv1Tq5ZBx6X11vn8Ro5UEbvz0fCP
         uwifD7nnLllM0Zj4MFlVUpJGLPYYE9/ggqCtaNpl66hstH3S1icEhQVdn0Vuxrz8JNCO
         k6hwHS6UlloZjeyAXZdlSfCLsc8M8bYnH3Kb8Wpy8T1/mVm2Sd/yeJNts8xv1qgQ+SPJ
         ZmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWANaO3GIVFL5+rJzDvA6VRpQvouGx1/pTFN4y0QMjlMgQ8P7q2Umz8XtpWZSKKb+0/dFsBZ/zQvyl53BeCbPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8//20OFafINPzASWcYvRzUjbT+ZsCfdhUs1s48ksCrxRbuL1
	d2kvtFnE7nCUxfUmh6HsCNP3jowCN+ewu1BI50VtpGq9/ZXkVSNrLCDNBTp3t1Y7
X-Gm-Gg: ASbGncv1qlnbfK9gRGlJS0ION34CdcYjxmTKdRSj/4f0q8i5ExAduD11CNuBKma5WTr
	7Eva7M0NDBsk2jsb9Yio9aSCezHWdjoIqzW/tJcuHxRBjKkiU3O15nbIR8mMvI1uTxaTEjFYNcN
	0fgDvGyYPRMGvnYDCGXJqDcyJi4Rxpx8Acl2djatfhbmNMQusI8cyNsr4nAKXPH5Tib1tJw27my
	p5NJDYSLppikT/PdZ2zZgwbNnEG4vMiwOHbzzpZ1/UFdv5lEn13nejHVcomMHlpKMU/CVHGKwqj
	DtB6eL+RIf9G6cRVud/B93JK8zzpoBZcct20K5BMV2VeM//mUmE1KG7Tqr52479KvKySg4bui+3
	5ec0zV6C58gUMnO/VCYG9GdC8yLPZ6q4Aosj9HdmLiw==
X-Google-Smtp-Source: AGHT+IEotbhaefRf+fLxluOtqnn6FSWCop0dB9/ArPtcsUI8oxKHGNaOe+BGfG69a5h5OUSM+gy7iw==
X-Received: by 2002:a05:6a20:a11b:b0:244:3a85:cd89 with SMTP id adf61e73a8af0-2533e94ff58mr20457522637.1.1757474405714;
        Tue, 09 Sep 2025 20:20:05 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774661247cdsm3554308b3a.33.2025.09.09.20.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:20:05 -0700 (PDT)
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
Subject: [PATCHv3 net 2/2] selftests: bonding: add vlan over bond testing
Date: Wed, 10 Sep 2025 03:19:46 +0000
Message-ID: <20250910031946.400430-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250910031946.400430-1-liuhangbin@gmail.com>
References: <20250910031946.400430-1-liuhangbin@gmail.com>
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

v3: do not switch all configs to module (Jakub Kicinski)
    redirect slowwait_for_counter output to /dev/null
v2: split the patch into 2 parts, the kernel change and test update (Jay Vosburgh)

---
 .../drivers/net/bonding/bond_options.sh       | 59 +++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |  1 +
 2 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index 7bc148889ca7..699bb41aae83 100755
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
+
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
+}
+
 trap cleanup EXIT
 
 setup_prepare
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


