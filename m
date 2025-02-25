Return-Path: <linux-kselftest+bounces-27403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544CFA43301
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF94B17B614
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A99146A69;
	Tue, 25 Feb 2025 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ3/iTN2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFD139CFA;
	Tue, 25 Feb 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450280; cv=none; b=sExiSz7Ngdm0TEwYRzNBf/P6r/w/84BbLlp8ic8yTmj5eudfHUIsSlcaN031z+0UnUR6N1Z4rIMjLXa6yXB8hnnonk/5jWWbw1lKEwB7uF8pXUQPYu5Jt2twuphQ4mKigfBzk836Nwxo1ei+GZllTbDCK3Je2QJQ7tU73KefILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450280; c=relaxed/simple;
	bh=6zn3Nzutmy9/cUH60WGsiUkCWy+MPNzKQZgD8FOaNZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvPsFuqTITP17oCx0wQH5uAQdmZZOI1WS4v5TCPbDdRjBNlfOQv21aeeEwjfzSV7pyLmGsH0spVvSyOW21EVMWC+phwJNF1DM/3CK3EWgHU92/w+R6CxJpafrdeheLgHtP29o91RnLMPzA3jA7rK/9L+gk1fEOzIkJV+mGdPtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ3/iTN2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e66a7e2754so40527036d6.3;
        Mon, 24 Feb 2025 18:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740450277; x=1741055077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOzDBahQI1VZ4AoB6s44bfERS1wLfqb+e8MX85aOWHU=;
        b=jJ3/iTN2Rd81gPKXPyOa52/aoE5wpR5TVSelgOXqxMEeU0G9JJRhQLnVxaPD5xjrp1
         zPPFoVBcztpHZYC0MBSu++5xFOImEoTUsYfogb9yOjH3U8skL2vK/e1eLI+lQc1UjEEF
         cxFHIeW561Ke8paGBA+Cr76wQA/bBi3bUpMpmGOkTf2oUh11+5yiEscSmIJHygaR1TLc
         YK6/8qd2eRtqtQyBKUivvQBc2KtHGAr4mk2icTQep1pKbtE7Q6qpw54jquhlyvXQ5nRU
         WDLdyWv3265LfDPQozlJDzynh7XhmX/za+aQEyVLTDC1Z82S7+/Dr/ZyuAQ0iS1KV/Xw
         yavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740450277; x=1741055077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOzDBahQI1VZ4AoB6s44bfERS1wLfqb+e8MX85aOWHU=;
        b=cMhRy99cUQ9wbxpSmJUP6TjNUZ7WPTTW1l35GlBe3ZUqWH5F38+dly9YcIn/qLAyGg
         oVTF5qANnGs6VtXtjKDQih4Hrw7WHTY1NhGoUeCSfS0Ru2GgkQ5aC/nT22HKVjsHFo0r
         gkC0W8+jhA0LUdL+SRfJ9xR/eAN2QyDHsX+7iuAhx7TRLNiObyG5I2x1uF5qH0xXBXyo
         na8h++X5z1MTyicVBa6H7B/LUoN4MXTNvolib5VXaG4B7uy94puaVGWQHyKElMkjOTHw
         /ENHFrR39t7A5T0ndaD+F1iiXZUQhOPSjbKijjzdK9AsS0vX73LAg/nhTpahTUxVHzN4
         NEoA==
X-Forwarded-Encrypted: i=1; AJvYcCVgPn6zIcgEiJetwsHtsoQ0LJiwr1fF/WSYZ6GnkhcSqWhneHURzapVMp9kj5hmbjP5zFN3WVOecrLgB8bC9Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSMb170MjrZZraEoyhZFYZcRJh3CihYcDCaVc9l/N5X4rq+yp
	fILr5Zyrvcrd1xHfaIMt7XwdWPU0717zTqCcNtSDxIUKo/6ZTmCNbl35TQ==
X-Gm-Gg: ASbGnct2FMMB4UcH+uqZelAgBexzmjHVm+DfrJDrqt8zINuXgLOorWQXlVj8vaY3G0i
	OExMWAentTydVExTaMTUuh6mLuWkTnqD67Kmlr1V4LAUV74P+ksAGj5dELekLoJm51yzl76EtKL
	/VmH3ini8+Qqbk/xpiQAasOH7yXFZ3RTu1x/5C7hCeZ4krzmh0lW4AH0nDoJSzd3Iwqa6a1ahi1
	PBgpGNSgGd+sw6DtQyWjHGkwvTVr/FDJYHHLjhivfLevmoYZa98CSdTSs7JuLMeqOeMpfw7QZBJ
	RwwWJ4nJv2wefCz4B74NOMC8ZuyxFdyD1EATQEsasI4F/cxBNY+pQIlD/VvMAeXcLujptmkBYCP
	MWbvPmfHD8hcUiueU0JzdWaWm3A==
