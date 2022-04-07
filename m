Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060BA4F883A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 21:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiDGTsu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDGTst (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 15:48:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB636C0AB
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 12:43:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d2d45c0df7so57251777b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=U0Hnhz6FkWikLEjV/D9C4mwc2iqVMG/fIPbXB9OU5q4=;
        b=o07BrSOg1I3ZAbol7DUdxPNo0X7ueGUKzVERCNpj3MJ9kk3m9o0e4o+g3VVNbQBltr
         mSnjB2+5TOFiAxJtHx3fk8yKuoRBvS4xMM2u4mkBbY+gLfjKWb7lc/weMn+oEf/+DkfF
         vBOwhSSJqqOc3Go9LsSl3HtXat6Uhdu4duXjqDqOT1TZj7FDG8h33YsrOen0PGhYwq2l
         KPlemUBfaSrXkR9gpPeMKQ8avWSdsxoN9XQ2q+Y1alRclcmMOI6W+wrSiwoL4qrj0A0A
         9fIWcnGYCzRK/CVGFHxBd5Mw7AVqrmXBQl+typj3/l2CIoLQnp/OjaE/QxYX/zMPFhDx
         OsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=U0Hnhz6FkWikLEjV/D9C4mwc2iqVMG/fIPbXB9OU5q4=;
        b=FQP+Kopf44bro/BC6mPWEZOjz80sUNRqCWFMxpAAx50Fixc6bReIkfBrbqKcAkdEOG
         kMTh4bgQjvurlCPuV5queFueI3BbLy5C49A9qucLoF9I4LUOODTWTwTk/3KGSjBkMql3
         ydiLkD80LZ3vGDMnEUYl2gOGcIKmcFyVQ/l+es6LUaX3n3F3akUHRb8VRDnwDJ3iDIrN
         4Ele/0gdRdXbw6A2q39T8bEIPKdmQgiA5cTBsHrwi6PYuOlWHtQJk0CL6Qt+4eb5PEGJ
         oqXuqKEQOwVf7QwDGrOcz0JCdEjzXiftAR8uTSEwVYKwbuy3LhG+XErs+ebDdrARdXcy
         xJgg==
X-Gm-Message-State: AOAM530b7+Sj0dBW90l7fc0su77OxUaRSrLJNror/HME0wWXxzTYTGBC
        9dIHKmjxZP+d/PSvLJwkJTtIFERF3Jp2Og==
X-Google-Smtp-Source: ABdhPJx6leyDfWk1JfaRZZrzTr1Cw4oe0SYHphG+OfJC1fFuk6FyR6wXnM7iI+LbxfBFFuABBeWe5FlM/b9x4A==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:aed6:d51d:dc38:e705])
 (user=dlatypov job=sendgmr) by 2002:a25:ba0c:0:b0:61a:79a6:fd0 with SMTP id
 t12-20020a25ba0c000000b0061a79a60fd0mr11581459ybg.45.1649360345816; Thu, 07
 Apr 2022 12:39:05 -0700 (PDT)
Date:   Thu,  7 Apr 2022 12:39:02 -0700
Message-Id: <20220407193902.1981605-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] kunit: tool: cosmetic: don't specify duplicate kunit_shutdown's
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Context:
When using a non-UML arch, kunit.py will boot the test kernel with these
options by default:
> mem=1G console=tty kunit_shutdown=halt console=ttyS0 kunit_shutdown=reboot

For QEMU, we need to use 'reboot', and for UML we need to use 'halt'.
If you switch them, kunit.py will hang until the --timeout expires.

So the code currently unconditionally adds 'kunit_shutdown=halt' but
then appends 'reboot' when using QEMU (which overwrites it).

This patch:
Having these duplicate options is a bit noisy.
Switch so we only add 'halt' for UML.

I.e. we now get
UML: 'mem=1G console=tty console=ttyS0 kunit_shutdown=halt'
QEMU: 'mem=1G console=tty console=ttyS0 kunit_shutdown=reboot'

Side effect: you can't overwrite kunit_shutdown on UML w/ --kernel_arg.
But you already couldn't for QEMU, and why would you want to?

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 483f78e15ce9..9731ceb7ad92 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -158,7 +158,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = os.path.join(build_dir, 'linux')
-		return subprocess.Popen([linux_bin] + params,
+		return subprocess.Popen([linux_bin] + params + ['kunit_shutdown=halt'],
 					   stdin=subprocess.PIPE,
 					   stdout=subprocess.PIPE,
 					   stderr=subprocess.STDOUT,
@@ -332,7 +332,7 @@ class LinuxSourceTree(object):
 	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
 		if not args:
 			args = []
-		args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
+		args.extend(['mem=1G', 'console=tty'])
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
 

base-commit: b04d1a8dc7e7ff7ca91a20bef053bcc04265d83a
-- 
2.35.1.1178.g4f1659d476-goog

