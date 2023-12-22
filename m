Return-Path: <linux-kselftest+bounces-2401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B444F81CD26
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D898E1C22704
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE376250EE;
	Fri, 22 Dec 2023 16:33:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD024B4D;
	Fri, 22 Dec 2023 16:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E88C433C9;
	Fri, 22 Dec 2023 16:33:54 +0000 (UTC)
Date: Fri, 22 Dec 2023 11:34:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Linux
 selftests <linux-kselftest@vger.kernel.org>
Subject: [PATCH v4] tracing/selftests: Add ownership modification tests for
 eventfs
Message-ID: <20231222113459.4d645bfc@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

As there were bugs found with the ownership of eventfs dynamic file
creation. Add a test to test it.

It will remount tracefs with a different gid and check the ownership of
the eventfs directory, as well as the system and event directories. It
will also check the event file directories.

It then does a chgrp on each of these as well to see if they all get
updated as expected.

Then it remounts the tracefs file system back to the original group and
makes sure that all the updated files and directories were reset back to
the original ownership.

It does the same for instances that change the ownership of he instance
directory.

Note, because the uid is not reset by a remount, it is tested for every
file by switching it to a new owner and then back again.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v3: https://lore.kernel.org/linux-trace-kernel/20231221211229.13398ef3@gandalf.local.home

- Added missing SPDX and removed exec permission from file (Shuah Khan)

 .../ftrace/test.d/00basic/test_ownership.tc   | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
new file mode 100644
index 000000000000..add7d5bf585d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
@@ -0,0 +1,114 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test file and directory owership changes for eventfs
+
+original_group=`stat -c "%g" .`
+original_owner=`stat -c "%u" .`
+
+mount_point=`stat -c '%m' .`
+mount_options=`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).*/\1/'`
+
+# find another owner and group that is not the original
+other_group=`tac /etc/group | grep -v ":$original_group:" | head -1 | cut -d: -f3`
+other_owner=`tac /etc/passwd | grep -v ":$original_owner:" | head -1 | cut -d: -f3`
+
+# Remove any group ownership already
+new_options=`echo "$mount_options" | sed -e "s/gid=[0-9]*/gid=$other_group/"`
+
+if [ "$new_options" = "$mount_options" ]; then
+	new_options="$mount_options,gid=$other_group"
+	mount_options="$mount_options,gid=$original_group"
+fi
+
+canary="events/timer events/timer/timer_cancel events/timer/timer_cancel/format"
+
+test() {
+	file=$1
+	test_group=$2
+
+	owner=`stat -c "%u" $file`
+	group=`stat -c "%g" $file`
+
+	echo "testing $file $owner=$original_owner and $group=$test_group"
+	if [ $owner -ne $original_owner ]; then
+		exit_fail
+	fi
+	if [ $group -ne $test_group ]; then
+		exit_fail
+	fi
+
+	# Note, the remount does not update ownership so test going to and from owner
+	echo "test owner $file to $other_owner"
+	chown $other_owner $file
+	owner=`stat -c "%u" $file`
+	if [ $owner -ne $other_owner ]; then
+		exit_fail
+	fi
+
+	chown $original_owner $file
+	owner=`stat -c "%u" $file`
+	if [ $owner -ne $original_owner ]; then
+		exit_fail
+	fi
+
+}
+
+run_tests() {
+	for d in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
+		test "$d" $other_group
+	done
+
+	chgrp $original_group events
+	test "events" $original_group
+	for d in "." "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
+		test "$d" $other_group
+	done
+
+	chgrp $original_group events/sched
+	test "events/sched" $original_group
+	for d in "." "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
+		test "$d" $other_group
+	done
+
+	chgrp $original_group events/sched/sched_switch
+	test "events/sched/sched_switch" $original_group
+	for d in "." "events/sched/sched_switch/enable" $canary; do
+		test "$d" $other_group
+	done
+
+	chgrp $original_group events/sched/sched_switch/enable
+	test "events/sched/sched_switch/enable" $original_group
+	for d in "." $canary; do
+		test "$d" $other_group
+	done
+}
+
+mount -o remount,"$new_options" .
+
+run_tests
+
+mount -o remount,"$mount_options" .
+
+for d in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
+	test "$d" $original_group
+done
+
+# check instances as well
+
+chgrp $other_group instances
+
+instance="$(mktemp -u test-XXXXXX)"
+
+mkdir instances/$instance
+
+cd instances/$instance
+
+run_tests
+
+cd ../..
+
+rmdir instances/$instance
+
+chgrp $original_group instances
+
+exit 0
-- 
2.42.0


