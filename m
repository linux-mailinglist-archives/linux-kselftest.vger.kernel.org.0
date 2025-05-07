Return-Path: <linux-kselftest+bounces-32575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB3AAE09B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 15:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18BF501218
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 13:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFE288C2C;
	Wed,  7 May 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp7U430R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299F280A2E;
	Wed,  7 May 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623982; cv=none; b=qpbIAh+ka++rgiMx2PfkEekFWMvuY6cfTf48bjpehxm8sMDnw7Hu+LKwLVIyeuCHJaWHZgEl8gIDWn1vr7xaE2S+NhjoFgTnn71ZKzZ2TxaX3Vc35N3zWZTvrqsjBsvSA8YAIzcM399MOWLzO6mA63GTQfLrDp7BQu1kOwT6oR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623982; c=relaxed/simple;
	bh=rUh17m48WTZoyo/o1QILtZNUlKVMOqIM3NF7WqvG//w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKy+67mrBj2mtqrdGTThUpDD9krqZOwtVblCMiXMCmDKyzGcw+T65VLk9kF77U4jz5t0KwQo0ytUckkdalCrfqiZ7z+IMFw2XfcBnmIQRJ0FxhcAYg+c0jTsUR22C/2y6Nhf/I6x8Mu6WT3G4rZ98SIlDwvXJnnN2Be8UMENPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp7U430R; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2241053582dso107106315ad.1;
        Wed, 07 May 2025 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623979; x=1747228779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdYhARpt2I2zanYqf2S7OyCV1snoNnsQ0QZffY/yXJU=;
        b=hp7U430RdbMgwQrZAbNHCAnLdJHtkTbQEJbEfmLZzqs5dfaspCsdwI7AyOC6J/TGFU
         JeQaYgn7h8jqgFncV5sc/voSVdQRoUBEzJXbosbYBfiU2Cuqpax6BtG7kPAm2rEcBhXT
         r+XPNuOr5NQchkUWLK2EubJnNeWD8Ht37gNDYqgVlz9hXddfi55x9FKfFvbgfZZuAboc
         cEnuXIDxkbWIPsrP3wy8jLAbL6KdYR8BV6pa3M3aILpxG2h1O4BODQHjHrVDQcm864+l
         YgP+PFih0/50MV70gwgZJiIj+sbDNpyiFQHEgfaY/FrpBbtffsoBHswNKJjqm5Y+k9vD
         pkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623979; x=1747228779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdYhARpt2I2zanYqf2S7OyCV1snoNnsQ0QZffY/yXJU=;
        b=l5gq2EAGFdbGf6hesIqSzU6m7YqSVqKLUcWRUIQ4YKNgr27s8C5kNGaJ7hhBCdk0C5
         wD4SKjjSYO2l01T9zvMbgiC5hgFZDjdBJJr9QlMUR5bCzSJEiwpvE6RBrEM1wHJNV7qr
         N7smRREwE+/5xT0lwh25z3+0zirKKH1nlRUWE3IiPRtayagVmZjPVgTy2IkDzXkVVQz8
         1MSGvk6QuvlrpLwjCE3cNEKRZI7HcThYHIe2nbq/D6TO+eqGu3q1KtTDYlrPrDXRePqf
         Y6vaONHfEF+Bv84ZqWYOIJpivZ+4E0Ze3L/OdZ6j7A4PaKi1b+wOiDePquWMFLxWy/B4
         kvfg==
X-Forwarded-Encrypted: i=1; AJvYcCULIgKUA+t0jzDz0aGapo21FdLFWI3Hg7nFUL0bNFLm1kYWD+4EGgVack4gsinQe3mY28K3DfAXW8fYxiXnpS6M@vger.kernel.org, AJvYcCUT+/9ZCMGWeU+5QSNFH7adfaTuHhr5BMFJ3n6m+3SkWwY3+gG2TgCtwYKbb6pG2xxuf0eNHLNOXSFsBt1wOmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznRhal2Mkp36CE6oX83EyQAeqYD51Hpu50VhVSu3lW51/pV/bU
	EzRcs6grNLKjYZxRLlJIbG5ttSSduT9r/OA/RRGU0cYMCHrCC7LOCZOL+2d7
