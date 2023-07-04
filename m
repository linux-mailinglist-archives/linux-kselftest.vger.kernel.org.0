Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA229746FE9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGDL2V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjGDL2V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 07:28:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149429D;
        Tue,  4 Jul 2023 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688470099; x=1720006099;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLH9BsfOqltAc7sUdtQbt5H7vdYrLnD89rq6FQ8+RPE=;
  b=HLAhSjDKfBogcyolvtc3siPy49HhgYhSeJ48kJnZ79UMoqnbPs1SZvWz
   JUK5BBX30PW0+GG4aVOiYgV20pEbZ4QtrGz0F/jvFiEzttYf0uDskce3T
   A6K6p5VBxAL9kSEKgASDYZyoapae2rV7rGFK0zOVIuKZP1igwVuyF5tEM
   kKa7p9eElPavne8eu5z7xvgAjB2vZKsY90ZPnNDAkS96YuyIXpEnRfjCy
   5fs0Ob5/cFH/eoY3iQcDE9/oyS0UOGulvVc3sW3H+xPOahAcPsArMEbLW
   FvHx0IseTmVGpurQAsjEt7L5iBkhxKPkAOCAppktopO8MxFw3f8x74PJK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="426784535"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="426784535"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 04:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="669069624"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="669069624"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2023 04:28:18 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.26.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7169C580BB8;
        Tue,  4 Jul 2023 04:28:15 -0700 (PDT)
Date:   Tue, 4 Jul 2023 13:28:12 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        mauro.chehab@intel.com, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmoar@google.com>
Subject: Re: Tests documentation
Message-ID: <20230704132812.02ba97ba@maurocar-mobl2>
In-Reply-To: <CABVgOSk2uW6DN8682om3Mxn9O3oF4mDYY1vdG-R9z6YC0B+Ndw@mail.gmail.com>
References: <20230702092308.4a022336@sal.lan>
        <CABVgOSk2uW6DN8682om3Mxn9O3oF4mDYY1vdG-R9z6YC0B+Ndw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 4 Jul 2023 17:45:54 +0800
David Gow <davidgow@google.com> wrote:

> (+CC Rae, for attributes/fields)
> 
> On Sun, 2 Jul 2023 at 15:23, Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> >
> > Hi Jon, Shuah & others,
> >
> > I'd like to discuss with you with regards to test documentation.
> >
> > I had some preliminary discussions with people interested on improving
> > tests during EOSS last week in Prague, as we're working to improve media
> > test coverage as well. During such discussions, I talked with developers
> > from several companies that have been collaboration and/or using Kernel
> > CI. I also talked with Nikolai from Red Hat, who gave a presentation about
> > Kernel CI, which points that one of the areas to be improved there is
> > documentation.
> >
> > So, it seems it is worth having some discussions about how to improve
> > Kernel test documentation.
> >  
> 
> Awesome: it'd definitely be nice to have some better documentation for
> specific tests. While the documentation for test systems as a whole
> seems okay (though could always do with improvement), I agree that
> documentation for individual test suites seems to mostly be either
> nonexistent, or exists only as unstructured text somewhere in the
> subsystem docs (or worse, a random wiki).

Yeah, we had the same problem on IGT. There are even internal
spreadsheets with documentation. That's why I ended writing scripts
to import from/to xls files.

