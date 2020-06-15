Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336431F9E64
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgFOR2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 13:28:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22329 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730852AbgFOR2H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 13:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592242085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goo7vP2ztodSwchYnfcz9w5EdTQRqC/4WP1aYyAF0xY=;
        b=KB41dwZdoQBp1vlXuBQ0N7azJ3B9sMqg4Q0dMlQn+Of7h5iAPk20EVxtjl0jqSLPTeRR5I
        Q7ixOHLtMcbK2brj8q5EqJYBTHGHlXzkYMtcblMbMVq4KuiBrATHB1FitHvT4ycmRkSqbw
        KDNDZkX+tpUCuGObCR7xZmmBITb8byU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-XOrxXQ_kNP6HXfyM7He1aA-1; Mon, 15 Jun 2020 13:28:01 -0400
X-MC-Unique: XOrxXQ_kNP6HXfyM7He1aA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65743873404;
        Mon, 15 Jun 2020 17:28:00 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCD1E19C66;
        Mon, 15 Jun 2020 17:27:59 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 2/4] selftests/livepatch: use $(dmesg --notime) instead of manually filtering
Date:   Mon, 15 Jun 2020 13:27:54 -0400
Message-Id: <20200615172756.12912-3-joe.lawrence@redhat.com>
In-Reply-To: <20200615172756.12912-1-joe.lawrence@redhat.com>
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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
index 7ac3aa20f403..bbbb4041f533 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -44,7 +44,7 @@ function die() {
 # save existing dmesg so we can detect new content
 function save_dmesg() {
 	SAVED_DMESG=$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
-	dmesg > "$SAVED_DMESG"
+	dmesg --notime > "$SAVED_DMESG"
 }
 
 # cleanup temporary dmesg file from save_dmesg()
@@ -272,9 +272,8 @@ function check_result {
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

