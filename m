Return-Path: <linux-kselftest+bounces-1235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAE88067F4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85884282375
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3B112E54;
	Wed,  6 Dec 2023 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrwe2Xia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D0D4F;
	Tue,  5 Dec 2023 23:08:23 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58d956c8c38so4325047eaf.2;
        Tue, 05 Dec 2023 23:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846502; x=1702451302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYos/olSJFawpPWA1MoshGDqtX8grpMKgvpvrIXvZY4=;
        b=hrwe2XiaOGWK2JxmC30CtDMFkNpy5vXkgShYorEaIjOR117mdUyIPRVnjaEK5+5C6F
         5KYtMTB0Tlu0NSeE2pESJSb/2QRAZLlguECpvtBfaIWMTegjzdiuGXB6uThryeHIKhRu
         sNMslcg+gP7lzwgMXXvM1ohwj2ihCbIsUXHhnhUM1DSiLblzqzGalQsmd3acNvnp5Rbw
         iIOUtV3C7nKJRwfTrxDmyMD62PdMI7nVRWxQ3ifNpWM/RAfgsrcdpsU0N9dwQXl/gChc
         7JPPJyNOfR4nmEBLxQTjXeT80oPBdaw6YzVO0kp77z7fa6lJKkvZrXpHKkfTEZhDnNj0
         xCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846502; x=1702451302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYos/olSJFawpPWA1MoshGDqtX8grpMKgvpvrIXvZY4=;
        b=Vmv4HKyUObFoRfe/EbmSYW5HDH84ceTfIIlENAyGtAGgBnAZFz3mfqRaiA3+Vn8SX7
         xFlFNYtXh9bGJ9TDOl3b/pflWC5iqqAwyavy9ZBDorxXnLZ7WCIY9C1Mw+zrSNWfuLY+
         tEm0mbhAIJubVujVHs0r3gJxkjdXDzQNwYrOWcv+ozaFVVgSA4xLa44yrHmV6VhU98eB
         77Kj7ADKtdrhIhkLm/ZBNervyxgrsETdfUqVCD2y/84P2p9U4YtQdrXPgIpB6Qzu0ixR
         bLTsSdwNTg6zn5TDax069SAEcmEGeQNTSY6zkm8Akd0rdpFmPL00+lhBQz17oZRRuuHT
         fOAQ==
X-Gm-Message-State: AOJu0YzpV0NZfZAFzIfy25I4SqWX8eI17+VwmbqAXSeWvHKrRj8Dgz2s
	xv7IVRyaFQMjvMPF4vXFAjZnTFFHf3yq6F3z
X-Google-Smtp-Source: AGHT+IHjTP8rzbqQUNA5VGH9GNlXU3iYQduePMs3UyjDxTlCg/S/tu5qVsqZaQ970X+7kjpdPPgOTA==
X-Received: by 2002:a05:6358:6502:b0:170:17ea:f4d9 with SMTP id v2-20020a056358650200b0017017eaf4d9mr641962rwg.38.1701846502146;
        Tue, 05 Dec 2023 23:08:22 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:21 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Roopa Prabhu <roopa@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 3/9] selftests/net: convert test_vxlan_mdb.sh to run it in unique namespace
Date: Wed,  6 Dec 2023 15:07:55 +0800
Message-ID: <20231206070801.1691247-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206070801.1691247-1-liuhangbin@gmail.com>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./test_vxlan_mdb.sh

Control path: Basic (*, G) operations - IPv4 overlay / IPv4 underlay
--------------------------------------------------------------------
TEST: MDB entry addition                                            [ OK ]

...

Data path: MDB torture test - IPv6 overlay / IPv6 underlay
----------------------------------------------------------
TEST: Torture test                                                  [ OK ]

Tests passed: 620
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/test_vxlan_mdb.sh | 202 +++++++++---------
 1 file changed, 99 insertions(+), 103 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_mdb.sh b/tools/testing/selftests/net/test_vxlan_mdb.sh
index 6e996f8063cd..6725fd9157b9 100755
--- a/tools/testing/selftests/net/test_vxlan_mdb.sh
+++ b/tools/testing/selftests/net/test_vxlan_mdb.sh
@@ -55,9 +55,8 @@
 # | ns2_v4                             | | ns2_v6                             |
 # +------------------------------------+ +------------------------------------+
 
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 CONTROL_PATH_TESTS="
 	basic_star_g_ipv4_ipv4
@@ -260,9 +259,6 @@ setup_common()
 	local local_addr1=$1; shift
 	local local_addr2=$1; shift
 