X-Google-Smtp-Source: AGHT+IHorHUXBmjbJ8PNr46MG5o1eYBtb3kb49VPR56rnTVBOgzEHcmG5Y1YWmBk8mzv4ZQWhzn3+g==
X-Received: by 2002:a05:6214:c4d:b0:6e4:42bb:5edc with SMTP id 6a1803df08f44-6e6ae7c9a0cmr188520616d6.8.1740450276965;
        Mon, 24 Feb 2025 18:24:36 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b09c5b8sm4368996d6.55.2025.02.24.18.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:24:36 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/2] selftests/net: expand cmsg_ipv6.sh with ipv4
Date: Mon, 24 Feb 2025 21:23:59 -0500
Message-ID: <20250225022431.2083926-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250225022431.2083926-1-willemdebruijn.kernel@gmail.com>
References: <20250225022431.2083926-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Expand IPV6_TCLASS to also cover IP_TOS.
Expand IPV6_HOPLIMIT to also cover IP_TTL.

Expand csmg_sender.c to allow setting IPv4 setsockopts.
Also rename struct v6 to cmsg to match its expanded scope.
Don't bother updating all occurrences of tclass and hoplimit.

Rename cmsg_ipv6.sh to cmsg_ip.sh to match the expanded scope.

Be careful around the subtle API difference between TCLASS and TOS.
IP_TOS includes ECN bits. Add a test to verify that these are masked
when making routing decisions.

Diff is more concise with --word-diff

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/Makefile          |  2 +-
 .../net/{cmsg_ipv6.sh => cmsg_ip.sh}          | 59 ++++++++----
 tools/testing/selftests/net/cmsg_sender.c     | 90 +++++++++++--------
 3 files changed, 96 insertions(+), 55 deletions(-)
 rename tools/testing/selftests/net/{cmsg_ipv6.sh => cmsg_ip.sh} (65%)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index aeb96c085614..2e16ce6d28e4 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -34,7 +34,7 @@ TEST_PROGS += gre_gso.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += test_so_rcv.sh
-TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
+TEST_PROGS += cmsg_time.sh cmsg_ip.sh
 TEST_PROGS += netns-name.sh
 TEST_PROGS += link_netns.py
 TEST_PROGS += nl_netdev.py
diff --git a/tools/testing/selftests/net/cmsg_ipv6.sh b/tools/testing/selftests/net/cmsg_ip.sh
similarity index 65%
rename from tools/testing/selftests/net/cmsg_ipv6.sh
rename to tools/testing/selftests/net/cmsg_ip.sh
index 51132c26e9b5..2a52520aca32 100755
--- a/tools/testing/selftests/net/cmsg_ipv6.sh
+++ b/tools/testing/selftests/net/cmsg_ip.sh
@@ -3,6 +3,8 @@
 
 source lib.sh
 
+IP4=172.16.0.1/24
+TGT4=172.16.0.2
 IP6=2001:db8:1::1/64
 TGT6=2001:db8:1::2
 TMPF=$(mktemp --suffix ".pcap")
@@ -30,6 +32,7 @@ $NSEXE sysctl -w net.ipv4.ping_group_range='0 2147483647' > /dev/null
 # Connectivity
 ip -netns $NS link add type dummy
 ip -netns $NS link set dev dummy0 up
+ip -netns $NS addr add $IP4 dev dummy0
 ip -netns $NS addr add $IP6 dev dummy0
 
 # Test
@@ -63,14 +66,19 @@ for ovr in setsock cmsg both diff; do
     done
 done
 
