Return-Path: <linux-kselftest+bounces-42454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDCEBA3389
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470C93BF8D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507032BD015;
	Fri, 26 Sep 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESSndw9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884AA2BE658
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880004; cv=none; b=CkY8HriPZSxN7FtTSTEPU0RhSm5MArbgpBSThY3IuOMNWNCdTb80XJhRzUr9M6ssIAk/hC2x3eWo4x1XEmyV0kaOUCeywphBWG/jYrlpHulnFiYco1RGkd5Kf8n4+cfMiOqM7+gigLXpLAGjgXzRrGyfak+sIlnM8iFilIeTQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880004; c=relaxed/simple;
	bh=erRWOVf7BAh31nNNIGdtBivhm5veAeT5yZ7hImoYeV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT925rtXFqvMzyJgUKay38F+5NHePi71FXiPmNPM9YrOJDOfNF+X/V2Wi1OCsVK+yZ2zS9aa9b/pZS9xaSpPvAdgOXl2a7HxP5YwjLxvX7OxrY+fZYlPyJJjQm99iambZEC8AkkFYJD2MKNyf486TJeR5lZ+u/K0iiAPUiF7OeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESSndw9q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758880001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ri7OxTEqx1F2zgmd879nrACSHnaIAJL7nd4jVykFk8=;
	b=ESSndw9q7OOA6o3TGLgZriQ9+B+Y4XdqnvOorW3R0AJxP+yBNfG7dtJPijbkBgGj2a9Lxy
	yQEAtqZkpmSgOeESPJHAo8ZQDzBKQJzoIUJUMDPJMg4ouOXBGl6szSAK1iSCm6iH8XEbYW
	V/7gJyHLOk0YS2yIxqW/DCP3uY7QfeI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-itJ2kWruM7ut_Xigye1eTg-1; Fri,
 26 Sep 2025 05:46:38 -0400
X-MC-Unique: itJ2kWruM7ut_Xigye1eTg-1
X-Mimecast-MFC-AGG-ID: itJ2kWruM7ut_Xigye1eTg_1758879997
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C59731800284;
	Fri, 26 Sep 2025 09:46:36 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.225.225])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92A0E1800446;
	Fri, 26 Sep 2025 09:46:32 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Waylon Cude <wcude@redhat.com>
Subject: [PATCH 1/2] selftest/ftrace: Generalise ftracetest to use with RV
Date: Fri, 26 Sep 2025 11:46:12 +0200
Message-ID: <20250926094613.34030-2-gmonaco@redhat.com>
In-Reply-To: <20250926094613.34030-1-gmonaco@redhat.com>
References: <20250926094613.34030-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The ftracetest script is a fairly complete test framework for tracefs-like
subsystem, but it can only be used for ftrace selftests.

If OPT_TEST_DIR is provided and includes a function file, use that as
test directory going forward rather than just grabbing tests from it.

Generalise function names like initialize_ftrace to initialize_system.

Add the --rv argument to set up the test for rv, basically changing the
trace directory to $TRACING_DIR/rv and displaying an error if that
cannot be found.

This prepares for rv selftests inclusion.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/testing/selftests/ftrace/ftracetest     | 34 +++++++++++++------
 .../ftrace/test.d/00basic/mount_options.tc    |  2 +-
 .../testing/selftests/ftrace/test.d/functions |  6 ++--
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index cce72f8b03dc..3230bd54dba8 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -22,6 +22,7 @@ echo "		--fail-unresolved Treat UNRESOLVED as a failure"
 echo "		-d|--debug Debug mode (trace all shell commands)"
 echo "		-l|--logdir <dir> Save logs on the <dir>"
 echo "		            If <dir> is -, all logs output in console only"
+echo "		--rv       Run RV selftests instead of ftrace ones"
 exit $1
 }
 
@@ -133,6 +134,10 @@ parse_opts() { # opts
       LINK_PTR=
       shift 2
     ;;
+    --rv)
+      RV_TEST=1
+      shift 1
+    ;;
     *.tc)
       if [ -f "$1" ]; then
         OPT_TEST_CASES="$OPT_TEST_CASES `abspath $1`"