> I've left a few first impressions / notes below:
> 
> > While kernel_doc does a pretty decent job documenting functions and data
> > structures, for tests, the most important things to be documented are:
> >
> >         a. what the tests do;
> >         b. what functionalities they are testing.
> >
> > This is a lot more important than documenting functions - and the used
> > data structures on tests are typically the ones that are part of the
> > driver's kAPI or uAPI, so they should be documented somewhere else.
> >
> > Usually, (b) is not so simple, as, at least for complex hardware,
> > the tested features are grouped on an hierarchical way, like:
> >
> >         1. hardware
> >         1.1 DMA engine
> >         1.2 output ports
> >         ...
> >         2. firmware
> >         2.1 firmware load
> >         2.2 firmware DMA actions
> >         ...
> >         3. kernel features
> >         3.1 memory allocation
> >         3.2 mmap
> >         3.3 bind/unbind
> >         ...
> >
> > CI engines running the test sets usually want to produce a report that will
> > be providing pass rates for the tested features and functionalites that
> > are available at the driver's and their respective hardware and firmware.
> >
> > I've doing some work at the tool we use to test DRM code [1] in order to
> > have a decent documentation of the tests we have hosted there, focusing
> > mostly on tests for i915 and Xe Intel drivers, also covering documentation
> > for DRM core tests - while providing support for other vendors to also
> > improve their test documentation for IGT - IGT GPU tools and tests.
> >
> > The documentation tool I developed is generic enough to be used for other
> > test sets and I believe it could be useful as well to document Kselftest
> > and KUnit.
> >
> > The core of the tool (at test_list.py) is a Python class, with some callers
> > (igt_doc.py, xls_to_doc.py, doc_to_xls.py), being extensible enough to
> > also have other callers to integrate with external tools. We are
> > developing internally one to integrate with our internal Grafana reports
> > to report the pass rate per documented feature, in an hierarchical way.  
> 
> A lot of tests/test frameworks already have some sort of hierarchy: I
> suspect there'll be some cases where it makes sense to either
> duplicate that, or deviate from it, but it'd be nice to reuse it where
> it makes sense.

Agreed. 

> I imagine this gets more interesting as we have tests which span
> different frameworks, or if we have tests which need to show up
> multiple times.

Heh, true. I guess we'll need to play with it for a while to identify
the actual issues when this happens, if any.

> > Something similar to:
> >
> >         1. hardware        pass rate:  98% (98 tests passed of 100)
> >         1.1 DMA engine     pass rate:  80% (8  tests passed of  10)
> >         1.2 output ports   pass rate: 100% (10 tests passed of  10)
> >         ...
> >
> > It is based on the concept that test documentation should be placed as
> > close as possible to the actual code implementing the test sets. It was
> > also be developed in a way that the documentation grouping is flexible.
> > The code was written from the scratch in Python and was implemented
> > inside a class that can also be re-used to do do other nice things,
> > like importing/exporting test documentation to spreadsheets and
> > integration with other tools (like Grafana).
> >
> > The actual documentation tags look like this:
> >
> >         /**
> >          * TEST: Check if new IGT test documentation logic functionality is working
> >          * Category: Software build block
> >          * Sub-category: documentation
> >          * Functionality: test documentation
> >          * Issue: none
> >          * Description: Complete description of this test
> >          *
> >          * SUBTEST: foo
> >          * Description: do foo things
> >          *      description continuing on another line
> >          *
> >          * SUBTEST: bar
> >          * Description: do bar things
> >          *      description continuing on another line
> >          * Functionality: bar test doc
> >          */  
> 
> How would these test/subtest names fit with, e.g., KUnit test/suite
> names? Would we want to require them to be the same, in which case can
> we parse them from the actual test declarations? Or would tests end up
> with multiple names?

It probably makes sense to rename the above tags to match KUnit 
test/suite. 

On IGT, we actually have a third level. There, we're using "@" to
go down to the third level, so we have things like:

	SUBTEST: perf@blt
	SUBTEST: perf@engine_cs

For the extra level. From my side, I'm not a big fan of using "@",
as it can be problematic with some GUIs (like git??b), as this
can be used as "@someone".

Perhaps we could use "/" or some other separator when upstreaming it.
> 
> >
> > And it has support for wildcards.
> >
> > There, "TEST" is associated to the contents of the file, while "SUBTEST"
> > refers to each specific subtest inside it. The valid fields are imported
> > from JSON config files, and can be placed into an hierarchical way, in
> > order to produce an hierarchical documentation. Fields defined at the
> > "TEST" level are imported on "SUBTEST", but can be overriden.  
> 
> If we assume that for KUnit, TEST == suite and SUBTEST == test, we hit
> the small issue that there can be multiple test suites per file.
> Ideally, we'd support a more arbitrary hierarchy here.

