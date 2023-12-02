Return-Path: <linux-kselftest+bounces-1017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C828019E1
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511901F2116C
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C3E613E;
	Sat,  2 Dec 2023 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvvM5v5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA3D5;
	Fri,  1 Dec 2023 18:02:26 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b83ed78a91so921411b6e.1;
        Fri, 01 Dec 2023 18:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482545; x=1702087345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb2msrxaVNlWSR/UolFSkDQjk3NlZGZRnRZHtc3FiMU=;
        b=XvvM5v5nZLeEZpsSd6yUABadM67Aq8qpGaTYU1DjvT8dgpG3rkjNA2bX8dEZH6vjPy
         GuUHP9boYRGb0N2xr03ezMXa5rOBXQ6HYLko+qJGbXkdmq02jG2W9ymCAAvqalmqoJeK
         eL70kiGYdUXIwDUq18JRGNSL+eXGK02AhvYLdK4pnKElv6XFQWxWjU425JhQo1onsHVy
         3msxCKJPespMIsHCucHE4MXL0QQ+qzaJeSgzbyNmnRZzxB+yGXfohJJ1+zxnFa7oYZ4f
         /hH2MBtBHQly58cputAKGozmJghIRuqOV4gTKn/dn7MdyXefKHXor/qmU/6Ubd3e1c0Y
         9xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482545; x=1702087345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb2msrxaVNlWSR/UolFSkDQjk3NlZGZRnRZHtc3FiMU=;
        b=uiTNQm4MU6J+iu7pW5UkP1Cax4n0Z8iI2LQ09jFyZEABkuxxyZPX6Ns3h8NqNM6VqE
         JjUu/0zTekreUJDg0UdgPKc/Sle+msN5nEeUj7qQitBs6w/K/sdahzrcSo0IHpS+srkd
         CMeJWsSY9XsxuWz2sZn4x/m8AS+KexSdwacTyO7+BcduE5+UBmfh8vZOD7fHQI0IfD1w
         v3AWpW4L6FaRI/PzxfB+qci/CLXPbQ3KCYfnpRSwmBRNOHUocKCGBpSwlt8013tqXGQx
         yzQx6xpLEPkq7f2F3n7OUrQSjFqbKJ7jyMFEYadSITYcLQ0YWY0z549eg/PM1Kb22pxt
         oMTg==
X-Gm-Message-State: AOJu0YyibfD1xhJ9/68lUTUOYC/mQc09+bxVsYFpcX/fmq0Bv42AYMvG
	KF1KBgycNPIbbYYefMITDz+Csv5jixU8Tiqz
X-Google-Smtp-Source: AGHT+IHtoGOiwAd+G+PX0dP7vmg5Jh/lU+r41rPOwDztpNNTKR8t2DDzbMERCfSgbDG9pVbWQHYNtw==
X-Received: by 2002:a05:6808:1242:b0:3b8:4db9:b791 with SMTP id o2-20020a056808124200b003b84db9b791mr456552oiv.48.1701482544821;
        Fri, 01 Dec 2023 18:02:24 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:02:24 -0800 (PST)
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
Subject: [PATCHv3 net-next 14/14] selftests/net: convert unicast_extensions.sh to run it in unique namespace
Date: Sat,  2 Dec 2023 10:01:10 +0800
Message-ID: <20231202020110.362433-15-liuhangbin@gmail.com>
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

 # ./unicast_extensions.sh
 /usr/bin/which: no nettest in (/root/.local/bin:/root/bin:/usr/share/Modules/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin)
 ###########################################################################
 Unicast address extensions tests (behavior of reserved IPv4 addresses)
 ###########################################################################
 TEST: assign and ping within 240/4 (1 of 2) (is allowed)            [ OK ]
 TEST: assign and ping within 240/4 (2 of 2) (is allowed)            [ OK ]
 TEST: assign and ping within 0/8 (1 of 2) (is allowed)              [ OK ]

 ...

 TEST: assign and ping class D address (is forbidden)                [ OK ]
 TEST: routing using class D (is forbidden)                          [ OK ]
 TEST: routing using 127/8 (is forbidden)                            [ OK ]

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/unicast_extensions.sh       | 99 +++++++++----------
 1 file changed, 46 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/net/unicast_extensions.sh b/tools/testing/selftests/net/unicast_extensions.sh