X-Gm-Gg: ASbGncvW89fmB9kePt55UH2deFg82nYi5H0ZhFDlCuZIvk2s0wvUsMZgTF6hgJpal7U
	LF6RGU0ex/OrqPiUgmdf0+lfAGcV/mHl3dCJUdH3VcYjc11jEkyOmzggIxZ8UfSSfbWjeznwM/F
	vWXeD2anZp93rqN4P/+0M84U6HNwqpqnoFIheE5SxeUBVljQQkPM0C8beR4NrtAMGKT+oHUvRB/
	T9Tq6t8jXziyISEZnHERodwhjuTWCXkuF5sxbZ4ct+q/zKU1h2aNLmJE9ua2/nXrt+DDQg8GxzL
	bcCFjGHBybLhV/wfN53lzZGIozLuxMPgI1zlL9h98I+Vrd+ABS5HQ569HiA/
X-Google-Smtp-Source: AGHT+IGDn8P3k/M83rQjvATxa3M5ZNh6koz6JGVm8voor5M8hZGEPZ35gpI6htaphSdbTNfwedwsug==
X-Received: by 2002:a17:903:2381:b0:224:191d:8a79 with SMTP id d9443c01a7336-22e798bde41mr11877545ad.27.1746623978524;
        Wed, 07 May 2025 06:19:38 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:37 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 4/6] selftests: net: use setup_ns for SRv6 tests and remove rp_filter configuration
Date: Wed,  7 May 2025 13:18:54 +0000
Message-ID: <20250507131856.78393-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250507131856.78393-1-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SRv6 tests manually set up network namespaces and disable rp_filter.
Since the setup_ns library function already handles rp_filter configuration,
convert these SRv6 tests to use setup_ns and remove the redundant rp_filter
settings.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh |  5 --
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh  |  5 --
 .../net/srv6_end_next_csid_l3vpn_test.sh      | 77 ++++-------------
 .../net/srv6_end_x_next_csid_l3vpn_test.sh    | 83 +++++--------------
 .../net/srv6_hencap_red_l3vpn_test.sh         | 74 ++++-------------
 .../net/srv6_hl2encap_red_l2vpn_test.sh       | 77 ++++-------------
 6 files changed, 73 insertions(+), 248 deletions(-)

diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
index 02d617040793..a5e959a080bb 100755
--- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
@@ -285,11 +285,6 @@ setup_hs()
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.default.accept_dad=0
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.default.rp_filter=0
-
 	ip -netns ${hsname} link add veth0 type veth peer name ${rtveth}
 	ip -netns ${hsname} link set ${rtveth} netns ${rtname}
 	ip -netns ${hsname} addr add ${IPv6_HS_NETWORK}::${hid}/64 dev veth0 nodad
diff --git a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
index 79fb81e63c59..a649dba3cb77 100755
--- a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
@@ -250,11 +250,6 @@ setup_hs()
 	eval local rtname=\${rt_${rid}}
 	local rtveth=veth-t${tid}
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.default.rp_filter=0
-
 	ip -netns ${hsname} link add veth0 type veth peer name ${rtveth}
 	ip -netns ${hsname} link set ${rtveth} netns ${rtname}
 	ip -netns ${hsname} addr add ${IPv4_HS_NETWORK}.${hid}/24 dev veth0
diff --git a/tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh
index 87e414cc417c..ba730655a7bf 100755
--- a/tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh
@@ -245,10 +245,8 @@
 # that adopted in the use cases already examined (of course, it is necessary to
 # consider the different SIDs/C-SIDs).
 
-# Kselftest framework requirement - SKIP code is 4.
-readonly ksft_skip=4
+source lib.sh
 
