Return-Path: <linux-kselftest+bounces-40809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F0B44C92
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 06:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED227A80AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 04:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48EC1F5423;
	Fri,  5 Sep 2025 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2eYj7ef"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF2CA5A
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757045091; cv=none; b=bigluECqwyrKisG8PXqNBv38PoSznw8iuAflMXAYN20uhjIWCg9Uy72S3fcFpdvX9qbZm3iEv8qd5kvceiRY9N9rYQqHGV1AxFKF08ohgnpHLO+wFC5IT6EqSpRnNV52mAPY+OI1HobpDjxsEApHDLB+fLDOdt5bWOxFmDfCLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757045091; c=relaxed/simple;
	bh=PwUTz7z+FWi8rvsQTOzsnt1R5+fa1UGAgcorB19lBko=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MtKrj6Dv0AgY0fi+1Az7bzLUYu6M6ZhfcMLeOWTRcvo4Io+ozuckbCCxsnuFbGSqQihuhlXpxKr1Nj4nW3AmlvKhmrMYEIdWiBdxngHY4j3vc82pvFR1z8VAgodJ7M5CjsTRqHqGT3vnLfHPubj+45Yaiv6f6S4TEgQoVzDVgSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2eYj7ef; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso1682790a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Sep 2025 21:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757045089; x=1757649889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xzSe+BvKaMS0Yk/BDbkc11n2XGrcdPm0xDpK5jZXbqM=;
        b=A2eYj7efz9YW7KfwtLxEQK/nWOhDL3Tj47YGPisoF5OslPCTe4+juOZFcV37bY0wkw
         Q35kkjwIlBCSaYiP0Ur/vuVfUrYqSnv1bENEvOA2DOMc/0Wuvcr7ZIjxZYH47UrK5S7W
         IWE2ErRupSRAdHNi67vqOez7/iXggzrYc1VsWzD3hDNkWXvsxnrHSODYErqFMKyen++H
         K6TfCME0rKSLnp/sEc95MJubOEopkOPgJsN2GR2mJQLfxw4DiejaRzLpLNkTaZ0vdrMm
         dX5YD/wzDutnLe9H83znABc/N+iKkYnfk7hgxeSIfNyUBFy7a4FECLRdVBP/KkMouS9a
         8YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757045089; x=1757649889;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzSe+BvKaMS0Yk/BDbkc11n2XGrcdPm0xDpK5jZXbqM=;
        b=DjJ90pYDqyFcRDwDu5bwvdjQaVMuZC3fVsJGprcxO8gdcnJZ+UV80QuT5u5NUGAeR9
         iM0aP6nZX4YtNVVRAjYRbVHMU1KilfpS33SV2QoU8kUe+zujBp5ezxSX1GfC9s3UMpKe
         U/rWbOchw4o9dRpNaEE0mWLr4rvOD5SmULDr5Use33vBvvBmFC+YbuQPkle4v8og0EFM
         bLU3Ic9mQgD6ifLmT7mbjku3eqPz809fzTbQcbXTt5beIxyMLl+eb+ed+Tu9Vu+Arf16
         DPGgwDITViya/njfYOqqMybm4v0xwV1l8JvR5vY8yMks5yQezUDS6IM4YuxB+Va1naPj
         XgWw==
X-Forwarded-Encrypted: i=1; AJvYcCW46mKz3M8tMlar5+Dn/6PdJi2MKj/ESkT7SZd7FYV1AHIoHg4eSRXTZz9OWvEvwvJwpf83EF4jdyFD0FHswts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvnlxMOf0ONvo5HESaJbb7VAxI64KlmIpzhyOWycfdiHEqU/Aa
	lLf52PEgcVKu2XgzFjnFcmcONV0Vgj6OAKraXyRBbbF2us93id41I61exbpJFFmm0D2uvdxaJTG
	5Cpp/EK6qt27mQ9NKd1h91w==
X-Google-Smtp-Source: AGHT+IFLKz6CiGy4wIk+cmybRuyHGuLxSct30ilYhoMtD9odIeFG5s/23vGOkVz9EMN2TikUejP2aNhF+gFem5mZ
X-Received: from pjbsy8.prod.google.com ([2002:a17:90b:2d08:b0:32b:5f22:e5da])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1848:b0:327:531b:b85c with SMTP id 98e67ed59e1d1-328156e38b4mr31773325a91.35.1757045088960;
 Thu, 04 Sep 2025 21:04:48 -0700 (PDT)
