Return-Path: <linux-kselftest+bounces-508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9748E7F6F90
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898A01C20F4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD0FBEA;
	Fri, 24 Nov 2023 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQEuUNhM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4034FDD;
	Fri, 24 Nov 2023 01:28:20 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c10f098a27so1371166b3a.2;
        Fri, 24 Nov 2023 01:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818099; x=1701422899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA5vRVzq91uijg6aVCCtOeejBBWQLG86GKIseV9oaOQ=;
        b=CQEuUNhM+GHyRZsHW7eZ+w7erHaYl1iWBnZDGSH7yekB+zo+P0MvE5uj7Q8gebzkgf
         Z/diUs5NPNEtLz0gvB7I7mHKcHWQsijg4VsVw3C9iWboYrHFPhnaTlv1SNz93a9RhPkm
         1E4TH8FRbifX0G/qodl3FANiCYxcQ52biR3i/+Dpstmm41G4MVBQmZtPzJRaiMxBDhXl
         YHa4OujYeEBG4C66BD3vGRMgqs90YMHNn1M/3UnchftBV1kCrBT8Uan6HgGMCVPusJYo
         2cIDyGtmRIVi3CjwotNZz/CHM+bCzz43CAA1ZBvd9Yno0l0Aeb0dEPWSaek5Aiv7v1B+
         l+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818099; x=1701422899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA5vRVzq91uijg6aVCCtOeejBBWQLG86GKIseV9oaOQ=;
        b=mskJzNSC3sSe0jOyg6/vwUg/IyBYLB11iMJ3Z9vtOvUz7HXcRF9A73ZfJ4wwa0AtRl
         xZrclXlmtU1vqQ9koAkHAFybXWgnadFdLfLxKDFrGVEgvWyvF1icxT2Hgyw3UpyraIz1
         BA70S8BYJiGOJZP5NRf2zqXuZPVU526jr12LQ/GmrjQ7FlKFM+62e3EEXRUj/uGQgDlP
         0SgJTAMyq8OOKQK++RGi0mOujSgpMAUr8oU0KWgf33ah6S/4NTgUonAK1Z30dVRSXcyL
         nNGmwYIlg90dv48qYxZppky/rFexFz2NO4kjlFHXmCD+Bp2deVSTFMcyGRSX6xFGE4Aj
         nUWQ==
X-Gm-Message-State: AOJu0Yxqp3tJrak++ZfGJEdYJ63pKWbFDa97m/a8GETDAfGfv6psnFNc
	3/0CVuFUjBMtwNVrjK1h5Nh+gSQbNAZBrxPm
X-Google-Smtp-Source: AGHT+IGYPNFYRK56EyILaDO74SFXXCOazBc46mdDxPhjdWEGjqPP5zzJMWl7yGFVML7BKV4kvKILfg==
X-Received: by 2002:a05:6a20:431c:b0:166:82cf:424a with SMTP id h28-20020a056a20431c00b0016682cf424amr2251163pzk.33.1700818099267;
        Fri, 24 Nov 2023 01:28:19 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:18 -0800 (PST)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 06/38] selftests/net: convert fcnal-test.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:04 +0800
Message-ID: <20231124092736.3673263-7-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
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
2.41.0


