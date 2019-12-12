Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA411C33A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 03:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfLLC12 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 21:27:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46316 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfLLC12 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 21:27:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so307659pgb.13;
        Wed, 11 Dec 2019 18:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CeHZmew+4fucmWx3flByYCHmWF3GN8c4eetw7jkXQA0=;
        b=q9g16o0tKc4t6Sf2qGrABEj2tsjyKw2fWr+zPrjkHOoFkt61yA6UumGtek0BqZ+6XC
         DN2/GPk7hySLkwmkmn9tdGbND5/+B7kdtl94GOfjUwIjqw7dTm7vVVRG1zsUZZb61rMR
         x9J+pWcIwyJ9cR8GlWeOBYZveVeKleVGi+gIHvBM1iyuS/jN6vB68ms2sdpbsaeZoi1p
         VMiw3lq6052q+Bbo+XJcm4s21WSnOrUg1M3GB06dQqP0OERgvcGpfx/3WKLPSv3f7b74
         apbRtTOEsfJCk9gYhhGD0HzVSuGdXswX9Spn8LAZbisQGt3xtzNDYL5s5O22jtXKLjsO
         JbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CeHZmew+4fucmWx3flByYCHmWF3GN8c4eetw7jkXQA0=;
        b=OPMSrJGqPDLCISQJKPMycjGM0f4Lw29IdGFnr2/KhSHvHCG0bvqS1R3jpDLSLL2hqH
         npCsJTeSR7B8stF+3raLdtd3mVKHiVf0Jiu6wi4yZxJ99sLtIQgPxn8WUvQufumRaNXa
         TuLtAThuDfggOEm36I3xPiYx1tVX1zwOIOmrHgUrIJ9GnCvxIqP+WIfT1jnVj5B8Tm2E
         CyCbpc6O0yYWbPKMyg9WA/Gxy07BFz21u3tBHs+CJh+0KwBSYu4+X1oMAfEEScYOSuoK
         SOZfOaVUCg+fU+9ERowdDr5np6Y2lr1fe0fe0k0NsdnlFxMFuDhS6KjyjQjUpOGmt30B
         A7hg==
X-Gm-Message-State: APjAAAU7lzLzdP8bs9Kbz5L0RlaTcyesugPRejeF8tTaEYRl/yjPDVTD
        Mp1z3eQs25Us2UYY8bR808U=
X-Google-Smtp-Source: APXvYqxJCYQEx6W1kxgsuysVD7Wm5ZbigplWxVjd2E+9qLsnn/jK30+3uJ6y7AMTk5VZfPqthfyURQ==
X-Received: by 2002:a63:a4b:: with SMTP id z11mr7526272pgk.97.1576117647259;
        Wed, 11 Dec 2019 18:27:27 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id d22sm4245173pgg.52.2019.12.11.18.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 18:27:26 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sj38.park@gmail.com,
        sjpark@amazon.de
Subject: [PATCH v6 4/6] kunit: Place 'test.log' under the 'build_dir'
Date:   Thu, 12 Dec 2019 02:27:09 +0000
Message-Id: <20191212022711.10062-5-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212022711.10062-1-sjpark@amazon.de>
References: <20191212022711.10062-1-sjpark@amazon.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

'kunit' writes the 'test.log' under the kernel source directory even
though a 'build_dir' option is given.  As users who use the option might
expect the outputs to be placed under the specified directory, this
commit modifies the logic to write the log file under the 'build_dir'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py           | 2 +-
 tools/testing/kunit/kunit_kernel.py    | 4 ++--
 tools/testing/kunit/kunit_tool_test.py | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5b222418eacd..e4250c4b06fb 100755
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
index c04a12e2f711..a10c0c787bc1 100644
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
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index a2a8ea6beae3..22f16e66b3c1 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -199,7 +199,7 @@ class KUnitMainTest(unittest.TestCase):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=None, timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':
-- 
2.17.1

