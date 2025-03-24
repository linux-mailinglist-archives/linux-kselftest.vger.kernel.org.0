Return-Path: <linux-kselftest+bounces-29720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB99A6E6DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4EB1895054
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B304E1F0E5C;
	Mon, 24 Mar 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCSA81k3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF451F03DA;
	Mon, 24 Mar 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856652; cv=none; b=qmSAS9lXNQY1FTAi0x2uB+oq+W/VJYZXpSTQ43GA65HRQGh78PhNsKjuzyOzXotmtIAomLT57Nl5KQaymnIfIawLxxuHwC3HQ8zK354UmObrov7Gn4ndly8QSflhn/AHOMTwSDoS/i0LE6lW8odNda1ChqYU01dknoeUIXrZSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856652; c=relaxed/simple;
	bh=nyvrbNgCdVC75BFn1aJkMtslxrzManeApmITngvXPQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4Gdu8C3toKy0Rk1SpwTWx9cfnk+zk0RYyh205Qfd4QtvhYtmApTf9h7fDWRbGWBXjLmO5sb3kKzpXZwTgKDQmMe/jBlSnVIw5EHBw7mpwOtdfogwYTrKNUEw9B+na3OfucbA+aUy4nUdJx6xjcjj1m7Ix4RsCr5KH+oO6XYZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCSA81k3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2264aefc45dso82994325ad.0;
        Mon, 24 Mar 2025 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742856650; x=1743461450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IO0/8MpeEUMa2+c8CKNOtHcsRnk9ft2IM2tQGzIvsHg=;
        b=OCSA81k3qGj1sVp/U7u+zrc1YW6Rgovv/M4bXbwSU1ecxGEPj4J3NWCfWfYOTV8l15
         ETIcPsB9ui2+mr1q8ltdafI5bD8/hEL8dQh3Wix4WCKew1VsdJ06e6wdtTD9gUc3EgdB
         jrN46cQ8oex96h/YVHZCuq+B1d2CohI6a+HkL5wRk8T7fHoHruLT/HXygsOoPUq7t2qn
         QpaqXosKm6l50CiQQySSS7icBuhO+K3tiFM2Ehfq19HmFehtQsbFngL7Wbzfqt2sRgA6
         0XEK4ES+SqHRuJrQFnk/iYttiEziO/MZjsej0Sd7skfzqPVvWAGBMF8B5DhU5PVe3wXO
         NhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856650; x=1743461450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO0/8MpeEUMa2+c8CKNOtHcsRnk9ft2IM2tQGzIvsHg=;
        b=hrgYnDzQm5clLfPL45oOxY+74e8NCk/w8tYZTk0Y7H117YmeydyazRfg6wnUGqlEwb
         g9XDF6KVwlWRaXr8YZZDQZDgw4ss7iHVx+SdzCsX5fmta+Pb4ORkrAHdzExPrLypyWFA
         USrcelHMy3hGoqJvB0LulqIIIWlYFZKHVcld2wq/M9by2+aHf9xs1KTVGLD8K1CV5SKN
         Zk7424V7+j4oTdHRpC4JP8FpeMGdlxAP85FEnEcAqGT0iB3Ffrd5BOEWjsNAw47BxAPM
         ZYaMoKSYQikOfGl6xp028H4/h5aTIpt841iTMQktaq73HuoceT0RTY8IYQZIYSLQPLlT
         H7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVr5iUQ2LZHNXkr6mzHGEnXapksgkucsx8yHTdviExambyExe/NTENH3+dmn/zJ6AdYCN+KSDBSCbE33aE=@vger.kernel.org, AJvYcCXguF/A14izmZrwghrKxYZzMKpgfU0kdEuc3keXeFYdrlJbNAIqAygfJ2/q+tAV0TaqkKLcXTR8aBICwMME5sBX@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+FdvhAX3uFtqEbhjkDq9lVwyK8tXG++fNwn8njFTw5Ny2dNC
	ARaFBU2KXQQ6404MtLuFf7pSezhcJgBHjT1XEtTr3NTu35CnlBRH
X-Gm-Gg: ASbGnctzV8MgO7sW2JOgNpULFdvI+5Pvm0DJ7OxHAMPyWq9KokFyVuOMdr3/UmO0n9a
	n4nI2ANX1SBkaIiO9EnsqrwghGFhomFLKKVqTbwbRvL6pSnBmvHHZSEiHf0sFBiLwdgy1S4+9CQ
	+G0qE5MkbdPEZfD29RaEHOEjsnFC4EhZo/9BygAAcdUWkoqzIrXm/H2cdpYfrnnOu5YpAihdmgN
	b94im0+moNk8Zq6FgiLn/nXzO+sydfQaCDYYSoLCzf4b855eW+ZLKsQttKW/7N7MKs7bDoWlqfV
	r12zQjdYsEqVODE/sYg7MRniLDSpk7jQoYTEkhXOeoGKI98ydYaB
