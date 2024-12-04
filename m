Return-Path: <linux-kselftest+bounces-22836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E549E3FE6
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 17:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D60164FD7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115B420E032;
	Wed,  4 Dec 2024 16:41:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91020D508;
	Wed,  4 Dec 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330466; cv=none; b=pBwZGrZl5aBhkuR4OXpEI0RdgQBYJTnOOG2fh6CYqNrDuy7IqR5Yj5IFAYVb95tUoPn+efocdYmlm7fiC7GERbB5yShDj0560pueDwiuc1rHKKKaGPzhpbw9VCnfhGglwiXPuK8o7Rt4Vo+CMxffvWQoQxUKvr1+XKV4AxNltmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330466; c=relaxed/simple;
	bh=YomcDZLsGkHJ93XYiHcO82QDo1w9Pr3neNOGqdenPeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAC/qx6hqoA7pEAx/sCw4cosuyhadaUhZ7wz4GeBthlW2Y9BLx5iwh4f96iM0GTD4hTc/Fk97m1MSQYwUK4dLugS9cOVYi0Fu5qOvcZXH4xYtdsNGji5IY3MyJQN8Sa+BVEmXMWmCtd1v67rBzqNBF/tGtqEWc9aUDKR5ZeeUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa55da18f89so1044166566b.0;
        Wed, 04 Dec 2024 08:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330462; x=1733935262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp5LZ1kxAlRspYk7ziqigDfPMTtHysD3G76P4O98mfc=;
        b=PCg2it7Dy+DB+dUV3p/njBpA4e/D3QDvI+2anX49f44whHDsrPGwNrzbo4gUhwZf9Q
         gvRltYJvX7zGEzpSRQsQ9r7cF7EvHHHcQJgqJng3q2/5OxP04hhEvznNg5maIpgP8qyK
         EpBwxPdTUBqZrZ1vtwm2/PXu5wj+0ZnE8fj6Ukij0Pan8KzVuTo+vE95rsLOBwsdZv6E
         9ezBGbIB8bEDXS805oTLj89OtVtOR2mpFoYbyC+PYkXwi8YF7kzE2B6K8gWzH56QaFh/
         1SoWnNx7hLFbahT74tRivPlmdKiDO/dyzHVadoRQ6fHqMPPgeUvafxpC1Jacv9vFDNcV
         6aTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKtaGkjHvq1uEOi1X8kjCamcFd+ZS3SAKoh8bX83Fp1OvQDwSZqaxaZn8inWM7FTYn0Ta589nEW4wrcXmxRvEe@vger.kernel.org, AJvYcCViXz/fMTtCLi7q+MKOVMQBu32gPE2f50/Umya6LRkAGvsHESo8gCumwm5vzitDaFLqTYfdtcJrtlkJyEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/CJJUkLgqqfnmx7BZ1sTgh3v64AZWLbK5v2UZlIEeKOkOmw+w
	7U+TPvxjf1RbYAX38/D+8LiGkp0ThTHXmA2lgPoH0zQU0UYtS16j
X-Gm-Gg: ASbGncv8Aqf1mY1UCxn4FjgzLq7HvcT49n4cdtle/BewoXMy4eEArst3mV893eZVilO
	jpmWsoStmWaMsQzbWhpVPSY9TbZRI3egW7VfOGiU34IkFddrpymuK9ZKBiIk5k15ByLeGXNYvCQ
	76zRl9WGJl1JX/2IiUdiU7c4oExjd0V9txaKjCIUlxIjHPwpON6I71MBwTltl3LN+0GI3550v0n
	RD1dBUA39K3IIWAtS4uvHTrQ1hm2T2qzvjwUDYDU7C8V7DyLBxRvd+85J37LCSprw1yi5jnWQjh
	lQ==
