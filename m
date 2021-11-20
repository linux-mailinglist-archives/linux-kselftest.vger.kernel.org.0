Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D8457AC4
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Nov 2021 04:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhKTD1K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 22:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbhKTD1J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 22:27:09 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6EC06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 19:24:06 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so4928826pgo.21
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 19:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R3HUx9GKckCPUPYSi+Liz6fStqqUgznZec3nouzCiJ4=;
        b=EN6C9YnKz2achMBc4URh09K02GQul2sGe340WD3Mox/3X1soO3SC+Sq5GJLeEVy293
         OOJ9YSEhn+3v4Xia/z3f8gWt3uDMJ4VgycFFNjSC5WvlidjRGRmggOMZM3NZpV1Q/7OA
         8feu7CAwy+ukcTXSNaVl5YPNdmVDBj1okj7zua/WzpILJ1pN+ieeoBOBMQTOKRpT0cmz
         AEAB/E/hhc/05Y4ILo2HuA/d5h64XtwGDDHPjwC72jdUsZp9wB0zrMNVguu1aGSWTJdI
         Qvq8LejjJoz1e1fnZXD9xFEdlsqX/jihvlqAjDaZ6Z9OEf2j/KJNpatRU1YIA+Ap3o3t
         ST0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R3HUx9GKckCPUPYSi+Liz6fStqqUgznZec3nouzCiJ4=;
        b=1xcdjpcMYLupkcgdZnYl4vZ4Y0WNjLBnw0KUhDUtvZb3XZVb3MjTSOzJAwZWtkLDPs
         YveoFlkxh0RGm4HrQ+13z98DoS42o77pmfvacO4zEnIOjpnUd3X1TEUHr1wQja3GxTeH
         xx7/svtMALYzcWg9Bz4pa2XeYgu9Af5xBEMBMPk0rFw3wMtmmMaPKSkYrM8rglK2pkX+
         jfXa8f+xEd59UISiqfS8dLY390Soqr16sGVbgOXtDLnz+TMhu3JxaaUTrRK+Rl9nQbLH
         WfU6apIkljfayqP+flgboAqiAly+aJ7hVVnTIZz4xe/X1m5HjsdqVA3zG/n7ngwthZB7
         fQlQ==
X-Gm-Message-State: AOAM5332nEvbL+XN1hfYFwhlQQYGLvnD+t7oyic5y+TlRiV3ChXtnR0B
        4K5Fh1dG9EGpG+6VTLBVpzNy+RUR1XDd+A==
X-Google-Smtp-Source: ABdhPJx/Mt3dOTW+E2LX9HJbkK4GEHIwuJdkkgHzXjcEz8vmQrgfwYYZBgJqAmAgPq1WZmpZP2t/eMt6/Nm6mw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:255f:999b:cd4:cfdd])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:1c06:: with SMTP id
 oc6mr6169677pjb.126.1637378646203; Fri, 19 Nov 2021 19:24:06 -0800 (PST)
Date:   Fri, 19 Nov 2021 19:24:01 -0800
Message-Id: <20211120032401.2305447-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] kunit: tool: suggest using decode_stacktrace.sh on kernel crash
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit.py isn't very clear that
1) it stashes a copy of the unparsed output in $BUILD_DIR/test.log
2) it sets $BUILD_DIR=.kunit by default

So it's trickier than it should be for a user to come up with the right
command to do so.

Make kunit.py print out a command for this if
a) we saw a test case crash
b) we only ran one kernel (test.log only contains output from the last)

Example suggested command:
$ scripts/decode_stacktrace.sh .kunit/vmlinux .kunit < .kunit/test.log | tee .kunit/decoded.log | ./tools/testing/kunit/kunit.py parse

Without debug info a user might see something like
[14:11:25] Call Trace:
[14:11:25] ? kunit_binary_assert_format (:?)
[14:11:25] kunit_try_run_case (test.c:?)
[14:11:25] ? __kthread_parkme (kthread.c:?)
[14:11:25] kunit_generic_run_threadfn_adapter (try-catch.c:?)
[14:11:25] ? kunit_generic_run_threadfn_adapter (try-catch.c:?)
[14:11:25] kthread (kthread.c:?)
[14:11:25] new_thread_handler (:?)
[14:11:25] [CRASHED]

`tee` is in GNU coreutils, so it seems fine to add that into the
pipeline by default, that way users can inspect the otuput in more
detail.

Note: to turn on debug info, users would need to do something like
$ echo -e 'CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y' >> .kunit/.kunitconfig
$ ./tools/testing/kunit/kunit.py config
$ ./tools/testing/kunit/kunit.py build
$ <then run decode_stacktrace.sh now vmlinux is updated>

This feels too clunky to include in the instructions.
With --kconfig_add [1], it would become a bit less painful.

[1] https://lore.kernel.org/linux-kselftest/20211106013058.2621799-2-dlatypov@google.com/

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 68e6f461c758..a45836ac2ca1 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -156,6 +156,12 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
 
 		test_counts.add_subtest_counts(result.result.test.counts)
 
+	if len(filter_globs) == 1 and test_counts.crashed > 0:
+		bd = request.build_dir
+		print('The kernel seems to have crashed; you can decode the stack traces with:')
+		print('$ scripts/decode_stacktrace.sh {}/vmlinux {} < {} | tee {}/decoded.log | {} parse'.format(
+				bd, bd, kunit_kernel.get_outfile_path(bd), bd, sys.argv[0]))
+
 	kunit_status = _map_to_overall_status(test_counts.get_status())
 	return KunitResult(status=kunit_status, result=result.result, elapsed_time=exec_time)
 

base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.34.0.rc2.393.gf8c9666880-goog