X-Google-Smtp-Source: AGHT+IFfUoDqYHSJpUAkSRhqvcQr4nVoDR7pn+09FRRq0qH5RxzPUbiVy3QxVHIk+syBZCoyfAPGHg==
X-Received: by 2002:a17:90b:1802:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-3030fe9fee8mr23494705a91.18.1742856650152;
        Mon, 24 Mar 2025 15:50:50 -0700 (PDT)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f5b7823sm8801477a91.10.2025.03.24.15.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:50:49 -0700 (PDT)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Mon, 24 Mar 2025 19:50:18 -0300
Subject: [PATCH v3 1/2] selftests: livepatch: add new ftrace helpers
 functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-ftrace-sftest-livepatch-v3-1-d9d7cc386c75@gmail.com>
References: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
In-Reply-To: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, felipe_life@live.com, 
 Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: b4 0.14.2

Add new ftrace helpers functions cleanup_tracing, trace_function and
check_traced_functions.

Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
---
 tools/testing/selftests/livepatch/functions.sh | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 15601402dee6567837c2c49ba342eb357e410d18..46991a029f7c64ace3945727b3540521ffe2e529 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -10,6 +10,7 @@ SYSFS_KERNEL_DIR="/sys/kernel"
 SYSFS_KLP_DIR="$SYSFS_KERNEL_DIR/livepatch"
 SYSFS_DEBUG_DIR="$SYSFS_KERNEL_DIR/debug"
 SYSFS_KPROBES_DIR="$SYSFS_DEBUG_DIR/kprobes"
+SYSFS_TRACING_DIR="$SYSFS_DEBUG_DIR/tracing"
 
 # Kselftest framework requirement - SKIP code is 4
 ksft_skip=4
@@ -62,6 +63,9 @@ function push_config() {
 			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
 	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
 	KPROBE_ENABLED=$(cat "$SYSFS_KPROBES_DIR/enabled")
+	TRACING_ON=$(cat "$SYSFS_TRACING_DIR/tracing_on")
+	CURRENT_TRACER=$(cat "$SYSFS_TRACING_DIR/current_tracer")
+	FTRACE_FILTER=$(cat "$SYSFS_TRACING_DIR/set_ftrace_filter")
 }
 
 function pop_config() {
@@ -74,6 +78,17 @@ function pop_config() {
 	if [[ -n "$KPROBE_ENABLED" ]]; then
 		echo "$KPROBE_ENABLED" > "$SYSFS_KPROBES_DIR/enabled"
 	fi
+	if [[ -n "$TRACING_ON" ]]; then
+		echo "$TRACING_ON" > "$SYSFS_TRACING_DIR/tracing_on"
+	fi
+	if [[ -n "$CURRENT_TRACER" ]]; then
+		echo "$CURRENT_TRACER" > "$SYSFS_TRACING_DIR/current_tracer"
+	fi
+	if [[ -n "$FTRACE_FILTER" ]]; then
+		echo "$FTRACE_FILTER" \
+			| sed -e "/#### all functions enabled ####/d" \
+			> "$SYSFS_TRACING_DIR/set_ftrace_filter"
+	fi
 }
 
 function set_dynamic_debug() {
@@ -352,3 +367,37 @@ function check_sysfs_value() {
 		die "Unexpected value in $path: $expected_value vs. $value"
 	fi
 }
+
+# cleanup_tracing() - stop and clean up function tracing
+function cleanup_tracing() {
+	echo 0 > "$SYSFS_TRACING_DIR/tracing_on"
+	echo "" > "$SYSFS_TRACING_DIR/set_ftrace_filter"
+	echo "nop" > "$SYSFS_TRACING_DIR/current_tracer"
+	echo "" > "$SYSFS_TRACING_DIR/trace"
+}
+
+# trace_function(function) - start tracing of a function
+#	function - to be traced function
+function trace_function() {
+	local function="$1"; shift
+
+	cleanup_tracing
+
+	echo "function" > "$SYSFS_TRACING_DIR/current_tracer"
+	echo "$function" > "$SYSFS_TRACING_DIR/set_ftrace_filter"
+	echo 1 > "$SYSFS_TRACING_DIR/tracing_on"
+}
+
+# check_traced_functions(functions...) - check whether each function appeared in the trace log
+#	functions - list of functions to be checked
+function check_traced_functions() {
+	local function
+
+	for function in "$@"; do
+		if ! grep -Fwq "$function" "$SYSFS_TRACING_DIR/trace" ; then
+			die "Function ($function) did not appear in the trace"
+		fi
+	done
+
+	cleanup_tracing
+}

-- 
2.46.2