Date: Fri,  5 Sep 2025 04:04:41 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250905040441.2679296-1-marcharvey@google.com>
Subject: [PATCH net-next v3] selftests: net: Add tests to verify team driver
 option set and get.
From: Marc Harvey <marcharvey@google.com>
To: jiri@resnulli.us, andrew+netdev@lunn.ch
Cc: edumazet@google.com, willemb@google.com, maheshb@google.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, kuba@kernel.org, 
	liuhangbin@gmail.com, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="UTF-8"

There are currently no kernel tests that verify setting and getting
options of the team driver.

In the future, options may be added that implicitly change other
options, which will make it useful to have tests like these that show
nothing breaks. There will be a follow up patch to this that adds new
"rx_enabled" and "tx_enabled" options, which will implicitly affect the
"enabled" option value and vice versa.

The tests use teamnl to first set options to specific values and then
gets them to compare to the set values.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v3:
  - Applied minor style changes based on v2 feedback.
  - Link to v2: https://lore.kernel.org/netdev/20250904015424.1228665-1-marcharvey@google.com/

Changes in v2:
  - Fixed shellcheck failures.
  - Fixed test failing in vng by adding a config option to enable the
    team driver's active backup mode.
  - Link to v1: https://lore.kernel.org/netdev/20250902235504.4190036-1-marcharvey@google.com/

 .../selftests/drivers/net/team/Makefile       |   6 +-
 .../testing/selftests/drivers/net/team/config |   1 +
 .../selftests/drivers/net/team/options.sh     | 188 ++++++++++++++++++
 3 files changed, 193 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/team/options.sh

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index eaf6938f100e..89d854c7e674 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -1,11 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for net selftests
 
-TEST_PROGS := dev_addr_lists.sh propagation.sh
+TEST_PROGS := dev_addr_lists.sh propagation.sh options.sh
 
 TEST_INCLUDES := \
 	../bonding/lag_lib.sh \
 	../../../net/forwarding/lib.sh \
-	../../../net/lib.sh
+	../../../net/lib.sh \
+	../../../net/in_netns.sh \
+	../../../net/lib/sh/defer.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/team/config b/tools/testing/selftests/drivers/net/team/config
index 636b3525b679..558e1d0cf565 100644
--- a/tools/testing/selftests/drivers/net/team/config
+++ b/tools/testing/selftests/drivers/net/team/config
@@ -3,4 +3,5 @@ CONFIG_IPV6=y
 CONFIG_MACVLAN=y
 CONFIG_NETDEVSIM=m
 CONFIG_NET_TEAM=y
+CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
 CONFIG_NET_TEAM_MODE_LOADBALANCE=y
