Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E00558C29
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 02:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiFXANI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jun 2022 20:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiFXAM7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jun 2022 20:12:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75CE8
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jun 2022 17:12:55 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q102-20020a17090a17ef00b001ec706653e0so494867pja.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jun 2022 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0zzE+0hwQXNaa277BCLUaAHFQtGaGomDY+ljzLXGDPc=;
        b=IEzUo2EgRrGk0GpITOyDG6hDD4cn0sUzZdIKb32OJa4YDY7wxm+bUgr+FEj55cani9
         yrkBkBKNlQgyT8sue6LUkGAWUGVJELS1fUW+89AZwMI7b28vjVkKR80WI/+N4dbf0nEM
         y0wvaGVj/JaLoMyz7dsUBA/vhH10CRfAySOJicWEuqolM+3dyXQ2CJqw8K5lktiAFGKI
         YR7x5M5kcNt30LP93/xMApOluh0W4JwkrUpxGPj3Q04QtFoWA8kcIMWaiZsBoYV0GTQF
         4bsI9w1qDPvJj9xheuINDOc/QDKaBfLy2suVSholqIqID/cSmQ99momC8LOZ/GsfNdZu
         ZYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0zzE+0hwQXNaa277BCLUaAHFQtGaGomDY+ljzLXGDPc=;
        b=EmxAkmknIlbuhTlED5rEBZrqS3xDLjJOMyt/H+JODPMLc84dpKkt6Tqg6tqGOYAY2V
         8L9PitHZiAs9nUwHq5layGhiBDnBcZB4sWwwrvuLLxVCDOzauwrVI7wBeOsdOKrCDWM0
         qFCeWcqXcIqY9x5n6auG1pzyhUl/+1EmhHpxEukfKrESFAknCi+E8DcRiyOL8O/Bz5FY
         Y72QpIxAUykDujXhdwEtXtx6LRyX91ajvVCu9kivA1RlDLiaPpPCrj4pWZ/Hj+YxTu9r
         kXyEhNBBGhYt8e2ZAhGCA6OkRdQw6AvQn6qf1v8tmGAlb8rkdepuVkoX/yGV1NfAOcva
         M5Og==
X-Gm-Message-State: AJIora8MSAhiYxix6PfB0N/Tj2TQujBLKPldxTjwlRyTYKs6b8WhFUvc
        HmZfr1gmO5ADfK5MpCSaTxWzM7uEV8+9Bg==
X-Google-Smtp-Source: AGRyM1u3zrL0Jgv51XIx/x2swY4tj9A348j0qX8rcynA2ePW/Vb4iQ9O4PySWB8rzcf9HFeYcuPzKGFsj1prRQ==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr85092pje.0.1656029574951; Thu, 23 Jun
 2022 17:12:54 -0700 (PDT)
Date:   Fri, 24 Jun 2022 00:12:47 +0000
In-Reply-To: <20220624001247.3255978-1-dlatypov@google.com>
Message-Id: <20220624001247.3255978-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220624001247.3255978-1-dlatypov@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH 2/2] kunit: add coverage_uml.config to enable GCOV on UML
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that kunit.py's --kunitconfig is repeatable, let's create a file to
hold the various options needed to enable coverage under UML.

This can be used like so:
$ ./tools/testing/kunit/kunit.py run \
  --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
  --kunitconfig=tools/testing/kunit/configs/coverage_uml.config \
  --make_options=CC=/usr/bin/gcc-6

which on my system is enough to get coverage working [1].

This is still a clunky command, but far better than before.

[1] at the time of this commit, I get:
  Overall coverage rate:
    lines......: 11.6% (34112 of 295033 lines)
    functions..: 15.3% (3721 of 24368 functions)

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/running_tips.rst  |  3 +--
 tools/testing/kunit/configs/coverage_uml.config | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/kunit/configs/coverage_uml.config

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index c36f6760087d..205ea21c9cca 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -123,8 +123,7 @@ Putting it together into a copy-pastable sequence of commands:
 .. code-block:: bash
 
 	# Append coverage options to the current config
-	$ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
-	$ ./tools/testing/kunit/kunit.py run
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=.kunit/ --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
 	# Extract the coverage information from the build dir (.kunit/)
 	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
 
diff --git a/tools/testing/kunit/configs/coverage_uml.config b/tools/testing/kunit/configs/coverage_uml.config
new file mode 100644
index 000000000000..bacb77664fa8
--- /dev/null
+++ b/tools/testing/kunit/configs/coverage_uml.config
@@ -0,0 +1,11 @@
+# This config fragment enables coverage on UML, which is different from the
+# normal gcov used in other arches (no debugfs).
+# Example usage:
+# ./tools/testing/kunit/kunit.py run \
+#   --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
+#   --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
+
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_GCOV=y
-- 
2.37.0.rc0.104.g0611611a94-goog

