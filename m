Return-Path: <linux-kselftest+bounces-20868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700809B3E53
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D141B283431
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98571F7081;
	Mon, 28 Oct 2024 23:14:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C6B1F4289;
	Mon, 28 Oct 2024 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730157294; cv=none; b=sIYDjm0YhUL5GjKvibQaLfAIlZAH99q1/BBv69FZKtAvAJH34IWvRMPJh7zqW4HRJ99RJ6n0v2pHypeRAmySydqn+GqT58CeiF5zG2WKIj6nTjj9FUZ5qNviuuPvdtb4JFPYDpcEg2AZu5hVYK2gYmMueKPmC/gFFI8xonEPzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730157294; c=relaxed/simple;
	bh=lqyVSJ2w1DxLy2GBz8KBZdaDPKrCBTviZxwWmviKDx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyw1E1tjqt8gRyafCMNRlf0SP1vTPHnJwlEliCZxOZPzLcJHV5TrwykIT2Ym4CfcLvn4GoAVKmHmrKgq0VpF8MFu5A4Rd7jFybWD8ZF8/Ymgscij+P8wi+cCJu+1i9rK2etbJc9+nHHVWO+zFiv4WKZ9Pyhm65ON6J16f0s9Jls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D52C4CECD;
	Mon, 28 Oct 2024 23:14:51 +0000 (UTC)
Date: Mon, 28 Oct 2024 19:14:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: dhowells@redhat.com, mhiramat@kernel.org, surenb@google.com,
 jyescas@google.com, kernel-team@android.com, android-mm@google.com, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 Ali Zahraee <ahzahraee@gmail.com>, Eric Sandeen <sandeen@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing/selftests: Add tracefs mount options test
Message-ID: <20241028191448.5f62531a@rorschach.local.home>
In-Reply-To: <20241028214550.2099923-3-kaleshsingh@google.com>
References: <20241028214550.2099923-1-kaleshsingh@google.com>
	<20241028214550.2099923-3-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 14:43:58 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> Add test to check the tracefs gid mount option is applied correctly
> 
>    ./ftracetest test.d/00basic/mount_options.tc
> 
> Use the new readme string "[gid=<gid>] as a requirement and also update
> test_ownership.tc requirements to use this.
> 
> mount_options.tc will fail currently, this is fixed by the subsequent
> patch in this series.

Test cases should never be added when they can fail. They should always
come after the fix is applied. But it appears that you check the README
to make sure that it does work and not fail.

I'll take a look at these patches in more detail later.

Thanks,

-- Steve


> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++++
>  .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
>  .../testing/selftests/ftrace/test.d/functions |  25 +++++
>  3 files changed, 129 insertions(+), 13 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
> new file mode 100644
> index 000000000000..b8aff85ec259
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Test tracefs GID mount option
> +# requires: "[gid=<gid>]":README
> +
> +fail() {
> +	local msg="$1"
> +
> +	echo "FAILED: $msg"
> +	exit_fail
> +}
> +
> +find_alternate_gid() {
> +	local original_gid="$1"
> +	tac /etc/group | grep -v ":$original_gid:" | head -1 | cut -d: -f3
> +}
> +
> +mount_tracefs_with_options() {
> +	local mount_point="$1"
> +	local options="$2"
> +
> +	mount -t tracefs -o "$options" nodev "$mount_point"
> +
> +	setup
> +}
> +
> +unmount_tracefs() {
> +	local mount_point="$1"
> +
> +	# Need to make sure the mount isn't busy so that we can umount it
> +	(cd $mount_point; finish_ftrace;)
> +
> +	cleanup
> +}
> +
> +create_instance() {
> +	local mount_point="$1"
> +	local instance="$mount_point/instances/$(mktemp -u test-XXXXXX)"
> +
> +	mkdir "$instance"
> +	echo "$instance"
> +}
> +
> +remove_instance() {
> +	local instance="$1"
> +
> +	rmdir "$instance"
> +}
> +
> +check_gid() {
> +	local mount_point="$1"
> +	local expected_gid="$2"
> +
> +	echo "Checking permission group ..."
> +
> +	cd "$mount_point"
> +
> +	for file in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable"; do
> +		local gid=`stat -c "%g" $file`
> +		if [ "$gid" -ne "$expected_gid" ]; then
> +			cd - # Return to the previous working direcotry (tracefs root)
> +			fail "$(realpath $file): Expected group $expected_gid; Got group $gid"
> +		fi
> +	done
> +
> +	cd - # Return to the previous working direcotry (tracefs root)
> +}
> +
> +test_gid_mount_option() {
> +	local mount_point=$(get_mount_point)
> +	local mount_options=$(get_mnt_options "$mount_point")
> +	local original_group=$(stat -c "%g" .)
> +	local other_group=$(find_alternate_gid "$original_group")
> +
> +	# Set up mount options with new GID for testing
> +	local new_options=`echo "$mount_options" | sed -e "s/gid=[0-9]*/gid=$other_group/"`
> +	if [ "$new_options" = "$mount_options" ]; then
> +		new_options="$mount_options,gid=$other_group"
> +		mount_options="$mount_options,gid=$original_group"
> +	fi
> +
> +	# Unmount existing tracefs instance and mount with new GID
> +	unmount_tracefs "$mount_point"
> +	mount_tracefs_with_options "$mount_point" "$new_options"
> +
> +	check_gid "$mount_point" "$other_group"
> +
> +	# Check that files created after the mount inherit the GID
> +	local instance=$(create_instance "$mount_point")
> +	check_gid "$instance" "$other_group"
> +	remove_instance "$instance"
> +
> +	# Unmount and remount with the original GID
> +	unmount_tracefs "$mount_point"
> +	mount_tracefs_with_options "$mount_point" "$mount_options"
> +	check_gid "$mount_point" "$original_group"
> +}
> +
> +test_gid_mount_option
> +
> +exit 0
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> index 094419e190c2..e71cc3ad0bdf 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> @@ -1,24 +1,14 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Test file and directory ownership changes for eventfs
> +# requires: "[gid=<gid>]":README
>  
>  original_group=`stat -c "%g" .`
>  original_owner=`stat -c "%u" .`
>  
> -mount_point=`stat -c '%m' .`
> +local mount_point=$(get_mount_point)
>  
> -# If stat -c '%m' does not work (e.g. busybox) or failed, try to use the
> -# current working directory (which should be a tracefs) as the mount point.
> -if [ ! -d "$mount_point" ]; then
> -	if mount | grep -qw $PWD ; then
> -		mount_point=$PWD
> -	else
> -		# If PWD doesn't work, that is an environmental problem.
> -		exit_unresolved
> -	fi
> -fi
> -
> -mount_options=`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).*/\1/'`
> +mount_options=$(get_mnt_options "$mount_point")
>  
>  # find another owner and group that is not the original
>  other_group=`tac /etc/group | grep -v ":$original_group:" | head -1 | cut -d: -f3`
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 779f3e62ec90..84d6a9c7ad67 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -193,3 +193,28 @@ ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
>      # "  Command: " and "^\n" => 13
>      test $(expr 13 + $pos) -eq $N
>  }
> +
> +# Helper to get the tracefs mount point
> +get_mount_point() {
> +	local mount_point=`stat -c '%m' .`
> +
> +	# If stat -c '%m' does not work (e.g. busybox) or failed, try to use the
> +	# current working directory (which should be a tracefs) as the mount point.
> +	if [ ! -d "$mount_point" ]; then
> +		if mount | grep -qw "$PWD"; then
> +			mount_point=$PWD
> +		else
> +			# If PWD doesn't work, that is an environmental problem.
> +			exit_unresolved
> +		fi
> +	fi
> +	echo "$mount_point"
> +}
> +
> +# Helper function to retrieve mount options for a given mount point
> +get_mnt_options() {
> +	local mnt_point="$1"
> +	local opts=$(mount | grep -m1 "$mnt_point" | sed -e 's/.*(\(.*\)).*/\1/')
> +
> +	echo "$opts"
> +}
> \ No newline at end of file


