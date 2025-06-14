Return-Path: <linux-kselftest+bounces-34976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0475AD9A41
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C081BC02C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 05:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5211DED69;
	Sat, 14 Jun 2025 05:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uV4lmPt9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3291DE3BE
	for <linux-kselftest@vger.kernel.org>; Sat, 14 Jun 2025 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749879329; cv=none; b=Rile2cqADqJyWvTYOlZW88EWlrqQLBvMsLxg13kSLhcCJCqsHWUmsxwQDFXd2zjtcwKJUh590Xf0C6xQx/NWROOwyNRsWAxItIdrPDMNTBpI4GioIUmm3MH/MZX91H1N8uSH2ocoJo24yC2vjDV3R+I8lULIVcxbr+B+QMfz26c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749879329; c=relaxed/simple;
	bh=Idyjm9PAvbAZs2Y85gPvsVywGKyYTgsgfoHFBDmwdd8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jWF1E/oU6HtxDy18inky+P4AIMxUbiYojES4m8g5V90Qwisp4AmLqb9uMwRAyrDOrYYMRbLyGpCYs1ETxtsUvoY4PAB58UDfxMNhmW6gD2bn5kvJFKvoUPA3PhOYDLa4Yyv/UsnVx+9gMYrxM20uKxcFsNDTICDVmpBm4HRsLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uV4lmPt9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso1781156a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 22:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749879327; x=1750484127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iABuUUOZvcSitzU5/7yzeqemM2WhK22/QQ6XRhuLRhM=;
        b=uV4lmPt9MHuZMvi27TkimycH5KePGnVjUyI4NeK/V0obWxZ38OPON0kpCMQa3QdNdN
         U7K1mknyTY+gvpLI11p/GRkg+E6/hOoa2OnFATTRoTsbjba1h0pLuwKJhyOwoVIy1A6T
         1QEupXh8zq9Y3YYDhCgVEsYhIPUbm+0+JjK8tssHLlfUuTNXS7t1Dwkz0BwaRjcsxvP0
         Kig/BPVHkqR2nhbxQTKZpajVnznXqiXoogSREOXg5pOrQr9EHjz/1H7sp1Wjn3DBUlL7
         99BgtVDo5cACSDfnUCqI569vftrABmVDWMSZkTxthr3QTHizmUoBMHvKeG7gCgjgbOa/
         qoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749879327; x=1750484127;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iABuUUOZvcSitzU5/7yzeqemM2WhK22/QQ6XRhuLRhM=;
        b=FOh1JdH7EAkGmk5WfiXwrNlzu6lHLsJJSlt45jy/COe8BDqZX4wggvVkmK4JNBRbTF
         999gTBSVD6EZFD8fDy58cfO8HeiWxWDLAFS+KzSkcmHxDnbWNNHnfts6gRxtWeKddJW9
         ajmhDNn0Te/2/qWlzPPX6VnC2KoFgR8CDwP3Lk/w+7wo4bQrseoGI2aN8pU6YmyfwzLz
         U0zobhvJkOEaHLjNyDtDttzQooRPcryQhmZQvFvbthZOMmuXcgOEah4ZLeKO79t6E0IB
         Ar6ytLcygEwAXK0r8SY3f3r/WjyxL68ON9U06I+lC44NqVE6MXXAC5btTJEN6Wh8CWRx
         xQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCVRoc1k0rYNtjL6xOAO7w3XXRVo5dx8RM1ILo5w4nIWaqi712RQMdxY7WjDzaLR9BQbQABNsTDV8DgJYkyGkPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynX3gqhVkrTqgdaFBb0kxqwmfXrGElBJ84F1SXo/jnjTRvegkE
	/OHQ04Odt1mr9zunWcfJ+wvgAfO0gWHNZfO5yqI3EVFmdaU1a/vgvBAhMa7sK8cG4ID43sZfA4w
	2Pi1i4/XENB7pg3G2fJZdyqXUJw==
X-Google-Smtp-Source: AGHT+IHZdjEKlVYu6FtY/GN86g3BZXJasIvErPJCytIMKyDnWUQaijewP82m/tZHk7FzU+2ABgm22Sj7Pw/O1Kz9qg==
X-Received: from pfbfu24.prod.google.com ([2002:a05:6a00:6118:b0:746:1fcb:a9cc])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e545:b0:201:8a13:f392 with SMTP id adf61e73a8af0-21fbd55a60emr2559978637.20.1749879326787;
 Fri, 13 Jun 2025 22:35:26 -0700 (PDT)
