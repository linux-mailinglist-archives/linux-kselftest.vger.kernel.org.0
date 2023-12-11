Return-Path: <linux-kselftest+bounces-1508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2AA80C5FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506BB1F2105A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631324B4C;
	Mon, 11 Dec 2023 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmwnxEVj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069D8121;
	Mon, 11 Dec 2023 02:09:53 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fb9c24a16aso3157635fac.0;
        Mon, 11 Dec 2023 02:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289391; x=1702894191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAjbhQ0JmgBFjHs5JcHl7yVjXolIMB4dO9LuvRr8LSQ=;
        b=OmwnxEVj1Zm2Yx/rcUjn9Yd+vF8Kz6DlYL9nBHCYnytyG5++dzwyw2DgIDfxjc4wQo
         bq2tp7sN1czkZAfVOEnBnPtIjLpRNxry0N28hVxHA7DFQHNtiYoi84B5yUodXcWt9GYl
         JsO+uuDF+IqLqTvvuXKWOyBmYF1Ko8otP69jfS9upMiLx2jIVhzAlRbJ4qi6aS5jJB0R
         6FJDR6PRlaCcpMw8S6u23cz+4OM0n168yKg8mbBdbMJkTgVFjw+fttYIJXhntu6USTfp
         gHIlwwlXLue9hJT/urpYxynK+Cxwl4tdasJkkq7quRENr8Of3h6JDl+neEgtQGwRSRM/
         8dbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289391; x=1702894191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAjbhQ0JmgBFjHs5JcHl7yVjXolIMB4dO9LuvRr8LSQ=;
        b=uo+Px258z7MTGoR25TrS+aDkrcgP84PIIqv9yfptQjFnJzG9sTuXXCjf+OemwVr2zE
         y2D85CYd5cHIVEN9FcGHzCkjc1x1ChLCutdnoWfjZssdccAaa9osiruxoAqD7N0ZhZTy
         AB+g11LX7QPR6f9gfdbpugzBcBgFoGAD+ZGCfbbJpEV/DUCf7o3ou8an8yiRvnDb+SYl
         +kA7nCA3wzZGFFdLcFGkWbr7lZwaa/suCAVwgcautHLqeFgeSsNrZCb9jzDHFuopIDW5
         +8tsfS3rBydeLty7L6EcXfftHkbmhu3MfIaTKFp3zTr0PUh0kQF88BFKrDWWGW1Uljzt
         C3RA==
X-Gm-Message-State: AOJu0YzMnCThnoZEw1KYhHg9aVJTXkn6Pvf4uXZJOdSPxH9w6kAEi431
	TzqSZAzEuoBgWt6kWV4N46pXtxYJ6kqAyU6A
X-Google-Smtp-Source: AGHT+IGt9hNJwVLM5wGjKYbteTySkeOvtfchxoV4bei/HKK7gv4BTiXIg1t4YEwTQcolQbw4UZuN8Q==
X-Received: by 2002:a05:6870:649e:b0:1fb:75b:2fb7 with SMTP id cz30-20020a056870649e00b001fb075b2fb7mr4769511oab.78.1702289391612;
        Mon, 11 Dec 2023 02:09:51 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:09:51 -0800 (PST)
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
Subject: [PATCH net-next 05/13] selftests/net: convert fcnal-test.sh to run it in unique namespace
Date: Mon, 11 Dec 2023 18:09:17 +0800
Message-ID: <20231211100925.3249265-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211100925.3249265-1-liuhangbin@gmail.com>
References: <20231211100925.3249265-1-liuhangbin@gmail.com>
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


