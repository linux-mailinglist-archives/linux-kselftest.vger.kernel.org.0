Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB503A918A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 08:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhFPGCr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 02:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhFPGCq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 02:02:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 386E56128C;
        Wed, 16 Jun 2021 06:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623823241;
        bh=KGd3OxnwK4y+TjTLK0lMih6es310l3HqXRYRuikr8nQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nzNSzJhgAOOyBeSRXqffzM/RVDarHHymaL5kBG1SeayyMiglp0ZgoYiiFoLvArvR2
         UyPc22AUNhUJmgt6gnGC8QPKwPcnUYRgG+XwH6+eTR7GmZwc8dTCp1lVJ1QR9cnLjM
         rTpElnfZWVzANRvwNjk9ggsCRoMcl2u+giDlm4NTcJ2feFYE3yslBAcnbnj4WNArnK
         cik1b4clps0ESOd/7OC6Qi7wGGrf1vSgSL1pmwn5fvf+IoUneJVkK71YT28t73eYdz
         1fZ0wTCWNNZ/PHHi4o82RN8BXV6QYIUhZPl2P+WyBnIXsnEhiS8KrJjexU/w8h59d3
         /AwItwm/+/Ueg==
Date:   Wed, 16 Jun 2021 08:00:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 14/34] docs: dev-tools: kunit: avoid using ReST
 :doc:`foo` markup
Message-ID: <20210616080034.335f3e75@coco.lan>
In-Reply-To: <CABVgOSnz_94ZO2Sa8Vf70eV_tf0gksDBUhZXYXX1VS=qFR=zPw@mail.gmail.com>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
        <a3ad84108a5b254e545f88e58d411f5fe2e25c7e.1622898327.git.mchehab+huawei@kernel.org>
        <CABVgOSnz_94ZO2Sa8Vf70eV_tf0gksDBUhZXYXX1VS=qFR=zPw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Sat, 5 Jun 2021 23:44:41 +0800
David Gow <davidgow@google.com> escreveu:

> On Sat, Jun 5, 2021 at 9:18 PM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > The :doc:`foo` tag is auto-generated via automarkup.py.
> > So, use the filename at the sources, instead of :doc:`foo`.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---  
> 
> This is much better, thanks! Do note that there's a merge conflict
> (and another :doc:`` tag which needs updating) in the kunit-fixes
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=11dbc62a73a7da9f3697e8ce83d07503c11dcabb

Ok, thanks for the warning. I'm folding the enclosed patch:

<patch>
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
index 8d8c238f7f79..af3c10a44050 100644
--- a/Documentation/dev-tools/kunit/tips.rst
+++ b/Documentation/dev-tools/kunit/tips.rst
@@ -125,7 +125,7 @@ Here's a slightly in-depth example of how one could implement "mocking":
 
 
 Note: here we're able to get away with using ``test->priv``, but if you wanted
-something more flexible you could use a named ``kunit_resource``, see :doc:`api/test`.
+something more flexible you could use a named ``kunit_resource``, see Documentation/dev-tools/kunit/api/test.rst.
 
 Failing the current test
 ------------------------
@@ -185,5 +185,5 @@ Alternatively, one can take full control over the error message by using ``KUNIT
 
 Next Steps
 ==========
-*   Optional: see the :doc:`usage` page for a more
+*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
     in-depth explanation of KUnit.
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 650f99590df5..3f6490fbeb95 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -10,7 +10,7 @@ understand it. This guide assumes a working knowledge of the Linux kernel and
 some basic knowledge of testing.
 
 For a high level introduction to KUnit, including setting up KUnit for your
-project, see :doc:`start`.
+project, see Documentation/dev-tools/kunit/start.rst.
 
 Organization of this document
 =============================
@@ -99,7 +99,7 @@ violated; however, the test will continue running, potentially trying other
 expectations until the test case ends or is otherwise terminated. This is as
 opposed to *assertions* which are discussed later.
 
-To learn about more expectations supported by KUnit, see :doc:`api/test`.
+To learn about more expectations supported by KUnit, see Documentation/dev-tools/kunit/api/test.rst.
 
 .. note::
    A single test case should be pretty short, pretty easy to understand,
@@ -216,7 +216,7 @@ test suite in a special linker section so that it can be run by KUnit either
 after late_init, or when the test module is loaded (depending on whether the
 test was built in or not).
 
-For more information on these types of things see the :doc:`api/test`.
+For more information on these types of things see the Documentation/dev-tools/kunit/api/test.rst.
 
 Common Patterns
 ===============
</patch>

Still, there's one hunk that would conflict between docs-next and
linux-next. I'll send this one in separate, during the -rc1 week,
in order to solve the remaining :doc: occurrence.

Thanks!
Mauro

> 
> Reviewed-by: David Gow <davidgow@google.com>

