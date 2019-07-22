Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4472B701DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2019 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfGVOFs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jul 2019 10:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbfGVOFs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jul 2019 10:05:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E4F630821A3;
        Mon, 22 Jul 2019 14:05:48 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-124-112.rdu2.redhat.com [10.10.124.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 881E9620CE;
        Mon, 22 Jul 2019 14:05:47 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, Jiri Benc <jbenc@redhat.com>
Subject: [PATCH v3] selftests/livepatch: add test skip handling
Date:   Mon, 22 Jul 2019 10:05:44 -0400
Message-Id: <20190722140544.29867-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 22 Jul 2019 14:05:48 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a skip() message function that stops the test, logs an explanation,
and sets the "skip" return code (4).

Before loading a livepatch self-test kernel module, first verify that
we've built and installed it by running a 'modprobe --dry-run'.  This
should catch a few environment issues, including !CONFIG_LIVEPATCH and
!CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
skip() function.

Reported-by: Jiri Benc <jbenc@redhat.com>
Suggested-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---

v3: tweak modprobe error message: check kernel config and run as root,
so output now looks like [shuah] :

  % make run_tests
  TAP version 13
  1..3
  # selftests: livepatch: test-livepatch.sh
  # TEST: basic function patching ... SKIP: unable load module test_klp_livepatch, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root
  not ok 1 selftests: livepatch: test-livepatch.sh # SKIP
  # selftests: livepatch: test-callbacks.sh
  # TEST: target module before livepatch ... SKIP: unable load module test_klp_callbacks_mod, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root
  not ok 2 selftests: livepatch: test-callbacks.sh # SKIP
  # selftests: livepatch: test-shadow-vars.sh
  # TEST: basic shadow variable API ... SKIP: unable load module test_klp_shadow_vars, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root
  not ok 3 selftests: livepatch: test-shadow-vars.sh # SKIP

v2: move assert_mod() call into load_mod() and load_lp_nowait(), before
    they check whether the module is a livepatch or not (a test-failing
    assertion). [mbenes, pmladek]

 .../testing/selftests/livepatch/functions.sh  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 30195449c63c..8eb21fcc71de 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -13,6 +13,14 @@ function log() {
 	echo "$1" > /dev/kmsg
 }
 
+# skip(msg) - testing can't proceed
+#	msg - explanation
+function skip() {
+	log "SKIP: $1"
+	echo "SKIP: $1" >&2
+	exit 4
+}
+
 # die(msg) - game over, man
 #	msg - dying words
 function die() {
@@ -43,6 +51,12 @@ function loop_until() {
 	done
 }
 
+function assert_mod() {
+	local mod="$1"
+
+	modprobe --dry-run "$mod" &>/dev/null
+}
+
 function is_livepatch_mod() {
 	local mod="$1"
 
@@ -75,6 +89,9 @@ function __load_mod() {
 function load_mod() {
 	local mod="$1"; shift
 
+	assert_mod "$mod" ||
+		skip "unable load module ${mod}, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root"
+
 	is_livepatch_mod "$mod" &&
 		die "use load_lp() to load the livepatch module $mod"
 
@@ -88,6 +105,9 @@ function load_mod() {
 function load_lp_nowait() {
 	local mod="$1"; shift
 
+	assert_mod "$mod" ||
+		skip "unable load module ${mod}, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root"
+
 	is_livepatch_mod "$mod" ||
 		die "module $mod is not a livepatch"
 
-- 
2.21.0