-readonly RDMSUFF="$(mktemp -u XXXXXXXX)"
 readonly DUMMY_DEVNAME="dum0"
 readonly VRF_TID=100
 readonly VRF_DEVNAME="vrf-${VRF_TID}"
@@ -376,32 +374,18 @@ test_command_or_ksft_skip()
 	fi
 }
 
-get_nodename()
-{
-	local name="$1"
-
-	echo "${name}-${RDMSUFF}"
-}
-
 get_rtname()
 {
 	local rtid="$1"
 
-	get_nodename "rt-${rtid}"
+	echo "rt_${rtid}"
 }
 
 get_hsname()
 {
 	local hsid="$1"
 
-	get_nodename "hs-${hsid}"
-}
-
-__create_namespace()
-{
-	local name="$1"
-
-	ip netns add "${name}"
+	echo "hs_${hsid}"
 }
 
 create_router()
@@ -410,8 +394,7 @@ create_router()
 	local nsname
 
 	nsname="$(get_rtname "${rtid}")"
-
-	__create_namespace "${nsname}"
+	setup_ns "${nsname}"
 }
 
 create_host()
@@ -420,28 +403,12 @@ create_host()
 	local nsname
 
 	nsname="$(get_hsname "${hsid}")"
-
-	__create_namespace "${nsname}"
+	setup_ns "${nsname}"
 }
 
 cleanup()
 {
-	local nsname
-	local i
-
-	# destroy routers
-	for i in ${ROUTERS}; do
-		nsname="$(get_rtname "${i}")"
-
-		ip netns del "${nsname}" &>/dev/null || true
-	done
-
-	# destroy hosts
-	for i in ${HOSTS}; do
-		nsname="$(get_hsname "${i}")"
-
-		ip netns del "${nsname}" &>/dev/null || true
-	done
+	cleanup_all_ns
 
 	# check whether the setup phase was completed successfully or not. In
 	# case of an error during the setup phase of the testing environment,
@@ -462,10 +429,10 @@ add_link_rt_pairs()
 	local nsname
 	local neigh_nsname
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
-		neigh_nsname="$(get_rtname "${neigh}")"
+		eval neigh_nsname=\${$(get_rtname "${neigh}")}
 
 		ip link add "veth-rt-${rt}-${neigh}" netns "${nsname}" \
 			type veth peer name "veth-rt-${neigh}-${rt}" \
@@ -497,7 +464,7 @@ setup_rt_networking()
 	local devname
 	local neigh
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
 		devname="veth-rt-${rt}-${neigh}"
@@ -518,9 +485,6 @@ setup_rt_networking()
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.forwarding=1
-
-	ip netns exec "${nsname}" sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${nsname}" sysctl -wq net.ipv4.conf.default.rp_filter=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv4.ip_forward=1
 }
 
@@ -596,7 +560,7 @@ setup_rt_local_sids()
 	local lcnode_func_prefix
 	local lcblock_prefix
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
 		devname="veth-rt-${rt}-${neigh}"
@@ -668,8 +632,8 @@ __setup_l3vpn()
 	local rtsrc_nsname
 	local rtdst_nsname
 
-	rtsrc_nsname="$(get_rtname "${src}")"
-	rtdst_nsname="$(get_rtname "${dst}")"
+	eval rtsrc_nsname=\${$(get_rtname "${src}")}
+	eval rtdst_nsname=\${$(get_rtname "${dst}")}
 
 	container="${LCBLOCK_ADDR}"
 
@@ -744,8 +708,8 @@ setup_hs()
 	local hsname
 	local rtname
 
-	hsname="$(get_hsname "${hs}")"
-	rtname="$(get_rtname "${rt}")"
+	eval hsname=\${$(get_hsname "${hs}")}
+	eval rtname=\${$(get_rtname "${rt}")}
 
 	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
@@ -791,11 +755,6 @@ setup_hs()
 	ip netns exec "${rtname}" \
 		sysctl -wq net.ipv4.conf."${RT2HS_DEVNAME}".proxy_arp=1
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec "${rtname}" \
-		sysctl -wq net.ipv4.conf."${RT2HS_DEVNAME}".rp_filter=0
-
 	ip netns exec "${rtname}" sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
 }
 
