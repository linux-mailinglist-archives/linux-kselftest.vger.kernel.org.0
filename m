Return-Path: <linux-kselftest+bounces-43376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CCCBE875A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 13:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DA5735CC44
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 11:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B262E5B26;
	Fri, 17 Oct 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYJkKUaP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3C2D9EDF
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701941; cv=none; b=mZBF+TUDfq3lI+JNl7tWD/ipH2w4lYQ6tz/i6qB3v6lQcCbF0Sg5LMAAjWY2QuGHqrp6BPqVMaJeg82PYntKJvR/P2s4FkLAz21T7Qp3LwdooVUpJ0v5yOqWPvINied7sARHX4W/+L6PK4PHa2VJ3GDbjBWj7fZGW13nd+VEQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701941; c=relaxed/simple;
	bh=erRWOVf7BAh31nNNIGdtBivhm5veAeT5yZ7hImoYeV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojvAnj4Ia5ahyxEgW4bUfT3DjXwitA16O69dLhBbMfl/znmQidqZkSAwApxm3RHdDbkDLfyNGIG/1mlLLL/H3VTfqmxcBVoQmIo1shyhdQEFSGvEO4TL6a9lMb9OE9Bb4s4R4nTep8ToGYPs1A0UweY5ZPvPfV4sWvTnD8wuouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYJkKUaP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760701939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ri7OxTEqx1F2zgmd879nrACSHnaIAJL7nd4jVykFk8=;
	b=UYJkKUaPfw36U8mdzQ8gQG03WhV0urYXUdxVoCsFr5ovGw2dlHYr+8I1j/s+rweVJutjjO
	m+h7CkvpAjCRlnPlj5fRk5ZpI/3Kt9KUA68h/Z/m3EjdT763xyv55JSDs36vxn4P48ONS2
	6dsEdJANIgSN41MtjsK7nYt6TsQgarw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-oKwHLChKMWOA3aDLwzOpFg-1; Fri,
 17 Oct 2025 07:52:18 -0400
X-MC-Unique: oKwHLChKMWOA3aDLwzOpFg-1
X-Mimecast-MFC-AGG-ID: oKwHLChKMWOA3aDLwzOpFg_1760701936
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E18D180A228;
	Fri, 17 Oct 2025 11:52:16 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.33.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E920C300019F;
	Fri, 17 Oct 2025 11:52:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Waylon Cude <wcude@redhat.com>
Subject: [PATCH v2 1/2] selftest/ftrace: Generalise ftracetest to use with RV
Date: Fri, 17 Oct 2025 13:52:02 +0200
Message-ID: <20251017115203.140080-2-gmonaco@redhat.com>
In-Reply-To: <20251017115203.140080-1-gmonaco@redhat.com>
References: <20251017115203.140080-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


