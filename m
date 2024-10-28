Return-Path: <linux-kselftest+bounces-20859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B031D9B3D7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703C128BF9E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 22:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD11EBA14;
	Mon, 28 Oct 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ltuu5R4S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786317D355
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153158; cv=none; b=jwlhVJ9wQi+5ZyBHj6q7+dKmjQqoLPVyUbMUzBYCrep21ELR5U9zFnCbp7rUuok/dmY7G071U4KDWXyIOusvyYekgNK51Fn7Ma07cWzI3yH3+Qf6odbbSNOAdz49Bu8TQcfpi3L8N4eLzYXj6848x6R+jQpSKpp+PbvS+ALekp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153158; c=relaxed/simple;
	bh=EmllJLfP0nLO3+si2cN9oyclRZPtfrj39zUndlbiJNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E3AodLIC2QsB48l9LzNR9Kq52P7Y4FbWZspNrtpnyvyYJOPC7OeZpeGged9KpiXcUlbMypnmPamBHIVPRhW6OnPPtxLW1S4JrPRO8Ntcq1JIO4sFF+oW/IJnXmx2s5d8KNeisWh8Mmvb6ER8yzLuOL++ZS51oDCQaoa6rZ5pI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ltuu5R4S; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293b3e014aso7893529276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730153154; x=1730757954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgXMA3H1i71vePLOcuFKt/eJvEilt9qljsSwQxbfxX0=;
        b=Ltuu5R4Sbpr4ZN0M6dvdhHpnmkkwzWkiHlVA7Pp5fyxc5Sb4Gr6leJCRfD+hmxs/b8
         wXhbVa2xLkkHabOg3NUhArBYu8m2njbzro09ZYiBKZDkzkw2bHoot7qwd8fAERMSYUZC
         BdAJZC0bF8APQqMtsDB2RnyZQ0biFTgsob9dxqdXBoJnGlctsT24Gi0rPxFNTlRIrUu2
         +e08xwgDK7cITIAshELE5jofXirKU2PWi1hUZTBMszt5Lv7wKDIEoyg94XtVN/uz7Scw
         GAEE/P7eyZ1DbBazPcDVXnx1Suo2yWFZgWwSWMa7662SchKZxYTqVgnbfKqd3gsNHW7m
         GWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153154; x=1730757954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgXMA3H1i71vePLOcuFKt/eJvEilt9qljsSwQxbfxX0=;
        b=Zybv7qDBfEfSt0Vfch4902XI23NYZNHMDeLFuhCipMpkcMg3K3ca86FKHAfsZm+o9V
         bTiXpt7hk/znlvcRsQgcwAL3dadKmtSlKXPFjTnu4T0guYxPa/Gyw66uhQnKpDtTxaUn
         1g+uyw0YzxTcwUrIfvYZoMfO4loy7AX91K2lauaINrH7LSFY2mWp4otF8oSYdFKKyvNB
         I6st9meyyv3EOtaYkBHicrDOwwHDbMDc9b+5kpHA/SSQQj+IIHiFdZrPuXGKrDZiG/dn
         XJoU4C2iBmVyTvES6Bb3uZ95BxRkLbR0XTV5xwEPqagfLk7Q7O+d3NYFR1FhVa9sgyUO
         yGig==
X-Forwarded-Encrypted: i=1; AJvYcCWtzV5H4km7iHZRSzf1yo50xKjlaqJqpsmPMFEMSOqO7nS3RAONfkXz/4jRUzv6Z30j4LwReZW5RsM4zKFJrMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJEwAulme2YVa1Qa1O5B8bFUJfA8Wba/RKTlW4ObxqeThUWYD6
	BJAusjFb0VPHKFi+Nxw3tY7e+rLnSHxeHYcwUtAVhAIo9iROGr09FTL8H91pVFXTUWtXEtNHkec
	FBvy+1gEvjFQnX/P/ix7Oqw==
X-Google-Smtp-Source: AGHT+IGF9Pi2lb2sUc0GUX/DYg5llr+NhdKdR00JACXX1x5oo3dzjoH/TRmaF857GPkgm+W8S7O8gnUmssb4hz0lRw==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:dd17:1d2c:7822:7fdf])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:1822:b0:e1c:ed3d:7bb7 with
 SMTP id 3f1490d57ef6-e308784a6eamr7475276.1.1730153153942; Mon, 28 Oct 2024
 15:05:53 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:43:58 -0700
In-Reply-To: <20241028214550.2099923-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241028214550.2099923-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028214550.2099923-3-kaleshsingh@google.com>
Subject: [PATCH 2/3] tracing/selftests: Add tracefs mount options test
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Eric Sandeen <sandeen@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add test to check the tracefs gid mount option is applied correctly

   ./ftracetest test.d/00basic/mount_options.tc

Use the new readme string "[gid=<gid>] as a requirement and also update
test_ownership.tc requirements to use this.

mount_options.tc will fail currently, this is fixed by the subsequent
patch in this series.

Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++++
 .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
 .../testing/selftests/ftrace/test.d/functions |  25 +++++
 3 files changed, 129 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