@@ -880,7 +839,7 @@ check_rt_connectivity()
 	local prefix
 	local rtsrc_nsname
 
-	rtsrc_nsname="$(get_rtname "${rtsrc}")"
+	eval rtsrc_nsname=\${$(get_rtname "${rtsrc}")}
 
 	prefix="$(get_network_prefix "${rtsrc}" "${rtdst}")"
 
@@ -903,7 +862,7 @@ check_hs_ipv6_connectivity()
 	local hsdst="$2"
 	local hssrc_nsname
 
-	hssrc_nsname="$(get_hsname "${hssrc}")"
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
 
 	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
 		"${IPv6_HS_NETWORK}::${hsdst}" >/dev/null 2>&1
@@ -915,7 +874,7 @@ check_hs_ipv4_connectivity()
 	local hsdst="$2"
 	local hssrc_nsname
 
-	hssrc_nsname="$(get_hsname "${hssrc}")"
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
 
 	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
 		"${IPv4_HS_NETWORK}.${hsdst}" >/dev/null 2>&1
@@ -1025,7 +984,7 @@ rt_x_nextcsid_end_behavior_test()
 	local nsname
 	local ret
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	__nextcsid_end_behavior_test "${nsname}" "add" "${blen}" "${flen}"
 	ret="$?"
diff --git a/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
index c79cb8ede17f..4b86040c58c6 100755
--- a/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
@@ -287,10 +287,8 @@
 # packet using the SRv6 End.DT46 behavior (associated with the SID fcff:1::d46)
 # and sends it to the host hs-1.
 
-# Kselftest framework requirement - SKIP code is 4.
-readonly ksft_skip=4
+source lib.sh
 
-readonly RDMSUFF="$(mktemp -u XXXXXXXX)"
 readonly DUMMY_DEVNAME="dum0"
 readonly VRF_TID=100
 readonly VRF_DEVNAME="vrf-${VRF_TID}"
@@ -418,32 +416,18 @@ test_command_or_ksft_skip()
 	fi
 }
 
-get_nodename()
-{
-	local name="$1"
-
-	echo "${name}-${RDMSUFF}"
-}
-
 get_rtname()
 {
 	local rtid="$1"
 
-	get_nodename "rt-${rtid}"
+	echo "rt_${rtid}"
 }
 
 get_hsname()
 {
 	local hsid="$1"
 
-	get_nodename "hs-${hsid}"
-}
-
-__create_namespace()
-{
-	local name="$1"
-
-	ip netns add "${name}"
+	echo "hs_${hsid}"
 }
 
 create_router()
@@ -452,15 +436,12 @@ create_router()
 	local nsname
 
 	nsname="$(get_rtname "${rtid}")"
+	setup_ns "${nsname}"
 
-	__create_namespace "${nsname}"
-
+	eval nsname=\${$(get_rtname "${rtid}")}
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.forwarding=1
-
-	ip netns exec "${nsname}" sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${nsname}" sysctl -wq net.ipv4.conf.default.rp_filter=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv4.ip_forward=1
 }
 
@@ -470,29 +451,12 @@ create_host()
 	local nsname
 
 	nsname="$(get_hsname "${hsid}")"
