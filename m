Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450FB19A350
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Apr 2020 03:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgDABgp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Mar 2020 21:36:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39402 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbgDABgp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Mar 2020 21:36:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id f20so20365264qtq.6
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Mar 2020 18:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbgGcVF0EJCkLy2QmL9Rcj9NjTuET0dt713t3OmqqbY=;
        b=j237GYzKoXjs1kMFmRh42jSasBRN0D7GB+dLS33p3s+FcbM6DlqulG5sneDSwJ761j
         V6fW4MvqxnPCFHSrD0hFA405b6NxssHove7YA0wgQVqlPCwdX7fcyo/Esvn9jcAQryok
         Ywu2ZvldoS3Jc4Xlo9EoDX8zrF6E8uN5RWChZ8yjeyc5XmhAUpdJa8Suzjgw4gJr7G3F
         C9dpxGJrABuWQN+S9kP+tbtrUKowkIcxuUEVcV2X97JC1WuNB2HGfF6HDMhctd2BpAue
         hx1+nimq1fJ441QW8i9Bwj3byVdnEu/nyypKLLeJoeaibIsK9o3zZM4GFXNfVgtOfZ1z
         eioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbgGcVF0EJCkLy2QmL9Rcj9NjTuET0dt713t3OmqqbY=;
        b=buyJuGiqXPqu8nq7+wn/G2l77AHEW6eJdSPE6k9agvIwYtxjzr7GiJHsbs4R6OsBN8
         wJeOEm41B9O07qIH2aiH+rCJaWf718+f16FPOkuBImN9nAca2zdWzlR5upDZEb0c2Pt7
         9vp+/D4o+gT12Np/Onns45aLQpiNVWP410M68pW82PT9Yf7dRusXILvz/g3yCjLlmiyG
         ai+Sdw9KZr9WIBXhH1LIpzmmSQML1U0NFgbKxWmt70SLATotVBj29ubHdU7iDKWKRMUC
         KPo/+8P29YRtLnyeGg7C6lIvi5Ja9n2d8EzV1z7BU+PnkFMyCQY4NUiI2Tv/4LlW2qQC
         r9tg==
X-Gm-Message-State: ANhLgQ0h18kub3yRWwZOdSmpxXsM2fqU4J+fMSOzF7TQ1tSCSpeUwzYO
        k0m1ag4Ep2AW56AJxCN6o8xbcw==
X-Google-Smtp-Source: ADFU+vuCtJl0alErKaDbHnravdHUnZEMxreqX2xAcP5PQ+W9SAURzTl80251dKNQNke6ULhDfGC3JQ==
X-Received: by 2002:ac8:1608:: with SMTP id p8mr8109582qtj.123.1585705003728;
        Tue, 31 Mar 2020 18:36:43 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id w28sm513147qtc.27.2020.03.31.18.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 18:36:43 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] kunit: Fix kunit.py run --build_dir='<foo>' fails on "unclean" trees
Date:   Tue, 31 Mar 2020 22:36:39 -0300
Message-Id: <20200401013639.16388-1-vitor@massaru.org>
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
v2:
 - Use the correct next branch
---
 tools/testing/kunit/kunit_kernel.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index cc5d844ecca1..5c30751387c7 100644
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

