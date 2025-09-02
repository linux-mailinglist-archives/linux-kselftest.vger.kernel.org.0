Return-Path: <linux-kselftest+bounces-40627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F58BB40AB6
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 18:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52021165A79
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C32EF669;
	Tue,  2 Sep 2025 16:33:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04DF33A005;
	Tue,  2 Sep 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830825; cv=none; b=J4BESzw21I+gS5vgg/6JxT5UCl/tyRiGSUNUgMQUaUbfgow5EMEHLIwmhZykfJ9ngJL/9SotaxA4pL9SrX4k9br/OR0ku4Q/e/kd0kJ95OhOIk4+QUEk7gfEqpE56JgyC3rS0GO7lOLJt+XCmThbJanBsbRunClxgdfcrxqr3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830825; c=relaxed/simple;
	bh=RE3FgNsKnWjC4fkSeAW422UDLZsZ8vzhCH9CYtQBqYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D6ZH6l83BdUwGQSuMXvwq9U8D0yN1w//7v6FMXJfM3ZzMOzeR/zvgNOqu1s/wsdEQ4EOfjdCQgowNzJtILwMNTpQv8JIJGSQbLNaPJ8ykfW8FEFqsRmqUy7o0ITqRl1IDKSFFoXBFUh+ZBMc6BXOI+6tJugev38d9wDjOUD4UlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b043da5a55fso263123866b.0;
        Tue, 02 Sep 2025 09:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830822; x=1757435622;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3FeINq1i5ZMPwlr/dYhne9uhmO3iEEG+4qpUcPbP6g=;
        b=GBUlhJbDxQZiv0moI8NtkCsnKiozQxkzYxpMXf7jgpPD0CW329Cc46QKR2mnEGyZnT
         QMflQYaE6H1aeNB4fCP/8lXnJMwgIoBryWkEe8qv6C6vK5cj0BSOCNuGO35PiqQqDUDx
         8AXkxa/M5LWHAt5UrePEcsCqlnJWWHoxnOehnx5J4NZWzvcYZC2uvVr/l2KSqgYyTxfN
         4ujbze8wA5WTriizTSawUHlfb8NPBMV0o6Hf4Az++cA431Kzkmpiy5VKYgGjmPD/9Xgu
         wcywqy+rqUYkTIlNIznaUms/e3l1mUUg3ABv/dmbPOqllThAl41+eIewZDFN6V3GTNtr
         IQ+A==
X-Forwarded-Encrypted: i=1; AJvYcCVI+DX4hUzVQQAB5bn6hMJcgdLd0xyKck1IlDu74AgYNnrnP3jFKusjfOOAMII5DhtPUmDTtZF9@vger.kernel.org, AJvYcCXDYfbFoyXAnR4HlWRjMwcpw8/b9N6phyNzdhKr7TTou2+YWwRzzDYE7b2X2tZSuqusew/9ZggUVaSa298KDUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hSvD8BVTgx20VtTdJ8RD4D2pEjyr0z4v/QY6mclUd8KVDUTb
	vzSJYRM7hZbMMqwJ6FQsky5MIdEz3mDJZEt4Nz3DOLc7X9kBS0bwJTTJuMClKg==
X-Gm-Gg: ASbGnctsOvlPv+rT1akO7utRwmMVrwfUGqWz/4lQOuniq3fYCcbmjjRyV6lFpBcisUb
	WRoLO7S9ejVfXtabL8dAdy66GdLOh2C9pTmg/4JOIf5sisuvLq7NR0lEgU5bC4Oad58FqbWC9We
	4G7w/X/MyDsFYO0X3gX1hRcWZycaA/uAoE+TpxxqHQR42DvyeLA6v+mCx9XcmLeqL9ysvtFwqu3
	+LqkbJqxaferDhaQI+2c1B3Hvf3U0uszmoG1oZv1ZJAPOoV1FFwzYYHxEVX1+Vlke5lbdnTnyxI
	0LH1HS/dWb8grx65qZe9rT66Av57gSrwLKN+zGoZ05+xVh8yfVsepFqeCA5uBUX0k03XqvWeUkN
	kZBrXJhF3JyGPWoYTTpiwHxEI
