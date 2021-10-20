Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596D643566C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 01:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJTXXn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 19:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTXXl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 19:23:41 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28196C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 16:21:26 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d187-20020a6236c4000000b0044cf291bfebso2658815pfa.10
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 16:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WeYFI5Q65D5VmaG+HirB0Qtdd3LYXh8Mm68u/4MK/X4=;
        b=SbfPCdH5oCeJ54y8USj1+eYR13UAlBYSMmIqteq1cHkh1UUTmxvvL3WBt37YgGVOVB
         j1aN6+/Ol/s06HN0O+8W5tY2fDNhGG7A6vQL1BtcpgoVAi7efDN/FPg2wTHdRqHc1DzB
         JxwRfuo/V08xluuGhnUQ1odxe1FhcPQXkKGunEWg4pUpQN1fzS2bJKjSE7syyd1R50P9
         kcuFcfVRFx0WyqCMgI/zf/swPshgVtwZYfDNqAD7DxqSVGT6u/gykapeqYoZOUbaz363
         oySG/KSE9P1UpLoIpgbFYYfCWsanb7yq/hMBoFVAR706zyW1Qm0YoN/ymopEA3KQvkeO
         IxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WeYFI5Q65D5VmaG+HirB0Qtdd3LYXh8Mm68u/4MK/X4=;
        b=aYplf2J+IhHLej6cw5WpClWZfKHc64GUosaDEA+Ufgftw40vJM74pdn/TZrteqBlOX
         +E2ejGQ63JdQ+ZaaJkhdVKdTiAin6pQzLMJEDWwiGB1ejzrdMczP3Qvs42VpzI89Mrd0
         vKdr/rj72ERjtLRC7ewbonWFqnRHKr37IyXflvI5+vRIcl7teAmSsPs6pivphBFtl/lA
         TcyBACqOYO4em2SXmci06NwxRzBTaDk8JI1DG8LEyuYOBCh377+QYpXdCxoaXwhd1z+V
         D1a/NqFbtmt6uV2J93z50SAHonc3QhCFo9iCV/JB9PCfEQVGuxcnW3BdxqpBv0IZxWDu
         H9Yg==
X-Gm-Message-State: AOAM532hDzCP4LJOySrlfqcjMUF3hnrPKtUyOIxKzPqoezbXLCB68S+x
        HrIDmrB/eOA9nWCi3/raUOjcBFSJhJEOVw==
X-Google-Smtp-Source: ABdhPJxYMLqxV8vp7g+5/pXQ6PH9x2d9AFeM9qcIZLBco7P9UpDuoPBnleKtBctDsBXkfnFaEIwyz8ZzuO51qQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d046:bdee:5827:25d6])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:1212:: with SMTP id
 gl18mr2312068pjb.166.1634772085580; Wed, 20 Oct 2021 16:21:25 -0700 (PDT)
Date:   Wed, 20 Oct 2021 16:21:21 -0700
Message-Id: <20211020232121.1748376-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2] kunit: tool: continue past invalid utf-8 output
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit.py currently crashes and fails to parse kernel output if it's not
fully valid utf-8.

This can come from memory corruption or or just inadvertently printing
out binary data as strings.

E.g. adding this line into a kunit test
  pr_info("\x80")
will cause this exception
  UnicodeDecodeError: 'utf-8' codec can't decode byte 0x80 in position 1961: invalid start byte

We can tell Python how to handle errors, see
https://docs.python.org/3/library/codecs.html#error-handlers

Unfortunately, it doesn't seem like there's a way to specify this in
just one location, so we need to repeat ourselves quite a bit.

Specify `errors='backslashreplace'` so we instead:
* print out the offending byte as '\x80'
* try and continue parsing the output.
  * as long as the TAP lines themselves are valid, we're fine.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: add comment to silence erroneous pytype error
---
 tools/testing/kunit/kunit.py        | 3 ++-
 tools/testing/kunit/kunit_kernel.py | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e1dd3180f0d1..68e6f461c758 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -477,9 +477,10 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'parse':
 		if cli_args.file == None:
+			sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
 			kunit_output = sys.stdin
 		else:
-			with open(cli_args.file, 'r') as f:
+			with open(cli_args.file, 'r', errors='backslashreplace') as f:
 				kunit_output = f.read().splitlines()
 		request = KunitParseRequest(cli_args.raw_output,
 					    None,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index faa6320e900e..f08c6c36a947 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -135,7 +135,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 					   stdin=subprocess.PIPE,
 					   stdout=subprocess.PIPE,
 					   stderr=subprocess.STDOUT,
-					   text=True, shell=True)
+					   text=True, shell=True, errors='backslashreplace')
 
 class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	"""An abstraction over command line operations performed on a source tree."""
@@ -172,7 +172,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 					   stdin=subprocess.PIPE,
 					   stdout=subprocess.PIPE,
 					   stderr=subprocess.STDOUT,
-					   text=True)
+					   text=True, errors='backslashreplace')
 
 def get_kconfig_path(build_dir) -> str:
 	return get_file_path(build_dir, KCONFIG_PATH)

base-commit: 63b136c634a2bdffd78795bc33ac2d488152ffe8
-- 
2.33.0.1079.g6e70778dc9-goog

