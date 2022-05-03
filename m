Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38807517D99
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 08:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiECGyH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 02:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiECGxn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 02:53:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628337031
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 23:50:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso766423wma.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 May 2022 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAb5iy0AwDrArAj21nJaNKQ/VTNcfReEnHCBV20biOU=;
        b=Gqz8TpnJSDUvMME+Q79dUBIaTzigsS2/syq/aVXx8M1gEN+5yB46ELFmE+W3yFhj5v
         71fYnTZyYuTqd1mCW/X6CoLywXIzT1tIAlwUfjD0InVB6uU11LYL2vuPU6tEPX+UnPRS
         edcaSHfEBA90vEjhP023tenz8ZOIUXn4oqqrTbzh1T1BCm3bH2KUHBC+giVSW0GWw7ff
         SFFZu/chd5OUnvMTjcb6RiZE1Uj/zCs9CbWw+XLA1iE9oHyaLApVwtKRI8Fc6xTOveo+
         rtLf8/js6/i7hhbGqaPrRE0TP5T/GHdo0UIfmcaP+AQ0ZdQvR+TkPwaXERnQJ4WSeZUv
         bX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAb5iy0AwDrArAj21nJaNKQ/VTNcfReEnHCBV20biOU=;
        b=UyFyvEA7THnld9zkNhdMhKIH6+lOs/TRurY43Xba3rE40SaLoIZZFqREoX5OWS5lay
         VPiKGoXR1Bza2WljE3oVpf5GZojPcBV7sm3nMuMXAYmtjhwSkuWthRsKygZU3fZooMS9
         o5y+m7T2TJSsJShXugOx7g/In40Sssw+GXjdsLpGz+fqWh7AG2yaFtF7igKbr/HfHLrr
         rT5ukuYB/XfDgWR5kMRz1/571y431oEaHRfVn5VdK9EqYRfOXVziU6DWpjKnBeJHbqay
         E+6qeu7Pnen/ejdtIPMDNo8EKVDrblqpIlETsMfrV8NTBblKVD6+qS5SFI4YVn1PGDFl
         1j3Q==
X-Gm-Message-State: AOAM533wGNebAA1XBr93V1g9/48ZHTo/xJBGZFCf9WOYqPHJx2PD2BP5
        HtzPwYCFNxKSoLeXQ8QhUCniyrLboCp8ixeprJSFpQ==
X-Google-Smtp-Source: ABdhPJxyhTrysklZawwiuijJbJ/nadJCUIYBK6lGOFsSdyjD6ixTWAlG8EEVXpp8C2uMVfwdN9Dk8PfWDRixhHaC1dQ=
X-Received: by 2002:a05:600c:600d:b0:394:5353:507a with SMTP id
 az13-20020a05600c600d00b003945353507amr26471wmb.96.1651560609078; Mon, 02 May
 2022 23:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220430030019.803481-1-davidgow@google.com>
 <Ym7P7mCoMiQq99EM@bombadil.infradead.org> <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
In-Reply-To: <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 3 May 2022 14:49:58 +0800
Message-ID: <CABVgOSmXyN3SrDkUt4y_TaKPvEGVJgbuE3ycrVDa-Kt1NFGH7g@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 2, 2022 at 2:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Sun, May 01, 2022 at 11:22:38AM -0700, Luis Chamberlain wrote:
> > On Sat, Apr 30, 2022 at 11:00:19AM +0800, David Gow wrote:
> > > KUnit tests are not supposed to run on production systems: they may do
> > > deliberately illegal things to trigger errors, and have security
> > > implications (assertions will often deliberately leak kernel addresses).
> > >
> > > Add a new taint type, TAINT_KUNIT to signal that a KUnit test has been
> > > run. This will be printed as 'N' (for kuNit, as K, U and T were already
> > > taken).
> > >
> > > This should discourage people from running KUnit tests on production
> > > systems, and to make it easier to tell if tests have been run
> > > accidentally (by loading the wrong configuration, etc.)
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> >
> > There is no reason to distinguish kunit from selftests if the result is
> > the same: really make the kernel try really insane stupid things which
> > may crash it or put it into a bad state.
> >
My initial thought is that KUnit is explicitly in-kernel testing,
whereas kselftest is (at least somewhat) user-space based. My personal
feeling is that "doing weird stuff from userspace" is fundamentally
different from "doing weird stuff in the kernel". That being said, in
practice many kselftest tests load modules which do strange things,
and those could be in scope for something like that. I'd still err on
the side of only having those tests (or specifically those modules)
add the taint, rather than all selftests, but could be conveniced.

The other thing of note is that KUnit tests do often leak pointer
addresses, which again is something that's a worry in the kernel, and
harmless in userspace.

> > So no, this should be renamed to "TEST_BREAK" as I think outside of
> > selftest and kunit we may grow the kernel to do stupid things outside
> > of that domain and this gives us the flexilibilty to use that in other
> > places as well.
> >
> > It begs the question if we *should* allow userspace to volunterally say
> > "hey, we are doing really insane things, brace yourself." Why ? Well
> > because selftest has tons of modules. We either then define a macro
> > that adds the taint for them and wrap the module declaration for it,
> > or we expose a syctl to let userspace volunteer to opt-in to seggest
> > we are about to try something stupid with the kernel including loading
> > some dangeerous modules which may not have macros which taint the kernel.
> > That would let selftest taint on *any* selftest. Because we can run all
> > selftests or run one selftest.
> >
> > Then, if such sysctl is exposed, maybe we should then also use this for
> > example for blktests, fstests, fio tests, etc.

Is this what TAINT_USER is for?

I think (though haven't actually tried) writing to
/proc/sys/kernel/tainted will add whatever taint flags are needed from
userspace.

That being said, I'm not _against_ making this more general, or
standardising on the existing TAINT_USER, or similar. Personally,
though, I quite like having KUnit separate (but I am, admittedly,
biased :-) ).

Cheers,
-- David
