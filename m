Return-Path: <linux-kselftest+bounces-40667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C0B4110A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79968541362
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4BA2EAB82;
	Tue,  2 Sep 2025 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8+vdApF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00724E4BD
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857337; cv=none; b=PeVol4u3CmYw/CTYG/4ZWKk5o4rMbxakXSmTAR6cyLRDMFojhSy+AaxEb01UWcJYZiQRlxsPUh3SEhsAB2Mkf8jFkvGuYOI85Zl1v5hclB2Qu62x2Y5qm2ET3aFXymeYT2nKAC5Jb1ZZ3AHytOobMbpa7q5RZKdi6fwKFZgj+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857337; c=relaxed/simple;
	bh=BgL7U4H/QEOKGQm2G8hM9ycFx9km2fSP4Aw1+zKZBl4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZgBzEng7bYkrgIyrt8KrteSAoZEZhJ9CMuOSBrBxdw6kpcMzxTSfTPsuFYgVpttBWcyx7eJwo42YUQMextxsTUwTFdvyZ6kpPwfrBD5ZHYmOO7F9dp+4aGeJToAi7BjS7YuIGPbt0Pk4ZTZgOa72WD5BZ1ZiztCOtBRsxC8sJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8+vdApF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445805d386so64293625ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 16:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756857334; x=1757462134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CIGRTa+hx7UfZvsP2fZBXMpfI369FpWVdSbO05Zb4TE=;
        b=p8+vdApFWyqkQz6FE+D4sF5On5fVKM1c8LlKUiDb/rJfrfVN8Ioh+ZsJcxCt1h9LnF
         vUchkaCYQV8Vtf/PLU2Gm1KI15QvxCGRXA2p8YgG/TnPbYio1IxuuXZzoV9AmCvkJAz2
         E0DBVYGLHFlZX7w8gCeObimolLQ79+kXWpT9+xRjek+wxDkHChi3Mg/VscOs8Kz0zKYB
         iGGf5eGpVkfztdDSBWNOPDhMPRj+ol0Kh/iG6R1cmSV3Z9tmablKY8NynyKNlmKqnFK5
         w5/UTD0S6Kbemgtfache6LzVTaWQ79hxO24BRGDf7fiqbh62qBBHS7ip+o9FvZSHVVzI
         KYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756857334; x=1757462134;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIGRTa+hx7UfZvsP2fZBXMpfI369FpWVdSbO05Zb4TE=;
        b=UiX4ISEsARJjKtL94fPw5aUFrUToHna6tyKENJIk6G8BswA+Kcm9NSdjMNdr1BVihO
         5BtFXwTHSOErvrWdq/TN05QbkVEhb9ayxrlNis0dgVJt+CfN3a9bUYsr3o75Gk0dlf4g
         CkLs5vTJW8+SkHBl2snjYqcG+S2r59a5DGMWbyzqmXDzgEoj30ts0YsNFvEnQ5ozUeDM
         6A58isTkWYB1/LUQxZjXl41zvnFVKZEJZKPHAWXHEXv179r9/aNCL6ZhL4J3DX4HatKP
         rxDrZXlAHjMq++QLp2mFN8yTLz6Jm8A1t+znatVaf3IwXFd/CWiwTE7TRAdoKx+aC6Mk
         Cefw==
X-Forwarded-Encrypted: i=1; AJvYcCWTmvvCasZZOmA5rMmKaGmwiQfyJ9eW4Gm58FhilbuURhD7Et3lh7Uc823xCd5p5S/3uUMLxTSWdQw0LQJp85U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPoIxjnT1hhVmv8FObnRnoT5l/Fc2BEKbvvoqvCWiqqOc33GjM
	q12UedYLIUzbkOJSRXHyj3mHcGqb6ATaCN5cwnb/xnRRi5dN622DXcx0nAsoWbc5Mwtqr6C2Wq+
	SEZ1vFBDQy6+dsLQajyG7yA==
X-Google-Smtp-Source: AGHT+IHhkNI0TBiTHsK3Yf20wfZ8jdimx+BAATrPLxjOnbn8CaU4LzudRl9ZwHjqTaNe30Olvhohi+5JNqCloWxj
X-Received: from pldq13.prod.google.com ([2002:a17:902:c9cd:b0:24c:8f0c:bd97])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f789:b0:249:2789:4110 with SMTP id d9443c01a7336-24944890abfmr165843255ad.10.1756857333921;
 Tue, 02 Sep 2025 16:55:33 -0700 (PDT)
Date: Tue,  2 Sep 2025 23:55:04 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250902235504.4190036-1-marcharvey@google.com>
Subject: [PATCH net-next] selftests: net: Add tests to verify team driver
 option set and get.
From: Marc Harvey <marcharvey@google.com>
To: jiri@resnulli.us, andrew+netdev@lunn.ch
Cc: edumazet@google.com, willemb@google.com, maheshb@google.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Marc Harvey <marcharvey@google.com>
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
 .../selftests/drivers/net/team/Makefile       |   6 +-
 .../selftests/drivers/net/team/options.sh     | 194 ++++++++++++++++++
 2 files changed, 198 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/team/options.sh

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index eaf6938f100e..8b00b70ce67f 100644
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
+	../../../net/lib/sh/defer.sh \
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/team/options.sh b/tools/testing/selftests/drivers/net/team/options.sh
new file mode 100755
index 000000000000..b9c7aa357ad5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/team/options.sh
@@ -0,0 +1,194 @@
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
+        value_from_get=$(teamnl "${TEAM_PORT}" getoption "${option_name}" \
+                "${port_flag}")
+        if [[ $? != 0 ]]; then
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
+        teamnl "${TEAM_PORT}" setoption "${option_name}" "${option_value}" \
+                "${port_flag}"
+        if [[ $? != 0 ]]; then
+                echo "'setoption ${option_name} ${option_value}' failed" >&2
+                return 1
+        fi
+
+        get_and_check_value "${option_name}" "${option_value}" "${port_flag}"
+        return $?
+}
+
+# Get a "port flag" to pass to the `teamnl` command.
+# E.g. $?="dummy0" -> "port=dummy0",
+#      $?=""       -> ""
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
+        local port_name="${1}"
+
+        if [[ -n "${port_name}" ]]; then
+                ip link set dev "${port_name}" master "${TEAM_PORT}"
+                return $?
+        fi
+}
+
+detach_port_if_specified()
+{
+        local port_name="${1}"
+
+        if [[ -n "${port_name}" ]]; then
+                ip link set dev "${port_name}" nomaster
+                return $?
+        fi
+}
+
+#######################################
+# Test that an option's get value matches its set value.
+# Globals:
+#   RET - Used by testing infra like `check_err`.
+#   EXIT_STATUS - Used by `log_test` to whole script exit value.
+# Arguments:
+#   option_name - The name of the option.
+#   value_1 - The first value to try setting.
+#   value_2 - The second value to try setting.
+#   port_name - The (optional) name of the attached port.
+#######################################
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
+#######################################
+# Test that getting a non-existant option fails.
+# Globals:
+#   RET - Used by testing infra like `check_err`.
+#   EXIT_STATUS - Used by `log_test` to whole script exit value.
+# Arguments:
+#   option_name - The name of the option.
+#   port_name - The (optional) name of the attached port.
+#######################################
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
2.51.0.355.g5224444f11-goog


