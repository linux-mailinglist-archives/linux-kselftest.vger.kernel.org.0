Return-Path: <linux-kselftest+bounces-1802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FAB8109E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27083B20DB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34447DF44;
	Wed, 13 Dec 2023 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULytDX8Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9156298;
	Tue, 12 Dec 2023 22:09:41 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b9dbbaa9a9so5414465b6e.2;
        Tue, 12 Dec 2023 22:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447780; x=1703052580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqjokwxmfNwn2b7TrM9od/452xo9IhKmKVow7UNSwEA=;
        b=ULytDX8YwVqUAAm0WSi5/PP+h8m6yqmJJETG9sDVJPlNtUNKhLpxMJ0Z341wF9AkMN
         Q3GQqP1ojAZAy6+3lwRV6X3wPMSu8kFvmNhCaYYR54jS58x1+IwilL+YRdRZT6jny/gK
         m4im2vn//uAbNhq/WpB5IbEmHi4k3cKI0PUnDrckBlMzqw16OeUdKS/hdjjNA98N6pWb
         cLu9C+JbpNgt2Tuu8DiyopBHBYEUH6cm6RC4aFVPa5htvRPWvWi5XoD7TEzZGhZYmwUF
         khniXewzb2tmBlV5AIyK4q2BgE0w+Jq7Gcp+sO4LjR7WIDiYSU6+GlJQ+EWm29YvYAQT
         IO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447780; x=1703052580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqjokwxmfNwn2b7TrM9od/452xo9IhKmKVow7UNSwEA=;
        b=U3gYlwVhE506sKUSjLk5V1kzFSWioBIaC64lkyWSjKZ8EVvnikwBGQ3Tu1mCWwZr6Y
         v7bKGA/oEC9UQTIKARFyU1SV5YzkiTYZg87j85wAw3wMfUwk9zusF+ZIh8i5h48Wf83t
         1nmxhVBOAapSTWIat7TacdkKCNmgbxVf3nMwKJWOUXbI9IkcgXX5m5eo2rh00hYJocrN
         QCgRlo3059g+pPQu3kdgrNMj9tRaj/sa5BzuXMHqH4Myv4VE5jfiez6WivFDtTJlht3m
         0RhsOxJX1yGDRgCgb52jH3ICDoPVRdVsE3EhZFPOofC8Z92vu5b8ke2ChCwnIfXqJ5ol
         BA0w==
X-Gm-Message-State: AOJu0Yxv+XgLIiurWbRQgyToFRBZykuH6qmIcs4KrJp50xLQ5icWNbf/
	LZhgyV5B79qzUlhZ6szlatAl87i0fszjl4QfqjU=
X-Google-Smtp-Source: AGHT+IEmtu3bKYsIudY+DU3+SNfp3hErsHetTrPZHwFo2H8p6wAVvWVA9qc2ydDAQSDD/FzOuVGKcg==
X-Received: by 2002:a05:6808:320d:b0:3b9:f231:5c96 with SMTP id cb13-20020a056808320d00b003b9f2315c96mr13322863oib.76.1702447780496;
        Tue, 12 Dec 2023 22:09:40 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:09:39 -0800 (PST)
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
Subject: [PATCHv2 net-next 08/13] selftests/net: convert fib_nexthop_nongw.sh to run it in unique namespace
Date: Wed, 13 Dec 2023 14:08:51 +0800
Message-ID: <20231213060856.4030084-9-liuhangbin@gmail.com>
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

Here is the test result after conversion.

 ]# ./fib_nexthop_nongw.sh
 TEST: nexthop: get route with nexthop without gw                    [ OK ]
 TEST: nexthop: ping through nexthop without gw                      [ OK ]

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/fib_nexthop_nongw.sh        | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthop_nongw.sh b/tools/testing/selftests/net/fib_nexthop_nongw.sh
index b7b928b38ce4..1ccf56f10171 100755
--- a/tools/testing/selftests/net/fib_nexthop_nongw.sh
+++ b/tools/testing/selftests/net/fib_nexthop_nongw.sh
@@ -8,6 +8,7 @@
 #            veth0 <---|---> veth1
 # Validate source address selection for route without gateway
 
+source lib.sh
 PAUSE_ON_FAIL=no
 VERBOSE=0
 ret=0
@@ -64,35 +65,31 @@ run_cmd()
 # config
 setup()
 {
-	ip netns add h1
-	ip -n h1 link set lo up
-	ip netns add h2
-	ip -n h2 link set lo up
+	setup_ns h1 h2
 
 	# Add a fake eth0 to support an ip address
-	ip -n h1 link add name eth0 type dummy
-	ip -n h1 link set eth0 up
-	ip -n h1 address add 192.168.0.1/24 dev eth0
+	ip -n $h1 link add name eth0 type dummy
+	ip -n $h1 link set eth0 up
+	ip -n $h1 address add 192.168.0.1/24 dev eth0
 
 	# Configure veths (same @mac, arp off)
-	ip -n h1 link add name veth0 type veth peer name veth1 netns h2
-	ip -n h1 link set veth0 up
+	ip -n $h1 link add name veth0 type veth peer name veth1 netns $h2
+	ip -n $h1 link set veth0 up
 
-	ip -n h2 link set veth1 up
+	ip -n $h2 link set veth1 up
 
 	# Configure @IP in the peer netns
-	ip -n h2 address add 192.168.1.1/32 dev veth1
-	ip -n h2 route add default dev veth1
+	ip -n $h2 address add 192.168.1.1/32 dev veth1
+	ip -n $h2 route add default dev veth1
 
 	# Add a nexthop without @gw and use it in a route
-	ip -n h1 nexthop add id 1 dev veth0
-	ip -n h1 route add 192.168.1.1 nhid 1
+	ip -n $h1 nexthop add id 1 dev veth0
+	ip -n $h1 route add 192.168.1.1 nhid 1
 }
 
 cleanup()
 {
-	ip netns del h1 2>/dev/null
-	ip netns del h2 2>/dev/null
+	cleanup_ns $h1 $h2
 }
 
 trap cleanup EXIT
@@ -108,12 +105,11 @@ do
 	esac
 done
 
-cleanup
 setup
 
-run_cmd ip -netns h1 route get 192.168.1.1
+run_cmd ip -netns $h1 route get 192.168.1.1
 log_test $? 0 "nexthop: get route with nexthop without gw"
-run_cmd ip netns exec h1 ping -c1 192.168.1.1
+run_cmd ip netns exec $h1 ping -c1 192.168.1.1
 log_test $? 0 "nexthop: ping through nexthop without gw"
 
 exit $ret
-- 
2.43.0