-
-	__create_namespace "${nsname}"
+	setup_ns "${nsname}"
 }
 
 cleanup()
 {
-	local nsname
-	local i
-
-	# destroy routers
-	for i in ${ROUTERS}; do
-		nsname="$(get_rtname "${i}")"
-
-		ip netns del "${nsname}" &>/dev/null || true
-	done
-
-	# destroy hosts
-	for i in ${HOSTS}; do
-		nsname="$(get_hsname "${i}")"
-
-		ip netns del "${nsname}" &>/dev/null || true
-	done
-
+	cleanup_all_ns
 	# check whether the setup phase was completed successfully or not. In
 	# case of an error during the setup phase of the testing environment,
 	# the selftest is considered as "skipped".
@@ -512,10 +476,10 @@ add_link_rt_pairs()
 	local nsname
 	local neigh_nsname
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
-		neigh_nsname="$(get_rtname "${neigh}")"
+		eval neigh_nsname=\${$(get_rtname "${neigh}")}
 
 		ip link add "veth-rt-${rt}-${neigh}" netns "${nsname}" \
 			type veth peer name "veth-rt-${neigh}-${rt}" \
@@ -547,7 +511,7 @@ setup_rt_networking()
 	local devname
 	local neigh
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
 		devname="veth-rt-${rt}-${neigh}"
@@ -631,7 +595,7 @@ set_end_x_nextcsid()
 	local rt="$1"
 	local adj="$2"
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 	net_prefix="$(get_network_prefix "${rt}" "${adj}")"
 	lcnode_func_prefix="$(build_lcnode_func_prefix "${rt}")"
 
@@ -650,7 +614,7 @@ set_underlay_sids_reachability()
 	local rt="$1"
 	local rt_neighs="$2"
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
 		devname="veth-rt-${rt}-${neigh}"
@@ -685,7 +649,7 @@ setup_rt_local_sids()
 	local lcnode_func_prefix
 	local lcblock_prefix
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
         set_underlay_sids_reachability "${rt}" "${rt_neighs}"
 
@@ -728,8 +692,8 @@ __setup_l3vpn()
 	local rtsrc_nsname
 	local rtdst_nsname
 
-	rtsrc_nsname="$(get_rtname "${src}")"
-	rtdst_nsname="$(get_rtname "${dst}")"
+	eval rtsrc_nsname=\${$(get_rtname "${src}")}
+	eval rtdst_nsname=\${$(get_rtname "${dst}")}
 
 	container="${LCBLOCK_ADDR}"
 
@@ -804,8 +768,8 @@ setup_hs()
 	local hsname
 	local rtname
 
-	hsname="$(get_hsname "${hs}")"
-	rtname="$(get_rtname "${rt}")"
+	eval hsname=\${$(get_hsname "${hs}")}
+	eval rtname=\${$(get_rtname "${rt}")}
 
 	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
@@ -851,11 +815,6 @@ setup_hs()
 	ip netns exec "${rtname}" \
 		sysctl -wq net.ipv4.conf."${RT2HS_DEVNAME}".proxy_arp=1
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec "${rtname}" \
-		sysctl -wq net.ipv4.conf."${RT2HS_DEVNAME}".rp_filter=0
-
 	ip netns exec "${rtname}" sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
 }
 
@@ -947,7 +906,7 @@ check_rt_connectivity()
 	local prefix
 	local rtsrc_nsname
 
-	rtsrc_nsname="$(get_rtname "${rtsrc}")"
+	eval rtsrc_nsname=\${$(get_rtname "${rtsrc}")}
 
 	prefix="$(get_network_prefix "${rtsrc}" "${rtdst}")"
 
@@ -970,7 +929,7 @@ check_hs_ipv6_connectivity()
 	local hsdst="$2"
 	local hssrc_nsname
 
-	hssrc_nsname="$(get_hsname "${hssrc}")"
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
 
 	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
 		"${IPv6_HS_NETWORK}::${hsdst}" >/dev/null 2>&1
@@ -982,7 +941,7 @@ check_hs_ipv4_connectivity()
 	local hsdst="$2"
 	local hssrc_nsname
 
-	hssrc_nsname="$(get_hsname "${hssrc}")"
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
 
 	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
 		"${IPv4_HS_NETWORK}.${hsdst}" >/dev/null 2>&1
@@ -1093,7 +1052,7 @@ rt_x_nextcsid_end_x_behavior_test()
 	local nsname
 	local ret
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	__nextcsid_end_x_behavior_test "${nsname}" "add" "${blen}" "${flen}"
 	ret="$?"
