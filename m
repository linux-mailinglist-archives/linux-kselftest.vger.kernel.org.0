Return-Path: <linux-kselftest+bounces-41678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFBBB7EABF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D581C07A0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B037C101;
	Wed, 17 Sep 2025 12:52:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDD32BC1F
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113541; cv=none; b=MoC4+4HjuVDGZbKw0JMDOOaoNBCvjeX14uU56QGgQniv4LoWxtVsbZIpoehvFWh4RWDubvGwicQJzYFkdtvxegJKWjSYAzkd1pmpkWJVqM0NWwsh7uA8dkeNk2U+1aYLmXcPIZxFAPYXYUQIsouS3aelP+f1uzEXUnWpKe0pCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113541; c=relaxed/simple;
	bh=r5EfBfSKIMrv477f7G+oCA4XbIivs+K5Gn+BWOKD4pM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5qhWdHXdOz5Fw1lJxp15uKxqvHUQ0Ho4ggaNMgr9vIYVNNaodfjP5MfynFNJsdrAt1Ci6/te8DTKSA8nR8hnv3p/peP/9t9IFaGJJ/vm8RVr0yruT/JOl1rhzSwwP6wg4Kr5pmnDhZJh2vPD509gGacUBhkBSApPOmpNLXy/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso8145414a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 05:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113538; x=1758718338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8g7UcBIXs26hAWNvuNbRdwnLJkrypreUCJrwcNAvpI=;
        b=UzpG8s0e9S481TYMeTj70D11Rr2esCcQV95BYieTUqtIvCpS3yQ81sPswvKfdCWZWb
         mabuKLWnrkGt++29fZEVZVh8YvUsfkuQMXhOhTJ4w7aMLSlgvRTWsKCbDyMxSkl9eAYx
         y/l1TBNtzldvIvtF3gDKH4JarZCKoSRaYXyb5c3X9MCVZ29js3ZZY9153ZCnG+IKT/2k
         PNkOgy0aeArmtBdCIr3f2HmfZuEyRpyvSrXL5j8zhRzxy/evEZlxy31TH1/OJBUgjhoB
         4UQEGZZl14dSeBmT3ZZUBjVnVAe/SIu9hnIlEig9E40dI7M7mPGwlIzGwxZnkZ+EaH9w
         Kd3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNhELnlnQAIPXnWAG18A4iYxJHqaCNQ6YEEls/A0nnX6bYkjgUZDDU7g0tJche65qVjtTIZzMm4+G6r879PGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCVaYQcv79OHu+Zlpw2rQChcvNUCD1w+0m+JsocCf5ad7kJCLT
	6PrT2P2Uwvirn4SBxCFk+KtOOUKwJdBUDPv8vMA/UvVxrcGDbMAZvEpV
X-Gm-Gg: ASbGnculuyjjtbpdJDBIE6sXT3nL4oD3W2jhKTGiq2b52VzdevqAMHtB7N3/aNH3lco
	Fq4gnQbhvS24FggW5njdBi7864u5KAc90RdX7C0h+qWLGHKiXqcBdiVsapARuQs3pboB+0FnT6w
	IKMmMbiDUYgxXtjuRQnY/Xetten8/HCd883ljtMSZ2FafyoTSrZjaNYsiTgPDEJnPuZcvvzEWf3
	rxa03JgSTH71zJpPFZcoD9vJXvWpXUIg2XUn/7xYqD1SSBQXur3g7Fj35R0GpDGNh3pMUTe0ara
	s5DFlnz3s5izg1k+HwfbwAdkjhalD3uXniVz3rRCGNsM4fBLx9QKCkQCXni5YjmqY8s1STYu+d7
	r0GXy4PKlXdRD
X-Google-Smtp-Source: AGHT+IHTSbPsp4F3Yju33mS4p9sEo3aXea3qOqf9CdOqp53LQeo/NydDmk2umI6b6gKsykQWoXn1Nw==
X-Received: by 2002:a17:907:3fa1:b0:b04:20c0:b1f9 with SMTP id a640c23a62f3a-b1bbecaf490mr245783766b.52.1758113537973;
        Wed, 17 Sep 2025 05:52:17 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c337e785sm1195125766b.25.2025.09.17.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:52:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 05:51:44 -0700
Subject: [PATCH net v4 3/4] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-netconsole_torture-v4-3-0a5b3b8f81ce@debian.org>
References: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
In-Reply-To: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5258; i=leitao@debian.org;
 h=from:subject:message-id; bh=r5EfBfSKIMrv477f7G+oCA4XbIivs+K5Gn+BWOKD4pM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyq77yytWubbprz0ljy6yMvY3u1Cr+N6g6vDUL
 juUk2QrHWiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqu+wAKCRA1o5Of/Hh3
 bQeQD/0XSQ6iM2BOau/ThxHm56EFKGBJAMD7gvCazvvxLXmj/QJxMhHzzLJZ8kLQ6GM3KxONl6N
 iJcghZXRSMF34SiSa1r4XNpULmWvHKDj+TGLoDh+QjkqZ1bWSB2E7jTEnELaw6XWMJXnkO8sDsK
 +B5iPZhufDcEKRdcoJV3P10F2I61iKsoKbxobK4k1KBDt07OgUgjEQCYXI6SGK9R0nVnpcv+Z5c
 ywv+XVUAltzV2QBA1RBI7SpZcMRALayE4bP0Hqftl4SiEWuc09APzr5CpRuAfySF9Ap87VSyNgw
 kQbm/yVQ1anmmPVSZRj3ZcKKoP/eaFcENwoe4f+2NlWkYJOcYBN34PZdpbWvpn3EZHo41Jo+9Xe
 McsBhL+J/Cc2MnGG/+qsDQ+54vSpeWDQVXZ+Js9xdtZ9F3jeTF80a09bdctbzJc61lYvZn4M7h2
 Ng/oEcWhGRfMDM33GYrsQGQJsTKXOyqMWO6dH5yxccuzWqXQN1zoVyns7KZ9JXG7nodiypJ6NEp
 G+DsSHMYazuqJejEPmNYdfqAfjTvMV/nHDYueevdpN6P1DXYNH8VDGhqnwyGZCVSsHBMfu8gYEh
 vbLGB72N34hui1elpswHPYiRRVfx9xdjB/zxu0kVDGC1RCKlJM4tRf/IDMQ8NwClFgrKiqIaHHR
 z3oD82pkCsTZb6A==
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
index 0000000000000..3608051d475ff
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
+	echo "netconsole selftest: ${COUNT} additional targets were created" > /dev/kmsg
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


