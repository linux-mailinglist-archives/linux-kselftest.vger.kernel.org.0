Return-Path: <linux-kselftest+bounces-41072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B60B507EC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CAF1C654B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632F265CC5;
	Tue,  9 Sep 2025 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcPoK4II"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C4261B62;
	Tue,  9 Sep 2025 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452372; cv=none; b=rpo/OHRccaj1W3E55kypLHx6htuLEwsQSbGD4uhVYsD/edxNoNqvinYypfhETqyXw80n31i4YhUgMbBEytbRlgq8S1SnZhu01QOhFLxACeH5q5rbCkpKCCxyIyRx94lKuPLfv4X0YS4k+CfqYAusPy5We4H/vsu2+tS9QkeC7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452372; c=relaxed/simple;
	bh=65r5Q30rEGislckJZUxh/W9mjPAujYvYiGkilVFpCfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IeK+dgoHKRjgRamvHPGOxwk2PAQ5RbmtlU8GeXje/4wvWD3PUrQXsX5YCy4bZpJn6RtYdldlibVXCKLDVZYIw7cm+dwIAnUvQ+efIGPH/kaZhgrUBmOM4qnmto4v0Gy/5JkTI7uMHozrY6eJQ0GYjBmU9U7QTVecC69Nr0fD69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcPoK4II; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5608d792558so6658196e87.0;
        Tue, 09 Sep 2025 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757452369; x=1758057169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtOqibUwz5tngZUvPo7icyfPskkpVVJBzNaUCRYuMOE=;
        b=IcPoK4IIANi6kWm9kcoS2ZcTirpPVzsoK8hSyoIWHho/FeDZT2ToK2xgp9aL52G4ZO
         SXIaKcEgJ4aLW1vuywnEGGnUIa1L1PD4VTzZd037EZEoCeMjqEe1RvqcYMbPdIwzd6ex
         SLx5aWglrUbecbKg9y1NDIoI+huRFOsnTbRgfTi0X32z75sCV3hqrdU65/H/4oo/pTYf
         8fMrEWmuiuey/iQCvC7iE4Ht+h77WQEsUUPrzDN56tBRdfSDAa197lb8bdhwz+OkrMie
         /jCmINoAm+sHJv1PyjzA5shj4hLnwIJyQBqOmDGxPSRel0FIYwsbJKv4bilIZ4Ne4ZgV
         39rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452369; x=1758057169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtOqibUwz5tngZUvPo7icyfPskkpVVJBzNaUCRYuMOE=;
        b=dQ6CrV0FJTSw1aoKP8BPtM0P411CwdCTNzTewB3FFXKzpybiWJwzM/hcTkY0bcky/O
         NgSKHCLB+udjfEzCozhp5dphuNpNBf50lq9sc+K0nFpf4e6Dcb9TrLdybXil6T8yJYwg
         FfhnVaNtNeUbr2+WvpGAtCx1c/0hIm9cWQdQYAYESClUbJDHtlPkl6XX8RDm7p23J7EB
         eJ7ySElq7YMZA6LTjpsTKS+0q/GGsUhiGEykUZ/ZDwWKIi/+JY5a7FAMk1Ot9LJLXw6d
         JM4PfzNO3xtqwRuTH9MnogA9P0wKfkevxC++gHHFD/EVaw+EBSCnzSMnNiXDiDLg5W9X
         fXOw==
X-Forwarded-Encrypted: i=1; AJvYcCV3P4JFM9kQf6sH4BGNWGv8ZZnx+5xtyD/OZEGxP8R+J3CI6YypRo+L5jG4yKivElgEaZLcZ9Jca4C7H6jIEPZf@vger.kernel.org, AJvYcCWtRuDuEidgu6ZDwmiWgdOCkd17QwZqqwX7xahL9tNvj79oQIsNcr2NLAvdpkVWtlctyFZafHvo7JkBXfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzGVg7dCjU8cPlwUr883xlWO89h25MYEQ9cfUbyjXSFv5JC1b
	dOiI5pB9bxsu6Nl83PXmN11Gn7oysaawKWt9fiEcDcGjwP6KiPz7nJI8
X-Gm-Gg: ASbGncuqbQqJfbp+jUtFIFIs6tWjEBvGihrSwFyEDPT9s76wy+aMSbfvBw8saunT4IS
	JmVqxchOGzc1RYOaxyYVbCZwhC6D+BFiykrRIDVInUgEF5+2HIgAP3CfixuuvkluA/CgMItVor9
	aY4ONX+s2io0X3hGTCuLiHN97y/IsouLPg3F1/eiUh1skoGr0HplYZHUhpy+FpL/Wf1fE08lLzs
	fSsyxFFwcJ7VgrT4j0zNBdpKC2dXdA8cjF5vYwQUCNMO1WD3P6TwVeZxy8EsEJvSCyT6z84S8Uk
	kJMhOKUyg7ZDEtt3MieIuSt8chYi/zWnCL8kf481UaGKLacPb+3ssqmtCQ3YEBX1SxDkxr9FwKg
	HBh7zEp9BamGXEbUuixj1lUESmCE=
