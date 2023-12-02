Return-Path: <linux-kselftest+bounces-1007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCEF8019CE
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1624EB21022
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6361FAF;
	Sat,  2 Dec 2023 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/lK1U6L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D45D5;
	Fri,  1 Dec 2023 18:01:39 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28652d59505so1412039a91.2;
        Fri, 01 Dec 2023 18:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482499; x=1702087299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlEgYvc8qJpS12JHsE+jswGQjmEhBmecN3rf8l/b5O4=;
        b=G/lK1U6LweEGqBRRvE25bRgR8ua+Rqnxh/EiirQLERE4sMGWPx3tHI4WTf/7JW0uz9
         wDYvsG8bi9//6Y6K1WBdJzMvKZ/57gzd8mb58LAzH4oEzabgntbqpkaGmmYoEQJM9K9c
         L2JsGI2JsDhGthQfNZuXel1xIXJLIsnJGCpHnFKgGSeam6VFKZVHWEo+Gzlb2VnkIOtA
         iLOmc134dl9F+yIYpot694TKmMa1k19W2VdIvdoZzzfaW0qYzlFynPBb1+cmHCMBK5xw
         2mnZWDSOi0UHItBEsmaEFDBTkbGCX6xMm8TchzrAK4ZYH7a1f53dOvXgI0dJU6BP2o0l
         kHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482499; x=1702087299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlEgYvc8qJpS12JHsE+jswGQjmEhBmecN3rf8l/b5O4=;
        b=cJg+YPsFLtz3TRsDZr+jqIvVoXeuzi557S+UuEJ4yE+5Y5RYBowflzEHf7OJJeWD3U
         McHuHak+m38GNRQ9/d5lP1iUAGNM2yQE1NiD06FuioHwSZCvKu2pgs/2/pGIHIOAwmn1
         zKD+tpstxv+SqOIHP0BpsWEp4U24eCxWnUSbYneWH7NQYQwwfKuL3TTZQujhon1u6mQY
         f5GP42RmXzZLIEp2VdSIxXAtgs5TVikJL3NC1R3aM7+3zirtucvglg3vBO1RTwzI9f4P
         g2MkpEvv1kCHZnFaUNOZ6mBZ+S98jL+lsiUH5su4eDHr59izxdZnb9GYcCxIx1vhDPbu
         jtjQ==
X-Gm-Message-State: AOJu0YwjFDU8MMgVZxrnxQON5Z5Arb0d1kFF7KXCBmMniCK6C1mRNr8f
	wP6TngwTzhgDqw1x52rsp3NO5MMjzR0BGULy
X-Google-Smtp-Source: AGHT+IGp5CHKowiVXA55H+LfWBJHScUSjhQj3l+M+veaxSYlsvSw1It2hx64aoMHxHO7B4PG6dhI2g==
X-Received: by 2002:a17:902:968d:b0:1d0:6ffd:ceb9 with SMTP id n13-20020a170902968d00b001d06ffdceb9mr234029plp.114.1701482498379;
        Fri, 01 Dec 2023 18:01:38 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:01:37 -0800 (PST)
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
Subject: [PATCHv3 net-next 04/14] selftests/net: convert arp_ndisc_untracked_subnets.sh to run it in unique namespace
Date: Sat,  2 Dec 2023 10:01:00 +0800
Message-ID: <20231202020110.362433-5-liuhangbin@gmail.com>
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

2 tests also failed without this patch

]# ./arp_ndisc_untracked_subnets.sh
    TEST: test_arp:  accept_arp=0                                       [ OK ]
    TEST: test_arp:  accept_arp=1                                       [ OK ]
    TEST: test_arp:  accept_arp=2  same_subnet=0                        [ OK ]
    TEST: test_arp:  accept_arp=2  same_subnet=1                        [ OK ]
    TEST: test_ndisc:  accept_untracked_na=0                            [ OK ]
    TEST: test_ndisc:  accept_untracked_na=1                            [ OK ]
    TEST: test_ndisc:  accept_untracked_na=2  same_subnet=0             [ OK ]
    TEST: test_ndisc:  accept_untracked_na=2  same_subnet=1             [ OK ]

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/arp_ndisc_untracked_subnets.sh         | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
index 327427ec10f5..a40c0e9bd023 100755
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
2.43.0


