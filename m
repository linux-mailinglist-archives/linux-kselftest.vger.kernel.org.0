Return-Path: <linux-kselftest+bounces-510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A0A7F6F94
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF62281DBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81A14F60;
	Fri, 24 Nov 2023 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJOmBUzF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC7FD6F;
	Fri, 24 Nov 2023 01:28:28 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf59c07faeso12873035ad.2;
        Fri, 24 Nov 2023 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818108; x=1701422908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJMgPbrP5UvlU9fu1Hxhe9v6i0//LxSD5GMYH3AvBO0=;
        b=JJOmBUzFGOYUs9drp4pqVWqkdwJFJ4EVd8v6sEdbHUFwnIMwDcKvE43RJLbUjTJZSf
         UUDsfjFpPV7HF2G5ye8qTMlU8KCc9KZ0kATglJKGgU45pXMRM9n3L1gKl9Ir8AAIQjve
         L5DjLstulFd70HvoUZk0/4Db44Z7jT7fsvO82hh1Xx9ALrGSOkWrrzFl/4z+GcaYnoQ6
         1GQ0JoOt3udTMGR4V8bI6dfb/8/0nuph/JsTojWzlReQN0XMcSZkiIQ2Wr4AC9WohVsF
         UnaYdgMDiI28rCu8F0PuvkS8uX3qNYnJ9FmqF3oaEd3taNzZWjQZrQnRE/LpCtz7coS4
         fgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818108; x=1701422908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJMgPbrP5UvlU9fu1Hxhe9v6i0//LxSD5GMYH3AvBO0=;
        b=D2xeQIePMcfl5lbsFR/mfsJABfbR5o7lGnWWJg8bJEkhP98ZweQCesXCZZg6rh1cUN
         ieA5vT7Osl5VXLn2HG8uu/9OOyTyaa97Vhx85g9vAWCe5rUHTzBibj/2HGzSTx95pd+R
         PrU2rFo/bcFJ96aUgTIcza4bMD9GN9ueezIzr6/txD9l62KHETaYNqNkIryEYKFYWdm0
         7lemW79CeRGwuIOktFskI3TqdD7BioSj1mBEsu+09h5jNnYmGI/mJZcYKx7RYaO63Nrx
         oMfZaAIy8nuUz/6bVViYJhnGptLSSkjeLnuEUjQzqhni1RcqzfYe2m7eE9DyjghyArvr
         tYbw==
X-Gm-Message-State: AOJu0YwYMdkZV6whaaUmvrj9+K1R0vNsnF3LskPobL0mB+9G0/aWcSOX
	a1AK9IPUP6LUUn78SWUJgCXduHx5XPZtjSDM
X-Google-Smtp-Source: AGHT+IEXnP9txGRYuDCx/Bkj3L6HIPs8Ga1Lyg95r+r/ZcWdHR3232RD6PURDTdfziR/rkLbhqr32A==
X-Received: by 2002:a17:902:8c85:b0:1cf:51c5:d427 with SMTP id t5-20020a1709028c8500b001cf51c5d427mr1931639plo.65.1700818108084;
        Fri, 24 Nov 2023 01:28:28 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:27 -0800 (PST)
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
Subject: [PATCH net-next 08/38] selftests/net: convert fib_nexthop_nongw.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:06 +0800
Message-ID: <20231124092736.3673263-9-liuhangbin@gmail.com>
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

]# ./fib_nexthop_nongw.sh
TEST: nexthop: get route with nexthop without gw                    [ OK ]
TEST: nexthop: ping through nexthop without gw                      [ OK ]

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
2.41.0


