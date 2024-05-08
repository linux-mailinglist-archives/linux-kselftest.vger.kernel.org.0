Return-Path: <linux-kselftest+bounces-9676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5FF8BF52D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 06:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3931F22063
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 04:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739A14AB0;
	Wed,  8 May 2024 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp/0TDr2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430C1A2C23;
	Wed,  8 May 2024 04:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715141271; cv=none; b=YmzNySF00CaUgeQQnShLj22dXcp5FyOKlh3GfRKcR2CGHBMvK5pxoE768wLJeeLUvLCmnZtLP5TSQYXkzKQViyZJv3AMhhbkGqRR4FqxQC6yKKlFxciKGXG+DjN5Ql5inhuglg15LARPNIC0+RnVh8RvbkTuVlxHpsNo9EP0aAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715141271; c=relaxed/simple;
	bh=JTS8Rkc1475nzT+xN3847hJpMJoSX3zHqbmX94RHptA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YB66YWFTuwo1ndF3mCVrDGZN4u4+vbnqPQn3bg9rd/IMz3+wkmwuwzsM0FlU6xKV1TXyPxh4f+QvZhbIMclJmLIEP8pti9toNOmiYKy1Uz/nBHZt7qy7ST6e/bqIfrVmpdjdMzxOW4JUretAL/vE2l/pWxpCjY2wYWVR8ktJVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp/0TDr2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2419907a12.2;
        Tue, 07 May 2024 21:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715141269; x=1715746069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7Mtv53fEGQOMIpXP81/gYFyhRVDA3yGOU9HnXOd/ew=;
        b=Bp/0TDr2PwmZ0YLVFQZFrK651cC2z1Of3WVRxzCrhPscp9ATvZ6Pj3BWP+HrxSVC3L
         VsJYuM3wkorwMlqvPBeBUwocDMYjMqirLzHeqdo+O9tfWE9TVS/Cjp2uIQQI+zkJfBQh
         kH5ON1xQ8p/rRYZ+rjb2KpXsOPzeMRodlC0yQhSZQ4mUAZtAXsFKzj1g0+XK2/lc15LO
         PV3iAyEj3O+PT9g7PJTXsWHdP/bTl9/aFLiwoPCpm2+xzvbSsX9CkM0NUYsnlPn6QQdY
         5WM4lq1b74SkjnWww59irm9RpDa42cJ7Q7M/nY23cqmMII4lW0Gnn16oXM0QK0tFDwXR
         5ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715141269; x=1715746069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7Mtv53fEGQOMIpXP81/gYFyhRVDA3yGOU9HnXOd/ew=;
        b=ha5iGLqpUu/Ss3mr8vvR33nZeHPzn6VTZA2JVShWbp7RfAi5CfT7QW6gZ/W/UNuMIi
         wQfLLogH++K27UdqfqCoEFkNPOyBgZdoETsi2OKdSCLFAZ9wMOAP+S473X+w0+QiAi81
         oVkBLiL/XHP7s4glnn+4ho6A45TN2L+oUOiY3/Dw8j1AOhiSvFV7vxJW9KwP5AD2UWkm
         EhoYigyFUatGdpRQH+hHVyatWpCVC/jRPIRMIP+NxbEbjxtXDWpt8ZcRNw83jlJDJE0h
         5+LYdVEP0zIUTEYOUD6oaUT8XHlifN+Sa4eebSi2sRctfyg8BKVROLHKv22iApiPviGa
         Cc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVX+QbbzsqEGWZzOj4Rq4F0vFwZUjf/CHGyh8JiSqV7/Um3XVWCA15ZLvNc52skT6uAbiOYXCyG+WnKHo+G+aY7FMJbdyg97pLAALG4HrJEfiLEBu1Iat5dQivsDBSDxdip/vlajUW
X-Gm-Message-State: AOJu0Ywqo8al2b8ZGPcblAUqHFQxf8ZFARmkLg7nSUgqVksztl1s3a+d
	NmVtdKdaCTqRInJ+b/EOtSI0A9D+ONehFnoifRNg6xqTDEsj1txt
X-Google-Smtp-Source: AGHT+IGzonYRDF7PihfRXZBEPfmnKgPc5mjnpIV49MYSNThTe8CbqHkGKlej6leDgXkNWOLFwt1Axg==
X-Received: by 2002:a17:90a:ac14:b0:2b5:6f9b:a7b with SMTP id 98e67ed59e1d1-2b6165a503dmr1429599a91.15.1715141269242;
        Tue, 07 May 2024 21:07:49 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 200-20020a6301d1000000b006109431806dsm10446586pgb.92.2024.05.07.21.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 21:07:48 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH net] selftests: net: avoid waiting for server in amt.sh forever when it fails.
