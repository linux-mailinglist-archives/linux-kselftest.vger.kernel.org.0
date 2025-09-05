Return-Path: <linux-kselftest+bounces-40860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484E0B4601A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 19:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6D7BA022E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0337427B;
	Fri,  5 Sep 2025 17:25:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2436CDF5;
	Fri,  5 Sep 2025 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093133; cv=none; b=kVbtulWFvQCWiySO8QaotHfmTchub3baZZDAEZX06/VgvBbdAvJDOKnB6L2xoGh2nf6crPWFegNoX48zaGoih+KTgPAboXcd9fSTFM0vaQjy2bLdb/Em9Kfl9g7bMGScPx0eJPi/T8M/ndjLYwaj3uNkUUsuPAIKIJUc/ezdYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093133; c=relaxed/simple;
	bh=YhgSQPI30A0/pOzsLH+CWqoAMiyIaTdyKoKM5XsaX+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MgBNKwDEd6Lh61sJGfXGO2jo9L+ro74nY/9Yi1UxkfkKLTCK+qIBzgeb3ca4lU+mFxStz6NVXHLqmoVm6ECS+Fg62jE790osqIwsh2piBBPtaZk/KMLAIUpYBXTGHRbKcGtsPsK9gTFNCHzsAq52dljBRx2WN8wmLW62EbfA+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78ead12so373905766b.1;
        Fri, 05 Sep 2025 10:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093130; x=1757697930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsc8MlYaU9tsK4NEePLeaaHzeDgrNDnhXfoZAt49ZYY=;
        b=lVTJfX22vlpVzb1cEYM5WJzMdnpv8Lsg7h0H02uI+hs4hq1UJfCTbrtO8XK+N8pap6
         5Pf4s+YdeZAWVqzMc5++NPljHv4qGHaAOOBlKz9mCZHcfi5nwMAJVwKJCvbkPljM9a8v
         81sZ+Ai/69CwA/6AVtIgOvf+/tLOBv3Ha25Zf1szjRA0LzHLezGdxTfWZ7RNlqmbA6wJ
         cypp8Cn6Irj3v/LYn5BUtiynIh/3e0L4p1fPgMnmrMsD0Rq7nXibQ419tTeq6W1evPsb
         MAYCVmnTTqqDpWH9Dd779k2FpGKuWqxnsnL7QtgMOKuT6r+0Zv2fqdC1KEuqZLgDqQO8
         UXdg==
X-Forwarded-Encrypted: i=1; AJvYcCX2XXeZJa9mLB0thHehL8qoF15SwNy8ZNJRykqlWDsudB1e8cNwaLLgYubZ5kRmuvJdSSclgUoa6qvNWWQdOzY=@vger.kernel.org, AJvYcCXIciVLVcokr71gn0fVWzeCBTZtfm8TzXQ4lP9JWH/zoGr6PM4D6zzs5yej7Sv8c1wrMErdVrXJ@vger.kernel.org, AJvYcCXbLeapRd0PeVoT/23QtL/ViEO2PprZVouuL7gYVSZevwMmOAY24jM5HJRYf9/1/EbdceQRiwZg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uor8ilEnfiMe+TX14Mbx6nYPEWyb0TJwGkJ9QN9WMUW93J+o
	Rhv+TaGstHm1GmYFH749k9hKLlYjLzPOJuBkRPTDtUApuWWDSA17qEax3Ox8mQ==
X-Gm-Gg: ASbGncvGG52qSxxKsxgxg6t46KxZ2pm1O+wBtI5EEkViTjfXWycuTIGg7BNNqBJlqc5
	mmEcQhLcyBHpWPfABvZN2NYfxwD96LcqkyJ1MB4ZYwGvu0NRoPaymWddzttTha6817tRN6T71Sj
	hDbnv4J+SOelo+MphU/7PvysYWZqo3Xx7D4VJCiS46tgi9YCHox8G4m65zYBo073ljffFChXxaK
	TNGrLRoZfuaj4mmkxHgxb8urmQU3hXvB4icC4i3oP+gxF6vfuP4tUMaIs8V9JpWtE3H8HWb3gdR
	I82jg0foAxvyJhZGe0r7pUjL0GnfuqwX8hOhQpiPG2nyT2Rbl05hgUR6NUQH3+LcinFmxnfR9wD
	ZB9c30ecJdc7btJsPc8x5Q8E8
X-Google-Smtp-Source: AGHT+IGqmX/C92BZR/M8sWY1XF2SOAm4ZqKGK9vRVcxiVLn6mADL/aMLPdQCuRHKNrezowVoMUVtfA==
X-Received: by 2002:a17:907:7290:b0:b04:8358:7d96 with SMTP id a640c23a62f3a-b04835881a8mr703525166b.51.1757093129618;
        Fri, 05 Sep 2025 10:25:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0cb2cb07sm1771128066b.16.2025.09.05.10.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:25:29 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:25:09 -0700
Subject: [PATCH net v3 3/3] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-netconsole_torture-v3-3-875c7febd316@debian.org>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
In-Reply-To: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5212; i=leitao@debian.org;
 h=from:subject:message-id; bh=YhgSQPI30A0/pOzsLH+CWqoAMiyIaTdyKoKM5XsaX+s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoux0CnH0C4DzJqRi8Evz7XiGBi2xlOP6ecxS9e
 2Z5KC6FcdSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsdAgAKCRA1o5Of/Hh3
 bTKDD/9+2q+hv1iMWEoydMoxB5EgWPZ+gNGXIE/nYeZco8dBubNHo+Rl/HHgRCjaVfzzclxz371
 aDe/EpHcnyCs0Y+djWM+HelR+FQV41x/STSneQS0mG5cJtpMskK1gBw7NPSvCZ0HK+hxFJl5YSN
 f8S/+/rmT+pVT2mAMLEK5VsiebNsDjAJ3sePHUKNnXYeDl/9sU8uGf4nZlr3aszb4smGDkpSjN2
 5VO+Mpt5m/rUMlUKuEZhjTjiloyMHy2fQ5Y2fYJYQh7RDbKYnddEQQTNY30PyQAfLB8pZYxjcYq
 /kvknr7mlXS3mKOp4r5SM1OX0sjw6RQY//yhqtPY8LsTgaxivuw5VvgFKZDn2UaYRdZF5bBXvwR
 uXm6KY1VZF8WDsgkKRIMF66MwRXAW9WjJRfzSYJHu26xiRxR892rZtBX+eIKkH/1M0tM5bu6amd
 nx4a+odVsKX3w0/MMdiCYPJrZqVhD5DynAKG5N5KauPOLScB3QduqGeVoKd0awn5jk9tS2vlHWs
 fmvE+bhndxDvdY+SRn0irPBSWNgmXzGh3x/h+Cxk+LIUidgDGBtkh96OxhN+gDFreRzck1g4COd
 M6YMmlN494Hqj6SMrVD5rwkPF9yxS/kFASlg/15BtS1s43frubaENEKY19Y0JQ9k9alEr+7PrbB
 23vnsEKBVF5UXLA==
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


