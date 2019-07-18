Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C690D6D5C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2019 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403840AbfGRU3v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jul 2019 16:29:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfGRU3v (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jul 2019 16:29:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A6B9307D98F;
        Thu, 18 Jul 2019 20:29:51 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A833E607AD;
        Thu, 18 Jul 2019 20:29:50 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/livepatch: push and pop dynamic debug config
Date:   Thu, 18 Jul 2019 16:29:48 -0400
Message-Id: <20190718202948.3404-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 18 Jul 2019 20:29:51 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The livepatching self-tests tweak the dynamic debug config to verify
the kernel log during the tests.  Enhance set_dynamic_debug() so that
the config changes are restored when the script exits.

Note this functionality needs to keep in sync with:
  - dynamic_debug input/output formatting
  - functions affected by set_dynamic_debug()

  For example, push_dynamic_debug() transforms:
    kernel/livepatch/transition.c:530 [livepatch]klp_init_transition =_ "'%s': initializing %s transition\012"
  to:
    file kernel/livepatch/transition.c line 530 =_

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 .../testing/selftests/livepatch/functions.sh  | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index de5a504ffdbc..860f27665ebd 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -29,13 +29,27 @@ function die() {
 	exit 1
 }
 
-# set_dynamic_debug() - setup kernel dynamic debug
-#	TODO - push and pop this config?
+function push_dynamic_debug() {
+        DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
+                awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
+}
+
+function pop_dynamic_debug() {
+	if [[ -n "$DYNAMIC_DEBUG" ]]; then
+		echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
+	fi
+}
+
+# set_dynamic_debug() - save the current dynamic debug config and tweak
+# 			it for the self-tests.  Set a script exit trap
+#			that restores the original config.
 function set_dynamic_debug() {
-	cat << EOF > /sys/kernel/debug/dynamic_debug/control
-file kernel/livepatch/* +p
-func klp_try_switch_task -p
-EOF
+        push_dynamic_debug
+        trap pop_dynamic_debug EXIT INT TERM HUP
+        cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
+		file kernel/livepatch/* +p
+		func klp_try_switch_task -p
+		EOF
 }
 
 # loop_until(cmd) - loop a command until it is successful or $MAX_RETRIES,
-- 
2.21.0