@@ -152,9 +157,13 @@ parse_opts() { # opts
     ;;
     esac
   done
-  if [ ! -z "$OPT_TEST_CASES" ]; then
+  if [ -n "$OPT_TEST_CASES" ]; then
     TEST_CASES=$OPT_TEST_CASES
   fi
+  if [ -n "$OPT_TEST_DIR" -a -f "$OPT_TEST_DIR"/test.d/functions ]; then
+    TOP_DIR=$OPT_TEST_DIR
+    TEST_DIR=$TOP_DIR/test.d
+  fi
 }
 
 # Parameters
@@ -190,10 +199,6 @@ fi
 TOP_DIR=`absdir $0`
 TEST_DIR=$TOP_DIR/test.d
 TEST_CASES=`find_testcases $TEST_DIR`
-LOG_TOP_DIR=$TOP_DIR/logs
-LOG_DATE=`date +%Y%m%d-%H%M%S`
-LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
-LINK_PTR=$LOG_TOP_DIR/latest
 KEEP_LOG=0
 KTAP=0
 DEBUG=0
@@ -201,14 +206,23 @@ VERBOSE=0
 UNSUPPORTED_RESULT=0
 UNRESOLVED_RESULT=0
 STOP_FAILURE=0
+RV_TEST=0
 # Parse command-line options
 parse_opts $*
 
+LOG_TOP_DIR=$TOP_DIR/logs
+LOG_DATE=`date +%Y%m%d-%H%M%S`
+LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
+LINK_PTR=$LOG_TOP_DIR/latest
+
 [ $DEBUG -ne 0 ] && set -x
 
-# Verify parameters
-if [ -z "$TRACING_DIR" -o ! -d "$TRACING_DIR" ]; then
-  errexit "No ftrace directory found"
+if [ $RV_TEST -ne 0 ]; then
+	TRACING_DIR=$TRACING_DIR/rv
+	if [ ! -d "$TRACING_DIR" ]; then
+		err_ret=$err_skip
+		errexit "rv is not configured in this kernel"
+	fi
 fi
 
 # Preparing logs
@@ -419,7 +433,7 @@ trap 'SIG_RESULT=$XFAIL' $SIG_XFAIL
 __run_test() { # testfile
   # setup PID and PPID, $$ is not updated.
   (cd $TRACING_DIR; read PID _ < /proc/self/stat; set -e; set -x;
-   checkreq $1; initialize_ftrace; . $1)
+   checkreq $1; initialize_system; . $1)
   [ $? -ne 0 ] && kill -s $SIG_FAIL $SIG_PID
 }
 
@@ -496,7 +510,7 @@ for t in $TEST_CASES; do
     exit 1
   fi
 done
-(cd $TRACING_DIR; finish_ftrace) # for cleanup
+(cd $TRACING_DIR; finish_system) # for cleanup
 
 prlog ""
 prlog "# of passed: " `echo $PASSED_CASES | wc -w`
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
index 8a7ce647a60d..318939451caf 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
@@ -28,7 +28,7 @@ unmount_tracefs() {
 	local mount_point="$1"
 
 	# Need to make sure the mount isn't busy so that we can umount it
-	(cd $mount_point; finish_ftrace;)
+	(cd $mount_point; finish_system;)
 
 	cleanup
 }
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index a1052bf460fc..e8e718139294 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -104,7 +104,7 @@ clear_dynamic_events() { # reset all current dynamic events
     done
 }
 
-initialize_ftrace() { # Reset ftrace to initial-state
+initialize_system() { # Reset ftrace to initial-state
 # As the initial state, ftrace will be set to nop tracer,
 # no events, no triggers, no filters, no function filters,
 # no probes, and tracing on.
@@ -134,8 +134,8 @@ initialize_ftrace() { # Reset ftrace to initial-state
     enable_tracing
 }
 
-finish_ftrace() {
-    initialize_ftrace
+finish_system() {
+    initialize_system
 # And recover it to default.
     [ -f options/pause-on-trace ] && echo 0 > options/pause-on-trace
 }
-- 
2.51.0


