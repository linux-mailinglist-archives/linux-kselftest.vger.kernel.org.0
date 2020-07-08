Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E9621929B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 23:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGHVhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jul 2020 17:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVhb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jul 2020 17:37:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77409C061A0B
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Jul 2020 14:37:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y3so327551ybf.4
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jul 2020 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PXdA0rNG8aGRV2ZzjVBiGuKlp3LZqY6KQhSWMv0h4t4=;
        b=jlfj14tJJso5xJQh2ZFFUs+makolFUrtgyAdJTx9tMshD9dQ4nIfqgVBWvXrCFtUjW
         tPjDOLfUBINVIxsCnn8HVfGIfL8tNijy3YNFr/s/B5grX6afT81g0nBf1biHctoipWCg
         Mnk6HeZMMiUtYz0ZWIJZxSyOxK78K5wCTlYcvd7ItygslKBi9ig+BZvRjgJk2AUCDzVf
         lVzsc9WErPnKTAEPfoVRpGsbI+2B/psJffTfyQAl9Z9Q8+H1qIi84CcGyndNSp+/7ICp
         JfxQ4iZExzvGzvmwyHTcbqYqRU+UwwyM/6Uf+EKK/gZKa6VJb1hYZJW7mwXePCx9V6Im
         KQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PXdA0rNG8aGRV2ZzjVBiGuKlp3LZqY6KQhSWMv0h4t4=;
        b=WEoOk21nnQWGsDF18EwdhXvsBslgegI1OaPc5RJa5kw9mhH87bfL+4Uqkqxjes2Rle
         s0BxfQ5rgTxX0syl9DjdtOiLnzQgIfbs0O0yd8rDTZi2XnpQIHSyDmmy3O6CeEti3+YL
         sFBwVCFWmu3hFsihb7kzjwEjE6k/oBpQClhdaelIu3f2ygFYGZ79wJVUl1/+vFNYle1g
         2Uz2IQHxju79t4exXqvpTEqftq7PVj9xs7edIxyv3cY7gtPL/cqzNwdOw6+asw+cpd+t
         rYNiGi8kDzVH/WazlcPuUGsmk9YI7oPOqpiyYX4JqcndG7Ir46JNyry5rejgjhtwnBot
         rArw==
X-Gm-Message-State: AOAM53013GU/o7SYYuStUOsM305821Erce5cbxFUUXVJBGeo4G2+DJEe
        sP+tO1/tJOrREWwfnhMk8djrw5xemys=
X-Google-Smtp-Source: ABdhPJzIAK/YhDl8oNzm9DEGNOQQXAqOey/d2Kazv/0TNh0ZqLlJor388FJ1PxZwqByTgY20/BZETshRzyE=
X-Received: by 2002:a25:ad03:: with SMTP id y3mr13948847ybi.411.1594244250479;
 Wed, 08 Jul 2020 14:37:30 -0700 (PDT)
Date:   Wed,  8 Jul 2020 14:35:43 -0700
Message-Id: <20200708213543.1365306-1-chenwi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] kunit: capture stderr on all make subprocess calls
From:   Will Chen <chenwi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     Will Chen <chenwi@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Direct stderr to subprocess.STDOUT so error messages get included in the
subprocess.CalledProcessError exceptions output field. This results in
more meaningful error messages for the user.

This is already being done in the make_allyesconfig method. Do the same
for make_mrproper, make_olddefconfig, and make methods.

With this, failures on unclean trees [1] will give users an error
message that includes:
"The source tree is not clean, please run 'make ARCH=um mrproper'"

[1] https://bugzilla.kernel.org/show_bug.cgi?id=205219

Signed-off-by: Will Chen <chenwi@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 63dbda2d029f..e20e2056cb38 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -34,7 +34,7 @@ class LinuxSourceTreeOperations(object):
 
 	def make_mrproper(self):
 		try:
-			subprocess.check_output(['make', 'mrproper'])
+			subprocess.check_output(['make', 'mrproper'], stderr=subprocess.STDOUT)
 		except OSError as e:
 			raise ConfigError('Could not call make command: ' + e)
 		except subprocess.CalledProcessError as e:
@@ -47,7 +47,7 @@ class LinuxSourceTreeOperations(object):
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command, stderr=subprocess.PIPE)
+			subprocess.check_output(command, stderr=subprocess.STDOUT)
 		except OSError as e:
 			raise ConfigError('Could not call make command: ' + e)
 		except subprocess.CalledProcessError as e:
@@ -77,7 +77,7 @@ class LinuxSourceTreeOperations(object):
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command)
+			subprocess.check_output(command, stderr=subprocess.STDOUT)
 		except OSError as e:
 			raise BuildError('Could not call execute make: ' + e)
 		except subprocess.CalledProcessError as e:
-- 
2.27.0.383.g050319c2ae-goog

