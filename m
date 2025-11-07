Return-Path: <linux-kselftest+bounces-45097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BFCC403F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123601888E5B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C66329369;
	Fri,  7 Nov 2025 14:04:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC76328615
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524252; cv=none; b=VtHaUgULVxPiQQrAsj4dysPM58Koos1SC6/sLB4yafhNj3Buj7p9WEX8T/D0gv5tBxZXiwxVMTacaO9sYRH6OzZqYk+gcHnZJeEfxtIkT246O85h93sE5PcPXEm50POtmJ5dfHzUHZcugBhB13hfoafyBvH0IW/pW1dHE0rXmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524252; c=relaxed/simple;
	bh=XQp4YoJOgWYJBS+lAreScEfDBZBcema28xQn9VyrhM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSBoxhX0gUtUWWfJGrmU0UMJHp7a1SX64r7+vOTzQlv0Jjgp25WAJw1cAY6H+56CO5Q7aa0qR7qMefnuBkT7DJxokrMiiVV5PrjfBLxBUPYyBtKQd79DFTmwRqsbpeWbyNLsNfbj4hk6MEDCzcuyoiXx+70EImSCmEulKjhD/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so129882766b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 06:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524248; x=1763129048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=48WWGgV3/OQmNtRAgDmereIyjTW6e2ku3y8EB8DFBcI=;
        b=o++4IlFQ53TTVWdryDqHCHEWJW8LyUFhxeZWZUVjmIX6fhsreNrd9ekS60WBPka3W1
         ePwuO+ofYOxD7mI4ttMSii5mEQQZCxCdEC+KOZ03BfHdQwsfuU+kq96ruTi8iGrwfX5g
         jbjAEQjOto9iZ9wBdiSef8STyspNLeNxlDI+6wUK1BZc+zfse3kgUcsFO06qd3exo3R6
         Lumgm7wlufzct0bPZKwiOkImlgZSWevZwqIRMOXKKIUO4YNy2DAeQcXTNBe9/Vl0holH
         cfmpf8997dp3uFDCcUBpOV2AHr9v5cj6fbIX6KyTBllhJVO6T61boR3hA8tIpm+mErxH
         IArA==
X-Forwarded-Encrypted: i=1; AJvYcCWNT+fnQLt+IaK9EGkEUQksbO7E4S3/msJqmO7fSWU50gVFQOxMRbFvdahZVSDrzTcpYD/wRZnCAY2BcTl7gsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5RXWnCUeDR67Dgwlxy4H8oskv44unwN1G86/obxoBXWaZMI7
	AxEawKz1+zZKGg49fNZ86mV7mmXxv2DBv7DSFUY9FKtydPRZhrxk7Re0
X-Gm-Gg: ASbGncsu1sKIch6Z8dRL8BkcZ2mGvC4LFwmqsgBQiy6wKykmAisZ4zZGQ9VwvdG+RR3
	2XkmJL2DcuklXaAyX6vneBNOzNb5MqOxC7QWTzyeOEFlBCpiA3o4r2+OrHfDUYlPEbcXAu659Qs
	jWoij5L/ar27S5I+TPNhibDoOSkP/s5Sxet6bnx/jlTD4wq5/zpqqwvGPPCwssmWxdc/5KQMD/I
	19QDsgASsm0nZ8hjxfWMx8GnhfU/DpKKPhfBwPnzAlbuRI6/3lTtvyoVUC+emZEspwpVmPP2LBf
	lOpGIoV1bRYQ7nZsE4X6RI7MEK8G193SgIyC2anGZapf1G4hDCPvdlgt/aM+3MXuKYV1NhEFd9s
	e32RGGTXuWSngP+EQ88j6nhMufh4QtzMXUYF/w/tJ1qTQA7KhO6j10h2Ij9VXwhv1mg==
X-Google-Smtp-Source: AGHT+IHsxl2XPAlFemI24OJUBp3fWjsJgLD0KhUvnrbrT+u5Rl9gEHfRv/SUFSF97pVI+pc2Kd8NmQ==
X-Received: by 2002:a17:907:7f8b:b0:b6d:67b0:ca0b with SMTP id a640c23a62f3a-b72c0dcb646mr312514066b.61.1762524247809;
        Fri, 07 Nov 2025 06:04:07 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862bd0sm4354131a12.26.2025.11.07.06.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:04:07 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Nov 2025 06:03:39 -0800
Subject: [PATCH net v10 3/4] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-netconsole_torture-v10-3-749227b55f63@debian.org>
References: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
In-Reply-To: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDfxRs0hwlyPprZCy7+HJz29rlUnUJTxAFFQNi
 /Z8x94vzfaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQ38UQAKCRA1o5Of/Hh3
 beFwD/93H/5JZ90OGK7FAb7LO8jQ5l5TjjZmj91h748Q+8zPGszefi/KlWCesQ4vSBGJ0YP6Xbe
 z/AXyk4N6z3LUM6kxXuWUgEZ8gnsb5VuVAK+qMnBzhTjKdTZ3IuRSd4vIZNhDf99pmOAY+dv8/s
 KHump/2qH/HsFgDFtsH+xGwUDYrOHJ/2Zk04MBnuSXZpl8HbDJd2mBiasrjfZ1fU6eHdD+OZhk+
 ypykIZRZgJvLSE8nHJMLC2Abxvq3eZHCoqg7wEDWcX2c8J6s+GiEgF1Y/ob6KmEk0QRkZVXvOjH
 2BbtvdK142leANniiHxHCPtxFS5NMJa2Tg7lLR716S5WLaUy5eAzvoFXZ0GZ0I9CfVXROzTbyP5
 evCXNHFGimHDDVJnYJsS5n9lNqN92Gnc11IEjJXQ8faVGn/rd94hqb70TQCKn3GvXw+US4m3Wm4
 ZWTN4Fale4u4FEgno56YX6FjONuC1x1dDcN43bcz1XGnnIw++NWcEnIOWhU4drRCCQgvllBC4Mw
 LJdAAAd0VvhjAIWUkYu72WLtZnlzgMMBAgzzGJRYOI0BsdV4HORBeGUFheISB5ZWmHZqOEBc994
 /u6sZi36kt1eWcqEbpxU7ctyDIA3dCowVYukU6bt5skEHCJrBMJw7PoQ/yd+AdUtzdYNfd79Upn
 TM3XfaLkgWTnU1Q==
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


