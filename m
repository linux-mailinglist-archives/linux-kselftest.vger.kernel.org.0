Return-Path: <linux-kselftest+bounces-46868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B3C9AE53
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 10:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD87B4E4724
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669CB313E22;
	Tue,  2 Dec 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGrQOiFI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467A312825
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668211; cv=none; b=g5t74Lh+ADBXFVLR45tTwn5LqDl7xnNzjr7B5OoShaFI0o444nqC6d/1iun5riFScJF/3XOG1+Rh+Wgr6aW18OOQIkkV+CEibQ3Bob3OCwSlayXVRvEO17LR44/y3QTCL9sl05QD6OQv7tdNuOshxO53yvivI5FM67aOItGYGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668211; c=relaxed/simple;
	bh=fdg7wtsCIJ3jnoTralVR8cTfLvIqlHoHr54JucFTkvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gGlMbwZwBznqtHB8VXHAo9Td0OIVnlyO++7R5+bepZZxfkh+o51HaiUJirwVwVM0xzz7lTAl2c0xFJf65fHK/uUHACNMQW0G7mzkkXcDRgq8PbzCC/FZvxk+cYF/lvjY6Gh8Vs5SHaxrqYxVGSg7zfO3j3dlpM41LWNS3ANm5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGrQOiFI; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso58837665e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 01:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668206; x=1765273006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8SaSlR21X8uw5JbfCQ1jPLfSHz69ALy3d7a4Nwxl7c=;
        b=vGrQOiFIqQ4VhnuLWCB9kMID5pOjfbcObqmR6K596841GBtpcC3hQ8i6/ZFE6VQJyD
         N0cbhcy8zByz9iq0G816iJy8iwwr5zi0oSJaYtYlqKk3BiH5ubAKnaqLRtVN4877RTSS
         nv2z6M4sWmi/XRTJgpWk7f94BrjT2acsPt1imR6Cl0DxhkCG0tzZA+8bXoVsxAfeYk3+
         aYqiCUC8DZJijpj1shY4LILzJFUFhBhjOe1MkKvkTk6QirZhHbPlCPuo/RjXYInm2SmB
         QrKr/V38ckTr56qi3Msm5wbbWIwSIyUo4sVAItapEBhLV6u5h6YoIcOFd5SViPOwGrFk
         7+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668206; x=1765273006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8SaSlR21X8uw5JbfCQ1jPLfSHz69ALy3d7a4Nwxl7c=;
        b=G42HFD45uovSkwVAhDAAssW5/e34Q0vo2HanbWeHtZ94AFAlSUf1iOiEgvoNVVdxLa
         cLV4r6EovUR0tSwukYoV7n/3h7TqoJrtfDMXwRQ93tVDRDTgrOcMfUyohwMTJxAqGcDq
         QJoZ6f7iZS8xn7wAeC+kXMdnvOiCeTzuUad/SObg6YvEmH4yw2DQyKukBC9jnGS7dqnt
         rZoI0KNzs0QWYQtIIAYfYAOuq2/gIxTsbFnZOaB+/qw2gtbmN3kQt/Hv+nkiD4gcusyo
         rEYcGMzJp64T6TlJHxLz7OvbQSoNOSAS3182i5p1Zg818dRMkKnMnZuOZ5m6sa6KSsuy
         cD1w==
X-Forwarded-Encrypted: i=1; AJvYcCW0U6yVIJuiYP6PEJwz0WJhv6BiTMBwtKtJmh9RIKDUblqONI66riP+RJH7Bcx9lltG3Oh+6SQs+CuF31jf6A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXY3s4Civ4Z7Aw8ThVFxH9NxU8mtZzzjzexlOO7dAZKkwxX7r
	CCeEk/FxUYOCEGEna5//K/l3uhs69n2dkJLkAjFfh7MOk4N+GelReRzpcUN9dEcojiDitDNNVKl
	hUVqj5HahRsuFuQxhxxXG+g==
