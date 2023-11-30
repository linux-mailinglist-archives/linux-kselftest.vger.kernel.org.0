Return-Path: <linux-kselftest+bounces-875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D67FE80E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386B91C20BD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB611548F;
	Thu, 30 Nov 2023 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjAAZwZu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094E110C3;
	Wed, 29 Nov 2023 20:02:18 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b843b61d8aso290100b6e.0;
        Wed, 29 Nov 2023 20:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316936; x=1701921736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FqYVBFYK+4gvZHlqs5UDN/v5GO8h6DbzEBCfm/gK3Q=;
        b=LjAAZwZuyG2zY5T872g/3QNfTORcBT1YbusODW2iQI4Gn7y8HGgPG3ICtuTgiPACiD
         Q5r6qWAyMpRkhHz1JJKp4eGFtuFlEix9PUMExmHC4Qdi/Ua0U5LzJliB5RWjDKmEANnG
         Ssdb47/o1+6ewQMXn1BIHW2YJbDVYXbKtPxws7oa5jmcWH/Ko3z6NNScx5wWAui/8OIS
         3Vgw9mOqI/BSGvnYAsDmNNm+LvysjUPFB9ap45wgZlArPku5yLrYznyldJpVfsUs3QxI
         m37Gu+ZLgz1Xh4Hqpb9oSGcYfIAMHJhqq6rnR8xBugW/xt4h26lkRo3W6B7icDQPfnJ7
         AmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316936; x=1701921736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FqYVBFYK+4gvZHlqs5UDN/v5GO8h6DbzEBCfm/gK3Q=;
        b=UPLQTr6llFk/5VvmOjggtQ7vitRSZVDcV9voKCeMic4YmCwN3iMTxUkAyuuq0s7O/U
         jzCrjK1mqNMWAcRBgiYnu8tEONhzdpaAgyql0FGwoz3mMi8qIgvUmzHeVFF9WKAOz/8b
         GUSUUrJWHw2Jrh4S4jdQHC+nRKBhQBjbmY2btethwClCEVOQUlUnrFS58VlJEFkdHd2X
         HTVSQjfZyK6mrHx2v6r8J1Ia6UeN3P4bmiHPd+lr2MVYoueb5JvSi67nxcSkzhS0KNGL
         +U5QqZFYty6MBJ+GptJGq43kDC6sqs+8TrVRzLeh90ktFbx6XF6CRyDoCdpJ1Kxq7du1
         NEcg==
X-Gm-Message-State: AOJu0YzgZgjD8m+RiHzBrVPPgbQGXS0hgUtAExNeL/EjpWoXE7K55Vz0
	S5IwygIWDv6+MPbGlqOmTUzJdeFLU892jQ==
X-Google-Smtp-Source: AGHT+IFDtiEMEboFDgTvUtCnrHfOyeoPhEG0gqnLRhUCzvvC8bjVUnu++5Ltr4IwHZAPB4LVXprq7Q==
X-Received: by 2002:a05:6808:4342:b0:3b8:8db8:d8b5 with SMTP id dx2-20020a056808434200b003b88db8d8b5mr4445473oib.58.1701316936736;
        Wed, 29 Nov 2023 20:02:16 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:02:16 -0800 (PST)
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
	Francesco Ruggeri <fruggeri@arista.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 13/14] selftests/net: convert sctp_vrf.sh to run it in unique namespace
Date: Thu, 30 Nov 2023 12:01:04 +0800
Message-ID: <20231130040105.1265779-14-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130040105.1265779-1-liuhangbin@gmail.com>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
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

Acked-by: David Ahern <dsahern@kernel.org>
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


