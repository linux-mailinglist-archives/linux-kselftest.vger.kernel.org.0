Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83F11A00C8
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 00:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDFWPL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Apr 2020 18:15:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36682 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDFWPI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Apr 2020 18:15:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id m33so1219475qtb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Apr 2020 15:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j72I6B2yv1MtQdVXUp6mfzONbbVa//fDwmUTKLmhZlM=;
        b=UmseYPFdd9OfC6LhQ+NAWOTbLOsEpFb06VKPLLcq3VeJFuFwva7Bg5Bglq5Z8WlJBY
         qazf1OFqJZw0RMObUPU24HzIGgofGjlz7oNnwpQVtW2HYVx2ARu2/gXxzAPRfev3g2Yc
         0rXQdub7D4sLzZR6PE4GVGQ2vWuokGmZxWF5OWTuynE62r/VRhMq7Ff9Co8wIMde3tid
         S04vh6x8Xz1q89PJiffvk0mkeb68WqucLMDSzdwWAnj0aLoS/8P+tFDx5Bda5dBRbrBe
         PHDBXGtw4FvPhYXQFGBfm6kI9quTC/6Hg2alzxea5pWiUzDYf6RXpslx0EyT37QQetYg
         z9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j72I6B2yv1MtQdVXUp6mfzONbbVa//fDwmUTKLmhZlM=;
        b=b8U9Vkq6aFVYKOKZOtiQTVW175QvvyZnFakaBVy1MCY9iVFv3r7wBkvQuAexv6wXtK
         Q9V/669E6qNcbHGn0ZJhDzRta61aNVbS2oLetunxvtLgBkBAZ0RLHbY3LO+C6ZxrNvPx
         sgPOETn5bdK+YL+cy8xk55YLviNbJ65Eli55IkRTF0FkPH08Ipz+vK1qbQZ/3IWfjaGr
         32Cv799qaJ9TdJD+G5Cw4bPhwTYus9vY1NKaSMXPiTCACrTEHUyyyimwc+8SZiMkweBW
         OFMkRGghjOHHpfoo8ABzc09CgPSiaN4HdzfcjHVbZZVIpZvuROSR/la7LZJZvKColMWv
         2Dsw==
X-Gm-Message-State: AGi0Puaf2JWJu4H6NQ8AX6EuQIze6NGYWoCfsE8T3V/30lTmv7IakxQg
        /6ZSMYw6FUYAHN6WptDO1nMBfg==
X-Google-Smtp-Source: APiQypIpf/UbhzyzYpY0P1+j4rwvPJzBNCD6XCGWvf++pPQWMWFWNGNj7BarpYyeNQ+BwIugzCGX4g==
X-Received: by 2002:aed:32c7:: with SMTP id z65mr1711174qtd.81.1586211307951;
        Mon, 06 Apr 2020 15:15:07 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id e10sm1834923qkl.48.2020.04.06.15.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:15:07 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] kunit: Fix kunit.py run --build_dir='<foo>' fails on "unclean" trees
Date:   Mon,  6 Apr 2020 19:15:03 -0300
Message-Id: <20200406221503.49760-1-vitor@massaru.org>
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
 
 
-- 
2.25.1