> 
> Cheers,
> -- David
> 
> 
> 
> >  Documentation/dev-tools/kunit/faq.rst   |  2 +-
> >  Documentation/dev-tools/kunit/index.rst | 14 +++++++-------
> >  Documentation/dev-tools/kunit/start.rst |  6 +++---
> >  Documentation/dev-tools/kunit/tips.rst  |  5 +++--
> >  Documentation/dev-tools/kunit/usage.rst |  8 +++++---
> >  5 files changed, 19 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
> > index 8d5029ad210a..5c6555d020f3 100644
> > --- a/Documentation/dev-tools/kunit/faq.rst
> > +++ b/Documentation/dev-tools/kunit/faq.rst
> > @@ -97,7 +97,7 @@ things to try.
> >     modules will automatically execute associated tests when loaded. Test results
> >     can be collected from ``/sys/kernel/debug/kunit/<test suite>/results``, and
> >     can be parsed with ``kunit.py parse``. For more details, see "KUnit on
> > -   non-UML architectures" in :doc:`usage`.
> > +   non-UML architectures" in Documentation/dev-tools/kunit/usage.rst.
> >
> >  If none of the above tricks help, you are always welcome to email any issues to
> >  kunit-dev@googlegroups.com.
> > diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> > index 848478838347..25d92a9a05ea 100644
> > --- a/Documentation/dev-tools/kunit/index.rst
> > +++ b/Documentation/dev-tools/kunit/index.rst
> > @@ -36,7 +36,7 @@ To make running these tests (and reading the results) easier, KUnit offers
> >  results. This provides a quick way of running KUnit tests during development,
> >  without requiring a virtual machine or separate hardware.
> >
> > -Get started now: :doc:`start`
> > +Get started now: Documentation/dev-tools/kunit/start.rst
> >
> >  Why KUnit?
> >  ==========
> > @@ -88,9 +88,9 @@ it takes to read their test log?
> >  How do I use it?
> >  ================
> >
> > -*   :doc:`start` - for new users of KUnit
> > -*   :doc:`tips` - for short examples of best practices
> > -*   :doc:`usage` - for a more detailed explanation of KUnit features
> > -*   :doc:`api/index` - for the list of KUnit APIs used for testing
> > -*   :doc:`kunit-tool` - for more information on the kunit_tool helper script
> > -*   :doc:`faq` - for answers to some common questions about KUnit
> > +*   Documentation/dev-tools/kunit/start.rst - for new users of KUnit
> > +*   Documentation/dev-tools/kunit/tips.rst - for short examples of best practices
> > +*   Documentation/dev-tools/kunit/usage.rst - for a more detailed explanation of KUnit features
> > +*   Documentation/dev-tools/kunit/api/index.rst - for the list of KUnit APIs used for testing
> > +*   Documentation/dev-tools/kunit/kunit-tool.rst - for more information on the kunit_tool helper script
> > +*   Documentation/dev-tools/kunit/faq.rst - for answers to some common questions about KUnit
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > index 0e65cabe08eb..ee21e482a0de 100644
> > --- a/Documentation/dev-tools/kunit/start.rst
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -21,7 +21,7 @@ The wrapper can be run with:
> >         ./tools/testing/kunit/kunit.py run
> >
> >  For more information on this wrapper (also called kunit_tool) check out the
> > -:doc:`kunit-tool` page.
> > +Documentation/dev-tools/kunit/kunit-tool.rst page.
> >
> >  Creating a .kunitconfig
> >  -----------------------
> > @@ -234,7 +234,7 @@ Congrats! You just wrote your first KUnit test!
> >
> >  Next Steps
> >  ==========
> > -*   Check out the :doc:`tips` page for tips on
> > +*   Check out the Documentation/dev-tools/kunit/tips.rst page for tips on
> >      writing idiomatic KUnit tests.
> > -*   Optional: see the :doc:`usage` page for a more
> > +*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
> >      in-depth explanation of KUnit.
> > diff --git a/Documentation/dev-tools/kunit/tips.rst b/Documentation/dev-tools/kunit/tips.rst
> > index 8d8c238f7f79..492d2ded2f5a 100644
> > --- a/Documentation/dev-tools/kunit/tips.rst
> > +++ b/Documentation/dev-tools/kunit/tips.rst
> > @@ -125,7 +125,8 @@ Here's a slightly in-depth example of how one could implement "mocking":
> >
> >
> >  Note: here we're able to get away with using ``test->priv``, but if you wanted
> > -something more flexible you could use a named ``kunit_resource``, see :doc:`api/test`.
> > +something more flexible you could use a named ``kunit_resource``, see
> > +Documentation/dev-tools/kunit/api/test.rst.
> >
> >  Failing the current test
> >  ------------------------
> > @@ -185,5 +186,5 @@ Alternatively, one can take full control over the error message by using ``KUNIT
> >
> >  Next Steps
> >  ==========
> > -*   Optional: see the :doc:`usage` page for a more
> > +*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
> >      in-depth explanation of KUnit.
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > index 650f99590df5..3ee7ab91f712 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -10,7 +10,7 @@ understand it. This guide assumes a working knowledge of the Linux kernel and
> >  some basic knowledge of testing.
> >
> >  For a high level introduction to KUnit, including setting up KUnit for your
> > -project, see :doc:`start`.
> > +project, see Documentation/dev-tools/kunit/start.rst.
> >
> >  Organization of this document
> >  =============================
> > @@ -99,7 +99,8 @@ violated; however, the test will continue running, potentially trying other
> >  expectations until the test case ends or is otherwise terminated. This is as
> >  opposed to *assertions* which are discussed later.
> >
> > -To learn about more expectations supported by KUnit, see :doc:`api/test`.
> > +To learn about more expectations supported by KUnit, see
> > +Documentation/dev-tools/kunit/api/test.rst.
> >
> >  .. note::
> >     A single test case should be pretty short, pretty easy to understand,
> > @@ -216,7 +217,8 @@ test suite in a special linker section so that it can be run by KUnit either
> >  after late_init, or when the test module is loaded (depending on whether the
> >  test was built in or not).
> >
> > -For more information on these types of things see the :doc:`api/test`.
> > +For more information on these types of things see the
> > +Documentation/dev-tools/kunit/api/test.rst.
> >
> >  Common Patterns
> >  ===============
> > --
> > 2.31.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/a3ad84108a5b254e545f88e58d411f5fe2e25c7e.1622898327.git.mchehab%2Bhuawei%40kernel.org.  



Thanks,
Mauro
