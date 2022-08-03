Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C6589340
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 22:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiHCUbw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 16:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiHCUbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 16:31:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3481F59265
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Aug 2022 13:31:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a7so20485711ejp.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Aug 2022 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n8pKImfx8Za6eHn+m1TtvWVUUWC/l25+Sr2AOODiNHU=;
        b=S31AfcWvWmUKKe89ihAv8h9HB4X+QuSLQ50vKDCY7bJY0i4bFO98tMAnEmfu1BNYP7
         HD41b/1p9GTXLpsG5g7oypfQ5V41+OnhOO6bQeLQwFz6CQ6l3DcDIPK+BWYiH6vKDsxw
         pm9/F+Cln/OOqur/QEVVQ8ksN2jPXycWsM2FamD2e4i/uaQMvu1ObPykgp5+il8v3ZUn
         GTOFDsaX+ejctGxg3328WnxSKRDzj4NHkNFYcISP14GdXSBzaEmlfU6cXMCKCV4aQS5x
         /ImLT40tAOGcKH8kwDjTCvcSRJIHYByQfBV1y0oenW06d/+gzZ0xI6xPRE0VpQARD2/8
         JY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n8pKImfx8Za6eHn+m1TtvWVUUWC/l25+Sr2AOODiNHU=;
        b=7aeCvKT7JLSvAji27q0c2jKou7dscrSR7aRISdH9XHK5D3oMrshJKBgX9YYWIDjN1h
         B8u1A+HofU5vIUaawRDX2rhk4p5vD5LpiyN3jbZnbN6RgryRRQxl687kRXPamzNbqAP5
         ojVqvmhM0HTaJ3gxqBwNDe5hZRH08WSb3U4KSaIikwPAj69WZvjMn8CCkCAUnIKysTRe
         ORB+cbZIj1UGahJR7Ylr8HDwpe9wtJfjwGPlZDBtfRU9+D79QPUvR4MxaFkczrV+ubvc
         H15pWhlQ4hS6DFhiHnxP3Kdohdyjep8FVwDnNrbKAtd/nWRYxO0S91TGI8GF+AJsTGBE
         Kmrg==
X-Gm-Message-State: ACgBeo3BZfIPhfaNft4oey0OlgJatpN4JfIdqT12N/lvWYtQJX7r2L+F
        fKn4HbY7y5QTcsxDlsdLiAKpxEcT0z85tVBlUtOp9g==
X-Google-Smtp-Source: AA6agR6xltbU2DJGqBal3KX71f6EjA835Dlm+EK4mwQrI6M78ca2wmVSAssvbra/rDYa4OqgVKCEfF88QL3JIh6NQ+w=
X-Received: by 2002:a17:907:9726:b0:730:9e04:f738 with SMTP id
 jg38-20020a170907972600b007309e04f738mr8421050ejc.631.1659558708460; Wed, 03
 Aug 2022 13:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220713005221.1926290-1-davidgow@google.com> <CAGS_qxrNKnrWXhOfptz9iL5c_sixhKjpAfR2RLQi1XqL6m2Tpg@mail.gmail.com>
 <Ytbw1T6uspICqj5B@bombadil.infradead.org> <CABVgOSkpT2kqVec2F7BsTF5tyABO43bseETC2Dz238zN+sTfQw@mail.gmail.com>
 <YthllWFPAjq5YHpL@bombadil.infradead.org> <CABVgOSnYQyRg8+nysnRAqn9-jEG+UzEdU7gSUOOEzU-aqYLSMQ@mail.gmail.com>
