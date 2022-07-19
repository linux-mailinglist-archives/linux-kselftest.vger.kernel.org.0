Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259FD57A5ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiGSR6v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 13:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbiGSR6u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 13:58:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EE14D163;
        Tue, 19 Jul 2022 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V0qiTrhKb5cDn7xIAf2JVpihXBS1asZkPJ9Pieu4GWQ=; b=TLdQhm87tVe/Km85VW344stqSW
        sGnhygUmoZeMCvY+KgA6lZ97rKTdlG4gdJ0pxREFFi5A+679pJNM3qKHlmlIH58qU2zL5bJyGs76V
        xw8+/fSGkRuqWq/8jpRptkA2FekKdawjW2AjvqNVN6wUhZXsEMatGmKeecDXx9Efww4Jbf+c6CXhh
        TTui8HWbn63uFSFS9R/3QEAaeEAcu3QZaIE7Je5Gsh6lRahE5QrdW2lEYbkK5oBCndywlf0SMMJ9+
        tQNUgEZo+vsiFwQ5SkTogBj5c7u8UaV/rfzaOW8/04ix8bTyftX45GC5s/n60llqQrZogkF99fhpi
        ur5rOExA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDrUb-00B2xA-Ge; Tue, 19 Jul 2022 17:58:45 +0000
Date:   Tue, 19 Jul 2022 10:58:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when
 CONFIG_KUNIT=m
Message-ID: <Ytbw1T6uspICqj5B@bombadil.infradead.org>
References: <20220713005221.1926290-1-davidgow@google.com>
 <CAGS_qxrNKnrWXhOfptz9iL5c_sixhKjpAfR2RLQi1XqL6m2Tpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxrNKnrWXhOfptz9iL5c_sixhKjpAfR2RLQi1XqL6m2Tpg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 13, 2022 at 08:24:32AM -0700, Daniel Latypov wrote:
> On Tue, Jul 12, 2022 at 5:52 PM David Gow <davidgow@google.com> wrote:
> >
> > The new KUnit module handling has KUnit test suites listed in a
> > .kunit_test_suites section of each module. This should be loaded when
> > the module is, but at the moment this only happens if KUnit is built-in.
> >
> > Also load this when KUnit is enabled as a module: it'll not be usable
> > unless KUnit is loaded, but such modules are likely to depend on KUnit
> > anyway, so it's unlikely to ever be loaded needlessly.
> 
> This seems reasonable to me.
> 
> Question: what happens in this case?
> 1. insmod <test-module>
> 2. insmod kunit
> 3. rmmod <test-module>
> 
> I think on 3, we'll call the cleanup code, __kunit_test_suites_exit(),
> for <test-module>, I think?
> But we never called __kunit_test_suites_init().
> My fear is what breaks as a result of this precondition break.
> 
> E.g. In the case that CONFIG_KUNIT_DEBUGFS is enabled, this includes a
> call to kunit_debugfs_destroy_suite() with no previous call to
> kunit_debugfs_create_suite().
> That will include a call to debugfs_remove_recursive(suite->debugfs),
> where suite->debugfs is an uninitialized pointer.
> 
> Maybe we can treat it as "undefined behavior" for now and proceed with
> this patch.
> 
> In terms of long-term fixes, perhaps insmod kunit could trigger it to
> 1. run all built-in tests (IIUC, it doesn't right now)
> 2. run all the tests of currently loaded modules
> 3. track which modules already ran so if you rmmod + insmod kunit
> again, it won't rerun tests?

Let's please address these considerations.

  Luis