X-Google-Smtp-Source: AGHT+IH5125NR6h4G5qI9OXqQ58KzdMsW/kDSzmVUUhGB0SH7VPyFtpYqivO04qynZX4fGGrjBootg==
X-Received: by 2002:a17:907:fd15:b0:afe:ef48:ee41 with SMTP id a640c23a62f3a-b01da23e859mr1289920766b.58.1756830821863;
        Tue, 02 Sep 2025 09:33:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04189de5b5sm679555066b.10.2025.09.02.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:33:41 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 09:33:33 -0700
Subject: [PATCH net-next] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netconsole_torture-v1-1-03c6066598e9@debian.org>
X-B4-Tracking: v=1; b=H4sIAFwct2gC/x3MUQoCMQwFwKuE972FWhFsryIipaYakFTSKAvL3
 l1wDjAbJpvwRKENxl+ZMhSFDguhPas+OMgdhZBiOsUcU1D2NnSOF998mH+Mw7m3dOyxtpozFsL
 buMv6Ty9Q9qC8Oq77/gMl5Qo8bgAAAA==
X-Change-ID: 20250902-netconsole_torture-8fc23f0aca99
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5546; i=leitao@debian.org;
 h=from:subject:message-id; bh=RE3FgNsKnWjC4fkSeAW422UDLZsZ8vzhCH9CYtQBqYw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotxxkeBqgpYB3NSplyoZQBNhlN+/P+i229zDMV
 XCcmANWf3aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLccZAAKCRA1o5Of/Hh3
 bfyXD/9LBCxagGihURttDoRGhKnRKDsxl9JuTQQ6BXr3jqz6+yd4u+s3hJNaN52AakUGDabw8lp
 1Onh1YxD4h8GfFnSmHGsfdqAU4QjCKrwUShNLFollyskOWDkvQ+09CxMD27toD2nXEqMRdnfM9V
 wpdAyZX3Hb9IuUO52hB3yDLvJa+kAVVVB1P8txQgfblFb4U73VV/KeM1Q29Z7GJp5woiF0UYo8q
 3/0GiCjcSsM2GOMSHEq6CP0TEAM9K2B9P2MnFD+/LgVXJbtadvmlFK62KCdyDynI+PdCjLv59yo
 coZOn+LiSCgepdErw3H8P64IDtWAR5SsCy8Ef8EsVVMTZvDDMn8cmbKwRnWqhQ+oyznXWbrVKnX
 tm+WViyu7Qf5I8m9audzevSPPrpzKw6JP/9LWWCBMvAQcSqNkLuFGE1QTvBfT26Gl4nZ8B66HSp
 TZtNOWbzU5YFZUNXIdK4agac0zAhwaWClXXb2kf+fix/liCobkgN1sYDjJY2sYpaRih1Kjijv7W
 xPU30rP52OiXNZ2vpWesd0NXFoW8x/tsq8qi6l77r7o1adeWFPR1NCtwRNX1b7Ni6wmKgvB039I
 wEF5+DFn1TaYT8qygM7n/1Q2w0r/PvRrVwZJrqhAEFpp73bZTY5XhM7R8crj6vLdZrq/yFdJClz
 IDgr5NE3dlPgcOA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Create a netconsole test that puts a lot of pressure on the netconsole
list manipulation. Do it by creating dynamic targets and deleting
targets while messages are being sent. Also put interface down while the
messages are being sent, as creating parallel targets.

The code launches three background jobs on distinct schedules:

 * Toggle netcons target every 30 iterations
 * create and delete random_target every 50 iterations
 * toggle iface every 70 iterations

This creates multiple concurrency sources that interact with netconsole
states. This is good practice to simulate stress, and exercise netpoll
and netconsole locks.

This test already found an issue as reported in [1]

Link: https://lore.kernel.org/all/20250901-netpoll_memleak-v1-1-34a181977dfc@debian.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/netcons_torture.sh       | 133 +++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 984ece05f7f92..2b253b1ff4f38 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
+	netcons_torture.sh \
 	netpoll_basic.py \
 	ping.py \
 	queues.py \
