Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5372811C33E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 03:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfLLC1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 21:27:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35672 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfLLC1Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 21:27:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so295568pfo.2;
        Wed, 11 Dec 2019 18:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yFujqdF7KSTFJjQQeDlyK/5HsN3cecg9EghFg3vBGxk=;
        b=M3TboQWYgdcx0JYFTTeu3fEYtHLHJOQTYEYOvIZodI/Fpx4OVg++6DWa1usRfgvUso
         zYaHlPPD2LqSVzVn1P+ovu7s+EFLr+4sfQLPouxrsy+ujqGcnsPDPs50XFNucaCfYSJe
         /f7e3+e5KIdHRg9dxiaD0kv0PCHZVkw9Kwc8ViS0R0MdMARP+FHTNH0DMXxMUXBKAtQP
         FwAsVEhLBw3v7DBTpXwQWxlUTft2WlKvqaAzFM2HR3WO8d7BZe2ug9xvs2c+CXgGzycs
         nyQCQZaFFcEnO/IzlvFAEFqKEP99Ws/ftwy1lY/7LoHTri/2zBvNJQChDfdYe/16UHvH
         JO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yFujqdF7KSTFJjQQeDlyK/5HsN3cecg9EghFg3vBGxk=;
        b=cFOgAh/paEfsTmJXZNxgLxhVbGzmzwKjE87teaHDctFUPJu5qKpJvMjIKGlML9Cf4W
         rxK77CXsjW9qJeoj/bA5BW1i3M0xTGu3kX1yTiYSB/r4CndaT6qfSGbTkiMN4W0AWExS
         pbJpcvX3EUXYhrKAU77Fl6f5FNCguztQ1QA/nLPD+KwXKURgi27Ci+D81kO/ud/cPYXs
         OJYg93bsfrgnoZOXGu5CtMYdkT8ifocCfZb579UQd5zqPAoiLvLSaQh1rQITW97f0/Hy
         GgWxtjyB0XZ+hO+wIrOM/LxUP+brZqedz3RM0qPf4Ozf4s0+nKnqwxSIV1IlRhwKbzjf
         siWw==
X-Gm-Message-State: APjAAAXcukyn7kUiAKmao0bdg4Kc4X/cwaxEFcjNe9gkZLKQpD1J3j8g
        //uVRJKmzrc1qIbJxWDmXdA=
X-Google-Smtp-Source: APXvYqxITzrasjB22U3/KJWgHX9aDzdbZHo1v+SvqYboBvMwPBgGHw4iXnCWwjsOooH1JKxY8VIlfA==
X-Received: by 2002:a63:c406:: with SMTP id h6mr8035736pgd.213.1576117644144;
        Wed, 11 Dec 2019 18:27:24 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id d22sm4245173pgg.52.2019.12.11.18.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 18:27:23 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sj38.park@gmail.com,
        sjpark@amazon.de
Subject: [PATCH v6 2/6] kunit: Remove duplicated defconfig creation
Date:   Thu, 12 Dec 2019 02:27:07 +0000
Message-Id: <20191212022711.10062-3-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212022711.10062-1-sjpark@amazon.de>
References: <20191212022711.10062-1-sjpark@amazon.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

'--defconfig' option is handled by the 'main() of the 'kunit.py' but
again handled in following 'run_tests()'.  This commit removes this
duplicated handling of the option in the 'run_tests()'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index efe06d621983..f8f26951cd1b 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -37,9 +37,6 @@ def create_default_kunitconfig():
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
-	if request.defconfig:
-		create_default_kunitconfig()
-
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir)
 	config_end = time.time()
-- 
2.17.1

