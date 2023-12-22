Return-Path: <linux-kselftest+bounces-2327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5BC81C2AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 02:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8AC1C233A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 01:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF9819;
	Fri, 22 Dec 2023 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZrGngBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83017C2;
	Fri, 22 Dec 2023 01:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F37C433C8;
	Fri, 22 Dec 2023 01:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703208113;
	bh=NyoPIEVyRa8tWludrgC4X0lHlJeOs+4No+Ye6yr7bSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UZrGngBaQYTzynCy+27xDvzHbS/z0OnScRJuJS7tDMfuwrLlOA51VO+kC5aQWqG6z
	 Q8ZAMcGi20Y85mkXARFh5helUw16tLH5cv/3gI8ykyPbpvmereB2JOTBen9Ct2X2WC
	 XCgyrpYjmewisdWcLoM7TrqU1CVsvMSI+Rf1SwulDElMKaLDV7SiKFEq88aXSDjdSB
	 BmrU4RcXLv/CsvjDgc7Xb1EPMTu6jGN1I1xeF0LQ8ngob6YixRDBrdjxzysJVdwoR1
	 eRQF8B0Ejyzvp0k7wUYnK3MXm2IKyviNZsI2ATsnxq8blbVKVUgRzpbc3OA/1qIJe3
	 p+fTMuHV0V1GA==
Date: Fri, 22 Dec 2023 10:21:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Linux
 selftests <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/selftests: Add ownership modification tests
 for eventfs
Message-Id: <20231222102148.2aa3863d7c11f3928549335a@kernel.org>
In-Reply-To: <20231221194516.53e1ee43@gandalf.local.home>
References: <20231221194516.53e1ee43@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

On Thu, 21 Dec 2023 19:45:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As there were bugs found with the ownership of eventfs dynamic file
> creation. Add a test to test it.
> 
> It will remount tracefs with a different gid and check the ownership of
> the eventfs directory, as well as the system and event directories. It
> will also check the event file directories.
> 
> It then does a chgrp on each of these as well to see if they all get
> updated as expected.
> 
> Then it remounts the tracefs file system back to the original group and
> makes sure that all the updated files and directories were reset back to
> the original ownership.
> 
> It does the same for instances that change the ownership of he instance
> directory.
> 
> Note, because the uid is not reset by a remount, it is tested for every
> file by switching it to a new owner and then back again.
> 

The testcase itself is OK but is there any way to identify the system
supports eventfs or not? I ran this test on v6.5.13 for checking then
it failed. We may need to skip (unsupported) this test for such case.

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/20231221193551.13a0b7bd@gandalf.local.home
> 
> - Fixed a cut and paste error of using $original_group for finding another uid
> 
>  .../ftrace/test.d/00basic/test_ownership.tc   | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100755 tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> new file mode 100755
> index 000000000000..83cbd116d06b
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> @@ -0,0 +1,113 @@
> +#!/bin/sh
> +# description: Test file and directory owership changes for eventfs
> +
> +original_group=`stat -c "%g" .`
> +original_owner=`stat -c "%u" .`
> +
> +mount_point=`stat -c '%m' .`
> +mount_options=`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).*/\1/'`
> +
> +# find another owner and group that is not the original
> +other_group=`tac /etc/group | grep -v ":$original_group:" | head -1 | cut -d: -f3`
> +other_owner=`tac /etc/passwd | grep -v ":$original_owner:" | head -1 | cut -d: -f3`
> +
> +# Remove any group ownership already
> +new_options=`echo "$mount_options" | sed -e "s/gid=[0-9]*/gid=$other_group/"`
> +
> +if [ "$new_options" = "$mount_options" ]; then
> +	new_options="$mount_options,gid=$other_group"
> +	mount_options="$mount_options,gid=$original_group"
> +fi
> +
> +canary="events/timer events/timer/timer_cancel events/timer/timer_cancel/format"
> +
> +test() {
> +	file=$1
> +	test_group=$2
> +
> +	owner=`stat -c "%u" $file`
> +	group=`stat -c "%g" $file`
> +
> +	echo "testing $file $owner=$original_owner and $group=$test_group"
> +	if [ $owner -ne $original_owner ]; then
> +		exit_fail
> +	fi
> +	if [ $group -ne $test_group ]; then
> +		exit_fail
> +	fi
> +
> +	# Note, the remount does not update ownership so test going to and from owner
> +	echo "test owner $file to $other_owner"
> +	chown $other_owner $file
> +	owner=`stat -c "%u" $file`
> +	if [ $owner -ne $other_owner ]; then
> +		exit_fail
> +	fi
> +
> +	chown $original_owner $file
> +	owner=`stat -c "%u" $file`
> +	if [ $owner -ne $original_owner ]; then
> +		exit_fail
> +	fi
> +
> +}
> +
> +run_tests() {
> +	for d in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
> +		test "$d" $other_group
> +	done
> +
> +	chgrp $original_group events
> +	test "events" $original_group
> +	for d in "." "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
> +		test "$d" $other_group
> +	done
> +
> +	chgrp $original_group events/sched
> +	test "events/sched" $original_group
> +	for d in "." "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
> +		test "$d" $other_group
> +	done
> +
> +	chgrp $original_group events/sched/sched_switch
> +	test "events/sched/sched_switch" $original_group
> +	for d in "." "events/sched/sched_switch/enable" $canary; do
> +		test "$d" $other_group
> +	done
> +
> +	chgrp $original_group events/sched/sched_switch/enable
> +	test "events/sched/sched_switch/enable" $original_group
> +	for d in "." $canary; do
> +		test "$d" $other_group
> +	done
> +}
> +
> +mount -o remount,"$new_options" .
> +
> +run_tests
> +
> +mount -o remount,"$mount_options" .
> +
> +for d in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
> +	test "$d" $original_group
> +done
> +
> +# check instances as well
> +
> +chgrp $other_group instances
> +
> +instance="foo-$(mktemp -u XXXXX)"
> +
> +mkdir instances/$instance
> +
> +cd instances/$instance
> +
> +run_tests
> +
> +cd ../..
> +
> +rmdir instances/$instance
> +
> +chgrp $original_group instances
> +
> +exit 0
> -- 
> 2.42.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

