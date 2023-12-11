Return-Path: <linux-kselftest+bounces-1511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854DC80C606
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1B81F2153E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C142233A;
	Mon, 11 Dec 2023 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy8yyu+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D84210E;
	Mon, 11 Dec 2023 02:10:04 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so3612123b3a.2;
        Mon, 11 Dec 2023 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289403; x=1702894203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PozmeJuAXwFiPNUwGtWiuY2UXzYUeXPWXVkDP1BUURk=;
        b=Yy8yyu+M/0b4Fq9bKOLOLnEgHQIETNf4gsWiGQUZ6KQ0qP2S64u7I83+YYBwhDayVQ
         8x3kafhcLAsuZzalmY8n1+g3mNDgZ3N8TLyNp3D4/rVcg5+Gw9xjMxJ4XAl7SQTf6DgS
         D+3hAPs6GLpxX828V/QxbKh7LNwF68hnaTzfug0rIN1Y7Gy2CFVLSk86ZIU+s0tACFQS
         EkvaBdUL7mhpOlM4QAiqiEt8u0JdP6omChEMZ62Ero/uokf7Fy9n/muCm0sxI8miYflE
         6JAYse2ZN29jv0iYKaUMEWS8SW8+JHcs8zM3GSbwGvHWm4WHgpwPXTIgCh845NX7c0U/
         pPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289403; x=1702894203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PozmeJuAXwFiPNUwGtWiuY2UXzYUeXPWXVkDP1BUURk=;
        b=Yu5xRMsgxeo/4Ve+7/kfW3Ur5IerIwbLfVuEh15SzhXF1bjnMkTMJWDg0o/8kQ7/g/
         U7KRbKoLguCY7EYSbBeUYxj+V3QHWcjeecZbaJXFalxXxdEKQ5YnABypJ1ENU2SpnOCq
         YDIW9v6Sr0PLa+FiSRRHiDZ3W1cLyJkDdNYAGrHAL6vrZ4apsG43UBrgsagjBPNHfyhm
         og9zPI9Dvf68WgAt5sxxktFiTdErRaAq70RdIiyvY81CjlkgkK1/HhJDjvkna2BX40O+
         VjMMJpndBa4W2FGWOQHPd+1gTN+ccT2q5UqZiuOZj5snyWmu8v6f7BQKazjy3T5TGFeC
         ZCzQ==
X-Gm-Message-State: AOJu0Yz9uxgUbfd7rVj/5CNXifws4rqhQE0D0bpMBTz8WKGoN/Ym4KJa
	CFOATw4ICiMEuQ6wryShXiwbjnmjH3KaXW1F
X-Google-Smtp-Source: AGHT+IE//lCTVF8EuQFpyCW1TFS1omQ6gnK9QT/amLoHDMOWF9ITsIpWLIhubMQcJb1cha+FF46/dA==
X-Received: by 2002:a05:6a21:609:b0:18c:770:4578 with SMTP id ll9-20020a056a21060900b0018c07704578mr4899793pzb.30.1702289403603;
        Mon, 11 Dec 2023 02:10:03 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:10:03 -0800 (PST)
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
Subject: [PATCH net-next 08/13] selftests/net: convert fib_nexthop_nongw.sh to run it in unique namespace
Date: Mon, 11 Dec 2023 18:09:20 +0800
Message-ID: <20231211100925.3249265-9-liuhangbin@gmail.com>
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