diff --git a/tools/testing/selftests/drivers/net/netcons_torture.sh b/tools/testing/selftests/drivers/net/netcons_torture.sh
new file mode 100755
index 0000000000000..d41884c83cab3
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_torture.sh
@@ -0,0 +1,133 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Repeatedly send kernel messages, toggles netconsole targets on and off,
+# creates and deletes targets in parallel, and toggles the source interface to
+# simulate stress conditions.
+#
+# This test aims verify the robustness of netconsole under dynamic
+# configurations and concurrent operations.
+#
+# The major goal is to run this test with LOCKDEP, Kmemleak and KASAN to make
+# sure no issues is reported.
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+# Number of times the main loop run
+ITERATIONS=${1:-1000}
+
+# Only test extended format
+FORMAT="extended"
+# And ipv6 only
+IP_VERSION="ipv6"
+
+# Create, enable and delete some targets.
+create_and_delete_random_target() {
+	COUNT=1
+	RND_PREFIX=$(mktemp -u netcons_rnd_XXXX_)
+
+	if [ -d "${NETCONS_CONFIGFS}/${RND_PREFIX}${COUNT}"  ] || \
+	   [ -d "${NETCONS_CONFIGFS}/${RND_PREFIX}0" ]; then
+		echo "Function didn't finish yet, skipping it." >&2
+		return
+	fi
+
+	# enable COUNT targets
+	for i in $(seq 0 ${COUNT})
+	do
+		RND_TARGET="${RND_PREFIX}"${i}
+		RND_TARGET_PATH="${NETCONS_CONFIGFS}"/"${RND_TARGET}"
+
+		# Basic population so the target can come up
+		mkdir "${RND_TARGET_PATH}"
+		echo "${DSTIP}" > "${RND_TARGET_PATH}"/remote_ip
+		echo "${SRCIP}" > "${RND_TARGET_PATH}"/local_ip
+		echo "${DSTMAC}" > "${RND_TARGET_PATH}"/remote_mac
+		echo "${SRCIF}" > "${RND_TARGET_PATH}"/dev_name
+
+		echo 1 > "${RND_TARGET_PATH}"/enabled
+	done
+
+	echo "netconsole selftest: ${COUNT} additional target was created" > /dev/kmsg
+	# disable them all
+	for i in $(seq 0 ${COUNT})
+	do
+		RND_TARGET="${RND_PREFIX}"${i}
+		RND_TARGET_PATH="${NETCONS_CONFIGFS}"/"${RND_TARGET}"
+		echo 0 > "${RND_TARGET_PATH}"/enabled
+		rmdir "${RND_TARGET_PATH}"
+	done
+}
+
+# Disable and enable the target mid-air, while messages
+# are being transmitted.
+toggle_netcons_target() {
+	for i in $(seq 2)
+	do
+		if [ ! -d "${NETCONS_PATH}" ]
+		then
+			break
+		fi
+		echo 0 > "${NETCONS_PATH}"/enabled 2> /dev/null || true
+		# Try to enable a bit harder, given it might fail to enable
+		# Write to `enabled` might fail depending on the lock, which is
+		# highly contentious here
+		for _ in $(seq 5)
+		do
+			echo 1 > "${NETCONS_PATH}"/enabled 2> /dev/null || true
+		done
+	done
+}
+
+toggle_iface(){
+	ip link set "${SRCIF}" down
+	ip link set "${SRCIF}" up
+}
+
+# Start here
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup EXIT
+# Create one namespace and two interfaces
+set_network "${IP_VERSION}"
+# Create a dynamic target for netconsole
+create_dynamic_target "${FORMAT}"
+
+for i in $(seq "$ITERATIONS")
+do
+	for _ in $(seq 10)
+	do
+		echo "${MSG}: ${TARGET} ${i}" > /dev/kmsg
+		wait
+	done
+
+	if (( i % 30 == 0 )); then
+		toggle_netcons_target &
+	fi
+
+	if (( i % 50 == 0 )); then
+		# create some targets, enable them, send msg and disable
+		# all in a parallel thread
+		create_and_delete_random_target &
+	fi
+
+	if (( i % 70 == 0 )); then
+		toggle_iface &
+	fi
+done
+wait
+
+exit "${ksft_pass}"

---
base-commit: 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