-	ip netns add $ns1
-	ip netns add $ns2
-
 	ip link add name veth0 type veth peer name veth1
 	ip link set dev veth0 netns $ns1 name veth0
 	ip link set dev veth1 netns $ns2 name veth0
@@ -273,36 +269,36 @@ setup_common()
 
 setup_v4()
 {
-	setup_common ns1_v4 ns2_v4 192.0.2.1 192.0.2.2
+	setup_ns ns1_v4 ns2_v4
+	setup_common $ns1_v4 $ns2_v4 192.0.2.1 192.0.2.2
 
-	ip -n ns1_v4 address add 192.0.2.17/28 dev veth0
-	ip -n ns2_v4 address add 192.0.2.18/28 dev veth0
+	ip -n $ns1_v4 address add 192.0.2.17/28 dev veth0
+	ip -n $ns2_v4 address add 192.0.2.18/28 dev veth0
 
-	ip -n ns1_v4 route add default via 192.0.2.18
-	ip -n ns2_v4 route add default via 192.0.2.17
+	ip -n $ns1_v4 route add default via 192.0.2.18
+	ip -n $ns2_v4 route add default via 192.0.2.17
 }
 
 cleanup_v4()
 {
-	ip netns del ns2_v4
-	ip netns del ns1_v4
+	cleanup_ns $ns2_v4 $ns1_v4
 }
 
 setup_v6()
 {
-	setup_common ns1_v6 ns2_v6 2001:db8:1::1 2001:db8:1::2
+	setup_ns ns1_v6 ns2_v6
+	setup_common $ns1_v6 $ns2_v6 2001:db8:1::1 2001:db8:1::2
 
-	ip -n ns1_v6 address add 2001:db8:2::1/64 dev veth0 nodad
-	ip -n ns2_v6 address add 2001:db8:2::2/64 dev veth0 nodad
+	ip -n $ns1_v6 address add 2001:db8:2::1/64 dev veth0 nodad
+	ip -n $ns2_v6 address add 2001:db8:2::2/64 dev veth0 nodad
 
-	ip -n ns1_v6 route add default via 2001:db8:2::2
-	ip -n ns2_v6 route add default via 2001:db8:2::1
+	ip -n $ns1_v6 route add default via 2001:db8:2::2
+	ip -n $ns2_v6 route add default via 2001:db8:2::1
 }
 
 cleanup_v6()
 {
-	ip netns del ns2_v6
-	ip netns del ns1_v6
+	cleanup_ns $ns2_v6 $ns1_v6
 }
 
 setup()
@@ -433,7 +429,7 @@ basic_common()
 
 basic_star_g_ipv4_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local grp_key="grp 239.1.1.1"
 	local vtep_ip=198.51.100.100
 
@@ -446,7 +442,7 @@ basic_star_g_ipv4_ipv4()
 
 basic_star_g_ipv6_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local grp_key="grp ff0e::1"
 	local vtep_ip=198.51.100.100
 
@@ -459,7 +455,7 @@ basic_star_g_ipv6_ipv4()
 
 basic_star_g_ipv4_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local grp_key="grp 239.1.1.1"
 	local vtep_ip=2001:db8:1000::1
 
@@ -472,7 +468,7 @@ basic_star_g_ipv4_ipv6()
 
 basic_star_g_ipv6_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local grp_key="grp ff0e::1"
 	local vtep_ip=2001:db8:1000::1
 
@@ -485,7 +481,7 @@ basic_star_g_ipv6_ipv6()
 
 basic_sg_ipv4_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local grp_key="grp 239.1.1.1 src 192.0.2.129"
 	local vtep_ip=198.51.100.100
 
@@ -498,7 +494,7 @@ basic_sg_ipv4_ipv4()
 
 basic_sg_ipv6_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local grp_key="grp ff0e::1 src 2001:db8:100::1"
 	local vtep_ip=198.51.100.100
 
@@ -511,7 +507,7 @@ basic_sg_ipv6_ipv4()
 
 basic_sg_ipv4_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local grp_key="grp 239.1.1.1 src 192.0.2.129"
 	local vtep_ip=2001:db8:1000::1
 
@@ -524,7 +520,7 @@ basic_sg_ipv4_ipv6()
 
 basic_sg_ipv6_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local grp_key="grp ff0e::1 src 2001:db8:100::1"
 	local vtep_ip=2001:db8:1000::1
 
