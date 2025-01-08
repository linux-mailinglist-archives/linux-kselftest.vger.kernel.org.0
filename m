Return-Path: <linux-kselftest+bounces-24060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15205A05A71
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBC51885913
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F331FCCEB;
	Wed,  8 Jan 2025 11:50:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318B1FC11C;
	Wed,  8 Jan 2025 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337047; cv=none; b=EKoqjWtDwNbj1FvLtEyDf3N8QUDKVSsJ6DNVb/5243O2WUVu6vK7kWz0JmwNWmI08ujoJS0Awy/rtyzYU7W5NFT2u0scIz9JY9xixgmGlwsG8K9z7yuvmsTAuraC1i89akcH1BbJ8zvZPfMfT5AggcFqV9Xm+cKiakDDOjKvovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337047; c=relaxed/simple;
	bh=FxHCTrtEmHlr3dDtmtGQco4f9/wDAlZQfRPrG20bCrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxjJlu8LPPEsToZKKnAh0zqcE3aSlUz3J6BPXlJWklf8VQ1o8lB9Yr6KaNp0lg0hLUTkdgRzdKLsg7g4YdTt+QsgXvxABgskVebGAHsuPCtHxuBk4677TeRF+5868Tmv+hQkY1wXZxPpJ2eLDkf9lzEnaYncodjyJhKF1P7SCFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa689a37dd4so533854366b.3;
        Wed, 08 Jan 2025 03:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337044; x=1736941844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJbpaWVafqwrrz+ZENkKDr5EG7mjxcdM072QuX4YMuo=;
        b=VY/TNxFC5NZlosi5ZJXgbSwG66Oy9AErQ6rK8hQs4wmQV+PI0r6RhRJZDuUhwe62+a
         QqVTAsfNWlpK+iQ0k3Xs9KgolvAuwqVb3Ve0O7jsDrv91MJ++amiDFK3g30LJ45+718a
         9NuDYJ9uLq+ssqMaxDqGkFOjq82dJa6UdATSFPiDFSNbp+pEiVZOMKp9aEJO6MBFmNjK
         Y6fezCyIeUIt1SfHwGQl5bLQUmllhAt3kYEuqQobfLdT5bTJcK4/8k47b0GUSMtrF0fQ
         aQvYH+11WTH2b79h6eT3JE4LeGFAVSIpyRXZSKD5u1VcrNYq9TXcK/pXEV3mHoMX57E2
         32rw==
X-Forwarded-Encrypted: i=1; AJvYcCW6FUehK7QzL0l4qVzeHM/Q/4rOLTBAAylCIFAkvRYlaYi4q+sYTZMZPkuapap/Q+CVTae7zEciTt9ZErpNJbO9@vger.kernel.org, AJvYcCXG7VJkKN1SYl1NG/fHyXUYnFuDRvTYxToBJzugIWawGOYJF8UAsetgvREIDiUY0DoIIo8zq7QW5tvulAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjhqbJf9QxfK/XFpdlDMC9quttPfdbVLwMDN/wWBVoPPf++v+
	wiB4QtEyk7YhHTSuPQhIgQRxlvC/jp7etCj96Hw7r6F/tXLHhQeakNYwxw==
X-Gm-Gg: ASbGnct9ukxvNLVBH25iFdLTxL4E8n6V8Un98lGWotYMgjlu5GPOiD87/Bw9PRHmUP3
	RDq+6N7XtShfJlDJeBrl4UGS54YpAqqYYh0P8/yK6om3SNPS7jbRazTwx9P7Kchl4K+Ojpol7vT
	mCMh0MgrVDVBs+bToS8FW/idkzkmgIzORb4fKuTH6dQEtKZKcxeqJSxQcfGb2XdsUUpsEyEBltA
	1C3lkplMqkQ2Pv1Z+vXZFaR7beG8q00iavXQODhvgbZ
X-Google-Smtp-Source: AGHT+IGakNtI4bbSXZ+97iyWdDz31MdnmCsTICCsbc+mlfNjy7LWX8mBCDxPvF0ejv6v1zPchbYH/g==
X-Received: by 2002:a17:906:f585:b0:aa6:7933:8b26 with SMTP id a640c23a62f3a-ab2ab6a8deamr162899666b.9.1736337043769;
        Wed, 08 Jan 2025 03:50:43 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c6dfsm25460691a12.37.2025.01.08.03.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:50:43 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 08 Jan 2025 03:50:28 -0800
Subject: [PATCH net-next v3 4/4] netconsole: selftest: verify userdata
 entry limit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-netcons_overflow_test-v3-4-3d85eb091bec@debian.org>
References: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
In-Reply-To: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4125; i=leitao@debian.org;
 h=from:subject:message-id; bh=FxHCTrtEmHlr3dDtmtGQco4f9/wDAlZQfRPrG20bCrc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnfmaK/oL+TEo0vdH3f7qL2qsiDS0LlxM+QiXYa
 a+AphiRc92JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ35migAKCRA1o5Of/Hh3
 bYb1D/9OiOlMTwUJSSQOGK0b8iQ2Cu4BW3XBxlDlKLkPgDZC+k+wc9NwdKfoh/DEUtHuaHMr7hM
 51yWAP2VCFy3/WwexQS8c09K7ZeovJCYn34V7rOEt6+cUdS0L2bMb+5PhiBG5v+7wnAYWz6HYuc
 Du14l8jPNCCp3cilVRG1UZnIe3V1GYB62w1E/ctn4UoM19BjHIy9GbtAbUkXS9mBmzzH6FHwSSC
 +SCJSL7UTq+9to0jzR20CDercbl8eIfSOhPjiOJWRm1v0Xdt8lzeDN1d8V1g/q1EZZY0EwtEzkg
 U2ICUoRyu9JxP6Vw22PO+Qq9cSgYPZINTHN7OuIhIv6AbEJWxCcHo4cR/kaQLP+v7tw140VRw1m
 RP2fdMnf4CSsO9Aq405rCXL/Q6eBNM0PjflJXpiDL3Zl2HGm5J9s47fOmzdy5XHVM27+WLnDzYU
 zQgQPfWdod2Q7jAuKFYSTwEaqYmvnvyscK6Uky6rlqadL71y8A7M/jLtsZC812cOyIP483qc/hH
 Kb15Vv7a+DB47JZEWBflAjYeZU4CROn9/QhBWLlasu6ENfLHLjNMQfkbQ+TAmwchBYiWAFkkjye
 xdIaOVCWV1lba/UzxMLavhrOnbNSv0c3VKhQQpVKiiWDCcbsuZgf5JOrER9F8glxisy50jzICjO
 YBGiau5Q+GrHdLA==
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
index d3cd4b7e48652b7a56873b840fd2ed6e12791008..44b560e3470ad612b60c7bf002152311bb419c72 100644
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
index dafff5d7fe88c82a1d27aa49faca728b52435ebc..469179c18935ffcc12b979ccdc9f84e9d4082b90 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -7,6 +7,7 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 
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


