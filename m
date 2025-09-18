Return-Path: <linux-kselftest+bounces-41824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6FBB84328
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 12:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0131C83D1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027F3002A0;
	Thu, 18 Sep 2025 10:42:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240252FE56E
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192142; cv=none; b=jGe3vMAdOFzyhzFumjQ2dHobQ8KQxH5FySuOVqOo94BnJG5d3sTJBaTGuCV90QiSp6EsJ7IMMb5iKSQ6ESB8r+49EB4sUcS/YUqkx+HETDCk/JFNN7BfyQjCtM10PEBww834DBunei4RoooJXJeteCZhdoqJUjs6pgqtV7w/MQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192142; c=relaxed/simple;
	bh=njsWipcAw6zDiWuPvoBPcLtz4KDuk27UDraQiXEyOh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eqm/CkualNNGgJ4Qij++xVnv/FK9h2BGTyuunIukkVuiI9rdQQWsJNuIetQiTp5myzjJBhyNNsggvqGv/wnLDb+HOlVZnA6mf8XvnVPVWe2Z33JsKLZGJtqR9Pa2cO1rGw6PzVJ1sDuLnRaP8yOn6XIRDAY26uM7wrTDbVvPdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b149efbed4eso124885166b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 03:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192138; x=1758796938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XoyvrHtWDXQ1aF+5AGUr+W6S/qx0Hv9FBJ5bml0jjU=;
        b=qWIcN+TyQ7+VBPbXDSgPEmV1xN+HBXudBWkW4O2A75EMQ2mYUYyjMV5WvtBw0gL6am
         TbE5aFnJkKM1yf6yoiH7aeseMN7tm19nE4Sm+d2YCwVzdPge2T9rDti4pTGFPbnKziwB
         ZqgZMCFTslQvXSloZ0t9Y8Ue2cRDhcLMtlStUJQ4YHQIkZLX43zpbrbRxIfUmJXQEv3D
         f8Jb+Izszz5+4twJpJAXizbEfKeWdKUtE4ehp/kG5Lkzw8/wxiWL8eBTOlWLAGVkxxJT
         bnEgIu8UEwn6kp2U6/dRrzwnnd/fNspjO0HyKh3Wd5KxiSybx3wKh4x7lwZS9u8YEAQx
         k6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlb1aftIIOI9iS4QXMAQ+SRZLOeTSapb0SnqVY7ZdfuN6G3fSiH3tQ7rNDtLMlVh33V/HTroYoY2cMKMD+gBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUSI44sZrWIq56FyDbjUhb9fxAYi6ONdoppm0jUmGDlsJq5cr
	y4OKZtCoV3ijp2wq8z65wi90phg9p1SDvhMuisVhkTG8QGl0vjLyfefL
X-Gm-Gg: ASbGncvkVTh8qsrVKuScvyVihLhrq9MZXbnACNxrGlB8nUaMuSrWo/P5XYMwcl3suN2
	GdSC+MG5iXl4m2p5Z/xDRUuTjVnItIhMuw7PoeqwdXyrTrM0NfXcG4ri4rmS6JxRd/uCdBLhNoD
	NCxzPc4h81Zt20tl0+UjLZBX2YWyF5GJMfwv5j2Y9dAh4qyYIsEX9V4XX7Vcrp8vLysWLV9EDRN
	6ZArkhLsokOQ8LN1nEbZYu9sNsYnOByh4i+BT2w+qA5GbeXP+gAWC6djK9T8rb3csxath8rJm70
	0GHS6TZuF+fajAThlK8L9Gmt4IA5c6KlgUKKIs8O9GmJDAjZY751w2VtSoyuImDWPxX+bdC4rRB
	N6ED/DA+26yG/p1egxEACx4nm24YiixY=
X-Google-Smtp-Source: AGHT+IE92BVFrQCBsR676S80PJ/8gUcq+eiiRVuAaXrNsNJAA15CFSCVcQfNzvpwZlkxIxTyuZ2zOg==
X-Received: by 2002:a17:907:6d11:b0:b04:5cca:9963 with SMTP id a640c23a62f3a-b1bbb0678d1mr596051466b.41.1758192138250;
        Thu, 18 Sep 2025 03:42:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd110259fsm168886166b.90.2025.09.18.03.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:42:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 03:42:07 -0700
Subject: [PATCH net v5 3/4] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netconsole_torture-v5-3-77e25e0a4eb6@debian.org>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
In-Reply-To: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5260; i=leitao@debian.org;
 h=from:subject:message-id; bh=njsWipcAw6zDiWuPvoBPcLtz4KDuk27UDraQiXEyOh8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy+IEovc49EgP5d4GjkGG1zgN4ovby5/JpB/Gu
 bWxpeoknFuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMviBAAKCRA1o5Of/Hh3
 bUcVD/oDDzmOZ/WDmw4umwdzF5PpslmCzGqFdnd/3/MODVV6eTR5YoBX/oi6j5rXsr7S3EWNp/d
 f3ANYb2uFJGznNnE9XNH65XPMHc/I4qKgB3n3MVsYIMv9lAZtmy+5vlZGMg3/cI2J/+MdwlK3zW
 FnGCOGZlqy1wad42ip35/RYKTLOD7XjFTMfplQJPskqgegn1NTy6Y9Wm8nBsZfzm3uICHzajxZn
 M9CjU5XmM0pTYug4g2UlfrMsKbhnK+Zj5MGgJGlS9E8nixYoj+qO50re1lS9iu0VBpjBOkxfXKf
 53sePs+4XNcd81g3m37vtkPFCbDVbsUnFlAc8iwKC11Bs5QMiyTB4DHA4IahWP3KSYsAWmJLEJp
 hYdq+ROdFTpJhSPiJp+jxVFdsp9fHayfLE3j/4iHwdzUsWJOrIpRW8pVSuJVE1gNb+DL9fXH0or
 0xrAerAVhVtYYW+skruPndxTCqJuEQoWP/jxmjfkhPmKUFAtCystb/dF1l7nSaR+fp82Lf27JBF
 nd6Lo8k38F3racYpgnnng+ddgJxqC80Vwuair90h+bwvjRzBy6/PrP8CCwv+z1XQwWVQm1Wv4FM
 TpLP/I2sBABwftn36Yks4msnf4aXvciaYs9PJAtefaYYC0dWdb3dkU+iBfY/mfa0sGRrmHTocQ1
 RMlF9QtzlesOqSQ==
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
index 0000000000000..723aa2488c19a
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
+exit "${EXIT_STATUS}"

-- 
2.47.3