index 2d10ccac898a..b7a2cb9e7477 100755
--- a/tools/testing/selftests/net/unicast_extensions.sh
+++ b/tools/testing/selftests/net/unicast_extensions.sh
@@ -28,8 +28,7 @@
 # These tests provide an easy way to flip the expected result of any
 # of these behaviors for testing kernel patches that change them.
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source ./lib.sh
 
 # nettest can be run from PATH or from same directory as this selftest
 if ! which nettest >/dev/null; then
@@ -61,20 +60,20 @@ _do_segmenttest(){
 	# foo --- bar
 	# Arguments: ip_a ip_b prefix_length test_description
 	#
-	# Caller must set up foo-ns and bar-ns namespaces
+	# Caller must set up $foo_ns and $bar_ns namespaces
 	# containing linked veth devices foo and bar,
 	# respectively.
 
-	ip -n foo-ns address add $1/$3 dev foo || return 1
-	ip -n foo-ns link set foo up || return 1
-	ip -n bar-ns address add $2/$3 dev bar || return 1
-	ip -n bar-ns link set bar up || return 1
+	ip -n $foo_ns address add $1/$3 dev foo || return 1
+	ip -n $foo_ns link set foo up || return 1
+	ip -n $bar_ns address add $2/$3 dev bar || return 1
+	ip -n $bar_ns link set bar up || return 1
 
-	ip netns exec foo-ns timeout 2 ping -c 1 $2 || return 1
-	ip netns exec bar-ns timeout 2 ping -c 1 $1 || return 1
+	ip netns exec $foo_ns timeout 2 ping -c 1 $2 || return 1
+	ip netns exec $bar_ns timeout 2 ping -c 1 $1 || return 1
 
-	nettest -B -N bar-ns -O foo-ns -r $1 || return 1
-	nettest -B -N foo-ns -O bar-ns -r $2 || return 1
+	nettest -B -N $bar_ns -O $foo_ns -r $1 || return 1
+	nettest -B -N $foo_ns -O $bar_ns -r $2 || return 1
 
 	return 0
 }