diff --git a/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh b/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
index 28a775654b92..3efce1718c5f 100755
--- a/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
@@ -166,10 +166,8 @@
 #  hs-4->hs-3 |IPv6 DA=fcff:1::e|SRH SIDs=fcff:3::d46|IPv6|...| (i.d)
 #
 
-# Kselftest framework requirement - SKIP code is 4.
-readonly ksft_skip=4
+source lib.sh
 
-readonly RDMSUFF="$(mktemp -u XXXXXXXX)"
 readonly VRF_TID=100
 readonly VRF_DEVNAME="vrf-${VRF_TID}"
 readonly RT2HS_DEVNAME="veth-t${VRF_TID}"
@@ -248,32 +246,18 @@ test_command_or_ksft_skip()
 	fi
 }
 
-get_nodename()
-{
-	local name="$1"
-
-	echo "${name}-${RDMSUFF}"
-}
-
 get_rtname()
 {
 	local rtid="$1"
 
-	get_nodename "rt-${rtid}"
+	echo "rt_${rtid}"
 }
 
 get_hsname()
 {
 	local hsid="$1"
 
-	get_nodename "hs-${hsid}"
-}
-
-__create_namespace()
-{
-	local name="$1"
-
-	ip netns add "${name}"
+	echo "hs_${hsid}"
 }
 
 create_router()
@@ -282,8 +266,7 @@ create_router()
 	local nsname
 
 	nsname="$(get_rtname "${rtid}")"
-
-	__create_namespace "${nsname}"
+	setup_ns "${nsname}"
 }
 
 create_host()
@@ -292,29 +275,12 @@ create_host()
 	local nsname
 
 	nsname="$(get_hsname "${hsid}")"
-
-	__create_namespace "${nsname}"
+	setup_ns "${nsname}"
 }
 
 cleanup()
 {
-	local nsname
-	local i
-
-	# destroy routers
-	for i in ${ROUTERS}; do
-		nsname="$(get_rtname "${i}")"
-
-		ip netns del "${nsname}" &>/dev/null || true
-	done
-
-	# destroy hosts
-	for i in ${HOSTS}; do
-		nsname="$(get_hsname "${i}")"
-
-		ip netns del "${nsname}" &>/dev/null || true
-	done
-
+	cleanup_all_ns
 	# check whether the setup phase was completed successfully or not. In
 	# case of an error during the setup phase of the testing environment,
 	# the selftest is considered as "skipped".
@@ -334,10 +300,10 @@ add_link_rt_pairs()
 	local nsname
 	local neigh_nsname
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
-		neigh_nsname="$(get_rtname "${neigh}")"
+		eval neigh_nsname=\${$(get_rtname "${neigh}")}
 
 		ip link add "veth-rt-${rt}-${neigh}" netns "${nsname}" \
 			type veth peer name "veth-rt-${neigh}-${rt}" \
@@ -369,7 +335,7 @@ setup_rt_networking()
 	local devname
 	local neigh
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
 		devname="veth-rt-${rt}-${neigh}"
@@ -387,9 +353,6 @@ setup_rt_networking()
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.forwarding=1
-
-	ip netns exec "${nsname}" sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${nsname}" sysctl -wq net.ipv4.conf.default.rp_filter=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv4.ip_forward=1
 }
 
@@ -403,7 +366,7 @@ setup_rt_local_sids()
 	local nsname
 	local neigh
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
 		devname="veth-rt-${rt}-${neigh}"
@@ -469,7 +432,7 @@ __setup_rt_policy()
 	local policy=''
 	local n
 
-	nsname="$(get_rtname "${encap_rt}")"
+	eval nsname=\${$(get_rtname "${encap_rt}")}
 
 	for n in ${end_rts}; do
 		policy="${policy}${VPN_LOCATOR_SERVICE}:${n}::${END_FUNC},"
@@ -516,8 +479,8 @@ setup_hs()
 	local hsname
 	local rtname
 
-	hsname="$(get_hsname "${hs}")"
-	rtname="$(get_rtname "${rt}")"
+	eval hsname=\${$(get_hsname "${hs}")}
+	eval rtname=\${$(get_rtname "${rt}")}
 
 	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
