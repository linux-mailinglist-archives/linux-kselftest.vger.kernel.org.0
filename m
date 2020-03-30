Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2B21987B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Mar 2020 01:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgC3XDD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Mar 2020 19:03:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43432 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XDD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Mar 2020 19:03:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id o10so21031797qki.10
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Mar 2020 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfP3d4P8jwaZXBD9eOyojCY2clb925eYfLTaD8OeKhA=;
        b=qaE9ka01+XIZt+e6Bvi86miiEoTYjIAZNc6SBrJHsRF8RCkg86ZaVTJROEIRnMjbX+
         epd/phtbktcNMRoCxb7vZX6Uhk31J7yqFb6MwNNJRzsjAuhxOSqF6Fj3w73J+otw36rm
         OhfKblcf3wgx2qK3ZGstg761wknK0bbodDx8aXiYsF8Y7xVUDYoNGoLpSASWg2c3X9mj
         KX42UsxIDrw+v1w7GyYu7f2qjDQzhIvNPOGxC8wcDG8kDGo68q8ffi9Hox+EvyO+YLjG
         T5SYPpcbPf9Vtdh9g+Jm56bfxJbkws3MmYsj5E4XViubrU10Xh4eHltlNPRyRB+/Virv
         C4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfP3d4P8jwaZXBD9eOyojCY2clb925eYfLTaD8OeKhA=;
        b=oGrd+/ep1i8+LsNIBywYCuROLyl9vWLV/+vnI6i2XXWb2nfjSPjKQYUxWnGDaNpHOc
         8O+V6L4phFDLJsRs+J9VPgmFBfIwj/9kQ9vJnp2hOl/oJIH/QGuk9rlak/6R1qBu7VMd
         bw1Am18bYTPdOgVEhiYdk5m1W3zY4HyRwmPrCk2Z5NOp0vpOiKFbDeEGShUN0vE9/+ZR
         WAyNPtLMw/f8Z1UuUgq2GbWy85dH0epJ5EE3UQMolxhYN/a+Or5LILilTdof/WuouR5w
         JRVcoXZnMuOnYAvi4XrjFIBwh2XJ7sBQnkDTj0Qvoh1jm5nKTWUqb5AP9EAK/0arQLCW
         Q/fw==
X-Gm-Message-State: ANhLgQ3lxx+k6XyQC2O2RKTWYskESQTKS5DzHxgCmayD/JpR4e2I4you
        /YciyuDAbXw3qyhuTwXOpFX1uA==
X-Google-Smtp-Source: ADFU+vuRo0Z9og1N04QkJ35KoQ07MEFGwx1jCIe2vGcNdl80NJ4ucpQC+2OppHx5h2cN8yRDQj+PoA==
X-Received: by 2002:a05:620a:539:: with SMTP id h25mr2309572qkh.395.1585609380619;
        Mon, 30 Mar 2020 16:03:00 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id i20sm931146qkl.135.2020.03.30.16.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:03:00 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kunit: Fix kunit.py run --build_dir='<foo>' fails on "unclean" trees
Date:   Mon, 30 Mar 2020 20:02:56 -0300
Message-Id: <20200330230256.28323-1-vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
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
 tools/testing/kunit/kunit_kernel.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index d99ae75ef72f..0cb1f81ac8f2 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -15,6 +15,7 @@ import kunit_config
 
 KCONFIG_PATH = '.config'
 kunitconfig_path = '.kunitconfig'
+env = dict(os.environ.copy(), ARCH='um', CROSS_COMPILE='')
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -36,22 +37,22 @@ class LinuxSourceTreeOperations(object):
 			raise ConfigError(e.output)
 
 	def make_olddefconfig(self, build_dir):
-		command = ['make', 'ARCH=um', 'olddefconfig']
+		command = ['make', 'olddefconfig']
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command)
+			subprocess.check_output(command, env=env)
 		except OSError as e:
 			raise ConfigError('Could not call make command: ' + e)
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
 	def make(self, jobs, build_dir):
-		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		command = ['make', '--jobs=' + str(jobs)]
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command)
+			subprocess.check_output(command, env=env)
 		except OSError as e:
 			raise BuildError('Could not call execute make: ' + e)
 		except subprocess.CalledProcessError as e:
@@ -66,7 +67,8 @@ class LinuxSourceTreeOperations(object):
 			[linux_bin] + params,
 			stdin=subprocess.PIPE,
 			stdout=subprocess.PIPE,
-			stderr=subprocess.PIPE)
+			stderr=subprocess.PIPE,
+			env=env)
 		process.wait(timeout=timeout)
 		return process
 
-- 
2.21.1

