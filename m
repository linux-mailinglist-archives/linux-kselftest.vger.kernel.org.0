Return-Path: <linux-kselftest+bounces-23867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CE2A00993
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 13:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE21641C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9011FAC5A;
	Fri,  3 Jan 2025 12:58:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65D1FAC31;
	Fri,  3 Jan 2025 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909104; cv=none; b=ueqRNNmYp6OfujN+y0xXXFMKopkIVWuNffsW7f2XVMiW9+md/1jhhuvlHB1PZ0Zmb48HYlKXhZf1qV3ETIzLJQeT5qlVQwgaH390+LC0oeyHtk3MMiTtekgUnqlfrXtYeXankU8fSbCJs0xMsN0dUBgERS62yVKv7Z/vWvqcpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909104; c=relaxed/simple;
	bh=j/d6IOIwcGaC9OHqLPuTe4vySvBHGxjJ9d3+kMRZ3vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pU2lhsAtFqtn+FEeCb9MYco6uUpTayh9thdsQIu1Q4oT3oXl18JV2wiEuS5+zDPBCvkWJnVj1aKd6JBnNFwbTneeRG3FV8TOQe3AIgjHZxUdSSCsJif9Vrz0u6y74NEafuJ+i5nMMCmzzXfaj27QOuCWAV+jDejlgRnPETUbnCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso21117659a12.2;
        Fri, 03 Jan 2025 04:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735909101; x=1736513901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ribTIMB9+dNnZKye+MGNDF+gCDhKrbL3cAGiX1697uw=;
        b=wfRywaTEYnFE4DwoFFDl2JcE2RCFk1zxKZNGBAypk2bUzniTnbyJHY7FPtWGDMB9uK
         Kv3QD7e3hhNvTHmsRab8CEbBaasYMxQWHbmVYElscP56PU5bnJXQGF/XKPrie/DdzKIB
         y/G8uPBJITPAQSTxx3/mjf5J5A7c+jxURiyAbg3Nv6WTuWL8QysfEMqxlW0KQi+q5A33
         U7XO5jJV1cPbVxgTDBejvCE7j4rqaPRsWJuW1Im7Eh9spLY/sBOTEjX5n56oadYCcy98
         QSHam3LzaE7yxtQEI2Ky7g3msOjrw8tqTB/9bcmCH/NW2UfQCfLnlfc8e1XeOhnvMSwb
         Yp5w==
X-Forwarded-Encrypted: i=1; AJvYcCV9IN8IvJ7fTFeNkNGVXfMvKnnBAaW8CdThe3EEzcoTG3dUviQh26hlyf3/s/6hQFZEcvP3IcPttL3SQkk=@vger.kernel.org, AJvYcCXQ5OEMoq38FbNBSVroQ7kGdy1Wn1+5zK18KY7FN364TcSKf+8XAfH4DLuQgP48MXXsrbX1AwoaAq3wy8Y2ylWx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jVv3cSNpr+FmVKKkCwiqV9dCgOFLQNEUzlkffD6UXLOLJor+
	JotgmpwqeNte4f9NdjT48kmwU3CEBDt8ZfC3EG2u4LU19MxYfX7+2sVmlA==
X-Gm-Gg: ASbGnctvnjWQyEpYj1bojz0UvrPCvjwzPsAgeiHVSbt1nz5ixZu7Z41KMJOtaR27zQI
	CTcPO9tBFQn7PUFvaQQE/3R1GLbQjKLnc4T3W2a1urBkSwQsseFfQdNM2ODskSTveR+0RdKUZzh
	Kat47r7alN/LXo4+QVA3NcBMeR70v8eILZgneDezE5kOOpdrUwuj3tfemFUXdWamTz8b3r+RMSy
	CTGVtOL2nXXAgPIeNyHba2BeqvVuB3acVrurwp8j3pLcuR7
X-Google-Smtp-Source: AGHT+IGXoOLlnSCol77Ouy97fOE/3hjW4YIr1G6KR5jqHhGzU7NTiyOWkR7lZOs/rQXoz9UMQMB0uA==
X-Received: by 2002:a05:6402:40c1:b0:5d0:e3fa:17ca with SMTP id 4fb4d7f45d1cf-5d81ddfdd7fmr41236836a12.15.1735909100493;
        Fri, 03 Jan 2025 04:58:20 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a71fsm19364962a12.18.2025.01.03.04.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 04:58:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Jan 2025 04:57:52 -0800
Subject: [PATCH net-next v2 4/4] netconsole: selftest: verify userdata
 entry limit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-netcons_overflow_test-v2-4-a49f9be64c21@debian.org>
