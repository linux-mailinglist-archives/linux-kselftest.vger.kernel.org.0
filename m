Return-Path: <linux-kselftest+bounces-44728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3AC32610
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 18:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15ED534865A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D4D33DED5;
	Tue,  4 Nov 2025 17:37:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791633BBDB
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277841; cv=none; b=V57WVzKuP11Wi19tmaYw+JuvZYXI917T1ZOYV9i/bomJri4Bfs+C3eM0SdkSem8+ONrgcU3uhRwBW0GDJcReU5W6dFLE+LVMTi+bCBhXecms+dDTd6XUH6x0TkiaKqXG2JwGxs2yCs6iI9X/l1HdlDuHCpsyvGqwVm4GN6eHmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277841; c=relaxed/simple;
	bh=XQp4YoJOgWYJBS+lAreScEfDBZBcema28xQn9VyrhM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=inVEYEo908koqqYHDsXZxYGRBR6EoVT4jDSpXuYdwHZI+iu5AyZwJ/aHYkb/mvwV44R1n8lZ1sXBPNMSopSno1RP/Rr4uOp9TkuPj4qNIyiRc0SeaZutZKugGoVRr/mSCMz0XTvfv8nyghoTkHakorz3Vf2U3uvfLuFifXCcdqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b2a51750so5115094a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 09:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277837; x=1762882637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48WWGgV3/OQmNtRAgDmereIyjTW6e2ku3y8EB8DFBcI=;
        b=BbdTvmsqpG1jDcSLmYuIMfMKtJVI1+z4Ypo8cZkoaZLUfX4+3DXAUKZutYUUBwWBgP
         mWB94wf3fcavttL2nCWpSzd5cVLGosoJAFQljtF7JxhCq/24Hn8UOznGyLw8h668RGGJ
         RhVXU2jh7OLzArcPCEiWarIQdbbvaNE1vs51o6BouRHoYV8b46g5tAAiS7ReOBXp1bcU
         oOxmzfUNKzEkWAZeOUjW33JztbCXNyQkmhPNJZm/ymL5gmgo4SSvHANg44edBoIpoaPF
         +hoKDwfWnJ0nGRMIlEC5LqAJcC7reVNITj4SwYTPkND/JLDZvK4w6Phc0QOW7HeRWtnX
         T/qA==
X-Forwarded-Encrypted: i=1; AJvYcCXVytxEeU0Ngn8anSbtl/cb6ll57PfkQLy7HDnTMBoaeFMBGz5hRXtQ3tQcNlLmbxnu/xRmH6Gd0LTvzVOS9mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPZ4Trcle18ksJTMsmPaOjDVrIbWuUr7j1dishkRQS5QZdULD
	hOkfIEO7z1OVcNMQJIE1y2aYpzojuefpS886LA+bS7p6RMsZVLO1UtR+
X-Gm-Gg: ASbGnctsoNyoHWuyWgm/DMP3xsThyLvPFW6/BUO65hb4M1zcKg+Iwh/3DOosE7SocTE
	mUnIO7M1zGjgFJfiu8Oq3lt28KZdgqrOVLn6/iClSdOjoYK20z+jKpemwkFVgtNs99UlYLGz5Xy
	qgDcizAlr9CtmzzbPbwCqptgGpAnIhT9osnLwnArKLN1KyTBrJ92cRJfELMTHqMRFipUoLKDHeI
	ip2/YM64HaUgF0S17YCf998+D/xirjh5+v3Shoi+0XZYMSzQl6VjFR3i3+8tCJpK8eIwD80D6cf
	/MHeWV2EsDuk+MDNMfSo2tC4rKDbq3BCKQs/AJAIgM2eraS61dHfqXWASMwBwve59OBTCUQg4qB
	2Vg9QNGfkJKRPej9FVQRbEcL0fqoHki4QmXF91JzHU96zFyYMEHCNDPlsJpnrEonSRzU=
X-Google-Smtp-Source: AGHT+IFJ1qYVHTtjz3WgcAaTA/+PbaaUWai8cHCtmtRDu7YFBVJTOVAy8XMlslBRTxZZtuv1myqRTA==
X-Received: by 2002:a05:6402:3586:b0:63c:25fb:19ea with SMTP id 4fb4d7f45d1cf-64105a4421emr35457a12.18.1762277837373;
        Tue, 04 Nov 2025 09:37:17 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6805da3sm2662988a12.15.2025.11.04.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:37:16 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Nov 2025 09:37:03 -0800
