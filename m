Return-Path: <linux-kselftest+bounces-1982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC14E813FEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06168B21CEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113019E;
	Fri, 15 Dec 2023 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ZP3kLNXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA417DB
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso7647755e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607846; x=1703212646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFjZBuDqESGIn1Gif+RfCOIbD2uia1amtmQGs+YCywY=;
        b=ZP3kLNXPhdqXMCN8CkYOgQO6Nxyy8H4rrpa3yoJn0tzRQCmsCRPQalr61qY1/4X5Yz
         6blw1ND2+BA+dNabx1JCss1Yy8G+J4sIGNUEZlup18l2yTZ36vPQ1j/ddEje68VF6Z8y
         A/MGzuWEmWvDgu/C9MUAncSxH90SxPnOKFHvckj21Acze30qVOQEDHhigsVXkB9GPSTl
         SlZDkqCqujikFXxHE7DHXmHGMb75ng59ks2lRyVpRdO0jtp0FQjhMoyfyhqbadgjyAdO
         4Vlq9H0Zsr9Dqu9djyXOGBXRgtu6mcNTA1U4Zi5PH1vinHdWYSw6zBKaWKslrJNW+fw0
         +TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607846; x=1703212646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFjZBuDqESGIn1Gif+RfCOIbD2uia1amtmQGs+YCywY=;
        b=R9At5p3BVVTArCBsiaYRXYSbzxgDnRh7WJyNLsxqenHbtqnl4AfyUwTWe9mbayFu3Z
         mCY/5h2awV97F82iXl+IO3ASYX48sLaIS1WIz3QGqL9HDTtEeJlelCdvIIeFkZqYWk9Q
         3Z2GNIFM5iJndgIs0Mn+Ay3x2FbURhrp7dqaG5Z0IfXcyI0TJYnDxxbxXt4khv616G+D
         W6jC4yk2euI0k8X/5pB/mgvCnnYdJ6RZ+4uY9Mn3LYY7SWjZNkTQD5RYJAZHlZCkE1d0
         bcJxFI/psTDa1rB7btKt6c9eNQJHVYuUdt1A0tJ1lf2k2rc8ygsjss20pfrmf0nsE8F4
         1P7w==
X-Gm-Message-State: AOJu0YxwdxjDK7PXQCpSZV2IdS49ngRd+xkWeqGcgoUotzo6Re1AaNsL
	c8zP5NuV3PSas7swdeWTDsSeSg==
X-Google-Smtp-Source: AGHT+IGFFBf+n8q40GtYYZlOAeCFJ3yfAqXYxlTaC+qKna0/R48JOBzgboQw4vie8687/3RIbwtMBA==
X-Received: by 2002:a05:600c:3511:b0:40c:451b:45de with SMTP id h17-20020a05600c351100b0040c451b45demr4517649wmq.121.1702607846369;
        Thu, 14 Dec 2023 18:37:26 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:25 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH 03/12] selftests/net: Add TCP-AO ICMPs accept test
Date: Fri, 15 Dec 2023 02:36:17 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-3-f6c08180b985@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607832; l=6969; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=J0MdMfJTIblBDZNk9W1pLtnvDAbnpaVavlgQ6/BawhA=; b=m6SOvF07iLeqeYBjewgXEC8fmt0SPErF2HOyZYJVbqeQfUN0PdJ3f0nibwkoo/iuHgYRH5EdE 9wiqy/6AjPDA5zY6I8wPul+r6PL4dSwjh0RVDDIr7Fl623S9MOOHaQt
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Reverse to icmps-discard test: the server accepts ICMPs, using
TCP_AO_CMDF_ACCEPT_ICMP and it is expected to fail under ICMP
flood from client. Test that the default pre-TCP-AO behaviour functions
when TCP_AO_CMDF_ACCEPT_ICMP is set.

Expected output for ipv4 version (in case it receives ICMP_PROT_UNREACH):
> # ./icmps-accept_ipv4
> 1..3
> # 3209[lib/setup.c:166] rand seed 1642623870
> TAP version 13
> # 3209[lib/proc.c:207]    Snmp6             Ip6InReceives: 0 => 1
> # 3209[lib/proc.c:207]    Snmp6             Ip6InNoRoutes: 0 => 1
> # 3209[lib/proc.c:207]    Snmp6               Ip6InOctets: 0 => 76
> # 3209[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 0 => 1
> # 3209[lib/proc.c:207]      Tcp                    InSegs: 3 => 23
> # 3209[lib/proc.c:207]      Tcp                   OutSegs: 2 => 22
> # 3209[lib/proc.c:207]  IcmpMsg                   InType3: 0 => 4
> # 3209[lib/proc.c:207]     Icmp                    InMsgs: 0 => 4
> # 3209[lib/proc.c:207]     Icmp            InDestUnreachs: 0 => 4
> # 3209[lib/proc.c:207]       Ip                InReceives: 3 => 27
> # 3209[lib/proc.c:207]       Ip                InDelivers: 3 => 27
> # 3209[lib/proc.c:207]       Ip               OutRequests: 2 => 22
> # 3209[lib/proc.c:207]    IpExt                  InOctets: 288 => 3420
> # 3209[lib/proc.c:207]    IpExt                 OutOctets: 124 => 3244
> # 3209[lib/proc.c:207]    IpExt               InNoECTPkts: 3 => 25
> # 3209[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> # 3209[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 20
> # 3209[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 19
> # 3209[lib/proc.c:207]   TcpExt                 TCPAOGood: 3 => 23
> ok 1 InDestUnreachs delivered 4
> ok 2 server failed with -92: Protocol not available
> ok 3 TCPAODroppedIcmps counter didn't change: 0 >= 0
> # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Expected output for ipv6 version (in case it receives ADM_PROHIBITED):
> # ./icmps-accept_ipv6
> 1..3
> # 3277[lib/setup.c:166] rand seed 1642624035
> TAP version 13
> # 3277[lib/proc.c:207]    Snmp6             Ip6InReceives: 6 => 31
> # 3277[lib/proc.c:207]    Snmp6             Ip6InDelivers: 4 => 29
> # 3277[lib/proc.c:207]    Snmp6            Ip6OutRequests: 4 => 24
> # 3277[lib/proc.c:207]    Snmp6               Ip6InOctets: 592 => 4492
> # 3277[lib/proc.c:207]    Snmp6              Ip6OutOctets: 332 => 3852
> # 3277[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 6 => 31
> # 3277[lib/proc.c:207]    Snmp6               Icmp6InMsgs: 1 => 6
> # 3277[lib/proc.c:207]    Snmp6       Icmp6InDestUnreachs: 0 => 5
> # 3277[lib/proc.c:207]    Snmp6              Icmp6InType1: 0 => 5
> # 3277[lib/proc.c:207]      Tcp                    InSegs: 3 => 23
> # 3277[lib/proc.c:207]      Tcp                   OutSegs: 2 => 22
> # 3277[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> # 3277[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 20
> # 3277[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 19
> # 3277[lib/proc.c:207]   TcpExt                 TCPAOGood: 3 => 23
> ok 1 Icmp6InDestUnreachs delivered 5
> ok 2 server failed with -13: Permission denied
> ok 3 TCPAODroppedIcmps counter didn't change: 0 >= 0
> # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