new file mode 100644
index 000000000000..b8aff85ec259
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
@@ -0,0 +1,101 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test tracefs GID mount option
+# requires: "[gid=<gid>]":README
+
+fail() {
+	local msg="$1"
+
+	echo "FAILED: $msg"
+	exit_fail
+}
+
+find_alternate_gid() {
+	local original_gid="$1"
+	tac /etc/group | grep -v ":$original_gid:" | head -1 | cut -d: -f3
+}
+
+mount_tracefs_with_options() {
+	local mount_point="$1"
+	local options="$2"
+
+	mount -t tracefs -o "$options" nodev "$mount_point"
+
+	setup
+}
+
+unmount_tracefs() {
+	local mount_point="$1"
+
+	# Need to make sure the mount isn't busy so that we can umount it
+	(cd $mount_point; finish_ftrace;)
+
+	cleanup
+}
+
+create_instance() {
+	local mount_point="$1"
+	local instance="$mount_point/instances/$(mktemp -u test-XXXXXX)"
+
+	mkdir "$instance"
+	echo "$instance"
+}
+
+remove_instance() {
+	local instance="$1"
+
+	rmdir "$instance"
+}
+
+check_gid() {
+	local mount_point="$1"
+	local expected_gid="$2"
+
+	echo "Checking permission group ..."
+
+	cd "$mount_point"
+
+	for file in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable"; do
+		local gid=`stat -c "%g" $file`
+		if [ "$gid" -ne "$expected_gid" ]; then
+			cd - # Return to the previous working direcotry (tracefs root)
+			fail "$(realpath $file): Expected group $expected_gid; Got group $gid"
+		fi
+	done
+
+	cd - # Return to the previous working direcotry (tracefs root)
+}
+
+test_gid_mount_option() {
+	local mount_point=$(get_mount_point)
+	local mount_options=$(get_mnt_options "$mount_point")
+	local original_group=$(stat -c "%g" .)
+	local other_group=$(find_alternate_gid "$original_group")
+
+	# Set up mount options with new GID for testing
+	local new_options=`echo "$mount_options" | sed -e "s/gid=[0-9]*/gid=$other_group/"`
+	if [ "$new_options" = "$mount_options" ]; then
+		new_options="$mount_options,gid=$other_group"
+		mount_options="$mount_options,gid=$original_group"
+	fi
+
+	# Unmount existing tracefs instance and mount with new GID
+	unmount_tracefs "$mount_point"
+	mount_tracefs_with_options "$mount_point" "$new_options"
+
+	check_gid "$mount_point" "$other_group"
+
+	# Check that files created after the mount inherit the GID
+	local instance=$(create_instance "$mount_point")
+	check_gid "$instance" "$other_group"
+	remove_instance "$instance"
+
+	# Unmount and remount with the original GID
+	unmount_tracefs "$mount_point"
+	mount_tracefs_with_options "$mount_point" "$mount_options"
+	check_gid "$mount_point" "$original_group"
+}
+
+test_gid_mount_option
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
index 094419e190c2..e71cc3ad0bdf 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
@@ -1,24 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test file and directory ownership changes for eventfs
+# requires: "[gid=<gid>]":README
 
 original_group=`stat -c "%g" .`
 original_owner=`stat -c "%u" .`
 
-mount_point=`stat -c '%m' .`
+local mount_point=$(get_mount_point)
 
-# If stat -c '%m' does not work (e.g. busybox) or failed, try to use the
-# current working directory (which should be a tracefs) as the mount point.
-if [ ! -d "$mount_point" ]; then
-	if mount | grep -qw $PWD ; then
-		mount_point=$PWD
-	else
-		# If PWD doesn't work, that is an environmental problem.
-		exit_unresolved
-	fi
-fi
-
-mount_options=`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).*/\1/'`
+mount_options=$(get_mnt_options "$mount_point")
 
 # find another owner and group that is not the original
 other_group=`tac /etc/group | grep -v ":$original_group:" | head -1 | cut -d: -f3`
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 779f3e62ec90..84d6a9c7ad67 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -193,3 +193,28 @@ ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
     # "  Command: " and "^\n" => 13
     test $(expr 13 + $pos) -eq $N
 }
+
+# Helper to get the tracefs mount point
+get_mount_point() {
+	local mount_point=`stat -c '%m' .`
+
+	# If stat -c '%m' does not work (e.g. busybox) or failed, try to use the
+	# current working directory (which should be a tracefs) as the mount point.
+	if [ ! -d "$mount_point" ]; then
+		if mount | grep -qw "$PWD"; then
+			mount_point=$PWD
+		else
+			# If PWD doesn't work, that is an environmental problem.
+			exit_unresolved
+		fi
+	fi
+	echo "$mount_point"
+}
+
+# Helper function to retrieve mount options for a given mount point
+get_mnt_options() {
+	local mnt_point="$1"
+	local opts=$(mount | grep -m1 "$mnt_point" | sed -e 's/.*(\(.*\)).*/\1/')
+
+	echo "$opts"
+}
\ No newline at end of file
-- 
2.47.0.163.g1226f6d8fa-goog


