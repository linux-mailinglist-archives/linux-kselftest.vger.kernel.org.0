Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B364272D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Oct 2021 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbhJHVJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 17:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhJHVJ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 17:09:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2BC061570
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Oct 2021 14:08:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z130-20020a256588000000b005b6b4594129so14270550ybb.15
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Oct 2021 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NvxIR5lqwcJuWcSfuCuUfro2i4IPITTSSpKuXYYyk34=;
        b=cADKC07GjJ3G+xr1MZz1LGpo+Cdm/bUM0G/R+pVUmSfCQ658tZSOmb4zUmAG8aRwfj
         7wwoaNaaNPX/SIDWDFsp6kFRKffka8Cs5ateSY8WLP+Nxnff0XeFttmwTSOOG4HNDURr
         3IuyzR9XuDDJ9mPaMNGKw91KKnG2PmzejXVLasR/o5PVZ1EpnImSA+3FhyS0z1r638F0
         2hgdWRPHVjWwUY/kRv12ohSnwBuFNgRQF41KBFzkbte7khcom2EnSgSI2p6p/tvMxYXF
         iR9eMhw5ky/b8pWsdHS0khgBOU/HmF+l9iz+VVK/UBvq+Qedq7K21Ha2Bg2iisjp0Vh4
         m2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NvxIR5lqwcJuWcSfuCuUfro2i4IPITTSSpKuXYYyk34=;
        b=QXJ344a9u1CKFcjlu+bMZXSt4qc+kywjkH9pCV8DShBSbrduU8ewwykjtKHWxr7t2p
         ZmjUQKPfd63peI4Lsu+WUHC+CeBmkaJKvj8YB+TY3xP4WtIRAeK1FIUjXMCgSZ1Z0yGM
         +RyNGMaz8Q0lTKI6RRCsI3eZzJWdyBsrOVBqX5jopXcRYsrd6Wcwt9C9fxHXAIYXfyND
         Sb6u1yJrqC7WdxVrvBat3F1qqx4ObNwBEQUBLJLsdU/ynP1DPq2PtDqdynCA/St65ZJV
         I+4AxqaOsVZxFnjXooIGsdRKu2GCwqSWOC1Ydz69yleZS37oDPcCgb/d0yjv5oCClsNu
         BVng==
X-Gm-Message-State: AOAM530wczQGZO9e6H0IJ5rnyBdzwrpkQrN6EyI9pBWI5kj8M4cBLov0
        zaXMiEHVoW37pBoZfRvaQ9aMNzOqghj19A==
X-Google-Smtp-Source: ABdhPJw5P3MkSyb8lxeM6KAt00QRdCv3JXcY6sHDKparFqH8YByXgWSsr9ZmVCP/NV/SzMn+i/SfaQ9oZ8TjQQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:cd04:8b15:ad9e:5bee])
 (user=dlatypov job=sendgmr) by 2002:a25:c88:: with SMTP id
 130mr5843808ybm.176.1633727282177; Fri, 08 Oct 2021 14:08:02 -0700 (PDT)
Date:   Fri,  8 Oct 2021 14:07:52 -0700
Message-Id: <20211008210752.1109785-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] kunit: tool: continue past invalid utf-8 output
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
---
 tools/testing/kunit/kunit.py        | 3 ++-
 tools/testing/kunit/kunit_kernel.py | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 9c9ed4071e9e..28ae096d4b53 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -457,9 +457,10 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'parse':
 		if cli_args.file == None:
+			sys.stdin.reconfigure(errors='backslashreplace')
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

base-commit: a032094fc1ed17070df01de4a7883da7bb8d5741
-- 
2.33.0.882.g93a45727a2-goog

