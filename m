Return-Path: <linux-kselftest+bounces-35270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A2ADE944
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E59617E46F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD044283FE9;
	Wed, 18 Jun 2025 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WK2kvWoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1517D285061
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243238; cv=none; b=P5s81lYySyqn+fBUmYrVzFwxXu7a+/DhNUXjrXaSQWGgBzIIvR8p1k59FOCCnQK/ur5ml8kqE70yJaXy1U/Bhm5n8SlSLOMfIy/nKYnfUbbMi4EwwXZ8MaifjtfLinScMX3XeOS5hoyAt7drTOkZmMVGI4S9lGXbAvFfwXyTJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243238; c=relaxed/simple;
	bh=IFrk+Wt+3IOL5c/d/oA9s1HjP/eu3QahRP+hmKMQO48=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PrxuugyivPanECFwDrADhZeI83Ux9Q/eb7gCFfHnAjw2e7l+bvw0diVgl1M6KAv0ca8mTXbObzbO5TJQmKbuwlbS4iOqDymN8DOuymzMI856u7E3vsGZTNH8PA8NI63SkgRYGqzAMTKKoSrqAVW7DY4sRdWkntJkbMFbag+Tk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WK2kvWoY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7489ac848f3so6789928b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750243236; x=1750848036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5ZRzpxuw236Qa1RlkQYMr8Acq5Mq2S5Ae5QLL/5mzs=;
        b=WK2kvWoYfJaQgF++P5iaPDbW/BY0ytQCs+vhdngpQSGRgg2xfiHcRSzqRA/4m0mPD0
         Km+mTIrtuN4GVPFfqgxj8S9iEJoSscsxfUEsDX9MG1w4Phf2jNfcH9WcHK6D1BoIB60y
         J+zg4Z6e+uYDhRuhVW9gibl14kJ74l2UYqzL0yYIBVNaXw09WjN1asXicGKtNllqEVNp
         ryD+i4aSTKtMHvakEjAWKpdkYRDWxfmGfIeMYtoCKFZ55IUr2zVvwUcWW6qQRrmVWgq1
         b4QtiMcZZyKK1PSuvQDeN5pZJM9n3yKQFlKGbJn+4tiUOb5v2JA/Biauq7kYF3QX2d4H
         T2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750243236; x=1750848036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5ZRzpxuw236Qa1RlkQYMr8Acq5Mq2S5Ae5QLL/5mzs=;
        b=bOfabHE3jor7Td3CSXyHmNnh8gNlImr419q13khgv5+bs0PqbbgcLIvDmjd9VqPsnW
         SIQBjJBC0B+RcnKJS36G0ohfymY86YqUH0OMtxYWMaBV678lvUYIzqoGpL22Z7FN9f5l
         IDuT76wyuiVJTzEEICmQ1A2UAO7xWLIzsIxuc207RbtgmZy83P4VW+Qi95uUY2AeTTyZ
         nrTCfPF98AasPZ8fCsxia/CEde8kGzc6SwH8oYVtopDaTWy/jSiEd3vpK1WxbvfSWBoF
         KqLpp+n+3IgZ/C91DMtFEtIJkmHN1tdUIIUr98d9v0DROSDlNVRJJB0Jhkeh999ya/Kf
         nfXw==
X-Forwarded-Encrypted: i=1; AJvYcCXD2nqMK30M6HqyxSkv6lRhivmN4WoQi+xAVEE1H8McU7ZGDJGM5SrzA/l2QczXfDu/xUGsIGd3vqzDLdwPe8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnEIoNiYOU6zQ0/dxtgVd3sRcc8MOKwZyrQUZuo73ZzJ0obQW
	BaMZkBw7dcBfetoGR/X6uVPg8c67W45XgR2gkAtEi8KASXLvcRico0W69QjHp1Qe5g/+zribWUz
	n8kVKwmVDu7dvfsEHaEs2HC8rdA==
X-Google-Smtp-Source: AGHT+IFm6jRnVgcFeMCAYW1rUtQm4z9LOhLiOCwsAqf3bSFUHFjg6zoWoywY8kEyAIzz78G43yBDi8e2+p1zScjWFw==
X-Received: from pfbgd14.prod.google.com ([2002:a05:6a00:830e:b0:740:5196:b63a])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b4c:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-7489cfde7a6mr23990572b3a.18.1750243236415;
 Wed, 18 Jun 2025 03:40:36 -0700 (PDT)