X-Google-Smtp-Source: AGHT+IGPJ5G+I2O4b4luyBXD5Ypbz6gRS12n8TqRZOXbdlUTemCDYTXVqsnoh3qZAcruZUutLW5fL0GMBBT57JUc
X-Received: from wmjy4.prod.google.com ([2002:a7b:cd84:0:b0:475:decb:4c4d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b96:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47904ad907amr319945915e9.10.1764668206205;
 Tue, 02 Dec 2025 01:36:46 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:08 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-16-vdonnefort@google.com>
Subject: [PATCH v9 15/30] tracing: selftests: Add trace remote tests
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Exercise the tracefs interface for trace remote with a set of tests to
check:

  * loading/unloading (unloading.tc)
  * reset (reset.tc)
  * size changes (buffer_size.tc)
  * consuming read (trace_pipe.tc)
  * non-consuming read (trace.tc)

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/buffer_size.tc
new file mode 100644
index 000000000000..1a43280ffa97
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/buffer_size.tc
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote buffer size
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_buffer_size()
+{
+    echo 0 > tracing_on
+    assert_unloaded
+
+    echo 4096 > buffer_size_kb
+    echo 1 > tracing_on
+    assert_loaded
+
+    echo 0 > tracing_on
+    echo 7 > buffer_size_kb
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+    setup_remote_test
+    test_buffer_size
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
new file mode 100644
index 000000000000..97a09d564a34
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0
+
+setup_remote()
+{
+	local name=$1
+
+	[ -e $TRACING_DIR/remotes/$name/write_event ] || exit_unresolved
+
+	cd remotes/$name/
+	echo 0 > tracing_on
+	clear_trace
+	echo 7 > buffer_size_kb
+	echo 0 > events/enable
+	echo 1 > events/$name/selftest/enable
+	echo 1 > tracing_on
+}
+
+setup_remote_test()
+{
+	[ -d $TRACING_DIR/remotes/test/ ] || modprobe remote_test || exit_unresolved
+
+	setup_remote "test"
+}
+
+assert_loaded()
+{
+	grep -q "(loaded)" buffer_size_kb
+}
+
+assert_unloaded()
+{
+	grep -q "(unloaded)" buffer_size_kb
+}
+
+dump_trace_pipe()
+{
+    output=$(mktemp $TMPDIR/remote_test.XXXXXX)
+    cat trace_pipe > $output &
+    pid=$!
+    sleep 1
+    kill -1 $pid
+
+    echo $output
+}
+
+check_trace()
+{
+	start_id="$1"
+	end_id="$2"
+	file="$3"
+
+	# Ensure the file is not empty
+	test -n "$(head $file)"
+
+	prev_ts=0
+	id=0
+
+	# Only keep <timestamp> <id>
+	tmp=$(mktemp $TMPDIR/remote_test.XXXXXX)
+	sed -e 's/\[[0-9]*\]\s*\([0-9]*.[0-9]*\): [a-z]* id=\([0-9]*\)/\1 \2/' $file > $tmp
+
+	while IFS= read -r line; do
+		ts=$(echo $line | cut -d ' ' -f 1)
+		id=$(echo $line | cut -d ' ' -f 2)
+
+		test $(echo "$ts>$prev_ts" | bc) -eq 1
+		test $id -eq $start_id
+
+		prev_ts=$ts
+		start_id=$((start_id + 1))
+	done < $tmp
+
+	test $id -eq $end_id
+	rm $tmp
+}
+
+get_cpu_ids()
+{
+    sed -n 's/^processor\s*:\s*\([0-9]\+\).*/\1/p' /proc/cpuinfo
+}
+
+get_page_size() {
+    sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
+}
+
+get_selftest_event_size() {
+    sed -ne 's/^.*field:.*;.*size:\([0-9][0-9]*\);.*/\1/p' events/*/selftest/format | awk '{s+=$1} END {print s}'
+}
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/reset.tc
new file mode 100644
index 000000000000..4d176349b2bc
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/reset.tc
@@ -0,0 +1,90 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote reset
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+check_reset()
+{
+    write_event_path="write_event"
+    taskset=""
+
+    clear_trace
+
+    # Is the buffer empty?
+    output=$(dump_trace_pipe)
+    test $(wc -l $output | cut -d ' ' -f1) -eq 0
+
+    if $(echo $(pwd) | grep -q "per_cpu/cpu"); then
+        write_event_path="../../write_event"
+        cpu_id=$(echo $(pwd) | sed -e 's/.*per_cpu\/cpu//')
+        taskset="taskset -c $cpu_id"
+    fi
+    rm $output
+
+    # Can we properly write a new event?
+    $taskset echo 7890 > $write_event_path
+    output=$(dump_trace_pipe)
+    test $(wc -l $output | cut -d ' ' -f1) -eq 1
+    grep -q "id=7890" $output
+    rm $output
+}
+
+test_global_interface()
+{
+    output=$(mktemp $TMPDIR/remote_test.XXXXXX)
+
+    # Confidence check
+    echo 123456 > write_event
+    output=$(dump_trace_pipe)
+    grep -q "id=123456" $output
+    rm $output
+
+    # Reset single event
+    echo 1 > write_event
+    check_reset
+
+    # Reset lost events
+    for i in $(seq 1 10000); do
+        echo 1 > write_event
+    done
+    check_reset
+}
+
+test_percpu_interface()
+{
+    [ "$(get_cpu_ids | wc -l)" -ge 2 ] || return 0
+
+    for cpu in $(get_cpu_ids); do
+        taskset -c $cpu echo 1 > write_event
+    done
+
+    check_non_empty=0
+    for cpu in $(get_cpu_ids); do
+        cd per_cpu/cpu$cpu/
+
+        if [ $check_non_empty -eq 0 ]; then
+            check_reset
+            check_non_empty=1
+        else
+            # Check we have only reset 1 CPU
+            output=$(dump_trace_pipe)
+            test $(wc -l $output | cut -d ' ' -f1) -eq 1
+            rm $output
+        fi
+        cd -
+    done
+}
+
+test_reset()
+{
+    test_global_interface
+    test_percpu_interface
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+    setup_remote_test
+    test_reset
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/trace.tc
new file mode 100644
index 000000000000..081133ec45ff
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/trace.tc
@@ -0,0 +1,127 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote non-consuming read
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_trace()
+{
+	echo 0 > tracing_on
+    assert_unloaded
+
+    echo 7 > buffer_size_kb
+    echo 1 > tracing_on
+    assert_loaded
+
+    # Simple test: Emit few events and try to read them
+    for i in $(seq 1 8); do
+        echo $i > write_event
+    done
+
+    check_trace 1 8 trace
+
+    #
+    # Test interaction with consuming read
+    #
+
+    cat trace_pipe > /dev/null &
+    pid=$!
+
+    sleep 1
+    kill $pid
+
+    test $(wc -l < trace) -eq 0
+
+    for i in $(seq 16 32); do
+        echo $i > write_event
+    done
+
+    check_trace 16 32 trace
+
+    #
+    # Test interaction with reset
+    #
+
+    echo 0 > trace
+
+    test $(wc -l < trace) -eq 0
+
+    for i in $(seq 1 8); do
+        echo $i > write_event
+    done
+
+    check_trace 1 8 trace
+
+    #
+    # Test interaction with lost events
+    #
+
+    # Ensure the writer is not on the reader page by reloading the buffer
+    echo 0 > tracing_on
+    echo 0 > trace
+    assert_unloaded
+    echo 1 > tracing_on
+    assert_loaded
+
+    # Ensure ring-buffer overflow by emitting events from the same CPU
+    for cpu in $(get_cpu_ids); do
+        break
+    done
+
+    events_per_page=$(($(get_page_size) / $(get_selftest_event_size))) # Approx: does not take TS into account
+    nr_events=$(($events_per_page * 2))
+    for i in $(seq 1 $nr_events); do
+        taskset -c $cpu echo $i > write_event
+    done
+
+    id=$(sed -n -e '1s/\[[0-9]*\]\s*[0-9]*.[0-9]*: [a-z]* id=\([0-9]*\)/\1/p' trace)
+    test $id -ne 1
+
+    check_trace $id $nr_events trace
+
+    #
+    # Test per-CPU interface
+    #
+    echo 0 > trace
+
+    for cpu in $(get_cpu_ids) ; do
+        taskset -c $cpu echo $cpu > write_event
+    done
+
+    for cpu in $(get_cpu_ids); do
+        cd per_cpu/cpu$cpu/
+
+        check_trace $cpu $cpu trace
+
+        cd - > /dev/null
+    done
+
+    #
+    # Test with hotplug
+    #
+
+    [ "$(get_cpu_ids | wc -l)" -ge 2 ] || return 0
+
+    echo 0 > trace
+
+    for cpu in $(get_cpu_ids); do
+        echo 0 > /sys/devices/system/cpu/cpu$cpu/online
+        break
+    done
+
+    for i in $(seq 1 8); do
+        echo $i > write_event
+    done
+
+    check_trace 1 8 trace
+
+    echo 1 > /sys/devices/system/cpu/cpu$cpu/online
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+
+    setup_remote_test
+    test_trace
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
new file mode 100644
index 000000000000..d28eaee10c7c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
@@ -0,0 +1,127 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote consuming read
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_trace_pipe()
+{
+    echo 0 > tracing_on
+    assert_unloaded
+
+    # Emit events from the same CPU
+    for cpu in $(get_cpu_ids); do
+        break
+    done
+
+    #
+    # Simple test: Emit enough events to fill few pages
+    #
+
+    echo 1024 > buffer_size_kb
+    echo 1 > tracing_on
+    assert_loaded
+
+    events_per_page=$(($(get_page_size) / $(get_selftest_event_size)))
+    nr_events=$(($events_per_page * 4))
+
+    output=$(mktemp $TMPDIR/remote_test.XXXXXX)
+
+    cat trace_pipe > $output &
+    pid=$!
+
+    for i in $(seq 1 $nr_events); do
+        taskset -c $cpu echo $i > write_event
+    done
+
+    echo 0 > tracing_on
+    sleep 1
+    kill $pid
+
+    check_trace 1 $nr_events $output
+
+    rm $output
+
+    #
+    # Test interaction with lost events
+    #
+
+    assert_unloaded
+    echo 7 > buffer_size_kb
+    echo 1 > tracing_on
+    assert_loaded
+
+    nr_events=$((events_per_page * 2))
+    for i in $(seq 1 $nr_events); do
+        taskset -c $cpu echo $i > write_event
+    done
+
+    output=$(dump_trace_pipe)
+
+    lost_events=$(sed -n -e '1s/CPU:.*\[LOST \([0-9]*\) EVENTS\]/\1/p' $output)
+    test -n "$lost_events"
+
+    id=$(sed -n -e '2s/\[[0-9]*\]\s*[0-9]*.[0-9]*: [a-z]* id=\([0-9]*\)/\1/p' $output)
+    test "$id" -eq $(($lost_events + 1))
+
+    # Drop [LOST EVENTS] line
+    sed -i '1d' $output
+
+    check_trace $id $nr_events $output
+
+    rm $output
+
+    #
+    # Test per-CPU interface
+    #
+
+    echo 0 > trace
+    echo 1 > tracing_on
+
+    for cpu in $(get_cpu_ids); do
+        taskset -c $cpu echo $cpu > write_event
+    done
+
+    for cpu in $(get_cpu_ids); do
+        cd per_cpu/cpu$cpu/
+        output=$(dump_trace_pipe)
+
+        check_trace $cpu $cpu $output
+
+        rm $output
+        cd - > /dev/null
+    done
+
+    #
+    # Test interaction with hotplug
+    #
+
+    [ "$(get_cpu_ids | wc -l)" -ge 2 ] || return 0
+
+    echo 0 > trace
+
+    for cpu in $(get_cpu_ids); do
+        echo 0 > /sys/devices/system/cpu/cpu$cpu/online
+        break
+    done
+
+    for i in $(seq 1 8); do
+        echo $i > write_event
+    done
+
+    output=$(dump_trace_pipe)
+
+    check_trace 1 8 $output
+
+    rm $output
+
+    echo 1 > /sys/devices/system/cpu/cpu$cpu/online
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+
+    setup_remote_test
+    test_trace_pipe
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/unloading.tc
new file mode 100644
index 000000000000..cac2190183f6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/unloading.tc
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote unloading
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_unloading()
+{
+    # No reader, writing
+    assert_loaded
+
+    # No reader, no writing
+    echo 0 > tracing_on
+    assert_unloaded
+
+    # 1 reader, no writing
+    cat trace_pipe &
+    pid=$!
+    sleep 1
+    assert_loaded
+    kill $pid
+    assert_unloaded
+
+    # No reader, no writing, events
+    echo 1 > tracing_on
+    echo 1 > write_event
+    echo 0 > tracing_on
+    assert_loaded
+
+    # Test reset
+    clear_trace
+    assert_unloaded
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+
+    setup_remote_test
+    test_unloading
+fi
-- 
2.52.0.107.ga0afd4fd5b-goog