In-Reply-To: <CABVgOSnYQyRg8+nysnRAqn9-jEG+UzEdU7gSUOOEzU-aqYLSMQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 3 Aug 2022 16:31:36 -0400
Message-ID: <CAFd5g46wqLTEqF=yRV6H=jR4d+n-qHy42coUFjH+ETMowoTAyQ@mail.gmail.com>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 28, 2022 at 4:42 AM David Gow <davidgow@google.com> wrote:
>
> On Thu, Jul 21, 2022 at 4:29 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Jul 20, 2022 at 05:26:02PM +0800, David Gow wrote:
> > > On Wed, Jul 20, 2022 at 1:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >
> > > > On Wed, Jul 13, 2022 at 08:24:32AM -0700, Daniel Latypov wrote:
> > > > > On Tue, Jul 12, 2022 at 5:52 PM David Gow <davidgow@google.com> wrote:
> > > > > >
> > > > > > The new KUnit module handling has KUnit test suites listed in a
> > > > > > .kunit_test_suites section of each module. This should be loaded when
> > > > > > the module is, but at the moment this only happens if KUnit is built-in.
> > > > > >
> > > > > > Also load this when KUnit is enabled as a module: it'll not be usable
> > > > > > unless KUnit is loaded, but such modules are likely to depend on KUnit
> > > > > > anyway, so it's unlikely to ever be loaded needlessly.
> > > > >
> > > > > This seems reasonable to me.
> > > > >
> > > > > Question: what happens in this case?
> > > > > 1. insmod <test-module>
> > > > > 2. insmod kunit
> > > > > 3. rmmod <test-module>
> > > > >
> > > > > I think on 3, we'll call the cleanup code, __kunit_test_suites_exit(),
> > > > > for <test-module>, I think?
> > > > > But we never called __kunit_test_suites_init().
> > > > > My fear is what breaks as a result of this precondition break.
> > >
> > > I don't think this should be possible: any module with KUnit tests
> > > will depend on the 'kunit' module (or, at least, kunit symbols), so
> > > shouldn't load without kunit already present.
> > >
> > > If modprobe is used, kunit will automatically be loaded. If insmod is
> > > used directly, loading the first module should error out with
> > > something like:
> > > [   82.393629] list_test: loading test module taints kernel.
> > > [   82.409607] list_test: Unknown symbol kunit_binary_ptr_assert_format (err -2)
> > > [   82.409657] list_test: Unknown symbol kunit_do_failed_assertion (err -2)
> > > [   82.409799] list_test: Unknown symbol kunit_binary_assert_format (err -2)
> > > [   82.409820] list_test: Unknown symbol kunit_unary_assert_format (err -2)
> > > insmod: ERROR: could not insert module
> > > /lib/modules/5.19.0-rc1-15284-g9ec67db0c271/kernel/lib/list-test.ko:
> > > Unknown symbol in module
> >
> > This can be fixed with a request_module() call. And since this is a
> > generic requirement, you can have the wrappers do it for you.
> >
>
> I'm not convinced that this is worth the trouble, particularly since
> KUnit needs to be loaded already before any test-specific code in a
> module is run. _Maybe_ we could put it in the code which looks for the
> .kunit_test_suites section, but even then it seems like a bit of an
> ugly hack.
>
> Personally, I'm not particularly concerned about test modules failing
> to load if KUnit isn't already present -- if people want all of a
> module's dependencies loaded, that's what modprobe is for.
>
> That being said, if you feel particularly strongly about it, this is
> something we can look at. Let's do so in a separate patch though: this
> one does fix a regression as-is.

I agree. We need a fix for 3d6e44623841 to go in for 5.20 - we've
gotten several complaints about it. This patch seems to accomplish
that.

I am not an expert on the module stuff by any means, so I am
absolutely open to continuing this discussion in a follow-up patch,
but I think we need this fix now.

If no one objects, I am going to ask Shuah to take this patch.

> > > Maybe you could get into some trouble by force-removing modules at
> > > various points, but you're in undefined behaviour generally at that
> > > point, so I don't think there's much point going out-of-our-way to try
> > > to support that.
> >
> > You can prevent that by refcounting the kunit module / symbols, by each test.
> >
>
> Again, I don't think KUnit is any more special than any other module
> here. I don't think we need to do this ourselves, as it shouldn't be
> possible to remove kunit without first removing any dependent modules.
>
> Of course, happy to look into this again if anyone can come up with an
> actual crash, but I'd rather get this fix in first. At the very least,
> this patch shouldn't introduce any _new_ issues.

Sounds good. I will send my Reviewed-by in a separate email, as per usual.

Cheers
