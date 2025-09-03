Return-Path: <linux-kselftest+bounces-40677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B551B4140F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 06:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57F3178F52
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 04:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E5D2D4B6F;
	Wed,  3 Sep 2025 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHRNFLhQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9C2D4B4E;
	Wed,  3 Sep 2025 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875499; cv=none; b=thOBBgjuXZc5/bDmzWd+brSk7o5VJr9UTfrNfN+MeSvdHDXwoFjd7+BQYunAol2AbVo5Rk/RFNfzM9Y0NJMHwLxbqPszdzZQ516tkDbZPRFcmmUkCXGg3PUmm/kTc97222BX+FGgeRCDIF8MOiU4xdGCkBtUeOfGpyPdsn05VtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875499; c=relaxed/simple;
	bh=6YJvO7PqsDrEvLx2JteHA5sSPVycN44jl8SxtQBZTHw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gFnKLTwecZBlwShlvoqwYUz7sHY6xarARy4kHYQL2uh7am7gnoPQ4CLOO740HjbvprGwcxWWRlwU4wKZs/1ulruPhXp0E6PY0rKdnq67Nw1J7LREC8KYxeUadiKto2oHChJwFaZVDKVDWT//UalO0/WuZiwXny9k1MKJyBptPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHRNFLhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C8CC4CEF0;
	Wed,  3 Sep 2025 04:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756875498;
	bh=6YJvO7PqsDrEvLx2JteHA5sSPVycN44jl8SxtQBZTHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHRNFLhQh+CxZitPcxGq0MmzpR0gHMbqTumPkFZKSLS1jgT5b0kVXbXhWc/Pvdxsq
	 RsNZjGr70W6P93yRbsaOro7UK+llD/EXQ0e3fIWkdW/OUAV0zkpkUGIuXPtAC1XQSr
	 aZn3ox+K9cek1H/kDmIg6KLBhcslnlqdT/TxpqOcok4yzPr65Ji4pHjSkJB6CioEIZ
	 mTiHxFltJ3QvXv5hIi3YkbFtWGl9DH/Gm0EcblCyeNRf6pEEq7Ayj69TfR8wcV/+9Q
	 RrJKVnC8aON60DMRGR3DyEKleqf27d0g9yduDWZ0WbzKRr0N6dJH8gJqc3MJc3bco5
	 cj1PJVVYYGJlg==
Date: Wed, 3 Sep 2025 13:58:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 12/24] tracing: selftests: Add trace remote tests
Message-Id: <20250903135814.57c4ec19de536032c640b755@kernel.org>
In-Reply-To: <20250821081412.1008261-13-vdonnefort@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
	<20250821081412.1008261-13-vdonnefort@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 09:14:00 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Exercise the tracefs interface for trace remote with a set of tests to
> check:
> 
>   * loading/unloading (unloading.tc)
>   * reset (reset.tc)
>   * size changes (buffer_size.tc)
>   * event integrity (trace_pipe)
> 
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/buffer_size.tc
> new file mode 100644
> index 000000000000..60bf431ccc91
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/buffer_size.tc
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Test trace remote buffer size

I think this test requires `remotes/`. If so, please add

# requires: remotes

Then this test will be skipped if it is not enabled.

> +
> +. $TEST_DIR/remotes/functions
> +
> +test_buffer_size()
> +{
> +    echo 0 > tracing_on
> +    assert_unloaded
> +
> +    echo 4096 > buffer_size_kb
> +    echo 1 > tracing_on
> +    assert_loaded
> +
> +    echo 0 > tracing_on
> +    echo 7 > buffer_size_kb
> +}
> +
> +if [ -z "$SOURCE_REMOTE_TEST" ]; then
> +    set -e
> +    setup_remote_test
> +    test_buffer_size
> +fi
> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
> new file mode 100644
> index 000000000000..504a495b3b1b
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +setup_remote()
> +{
> +	local name=$1
> +
> +	[ -e $TRACING_DIR/remotes/$name/write_event ] || exit_unresolved
> +
> +	cd remotes/$name/
> +	echo 0 > tracing_on
> +	clear_trace
> +	echo 7 > buffer_size_kb
> +	echo 0 > events/enable
> +	echo 1 > events/$name/selftest/enable
> +	echo 1 > tracing_on
> +}
> +
> +setup_remote_test()
> +{
> +	[ -d $TRACING_DIR/remotes/test/ ] || modprobe remote_test || exit_unresolved
> +
> +	setup_remote "test"
> +}
> +
> +assert_loaded()
> +{
> +	grep -q "(loaded)" buffer_size_kb
> +}
> +
> +assert_unloaded()
> +{
> +	grep -q "(unloaded)" buffer_size_kb
> +}
> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/reset.tc
> new file mode 100644
> index 000000000000..93d6eb2a807f
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/reset.tc
> @@ -0,0 +1,105 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Test trace remote reset

Ditto.