@@ -555,11 +518,6 @@ setup_hs()
 	ip netns exec "${rtname}" \
 		sysctl -wq net.ipv4.conf."${RT2HS_DEVNAME}".proxy_arp=1
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec "${rtname}" \
-		sysctl -wq net.ipv4.conf."${RT2HS_DEVNAME}".rp_filter=0
-
 	ip netns exec "${rtname}" sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
 }
 
@@ -656,7 +614,7 @@ check_rt_connectivity()
 	local prefix
 	local rtsrc_nsname
 
-	rtsrc_nsname="$(get_rtname "${rtsrc}")"
+	eval rtsrc_nsname=\${$(get_rtname "${rtsrc}")}
 
 	prefix="$(get_network_prefix "${rtsrc}" "${rtdst}")"
 
@@ -679,7 +637,7 @@ check_hs_ipv6_connectivity()
 	local hsdst="$2"
 	local hssrc_nsname
 
-	hssrc_nsname="$(get_hsname "${hssrc}")"
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
 
 	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
 		"${IPv6_HS_NETWORK}::${hsdst}" >/dev/null 2>&1
@@ -691,7 +649,7 @@ check_hs_ipv4_connectivity()
 	local hsdst="$2"
 	local hssrc_nsname
 
-	hssrc_nsname="$(get_hsname "${hssrc}")"
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
 
 	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
 		"${IPv4_HS_NETWORK}.${hsdst}" >/dev/null 2>&1
diff --git a/tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh b/tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh
index cb4177d41b21..c08a744bf404 100755
--- a/tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh
@@ -116,10 +116,8 @@
 #  hs-2->hs-1 |IPv6 DA=fcff:4::e|SRH SIDs=fcff:3::e,fcff:1::d2|eth|...| (i.b)
 #
 
-# Kselftest framework requirement - SKIP code is 4.
-readonly ksft_skip=4
+source lib.sh
 
-readonly RDMSUFF="$(mktemp -u XXXXXXXX)"
 readonly DUMMY_DEVNAME="dum0"
 readonly RT2HS_DEVNAME="veth-hs"
 readonly HS_VETH_NAME="veth0"
@@ -199,32 +197,18 @@ test_command_or_ksft_skip()
 	fi
 }
 
-get_nodename()
-{
-	local name="$1"
-
-	echo "${name}-${RDMSUFF}"
-}
-
 get_rtname()
 {
 	local rtid="$1"
 
-	get_nodename "rt-${rtid}"
+	echo "rt_${rtid}"
 }
 
 get_hsname()
 {
 	local hsid="$1"
 
-	get_nodename "hs-${hsid}"
-}
-
-__create_namespace()
-{
-	local name="$1"
-
-	ip netns add "${name}"
+	echo "hs_${hsid}"
 }
 
 create_router()
@@ -233,8 +217,7 @@ create_router()
 	local nsname
 
 	nsname="$(get_rtname "${rtid}")"
-
-	__create_namespace "${nsname}"
+	setup_ns "${nsname}"
 }
 
 create_host()
@@ -243,28 +226,12 @@ create_host()
 	local nsname
 
 	nsname="$(get_hsname "${hsid}")"
