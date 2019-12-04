Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9EC113648
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 21:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfLDUSb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 15:18:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51080 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfLDUS3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 15:18:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so1143229wmg.0;
        Wed, 04 Dec 2019 12:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=am4G9RyEJvZU3iD6UHaJrfyA1+DpEoSf8ZHszrpfUcY=;
        b=IP4F/fddg5fnCaXNGTWpg3p4FN1B9h+gRPKtUpGLvgqDbYIyvgmiHgUJvHu0aYC224
         cp0x6kYUwTGTkFNp7vAEkonNaLlKCiddnRwn3vS6nGWv+Bo6mVO+srsgFz4Q8hbAZBUF
         x16/54EVP7dupXSFj1d3+6tfQWeHGCXmuiaOG6ALs78WGJqBy1O7F4OcbihREYS/KccF
         si27ejeo9FYhNGvW62wWuuH+siR33jzu5PvkFKyUNzrOD54CbuSEQocYD/jLEtdueCk6
         xaqAwlnS1cUg0KaW4m3S8KudotFueZATzOU+Cm4W69c092ynWLoQ/6z0ICwKcJ8xdHBF
         Nlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=am4G9RyEJvZU3iD6UHaJrfyA1+DpEoSf8ZHszrpfUcY=;
        b=je5ji0Ed9aEtT+Y8ZqQoKmWsTjvVgDLp8AmLEVy3SzY2yzq4y64dZRgEzEp+ZwJFr+
         Msgd8UuborbswVwUSg9sYEbNU35+jcnGbWTW8YaMJ6LTJ8TJWn+X1ADILfVRWCI6akOC
         AErfzSksXH2EGTgkYHQTX10ePr/llBaef9Cz9qg14Fwz/v7M9673IpJYIO8o895dnWOD
         c0yOXRVTvcCBwurp5oG2/Zxl37aFZtu/zHbMdRvzu+4JL57Ow2Its3v+6grsPj6qVqZc
         KyFcFWTUXF5ut0Kj9BHNmmTrRybW3ax9fSRQsaJO1EpWj0sjCKbPfITlje67i22+oQai
         pQVQ==
X-Gm-Message-State: APjAAAVIPMe1UwxxLUpX0CASjIfqePO0dwXqOvtT3MTlPFjWbt3RfdKJ
        JagZP2G8wfZqk1rB5WW10nB9r1qw
X-Google-Smtp-Source: APXvYqwW4WdfpvQ1Z5462XKPANV3Ws1NgaI03X+nXGgSLf8EnaF0OldUwrQe+W2BYBGKJLL+shJbUw==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr1516463wmc.174.1575490707775;
        Wed, 04 Dec 2019 12:18:27 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f2sm7329254wmh.46.2019.12.04.12.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:18:27 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v4 4/5] kunit: Place 'test.log' under the 'build_dir'
Date:   Thu,  5 Dec 2019 05:18:02 +0900
Message-Id: <1575490683-13015-5-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
References: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'kunit' writes the 'test.log' under the kernel source directory even
though a 'build_dir' option is given.  As users who use the option might
expect the outputs to be placed under the specified directory, this
commit modifies the logic to write the log file under the 'build_dir'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit.py        | 2 +-
 tools/testing/kunit/kunit_kernel.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5b22241..e4250c4 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -105,7 +105,7 @@ def main(argv, linux=None):
 	run_parser.add_argument('--build_dir',
 				help='As in the make command, it specifies the build '
 				'directory.',
-				type=str, default=None, metavar='build_dir')
+				type=str, default='', metavar='build_dir')
 
 	run_parser.add_argument('--defconfig',
 				help='Uses a default kunitconfig.',
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index c04a12e..a10c0c7 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -140,10 +140,10 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def run_kernel(self, args=[], timeout=None, build_dir=None):
+	def run_kernel(self, args=[], timeout=None, build_dir=''):
 		args.extend(['mem=256M'])
 		process = self._ops.linux_bin(args, timeout, build_dir)
-		with open('test.log', 'w') as f:
+		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
 			for line in process.stdout:
 				f.write(line.rstrip().decode('ascii') + '\n')
 				yield line.rstrip().decode('ascii')
-- 
2.7.4