The tool actually allows multiple TEST tags at the same file. On
IGT, the convention was to use just one per file to make things
simpler.

For KUnit, we should probably name the tags as "SUITE" and "TEST".

> >
> > The JSON config file looks like this:
> >         https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/158feaa20fa2b9424ee544efd2e0e0892562f8f0/tests/xe/xe_test_config.json  
> 
> We're looking into having support for some level of test metadata in
> both KTAPv2[1] and KUnit[2], which might be an interesting point of
> comparison. (Things like inheritence work similarly.)

Interesting. IMO, IGT's past experiences of having test metadata placed
at the code was not great, as people often forgets about it when
writing, modifying or reviewing the code.

For IGT, the code has some logic to validate that everything is
documented. This is specific to IGT, but we could come up with
something similar for KUnit.

> The advantages of having some of these fields being stored as a part
> of the test itself include having more self-descriptive results (being
> more readable without the source code / docs open) and the ability to
> filter test runs based on these fields.

Yes. The tool already has some logic to filter tests based at the
fields and/or to order them based on one field.

> I'd be really interested in working out what sorts of
> fields/attributes would be useful, too. I'm sure there'd be a lot of
> "general" ones, which it'd be nice to keep consistent across different
> subsystems. Though per-subsystem attributes are also really
> interesting: it'd be great if we could easily have tooling filter
> tests by "needs this GPU" or similar.

Heh, we do have a field on IGT for such purpose :-)

On our TODO list is to have a way to check for consistency. It shouldn't
be hard to add, but maintaining a list of acceptable values is a different
history.

> >
> > The output is in ReST, which can be generated in hierarchical or per-file
> > way. The hierarchical output looks like this:
> >
> >         $ ./scripts/igt_doc.py --config tests/xe/xe_test_config.json --file fubar_tests.c
> >
> >         ===============================
> >         Implemented Tests for Xe Driver
> >         ===============================
> >
> >         Category: Software build block
> >         ==============================
> >
> >         Sub-category: documentation
> >         ---------------------------
> >
> >         Functionality: bar test doc
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> >
> >         ``igt@fubar_tests@bar``
> >
> >         :Description: do bar things description continuing on another line
> >         :Issue: none
> >
> >         Functionality: test documentation
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> >
> >         ``igt@fubar_tests@foo``
> >
> >         :Description: do foo things description continuing on another line
> >         :Issue: none
> >
> > (if --file is not used, it will use all C files specified at the
> > configuration)
> >
> > The tool already skips tags like the ones used by kernel-doc[1], so one
> > could have both function documentation and per-test documentation on
> > the same file, if needed.
> >
> > While such tool was conceived to be part of IGT, it doesn't have anything
> > specific for it [2], and I do believe it would be a great contribution to
> > the Kernel to have such tool upstreamed, and integrated as a Sphinx
> > extension.
> >
> > If we decide to go ahead adding it, I can work on a patchset to apply
> > it to the Kernel, modifying the scripts to better fit at the Kernel
> > needs and start with some documentation examples for i915,
> > DRM core and upcoming Xe KUnit tests.
> >
> > Comments?  
> 
> I like the idea overall, but do feel it'd be nice to integrate enough
> with the various test systems to avoid any rough edges where things
> like test layout crash, or we end up with too much duplication of
> features.

Agreed.

> That being said, I'd rather have a bit of redundancy and a few
> mismatches if it keeps this simple and more easily used with arbitrary
> test systems.

Yeah, I'd like to keep the tool generic enough to be used with different
test tools. Perhaps we could have a "basic" class with common features,
and then move things that are specific to integration with test suites 
(so, inherited classes for IGT, Kernel, Kernel CI, ...).

Regards,
Mauro
