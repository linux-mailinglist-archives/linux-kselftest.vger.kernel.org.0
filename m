Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E694526902
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 20:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383239AbiEMSKn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 14:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383245AbiEMSKm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 14:10:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968553A65
        for <linux-kselftest@vger.kernel.org>; Fri, 13 May 2022 11:10:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d22-20020a25add6000000b00645d796034fso7946400ybe.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 May 2022 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8buMt52MUzaasZ6jsjp6myKL0GeKFoD3/wZybTV/TmM=;
        b=NF38oozRIFs8X6o8YLo0E1qzhmO1P8ZdEhbOKiFZM5s+oqyb9UIKEzsjx254jTgddB
         cCCZQjWjOabEb7MN6sw20yDxEKS3hZ1cK1+8dmMxb2TynK2D/EGklgKCZB0C8hCWTFEs
         KbEuEt35Lg+CuxcKHfg8edkThSXnTpemSzcvgkW75QrOvw2rOTk+XLcVmutMiaTKXZ3c
         cYCYqooI5/DC69sAbs8jK191LuxXRNffEYm7lPKVEVNXOKd3nMMF/6wQ4s1pVFvuuMpd
         VNbkWQ9ihpBBhZCsB8rWh+Aig0suWLjflBsOO23hFN67ZV+cnezBIlNP6cQXMWgtDzTY
         DtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8buMt52MUzaasZ6jsjp6myKL0GeKFoD3/wZybTV/TmM=;
        b=W+tMr1UXaToNbT9ZEQ7t4YTZboW/Did0YFgJP57NN+zu6LW7zsDBfRovOebuPPi0m0
         1FkWADzu4aoD/45k/O7vJzUF33lJS78jGwPtNb0O1uh2lj/CYaER9LDYRBwwbhsKPk7m
         WBrZiHOv4utyd9+0tIpdDZShhNtuYjybfULpAo6CJNy7WbphzMeaF/s7zT9akduL/hxk
         KJyX9Sh4QGJHdwV73sztkg+e6WptxL8n0JaIRzqetLSrh5mAVd6WQIDXZKkfgingY4KQ
         yRDUYo7NT9SA3H/oQjbBR+7GXKInMWm25FXM5ArriNZbNm5I5bttjy2ejvFPxLByvmPk
         S99w==
X-Gm-Message-State: AOAM532IUFs2J33GCxpmkfx20LwZWJPBZ7PDZDtl38bh7f5nLt7mtQXp
        xFtUPi4s6pZg1BSAVht2ja9aRVeEyEhenw==
X-Google-Smtp-Source: ABdhPJy2h+vw30dO0Bq1irc/WGZWYZ8ZyOuEdHxvG4gOcCyytDX8eDNpVkJYbudcI3v0tCy5QS9tEb8L7UMA2g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:577a:4fdf:13a8:670])
 (user=dlatypov job=sendgmr) by 2002:a25:3157:0:b0:649:b216:bb4e with SMTP id
 x84-20020a253157000000b00649b216bb4emr6332372ybx.387.1652465436436; Fri, 13
 May 2022 11:10:36 -0700 (PDT)
Date:   Fri, 13 May 2022 11:10:32 -0700
Message-Id: <20220513181032.24484-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2] kunit: tool: cosmetic: don't specify duplicate kernel
 cmdline options
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Context:
When using a non-UML arch, kunit.py will boot the test kernel with
options like these by default (this is x86_64):
> mem=1G console=tty kunit_shutdown=halt console=ttyS0 kunit_shutdown=reboot

The first three options are added unconditionally but are only intended
for UML.

1. 'mem=1G' is redundant with the '-m 1024' that we hard-code into the
   qemu commandline.

2. We specify a 'console' for all tools/testing/kunit/qemu_configs/*.py
   already, so 'console=tty' gets overwritten.

3. For QEMU, we need to use 'reboot', and for UML we need to use 'halt'.
   If you switch them, kunit.py will hang until the --timeout expires.

This patch:
Having these duplicate options is a bit noisy.
Switch so we only add UML-specific options for UML.

I.e. we now get
UML: 'mem=1G console=tty kunit_shutdown=halt' (unchanged)
x86_64: 'console=ttyS0 kunit_shutdown=reboot'

Side effect: you can't overwrite these options on UML w/ --kernel_arg.
But you already couldn't for QEMU (console, kunit_shutdown), and why
would you want to?

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: Remove other UML-specific args from other arches.
I.e. also only specify "mem=1G and console=tty" for UML.
---
 tools/testing/kunit/kunit_kernel.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 1b9c4922a675..8945640b5063 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -160,6 +160,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = os.path.join(build_dir, 'linux')
+		params.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
 		return subprocess.Popen([linux_bin] + params,
 					   stdin=subprocess.PIPE,
 					   stdout=subprocess.PIPE,
@@ -334,7 +335,6 @@ class LinuxSourceTree(object):
 	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
 		if not args:
 			args = []
-		args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
 

base-commit: 9660209d9418f2295d31fea0d32e313e9b2c1200
-- 
2.36.0.550.gb090851708-goog

