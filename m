Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D666E23387F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jul 2020 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgG3ShY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jul 2020 14:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730275AbgG3ShW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jul 2020 14:37:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB60E2083B;
        Thu, 30 Jul 2020 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596134241;
        bh=F1AYrEcZ7mpD0EYEJHQ5gNlFCjBTpcbcw3WgaRKBGUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ey4XAGD1gH8xyBmOIPLVPVwtgpdy8kCTkGlP9rlY0ak+66cD/EchmZOJuzD8J/nHs
         MBMNzdyIm3+jEjSFqKYq8jfqnUNg9phyg11gUyvw9HGMhZYYIN7PECePhEqcrd2YOs
         B3tvkH+A7Ze0XD3JSmVYdsBB2Fgf+rB4nO2fYgaY=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/6] selftests: arm64: Add wrapper scripts for stress tests
Date:   Thu, 30 Jul 2020 19:09:19 +0100
Message-Id: <20200730180920.23527-6-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200730180920.23527-1-broonie@kernel.org>
References: <20200730180920.23527-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add wrapper scripts which invoke fpsimd-test and sve-test with several
copies per CPU such that the context switch code will be appropriately
exercised.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/fp/fpsimd-stress  | 60 +++++++++++++++++++
 tools/testing/selftests/arm64/fp/sve-stress   | 59 ++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100755 tools/testing/selftests/arm64/fp/fpsimd-stress
 create mode 100755 tools/testing/selftests/arm64/fp/sve-stress

diff --git a/tools/testing/selftests/arm64/fp/fpsimd-stress b/tools/testing/selftests/arm64/fp/fpsimd-stress
new file mode 100755
index 000000000000..781b5b022eaf
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/fpsimd-stress
@@ -0,0 +1,60 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2015-2019 ARM Limited.
+# Original author: Dave Martin <Dave.Martin@arm.com>
+
+set -ue
+
+NR_CPUS=`nproc`
+
+pids=
+logs=
+
+cleanup () {
+	trap - INT TERM CHLD
+	set +e
+
+	if [ -n "$pids" ]; then
+		kill $pids
+		wait $pids
+		pids=
+	fi
+
+	if [ -n "$logs" ]; then
+		cat $logs
+		rm $logs
+		logs=
+	fi
+}
+
+interrupt () {
+	cleanup
+	exit 0
+}
+
+child_died () {
+	cleanup
+	exit 1
+}
+
+trap interrupt INT TERM EXIT
+trap child_died CHLD
+
+for x in `seq 0 $((NR_CPUS * 4))`; do
+	log=`mktemp`
+	logs=$logs\ $log
+	./fpsimd-test >$log &
+	pids=$pids\ $!
+done
+
+# Wait for all child processes to be created:
+sleep 10
+
+while :; do
+	kill -USR1 $pids
+done &
+pids=$pids\ $!
+
+wait
+
+exit 1
diff --git a/tools/testing/selftests/arm64/fp/sve-stress b/tools/testing/selftests/arm64/fp/sve-stress
new file mode 100755
index 000000000000..24dd0922cc02
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/sve-stress
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2015-2019 ARM Limited.
+# Original author: Dave Martin <Dave.Martin@arm.com>
+
+set -ue
+
+NR_CPUS=`nproc`
+
+pids=
+logs=
+
+cleanup () {
+	trap - INT TERM CHLD
+	set +e
+
+	if [ -n "$pids" ]; then
+		kill $pids
+		wait $pids
+		pids=
+	fi
+
+	if [ -n "$logs" ]; then
+		cat $logs
+		rm $logs
+		logs=
+	fi
+}
+
+interrupt () {
+	cleanup
+	exit 0
+}
+
+child_died () {
+	cleanup
+	exit 1
+}
+
+trap interrupt INT TERM EXIT
+
+for x in `seq 0 $((NR_CPUS * 4))`; do
+	log=`mktemp`
+	logs=$logs\ $log
+	./sve-test >$log &
+	pids=$pids\ $!
+done
+
+# Wait for all child processes to be created:
+sleep 10
+
+while :; do
+	kill -USR1 $pids
+done &
+pids=$pids\ $!
+
+wait
+
+exit 1
-- 
2.20.1

