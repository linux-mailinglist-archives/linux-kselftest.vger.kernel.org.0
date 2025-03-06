Return-Path: <linux-kselftest+bounces-28434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B3A55919
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 22:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE0D176E1D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F26278110;
	Thu,  6 Mar 2025 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMiYiGP7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00EC2780F1;
	Thu,  6 Mar 2025 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297931; cv=none; b=IxwjRifqVOtv3kCgC+RoTcYYMW6L18N6kLz9YA3rwfr201vj5H+EpT9/bbl51/8j27YpU87Rrqmtc5h5x9wuff/xFlKHJO5TbRPbaMoEbnJ11YZ0AuRYxdG3urFmTrXYn+84AtLMc4ASbo2tTi7N8/gtAyNptX9iBLryOa1NZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297931; c=relaxed/simple;
	bh=+s/sk4fVMkclGxEhZgRoyB4GsatFYR0Z/YUB6BcVOdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmH4h8U+b24QfkouVLX/cvMNsPdrgA4AU0CJVnv6E7oGlJhKZ3eYIxtqJxMKXqq/LlPAlu0G6oBvIQQE7fIbku32JPhwUXX81GHjuXxNMqUWyaRwV+5zKgMJ/CUJl0vtS1cetCbJv+xaLACq31wdhPM2Wi+9wBOtQI8mJDDhsuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMiYiGP7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-219f8263ae0so23349865ad.0;
        Thu, 06 Mar 2025 13:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741297929; x=1741902729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7zTXY5LTfD/3dXSuynLE+jQWT/QVXEEJIIi/3SPsNc=;
        b=QMiYiGP7ZNb14PBZdt//b6ZtqOzbxzuxKrfTr+1rPxzHxxg6wtjkHEPS5s3PcQEsfp
         tTjjCWkBM75VcAQVdBCIFwpo+u7BJte8Iwu09VfkURb6kwHVpaXkYVQoOyBloK2oCSE2
         sNctLSS9CQOtuOWkI5WTWz9fLAVOgL32MA2phDGV+tkJmUqP7AXY448Mt2rUX1HaW4zv
         9gLNLpUsSOZX0JXwMegRD2yNgXBH5zJX+Gm5/jngGdhJC8AwJOPLvZqAbqKjQnendTxt
         QJx4j4qU1GupwXkROlwUOzlhRwWDfVU8e1Ba/nY69OSoqakliqdzGQkK61Cuk9feaoqn
         pPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297929; x=1741902729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7zTXY5LTfD/3dXSuynLE+jQWT/QVXEEJIIi/3SPsNc=;
        b=wkglWrPigzK/iT6QO5ZtqLUNbyT+B0L/NBDjhWFQM8TJ312LwIt8pTZfvjmX0Lbrbe
         OcS245P0/TyJjKpJyXPoe0M6PvleoAasFmuJaTH6xD2ho/z1lDh0eJJ9dSJaCsKpASnY
         S0dFQ5LMQpijaOVEzU2R2xCp9A8SFr1ty6CH1+KyFlYLliYa4GHnEImWV503FOuvMPkv
         6RhQDi9614JMkd238esCbpjURpPUB2grqzUViDiElPf6ugkp9UwR/4bLdSH+NjgWc98N
         XLTi+/02wvLxi7RmVqlGU2QNfOI0MXUHn7PQJ5jq78KK2jnFKqRtTHAZFN/hF8DMKVOW
         gL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYCDiH1Dnm8GmGUQZUTuXZfDelJsLDyFiQrXuBbfgetoRe8jf5yoZEZjyCebQyUfbb1KygLQyzdgqUIGuC0bQO@vger.kernel.org, AJvYcCWxw9QlfCCXrTyL1FjH0nxLhQoisjDYe6UkUfuAawJqLHKkI23rzhJvDBYfwT5/IfOlxoyugZ3wLoHj7U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJ+I5joyEKVDfnd4gVsFeub7mTGuhvnY2XNJsxr2pc7rlUHKM
	qRp2UfVejrkbOnAW2M0GP13ogOld8pz+pA0JKhi9GhNHjB67ELbC
X-Gm-Gg: ASbGncvd0nNibugPsxOP1gNBzMZNqAbqrmTFYUA0GjjhVK67YLS6qBkmZvwr7SkZuw2
	Pu3Zj7p6Rsr0Jbjtr/W16XmapQvQ1E3raXVOePFOeaFr/SejjGwniO1P4xaOH35Oz2WRDc9iDPW
	V5ayXC6eLbpyjSpBPxhjwoWkxKPlhiW7nL6w24AiivUfOpcKOPKXNyILGTNH50SywRVVdLuk7Hf
	9agM7oKisXhyoesXWzc4najXEKbaUmnYweTuIHKScdnAa0uNG75R9Md3FD/EP/HiFqT4ZADKpL0
	/0hM9OFC61hdgAW9IxbPjU2PE/ZWjf352Q0IOGcUuox1oDEL2ot9
X-Google-Smtp-Source: AGHT+IHA403KIEk38FD1/zoA0i8RjhzvgshZ+rqqLIvHZXEdxCM44TV07I5JP74RbfjFUrsWGPDN5A==
X-Received: by 2002:a05:6a00:228c:b0:736:8c0f:774f with SMTP id d2e1a72fcca58-736aab02cd8mr1414309b3a.22.1741297928842;
        Thu, 06 Mar 2025 13:52:08 -0800 (PST)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369824554bsm1923651b3a.69.2025.03.06.13.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:52:08 -0800 (PST)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Thu, 06 Mar 2025 18:51:42 -0300
Subject: [PATCH PATCH 1/2] selftests: livepatch: add new ftrace helpers
 functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-ftrace-sftest-livepatch-v1-1-a6f1dfc30e17@gmail.com>
References: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com>
In-Reply-To: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, felipe_life@live.com, 
 Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: b4 0.14.2

Add new ftrace helpers functions cleanup_tracing, trace_function and
check_traced_function.

Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
---
 tools/testing/selftests/livepatch/functions.sh | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 15601402dee6567837c2c49ba342eb357e410d18..512ab3a9c20cc5691bbf0863d837ffa0d40a15e9 100644
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
@@ -352,3 +367,33 @@ function check_sysfs_value() {
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
+# check_traced_function(function) - check whether function appeared in trace log
+#	function - to be traced function
+function check_traced_function() {
+	local function="$1"; shift
+
+	if ! grep -q "$function" "$SYSFS_TRACING_DIR/trace" ; then
+		die "Function ($function) did not appear in the trace"
+	fi
+}

-- 
2.46.2