diff --git a/tools/testing/selftests/drivers/net/team/options.sh b/tools/testing/selftests/drivers/net/team/options.sh
new file mode 100755
index 000000000000..44888f32b513
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/options.sh
@@ -0,0 +1,188 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# These tests verify basic set and get functionality of the team
+# driver options over netlink.
+
+# Run in private netns.
+test_dir="$(dirname "$0")"
+if [[ $# -eq 0 ]]; then
+        "${test_dir}"/../../../net/in_netns.sh "$0" __subprocess
+        exit $?
+fi
+
+ALL_TESTS="
+        team_test_options
+"
+
+source "${test_dir}/../../../net/lib.sh"
+
+TEAM_PORT="team0"
+MEMBER_PORT="dummy0"
+
+setup()
+{
+        ip link add name "${MEMBER_PORT}" type dummy
+        ip link add name "${TEAM_PORT}" type team
+}
+
+get_and_check_value()
+{
+        local option_name="$1"
+        local expected_value="$2"
+        local port_flag="$3"
+
+        local value_from_get
+
+        if ! value_from_get=$(teamnl "${TEAM_PORT}" getoption "${option_name}" \
+                        "${port_flag}"); then
+                echo "Could not get option '${option_name}'" >&2
+                return 1
+        fi
+
+        if [[ "${value_from_get}" != "${expected_value}" ]]; then
+                echo "Incorrect value for option '${option_name}'" >&2
+                echo "get (${value_from_get}) != set (${expected_value})" >&2
+                return 1
+        fi
+}
+
+set_and_check_get()
+{
+        local option_name="$1"
+        local option_value="$2"
+        local port_flag="$3"
+
+        local value_from_get
+
+        if ! teamnl "${TEAM_PORT}" setoption "${option_name}" \
+                        "${option_value}" "${port_flag}"; then
+                echo "'setoption ${option_name} ${option_value}' failed" >&2
+                return 1
+        fi
+
+        get_and_check_value "${option_name}" "${option_value}" "${port_flag}"
+        return $?
+}
+
+# Get a "port flag" to pass to the `teamnl` command.
+# E.g. $1="dummy0" -> "port=dummy0",
+#      $1=""       -> ""
+get_port_flag()
+{
+        local port_name="$1"
+
+        if [[ -n "${port_name}" ]]; then
+                echo "--port=${port_name}"
+        fi
+}
+
+attach_port_if_specified()
+{
+        local port_name="$1"
+
+        if [[ -n "${port_name}" ]]; then
+                ip link set dev "${port_name}" master "${TEAM_PORT}"
+                return $?
+        fi
+}
+
+detach_port_if_specified()
+{
+        local port_name="$1"
+
+        if [[ -n "${port_name}" ]]; then
+                ip link set dev "${port_name}" nomaster
+                return $?
+        fi
+}
+
+# Test that an option's get value matches its set value.
+# Globals:
+#   RET - Used by testing infra like `check_err`.
+#   EXIT_STATUS - Used by `log_test` for whole script exit value.
+# Arguments:
+#   option_name - The name of the option.
+#   value_1 - The first value to try setting.
+#   value_2 - The second value to try setting.
+#   port_name - The (optional) name of the attached port.
+team_test_option()
+{
+        local option_name="$1"
+        local value_1="$2"
+        local value_2="$3"
+        local possible_values="$2 $3 $2"
+        local port_name="$4"
+        local port_flag
+
+        RET=0
+
+        echo "Setting '${option_name}' to '${value_1}' and '${value_2}'"
+
+        attach_port_if_specified "${port_name}"
+        check_err $? "Couldn't attach ${port_name} to master"
+        port_flag=$(get_port_flag "${port_name}")
+
+        # Set and get both possible values.
+        for value in ${possible_values}; do
+                set_and_check_get "${option_name}" "${value}" "${port_flag}"
+                check_err $? "Failed to set '${option_name}' to '${value}'"
+        done
+
+        detach_port_if_specified "${port_name}"
+        check_err $? "Couldn't detach ${port_name} from its master"
+
+        log_test "Set + Get '${option_name}' test"
+}
+
+# Test that getting a non-existant option fails.
+# Globals:
+#   RET - Used by testing infra like `check_err`.
+#   EXIT_STATUS - Used by `log_test` for whole script exit value.
+# Arguments:
+#   option_name - The name of the option.
+#   port_name - The (optional) name of the attached port.
+team_test_get_option_fails()
+{
+        local option_name="$1"
+        local port_name="$2"
+        local port_flag
+
+        RET=0
+
+        attach_port_if_specified "${port_name}"
+        check_err $? "Couldn't attach ${port_name} to master"
+        port_flag=$(get_port_flag "${port_name}")
+
+        # Just confirm that getting the value fails.
+        teamnl "${TEAM_PORT}" getoption "${option_name}" "${port_flag}"
+        check_fail $? "Shouldn't be able to get option '${option_name}'"
+
+        detach_port_if_specified "${port_name}"
+
+        log_test "Get '${option_name}' fails"
+}
+
+team_test_options()
+{
+        # Wrong option name behavior.
+        team_test_get_option_fails fake_option1
+        team_test_get_option_fails fake_option2 "${MEMBER_PORT}"
+
+        # Correct set and get behavior.
+        team_test_option mode activebackup loadbalance
+        team_test_option notify_peers_count 0 5
+        team_test_option notify_peers_interval 0 5
+        team_test_option mcast_rejoin_count 0 5
+        team_test_option mcast_rejoin_interval 0 5
+        team_test_option enabled true false "${MEMBER_PORT}"
+        team_test_option user_linkup true false "${MEMBER_PORT}"
+        team_test_option user_linkup_enabled true false "${MEMBER_PORT}"
+        team_test_option priority 10 20 "${MEMBER_PORT}"
+        team_test_option queue_id 0 1 "${MEMBER_PORT}"
+}
+
+require_command teamnl
+setup
+tests_run
+exit "${EXIT_STATUS}"
-- 
2.51.0.384.g4c02a37b29-goog


