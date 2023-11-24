Return-Path: <linux-kselftest+bounces-534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C051E7F6FC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E117E1C211D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1ED16420;
	Fri, 24 Nov 2023 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgGJWXvq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F1D7E;
	Fri, 24 Nov 2023 01:30:11 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so1219384a12.0;
        Fri, 24 Nov 2023 01:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818210; x=1701423010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22bGeDvOqSIi2jLo3b1e9rGAXyX9O1zzDqW07GHNxIE=;
        b=DgGJWXvqrPNYP21bWzfjLrsY1Xfe7hMPhAdrv9OtzTxqyMBDvg1cIulp7Eh13vr7Uu
         FOrCwhEOzz6QHiEcaOLd8qfuNdd9/I2gWkZkvfDKzbS6+iH6Xq9NaYQ52a1x/9toDp6N
         TmLg3BtkXF41ljgTW9Il5Az62xjvbH0hvMLWe6yE62KSMecirrHod31w01QZiSo+WvOk
         TwnYFwhEF1w6+Oygu9gW18Gn6A1zMx/VENJYm9Ql9pncoD/K9XpJO3P9gBSPgKEyOCb1
         O1tLd6+HLhNaGy4ZXp9eE05SSxSn5zDfIpa7v+EpQRdSCwrFdyL0Nr/9L/kwmIaoTenm
         mWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818210; x=1701423010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22bGeDvOqSIi2jLo3b1e9rGAXyX9O1zzDqW07GHNxIE=;
        b=BasmcVamOJl8kilS0YzoqeG5mBL5Nj0LDcoDHifEEQbIBKvL8cmD4mCPcyW51oIInO
         KDxlZpIPtSrJcU89lBfdf6j5K9D4pZmy33gneabVPm2ZQs8BirXNhTNJTLuk1bFGZfYg
         /1ggvhvX/dwQKbOXfC5M36xktuWdzSXudCXC/VMVdlT01HP3sCOnrD3IkpkJytYTGR4i
         BpL7FOqusVXL5Kn0J3ILl9gvas56/r36zA7yq6kFk/iszW/XxuA/SUYdZyhsYPxbRNp2
         2JkaR5W4wRIHbDgo6JCW43cMcyvTCb5Fdd5FRzo8CepZbpCM6CJeA5s8iECp3k+4MOAz
         vwlQ==
X-Gm-Message-State: AOJu0Yz0CQGT/zmj+iFkjwbV3oIk9bHYQHLJmN8X4m5nT0h8e03G7kZd
	G7RCkNxMZZLl26W7mvGpxdzym2JqSvDOBgpg
X-Google-Smtp-Source: AGHT+IGDEQVJ/c5WoJ5ktmgULXJoQm4TkyGoA6wfJW/Tqay/x0K8RYBbHtF9Jjgvwncq0Zf8JHAgRQ==
X-Received: by 2002:a05:6a20:94c5:b0:18b:2265:c6d3 with SMTP id ht5-20020a056a2094c500b0018b2265c6d3mr2303545pzb.36.1700818209962;
        Fri, 24 Nov 2023 01:30:09 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:09 -0800 (PST)
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
Subject: [PATCH net-next 32/38] selftests/net: convert unicast_extensions.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:30 +0800
Message-ID: <20231124092736.3673263-33-liuhangbin@gmail.com>
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
2.41.0