References: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
In-Reply-To: <20250103-netcons_overflow_test-v2-0-a49f9be64c21@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4125; i=leitao@debian.org;
 h=from:subject:message-id; bh=j/d6IOIwcGaC9OHqLPuTe4vySvBHGxjJ9d3+kMRZ3vY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnd97i1fNFFHR5UlGtanDQc7lY/3RDoJje4pnAo
 S5mqo9eJzeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ3fe4gAKCRA1o5Of/Hh3
 bXKND/9XqnxRlCpX0HH/PJG2BEDc/qCdp6A9dZf258qWwHT8JiFEtM+6iu2pfMdP3i1gR8nhD6A
 nAhjEXaDEuXiwgmzho9cACEJKa66jx0TTWZMtx3LPULCL2BDPROY+SwH1ale9RM0RkbQD1YNXO3
 fRKK+dOtPQ3e49OfoEeAAmrvK2vYpBgehevBC9j5fCv/0yiGIlbQ3z16t1kFONyCq6feVNtlr5n
 cnwR0nsC4j6enZUdVBJ6H7uR7EKiWCnbuouMqsHBg+gbpyN1m5YuZ6490Jn19Jp5h5jbUYW1uX6
 mhHZJijjkhNDGOHjGX3L2uY14LKmQVngkjDRJOoshTiOCNL/GaWRfBmt3DsGDyscNp9V6UJBx4y
 odPJZgSnJ/v+6iEsdFGjrSFUzQeb9t6BoiU6oeoqmXqxntuG1KFzLeKq7EgllvLT7KNLm94d1ta
 ShB/51dopG5q9OsDepQNyEF9RjBgkMlAJht06W99x2Ez8cDvTomMncY1ztPwkievzdkjNkR/xrd
 qiPKdGyZoujb2dqtjb2RKKCGwD43YcpGM1Qnx433O4dj9UI0VojAz4m1TDsRaJIohLKJZdGpVx7
 eGPM3I5UTb1JloSqfAlI2iYvQwMcoVBO6C0iMIVBEIngYSCo6vMb5m53EyiF+JHq8UCJFOP2CFh
 yh1oqtxH54xO4ug==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new selftest for netconsole that tests the userdata entry limit
functionality. The test performs two key verifications:

1. Create MAX_USERDATA_ITEMS (16) userdata entries successfully
2. Confirm that attempting to create an additional userdata entry fails

The selftest script uses the netcons library and checks the behavior
by attempting to create entries beyond the maximum allowed limit.

Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS                                        |  2 +-
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/netcons_overflow.sh      | 67 ++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7af1c38dbab0c1ac253ced11a07ee7422c75c0a..d14bfb5ab0122f0b6651e72add3b178dcf742f18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16175,7 +16175,7 @@ S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c
 F:	tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
-F:	tools/testing/selftests/drivers/net/netcons_basic.sh
+F:	tools/testing/selftests/drivers/net/netcons\*
 
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 0fec8f9801ad4d94d99ab6d0acaea6e2e7b2894d..bcd630eb072eb9cf22bb11a647de751795de2408 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -6,6 +6,7 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 
 TEST_PROGS := \
 	netcons_basic.sh \
+	netcons_overflow.sh \
 	ping.py \
 	queues.py \
 	stats.py \
diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh
new file mode 100755
index 0000000000000000000000000000000000000000..29bad56448a24a2d98c21bd53b74f3bc2ca7e64a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_overflow.sh
@@ -0,0 +1,67 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test verifies that users can successfully create up to
+# MAX_USERDATA_ITEMS userdata entries without encountering any failures.
+#
+# Additionally, it tests for expected failure when attempting to exceed this
+# maximum limit.
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+# This is coming from netconsole code. Check for it in drivers/net/netconsole.c
+MAX_USERDATA_ITEMS=16
+
+# Function to create userdata entries
+function create_userdata_max_entries() {
+	# All these keys should be created without any error
+	for i in $(seq $MAX_USERDATA_ITEMS)
+	do
+		# USERDATA_KEY is used by set_user_data
+		USERDATA_KEY="key"${i}
+		set_user_data
+	done
+}
+
+# Function to verify the entry limit
+function verify_entry_limit() {
+	# Allowing the test to fail without exiting, since the next command
+	# will fail
+	set +e
+	mkdir "${NETCONS_PATH}/userdata/key_that_will_fail" 2> /dev/null
+	ret="$?"
+	set -e
+	if [ "$ret" -eq 0 ];
+	then
+		echo "Adding more than ${MAX_USERDATA_ITEMS} entries in userdata should fail, but it didn't" >&2
+		ls "${NETCONS_PATH}/userdata/" >&2
+		exit "${ksft_fail}"
+	fi
+}
+
+# ========== #
+# Start here #
+# ========== #
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup EXIT
+# Create one namespace and two interfaces
+set_network
+# Create a dynamic target for netconsole
+create_dynamic_target
+# populate the maximum number of supported keys in userdata
+create_userdata_max_entries
+# Verify an additional entry is not allowed
+verify_entry_limit
+exit "${ksft_pass}"

-- 
2.43.5