Subject: [PATCH net v8 3/4] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-netconsole_torture-v8-3-5288440e2fa0@debian.org>
References: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
In-Reply-To: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5328; i=leitao@debian.org;
 h=from:subject:message-id; bh=XQp4YoJOgWYJBS+lAreScEfDBZBcema28xQn9VyrhM8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpCjnH70CjYjOr27ZeWZDVbZhlEIEwOSX83Pzs7
 Fxy2YeRYECJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQo5xwAKCRA1o5Of/Hh3
 bb7YD/9bgo/aFjZ282vejMAMVUODUwaIJnAyQnaERjc5WDPdX8/tAe9MFisY0yoEcjg57sCMVbj
 HFndrt3V9l4AYtQuGht0xoM7lGoF4ABzSe0dCAvQN5Tp0E7Q2hLUEadKQmpyMTdnRnfIr0zdfNj
 k/jWsc4781aRdfH78TcNItUVd9GCHDkpNOeJq4acP8ePCX/nskI5gn3jzhaR+8fkJXoAbtDk+am
 aKYrFbPbXqga6NoihztLdMA3SWvYvaj5BgQ9j/tSqK7rFguMMkPNReyUDdVCzqTVosssuXc14Br
 2RRbQgWM3tO1/xhe7P+IcJMklJT1ueyQk6rGR6tJCAZiv95LWtSsiNaQFVw+SgQRJ8iRj/r8j26
 PG8I2u2z1fIDztZcO1zqI9/aU9ZBuBJ8GNHPWiX6D0AiGmQKKjBW6BZLGYoQXXyH8wsb0pzRqg4
 uyc8AgwMCAgAuN2xbDaUTOVnxWi5RfHc6ShrWocCN+AS8X2kIdqx8vPgvfloQ8050tBQPANBBSm
 GoER+IOWZiI7uAzv+b0IzOKohngpEmoNLAsoYPSftHcC+QNljqW2YbzQ04Ridrgy7QhRa8t/d+s
 MXOOjzu+slSk10Ta0U5JTg0xVZn967m/66IxCZqshzKUPlat8jAVOWDFh+bTXXLSZpSBS5UWyOh
 GuYHrSxEehtgq2A==
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
Reviewed-by: Andre Carvalho <asantostc@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/netcons_torture.sh       | 130 +++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 6e41635bd55a4..71ee69e524d77 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -18,6 +18,7 @@ TEST_PROGS := \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
+	netcons_torture.sh \
 	netpoll_basic.py \
 	ping.py \
 	psp.py \
diff --git a/tools/testing/selftests/drivers/net/netcons_torture.sh b/tools/testing/selftests/drivers/net/netcons_torture.sh
new file mode 100755
index 0000000000000..2ce9ee3719d1a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_torture.sh
@@ -0,0 +1,130 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Repeatedly send kernel messages, toggles netconsole targets on and off,
+# creates and deletes targets in parallel, and toggles the source interface to
+# simulate stress conditions.
+#
+# This test aims to verify the robustness of netconsole under dynamic
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
+ITERATIONS=${1:-150}
+
+# Only test extended format
+FORMAT="extended"
+# And ipv6 only
+IP_VERSION="ipv6"
+
+# Create, enable and delete some targets.
+create_and_delete_random_target() {
+	COUNT=2
+	RND_PREFIX=$(mktemp -u netcons_rnd_XXXX_)
+
+	if [ -d "${NETCONS_CONFIGFS}/${RND_PREFIX}${COUNT}"  ] || \
+	   [ -d "${NETCONS_CONFIGFS}/${RND_PREFIX}0" ]; then
+		echo "Function didn't finish yet, skipping it." >&2
+		return
+	fi
+
+	# enable COUNT targets
+	for i in $(seq ${COUNT})
+	do
+		RND_TARGET="${RND_PREFIX}"${i}
+		RND_TARGET_PATH="${NETCONS_CONFIGFS}"/"${RND_TARGET}"
+
+		# Basic population so the target can come up
+		_create_dynamic_target "${FORMAT}" "${RND_TARGET_PATH}"
+	done
+
+	echo "netconsole selftest: ${COUNT} additional targets were created" > /dev/kmsg
+	# disable them all
+	for i in $(seq ${COUNT})
+	do
+		RND_TARGET="${RND_PREFIX}"${i}
+		RND_TARGET_PATH="${NETCONS_CONFIGFS}"/"${RND_TARGET}"
+		if [[ $(cat "${RND_TARGET_PATH}/enabled") -eq 1 ]]
+		then
+			echo 0 > "${RND_TARGET_PATH}"/enabled
+		fi
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
+	done
+	wait
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
+exit "${EXIT_STATUS}"

-- 
2.47.3