@@ -88,31 +87,31 @@ _do_route_test(){
 	# Arguments: foo_ip foo1_ip bar1_ip bar_ip prefix_len test_description
 	# Displays test result and returns success or failure.
 
-	# Caller must set up foo-ns, bar-ns, and router-ns
+	# Caller must set up $foo_ns, $bar_ns, and $router_ns
 	# containing linked veth devices foo-foo1, bar1-bar
-	# (foo in foo-ns, foo1 and bar1 in router-ns, and
-	# bar in bar-ns).
-
-	ip -n foo-ns address add $1/$5 dev foo || return 1
-	ip -n foo-ns link set foo up || return 1
-	ip -n foo-ns route add default via $2 || return 1
-	ip -n bar-ns address add $4/$5 dev bar || return 1
-	ip -n bar-ns link set bar up || return 1
-	ip -n bar-ns route add default via $3 || return 1
-	ip -n router-ns address add $2/$5 dev foo1 || return 1
-	ip -n router-ns link set foo1 up || return 1
-	ip -n router-ns address add $3/$5 dev bar1 || return 1
-	ip -n router-ns link set bar1 up || return 1
-
-	echo 1 | ip netns exec router-ns tee /proc/sys/net/ipv4/ip_forward
-
-	ip netns exec foo-ns timeout 2 ping -c 1 $2 || return 1
-	ip netns exec foo-ns timeout 2 ping -c 1 $4 || return 1
-	ip netns exec bar-ns timeout 2 ping -c 1 $3 || return 1
-	ip netns exec bar-ns timeout 2 ping -c 1 $1 || return 1
-
-	nettest -B -N bar-ns -O foo-ns -r $1 || return 1
-	nettest -B -N foo-ns -O bar-ns -r $4 || return 1
+	# (foo in $foo_ns, foo1 and bar1 in $router_ns, and
+	# bar in $bar_ns).
+
+	ip -n $foo_ns address add $1/$5 dev foo || return 1
+	ip -n $foo_ns link set foo up || return 1
+	ip -n $foo_ns route add default via $2 || return 1
+	ip -n $bar_ns address add $4/$5 dev bar || return 1
+	ip -n $bar_ns link set bar up || return 1
+	ip -n $bar_ns route add default via $3 || return 1
+	ip -n $router_ns address add $2/$5 dev foo1 || return 1
+	ip -n $router_ns link set foo1 up || return 1
+	ip -n $router_ns address add $3/$5 dev bar1 || return 1
+	ip -n $router_ns link set bar1 up || return 1
+
+	echo 1 | ip netns exec $router_ns tee /proc/sys/net/ipv4/ip_forward
+
+	ip netns exec $foo_ns timeout 2 ping -c 1 $2 || return 1
+	ip netns exec $foo_ns timeout 2 ping -c 1 $4 || return 1
+	ip netns exec $bar_ns timeout 2 ping -c 1 $3 || return 1
+	ip netns exec $bar_ns timeout 2 ping -c 1 $1 || return 1
+
+	nettest -B -N $bar_ns -O $foo_ns -r $1 || return 1
+	nettest -B -N $foo_ns -O $bar_ns -r $4 || return 1
 
 	return 0
 }
@@ -121,17 +120,15 @@ segmenttest(){
 	# Sets up veth link and tries to connect over it.
 	# Arguments: ip_a ip_b prefix_len test_description
 	hide_output
-	ip netns add foo-ns
-	ip netns add bar-ns
-	ip link add foo netns foo-ns type veth peer name bar netns bar-ns
+	setup_ns foo_ns bar_ns
+	ip link add foo netns $foo_ns type veth peer name bar netns $bar_ns
 
 	test_result=0
 	_do_segmenttest "$@" || test_result=1
 
-	ip netns pids foo-ns | xargs -r kill -9
-	ip netns pids bar-ns | xargs -r kill -9
-	ip netns del foo-ns
-	ip netns del bar-ns
+	ip netns pids $foo_ns | xargs -r kill -9
+	ip netns pids $bar_ns | xargs -r kill -9
+	cleanup_ns $foo_ns $bar_ns
 	show_output
 
 	# inverted tests will expect failure instead of success
@@ -147,21 +144,17 @@ route_test(){
 	# Returns success or failure.
 
 	hide_output
-	ip netns add foo-ns
-	ip netns add bar-ns
-	ip netns add router-ns
-	ip link add foo netns foo-ns type veth peer name foo1 netns router-ns
-	ip link add bar netns bar-ns type veth peer name bar1 netns router-ns
+	setup_ns foo_ns bar_ns router_ns
+	ip link add foo netns $foo_ns type veth peer name foo1 netns $router_ns
+	ip link add bar netns $bar_ns type veth peer name bar1 netns $router_ns
 
 	test_result=0
 	_do_route_test "$@" || test_result=1
 
-	ip netns pids foo-ns | xargs -r kill -9
-	ip netns pids bar-ns | xargs -r kill -9
-	ip netns pids router-ns | xargs -r kill -9
-	ip netns del foo-ns
-	ip netns del bar-ns
-	ip netns del router-ns
+	ip netns pids $foo_ns | xargs -r kill -9
+	ip netns pids $bar_ns | xargs -r kill -9
+	ip netns pids $router_ns | xargs -r kill -9
+	cleanup_ns $foo_ns $bar_ns $router_ns
 
 	show_output
 
-- 
2.43.0


