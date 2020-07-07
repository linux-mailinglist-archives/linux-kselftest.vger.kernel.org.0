Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8D216566
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 06:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgGGEcE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 00:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgGGEcD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 00:32:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A577BC061755
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jul 2020 21:32:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o140so45331393yba.16
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jul 2020 21:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bSieeJifIVIrHN3z5di4jeqqr1xXTV3Iv6pZZ8KLoOc=;
        b=Hp5nO+v2HQgAYY+oLVI0jiIkGiZNdqok1IhMoBTc7zoe6wfbeDZSAnVLFURhrC9jqF
         Eto/TUZQqRXxhVZjINsrUlkmGgUpJVbvRRvGeQwnrrI8Yw16n+AZncmIGLpj8tL4LDrU
         WFB9gh2mP9JuEkknna7TQglRdgoF0XVBCf4puEHxBOWEW4VNdgNQHrlij7bXu87zbQoA
         qs3vGVXEbKhz26OJLHt/ETlH+ZAFfpaFvIVWpay41Oa9ORTK9JAmXkXvIHwgh81eqUfB
         MRz29Oga86VLzRhKYxU0NHtLH20M04rRJdDM5CHLSvN6PCoCDFcjYdQ/BKmj9Ga7gBOw
         XR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bSieeJifIVIrHN3z5di4jeqqr1xXTV3Iv6pZZ8KLoOc=;
        b=NTjqfalY3TutcpBoFKWq85+hI5POU45juplooNPdC72ZIlPaqiEuM8tYhsh1b00v6a
         R83521LEMX/kuLS3ZjpsiS3XsFckbfYMFw7GPvIBmdGMgFvCXjH2GP+uM4d4+EQ9sF0W
         pgDHJu1YwtRTF+a3//aOb9fDzhL8BC/JBfuxSUEJKxiDMJ0WD76K0MfF87jZG9L5kmd8
         5wKtzvHwTc6y42W6nVZR/pzE1sbXJ0GyYwn7atrnhBRuL+ZyQeWH9fu817I6HELOZMsE
         yauLLdDt0BCPE6phMT3E3M6/c2VmON1XofEitxwRT5B4XEcQh4fexTKrdqRRjOuaefmb
         uuQg==
X-Gm-Message-State: AOAM531IFztJaXDJQErwGvuMnbhOLodr7DwEO0nVMwfxXkpGkKAIXKTc
        9l2mbQJBruMGZ2/9ZxvLBFJU+jn45wq8qA==
X-Google-Smtp-Source: ABdhPJyW2ZGUSk2EaVISeQfvjunyOBHDAXEWrY4Tyhrbj9oNjJRSJGVCeWSH5cytKMNnTkN3wb/fSIefOeUU3A==
X-Received: by 2002:a25:3d5:: with SMTP id 204mr38355148ybd.442.1594096322922;
 Mon, 06 Jul 2020 21:32:02 -0700 (PDT)
Date:   Mon,  6 Jul 2020 21:31:20 -0700
Message-Id: <20200707043119.3016937-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] Documentation: kunit: Remove references to --defconfig
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     SeongJae Park <sjpark@amazon.de>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The --defconfig option in kunit_tool was removed in [1], but the getting
started and kunit_tool documentation still encouraged its use. Update
those documents to reflect that it's no-longer required, and is the
default behaviour if no .kunitconfig is found.

Also update a couple of places where .kunitconfig is still referred to
as kunitconfig (this was changed in [2]).

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=9bdf64b35117cc10813d24e1842cd8ee40ecbf19
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=14ee5cfd4512ee3d1e0047d8751450dcc6544070

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/kunit-tool.rst | 17 +++++------------
 Documentation/dev-tools/kunit/start.rst      |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index 949af2da81e5..29ae2fee8123 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -19,13 +19,13 @@ compiles the kernel as a standalone Linux executable that can be run like any
 other program directly inside of a host operating system. To be clear, it does
 not require any virtualization support: it is just a regular program.
 
-What is a kunitconfig?
-======================
+What is a .kunitconfig?
+=======================
 
 It's just a defconfig that kunit_tool looks for in the base directory.
 kunit_tool uses it to generate a .config as you might expect. In addition, it
 verifies that the generated .config contains the CONFIG options in the
-kunitconfig; the reason it does this is so that it is easy to be sure that a
+.kunitconfig; the reason it does this is so that it is easy to be sure that a
 CONFIG that enables a test actually ends up in the .config.
 
 How do I use kunit_tool?
@@ -46,16 +46,9 @@ However, you most likely want to use it with the following options:
 - ``--timeout`` sets a maximum amount of time to allow tests to run.
 - ``--jobs`` sets the number of threads to use to build the kernel.
 
-If you just want to use the defconfig that ships with the kernel, you can
-append the ``--defconfig`` flag as well:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all` --defconfig
-
 .. note::
-	This command is particularly helpful for getting started because it
-	just works. No kunitconfig needs to be present.
+	This command will work even without a .kunitconfig file: if no
+        .kunitconfig is present, a default one will be used instead.
 
 For a list of all the flags supported by kunit_tool, you can run:
 
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index bb112cf70624..d23385e3e159 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -18,7 +18,7 @@ The wrapper can be run with:
 
 .. code-block:: bash
 
-	./tools/testing/kunit/kunit.py run --defconfig
+	./tools/testing/kunit/kunit.py run
 
 For more information on this wrapper (also called kunit_tool) check out the
 :doc:`kunit-tool` page.
-- 
2.27.0.212.ge8ba1cc988-goog