With some luck the server may fail with ECONNREFUSED (depending on what
icmp packet was delivered firstly).
For the kernel error handlers see: tab_unreach[] and icmp_err_convert[].

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile        |  4 +++-
 tools/testing/selftests/net/tcp_ao/icmps-accept.c  |  1 +
 tools/testing/selftests/net/tcp_ao/icmps-discard.c | 25 ++++++++++++++++------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 0fc5db59be0c..7bf61b167ec5 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_BOTH_AF := connect
-TEST_BOTH_AF += icmps-discard
+TEST_BOTH_AF += icmps-accept icmps-discard
 
 TEST_IPV4_PROGS := $(TEST_BOTH_AF:%=%_ipv4)
 TEST_IPV6_PROGS := $(TEST_BOTH_AF:%=%_ipv6)
@@ -44,3 +44,5 @@ $(OUTPUT)/%_ipv4: %.c
 $(OUTPUT)/%_ipv6: %.c
 	$(LINK.c) -DIPV6_TEST $^ $(LDLIBS) -o $@
 
+$(OUTPUT)/icmps-accept_ipv4: CFLAGS+= -DTEST_ICMPS_ACCEPT
+$(OUTPUT)/icmps-accept_ipv6: CFLAGS+= -DTEST_ICMPS_ACCEPT
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-accept.c b/tools/testing/selftests/net/tcp_ao/icmps-accept.c
new file mode 120000
index 000000000000..0a5bb85eb260
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/icmps-accept.c
@@ -0,0 +1 @@
+icmps-discard.c
\ No newline at end of file
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-discard.c b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
index d77c791754de..d69bcba3c929 100644
--- a/tools/testing/selftests/net/tcp_ao/icmps-discard.c
+++ b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
@@ -39,8 +39,14 @@ const int sk_ip_level	= SOL_IP;
 const int sk_recverr	= IP_RECVERR;
 #endif
 
-#define test_icmps_fail test_fail
-#define test_icmps_ok test_ok
+/* Server is expected to fail with hard error if ::accept_icmp is set */
+#ifdef TEST_ICMPS_ACCEPT
+# define test_icmps_fail test_ok
+# define test_icmps_ok test_fail
+#else
+# define test_icmps_fail test_fail
+# define test_icmps_ok test_ok
+#endif
 
 static void serve_interfered(int sk)
 {
@@ -84,7 +90,11 @@ static void serve_interfered(int sk)
 		test_fail("Not found %s counter", tcpao_icmps);
 		return;
 	}
+#ifdef TEST_ICMPS_ACCEPT
+	test_tcp_ao_counters_cmp(NULL, &ao_cnt1, &ao_cnt2, TEST_CNT_GOOD);
+#else
 	test_tcp_ao_counters_cmp(NULL, &ao_cnt1, &ao_cnt2, TEST_CNT_GOOD | TEST_CNT_AO_DROPPED_ICMP);
+#endif
 	if (icmp_ignored_a >= icmp_ignored_b) {
 		test_icmps_fail("%s counter didn't change: %" PRIu64 " >= %" PRIu64,
 				tcpao_icmps, icmp_ignored_a, icmp_ignored_b);
@@ -95,11 +105,15 @@ static void serve_interfered(int sk)
 
 static void *server_fn(void *arg)
 {
-	int val, err, sk, lsk;
+	int val, sk, lsk;
 	bool accept_icmps = false;
 
 	lsk = test_listen_socket(this_ip_addr, test_server_port, 1);
 
+#ifdef TEST_ICMPS_ACCEPT
+	accept_icmps = true;
+#endif
+
 	if (test_set_ao_flags(lsk, false, accept_icmps))
 		test_error("setsockopt(TCP_AO_INFO)");
 
@@ -107,10 +121,7 @@ static void *server_fn(void *arg)
 		test_error("setsockopt(TCP_AO_ADD_KEY)");
 	synchronize_threads();
 
-	err = test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0);
-	if (!err)
-		test_error("timeouted for accept()");
-	else if (err < 0)
+	if (test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0))
 		test_error("test_wait_fd()");
 
 	sk = accept(lsk, NULL, NULL);

-- 
2.43.0


