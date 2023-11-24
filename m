Return-Path: <linux-kselftest+bounces-524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270A7F6FB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440041C210D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160BC16427;
	Fri, 24 Nov 2023 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAzf8IBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D4D53;
	Fri, 24 Nov 2023 01:29:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf897c8de1so11804285ad.0;
        Fri, 24 Nov 2023 01:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818167; x=1701422967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re5W3f6LMVeKhOLuaM5o8zQ+5qabkuQLUABIZdRrMoo=;
        b=cAzf8IBI1y6sE8Qe5uGkwvJzJ73J8GMbBUCLYl1AT8vY00uGYSEUMerw81PeWh9VN8
         lI6/gCw9bDorUvnqtVMgPA4ALeB6XTSOqsYjvaez7KBi/bOMvsLLspwfsvtTfoq+Gi8z
         qcJcUuemZAe0mNjoIYaUzJ0U1Ij85NVEJaUrqmgJGDIBIabc+DiiyH7Qozvq1JtJFDrM
         2bqZ/6UGXP0bBvCZorHg9pPIQs1GtwsQ56I7V/+Z+sZl3Q64Oqfl+ExV0og/wQpTDYu8
         XnTNEpwczwGw+pTxJHZyTZUt8XIyH8cgRlym5eAUPuc1Wbt/hcwDsSgwJ8eSwAdzvMGq
         CHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818167; x=1701422967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Re5W3f6LMVeKhOLuaM5o8zQ+5qabkuQLUABIZdRrMoo=;
        b=s/Y2qdfbs4V20gaVbJsKGnIhRzmsOOPsADgtOvX36IV6qUtQEYE4jeGbHmYcSyEqW3
         NscfEjQR+sOjjt73Klv4Vtj9AlCZRNukr3MZ7aTrv8UEGitbaYNXaXEi2IDt56xtLhhc
         J/LEypB+zq0KmcUSwXf/uX7NZ/N+uFEAb+TDKB2tHuFnR5Iz228FOCQe4vV6GXEH/44W
         tL/9MQeYoHFFuvi8I3WiyGgO+kLH4B7QKse1TDheTBly+5gGb7Hw8fhrJV+0fCLhHQcJ
         uv0R8/6RCX+3bqt+Fy6LuYg8rBEA5LaAQ01qXymDXEOrDEyUl55spnNtzKD4OABSaqQD
         AsdA==
X-Gm-Message-State: AOJu0YzokiwCHlXUMziSGah7I3LUOsPoVwncmoBWuk/TxkNJJ6XlPevU
	b+7f2IQceFstvRYBdticyhecHvFpSFXDx4cz
X-Google-Smtp-Source: AGHT+IGgIhd87yds1Drrm0hSInOyAMtVdHEk11zgw72gZkGxyowotwDAKhgDGwp5vEM4hk9pbIQGkQ==
X-Received: by 2002:a17:902:c713:b0:1cf:677b:6c2b with SMTP id p19-20020a170902c71300b001cf677b6c2bmr1765848plp.29.1700818167542;
        Fri, 24 Nov 2023 01:29:27 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:27 -0800 (PST)
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
Subject: [PATCH net-next 22/38] selftests/net: convert sctp_vrf.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:20 +0800
Message-ID: <20231124092736.3673263-23-liuhangbin@gmail.com>
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

]# ./sctp_vrf.sh
Testing For SCTP VRF:
TEST 01: nobind, connect from client 1, l3mdev_accept=1, Y [PASS]
...
TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N [PASS]
***v6 Tests Done***

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/sctp_vrf.sh | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/sctp_vrf.sh b/tools/testing/selftests/net/sctp_vrf.sh
index c721e952e5f3..c854034b6aa1 100755
--- a/tools/testing/selftests/net/sctp_vrf.sh
+++ b/tools/testing/selftests/net/sctp_vrf.sh
@@ -6,13 +6,11 @@
 #                                                  SERVER_NS
 #       CLIENT_NS2 (veth1) <---> (veth2) -> vrf_s2
 
-CLIENT_NS1="client-ns1"
-CLIENT_NS2="client-ns2"
+source lib.sh
 CLIENT_IP4="10.0.0.1"
 CLIENT_IP6="2000::1"
 CLIENT_PORT=1234
 
-SERVER_NS="server-ns"
 SERVER_IP4="10.0.0.2"
 SERVER_IP6="2000::2"
 SERVER_PORT=1234
@@ -20,9 +18,7 @@ SERVER_PORT=1234
 setup() {
 	modprobe sctp
 	modprobe sctp_diag
-	ip netns add $CLIENT_NS1
-	ip netns add $CLIENT_NS2
-	ip netns add $SERVER_NS
+	setup_ns CLIENT_NS1 CLIENT_NS2 SERVER_NS
 
 	ip net exec $CLIENT_NS1 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
 	ip net exec $CLIENT_NS2 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
@@ -67,9 +63,7 @@ setup() {
 
 cleanup() {
 	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns del "$CLIENT_NS1"
-	ip netns del "$CLIENT_NS2"
-	ip netns del "$SERVER_NS"
+	cleanup_ns $CLIENT_NS1 $CLIENT_NS2 $SERVER_NS
 }
 
 wait_server() {
-- 
2.41.0


