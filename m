Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4683A9276
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 08:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhFPGaO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 02:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231589AbhFPG3y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14251613EF;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=gs5m/MkXQDtWTjnGDrCEoYJDvwdeXEBcGAgd7x1Plx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ub1U5hSS1AsVDRC/KTpWofaAcZrB5Qk1a2C9ufGuIUS+3JWkVJG6LUjzIjmtgjh2L
         EpbMJGMEKx9ysjFM3d+pwzU8LrA/H+lAJnRsNoQitRfnK7TIJNjzvArvvpT7hFEwPo
         v0QvNehPW6H0K95U9nJF1Q6HwZ7pngdzJ+VrBlGYh7lQZ8Lg45XlmWf9fTUzrOdC2B
         jJYzyd48CsAsqXJUfiqEC4iIHFgnQZZDLQeXlDG2MCxZFOri2bMhdd77F4iZefh8T3
         1og6k1nmY/OzpQnFsFVIPNHCxihf+NecpGR/EnaEsEKhrC4QEDFAMtoP14aqAKhE4I
         xnnqsxxRvnDTQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kIw-Bh; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>
Subject: [PATCH v2 10/29] docs: dev-tools: kunit: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:25 +0200
Message-Id: <6fde409079959a95b62b9b2692503608d7ff0dbd.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/dev-tools/kunit/faq.rst   |  2 +-
 Documentation/dev-tools/kunit/index.rst | 14 +++++++-------
 Documentation/dev-tools/kunit/start.rst |  4 ++--
 Documentation/dev-tools/kunit/tips.rst  |  5 +++--
 Documentation/dev-tools/kunit/usage.rst |  8 +++++---
 5 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index 8d5029ad210a..5c6555d020f3 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -97,7 +97,7 @@ things to try.
    modules will automatically execute associated tests when loaded. Test results
    can be collected from ``/sys/kernel/debug/kunit/<test suite>/results``, and
    can be parsed with ``kunit.py parse``. For more details, see "KUnit on
-   non-UML architectures" in :doc:`usage`.
+   non-UML architectures" in Documentation/dev-tools/kunit/usage.rst.
 
 If none of the above tricks help, you are always welcome to email any issues to
 kunit-dev@googlegroups.com.
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 848478838347..25d92a9a05ea 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -36,7 +36,7 @@ To make running these tests (and reading the results) easier, KUnit offers
 results. This provides a quick way of running KUnit tests during development,
 without requiring a virtual machine or separate hardware.
 
-Get started now: :doc:`start`
+Get started now: Documentation/dev-tools/kunit/start.rst
 
 Why KUnit?
 ==========
@@ -88,9 +88,9 @@ it takes to read their test log?
 How do I use it?
 ================
 
-*   :doc:`start` - for new users of KUnit
-*   :doc:`tips` - for short examples of best practices
-*   :doc:`usage` - for a more detailed explanation of KUnit features
-*   :doc:`api/index` - for the list of KUnit APIs used for testing
-*   :doc:`kunit-tool` - for more information on the kunit_tool helper script
-*   :doc:`faq` - for answers to some common questions about KUnit
+*   Documentation/dev-tools/kunit/start.rst - for new users of KUnit
+*   Documentation/dev-tools/kunit/tips.rst - for short examples of best practices
+*   Documentation/dev-tools/kunit/usage.rst - for a more detailed explanation of KUnit features
+*   Documentation/dev-tools/kunit/api/index.rst - for the list of KUnit APIs used for testing
+*   Documentation/dev-tools/kunit/kunit-tool.rst - for more information on the kunit_tool helper script
+*   Documentation/dev-tools/kunit/faq.rst - for answers to some common questions about KUnit
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 0e65cabe08eb..63ef7b625c13 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -21,7 +21,7 @@ The wrapper can be run with:
 	./tools/testing/kunit/kunit.py run
 
 For more information on this wrapper (also called kunit_tool) check out the
-:doc:`kunit-tool` page.
+Documentation/dev-tools/kunit/kunit-tool.rst page.
 
 Creating a .kunitconfig
 -----------------------
@@ -234,7 +234,7 @@ Congrats! You just wrote your first KUnit test!
 
 Next Steps
 ==========
-*   Check out the :doc:`tips` page for tips on
+*   Check out the Documentation/dev-tools/kunit/tips.rst page for tips on
     writing idiomatic KUnit tests.
 *   Optional: see the :doc:`usage` page for a more
     in-depth explanation of KUnit.
diff --git a/Documentation/dev-tools/kunit/tips.rst b/Documentation/dev-tools/kunit/tips.rst
index 8d8c238f7f79..492d2ded2f5a 100644
--- a/Documentation/dev-tools/kunit/tips.rst
+++ b/Documentation/dev-tools/kunit/tips.rst
@@ -125,7 +125,8 @@ Here's a slightly in-depth example of how one could implement "mocking":
 
 
 Note: here we're able to get away with using ``test->priv``, but if you wanted
-something more flexible you could use a named ``kunit_resource``, see :doc:`api/test`.
+something more flexible you could use a named ``kunit_resource``, see
+Documentation/dev-tools/kunit/api/test.rst.
 
 Failing the current test
 ------------------------
@@ -185,5 +186,5 @@ Alternatively, one can take full control over the error message by using ``KUNIT
 
 Next Steps
 ==========
-*   Optional: see the :doc:`usage` page for a more
+*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
     in-depth explanation of KUnit.
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 650f99590df5..3ee7ab91f712 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -10,7 +10,7 @@ understand it. This guide assumes a working knowledge of the Linux kernel and
 some basic knowledge of testing.
 
 For a high level introduction to KUnit, including setting up KUnit for your
-project, see :doc:`start`.
+project, see Documentation/dev-tools/kunit/start.rst.
 
 Organization of this document
 =============================
@@ -99,7 +99,8 @@ violated; however, the test will continue running, potentially trying other
 expectations until the test case ends or is otherwise terminated. This is as
 opposed to *assertions* which are discussed later.
 
-To learn about more expectations supported by KUnit, see :doc:`api/test`.
+To learn about more expectations supported by KUnit, see
+Documentation/dev-tools/kunit/api/test.rst.
 
 .. note::
    A single test case should be pretty short, pretty easy to understand,
@@ -216,7 +217,8 @@ test suite in a special linker section so that it can be run by KUnit either
 after late_init, or when the test module is loaded (depending on whether the
 test was built in or not).
 
-For more information on these types of things see the :doc:`api/test`.
+For more information on these types of things see the
+Documentation/dev-tools/kunit/api/test.rst.
 
 Common Patterns
 ===============
-- 
2.31.1

