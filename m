Return-Path: <linux-kselftest+bounces-1799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E002D8109DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6662820A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E9DDAE;
	Wed, 13 Dec 2023 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTUI88Lj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4970EDB;
	Tue, 12 Dec 2023 22:09:29 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6d089bc4e1aso2417507b3a.0;
        Tue, 12 Dec 2023 22:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447768; x=1703052568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAjbhQ0JmgBFjHs5JcHl7yVjXolIMB4dO9LuvRr8LSQ=;
        b=cTUI88Lj+IOiWVHku63E4RZkoD6vwO9/v9n/iV6hjL8vnPz4gV6GaSYnWcNTWsinl6
         1IaXC1W6ecBifdNMfvdvj5wfNyh4Hw0dcrL59wI1/j5gfliv+3jJ3smemYq4I3syxvl2
         wyY8Ikjlyyz6sXLNrrTs+rfxDIWz+jceuniRTgWc0QpH+ENzra78SenVMG7DpdWGIqSF
         f8ER1r1fO7eEaxItjeIgVAW7uPfksFA/walddRI934RjP707UY2stBnt6HR3CEuWIan3
         EXAPo+iUQC42wI3nx8ZAhrR6p6C8RHBio1SWf208mDhGx4Q+vB1Iztk5JGVVQgIMD3hl
         DzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447768; x=1703052568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAjbhQ0JmgBFjHs5JcHl7yVjXolIMB4dO9LuvRr8LSQ=;
        b=RfTfgOOHoV71tyxwhoSeUO3yhtcAZVYlUI0gLa7NxQTT7d5eMWx8TwRBWL+Z7NLyEE
         xglA2upDMn1sr25d76nmH8Ul2XbiFzRxT+UcleX/A3MdCRwAKhEWwxRJIZuzj/tcSqtP
         Kum2Ucuz4v+15W99h5163jF+qIYjqxsBANiqEh+jMQDyJ3YKf0TUGNP43vIN1mPC8foR
         Eci6XEgLAbeIigJEcnC51fa7ivLCGW/tz9ma8OaZWw6aofxsTUgZiq2yjxZI+lmbbCMb
         a8J8Vbj5o+PNJ4b49QuyvSbJ54EVxMUhfUpenZC8HBir/y3x55yoFOC7CbUVuxGcqBHk
         40Ew==
X-Gm-Message-State: AOJu0Yy9ZVu+Y7amaefcjYtpleoIhfpSm5JDj4s28snIZ7M4Me42exEn
	LC07Zcl0Mo5gIVc5a4b+Uz3jyBfpGXdbqOoIql0=
X-Google-Smtp-Source: AGHT+IGpjucCDoyCuvO/7QZJ/Om1mFCMldCsAM0hHmOZ9bf+FhyxXD6AfdYf8MSUPBJXegi0n1J7zA==
X-Received: by 2002:a05:6a21:1a3:b0:18f:e956:8332 with SMTP id le35-20020a056a2101a300b0018fe9568332mr10281809pzb.8.1702447768056;
        Tue, 12 Dec 2023 22:09:28 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:09:27 -0800 (PST)
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
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Amit Cohen <amcohen@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 05/13] selftests/net: convert fcnal-test.sh to run it in unique namespace
Date: Wed, 13 Dec 2023 14:08:48 +0800
Message-ID: <20231213060856.4030084-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213060856.4030084-1-liuhangbin@gmail.com>
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion. There are some failures, but it
also exists on my system without this patch. So it's not affectec by
this patch and I will check the reason later.

  ]# time ./fcnal-test.sh
  /usr/bin/which: no nettest in (/root/.local/bin:/root/bin:/usr/share/Modules/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin)

  ###########################################################################
  IPv4 ping
  ###########################################################################

  #################################################################
  No VRF

  SYSCTL: net.ipv4.raw_l3mdev_accept=0

  TEST: ping out - ns-B IP                                                      [ OK ]
  TEST: ping out, device bind - ns-B IP                                         [ OK ]
  TEST: ping out, address bind - ns-B IP                                        [ OK ]
  ...

  #################################################################
  SNAT on VRF

  TEST: IPv4 TCP connection over VRF with SNAT                                  [ OK ]
  TEST: IPv6 TCP connection over VRF with SNAT                                  [ OK ]

  Tests passed: 893
  Tests failed:  21

  real    52m48.178s
  user    0m34.158s
  sys     1m42.976s

