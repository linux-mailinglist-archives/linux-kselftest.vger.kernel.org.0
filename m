Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D691102E52
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 22:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKSVjC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 16:39:02 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52183 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfKSVjC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 16:39:02 -0500
Received: by mail-pg1-f201.google.com with SMTP id f18so4271702pgh.18
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2019 13:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6Oh8ez2vQeUAb5PnTKMOWQGApcFEd8vMEamkT67anhA=;
        b=l8EMZDoz0ncUEb4shgTBSTIj1pS4wqZFXkz7gFMBxdZSjfycv6kM3MA/0efHq1TYGS
         bQ8xu8kr0EfaIywUvuBjrpKOZi+dpA4ASU4DQ1F50s2oLIDMJoC9A34cXKw+U8S5PhIm
         zpo/Ytsfiy2l4Yx9wr9SsWw5NgSv89oqfO88TPOozgedrlP/chHEcbHua5kRWywRgwVI
         z4rLgpQBiC6iy6pW7ClaYLFfwCTYTjrkB0C5pAAINwyTnCzjCkKf2pZSlLEK17fwKFoG
         xJOzucXyeHBIJowKHjryY3FrpF78uFB24kMuBxJ+3BIJxazcaKAI6D3qJz0UVXv1cOho
         hSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6Oh8ez2vQeUAb5PnTKMOWQGApcFEd8vMEamkT67anhA=;
        b=o8PWkQDJK6+LNNOmH4P7anW8hvbOZ15ip4nsUvglojDobtQsIrWjB0Z43ZmUVNx5fK
         eR4NHAknXIz013UkMx6TfkpPFeog65eASgTwPn0LVGeCyEgjsTRIDlHNtJ3Ue4kuvyCb
         0hh7Ru0eFx6RZRuZl2beIL+zS1/fTrjRN3hTc5QfW/YxH5ql9JRlXkXsCQvfR7h060qA
         sLKwQBU+iYfJdEdWugd4qScHFTqIIFHwigNR8HIKJVi9Z0tzGzZn0ilTg8/LmG+oOACt
         E5j1KiaEF3jwxKANVDkug9Pl2hbrff9i3MzWT4UIYY6rGwXgQrJNqk6wWzGWmB+vPHzn
         k2Xw==
X-Gm-Message-State: APjAAAVSNJ+krqWUoTkepgHQJewIuQzKOHdca6i+9w8IzoZaFUMIoZug
        KZrND8LdpDETGQ4vcNmQkYXcR7M+GpSDurLEWCFsWg==
X-Google-Smtp-Source: APXvYqyih2Ae2jisYX7fb/lrrEwx4vhyeYz8YkVDI9WOTJOniDNVRainjgvbEDqanmXZtuTtyPFGrgSb+6dOtRyyh5t1Pw==
X-Received: by 2002:a65:5648:: with SMTP id m8mr2923798pgs.286.1574199541054;
 Tue, 19 Nov 2019 13:39:01 -0800 (PST)
Date:   Tue, 19 Nov 2019 13:38:34 -0800
Message-Id: <20191119213834.175992-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH linux-kselftest/test v1] Documentation: kunit: fix typos and
 gramatical errors
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, heidifahim@google.com, trishalfonso@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix typos and gramatical errors in the Getting Started and Usage guide
for KUnit.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://patchwork.kernel.org/patch/11156481/
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/start.rst |  6 +++---
 Documentation/dev-tools/kunit/usage.rst | 22 +++++++++++-----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index f4d9a4fa914f8..db146c7d77490 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -26,7 +26,7 @@ For more information on this wrapper (also called kunit_tool) checkout the
 
 Creating a kunitconfig
 ======================
-The Python script is a thin wrapper around Kbuild as such, it needs to be
+The Python script is a thin wrapper around Kbuild. As such, it needs to be
 configured with a ``kunitconfig`` file. This file essentially contains the
 regular Kernel config, with the specific test targets as well.
 
@@ -62,8 +62,8 @@ If everything worked correctly, you should see the following:
 followed by a list of tests that are run. All of them should be passing.
 
 .. note::
-   Because it is building a lot of sources for the first time, the ``Building
-   kunit kernel`` step may take a while.
+	Because it is building a lot of sources for the first time, the
+	``Building KUnit kernel`` step may take a while.
 
 Writing your first test
 =======================
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c6e69634e274b..ae42a0d128c27 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -16,7 +16,7 @@ Organization of this document
 =============================
 
 This document is organized into two main sections: Testing and Isolating
-Behavior. The first covers what a unit test is and how to use KUnit to write
+Behavior. The first covers what unit tests are and how to use KUnit to write
 them. The second covers how to use KUnit to isolate code and make it possible
 to unit test code that was otherwise un-unit-testable.
 
@@ -174,13 +174,13 @@ Test Suites
 ~~~~~~~~~~~
 
 Now obviously one unit test isn't very helpful; the power comes from having
-many test cases covering all of your behaviors. Consequently it is common to
-have many *similar* tests; in order to reduce duplication in these closely
-related tests most unit testing frameworks provide the concept of a *test
-suite*, in KUnit we call it a *test suite*; all it is is just a collection of
-test cases for a unit of code with a set up function that gets invoked before
-every test cases and then a tear down function that gets invoked after every
-test case completes.
+many test cases covering all of a unit's behaviors. Consequently it is common
+to have many *similar* tests; in order to reduce duplication in these closely
+related tests most unit testing frameworks - including KUnit - provide the
+concept of a *test suite*. A *test suite* is just a collection of test cases
+for a unit of code with a set up function that gets invoked before every test
+case and then a tear down function that gets invoked after every test case
+completes.
 
 Example:
 
@@ -211,7 +211,7 @@ KUnit test framework.
 .. note::
    A test case will only be run if it is associated with a test suite.
 
-For a more information on these types of things see the :doc:`api/test`.
+For more information on these types of things see the :doc:`api/test`.
 
 Isolating Behavior
 ==================
@@ -454,7 +454,7 @@ KUnit on non-UML architectures
 By default KUnit uses UML as a way to provide dependencies for code under test.
 Under most circumstances KUnit's usage of UML should be treated as an
 implementation detail of how KUnit works under the hood. Nevertheless, there
-are instances where being able to run architecture specific code, or test
+are instances where being able to run architecture specific code or test
 against real hardware is desirable. For these reasons KUnit supports running on
 other architectures.
 
@@ -557,7 +557,7 @@ run your tests on your hardware setup just by compiling for your architecture.
 .. important::
    Always prefer tests that run on UML to tests that only run under a particular
    architecture, and always prefer tests that run under QEMU or another easy
-   (and monitarily free) to obtain software environment to a specific piece of
+   (and monetarily free) to obtain software environment to a specific piece of
    hardware.
 
 Nevertheless, there are still valid reasons to write an architecture or hardware
-- 
2.24.0.432.g9d3f5f5b63-goog