@@ -694,7 +690,7 @@ star_g_common()
 
 star_g_ipv4_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local grp=239.1.1.1
 	local src1=192.0.2.129
 	local src2=192.0.2.130
@@ -711,7 +707,7 @@ star_g_ipv4_ipv4()
 
 star_g_ipv6_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local grp=ff0e::1
 	local src1=2001:db8:100::1
 	local src2=2001:db8:100::2
@@ -728,7 +724,7 @@ star_g_ipv6_ipv4()
 
 star_g_ipv4_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local grp=239.1.1.1
 	local src1=192.0.2.129
 	local src2=192.0.2.130
@@ -745,7 +741,7 @@ star_g_ipv4_ipv6()
 
 star_g_ipv6_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local grp=ff0e::1
 	local src1=2001:db8:100::1
 	local src2=2001:db8:100::2
@@ -793,7 +789,7 @@ sg_common()
 
 sg_ipv4_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local grp=239.1.1.1
 	local src=192.0.2.129
 	local vtep_ip=198.51.100.100
@@ -808,7 +804,7 @@ sg_ipv4_ipv4()
 
 sg_ipv6_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local grp=ff0e::1
 	local src=2001:db8:100::1
 	local vtep_ip=198.51.100.100
@@ -823,7 +819,7 @@ sg_ipv6_ipv4()
 
 sg_ipv4_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local grp=239.1.1.1
 	local src=192.0.2.129
 	local vtep_ip=2001:db8:1000::1
@@ -838,7 +834,7 @@ sg_ipv4_ipv6()
 
 sg_ipv6_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local grp=ff0e::1
 	local src=2001:db8:100::1
 	local vtep_ip=2001:db8:1000::1
@@ -918,7 +914,7 @@ dump_common()
 
 dump_ipv4_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local local_addr=192.0.2.1
 	local remote_prefix=198.51.100.
 	local fn=ipv4_grps_get
@@ -932,7 +928,7 @@ dump_ipv4_ipv4()
 
 dump_ipv6_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local local_addr=192.0.2.1
 	local remote_prefix=198.51.100.
 	local fn=ipv6_grps_get
@@ -946,7 +942,7 @@ dump_ipv6_ipv4()
 
 dump_ipv4_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local local_addr=2001:db8:1::1
 	local remote_prefix=2001:db8:1000::
 	local fn=ipv4_grps_get
@@ -960,7 +956,7 @@ dump_ipv4_ipv6()
 
 dump_ipv6_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local local_addr=2001:db8:1::1
 	local remote_prefix=2001:db8:1000::
 	local fn=ipv6_grps_get
@@ -1072,8 +1068,8 @@ encap_params_common()
 
 encap_params_ipv4_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local plen=32
@@ -1091,8 +1087,8 @@ encap_params_ipv4_ipv4()
 
 encap_params_ipv6_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local plen=32
@@ -1110,8 +1106,8 @@ encap_params_ipv6_ipv4()
 
 encap_params_ipv4_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
@@ -1129,8 +1125,8 @@ encap_params_ipv4_ipv6()
 
 encap_params_ipv6_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
@@ -1208,8 +1204,8 @@ starg_exclude_ir_common()
 
 starg_exclude_ir_ipv4_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local plen=32
@@ -1227,8 +1223,8 @@ starg_exclude_ir_ipv4_ipv4()
 
 starg_exclude_ir_ipv6_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local plen=32
@@ -1246,8 +1242,8 @@ starg_exclude_ir_ipv6_ipv4()
 
 starg_exclude_ir_ipv4_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
@@ -1265,8 +1261,8 @@ starg_exclude_ir_ipv4_ipv6()
 
 starg_exclude_ir_ipv6_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
@@ -1344,8 +1340,8 @@ starg_include_ir_common()
 
 starg_include_ir_ipv4_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local plen=32
@@ -1363,8 +1359,8 @@ starg_include_ir_ipv4_ipv4()
 
 starg_include_ir_ipv6_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local plen=32
@@ -1382,8 +1378,8 @@ starg_include_ir_ipv6_ipv4()
 
 starg_include_ir_ipv4_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
@@ -1401,8 +1397,8 @@ starg_include_ir_ipv4_ipv6()
 
 starg_include_ir_ipv6_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
@@ -1462,8 +1458,8 @@ starg_exclude_p2mp_common()
 
 starg_exclude_p2mp_ipv4_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local grp=239.1.1.1
@@ -1480,8 +1476,8 @@ starg_exclude_p2mp_ipv4_ipv4()
 
 starg_exclude_p2mp_ipv6_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local grp=ff0e::1