> +
> +. $TEST_DIR/remotes/functions
> +
> +get_cpu_ids()
> +{
> +    sed -n 's/^processor\s*:\s*\([0-9]\+\).*/\1/p' /proc/cpuinfo
> +}
> +
> +dump_trace()
> +{
> +    output=$(mktemp /tmp/remote_test.XXXXXX)

For the test-local temporary working directory, can you use $TMPDIR
instead of /tmp ? That directory is removed after running each test.

> +    cat trace_pipe > $output &
> +    pid=$!
> +    sleep 1
> +    kill -1 $pid
> +
> +    echo $output
> +}
> +
> +check_reset()
> +{
> +    write_event_path="write_event"
> +    taskset=""
> +
> +    clear_trace
> +
> +    # Is the buffer empty?
> +    output=$(dump_trace)
> +    test $(wc -l $output | cut -d ' ' -f1) -eq 0
> +
> +    if $(echo $(pwd) | grep -q "per_cpu/cpu"); then
> +        write_event_path="../../write_event"
> +        cpu_id=$(echo $(pwd) | sed -e 's/.*per_cpu\/cpu//')
> +        taskset="taskset -c $cpu_id"
> +    fi
> +    rm $output
> +
> +    # Can we properly write a new event?
> +    $taskset echo 7890 > $write_event_path
> +    output=$(dump_trace)
> +    test $(wc -l $output | cut -d ' ' -f1) -eq 1
> +    grep -q "id=7890" $output
> +    rm $output
> +}
> +
> +test_global_interface()
> +{
> +    output=$(mktemp /tmp/remote_test.XXXXXX)
> +
> +    # Confidence check
> +    echo 123456 > write_event
> +    output=$(dump_trace)
> +    grep -q "id=123456" $output
> +    rm $output
> +
> +    # Reset single event
> +    echo 1 > write_event
> +    check_reset
> +
> +    # Reset lost events
> +    for i in $(seq 1 10000); do
> +        echo 1 > write_event
> +    done
> +    check_reset
> +}
> +
> +test_percpu_interface()
> +{
> +    [ "$(get_cpu_ids | wc -l)" -ge 2 ] || return 0
> +
> +    for cpu in $(get_cpu_ids); do
> +        taskset -c $cpu echo 1 > write_event
> +    done
> +
> +    check_non_empty=0
> +    for cpu in $(get_cpu_ids); do
> +        cd per_cpu/cpu$cpu/
> +
> +        if [ $check_non_empty -eq 0 ]; then
> +            check_reset
> +            check_non_empty=1
> +        else
> +            # Check we have only reset 1 CPU
> +            output=$(dump_trace)
> +            test $(wc -l $output | cut -d ' ' -f1) -eq 1
> +            rm $output
> +        fi
> +        cd -
> +    done
> +}
> +
> +test_reset()
> +{
> +    test_global_interface
> +    test_percpu_interface
> +}
> +
> +if [ -z "$SOURCE_REMOTE_TEST" ]; then
> +    set -e
> +    setup_remote_test
> +    test_reset
> +fi
> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
> new file mode 100644
> index 000000000000..f4bd2b3655e0
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Test trace remote trace_pipe

Ditto.

> +
> +. $TEST_DIR/remotes/functions
> +
> +test_trace_pipe()
> +{
> +    echo 0 > tracing_on
> +    assert_unloaded
> +
> +    echo 1024 > buffer_size_kb
> +    echo 1 > tracing_on
> +    assert_loaded
> +
> +    output=$(mktemp /tmp/remote_test.XXXXXX)
> +
> +    cat trace_pipe > $output &
> +    pid=$!
> +
> +    for i in $(seq 1 1000); do
> +        echo $i > write_event
> +    done
> +
> +    echo 0 > tracing_on
> +    sleep 1
> +    kill $pid
> +
> +    prev_ts=0 # TODO: Init with proper clock value
> +    prev_id=0
> +
> +    # Only keep <timestamp> <id>
> +    sed -i -e 's/\[[0-9]*\]\s*\([0-9]*.[0-9]*\): [a-z]* id=\([0-9]*\)/\1 \2/' $output
> +
> +    IFS=$'\n'

This fails checkbashisms test. Can you use printf for this?

IFS=$(printf "\n")


> +    for line in $(cat $output); do
> +        ts=$(echo $line | cut -d ' ' -f 1)
> +        id=$(echo $line | cut -d ' ' -f 2)
> +
> +        test $(echo "$ts>$prev_ts" | bc) -eq 1
> +        test $id -eq $((prev_id + 1))
> +
> +        prev_ts=$ts
> +        prev_id=$id
> +    done
> +
> +    test $prev_id -eq 1000
> +
> +    rm $output
> +}
> +
> +if [ -z "$SOURCE_REMOTE_TEST" ]; then
> +    set -e
> +
> +    setup_remote_test
> +    test_trace_pipe
> +fi
> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/unloading.tc
> new file mode 100644
> index 000000000000..99f97e100fde
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/unloading.tc
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Test trace remote unloading

Here, please add "requires: remotes" line.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

