Return-Path: <linux-kselftest+bounces-24297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D81A0A552
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 19:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77066168D8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6758F1B4F23;
	Sat, 11 Jan 2025 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7pQfgF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBAA1B4253;
	Sat, 11 Jan 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736620968; cv=none; b=eM/ZbwWubg02qsChjCW12nHClk/D8xxqj9Cf8LCQXHmobJ5QzDo9PvSK5gVyDQzvMJVBXoQ4Wk/JhsQxcVZ5IJ7TZALgT0VRNgsHgD1xkHwN5QvUCCNc5n9lOar2ZsBTWpexiR86cyPNDhJp+FlAMCTsgiSxjgoxTVgX7Blk8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736620968; c=relaxed/simple;
	bh=qHN6h7rUSVo5CIeTRnZQIDZR55pp4S6wi3KyOIE7X2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vu4Mnngk9HGZwyjO0zGo1UZySKpoz2F5t1fYIlPs+n7byVti8hv9mkrkhQTjnMVLhrmxsq/FwVL5MKcqc5hfVv/Ri6fkqrdiN8lAAVSuzoWhdUbnJJqGc8UCOQ99Q5Ns6DLXfAI5v0ztse+vcMIlyanWeJMXNwYhgWhKOEOZQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7pQfgF7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21628b3fe7dso51413345ad.3;
        Sat, 11 Jan 2025 10:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736620966; x=1737225766; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fvGqwZAuw5vpQfQsA/WWi9Bqd1oJsgWApQ/uA7RLxw=;
        b=S7pQfgF78RmKh2fvV8EuJQQxjJzoE4xXPv2R+TIu6WKLhmXVecpGMxDlK3Fo6/Xnp9
         xtNIsqKi+eQ+/ntO2FHZfae2jbLAQddklJB58qXNg9ARxcnPSnFpzRt3e+MEZCWScPkG
         ANIPh2pMd5vwxJ9sn4a5YL8HvJzXKYVhBFX5zXKNQWFUJAUdNcC0Kpvlj9pfEKhzFsUc
         UHubHPHRvVXLuHKsg+teJ4yUTNfauMcFzC/CE7Pz5gG89x6yxjIuKTTEXP/FXz4YPdsA
         fP9vctefmYngQ8uVKLLGPwfG3Gdc6H8u41NwmYLfKC2GSvpxfEI3FdQ+HZMupM/AIe35
         YKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736620966; x=1737225766;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fvGqwZAuw5vpQfQsA/WWi9Bqd1oJsgWApQ/uA7RLxw=;
        b=TGjq9XjyIJAyu6iZKzKw666OscXW0EV5e/KdMGL8HymXyk29ArtRTHoWHnjxfwkyJf
         9pbkKMeTe2TaSPtjAm48hG5qs/IIc5UQZxMY5CVqrN0ArZCBiHNwD9w0HK1V3VbsUquR
         dUen52hnYFXipuzCuWdmuKBMr3x0NOB/FsAiS08ExHuJ9rm2eVbb77kUNlxq+5Z2b45I
         reIpT0PfjiXB/sHIIHcwTodhIPy5JpHx6HUlNccjrQSn5aSYEW80dSADFUYLJNZDrLpx
         UDxLbUx8NmWK7+OXNkvEp5DaQDzBOyFTF0b464lo6w2tmn911oYlLhkAHAOumw/KCNcz
         HtnA==
X-Forwarded-Encrypted: i=1; AJvYcCUlrqXqmLz8XUZ594GptDE8RNp+m9gqLTv0JUxRVAl+SnvLWDfodidPPaTrPTB5lhveggaHQsqfhEEQZAE=@vger.kernel.org, AJvYcCXMgRR5Ur9RPmhGQY9y/VH6/m/6OPesooi9PrK0vpUxRIZD6wKRdWsg63+Y3wFFe0Ji0+AImP6P7o0zsExeJ1sN@vger.kernel.org
X-Gm-Message-State: AOJu0YwwI/4JQ7BwfPYK+aqM7dhoyDuGiHpr2jZIEQ7e6/eMwvV+QCBo
	WPmOcIBWv79Gl21vuJS2sJKYUy2acRqTKeXUnxH72zVhJfkL6yUDB9aWn19d29c=
X-Gm-Gg: ASbGncsQDrcHLhPCW2PFuJzviS5Y6cJbpJzKNkMyUBM2cTnSF/vBFw7U1xJ/Jr3nBXY
	SILixRPepZlcEOOfXGOnAobNJymz2ctWo6SLfHQO0jQpuK+8tq3m9XW7qFfvgVJ+uGSLuxcnWLU
	dU65FuV5jv32pF+Ww7EH6iHVaarRsc5Ae73uH9eXAoX7O//R7hd4pHAPXoeVyZV8apxSbbkPkL1
	OPqKEMSsDrVIQxnRZWNt7K/l3Y2vrU15Xh/qMxoTo9tk3rllvZjSXJcpIt1Lmfy
