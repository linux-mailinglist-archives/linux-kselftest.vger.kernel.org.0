Return-Path: <linux-kselftest+bounces-1015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A112A8019DE
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4518FB21156
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453013D87;
	Sat,  2 Dec 2023 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAayVkYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B60D9D;
	Fri,  1 Dec 2023 18:02:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d04c097e34so9144495ad.0;
        Fri, 01 Dec 2023 18:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482535; x=1702087335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7Tut7UMz7UzHod20hFNB1yO2SXZLvJsPwoCZuCY6kw=;
        b=lAayVkYVwMLJesdmnzXo4C9sk9dACke5lFR+/Cvk+qA3ntv4hkuc6rViQiHlMigQ6J
         5zesy84JJFKZCfVoz+q7RrLkbVzUUfQWr4C1JXG5QZPhi2sDwRX1Qlsdugr+RUiORYdc
         Kf827SQvZ+YBCwpjtuuQu5ul8Sf8zqJya/r4a2fP8qsyVKTV3R4VC30WvX9gUP0+EjpI
         TZNROYW9sWL4v3Y+FJBxH5ekhdLcH1c+cabnwjXAK+F+DHdtMK5K62mBLVHZ6wdnfVvx
         JteoD/Bo3zADZAFNbJP69qHRlKAO6h92iy3CfYBKfVFthbHfDcYVojAhxQZPi6UrYUaH
         govg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482535; x=1702087335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7Tut7UMz7UzHod20hFNB1yO2SXZLvJsPwoCZuCY6kw=;
        b=a2Hvn09UZF1Z7uYg5/9qO4JGsQ86mONA5yaCUysWvpGZv37oA6ga3GdDHWHpe4Do3i
         SvwVzKq9re3EtAE2mbHSEn9NFOzqEdGiOEn9rORlU4Q/QM0kRzJML7RQzTvKjLNLNw1r
         oeuJXBPRGW7tfY8KyPvZVVxzomv+gOyc34t6hyxLt8RBMhn5vlViaNghRJE+686qn2K6
         6Y+djasriN+Nc7kX80CmDUhulZiYdmdnHuUz1bcJwbL2BB06Fogp1cGjmoXCnExW98t0
         zb54E6e92SjQoy5q734i21cTSiuuUjDODzplAp1FpYirHr4Rag7qX6RATi/gUyumPK8W
         tTvw==
X-Gm-Message-State: AOJu0Yynf+FW7kEcMPVvDIzaL4wu/MgeQfUbu2UtlQR/TsYlEjQotWC5
	Aq39GPAuFqjXyyovZNViiNk+3jKkEkgiV2wU
X-Google-Smtp-Source: AGHT+IEHcqRLSPo2S298nzwox3TTs/8rC2dOszFjIG4rCy/b267gbS0so5VzqFygEjt3Z6ID25JfKA==
X-Received: by 2002:a17:902:e54b:b0:1d0:569f:edf with SMTP id n11-20020a170902e54b00b001d0569f0edfmr679965plf.14.1701482535478;
        Fri, 01 Dec 2023 18:02:15 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:02:14 -0800 (PST)
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
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 12/14] selftests/net: convert ndisc_unsolicited_na_test.sh to run it in unique namespace
Date: Sat,  2 Dec 2023 10:01:08 +0800
Message-ID: <20231202020110.362433-13-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202020110.362433-1-liuhangbin@gmail.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./ndisc_unsolicited_na_test.sh
    TEST: test_unsolicited_na:  drop_unsolicited_na=0  accept_untracked_na=1  forwarding=1  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=0  accept_untracked_na=0  forwarding=0  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=0  accept_untracked_na=0  forwarding=1  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=0  accept_untracked_na=1  forwarding=0  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=1  accept_untracked_na=0  forwarding=0  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=1  accept_untracked_na=0  forwarding=1  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=1  accept_untracked_na=1  forwarding=0  [ OK ]
    TEST: test_unsolicited_na:  drop_unsolicited_na=1  accept_untracked_na=1  forwarding=1  [ OK ]

Tests passed:   8
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/ndisc_unsolicited_na_test.sh          | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh b/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
index 86e621b7b9c7..5db69dad0cfc 100755
--- a/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
+++ b/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
@@ -10,16 +10,12 @@
 #    0        1       0  Don't update NC
 #    0        1       1  Add a STALE NC entry
 
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 PAUSE_ON_FAIL=no
 PAUSE=no
 
-HOST_NS="ns-host"
-ROUTER_NS="ns-router"
-
 HOST_INTF="veth-host"
 ROUTER_INTF="veth-router"
 
@@ -29,11 +25,6 @@ SUBNET_WIDTH=64
 ROUTER_ADDR_WITH_MASK="${ROUTER_ADDR}/${SUBNET_WIDTH}"
 HOST_ADDR_WITH_MASK="${HOST_ADDR}/${SUBNET_WIDTH}"
 
-IP_HOST="ip -6 -netns ${HOST_NS}"
-IP_HOST_EXEC="ip netns exec ${HOST_NS}"
-IP_ROUTER="ip -6 -netns ${ROUTER_NS}"
-IP_ROUTER_EXEC="ip netns exec ${ROUTER_NS}"
-
 tcpdump_stdout=
 tcpdump_stderr=
 
@@ -76,8 +67,12 @@ setup()
 
 	# Setup two namespaces and a veth tunnel across them.
 	# On end of the tunnel is a router and the other end is a host.
-	ip netns add ${HOST_NS}
-	ip netns add ${ROUTER_NS}
+	setup_ns HOST_NS ROUTER_NS
+	IP_HOST="ip -6 -netns ${HOST_NS}"
+	IP_HOST_EXEC="ip netns exec ${HOST_NS}"
+	IP_ROUTER="ip -6 -netns ${ROUTER_NS}"
+	IP_ROUTER_EXEC="ip netns exec ${ROUTER_NS}"
+
 	${IP_ROUTER} link add ${ROUTER_INTF} type veth \
                 peer name ${HOST_INTF} netns ${HOST_NS}
 
-- 
2.43.0