X-Google-Smtp-Source: AGHT+IF38s9lxfZU8G7P7mNg2kejHM6ZDeNW2psHHku97+fDx/sloeupxoCrsOVOWsnx59K9tuGcSg==
X-Received: by 2002:a05:6512:1589:b0:55f:3f25:f03d with SMTP id 2adb3069b0e04-56260e42ab1mr3957629e87.32.1757452368272;
        Tue, 09 Sep 2025 14:12:48 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fc9sm757025e87.9.2025.09.09.14.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:12:47 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Tue, 09 Sep 2025 22:12:16 +0100
Subject: [PATCH net-next 5/5] selftests: netconsole: validate target
 reactivation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-netcons-retrigger-v1-5-3aea904926cf@gmail.com>
References: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
In-Reply-To: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757452359; l=4794;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=65r5Q30rEGislckJZUxh/W9mjPAujYvYiGkilVFpCfc=;
 b=ymDJeSULC8JJf+tNqHagtFdnz6Op111esKWv7VDiuiVJdtJGfLQukER03uPfkXQBkvNur32Pg
 X49B70l7ur8BoQ5OywnjaGh6w9A4g3AfHystfjhb1nz6H/Z+4y+GmHg
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce a new netconsole selftest to validate that netconsole is able
to resume a deactivated target when the low level interface comes back.

The test setups the network using netdevsim, creates a netconsole target
and then remove/add netdevsim in order to bring the same interfaces
back. Afterwards, the test validates that the target works as expected.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 23 ++++++++
 .../selftests/drivers/net/netcons_resume.sh        | 68 ++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 984ece05f7f92e836592107ba4c692da6d8ce1b3..f47c4d57f7b4ce82b0b59bee4c87a9660819675e 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
+	netcons_resume.sh \
 	netpoll_basic.py \
 	ping.py \
 	queues.py \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 8e1085e896472d5c87ec8b236240878a5b2d00d2..ba7c865b1be3b60f53ea548aba269059ca74aee6 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -350,6 +350,29 @@ function check_netconsole_module() {
 	fi
 }
 
+function wait_target_state() {
+	local TARGET=${1}
+	local STATE=${2}
+	local FILENAME="${NETCONS_CONFIGFS}"/"${TARGET}"/"enabled"
+
+	if [ "${STATE}" == "enabled" ]
+	then
+		ENABLED=1
+	else
+		ENABLED=0
+	fi
+
+	if [ ! -f "$FILENAME" ]; then
+		echo "FAIL: Target does not exist." >&2
+		exit "${ksft_fail}"
+	fi
+
+	slowwait 2 sh -c 'test -n "$(grep '"'${ENABLED}'"' '"'${FILENAME}'"')"' || {
+		echo "FAIL: ${TARGET} is not ${STATE}." >&2
+		exit "${ksft_fail}"
+	}
+}
+
 # A wrapper to translate protocol version to udp version
 function wait_for_port() {
 	local NAMESPACE=${1}
diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
new file mode 100755
index 0000000000000000000000000000000000000000..7e8ea74821fffdac8be0c3db2f1aa7953b4d5bd5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
@@ -0,0 +1,68 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test validates that netconsole is able to resume a target that was
+# deactivated when its interface was removed.
+#
+# The test configures a netconsole dynamic target and then removes netdevsim
+# module to cause the interface to disappear. The test veries that the target
+# moved to disabled state before adding netdevsim and the interface back.
+#
+# Finally, the test verifies that the target is re-enabled automatically and
+# the message is received on the destination interface.
+#
+# Author: Andre Carvalho <asantostc@gmail.com>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+# The content of kmsg will be save to the following file
+OUTPUT_FILE="/tmp/${TARGET}"
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup EXIT
+
+# Create one namespace and two interfaces
+set_network
+# Create a dynamic target for netconsole
+create_dynamic_target
+
+# Remove low level module
+rmmod netdevsim
+# Target should be disabled
+wait_target_state "${TARGET}" "disabled"
+
+# Add back low level module
+modprobe netdevsim
+# Recreate namespace and two interfaces
+set_network
+# Target should be enabled again
+wait_target_state "${TARGET}" "enabled"
+
+# Listed for netconsole port inside the namespace and destination
+# interface
+listen_port_and_save_to "${OUTPUT_FILE}" &
+# Wait for socat to start and listen to the port.
+wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+# Send the message
+echo "${MSG}: ${TARGET}" > /dev/kmsg
+# Wait until socat saves the file to disk
+busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+# Make sure the message was received in the dst part
+# and exit
+validate_msg "${OUTPUT_FILE}"
+# kill socat in case it is still running
+pkill_socat
+
+exit "${ksft_pass}"

-- 
2.51.0


