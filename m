Return-Path: <linux-kselftest+bounces-505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF3B7F6F89
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7558E281DB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4997E57E;
	Fri, 24 Nov 2023 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsfSYWew"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3150D72;
	Fri, 24 Nov 2023 01:28:06 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso1389215b3a.0;
        Fri, 24 Nov 2023 01:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818085; x=1701422885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI/nrJfZrXvC85t5VjIo7Y3E+d23rEKAFvbpvB7b7Ms=;
        b=BsfSYWewblBRjMxzGDpvtx/EPh0SWx015LG+JbcesiFSjDDABJBrHUGd4FmQjU0IFp
         +MBU2z5wtLuGg9fvu1ISCRRjxRVrd9WZJ7NGZZq7rXMFIjiHcDyQC/MA3kqYLeRnZNO8
         /kZdrEMTvsRuDdMY/PmsfIRJ3NXVvhlPkulKMtiB/OloUQf6R9sOio60dKtQ8CcIRzD0
         xXUqfiYpqe/k7nlekuhTK1C7xU6zMFz2/xCtWavNSMSjpmZyq/WlT1SXWF9MqkGMaY/E
         7KelJq7Zyzx1EHmTAYADtbOwRB+eOIOgXtwbMJZDqmWGhWPX6Jh054rtKmaZEMi3I9gf
         Lg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818085; x=1701422885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DI/nrJfZrXvC85t5VjIo7Y3E+d23rEKAFvbpvB7b7Ms=;
        b=pr33XGG817v0JYCWqt2n2Izd8CF3yZq/5tNBdXxs6gnDSITXquGlVtLovu0HUcOWes
         O4z+2jJX4clRr6Umn+hlIaJrGVgBfXro5WEgPMz8A9Mo1cTqkVceUyMDaj+3uSpaRv+Z
         D32L3eYFft+nl0Pj4pp4w5CF2Qn7fGYr8SwROCA0G0wfFQae5esk6MHvEc/Gq85ujToT
         /5SsPyFoqI2sEkXtbZBcgevQdDojobX3hx28LKrw2qhgDwAqzSiLLamupf88V5ImyAqc
         btX2k6633mAgLZMRLuV6apH5+mF0PaGpaj3H+bT0kHxIhPaHXvyOdzqSCKVIEaw4dU9z
         edGQ==
X-Gm-Message-State: AOJu0YxRe5b1dFe2ED5ZEeqPAQ0nzyNhFlA0mH92jRHrHn8JY0lOA1FJ
	i8UOeReWZ6r3WMYi6hAjMRYyhQTGIUek36Le
X-Google-Smtp-Source: AGHT+IHHjswXESv9k6IffXJFEb9vYoHKrFAEkY9Rh4xcssMIP451VajLqChx/5CAzGgbgT4KHAzYWA==
X-Received: by 2002:a05:6a20:7da0:b0:180:d33d:9256 with SMTP id v32-20020a056a207da000b00180d33d9256mr2636407pzj.58.1700818085561;
        Fri, 24 Nov 2023 01:28:05 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:05 -0800 (PST)
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
Subject: [PATCH net-next 03/38] selftest: arp_ndisc_untracked_subnets.sh convert to run test in unique namespace
Date: Fri, 24 Nov 2023 17:27:01 +0800
Message-ID: <20231124092736.3673263-4-liuhangbin@gmail.com>
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

2 tests also failed without this patch

]# ./arp_ndisc_untracked_subnets.sh
    TEST: test_arp:  accept_arp=0                                       [ OK ]
    TEST: test_arp:  accept_arp=1                                       [FAIL]
    TEST: test_arp:  accept_arp=2  same_subnet=0                        [ OK ]
    TEST: test_arp:  accept_arp=2  same_subnet=1                        [FAIL]
    TEST: test_ndisc:  accept_untracked_na=0                            [ OK ]
    TEST: test_ndisc:  accept_untracked_na=1                            [ OK ]
    TEST: test_ndisc:  accept_untracked_na=2  same_subnet=0             [ OK ]
    TEST: test_ndisc:  accept_untracked_na=2  same_subnet=1             [ OK ]

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/arp_ndisc_untracked_subnets.sh         | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
index c899b446acb6..5fda2344e14a 100755
--- a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
+++ b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
@@ -5,16 +5,14 @@
 # garp to the router. Router accepts or ignores based on its arp_accept
 # or accept_untracked_na configuration.
 
+source lib.sh
+
 TESTS="arp ndisc"
 
-ROUTER_NS="ns-router"
-ROUTER_NS_V6="ns-router-v6"
 ROUTER_INTF="veth-router"
 ROUTER_ADDR="10.0.10.1"
 ROUTER_ADDR_V6="2001:db8:abcd:0012::1"
 
-HOST_NS="ns-host"
-HOST_NS_V6="ns-host-v6"
 HOST_INTF="veth-host"
 HOST_ADDR="10.0.10.2"
 HOST_ADDR_V6="2001:db8:abcd:0012::2"
@@ -23,13 +21,11 @@ SUBNET_WIDTH=24
 PREFIX_WIDTH_V6=64
 
 cleanup() {
-	ip netns del ${HOST_NS}
-	ip netns del ${ROUTER_NS}
+	cleanup_ns ${HOST_NS} ${ROUTER_NS}
 }
 
 cleanup_v6() {
-	ip netns del ${HOST_NS_V6}
-	ip netns del ${ROUTER_NS_V6}
+	cleanup_ns ${HOST_NS_V6} ${ROUTER_NS_V6}
 }
 
 setup() {
@@ -37,8 +33,7 @@ setup() {
 	local arp_accept=$1
 
 	# Set up two namespaces
-	ip netns add ${ROUTER_NS}
-	ip netns add ${HOST_NS}
+	setup_ns HOST_NS ROUTER_NS
 
 	# Set up interfaces veth0 and veth1, which are pairs in separate
 	# namespaces. veth0 is veth-router, veth1 is veth-host.
@@ -72,8 +67,7 @@ setup_v6() {
 	local accept_untracked_na=$1
 
 	# Set up two namespaces
-	ip netns add ${ROUTER_NS_V6}
-	ip netns add ${HOST_NS_V6}
+	setup_ns HOST_NS_V6 ROUTER_NS_V6
 
 	# Set up interfaces veth0 and veth1, which are pairs in separate
 	# namespaces. veth0 is veth-router, veth1 is veth-host.
-- 
2.41.0


