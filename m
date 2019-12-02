Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654CD10F39E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 00:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLBXxf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 18:53:35 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:44381 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfLBXxf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 18:53:35 -0500
Received: by mail-yb1-f201.google.com with SMTP id 63so806073ybz.11
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 15:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UeRKrWFVc6wY9N41muBnONFCKBYX0ait5S3vLExo2C8=;
        b=RGDpjo9g2s0+05+TUY8HpRUB7+2PduVCQSOy60Qh1+iVPxkuooklhCwku+SiEnKI0L
         b5qB9mxFIOsHKNxJOx4a/UVd1ppbUhUPNKBrtdNOauCww107oIAuy2mTUbwR1SEJLTjq
         aRNyNcsn7aDtjYCcDJCqYlixRa7haLhQ8rvQ74PWZX4IcHjxovu/0RFFOJPuhh3taJpc
         crzz00vYIuuWE1oIEEOe9Jh2XfLXyt3Gx9wQ+npPR0quW/KBG+1VC6/+mitVnOCuIFl2
         Qf7eRhMMEk/ieWyLrXscyQz21cegxwafthWAWNmQo7SvZHgIleptKl6I/gj/+IGW3Vrs
         sRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UeRKrWFVc6wY9N41muBnONFCKBYX0ait5S3vLExo2C8=;
        b=StAw3pTSROVLebmJVMLfJ2LCwnDSOOTIPTf1O94QvRr7DzUXvVbvfzuunVQKK1J9n2
         t9TurO7rhj4pRe8jdoPOoNXDqFQ86xH1POqOmc5e+fXXF5vc4jBsvkuQbMeovT0lldoi
         rteDum6Ag36RjFctQi9lKmldOIhwprKHwh4fVl3bE6XSv+cAhed65rke/oBxo2C32c1x
         qz5btq9ALBsgZZ9yXNftBP/MVK11YRV2N7GUfpIqe4od6f0DQLvoOB1n16ZDGm6RM2Cu
         S8Jfc1fmSNV4pVaX7jpeP2ytnQS3pR6zoOkuui+F1UkquQaUz6p9B+H+Y7JXUhEtHVxK
         1NhA==
X-Gm-Message-State: APjAAAW+7T6x+eoAwU4QcG+6GXIXuNCXC40ZWSReBYU+wFPkwtSQWVlL
        1wz0juDw+Yx4w8tfhb1uGH//sTrVngc/FxWI
X-Google-Smtp-Source: APXvYqzmaUROhknPs3h84wqPTsgnp/3k+KDptOqKEFmduxF1uHlGv1cWBX/AyR/Vw9ASXdFPSaggJabpNdUQnDb0
X-Received: by 2002:a0d:c205:: with SMTP id e5mr1182728ywd.165.1575330813948;
 Mon, 02 Dec 2019 15:53:33 -0800 (PST)
Date:   Mon,  2 Dec 2019 15:53:29 -0800
Message-Id: <20191202235329.241986-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2] kunit: testing kunit: Bug fix in test_run_timeout function
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, shuah@kernel.org
Cc:     sj38.park@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Heidi Fahim <heidifahim@google.com>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Assert in test_run_timeout was not updated with the build_dir argument
and caused the following error:
AssertionError: Expected call: run_kernel(timeout=3453)
Actual call: run_kernel(build_dir=None, timeout=3453)

Needed to update kunit_tool_test to reflect this fix
https://lkml.org/lkml/2019/9/6/351

Signed-off-by: Heidi Fahim <heidifahim@google.com>
Reviewed-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit_tool_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 4a12baa0cd4e..a2a8ea6beae3 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -199,7 +199,7 @@ class KUnitMainTest(unittest.TestCase):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=None, timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':
-- 
2.24.0.393.g34dc348eaf-goog