-# IPV6_TCLASS
+# IP_TOS + IPV6_TCLASS
 
 test_dscp() {
+    local -r IPVER=$1
+    local -r TGT=$2
+    local -r MATCH=$3
+
     local -r TOS=0x10
     local -r TOS2=0x20
+    local -r ECN=0x3
 
-    ip -6 -netns $NS rule add tos $TOS lookup 300
-    ip -6 -netns $NS route add table 300 prohibit any
+    ip $IPVER -netns $NS rule add tos $TOS lookup 300
+    ip $IPVER -netns $NS route add table 300 prohibit any
 
     for ovr in setsock cmsg both diff; do
 	for p in u i r; do
@@ -87,30 +95,42 @@ test_dscp() {
 	    BG=$!
 	    sleep 0.05
 
-	    $NSEXE ./cmsg_sender -6 -p $p $m $((TOS2)) $TGT6 1234
-	    check_result $? 0 "TCLASS $prot $ovr - pass"
+	    $NSEXE ./cmsg_sender $IPVER -p $p $m $((TOS2)) $TGT 1234
+	    check_result $? 0 "$MATCH $prot $ovr - pass"
 
 	    while [ -d /proc/$BG ]; do
-	        $NSEXE ./cmsg_sender -6 -p $p $m $((TOS2)) $TGT6 1234
+	        $NSEXE ./cmsg_sender $IPVER -p $p $m $((TOS2)) $TGT 1234
 	    done
 
-	    tcpdump -r $TMPF -v 2>&1 | grep "class $TOS2" >> /dev/null
-	    check_result $? 0 "TCLASS $prot $ovr - packet data"
+	    tcpdump -r $TMPF -v 2>&1 | grep "$MATCH $TOS2" >> /dev/null
+	    check_result $? 0 "$MATCH $prot $ovr - packet data"
 	    rm $TMPF
 
 	    [ $ovr == "both" ]    && m="-C $((TOS )) -c"
 	    [ $ovr == "diff" ]    && m="-C $((TOS2)) -c"
 
-	    $NSEXE ./cmsg_sender -6 -p $p $m $((TOS)) -s $TGT6 1234
-	    check_result $? 1 "TCLASS $prot $ovr - rejection"
+	    # Match prohibit rule: expect failure
+	    $NSEXE ./cmsg_sender $IPVER -p $p $m $((TOS)) -s $TGT 1234
+	    check_result $? 1 "$MATCH $prot $ovr - rejection"
+
+	    # Match prohibit rule: IPv4 masks ECN: expect failure
+	    if [[ "$IPVER" == "-4" ]]; then
+		$NSEXE ./cmsg_sender $IPVER -p $p $m "$((TOS | ECN))" -s $TGT 1234
+		check_result $? 1 "$MATCH $prot $ovr - rejection (ECN)"
+	    fi
 	done
     done
 }
 
-test_dscp
+test_dscp -4 $TGT4 tos
+test_dscp -6 $TGT6 class
+
+# IP_TTL + IPV6_HOPLIMIT
+test_ttl_hoplimit() {
+    local -r IPVER=$1
+    local -r TGT=$2
+    local -r MATCH=$3
 
-# IPV6_HOPLIMIT
-test_hoplimit() {
     local -r LIM=4
 
     for ovr in setsock cmsg both diff; do
@@ -128,21 +148,22 @@ test_hoplimit() {
 	    BG=$!
 	    sleep 0.05
 
-	    $NSEXE ./cmsg_sender -6 -p $p $m $LIM $TGT6 1234
-	    check_result $? 0 "HOPLIMIT $prot $ovr - pass"
+	    $NSEXE ./cmsg_sender $IPVER -p $p $m $LIM $TGT 1234
+	    check_result $? 0 "$MATCH $prot $ovr - pass"
 
 	    while [ -d /proc/$BG ]; do
-	        $NSEXE ./cmsg_sender -6 -p $p $m $LIM $TGT6 1234
+		$NSEXE ./cmsg_sender $IPVER -p $p $m $LIM $TGT 1234
 	    done
 
-	    tcpdump -r $TMPF -v 2>&1 | grep "hlim $LIM[^0-9]" >> /dev/null
-	    check_result $? 0 "HOPLIMIT $prot $ovr - packet data"
+	    tcpdump -r $TMPF -v 2>&1 | grep "$MATCH $LIM[^0-9]" >> /dev/null
+	    check_result $? 0 "$MATCH $prot $ovr - packet data"
 	    rm $TMPF
 	done
     done
 }
 
-test_hoplimit
+test_ttl_hoplimit -4 $TGT4 ttl
+test_ttl_hoplimit -6 $TGT6 hlim
 
 # IPV6 exthdr
 for p in u i r; do
diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index bc314382e4e1..19bd8499031b 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -72,7 +72,7 @@ struct options {
 		struct option_cmsg_u32 tclass;
 		struct option_cmsg_u32 hlimit;
 		struct option_cmsg_u32 exthdr;
-	} v6;
+	} cmsg;
 } opt = {
 	.size = 13,
 	.num_pkt = 1,
@@ -104,10 +104,10 @@ static void __attribute__((noreturn)) cs_usage(const char *bin)
 	       "\t\t-t      Enable time stamp reporting\n"
 	       "\t\t-f val  Set don't fragment via cmsg\n"
 	       "\t\t-F val  Set don't fragment via setsockopt\n"
-	       "\t\t-c val  Set TCLASS via cmsg\n"
-	       "\t\t-C val  Set TCLASS via setsockopt\n"
-	       "\t\t-l val  Set HOPLIMIT via cmsg\n"
-	       "\t\t-L val  Set HOPLIMIT via setsockopt\n"
+	       "\t\t-c val  Set TOS/TCLASS via cmsg\n"
+	       "\t\t-C val  Set TOS/TCLASS via setsockopt\n"
+	       "\t\t-l val  Set TTL/HOPLIMIT via cmsg\n"
+	       "\t\t-L val  Set TTL/HOPLIMIT via setsockopt\n"
 	       "\t\t-H type Add an IPv6 header option\n"
 	       "\t\t        (h = HOP; d = DST; r = RTDST)"
 	       "");
@@ -169,37 +169,37 @@ static void cs_parse_args(int argc, char *argv[])
 			opt.ts.ena = true;
 			break;
 		case 'f':
-			opt.v6.dontfrag.ena = true;
-			opt.v6.dontfrag.val = atoi(optarg);
+			opt.cmsg.dontfrag.ena = true;
+			opt.cmsg.dontfrag.val = atoi(optarg);
 			break;
 		case 'F':
 			opt.sockopt.dontfrag = atoi(optarg);
 			break;
 		case 'c':
-			opt.v6.tclass.ena = true;
-			opt.v6.tclass.val = atoi(optarg);
+			opt.cmsg.tclass.ena = true;
+			opt.cmsg.tclass.val = atoi(optarg);
 			break;
 		case 'C':
 			opt.sockopt.tclass = atoi(optarg);
 			break;
 		case 'l':
-			opt.v6.hlimit.ena = true;
-			opt.v6.hlimit.val = atoi(optarg);
+			opt.cmsg.hlimit.ena = true;
+			opt.cmsg.hlimit.val = atoi(optarg);
 			break;
 		case 'L':
 			opt.sockopt.hlimit = atoi(optarg);
 			break;
 		case 'H':
-			opt.v6.exthdr.ena = true;
+			opt.cmsg.exthdr.ena = true;
 			switch (optarg[0]) {
 			case 'h':
-				opt.v6.exthdr.val = IPV6_HOPOPTS;
+				opt.cmsg.exthdr.val = IPV6_HOPOPTS;
 				break;
 			case 'd':
-				opt.v6.exthdr.val = IPV6_DSTOPTS;
+				opt.cmsg.exthdr.val = IPV6_DSTOPTS;
 				break;
 			case 'r':
-				opt.v6.exthdr.val = IPV6_RTHDRDSTOPTS;
+				opt.cmsg.exthdr.val = IPV6_RTHDRDSTOPTS;
 				break;
 			default:
 				printf("Error: hdr type: %s\n", optarg);
@@ -261,12 +261,20 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
 			  SOL_SOCKET, SO_MARK, &opt.mark);
 	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
 			  SOL_SOCKET, SO_PRIORITY, &opt.priority);
