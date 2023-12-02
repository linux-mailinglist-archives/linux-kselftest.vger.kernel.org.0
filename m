Return-Path: <linux-kselftest+bounces-1016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609F48019DF
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CB61C20B9A
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B446135;
	Sat,  2 Dec 2023 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwc6G4l8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF010E5;
	Fri,  1 Dec 2023 18:02:21 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cfc3a48ab2so30373517b3.0;
        Fri, 01 Dec 2023 18:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482540; x=1702087340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFmFOexR5ZAZ2el5ibqzE+s9jfQBaQ7q5atTVOqAmCM=;
        b=Rwc6G4l83SQM60E7IYoLkWVCm74McW5hz1z4MVMk6kPap04P/q5rFLTudo2zgcsBSZ
         Hd+NHbM/y6FZxSUgR9gCB5vhyjJKouHSSf8eqMHZ/ejdv0q6j3kGLc8DV0ni7LxkO02m
         EOE21WIhcSbDs/s96VBPU3j9GcqO9awUB6caJyUn49WlcxyK5CmtlesMTYtSzArIOTzo
         lQU8eILyKJz+nBcjSCLwvQPFGY4Jo376QRb/LXfFtZiB7YKEmDzFCPRXHU4N4AJRdW+5
         zzXT1qPWdm6rCdlaauJKwW/Kg8RgVCnCWXDPQYkwU6VDhpjrAVjLUxfL8sCl+4Jjl/rr
         lvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482540; x=1702087340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFmFOexR5ZAZ2el5ibqzE+s9jfQBaQ7q5atTVOqAmCM=;
        b=s/AxMtmfQ7w1/GACalJuY9XMh+t/mWe3LH068z/5LdYWZtG2k9/XeYtfgP9OYJLGVJ
         cSarFUgY69jgPbOAoxqP0q25TPLVfemWsg5KpH4QbOUzDrFX6tntZayvnwYjatxg0H/g
         GOiLSPx+ZuQ4UdZhGqs5i82Uianunhkgj6esHk3z8pV2ihR3MeeLZfpLS23NF6XqAsBF
         6e4mAyqU7LmjZR7Ad38G/W4+ReFLPf14OS1vUYSbCcfyZkw8m0OffEHQdJ1n79ugxcp8
         3YoeUvxSST3oDOp2vu2uAFtam+CsVBmXLzi91DH1ny/l6GLUft/OnqFxvmeV3y5jfr0O
         kQOw==
X-Gm-Message-State: AOJu0YyYEi3I66WKii63iVnfSVY0az/C5VErp+E87Hnbz/Vmu3D6IegN
	JE8d3Uzs7sZlxfVDmf95L9adVIoc+97C8+af
X-Google-Smtp-Source: AGHT+IGz3EoagRZK8aZvYll86CRK4FQn/q84wRMFQ1CrLBKn6R4oVs9ARnEQan5y4iYtnu3Bd/TxFA==
X-Received: by 2002:a81:d202:0:b0:5d7:1941:ac2 with SMTP id x2-20020a81d202000000b005d719410ac2mr507081ywi.93.1701482540178;
        Fri, 01 Dec 2023 18:02:20 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:02:19 -0800 (PST)
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
Subject: [PATCHv3 net-next 13/14] selftests/net: convert sctp_vrf.sh to run it in unique namespace
Date: Sat,  2 Dec 2023 10:01:09 +0800
Message-ID: <20231202020110.362433-14-liuhangbin@gmail.com>
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

]# ./sctp_vrf.sh
Testing For SCTP VRF:
TEST 01: nobind, connect from client 1, l3mdev_accept=1, Y [PASS]
...
TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N [PASS]
***v6 Tests Done***

Acked-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
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
2.43.0


