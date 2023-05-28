Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6EE713B2F
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 19:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjE1RgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 13:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjE1RgO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 13:36:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3FDF
        for <linux-kselftest@vger.kernel.org>; Sun, 28 May 2023 10:36:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ab87a1897so1437655f8f.1
        for <linux-kselftest@vger.kernel.org>; Sun, 28 May 2023 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685295364; x=1687887364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3hOp7A+/gdKa6ceniwP9XCSV18QbyWs0ktuK5d8pCE=;
        b=ARSKmT8Ji7mM694G9E9aohgiCCCxneu6cztqGv5MbAuZ+/k+fo3TYqQ+ingoTubU0t
         jO9+Tv+TzYWk5unmVa8Df20sZFMen9ZdLvBVzRg2mmAjveVqMUYcwL3i4ZXLnUliamoz
         vNLmDrv7sMsMEU/lcbvzCLFDNPF/k9Tn4AtFwdDjFVT4nAmGU9/awBD+BGrEsNPR2Brt
         KajrCx/dcKuOgML/dYwpf0dJPVRxX/WSRBgjZNE1DIwnTlQXxkXwJcPxCyKzDys6qg+q
         qcUSZrfzISyWEjbP0rUMB6prjGyOt0n4NQnr+PyYVLHOtdaphx+769Ft4afpdnb5Ec3z
         nzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685295364; x=1687887364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3hOp7A+/gdKa6ceniwP9XCSV18QbyWs0ktuK5d8pCE=;
        b=YpCdQyCl1W07YuhVABQK0RJiSZ7VXHxtWYeB0MvmmX4RRxByOVMJ6sPAAB8NU22vPT
         pgGXMrPiTcksj3I66Dj60T8FIt3fDTZkR5IFj6z6SjdycCctg/tLNjGoaI6pM3yqXTUC
         7uL26A/XzNL7CGpKePo6/UvYzVrk70jDrBWi2XWkKRGVCBzRYz0qgsr2j/hnAsBJ+q20
         Ea9wwdORpS22Jb6sKSztcPXYN/EGCIrKhVrnTqjeLXb89W88WS9jNgLFgKBUYE7mCqYN
         2hE64Bl8vHFWBhD32zJmiwiOcZp1U+JIekwWlHxzX5yTg8mAdfTmpAK5go+5+9u9wtzu
         2C/A==
X-Gm-Message-State: AC+VfDwnUa4rV+3WUKEFKry9x68/2S0utfyYzkI3bsnHtGobikEHgOZi
        rR7QZekwGNuVAfL/OKElVAL/uQ==
X-Google-Smtp-Source: ACHHUZ4ZQAV+j4Tdad+xRQQincCNDyTI7LzTsbLia8AtIt4fL/eD5QTDAJ+lyHCtuvtMb4o93rtv5w==
X-Received: by 2002:adf:fd8d:0:b0:30a:dff0:7bac with SMTP id d13-20020adffd8d000000b0030adff07bacmr6083933wrr.30.1685295364602;
        Sun, 28 May 2023 10:36:04 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f602e2b653sm15334523wmk.28.2023.05.28.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 10:36:04 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sun, 28 May 2023 19:35:27 +0200
Subject: [PATCH net 2/8] selftests: mptcp: connect: skip if MPTCP is not
 supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-2-a32d85577fc6@tessares.net>
References: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
In-Reply-To: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christoph Paasch <cpaasch@apple.com>,
        Florian Westphal <fw@strlen.de>,
        Davide Caratti <dcaratti@redhat.com>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3373;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=nA2G9Gp6t/Qi7hdZXemZ3CUHfQrooppvVjw4SfeTdgM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkc5EAjivNWBqEV1EeGg+AXKQ47OeysRwmBS9Wo
 Dx5NgDv59+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHORAAAKCRD2t4JPQmmg
 czpkEADvdWy4AgG9umn2F8syDixF6Zv7mtOEVs+4v1yt3GBqmSmoBrbk8xiXb+p7wSu3HbXMNaT
 MOUgvPnvbC3Mbz/1f4U6kIF7rl4s5qwY5BVMmE4Jk0+IEtxJosaHkf/LFG2M4RAAXznVQh7Mqmz
 XJyC+U2zOSYFb5WTz1mDerVQ9l8VvCrwCrRGQhwfpPnmkcl24AKMfZ9/62O4nZM98PHdRfiA4tG
 kz8My0w8R2hcWBYN48dEv+P0xUH9vPFg1v2fEQIZGMrgMVX1pH5+0/nC68zfHUqBM/q+P1C0PYW
 mr8SDROB9k+xVkd3KPgYNHMn/cogQncuAlELwjS4ngCw112/XoQbBCu8vRZcJQvRWu8X/0IfvOk
 iH7viP9+KWiAg54dvNOsCzIwYTs74do60FAknvovLtoQzkplZHQLOgE4CRL2vvHTWQVS8kRhYJk
 /vnQl3Z0cSmewYNjYCSaCaI6HUN1rM8rvYeLpH6EzF+++NJA50/m3amzYHJGmtAkvfjFrWUYL1h
 cEcLEQF7qkwmER/fct4kDrcpAERTEbfPhwdZ8eAt3mual6gNWl6AosRglPN5ilSvX61toYeqaXT
 0Q4TQnYmSZgm6FJWQIE4mVSH+xyGUNp4NVgdgAZgZJxwwQQHfsr9hMTaJvzMEaGTxJ4K49mLcpR
 jaZvUWoMLGk99mQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped". Note that this check can also
mark the test as failed if 'SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES' env
var is set to 1: by doing that, we can make sure a test is not being
skipped by mistake.

A new shared file is added here to be able to re-used the same check in
the different selftests we have.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/Makefile         |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  4 +++
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 40 ++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 43a723626126..7b936a926859 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -9,7 +9,7 @@ TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
-TEST_FILES := settings
+TEST_FILES := mptcp_lib.sh settings
 
 EXTRA_CLEAN := *.pcap
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a43d3e2f59bb..c1f7bac19942 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
@@ -141,6 +143,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
new file mode 100644
index 000000000000..3286536b79d5
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+readonly KSFT_FAIL=1
+readonly KSFT_SKIP=4
+
+# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
+# features using the last version of the kernel and the selftests to make sure
+# a test is not being skipped by mistake.
+mptcp_lib_expect_all_features() {
+	[ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
+}
+
+# $1: msg
+mptcp_lib_fail_if_expected_feature() {
+	if mptcp_lib_expect_all_features; then
+		echo "ERROR: missing feature: ${*}"
+		exit ${KSFT_FAIL}
+	fi
+
+	return 1
+}
+
+# $1: file
+mptcp_lib_has_file() {
+	local f="${1}"
+
+	if [ -f "${f}" ]; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${f} file not found"
+}
+
+mptcp_lib_check_mptcp() {
+	if ! mptcp_lib_has_file "/proc/sys/net/mptcp/enabled"; then
+		echo "SKIP: MPTCP support is not available"
+		exit ${KSFT_SKIP}
+	fi
+}

-- 
2.39.2

