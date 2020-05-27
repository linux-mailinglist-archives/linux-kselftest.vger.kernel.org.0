Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB11E3415
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 02:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgE0Ae1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 20:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgE0Ae0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 20:34:26 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E602C061A0F
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 17:34:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so17833869qts.9
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 17:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mq62GKb+a6uI+kRh3uk1w4mJxevGSsQXqoT6TNUJtKU=;
        b=Fsp134TQ7ts6VmjtGPWLw/8pcYBl5mf3YGy3/ugLjZWeWLH9WV5b+ca9T9kOjAMf7a
         sw5TPCeQE7mLzQU5m+epgt79iYBYCkzA6CDn2lD2ZKpD/CNQUiRC4/IK2cLOulw4IclN
         ZB+GpDT/Qs9+fANsZGrmxiyChMn7WelXygAYfgtnEk6yVF14bOgtvMSUrWm9Z20zX9H0
         MQb9zfjtYEUTRJV61OCuW1gZUCwGOWPv8B5whJDWlljeGzUbZ6UFjABYB9vk2izKWBly
         QvmiWi+g3H2NEHGFKSxX8G6y656HaQCbz3VnQ3NyKPs4AxTf/+JCQ7CMH5kxGen1i6Zw
         UhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mq62GKb+a6uI+kRh3uk1w4mJxevGSsQXqoT6TNUJtKU=;
        b=iq1ge4L0+lwaKbPLgpSHqrTG+xxQ6PoblRN0ygRD1vgDz+R3i9oYlVfw4oNUweRfzE
         zLeijDPjUk2gLuy5nvK4HJhqP1SJJCRRGZ4cn1d5pivC2hxCtqNINgf3lcp/MniPVjsz
         re/D59YTQAxjdrLu6ie/z31JXstPeJ2+jes0UlfE7/I8Uu9NXm4gG02PBRC+4aqM8He6
         9SugjdKSFAJ0Q90fnKV5YrbyBWswpU4sOz0gxCVGGbPuLPqkzOlb6oGNyiOnVdaqQMh0
         TtGYpyjdJNl1UlEt+LS8X6slG/ljMAhR50Xw9ZVhVnB0Wkvg5tE4AvAjPDnXSxVbUGa0
         LKDg==
X-Gm-Message-State: AOAM5310NMzM+TZG+DN7Z4QfY08htQpJAZXe7xW2rb50WwCMGyMBqcSF
        fPzAv7m9WNwV0vHyZC19WBmNPQ==
X-Google-Smtp-Source: ABdhPJwJlQUfbYhgP9H9HncZXgvR0jCIXllQbBglRLefb6mmcd3qtbB+BjdM5ZoIFi76MyRNuAH6oQ==
X-Received: by 2002:ac8:5045:: with SMTP id h5mr1641523qtm.259.1590539664497;
        Tue, 26 May 2020 17:34:24 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id y185sm647153qkd.83.2020.05.26.17.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 17:34:23 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com, skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [fixup v2] kunit: use --build_dir=.kunit as default
Date:   Tue, 26 May 2020 21:34:20 -0300
Message-Id: <20200527003420.34790-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To make KUnit easier to use, and to avoid overwriting object and
.config files, the default KUnit build directory is set to .kunit

Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>

Fixed this identation error exchanging spaces for tabs between lines
248 and 252:

tools/testing/kunit/kunit.py run --defconfig

  File "tools/testing/kunit/kunit.py", line 254
    if not linux:
                ^
TabError: inconsistent use of tabs and spaces in indentation

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205221
---
version after merge on kunit brach:
v1:
 * fix identation (tabs instead of spaces)

v2:
 * fix v1 changelog description: fix identation
   (spaces instead of tabs, lines 248-252);
 * add python error message on commit message;
 * fix Link tag on commit message.
---
 tools/testing/kunit/kunit.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index b01838b6f5f9..b3490271a103 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -169,7 +169,7 @@ def add_common_opts(parser):
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
-			    type=str, default='', metavar='build_dir')
+                            type=str, default='.kunit', metavar='build_dir')
 	parser.add_argument('--make_options',
 			    help='X=Y make option, can be repeated.',
 			    action='append')
@@ -245,12 +245,11 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-			kunit_kernel.kunitconfig_path = os.path.join(
-				cli_args.build_dir,
-				kunit_kernel.kunitconfig_path)
+		if not os.path.exists(cli_args.build_dir):
+			os.mkdir(cli_args.build_dir)
+		kunit_kernel.kunitconfig_path = os.path.join(
+			cli_args.build_dir,
+			kunit_kernel.kunitconfig_path)
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
-- 
2.26.2