-	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
-			  SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
-	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
-			  SOL_IPV6, IPV6_TCLASS, &opt.v6.tclass);
-	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
-			  SOL_IPV6, IPV6_HOPLIMIT, &opt.v6.hlimit);
+
+	if (opt.sock.family == AF_INET) {
+		ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
+				  SOL_IP, IP_TOS, &opt.cmsg.tclass);
+		ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
+				  SOL_IP, IP_TTL, &opt.cmsg.hlimit);
+	} else {
+		ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
+				  SOL_IPV6, IPV6_DONTFRAG, &opt.cmsg.dontfrag);
+		ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
+				  SOL_IPV6, IPV6_TCLASS, &opt.cmsg.tclass);
+		ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
+				  SOL_IPV6, IPV6_HOPLIMIT, &opt.cmsg.hlimit);
+	}
 
 	if (opt.txtime.ena) {
 		__u64 txtime;
@@ -297,14 +305,14 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
 		*(__u32 *)CMSG_DATA(cmsg) = SOF_TIMESTAMPING_TX_SCHED |
 					    SOF_TIMESTAMPING_TX_SOFTWARE;
 	}
-	if (opt.v6.exthdr.ena) {
+	if (opt.cmsg.exthdr.ena) {
 		cmsg = (struct cmsghdr *)(cbuf + cmsg_len);
 		cmsg_len += CMSG_SPACE(8);
 		if (cbuf_sz < cmsg_len)
 			error(ERN_CMSG_WR, EFAULT, "cmsg buffer too small");
 
 		cmsg->cmsg_level = SOL_IPV6;
-		cmsg->cmsg_type = opt.v6.exthdr.val;
+		cmsg->cmsg_type = opt.cmsg.exthdr.val;
 		cmsg->cmsg_len = CMSG_LEN(8);
 		*(__u64 *)CMSG_DATA(cmsg) = 0;
 	}
@@ -405,23 +413,35 @@ static void ca_set_sockopts(int fd)
 	    setsockopt(fd, SOL_SOCKET, SO_MARK,
 		       &opt.sockopt.mark, sizeof(opt.sockopt.mark)))
 		error(ERN_SOCKOPT, errno, "setsockopt SO_MARK");
