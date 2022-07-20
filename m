Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB657BF34
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGTU3R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 16:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTU3Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 16:29:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C34A48C9F;
        Wed, 20 Jul 2022 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zxE+g7/OLayRp/SvLyFE7/rwft45pMJGSNXI0aaEGpY=; b=Cl4oaZLAMdmHTCIavvFTdMS3Cx
        qyez5eI2p/aqfA5uUUy2CDWJ8qez4zCgeXDrdudnjUxXddFEcOMrdnE0OtT0nnWTyHb2kK2YxZgsZ
        54grIl1vMnA86UmtYaryYImnU6RlDa868ri4ylyAK2o0zXAiCzSTdfDFQrhbzv6qSmiN8ZXL4NBlQ
        9CRuY6U2F/1MsJJKHs1urc4scWxrEfy6rtv4t3r/HlqFzK4Fh6C4/3f83GMKa6XBTZykoNG5x6tac
        bHj8gXtGm32kBXLdpgfMXmlz6++7gE9Zyq1+04f2egOSP54fnRh1pOLfoN97M4sWvKvh+J/SFgPg2
        AjTz6Thw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEGJh-00AmDZ-Cg; Wed, 20 Jul 2022 20:29:09 +0000
Date:   Wed, 20 Jul 2022 13:29:09 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when
 CONFIG_KUNIT=m
Message-ID: <YthllWFPAjq5YHpL@bombadil.infradead.org>
References: <20220713005221.1926290-1-davidgow@google.com>
 <CAGS_qxrNKnrWXhOfptz9iL5c_sixhKjpAfR2RLQi1XqL6m2Tpg@mail.gmail.com>
 <Ytbw1T6uspICqj5B@bombadil.infradead.org>
 <CABVgOSkpT2kqVec2F7BsTF5tyABO43bseETC2Dz238zN+sTfQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkpT2kqVec2F7BsTF5tyABO43bseETC2Dz238zN+sTfQw@mail.gmail.com>
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

On Wed, Jul 20, 2022 at 05:26:02PM +0800, David Gow wrote:
> On Wed, Jul 20, 2022 at 1:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Jul 13, 2022 at 08:24:32AM -0700, Daniel Latypov wrote:
> > > On Tue, Jul 12, 2022 at 5:52 PM David Gow <davidgow@google.com> wrote:
> > > >
> > > > The new KUnit module handling has KUnit test suites listed in a
> > > > .kunit_test_suites section of each module. This should be loaded when
> > > > the module is, but at the moment this only happens if KUnit is built-in.
> > > >
> > > > Also load this when KUnit is enabled as a module: it'll not be usable
> > > > unless KUnit is loaded, but such modules are likely to depend on KUnit
> > > > anyway, so it's unlikely to ever be loaded needlessly.
> > >
> > > This seems reasonable to me.
> > >
> > > Question: what happens in this case?
> > > 1. insmod <test-module>
> > > 2. insmod kunit
> > > 3. rmmod <test-module>
> > >
> > > I think on 3, we'll call the cleanup code, __kunit_test_suites_exit(),
> > > for <test-module>, I think?
> > > But we never called __kunit_test_suites_init().
> > > My fear is what breaks as a result of this precondition break.
> 
> I don't think this should be possible: any module with KUnit tests
> will depend on the 'kunit' module (or, at least, kunit symbols), so
> shouldn't load without kunit already present.
> 
> If modprobe is used, kunit will automatically be loaded. If insmod is
> used directly, loading the first module should error out with
> something like:
> [   82.393629] list_test: loading test module taints kernel.
> [   82.409607] list_test: Unknown symbol kunit_binary_ptr_assert_format (err -2)
> [   82.409657] list_test: Unknown symbol kunit_do_failed_assertion (err -2)
> [   82.409799] list_test: Unknown symbol kunit_binary_assert_format (err -2)
> [   82.409820] list_test: Unknown symbol kunit_unary_assert_format (err -2)
> insmod: ERROR: could not insert module
> /lib/modules/5.19.0-rc1-15284-g9ec67db0c271/kernel/lib/list-test.ko:
> Unknown symbol in module

This can be fixed with a request_module() call. And since this is a
generic requirement, you can have the wrappers do it for you.

> Maybe you could get into some trouble by force-removing modules at
> various points, but you're in undefined behaviour generally at that
> point, so I don't think there's much point going out-of-our-way to try
> to support that.

You can prevent that by refcounting the kunit module / symbols, by each test.

  Luis