@@ -1498,8 +1494,8 @@ starg_exclude_p2mp_ipv6_ipv4()
 
 starg_exclude_p2mp_ipv4_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local mcast_grp=ff0e::2
 	local plen=128
 	local grp=239.1.1.1
@@ -1516,8 +1512,8 @@ starg_exclude_p2mp_ipv4_ipv6()
 
 starg_exclude_p2mp_ipv6_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local mcast_grp=ff0e::2
 	local plen=128
 	local grp=ff0e::1
@@ -1576,8 +1572,8 @@ starg_include_p2mp_common()
 
 starg_include_p2mp_ipv4_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local grp=239.1.1.1
@@ -1594,8 +1590,8 @@ starg_include_p2mp_ipv4_ipv4()
 
 starg_include_p2mp_ipv6_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local grp=ff0e::1
@@ -1612,8 +1608,8 @@ starg_include_p2mp_ipv6_ipv4()
 
 starg_include_p2mp_ipv4_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local mcast_grp=ff0e::2
 	local plen=128
 	local grp=239.1.1.1
@@ -1630,8 +1626,8 @@ starg_include_p2mp_ipv4_ipv6()
 
 starg_include_p2mp_ipv6_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local mcast_grp=ff0e::2
 	local plen=128
 	local grp=ff0e::1
@@ -1709,8 +1705,8 @@ egress_vni_translation_common()
 
 egress_vni_translation_ipv4_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local proto="ipv4"
@@ -1727,8 +1723,8 @@ egress_vni_translation_ipv4_ipv4()
 
 egress_vni_translation_ipv6_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local mcast_grp=238.1.1.1
 	local plen=32
 	local proto="ipv6"
@@ -1745,8 +1741,8 @@ egress_vni_translation_ipv6_ipv4()
 
 egress_vni_translation_ipv4_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local mcast_grp=ff0e::2
 	local plen=128
 	local proto="ipv4"
@@ -1763,8 +1759,8 @@ egress_vni_translation_ipv4_ipv6()
 
 egress_vni_translation_ipv6_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local mcast_grp=ff0e::2
 	local plen=128
 	local proto="ipv6"
@@ -1929,8 +1925,8 @@ all_zeros_mdb_common()
 
 all_zeros_mdb_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local vtep1_ip=198.51.100.101
 	local vtep2_ip=198.51.100.102
 	local vtep3_ip=198.51.100.103
@@ -1947,8 +1943,8 @@ all_zeros_mdb_ipv4()
 
 all_zeros_mdb_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local vtep3_ip=2001:db8:3000::1
@@ -2021,8 +2017,8 @@ mdb_fdb_common()
 
 mdb_fdb_ipv4_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local plen=32
@@ -2040,8 +2036,8 @@ mdb_fdb_ipv4_ipv4()
 
 mdb_fdb_ipv6_ipv4()
 {
-	local ns1=ns1_v4
-	local ns2=ns2_v4
+	local ns1=$ns1_v4
+	local ns2=$ns2_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local plen=32
@@ -2059,8 +2055,8 @@ mdb_fdb_ipv6_ipv4()
 
 mdb_fdb_ipv4_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
@@ -2078,8 +2074,8 @@ mdb_fdb_ipv4_ipv6()
 
 mdb_fdb_ipv6_ipv6()
 {
-	local ns1=ns1_v6
-	local ns2=ns2_v6
+	local ns1=$ns1_v6
+	local ns2=$ns2_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local plen=128
@@ -2166,7 +2162,7 @@ mdb_torture_common()
 
 mdb_torture_ipv4_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local grp1=239.1.1.1
@@ -2183,7 +2179,7 @@ mdb_torture_ipv4_ipv4()
 
 mdb_torture_ipv6_ipv4()
 {
-	local ns1=ns1_v4
+	local ns1=$ns1_v4
 	local vtep1_ip=198.51.100.100
 	local vtep2_ip=198.51.100.200
 	local grp1=ff0e::1
@@ -2200,7 +2196,7 @@ mdb_torture_ipv6_ipv4()
 
 mdb_torture_ipv4_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local grp1=239.1.1.1
@@ -2217,7 +2213,7 @@ mdb_torture_ipv4_ipv6()
 
 mdb_torture_ipv6_ipv6()
 {
-	local ns1=ns1_v6
+	local ns1=$ns1_v6
 	local vtep1_ip=2001:db8:1000::1
 	local vtep2_ip=2001:db8:2000::1
 	local grp1=ff0e::1
-- 
2.43.0


