Return-Path: <linux-kselftest+bounces-29383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF3A67E91
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 22:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970B242290C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF3211A15;
	Tue, 18 Mar 2025 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvYOlgSt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB8206F08;
	Tue, 18 Mar 2025 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332864; cv=none; b=cHtRwo/dHwuE+2Nb+IxKj+/M08A4Znw5eCacKlxNlstasrJX/1Hm1YexsH231jQKCGzrbtDQBDKc7x6T0TCgsqHPhBu4PT84UrTZ24drg7i38soNbucMkkyef63fUFwsZAQWI9pidGK6o2O9CugnvSj/MYQaZbydMySBNU8klPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332864; c=relaxed/simple;
	bh=t3LBr8Y/NNuvTN/6q5VrjpjZNWmpXm5vCWWb61LZX50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRIi5TvJVv74uhftouvf0ZAIROuX55mZ0oXpg289RiFEtadlgLvxPX61biZ9xyNP0b8S3qIOTwraAu5/WocnvFTHKgOILXiiRUXmZcBS0h73zq2i0vbdI7eJt1LYMw45rVXXPImtxOeDqIGcQsOhkbQxFQlOQHBdWA/5l7Z1FPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvYOlgSt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3014678689aso5022821a91.0;
        Tue, 18 Mar 2025 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742332862; x=1742937662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7hU98wGhmJEnwZdhghVSe4pYXRo5E6EyhPwz0NPt58=;
        b=SvYOlgStkdCoDDUAQKb9Mxx4wEHsHE4s2+pPvjJ7CjQnH3arSJt1t42qTPyzV2HmrW
         gJGDiYtqTQV4lROBllcp+zuwlGPWEJ4xNIwP9rzloWkx+cTyB6yOkE9YSoKGlp2vqQdZ
         +w5ifqvRhlNhB4e5xxlt09YEhQyBtz/pCUH0nXJDcx5j8geT9tI5ETdeSM0suptf7inF
         VpRan3uEWmP9U0Jh9WWcwNVugTyQ+Tqty1RDSYRx6NXYkLOOtT/YZo1c5EEfW1P7rZDi
         L7P1ChBklWcQmjCLKKJicszmB+FOxT1zDnUwVPlTqU1FO6jthnmfJSb97N7UiHURyd1q
         enUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742332862; x=1742937662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7hU98wGhmJEnwZdhghVSe4pYXRo5E6EyhPwz0NPt58=;
        b=p/BadKQ/td9gy/bgl29k4PytEypzM3YbXJ3JYqZcpAySd5OWL8j+xeUGAEy+9jRZpM
         vo2oLsfuVoXWEKA0+NclcP2maQFrMVXBO1C5LIEXjofaEclkPeS87BuEFXpqL1tWnJSp
         gbGqPL9ZDsZeeKgvfH5qPX4BQJrTSvBeTac8F33e6hmDmZVjhqJ5KOtYaCC5Fzd0fJ/4
         +0FQS6NjFnOe34othmehx5+5FAbObG5NDiNRhg+mFv//vE/PjdYVDkZrfrIQcKqrMPVH
         BfkaELJUOfClFRot48mgyBcpDqMCmkk4wodTbAYwxn6P2hpuydk+ADDEW0Abp0KX7lB9
         +J4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW7QhovAVY5VcQDfdhloB/wNIvchKkSbi/iHoyNhC7tgWFxa5AvzgwuX+K+iLgomGLf/2rC5txmolCJuXSUAa+@vger.kernel.org, AJvYcCXcn6zgibYoLjsstfRITuXf2zS9iEEtnKfWQbYuqnGJorR0lToV1Q982Tn55x0xMD7z0rMbuXG+RmeN1ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kX31vRJIdZseqE3iTE4b5ls6z6Bu2/oqS9l4hIMUmU/ms/Qt
	Zb5ZV5xdgzm0VQkDT+9kY8LzUxKe5XdFLzG2npZ3DDriDcN66o/pa4DFwhzSY+U=
X-Gm-Gg: ASbGncvQUjxN7+vxK+I4Pz8hzVRV4JMtEcQuZJ4n2rlQ9HbxHicOWrX6zRmD7kj1XgB
	ynN0Ywzgsd5Ejop25z8w0QIs7UNtrmAUvPOGyjzeahBDFqbsP8hdd0m4aTcBAoZk/lYeQcZ/gjS
	C31UvWrOLK13j+VZcPFVZvkHnBOMgyxKLxTPG+6t+EFnGEwBZ9z8KBzWrcpHywbEDlCr4lkDbwv
	isTh3g0SErmSexISjlHRVTbQIMjG0/T2fBS4h2uy+rsVTt8pmiUCQUS5Vww6L6KV2O9t8+JA7ZN
	e4H/E/kR7fPIYofqksOt2C2ce/o4gQExc6u14spExiy2BVS9UwOV
X-Google-Smtp-Source: AGHT+IGT2VibjX3PZO9f2MPn6ZWEIGoikv5Ef2UT2HBrIYFIdsujMP1ur1rBKk2cCC9QFyhk4VlbBg==
X-Received: by 2002:a17:90a:e7ca:b0:2fe:ac91:4667 with SMTP id 98e67ed59e1d1-301be21fe92mr208183a91.29.1742332862383;
        Tue, 18 Mar 2025 14:21:02 -0700 (PDT)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afe74asm8771777a91.24.2025.03.18.14.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:21:02 -0700 (PDT)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Tue, 18 Mar 2025 18:20:35 -0300
Subject: [PATCH v2 1/2] selftests: livepatch: add new ftrace helpers
 functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-ftrace-sftest-livepatch-v2-1-60cb0aa95cca@gmail.com>
References: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
In-Reply-To: <20250318-ftrace-sftest-livepatch-v2-0-60cb0aa95cca@gmail.com>
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
index 15601402dee6567837c2c49ba342eb357e410d18..dea9cc10a3f09662c57c2593cff49423302c8a5c 100644
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
+			| sed -e "/#### all functions enabled ####/d"
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
+		if ! grep -q "$function" "$SYSFS_TRACING_DIR/trace" ; then
+			die "Function ($function) did not appear in the trace"
+		fi
+	done
+
+	cleanup_tracing
+}

-- 
2.46.2


