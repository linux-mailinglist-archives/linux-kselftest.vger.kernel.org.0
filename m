Return-Path: <linux-kselftest+bounces-40801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F01B444F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 20:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947513BFE24
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AAF343205;
	Thu,  4 Sep 2025 18:01:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83B34166F;
	Thu,  4 Sep 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008860; cv=none; b=qybEcCRjQx86HswRR7ot5Ffsgmv9UM6fn2X7ntXAmgMUC22tfgRZHNGPYrmtkycCQK0PiucAO8K7UoS3bsB40Cwjn2l38cFFQ5cHXhUGt6dWuZ1OMOJQRiO4LCU5x6FNIzB+fHG9phfrqIY0Gyw2MqEB8nU2OUZj/4joFw51nrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008860; c=relaxed/simple;
	bh=Rj/aqwJo1eDbOH1a9/u0mZvk6QA6zymZcXs+2NbyVlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M7pRiuEtFklabBAVgLLvUMOVBJYW3I0O6EI6DxoERrKdED7Pf63oUW4Yrn6mnk3xNahmNqJypHQhOhHQ4qkVCpKWA/wcp/QkedjNlobwo1W/t5WB5B//4V/WdhOhOvDJpEPU951AjO68rOOLrfHupFoFgc7h68lFtOKvXyTuYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so1854277a12.2;
        Thu, 04 Sep 2025 11:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008857; x=1757613657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8TcQd40DwftcY+OnUbKSA5yId8h3+mNgJMC7BEIRO4=;
        b=eoV5xEyKc2LKj6d1kwoT+/PszprHB5cLbqf1tTsqL/LwlPikY78pNmpME7Skgh0kZt
         CnsS+0xlTuKSf4VkGqdukuJbqjO1Qj0VnmbqqQSkN+JoODQTVrLX42rpZx9CPAIRwtZU
         onnaY2AAtvYamFf7xSy7zfqQg25wGnnOUMckS68Cf8Rznysgyw56eHgxLFFZbNt4GLBQ
         hutIyvtAmbVOWiAvCCUcKUSVQt3bGA7dsnqscNye4ic80djHJZugowTWTMl1O2CJHCMH
         SjveSE4FpfCamsBmLnuRQt/AjxfjD2vOKFOluOxAAVHWHgv7y4Sd/X9Dgug9QkSLvD9Y
         EJdg==
X-Forwarded-Encrypted: i=1; AJvYcCUQsA7qZhD7Q0UFEmyyxD+5cishYQal5p0TzyB9vNhOkV7SA0xpisEvVZZf5tLuEWf+9BzXZ2V+8cjifCH57I4=@vger.kernel.org, AJvYcCXSVI+OFF2yKPRWgTG+tkI0nhpiEYqjsk+8vNsh6dnMM7yXw4o16qRnPGDPEoJtqXu+9/uR5V/R@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0tYPEMkhDJP/5u7Bw1LiJLpAs945vQE/vTJllfLS1Mhft+3C
	EYqBdMZ20nEPdJ7nijs3w6GT8NqzhAn1itPnm5Q/oJw0kx+93qzUArcs
X-Gm-Gg: ASbGncs0Fqwq8KMMYGO9NDfINRLSaAhFPptrzqxJIrA5hcLWB5oHbZFTmFU9ea4r5uk
	zNDCUD/QNx/Xji6eY0YYL9SrrzIJXqtPr9ap9G+fhINMymXXGr2MOp7D8p1T49XSexygaLdJ/dL
	ChKOA9RnGuJMO+T9IYS4ue9HlzWG9jJwkhR+bS5Uy+iAU0IgoZBgt6mYpOQTO1dG+IUpoiO3ZIc
	6RGbiN2RFZ2xdrS+fAJU8AvO6WwUbJJ3OeRvjjsnk+m6zCgjWf9eUs1wiVOOIX2I31mMIM72Yb/
	mMSZV9tuFQTabuZhEGDBGj8LqBptgBtg0BOjQPCApjU8wKCH5YPQqjOwojv+I6BjEZTePtRB8Lk
	k4D7dLImGIA==
X-Google-Smtp-Source: AGHT+IGevcgoHTZIQ292kIzWTrPkKUWbWymSXeh3zV9OYq806RT7xD1Ty3dCoqV0TTU/yKG1Xkqrig==
X-Received: by 2002:a05:6402:4382:b0:61a:9385:c795 with SMTP id 4fb4d7f45d1cf-61d26eb51f8mr18283230a12.38.1757008857070;
        Thu, 04 Sep 2025 11:00:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-620e3289db2sm336619a12.4.2025.09.04.11.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:00:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 04 Sep 2025 11:00:41 -0700
Subject: [PATCH net-next v2 2/2] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-netconsole_torture-v2-2-5775ed5dc366@debian.org>
References: <20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org>
In-Reply-To: <20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5156; i=leitao@debian.org;
 h=from:subject:message-id; bh=Rj/aqwJo1eDbOH1a9/u0mZvk6QA6zymZcXs+2NbyVlw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoudPUDrDLTIJL+kC+/eGhpFfugCgwWmtScz0VP
 34vn+t1FCyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLnT1AAKCRA1o5Of/Hh3
 bebuD/9MStT2lufaDTldmt2sNGc2M2MNBes+dTYSaMN7WKcwz1LOGc/qrHwkZvekPgrtpSuNZIm
 NNR79RQcNOT6UTFis1Ndv4J7ER5Oiw5qB8j545sZiN2CQdD5kwCaa1qM8dvr7n6nXw7HPK79Txi
 82qMNiZ3M4f/vHntZFco4kKMXhCYm8VzGIEo2fExqFKoiGHcU864cod1frLPWufVyJBODWSd8ov
 bt2Co8GtKwYFFX2CAuNH6NCBvGCL4Mi8FZ6g1CrIPOs3ZG+0PfGzVR0+nzmchUrUR/+gSMNOaXe
 k1FRG7GFRcDpFzBmPX0dDDJ7oUyPv5oPvzpAHLuLAlw8D2Lmg1TixBv0pS0xA91GMfh7cIHzzJe
 RPdsbh6iKLt4GfLerDLIysahvC3L9heOHIKee4VdOr2WSh/t6f1DMJNEmiEEw9vpXjJeU2Vlw90
 KsA8ZP3cuJuJryDeeWqqy5qLsRWKEVp6LKMaHp9lKi1G+kWNt0gyi2jAMJTXDH/Kak5U7Vb3+Nk
 fgpnodIIbs7szBLzLb2tBbwCOkKFqeWrwmu5uHHzLDF3Eu1EO1+M4RMNNQQc2J7t0LlfAHrZhzW
 Ugsr3H0XE9ruonOygV+Zq6MpMc0939T2T9+OqROomRpR93TV4U+O2tQicNLYGbxoBnTMWibOUU2
 bYhd1hYad4qhRGQ==
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
 .../selftests/drivers/net/netcons_torture.sh       | 127 +++++++++++++++++++++
 2 files changed, 128 insertions(+)

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
index 0000000000000..ed95cdac7f47a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_torture.sh
@@ -0,0 +1,127 @@
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
+	echo "netconsole selftest: ${COUNT} additional target was created" > /dev/kmsg
+	# disable them all
+	for i in $(seq ${COUNT})
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
+exit "${ksft_pass}"

-- 
2.47.3