Date: Wed,  8 May 2024 04:06:43 +0000
Message-Id: <20240508040643.229383-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the forwarding testcase, it opens a server and a client with the nc.
The server receives the correct message from NC, it prints OK.
The server prints FAIL if it receives the wrong message from the client.

But If the server can't receive any message, it will not close so
the amt.sh waits forever.
There are several reasons.
1. crash of smcrouted.
2. Send a message from the client to the server before the server is up.

To avoid this problem, the server waits only for 10 seconds.
The client sends messages for 10 seconds.
If the server is successfully closed, it kills the client.

Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 tools/testing/selftests/net/amt.sh | 63 +++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 75528788cb95..16641d3dccce 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -77,6 +77,7 @@ readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
 readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
 readonly RELAY=$(mktemp -u relay-XXXXXXXX)
 readonly SOURCE=$(mktemp -u source-XXXXXXXX)
+readonly RESULT=$(mktemp -p /tmp amt-XXXXXXXX)
 ERR=4
 err=0
 
@@ -85,6 +86,10 @@ exit_cleanup()
 	for ns in "$@"; do
 		ip netns delete "${ns}" 2>/dev/null || true
 	done
+	rm $RESULT
+	smcpid=$(< $SMCROUTEDIR/amt.pid)
+	kill $smcpid
+	rm -rf $SMCROUTEDIR
 
 	exit $ERR
 }
@@ -167,7 +172,9 @@ setup_iptables()
 
 setup_mcast_routing()
 {
-	ip netns exec "${RELAY}" smcrouted
+	SMCROUTEDIR="$(mktemp -d)"
+
+	ip netns exec "${RELAY}" smcrouted -P $SMCROUTEDIR/amt.pid
 	ip netns exec "${RELAY}" smcroutectl a relay_src \
 		172.17.0.2 239.0.0.1 amtr
 	ip netns exec "${RELAY}" smcroutectl a relay_src \
@@ -210,40 +217,52 @@ check_features()
 
 test_ipv4_forward()
 {
-	RESULT4=$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)
+	echo "" > $RESULT
+	bash -c "$(ip netns exec "${LISTENER}" \
+		timeout 10s nc -w 1 -l -u 239.0.0.1 4000 > $RESULT)"
+	RESULT4=$(< $RESULT)
 	if [ "$RESULT4" == "172.17.0.2" ]; then
 		printf "TEST: %-60s  [ OK ]\n" "IPv4 amt multicast forwarding"
-		exit 0
 	else
 		printf "TEST: %-60s  [FAIL]\n" "IPv4 amt multicast forwarding"
-		exit 1
 	fi
+
 }
 
 test_ipv6_forward()
 {
-	RESULT6=$(ip netns exec "${LISTENER}" nc -w 1 -l -u ff0e::5:6 6000)
+	echo "" > $RESULT
+	bash -c "$(ip netns exec "${LISTENER}" \
+		timeout 10s nc -w 1 -l -u ff0e::5:6 6000 > $RESULT)"
+	RESULT6=$(< $RESULT)
 	if [ "$RESULT6" == "2001:db8:3::2" ]; then
 		printf "TEST: %-60s  [ OK ]\n" "IPv6 amt multicast forwarding"
-		exit 0
 	else
 		printf "TEST: %-60s  [FAIL]\n" "IPv6 amt multicast forwarding"
-		exit 1
 	fi
+
 }
 
 send_mcast4()
 {
 	sleep 2
-	ip netns exec "${SOURCE}" bash -c \
-		'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
+	for n in {0..10}; do
+		ip netns exec "${SOURCE}" bash -c \
+			'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000'
+		sleep 1
+	done
+
 }
 
 send_mcast6()
 {
 	sleep 2
-	ip netns exec "${SOURCE}" bash -c \
-		'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
+	for n in {0..10}; do
+		ip netns exec "${SOURCE}" bash -c \
+			'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000'
+		sleep 1
+	done
+
 }
 
 check_features
@@ -259,19 +278,17 @@ setup_iptables
 setup_mcast_routing
 test_remote_ip
 test_ipv4_forward &
-pid=$!
-send_mcast4
-wait $pid || err=$?
-if [ $err -eq 1 ]; then
-	ERR=1
-fi
+spid=$!
+send_mcast4 &
+cpid=$!
+wait $spid
+kill $cpid
 test_ipv6_forward &
-pid=$!
-send_mcast6
-wait $pid || err=$?
-if [ $err -eq 1 ]; then
-	ERR=1
-fi
+spid=$!
+send_mcast6 &
+cpid=$!
+wait $spid
+kill $cpid
 send_mcast_torture4
 printf "TEST: %-60s  [ OK ]\n" "IPv4 amt traffic forwarding torture"
 send_mcast_torture6
-- 
2.34.1


