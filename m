Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A965744C84
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 09:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjGBHXS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBHXR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 03:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C1D10E7;
        Sun,  2 Jul 2023 00:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93EE560A71;
        Sun,  2 Jul 2023 07:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8F5C433C7;
        Sun,  2 Jul 2023 07:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688282595;
        bh=U9ipIdPx01QtKgrcjm3ZPFh42uxgLxY6TX/dpLch/LE=;
        h=Date:From:To:Cc:Subject:From;
        b=QXzM9IPF/TCEZZ5Nv2RmGIQP0mdcrGv1Qeo/HjK4yKj49meTCZhg6/9UzwOH4puRn
         2qhtNUE/VwmeQqywop3OSNBwLAmTJwIrwr3Z7OvoJ5jf60wqSCFdiODgHuPZnN51ms
         MAdj6QUse+jNfPPU3lIpgYo7I+p03iJDvG+TgfiNAsTkKB8/N4vD0i3I3VFA94hvMN
         jQy91rasWbcvQfsuxslom+oOXA9pNbbya2rrZlvdNwzT9BGogsIsyiszukzJ2k5sNa
         olr0k5bFrAq/B5TeO1INSKz0NgmS9dz1iqSTRF/1trjnCOJamHilRWGQuqGZaol9WI
         LSZdT+LWOUvgQ==
Date:   Sun, 2 Jul 2023 09:23:08 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Nikolai Kondrashov <spbnick@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        mauro.chehab@intel.com, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Subject: Tests documentation
Message-ID: <20230702092308.4a022336@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jon, Shuah & others,

I'd like to discuss with you with regards to test documentation.

I had some preliminary discussions with people interested on improving 
tests during EOSS last week in Prague, as we're working to improve media
test coverage as well. During such discussions, I talked with developers
from several companies that have been collaboration and/or using Kernel
CI. I also talked with Nikolai from Red Hat, who gave a presentation about
Kernel CI, which points that one of the areas to be improved there is
documentation.

So, it seems it is worth having some discussions about how to improve 
Kernel test documentation.

While kernel_doc does a pretty decent job documenting functions and data
structures, for tests, the most important things to be documented are:

	a. what the tests do;
	b. what functionalities they are testing.

This is a lot more important than documenting functions - and the used
data structures on tests are typically the ones that are part of the
driver's kAPI or uAPI, so they should be documented somewhere else.

Usually, (b) is not so simple, as, at least for complex hardware,
the tested features are grouped on an hierarchical way, like:

	1. hardware
	1.1 DMA engine
	1.2 output ports
	...
	2. firmware
	2.1 firmware load
	2.2 firmware DMA actions
	...
	3. kernel features
	3.1 memory allocation
	3.2 mmap
	3.3 bind/unbind
	...

CI engines running the test sets usually want to produce a report that will
be providing pass rates for the tested features and functionalites that
are available at the driver's and their respective hardware and firmware.

I've doing some work at the tool we use to test DRM code [1] in order to 
have a decent documentation of the tests we have hosted there, focusing 
mostly on tests for i915 and Xe Intel drivers, also covering documentation
for DRM core tests - while providing support for other vendors to also
improve their test documentation for IGT - IGT GPU tools and tests.

The documentation tool I developed is generic enough to be used for other
test sets and I believe it could be useful as well to document Kselftest 
and KUnit.

The core of the tool (at test_list.py) is a Python class, with some callers
(igt_doc.py, xls_to_doc.py, doc_to_xls.py), being extensible enough to
also have other callers to integrate with external tools. We are 
developing internally one to integrate with our internal Grafana reports
to report the pass rate per documented feature, in an hierarchical way.

Something similar to:

	1. hardware        pass rate:  98% (98 tests passed of 100)
	1.1 DMA engine     pass rate:  80% (8  tests passed of  10)
	1.2 output ports   pass rate: 100% (10 tests passed of  10)
	...

It is based on the concept that test documentation should be placed as
close as possible to the actual code implementing the test sets. It was
also be developed in a way that the documentation grouping is flexible.
The code was written from the scratch in Python and was implemented 
inside a class that can also be re-used to do do other nice things,
like importing/exporting test documentation to spreadsheets and
integration with other tools (like Grafana).

The actual documentation tags look like this:

        /**
         * TEST: Check if new IGT test documentation logic functionality is working
         * Category: Software build block
         * Sub-category: documentation
         * Functionality: test documentation
         * Issue: none
         * Description: Complete description of this test
         *
         * SUBTEST: foo
         * Description: do foo things
         * 	description continuing on another line
         *
         * SUBTEST: bar
         * Description: do bar things
         * 	description continuing on another line
         * Functionality: bar test doc
         */

And it has support for wildcards.

There, "TEST" is associated to the contents of the file, while "SUBTEST"
refers to each specific subtest inside it. The valid fields are imported
from JSON config files, and can be placed into an hierarchical way, in
order to produce an hierarchical documentation. Fields defined at the
"TEST" level are imported on "SUBTEST", but can be overriden. 

The JSON config file looks like this:
	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/158feaa20fa2b9424ee544efd2e0e0892562f8f0/tests/xe/xe_test_config.json

The output is in ReST, which can be generated in hierarchical or per-file
way. The hierarchical output looks like this:

	$ ./scripts/igt_doc.py --config tests/xe/xe_test_config.json --file fubar_tests.c

	===============================
	Implemented Tests for Xe Driver
	===============================
	
	Category: Software build block
	==============================
	
	Sub-category: documentation
	---------------------------
	
	Functionality: bar test doc
	^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	
	``igt@fubar_tests@bar``
	
	:Description: do bar things description continuing on another line
	:Issue: none
	
	Functionality: test documentation
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	
	``igt@fubar_tests@foo``
	
	:Description: do foo things description continuing on another line
	:Issue: none

(if --file is not used, it will use all C files specified at the
configuration)

The tool already skips tags like the ones used by kernel-doc[1], so one
could have both function documentation and per-test documentation on
the same file, if needed.

While such tool was conceived to be part of IGT, it doesn't have anything
specific for it [2], and I do believe it would be a great contribution to
the Kernel to have such tool upstreamed, and integrated as a Sphinx
extension.

If we decide to go ahead adding it, I can work on a patchset to apply
it to the Kernel, modifying the scripts to better fit at the Kernel
needs and start with some documentation examples for i915,
DRM core and upcoming Xe KUnit tests.

Comments?

Regards,
Mauro

[1] It should be trivial to patch kernel-doc for it to skip TEST and 
    SUBTEST tags if we decide to integrate it to the kernel.

[2] except that tests there are named after IGT, as
    <igt <test>@<subtest>@<dynamic_subtest>, but a change to a 
    Kernel-specific namespace would be trivial