X-Google-Smtp-Source: AGHT+IEBe/MCZn89f8LfBZ1StrWiBjS3xJcv0zgoqM72+sAAj8nA+48SpAnEkXV9/1mkDBJcX3farg==
X-Received: by 2002:a17:902:ecc5:b0:215:7dbf:f3de with SMTP id d9443c01a7336-21a83f5e4e5mr228852025ad.28.1736620966091;
        Sat, 11 Jan 2025 10:42:46 -0800 (PST)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c99csm30037235ad.164.2025.01.11.10.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 10:42:45 -0800 (PST)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Sat, 11 Jan 2025 15:42:27 -0300
Subject: [PATCH v2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-ftrace-selftest-livepatch-v2-1-9f4ff90f251a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJK7gmcC/32NywrCMBBFf6Vk7UgmqA2u/A/pIo9JO9AXSQhK6
 b8bC25dngP33E0kikxJ3JtNRCqceJkrqFMj3GDmnoB9ZaGkukqUCCFH4wgSjSFTyjByodVkNwD
 eMNi29Za8FnW/Rgr8OtrPrvLAKS/xfVwV/NpfVf2pFgQEfdFaWkPBoX30k+Hx7JZJdPu+fwAsp
 0/YwgAAAA==
X-Change-ID: 20250101-ftrace-selftest-livepatch-161fb77dbed8
To: Marcos Paulo de Souza <mpdesouza@suse.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felipe Xavier <felipe_life@live.com>, 
 Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: b4 0.14.2

This new test makes sure that ftrace can trace a
function that was introduced by a livepatch.

Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
---
Changes in v2:
- functions.sh: added reset tracing on push and pop_config.
- test-ftrace.sh: enabled tracing_on before test init.
- nitpick: added double quotations on filenames and fixed some wording. 
- Link to v1: https://lore.kernel.org/r/20250102-ftrace-selftest-livepatch-v1-1-84880baefc1b@gmail.com
---
 tools/testing/selftests/livepatch/functions.sh   | 14 ++++++++++
 tools/testing/selftests/livepatch/test-ftrace.sh | 33 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index e5d06fb402335d85959bafe099087effc6ddce12..e6c13514002dae5f8d7461f90b8241ab43024ea4 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -62,6 +62,9 @@ function push_config() {
 			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
 	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
 	KPROBE_ENABLED=$(cat "$SYSFS_KPROBES_DIR/enabled")
+	TRACING_ON=$(cat "$SYSFS_DEBUG_DIR/tracing/tracing_on")
+	CURRENT_TRACER=$(cat "$SYSFS_DEBUG_DIR/tracing/current_tracer")
+	FTRACE_FILTER=$(cat "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter")
 }
 
 function pop_config() {
@@ -74,6 +77,17 @@ function pop_config() {
 	if [[ -n "$KPROBE_ENABLED" ]]; then
 		echo "$KPROBE_ENABLED" > "$SYSFS_KPROBES_DIR/enabled"
 	fi
+	if [[ -n "$TRACING_ON" ]]; then
+		echo "$TRACING_ON" > "$SYSFS_DEBUG_DIR/tracing/tracing_on"
+	fi
+	if [[ -n "$CURRENT_TRACER" ]]; then
+		echo "$CURRENT_TRACER" > "$SYSFS_DEBUG_DIR/tracing/current_tracer"
+	fi
+	if [[ "$FTRACE_FILTER" == *"#"* ]]; then
+		echo > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
+	elif [[ -n "$FTRACE_FILTER" ]]; then
+		echo "$FTRACE_FILTER" > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
+	fi
 }
 
 function set_dynamic_debug() {
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index fe14f248913acbec46fb6c0fec38a2fc84209d39..66af5d726c52e48e5177804e182b4ff31784d5ac 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -61,4 +61,37 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 % rmmod $MOD_LIVEPATCH"
 
 
+# - verify livepatch can load
+# - check if traces have a patched function
+# - unload livepatch and reset trace
+
+start_test "trace livepatched function and check that the live patch remains in effect"
+
+TRACE_FILE="$SYSFS_DEBUG_DIR/tracing/trace"
+FUNCTION_NAME="livepatch_cmdline_proc_show"
+
+load_lp $MOD_LIVEPATCH
+
+echo 1 > "$SYSFS_DEBUG_DIR/tracing/tracing_on"
+echo $FUNCTION_NAME > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
+echo "function" > "$SYSFS_DEBUG_DIR/tracing/current_tracer"
+echo "" > "$TRACE_FILE"
+
+if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+grep -q $FUNCTION_NAME "$TRACE_FILE"
+FOUND=$?
+
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+
+if [ "$FOUND" -eq 1 ]; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+
 exit 0

---
base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
change-id: 20250101-ftrace-selftest-livepatch-161fb77dbed8

Best regards,
-- 
Filipe Xavier <felipeaggger@gmail.com>


