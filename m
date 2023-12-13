Return-Path: <linux-kselftest+bounces-1804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B9D8109E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61250281ECF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26566FBF6;
	Wed, 13 Dec 2023 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLadnqg2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A71ADB;
	Tue, 12 Dec 2023 22:09:50 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so5950319b3a.2;
        Tue, 12 Dec 2023 22:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447789; x=1703052589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQi+kDlznq0CFqtjRvuPpTyk/PEd2xJSKjNfnpVe/PA=;
        b=eLadnqg2VXUBGRPEbDGxgHT4ZWrZNvXiuz1ks76XypFtgWWT2opLr8WPAE05EbRc8p
         hV7q+AhevbzKlvmRe8Aspw44uaPLjAs3hee5V6jzr/RyQToT6GKKtMEnGHClOEPt6vL3
         SLC5U/3091iZud/Q6JoY97xlvpMhdig4wAOb/JIfNklieKaAgXq1ZRmX/w7nlBU0vSdf
         Mv95Geg0PnrdozPas2GinX4oRdePOnuuJdPyU4o7oDTBrG1htPODt3kuCVg9sIOxPa/m
         HXBdOfzDxBDYo1WszQxMiPy+oaxd0A0q8ZNwPgi1CzIgVa7si6DUT2FFy3HQflfS89CG
         YxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447789; x=1703052589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQi+kDlznq0CFqtjRvuPpTyk/PEd2xJSKjNfnpVe/PA=;
        b=T7DuzKtYLuH1qLP/bFEV4TLPjydoS9xaO8STNx7AMDmo4bx1jVrVPiS8GMwTO0nopd
         o94JH99dVJjnllIR6UPIxLMXGL0U2CZB9Hpvz1dfy6+btDciuc/CAktNoq9ur1K4Fabo
         6V7oU9aN0MurmpggMZBzgNvohB58s0x9O3d+AX8pezePNHaywVVAR5tbrFGMZt/vO/DF
         l8asguJX47h5LAvXWck+z7oPtRegHkrMYACBBiwRhSDLLpyg23rg7EvdL4OU9emD8atz
         yOvB8k36eC0pmAvT+itE6mmzyEnBklLLCsPbnoDPA/h50TtZAjtbm3HkmBQN2UEJ1LC9
         KPzQ==
X-Gm-Message-State: AOJu0Ywjy04ColcwItJFoVh4Rp7211LF2j+laikNXCGTSplQSmIeiX4X
	cJjzXZME1g+N/byq+D7LC8lTy9E04a1Ageaz9Wc=
X-Google-Smtp-Source: AGHT+IGIy5j/W9KkN1QjWvsCgSFaWiCEtRB9z9d93F8VG7lnf4zx1WfPDdc1RSzAUPMBx4jfvs5VFg==
X-Received: by 2002:a05:6a00:2301:b0:6ce:ee3b:e529 with SMTP id h1-20020a056a00230100b006ceee3be529mr8593469pfh.62.1702447789364;
        Tue, 12 Dec 2023 22:09:49 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:09:48 -0800 (PST)
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
Subject: [PATCHv2 net-next 10/13] selftests/net: convert fib-onlink-tests.sh to run it in unique namespace
Date: Wed, 13 Dec 2023 14:08:53 +0800
Message-ID: <20231213060856.4030084-11-liuhangbin@gmail.com>
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

Remove PEER_CMD, which is not used in this test

Here is the test result after conversion.

 ]# ./fib-onlink-tests.sh
 Error: ipv4: FIB table does not exist.
 Flush terminated
 Error: ipv6: FIB table does not exist.
 Flush terminated

 ########################################
 Configuring interfaces

   ...

     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]

 Tests passed:  38
 Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index c287b90b8af8..ec2d6ceb1f08 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -3,6 +3,7 @@
 
 # IPv4 and IPv6 onlink tests
 
+source lib.sh
 PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
 VERBOSE=0
 
@@ -74,9 +75,6 @@ TEST_NET4IN6[2]=10.2.1.254
 # mcast address
 MCAST6=ff02::1
 
-
-PEER_NS=bart
-PEER_CMD="ip netns exec ${PEER_NS}"
 VRF=lisa
 VRF_TABLE=1101
 PBR_TABLE=101
@@ -176,8 +174,7 @@ setup()
 	set -e
 
 	# create namespace
-	ip netns add ${PEER_NS}
-	ip -netns ${PEER_NS} li set lo up
+	setup_ns PEER_NS
 
 	# add vrf table
 	ip li add ${VRF} type vrf table ${VRF_TABLE}
@@ -219,7 +216,7 @@ setup()
 cleanup()
 {
 	# make sure we start from a clean slate
-	ip netns del ${PEER_NS} 2>/dev/null
+	cleanup_ns ${PEER_NS} 2>/dev/null
 	for n in 1 3 5 7; do
 		ip link del ${NETIFS[p${n}]} 2>/dev/null
 	done
-- 
2.43.0