X-Google-Smtp-Source: AGHT+IHO0yNu3MoObM3YmZd7Bqm+/kY4WR82IcRqXNzewqckpka6AEx2/xT8dMOgvIORsma2yOwlbg==
X-Received: by 2002:a17:906:cc9:b0:a99:e939:d69e with SMTP id a640c23a62f3a-aa5f7f35a67mr507569266b.51.1733330462155;
        Wed, 04 Dec 2024 08:41:02 -0800 (PST)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6a1asm750102766b.98.2024.12.04.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:41:01 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 04 Dec 2024 08:40:45 -0800
Subject: [PATCH net-next 4/4] netconsole: selftest: verify userdata entry
 limit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-netcons_overflow_test-v1-4-a85a8d0ace21@debian.org>
References: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
In-Reply-To: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3502; i=leitao@debian.org;
 h=from:subject:message-id; bh=YomcDZLsGkHJ93XYiHcO82QDo1w9Pr3neNOGqdenPeA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnUIYVHQTBNZj7dFIHe4XblV2VV/QByfF5NQGkt
 ioydQXukr6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ1CGFQAKCRA1o5Of/Hh3
 bXPUEACn4DPPvEGE3XTGBPu/ibwdBM9YYUMy4lUVQ76eZv7QVfrRDLG7AbwUbLHhndQVsvqoPG8
 bmykl0uRhspf0MNB+ugX9BfaQM8BvVnAxGhj/DbFvYdxs+gVAdJfujiXEG7axVPhsN4maoOsijw
 Vu51P9JfcO2jp84IO2Oj3noIqJQ9dzIXPQYHo9mBqZqzm+tRdUOF6yCVz7ZxRGerasSnpvMszML
 O6qCCQOXjlKd3ZxqtnuF1wbmvfMFizzAqX5ITp7/ZSMAuyua3AZ9GTjw3TLhEzlAzRhsdEH8Eni
 mIbqLz+aRCP5proEVnkc1AlHLZhr1ZLpEgLuguwEg67jdjpaq/U8ALZvpt+b1b5E9is6ck/YYI1
 arL9sEeLn/xZdwOk8c9/NlZDbkjKJ7UCnvydjgOtQhvqtlq++ToEgfWkgRsQ01LhmKmX9NQTJEC
 0eJ+zV1CU6tDSXTzJm8qtYnbbaW5UbsEnZYirIx6glEdGsECFP3PCU0fms0CsbHwecHFF4HzUU9
 ceR05gJsUk0KFSiMuAPW2EyFxeM5ilQS2HBqguiAVR1C8Z9GiQIRUmjaL83gDIjukGWG4oPy8YB
 ZGv5ODoPSQj2qRxvhYVRu1k2/lpxvMk30b7pvin2nViDOE8yTPtsHSHendgFLDiykYQXSodG1TP
 aFbCj1R8O7Xpv5w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new selftest for netconsole that tests the userdata entry limit
functionality. The test performs two key verifications:

1. Create MAX_USERDATA_ITEMS (16) userdata entries successfully
2. Confirm that attempting to create an additional userdata entry fails

The selftest script uses the netcons library and checks the behavior
by attempting to create entries beyond the maximum allowed limit.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 MAINTAINERS                                        |  2 +-
 .../selftests/drivers/net/netcons_overflow.sh      | 67 ++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8af5c9a28e68c4b6a785e2e6b82db20b3cf59822..62192db4641a4056d1eab911f5c141fb37eaed36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16092,7 +16092,7 @@ S:	Maintained
 F:	Documentation/networking/netconsole.rst
 F:	drivers/net/netconsole.c
 F:	tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
-F:	tools/testing/selftests/drivers/net/netcons_basic.sh
+F:	tools/testing/selftests/drivers/net/netcons\*
 
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh
new file mode 100755
index 0000000000000000000000000000000000000000..a19f613553578dc185b7332a827463d9b0c6685f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_overflow.sh
@@ -0,0 +1,67 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+#  This test verifies that users can successfully create up to
+#  MAX_USERDATA_ITEMS userdata entries without encountering any failures.
+#
+#  Additionally, it tests for expected failure when attempting to exceed this
+#  maximum limit.
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