BTW, this test needs a really long time. So expand the timeout to 1h.

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fcnal-test.sh | 30 ++++++++++-------------
 tools/testing/selftests/net/settings      |  2 +-
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index d32a14ba069a..0d4f252427e2 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -37,9 +37,7 @@
 #
 # server / client nomenclature relative to ns-A
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
+source lib.sh
 VERBOSE=0
 
 NSA_DEV=eth1
@@ -82,14 +80,6 @@ MCAST=ff02::1
 NSA_LINKIP6=
 NSB_LINKIP6=
 
-NSA=ns-A
-NSB=ns-B
-NSC=ns-C
-
-NSA_CMD="ip netns exec ${NSA}"
-NSB_CMD="ip netns exec ${NSB}"
-NSC_CMD="ip netns exec ${NSC}"
-
 which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 
 # Check if FIPS mode is enabled
@@ -406,9 +396,6 @@ create_ns()
 	local addr=$2
 	local addr6=$3
 
-	ip netns add ${ns}
-
-	ip -netns ${ns} link set lo up
 	if [ "${addr}" != "-" ]; then
 		ip -netns ${ns} addr add dev lo ${addr}
 	fi
@@ -467,13 +454,12 @@ cleanup()
 		ip -netns ${NSA} link del dev ${NSA_DEV}
 
 		ip netns pids ${NSA} | xargs kill 2>/dev/null
-		ip netns del ${NSA}
+		cleanup_ns ${NSA}
 	fi
 
 	ip netns pids ${NSB} | xargs kill 2>/dev/null
-	ip netns del ${NSB}
 	ip netns pids ${NSC} | xargs kill 2>/dev/null
-	ip netns del ${NSC} >/dev/null 2>&1
+	cleanup_ns ${NSB} ${NSC}
 }
 
 cleanup_vrf_dup()
@@ -487,6 +473,8 @@ setup_vrf_dup()
 {
 	# some VRF tests use ns-C which has the same config as
 	# ns-B but for a device NOT in the VRF
+	setup_ns NSC
+	NSC_CMD="ip netns exec ${NSC}"
 	create_ns ${NSC} "-" "-"
 	connect_ns ${NSA} ${NSA_DEV2} ${NSA_IP}/24 ${NSA_IP6}/64 \
 		   ${NSC} ${NSC_DEV} ${NSB_IP}/24 ${NSB_IP6}/64
@@ -503,6 +491,10 @@ setup()
 	log_debug "Configuring network namespaces"
 	set -e
 
+	setup_ns NSA NSB
+	NSA_CMD="ip netns exec ${NSA}"
+	NSB_CMD="ip netns exec ${NSB}"
+
 	create_ns ${NSA} ${NSA_LO_IP}/32 ${NSA_LO_IP6}/128
 	create_ns ${NSB} ${NSB_LO_IP}/32 ${NSB_LO_IP6}/128
 	connect_ns ${NSA} ${NSA_DEV} ${NSA_IP}/24 ${NSA_IP6}/64 \
@@ -545,6 +537,10 @@ setup_lla_only()
 	log_debug "Configuring network namespaces"
 	set -e
 
+	setup_ns NSA NSB NSC
+	NSA_CMD="ip netns exec ${NSA}"
+	NSB_CMD="ip netns exec ${NSB}"
+	NSC_CMD="ip netns exec ${NSC}"
 	create_ns ${NSA} "-" "-"
 	create_ns ${NSB} "-" "-"
 	create_ns ${NSC} "-" "-"
diff --git a/tools/testing/selftests/net/settings b/tools/testing/selftests/net/settings
index dfc27cdc6c05..ed8418e8217a 100644
--- a/tools/testing/selftests/net/settings
+++ b/tools/testing/selftests/net/settings
@@ -1 +1 @@
-timeout=1500
+timeout=3600
-- 
2.43.0


