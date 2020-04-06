Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D602F1A0101
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 00:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDFWTX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Apr 2020 18:19:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39834 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgDFWTX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Apr 2020 18:19:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id f20so1206498qtq.6
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Apr 2020 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPrlCY8jQsQXtLUnLDlfV3dzYEfymLtvdW8F4aI7TfY=;
        b=m3OlceImpplocncT+pL8x7NKjNxj63YBiWKChKASzcRMWdu/2mK+uafJmmE2IkMp55
         7c/t/K14EDQxUksZXBbiKzHGIbD0VASz5jMxB2pxC8/roVrjtIE1CENOna76aad1iy1q
         TaTZD9/1D4fpTuwOw/5s9sqoLeUkH3IfdIt5HnV8a82hZmpactr3zehOcO0F/reZASrb
         1c7mB9NZGyC15MxEENaRqsdEqN6PsJEN0EzkCSOYeMf8y7l1XuzLyfKCDqG7S8+FsiLW
         Svn9XbAaQ/1gen3RUT/8TaQmqR+bqLNobFkN31jG9qxnLYq12+hPHGFBEOvCEXv5eAJs
         ThpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPrlCY8jQsQXtLUnLDlfV3dzYEfymLtvdW8F4aI7TfY=;
        b=bo451i8tbxKE4pCpbIvM9E7uZIm8v56RYJRDq5J/3VunnfF2Pjr6CFG3DMHRx7tSeL
         Ml8hTBoUXq/yEVCdzsme8GEgjVfPcqjLryMak+sBx19i095JDjclzNvzeLSHnVusmWOC
         gIZISUe3UWgXRuPI29hjCZqIXUHleMQD0L26KsIBcpFkhnsfGNejQbhqQ6dvliQAU4kE
         urZdcKVO53Q43fZxoL7GtcqSI5jsXzziC24GhkT/gSlLabdCtzINOi/4AU2VrqROBEmz
         So4bj4E6bF9aHbpITTBCgzCMFyck7gYDxDJysvW1FMhI+AjEaeghKBCoMpxxitl9Vp1N
         vQHg==
X-Gm-Message-State: AGi0PuY+uukRvd9X0NvAA9vlgF4HftMBWZ/gslGo5wGoLhSo530S6Xnt
        UOLmOR5NTmJsBQJhim/M10fvrQ==
X-Google-Smtp-Source: APiQypIgCypxzVhSxBHo3S9YP15zDlJ8kCqvoD0wznCPGR7+wsJ5GU1Oq3bn/SWODBllN8dV7NEuKg==
X-Received: by 2002:ac8:7316:: with SMTP id x22mr1914028qto.4.1586211560566;
        Mon, 06 Apr 2020 15:19:20 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id f1sm14521822qkl.72.2020.04.06.15.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:19:19 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3, RESEND] kunit: Fix kunit.py run --build_dir='<foo>' fails on "unclean" trees
Date:   Mon,  6 Apr 2020 19:19:16 -0300
Message-Id: <20200406221916.50008-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219

For some reason, the environment variable ARCH is used instead of ARCH
passed as an argument, this patch uses a copy of the env, but using
ARCH=um and CROSS_COMPILER='' to avoid this problem.

This patch doesn't change the user's environment variables, avoiding
side effects.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
v2:
 - Use the correct next branch

v3:
 - Use torvalds/master branch
 - Use base parameter on git send-email
---
 tools/testing/kunit/kunit_kernel.py | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 63dbda2d029f..96216c699fde 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -20,6 +20,7 @@ import kunit_parser
 KCONFIG_PATH = '.config'
 kunitconfig_path = '.kunitconfig'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
+env = dict(os.environ.copy(), ARCH='um', CROSS_COMPILE='')
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -41,13 +42,15 @@ class LinuxSourceTreeOperations(object):
 			raise ConfigError(e.output)
 
 	def make_olddefconfig(self, build_dir, make_options):
-		command = ['make', 'ARCH=um', 'olddefconfig']
+		command = ['make', 'olddefconfig']
 		if make_options:
 			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command, stderr=subprocess.PIPE)
+			subprocess.check_output(command,
+						stderr=subprocess.PIPE,
+						env=env)
 		except OSError as e:
 			raise ConfigError('Could not call make command: ' + e)
 		except subprocess.CalledProcessError as e:
@@ -57,9 +60,10 @@ class LinuxSourceTreeOperations(object):
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
 		process = subprocess.Popen(
-			['make', 'ARCH=um', 'allyesconfig'],
+			['make', 'allyesconfig'],
 			stdout=subprocess.DEVNULL,
-			stderr=subprocess.STDOUT)
+			stderr=subprocess.STDOUT,
+			env=env)
 		process.wait()
 		kunit_parser.print_with_timestamp(
 			'Disabling broken configs to run KUnit tests...')
@@ -71,13 +75,13 @@ class LinuxSourceTreeOperations(object):
 			'Starting Kernel with all configs takes a few minutes...')
 
 	def make(self, jobs, build_dir, make_options):
-		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		command = ['make', '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command)
+			subprocess.check_output(command, env=env)
 		except OSError as e:
 			raise BuildError('Could not call execute make: ' + e)
 		except subprocess.CalledProcessError as e:
@@ -91,7 +95,8 @@ class LinuxSourceTreeOperations(object):
 		with open(outfile, 'w') as output:
 			process = subprocess.Popen([linux_bin] + params,
 						   stdout=output,
-						   stderr=subprocess.STDOUT)
+						   stderr=subprocess.STDOUT,
+						   env=env)
 			process.wait(timeout)
 
 

base-commit: 7e63420847ae5f1036e4f7c42f0b3282e73efbc2
-- 
2.25.1

