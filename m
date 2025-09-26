Return-Path: <linux-kselftest+bounces-42455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBC9BA3392
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76684C4365
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702B12BEC3F;
	Fri, 26 Sep 2025 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqQxqwY/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0502BE024
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880012; cv=none; b=i53GmBSXy6Y616zWu2whA5X18DLH1BQAuKffBxJXsMjoO20o2LB9GZFkeD7l8xmBZAuUc7brCgMw5WCUjd+bOqpAMQtn9Z0BrQY4EnngeEzFreMQUAOf5O6VTM6+OmAQu2C4eDgqr7gpM41A2OCIiKtC2TR/KHm9wl38LDBAIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880012; c=relaxed/simple;
	bh=g5J992IN2mgxgUIBVLwgJ5g2OHzfg+nnrAKR9SC27B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xbzyw1Gr47a2gMY4Jf02FYRnPCaBYf24uqiVB2ZsoD/afqWQaG4F9xw3UusVC8YOo7AkP+zOaAVJdRut346SA2bmLq9G1EpStfvNiyMS7Fg5AWoERPtJKlUq3OVLecZUSJswVe2BkApzohtdSQbkKYGDzVaiMayhSkvTXcpj0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqQxqwY/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758880009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Da40y88KmGAqhR/u2ItWMYyOAktUUmdNXmRD+2pQK0o=;
	b=BqQxqwY/jIXgazsAATIBFWksXi6tVhh2H8MpCLPpVGNme5TPwcGx8o6H8cp8KZ1p9tMGE9
	r3zIpmi0hAKqevk4N/TDQ9m2xKibLU3RE5ySkL+RSdLy3v00W8x5HuAfjD2Wzi7XTxZH7g
	9SM85Q2VZBNEgrw8942hNjgYzqhXcU4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-FZZMCIJDOjyv7L06qAgbJg-1; Fri,
 26 Sep 2025 05:46:45 -0400
X-MC-Unique: FZZMCIJDOjyv7L06qAgbJg-1
X-Mimecast-MFC-AGG-ID: FZZMCIJDOjyv7L06qAgbJg_1758880003
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B371F19774D9;
	Fri, 26 Sep 2025 09:46:43 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.225.225])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F4991800446;
	Fri, 26 Sep 2025 09:46:38 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Waylon Cude <wcude@redhat.com>
Subject: [PATCH 2/2] selftests/verification: Add initial RV tests
Date: Fri, 26 Sep 2025 11:46:13 +0200
Message-ID: <20250926094613.34030-3-gmonaco@redhat.com>
In-Reply-To: <20250926094613.34030-1-gmonaco@redhat.com>
References: <20250926094613.34030-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a series of tests to validate the RV tracefs API and basic
functionality.

* available monitors:
    Check that all monitors (from the monitors folder) appear as
    available and have a description. Works with nested monitors.

* enable/disable:
    Enable and disable all monitors and validate both the enabled file
    and the enabled_monitors. Check that enabling container monitors
    enables all nested monitors.

* reactors:
    Set all reactors and validate the setting, also for nested monitors.

* wwnr with printk:
    wwnr is broken on purpose, run it with a load and check that the
    printk reactor works. Also validate disabling reacting_on or
    monitoring_on prevents reactions.

These tests use the ftracetest suite.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 MAINTAINERS                                   |  1 +
 .../testing/selftests/verification/.gitignore |  2 +
 tools/testing/selftests/verification/Makefile |  8 ++
 tools/testing/selftests/verification/config   |  1 +
 tools/testing/selftests/verification/settings |  1 +
 .../selftests/verification/test.d/functions   | 39 ++++++++++
 .../test.d/rv_monitor_enable_disable.tc       | 75 +++++++++++++++++++
 .../verification/test.d/rv_monitor_reactor.tc | 68 +++++++++++++++++
 .../test.d/rv_monitors_available.tc           | 18 +++++
 .../verification/test.d/rv_wwnr_printk.tc     | 29 +++++++
 .../verification/verificationtest-ktap        |  8 ++
 11 files changed, 250 insertions(+)
 create mode 100644 tools/testing/selftests/verification/.gitignore
 create mode 100644 tools/testing/selftests/verification/Makefile
 create mode 100644 tools/testing/selftests/verification/config
 create mode 100644 tools/testing/selftests/verification/settings
 create mode 100644 tools/testing/selftests/verification/test.d/functions
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitors_available.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
 create mode 100644 tools/testing/selftests/verification/verificationtest-ktap