-
-	__create_namespace "${nsname}"
+	setup_ns "${nsname}"
 }
 
 cleanup()
 {
-	local nsname
-	local i
-
-	# destroy routers
-	for i in ${ROUTERS}; do
-		nsname="$(get_rtname "${i}")"
-
-		ip netns del "${nsname}" &>/dev/null || true
-	done
-
-	# destroy hosts
-	for i in ${HOSTS}; do
-		nsname="$(get_hsname "${i}")"
-
-		ip netns del "${nsname}" &>/dev/null || true
-	done
+	cleanup_all_ns
 
 	# check whether the setup phase was completed successfully or not. In
 	# case of an error during the setup phase of the testing environment,
@@ -285,10 +252,10 @@ add_link_rt_pairs()
 	local nsname
 	local neigh_nsname
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
-		neigh_nsname="$(get_rtname "${neigh}")"
+		eval neigh_nsname=\${$(get_rtname "${neigh}")}
 
 		ip link add "veth-rt-${rt}-${neigh}" netns "${nsname}" \
 			type veth peer name "veth-rt-${neigh}-${rt}" \
@@ -320,7 +287,7 @@ setup_rt_networking()
 	local devname
 	local neigh
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
 		devname="veth-rt-${rt}-${neigh}"
@@ -341,9 +308,6 @@ setup_rt_networking()
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.forwarding=1
-
-	ip netns exec "${nsname}" sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${nsname}" sysctl -wq net.ipv4.conf.default.rp_filter=0
 	ip netns exec "${nsname}" sysctl -wq net.ipv4.ip_forward=1
 }
 
@@ -357,7 +321,7 @@ setup_rt_local_sids()
 	local nsname
 	local neigh
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	for neigh in ${rt_neighs}; do
 		devname="veth-rt-${rt}-${neigh}"
@@ -407,7 +371,7 @@ __setup_rt_policy()
 	local policy=''
 	local n
 
-	nsname="$(get_rtname "${encap_rt}")"
+	eval nsname=\${$(get_rtname "${encap_rt}")}
 
 	for n in ${end_rts}; do
 		policy="${policy}${VPN_LOCATOR_SERVICE}:${n}::${END_FUNC},"
@@ -446,7 +410,7 @@ setup_decap()
 	local rt="$1"
 	local nsname
 
-	nsname="$(get_rtname "${rt}")"
+	eval nsname=\${$(get_rtname "${rt}")}
 
 	# Local End.DX2 behavior
 	ip -netns "${nsname}" -6 route \
@@ -463,8 +427,8 @@ setup_hs()
 	local hsname
 	local rtname
 
-	hsname="$(get_hsname "${hs}")"
-	rtname="$(get_rtname "${rt}")"
+	eval hsname=\${$(get_hsname "${hs}")}
+	eval rtname=\${$(get_rtname "${rt}")}
 
 	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
@@ -486,11 +450,6 @@ setup_hs()
 		add "${IPv4_HS_NETWORK}.254/24" dev "${RT2HS_DEVNAME}"
 
 	ip -netns "${rtname}" link set "${RT2HS_DEVNAME}" up
-
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec "${rtname}" \
-		sysctl -wq net.ipv4.conf."${RT2HS_DEVNAME}".rp_filter=0
 }
 
 # set an auto-generated mac address
@@ -532,7 +491,7 @@ set_host_l2peer()
 	local hssrc_name
 	local ipaddr
 
-	hssrc_name="$(get_hsname "${hssrc}")"
+	eval hssrc_name=\${$(get_hsname "${hssrc}")}
 
 	if [ "${proto}" -eq 6 ]; then
 		ipaddr="${ipprefix}::${hsdst}"
@@ -647,7 +606,7 @@ check_rt_connectivity()
 	local prefix
 	local rtsrc_nsname
 
-	rtsrc_nsname="$(get_rtname "${rtsrc}")"
+	eval rtsrc_nsname=\${$(get_rtname "${rtsrc}")}
 
 	prefix="$(get_network_prefix "${rtsrc}" "${rtdst}")"
 
@@ -670,7 +629,7 @@ check_hs_ipv6_connectivity()
 	local hsdst="$2"
 	local hssrc_nsname
 
-	hssrc_nsname="$(get_hsname "${hssrc}")"
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
 
 	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
 		"${IPv6_HS_NETWORK}::${hsdst}" >/dev/null 2>&1
@@ -682,7 +641,7 @@ check_hs_ipv4_connectivity()
 	local hsdst="$2"
 	local hssrc_nsname
 
-	hssrc_nsname="$(get_hsname "${hssrc}")"
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
 
 	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
 		"${IPv4_HS_NETWORK}.${hsdst}" >/dev/null 2>&1
-- 
2.46.0


