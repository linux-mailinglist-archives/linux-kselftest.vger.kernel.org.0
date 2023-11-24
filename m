Return-Path: <linux-kselftest+bounces-520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFBE7F6FA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1D5B211FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B9A14262;
	Fri, 24 Nov 2023 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGufBRQh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04876D6F;
	Fri, 24 Nov 2023 01:29:12 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfa8f7c356so1016045ad.2;
        Fri, 24 Nov 2023 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818151; x=1701422951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re23Dhd2Q25xShZKjAFhmv6SyK2PQ4FpKglYecUP7i0=;
        b=lGufBRQh05cp4etD0lEKOE/Yyvw0eiC3Py4xPV1XbDrKRplftWS4jbsvb9LT+PefQP
         mQ0IhNBukzw+et/FRSb/JaeypKTEwS7GxA+okzyGx3963jJcZ/kWklZ0uwcesFPKgdKf
         +1S9vLeH7/wwzuWco5wFuDcpL52VQTbn/c8KOFJOhmfHKEPDX9x5bG8NA/YRvpJ1SgD/
         qQvMJR0gns0snP+fyVsluEUmsuFuakrQfQANrjSo1TzdJQA5eBqEKSNrllkFAwUU2SJA
         pfUayPqn0sPomFOX207Wjb4zor75YqrIYY1+piki5eRX3nhlihGD+vhKphVi9UMsK5mS
         Is0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818151; x=1701422951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re23Dhd2Q25xShZKjAFhmv6SyK2PQ4FpKglYecUP7i0=;
        b=ZSfHbeyxaKeVDGnjJbFtJln4i0Mh/KNM9EBTqxK4TSqvsnizso8WEXZRhyVjKJRFyK
         tROLy7Uz/DG3vBgGlKmcyBqsw9ddxOBTub4oeXuAZeNKk/X3tSwdnvjS0ShtEZVWC15S
         Kh79HAgnN6QhdBfmcRg9i/+qQw6I7GNAiKvYzmR3S8R42XIalhVhl8wv9ywX5D0/pvHD
         /s7T2VXbC1zPBZX8cgEkqUkYvI0EWxNBqJE5veakaY/yHsIo2kii0S0UI3zPeOueXAxV
         63anNpaap4deNAuUXLZnlSwV8lD17tE05hatRxvM4EA2qebw9vPn2A+p0lAL/8cIysp2
         iq/Q==
X-Gm-Message-State: AOJu0Yz0BHEM9XlM68gM3Zx4qz6DzujYshiFKfMWaTqGft4M8JcNZaw3
	plLCYFjlemn7+QZ3KHqyPTabdVdq568LyJy4
X-Google-Smtp-Source: AGHT+IFGIDe05ezgFYnfe2kvXCnSqtLkcIdM9Q5sWtapU5/IkwaFQRdwPTgONGLPlgGuxFb+oPlBxg==
X-Received: by 2002:a17:902:7584:b0:1cf:9c0b:b3dc with SMTP id j4-20020a170902758400b001cf9c0bb3dcmr1532221pll.69.1700818150862;
        Fri, 24 Nov 2023 01:29:10 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:10 -0800 (PST)
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
Subject: [PATCH net-next 18/38] selftests/net: convert ndisc_unsolicited_na_test.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:16 +0800
Message-ID: <20231124092736.3673263-19-liuhangbin@gmail.com>
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
2.41.0