Date: Wed, 18 Jun 2025 19:40:25 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250618104025.3463656-1-yuyanghuang@google.com>
Subject: [PATCH net-next] selftest: add selftest for anycast notifications
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This commit adds a new kernel selftest to verify RTNLGRP_IPV6_ACADDR
notifications. The test works by adding/removing a dummy interface,
enabling packet forwarding, and then confirming that user space can
correctly receive anycast notifications.

The test relies on the iproute2 version to be 6.13+.

Tested by the following command:
$ vng -v --user root --cpus 16 -- \
make -C tools/testing/selftests TARGETS=net
TEST_PROGS=rtnetlink_notification.sh \
TEST_GEN_PROGS="" run_tests

Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 .../selftests/net/rtnetlink_notification.sh   | 52 +++++++++++++++++--
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink_notification.sh b/tools/testing/selftests/net/rtnetlink_notification.sh
index 39c1b815bbe4..2d938861197c 100755
--- a/tools/testing/selftests/net/rtnetlink_notification.sh
+++ b/tools/testing/selftests/net/rtnetlink_notification.sh
@@ -8,9 +8,11 @@
 
 ALL_TESTS="
 	kci_test_mcast_addr_notification
+	kci_test_anycast_addr_notification
 "
 
 source lib.sh
+test_dev="test-dummy1"
 
 kci_test_mcast_addr_notification()
 {
@@ -18,12 +20,11 @@ kci_test_mcast_addr_notification()
 	local tmpfile
 	local monitor_pid
 	local match_result
-	local test_dev="test-dummy1"
 
 	tmpfile=$(mktemp)
 	defer rm "$tmpfile"
 
-	ip monitor maddr > $tmpfile &
+	ip monitor maddr > "$tmpfile" &
 	monitor_pid=$!
 	defer kill_process "$monitor_pid"
 
@@ -32,7 +33,7 @@ kci_test_mcast_addr_notification()
 	if [ ! -e "/proc/$monitor_pid" ]; then
 		RET=$ksft_skip
 		log_test "mcast addr notification: iproute2 too old"
-		return $RET
+		return "$RET"
 	fi
 
 	ip link add name "$test_dev" type dummy
@@ -53,7 +54,48 @@ kci_test_mcast_addr_notification()
 		RET=$ksft_fail
 	fi
 	log_test "mcast addr notification: Expected 4 matches, got $match_result"
-	return $RET
+	return "$RET"
+}
+
+kci_test_anycast_addr_notification()
+{
+	RET=0
+	local tmpfile
+	local monitor_pid
+	local match_result
+
+	tmpfile=$(mktemp)
+	defer rm "$tmpfile"
+
+	ip monitor acaddress > "$tmpfile" &
+	monitor_pid=$!
+	defer kill_process "$monitor_pid"
+	sleep 1
+
+	if [ ! -e "/proc/$monitor_pid" ]; then
+		RET=$ksft_skip
+		log_test "anycast addr notification: iproute2 too old"
+		return "$RET"
+	fi
+
+	ip link add name "$test_dev" type dummy
+	check_err $? "failed to add dummy interface"
+	ip link set "$test_dev" up
+	check_err $? "failed to set dummy interface up"
+	sysctl -qw net.ipv6.conf."$test_dev".forwarding=1
+	ip link del dev "$test_dev"
+	check_err $? "Failed to delete dummy interface"
+	sleep 1
+
+	# There should be 2 line matches as follows.
+	# 9: dummy2    inet6 any fe80:: scope global
+	# Deleted 9: dummy2    inet6 any fe80:: scope global
+	match_result=$(grep -cE "$test_dev.*(fe80::)" "$tmpfile")
+	if [ "$match_result" -ne 2 ]; then
+		RET=$ksft_fail
+	fi
+	log_test "anycast addr notification: Expected 2 matches, got $match_result"
+	return "$RET"
 }
 
 #check for needed privileges
@@ -67,4 +109,4 @@ require_command ip
 
 tests_run
 
-exit $EXIT_STATUS
+exit "$EXIT_STATUS"
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


