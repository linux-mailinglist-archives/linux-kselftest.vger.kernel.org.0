Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22F91F5A2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 19:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgFJRVL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 13:21:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30479 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727931AbgFJRVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 13:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591809668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwokYWzqDrOxPRws4POBhs9ccT6l1S+fFHgfZOKR8iI=;
        b=BkCHkPZwSG3bm3InsNOV13aT6QcqI2GAw0QVamjqzI9IUsZbCHpBOdGn7EDG//jU/lu9zt
        qfKCA3fZuANPZaDnDupf8CqM+wEju/6s5zJadBLyiwki1k1EPTv0uGRtNd+coV1FEGPokd
        WdcWS7/Lr29Gd9EQFl0qNUcaX9mgUhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-f9SpL4cLNHGnLH02Zx5HWA-1; Wed, 10 Jun 2020 13:21:05 -0400
X-MC-Unique: f9SpL4cLNHGnLH02Zx5HWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B959B8018A5;
        Wed, 10 Jun 2020 17:21:04 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-117-142.rdu2.redhat.com [10.10.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DBFD1944D;
        Wed, 10 Jun 2020 17:21:04 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] selftests/livepatch: use $(dmesg --notime) instead of manually filtering
Date:   Wed, 10 Jun 2020 13:21:00 -0400
Message-Id: <20200610172101.21910-3-joe.lawrence@redhat.com>
In-Reply-To: <20200610172101.21910-1-joe.lawrence@redhat.com>
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The dmesg utility already comes with a command line switch to omit
kernel timestamps, let's use it instead of applying an extra regex to
filter them out.

Now without the '[timestamp]: ' prefix at the beginning of the log
entry, revise the filtering regex to search for the 'livepatch:'
subsystem prefix at the beginning of the line.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/testing/selftests/livepatch/README       | 8 ++++----
 tools/testing/selftests/livepatch/functions.sh | 7 +++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
index 0942dd5826f8..79dafab03017 100644
--- a/tools/testing/selftests/livepatch/README
+++ b/tools/testing/selftests/livepatch/README
@@ -37,7 +37,7 @@ Adding tests
 See the common functions.sh file for the existing collection of utility
 functions, most importantly setup_config(), start_test() and
 check_result().  The latter function greps the kernel's ring buffer for
-"livepatch:" and "test_klp" strings, so tests be sure to include one of
-those strings for result comparison.  Other utility functions include
-general module loading and livepatch loading helpers (waiting for patch
-transitions, sysfs entries, etc.)
+the "^livepatch:" subsystem prefix and also any "test_klp" strings.
+Test log entries need include one of those for result comparison.  Other
+utility functions include general module loading and livepatch loading
+helpers (waiting for patch transitions, sysfs entries, etc.)
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index e84375a33852..83560c3df2ee 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -248,7 +248,7 @@ function start_test {
 
 	# Save existing dmesg so we can detect new content below
 	SAVED_DMESG=$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
-	dmesg > "$SAVED_DMESG"
+	dmesg --notime > "$SAVED_DMESG"
 
 	echo -n "TEST: $test ... "
 }
@@ -259,9 +259,8 @@ function check_result {
 	local expect="$*"
 	local result
 
-	result=$(dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
-		 grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | \
-		 sed 's/^\[[ 0-9.]*\] //')
+	result=$(dmesg --notime | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
+		 grep -v 'tainting' | grep -e '^livepatch:' -e 'test_klp')
 
 	if [[ "$expect" == "$result" ]] ; then
 		echo "ok"
-- 
2.21.3