diff --git a/MAINTAINERS b/MAINTAINERS
index 520fb4e379a3..50e2e99e8c0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22059,6 +22059,7 @@ F:	Documentation/trace/rv/
 F:	include/linux/rv.h
 F:	include/rv/
 F:	kernel/trace/rv/
+F:	tools/testing/selftests/verification/
 F:	tools/verification/
 
 RUST
diff --git a/tools/testing/selftests/verification/.gitignore b/tools/testing/selftests/verification/.gitignore
new file mode 100644
index 000000000000..2659417cb2c7
--- /dev/null
+++ b/tools/testing/selftests/verification/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+logs
diff --git a/tools/testing/selftests/verification/Makefile b/tools/testing/selftests/verification/Makefile
new file mode 100644
index 000000000000..aa8790c22a71
--- /dev/null
+++ b/tools/testing/selftests/verification/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+all:
+
+TEST_PROGS := verificationtest-ktap
+TEST_FILES := test.d settings
+EXTRA_CLEAN := $(OUTPUT)/logs/*
+
+include ../lib.mk
diff --git a/tools/testing/selftests/verification/config b/tools/testing/selftests/verification/config
new file mode 100644
index 000000000000..43072c1c38f4
--- /dev/null
+++ b/tools/testing/selftests/verification/config
@@ -0,0 +1 @@
+CONFIG_RV=y
diff --git a/tools/testing/selftests/verification/settings b/tools/testing/selftests/verification/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/verification/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/verification/test.d/functions b/tools/testing/selftests/verification/test.d/functions
new file mode 100644
index 000000000000..ec36a092f56e
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/functions
@@ -0,0 +1,39 @@
+check_requires() { # Check required files, monitors and reactors
+	for i in "$@" ; do
+		p=${i%:program}
+		m=${i%:monitor}
+		r=${i%:reactor}
+		if [ $p != $i ]; then
+			if ! which $p ; then
+				echo "Required program $p is not found."
+				exit_unresolved
+			fi
+		elif [ $m != $i ]; then
+			if ! grep -wq $m available_monitors ; then
+				echo "Required monitor $m is not configured."
+				exit_unsupported
+			fi
+		elif [ $r != $i ]; then
+			if ! grep -wq $r available_reactors ; then
+				echo "Required reactor $r is not configured."
+				exit_unsupported
+			fi
+		elif [ ! -e $i ]; then
+			echo "Required feature interface $i doesn't exist."
+			exit_unsupported
+		fi
+	done
+}
+
+initialize_system() { # Reset RV to initial-state
+	echo > enabled_monitors
+	for m in monitors/*; do
+		echo nop > $m/reactors || true
+	done
+	echo 1 > monitoring_on
+	echo 1 > reacting_on || true
+}
+
+finish_system() {
+	initialize_system
+}
diff --git a/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc b/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
new file mode 100644
index 000000000000..f29236defb5a
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
@@ -0,0 +1,75 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test monitor enable/disable
+
+test_simple_monitor() {
+    local monitor="$1"
+    local prefix="$2" # nested monitors
+
+    echo 1 > "monitors/$prefix$monitor/enable"
+    grep -q "$monitor$" enabled_monitors
+
+    echo 0 > "monitors/$prefix$monitor/enable"
+    ! grep -q "$monitor$" enabled_monitors
+
+    echo "$monitor" >> enabled_monitors
+    grep -q 1 "monitors/$prefix$monitor/enable"
+
+    echo "!$monitor" >> enabled_monitors
+    grep -q 0 "monitors/$prefix$monitor/enable"
+}
+
+test_container_monitor() {
+    local monitor="$1"
+	local nested
+
+    echo 1 > "monitors/$monitor/enable"
+    grep -q "^$monitor$" enabled_monitors
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        grep -q "^$monitor:$nested$" enabled_monitors
+    done
+	test -n "$nested"
+
+    echo 0 > "monitors/$monitor/enable"
+    ! grep -q "^$monitor$" enabled_monitors
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        ! grep -q "^$monitor:$nested$" enabled_monitors
+    done
+
+    echo "$monitor" >> enabled_monitors
+    grep -q 1 "monitors/$monitor/enable"
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        grep -q "^$monitor:$nested$" enabled_monitors
+    done
+
+    echo "!$monitor" >> enabled_monitors
+    grep -q 0 "monitors/$monitor/enable"
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+		test_simple_monitor "$nested" "$monitor/"
+    done
+}
+
+for monitor_dir in monitors/*; do
+    monitor=$(basename "$monitor_dir")
+
+    if find "$monitor_dir" -mindepth 1 -type d | grep -q .; then
+        test_container_monitor "$monitor"
+    else
+        test_simple_monitor "$monitor"
+    fi
+done
+
+! echo non_existent_monitor > enabled_monitors
+! grep -q "^non_existent_monitor$" enabled_monitors
diff --git a/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc b/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
new file mode 100644
index 000000000000..2958bf849338
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
@@ -0,0 +1,68 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test monitor reactor setting
+# requires: available_reactors
+
+test_monitor_reactor() {
+    local monitor="$1"
+    local prefix="$2" # nested monitors
+
+    while read -r reactor; do
+        [ "$reactor" = nop ] && continue
+
+        echo "$reactor" > "monitors/$prefix$monitor/reactors"
+        grep -q "\\[$reactor\\]" "monitors/$prefix$monitor/reactors"
+    done < available_reactors
+
+    echo nop > "monitors/$prefix$monitor/reactors"
+    grep -q "\\[nop\\]" "monitors/$prefix$monitor/reactors"
+}
+
+test_container_monitor() {
+    local monitor="$1"
+	local nested
+
+    while read -r reactor; do
+        [ "$reactor" = nop ] && continue
+
+        echo "$reactor" > "monitors/$monitor/reactors"
+        grep -q "\\[$reactor\\]" "monitors/$monitor/reactors"
+
+        for nested_dir in "monitors/$monitor"/*; do
+            [ -d "$nested_dir" ] || continue
+            nested=$(basename "$nested_dir")
+            grep -q "\\[$reactor\\]" "monitors/$monitor/$nested/reactors"
+        done
+    done < available_reactors
+	test -n "$nested"
+
+    echo nop > "monitors/$monitor/reactors"
+    grep -q "\\[nop\\]" "monitors/$monitor/reactors"
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        grep -q "\\[nop\\]" "monitors/$monitor/$nested/reactors"
+    done
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        test_monitor_reactor "$nested" "$monitor/"
+    done
+}
+
+for monitor_dir in monitors/*; do
+    monitor=$(basename "$monitor_dir")
+
+    if find "$monitor_dir" -mindepth 1 -type d | grep -q .; then
+        test_container_monitor "$monitor"
+    else
+        test_monitor_reactor "$monitor"
+    fi
+done
+
+monitor=$(ls /sys/kernel/tracing/rv/monitors -1 | head -n 1)
+test -f "monitors/$monitor/reactors"
+! echo non_existent_reactor > "monitors/$monitor/reactors"
+! grep -q "\\[non_existent_reactor\\]" "monitors/$monitor/reactors"
diff --git a/tools/testing/selftests/verification/test.d/rv_monitors_available.tc b/tools/testing/selftests/verification/test.d/rv_monitors_available.tc
new file mode 100644
index 000000000000..e6a4a1410690
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_monitors_available.tc
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Check available monitors
+
+for monitor_dir in monitors/*; do
+    monitor=$(basename "$monitor_dir")
+
+    grep -q "^$monitor$" available_monitors
+    grep -q . "$monitor_dir"/desc
+
+    for nested_dir in "$monitor_dir"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+
+        grep -q "^$monitor:$nested$" available_monitors
+		grep -q . "$nested_dir"/desc
+    done
+done
diff --git a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
new file mode 100644
index 000000000000..bc0b2668bf7c
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test wwnr monitor with printk reactor
+# requires: available_reactors wwnr:monitor printk:reactor stress-ng:program
+
+load() { # returns true if there was a reaction
+	local lines_before
+	lines_before=$(dmesg | wc -l)
+	stress-ng --cpu-sched 2 --timer 2 -t 5 -q
+	dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr does not allow event"
+}
+
+echo 1 > monitors/wwnr/enable
+echo printk > monitors/wwnr/reactors
+
+load
+
+echo 0 > monitoring_on
+! load
+echo 1 > monitoring_on
+
+load
+
+echo 0 > reacting_on
+! load
+echo 1 > reacting_on
+
+echo nop > monitors/wwnr/reactors
+echo 0 > monitors/wwnr/enable
diff --git a/tools/testing/selftests/verification/verificationtest-ktap b/tools/testing/selftests/verification/verificationtest-ktap
new file mode 100644
index 000000000000..18f7fe324e2f
--- /dev/null
+++ b/tools/testing/selftests/verification/verificationtest-ktap
@@ -0,0 +1,8 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ftracetest-ktap: Wrapper to integrate ftracetest with the kselftest runner
+#
+# Copyright (C) Arm Ltd., 2023
+
+../ftrace/ftracetest -K -v --rv ../verification
-- 
2.51.0