Date: Sat, 14 Jun 2025 14:35:22 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614053522.623820-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v4] selftest: Add selftest for multicast address notifications
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
removing a dummy interface and then confirming that the system
correctly receives join and removal notifications for the 224.0.0.1
and ff02::1 multicast addresses.

The test relies on the iproute2 version to be 6.13+.

Tested by the following command:
$ vng -v --user root --cpus 16 -- \
make -C tools/testing/selftests TARGETS=3Dnet
TEST_PROGS=3Drtnetlink_notification.sh \
TEST_GEN_PROGS=3D"" run_tests

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v3:
- Refactor the test to use utilities provided by lib.h.
- Fix shellcheck warnings.

Changelog since v2:
- Move the test case to a separate file.

Changelog since v1:
- Skip the test if the iproute2 is too old.

 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/rtnetlink_notification.sh   | 70 +++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100755 tools/testing/selftests/net/rtnetlink_notification.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests=
/net/Makefile
index ab996bd22a5f..3abb74d563a7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -41,6 +41,7 @@ TEST_PROGS +=3D netns-name.sh
 TEST_PROGS +=3D link_netns.py
 TEST_PROGS +=3D nl_netdev.py
 TEST_PROGS +=3D rtnetlink.py
+TEST_PROGS +=3D rtnetlink_notification.sh
 TEST_PROGS +=3D srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS +=3D srv6_end_dt4_l3vpn_test.sh
 TEST_PROGS +=3D srv6_end_dt6_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/rtnetlink_notification.sh b/tools/=
testing/selftests/net/rtnetlink_notification.sh
new file mode 100755
index 000000000000..39c1b815bbe4
--- /dev/null
+++ b/tools/testing/selftests/net/rtnetlink_notification.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This test is for checking rtnetlink notification callpaths, and get as m=
uch
+# coverage as possible.
+#
+# set -e
+
+ALL_TESTS=3D"
+	kci_test_mcast_addr_notification
+"
+
+source lib.sh
+
+kci_test_mcast_addr_notification()
+{
+	RET=3D0
+	local tmpfile
+	local monitor_pid
+	local match_result
+	local test_dev=3D"test-dummy1"
+
+	tmpfile=3D$(mktemp)
+	defer rm "$tmpfile"
+
+	ip monitor maddr > $tmpfile &
+	monitor_pid=3D$!
+	defer kill_process "$monitor_pid"
+
+	sleep 1
+
+	if [ ! -e "/proc/$monitor_pid" ]; then
+		RET=3D$ksft_skip
+		log_test "mcast addr notification: iproute2 too old"
+		return $RET
+	fi
+
+	ip link add name "$test_dev" type dummy
+	check_err $? "failed to add dummy interface"
+	ip link set "$test_dev" up
+	check_err $? "failed to set dummy interface up"
+	ip link del dev "$test_dev"
+	check_err $? "Failed to delete dummy interface"
+	sleep 1
+
+	# There should be 4 line matches as follows.
+	# 13: test-dummy1=C2=A0 =C2=A0 inet6 mcast ff02::1 scope global=C2=A0
+	# 13: test-dummy1=C2=A0 =C2=A0 inet mcast 224.0.0.1 scope global=C2=A0
+	# Deleted 13: test-dummy1=C2=A0 =C2=A0 inet mcast 224.0.0.1 scope global=
=C2=A0
+	# Deleted 13: test-dummy1=C2=A0 =C2=A0 inet6 mcast ff02::1 scope global=
=C2=A0
+	match_result=3D$(grep -cE "$test_dev.*(224.0.0.1|ff02::1)" "$tmpfile")
+	if [ "$match_result" -ne 4 ]; then
+		RET=3D$ksft_fail
+	fi
+	log_test "mcast addr notification: Expected 4 matches, got $match_result"
+	return $RET
+}
+
+#check for needed privileges
+if [ "$(id -u)" -ne 0 ];then
+	RET=3D$ksft_skip
+	log_test "need root privileges"
+	exit $RET
+fi
+
+require_command ip
+
+tests_run
+
+exit $EXIT_STATUS
--=20
2.50.0.rc1.591.g9c95f17f64-goog