-	if (opt.sockopt.dontfrag &&
-	    setsockopt(fd, SOL_IPV6, IPV6_DONTFRAG,
-		       &opt.sockopt.dontfrag, sizeof(opt.sockopt.dontfrag)))
-		error(ERN_SOCKOPT, errno, "setsockopt IPV6_DONTFRAG");
-	if (opt.sockopt.tclass &&
-	    setsockopt(fd, SOL_IPV6, IPV6_TCLASS,
-		       &opt.sockopt.tclass, sizeof(opt.sockopt.tclass)))
-		error(ERN_SOCKOPT, errno, "setsockopt IPV6_TCLASS");
-	if (opt.sockopt.hlimit &&
-	    setsockopt(fd, SOL_IPV6, IPV6_UNICAST_HOPS,
-		       &opt.sockopt.hlimit, sizeof(opt.sockopt.hlimit)))
-		error(ERN_SOCKOPT, errno, "setsockopt IPV6_HOPLIMIT");
 	if (opt.sockopt.priority &&
 	    setsockopt(fd, SOL_SOCKET, SO_PRIORITY,
 		       &opt.sockopt.priority, sizeof(opt.sockopt.priority)))
 		error(ERN_SOCKOPT, errno, "setsockopt SO_PRIORITY");
 
+	if (opt.sock.family == AF_INET) {
+		if (opt.sockopt.tclass &&
+		    setsockopt(fd, SOL_IP, IP_TOS,
+			       &opt.sockopt.tclass, sizeof(opt.sockopt.tclass)))
+			error(ERN_SOCKOPT, errno, "setsockopt IP_TOS");
+		if (opt.sockopt.hlimit &&
+		    setsockopt(fd, SOL_IP, IP_TTL,
+			       &opt.sockopt.hlimit, sizeof(opt.sockopt.hlimit)))
+			error(ERN_SOCKOPT, errno, "setsockopt IP_TTL");
+	} else {
+		if (opt.sockopt.dontfrag &&
+		    setsockopt(fd, SOL_IPV6, IPV6_DONTFRAG,
+			       &opt.sockopt.dontfrag, sizeof(opt.sockopt.dontfrag)))
+			error(ERN_SOCKOPT, errno, "setsockopt IPV6_DONTFRAG");
+		if (opt.sockopt.tclass &&
+		    setsockopt(fd, SOL_IPV6, IPV6_TCLASS,
+			       &opt.sockopt.tclass, sizeof(opt.sockopt.tclass)))
+			error(ERN_SOCKOPT, errno, "setsockopt IPV6_TCLASS");
+		if (opt.sockopt.hlimit &&
+		    setsockopt(fd, SOL_IPV6, IPV6_UNICAST_HOPS,
+			       &opt.sockopt.hlimit, sizeof(opt.sockopt.hlimit)))
+			error(ERN_SOCKOPT, errno, "setsockopt IPV6_HOPLIMIT");
+	}
+
 	if (opt.txtime.ena) {
 		struct sock_txtime so_txtime = {
 			.clockid = CLOCK_MONOTONIC,
-- 
2.48.1.658.g4767266eb4-goog


