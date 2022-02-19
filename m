Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAC44BC933
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Feb 2022 16:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbiBSPoX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Feb 2022 10:44:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiBSPoW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Feb 2022 10:44:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DB6606DA;
        Sat, 19 Feb 2022 07:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=51IuRnSgtWxZG2Jmu2renXJr42JUA6j1ZiqJaCkpimM=;
        t=1645285443; x=1646495043; b=qyks8bf/gJgo+UE96AF+v7tTvMKni7RZUpphuTWTqN8Rk2R
        Am7kqD49/sN5h4KDNJPrSZGV8f0GcT75I8xJNB7dcGxCbOdkerMrLVcOLIVrkE0K6bv3YpBEdoOFL
        1T81+KgUQBYxxc8wcQ1X1VE+Li9W+osj7t0tXNzeK1JoBCdyEaAgR0y5IEE4UUtiZHm8kPNYbacIc
        A7g4sVndtVppm8t6AXmAx3tRoGo/iJOTJ7lkr+kSWTa8E0INoalHKlQDPTbykbSf8rx5SDnxlLtl/
        8xSYGedMKPgdMqq9W6I/HuRtVdvmcEjn+9lNqGKpUR7wIQuW5bhAPk9ifVlFgosw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nLRtJ-0035Fb-Ex;
        Sat, 19 Feb 2022 16:43:21 +0100
Message-ID: <d14b6a0c72788e78bab2bd1f0bc2c49891ded5d7.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] kunit: tool: Disable broken options for --alltests
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-rdma@vger.kernel.org,
        x86@kernel.org, felix.kuehling@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Feb 2022 16:43:19 +0100
In-Reply-To: <CABVgOSnBq0QE+Cq+SDeV-LxOQYbGZ6Bqbjix6h-UpNj0GMicPA@mail.gmail.com>
References: <20220218075727.2737623-1-davidgow@google.com>
         <20220218075727.2737623-5-davidgow@google.com>
         <ac4c5f8c890e5bdd7ad7ecc04a51e72fa3ac1703.camel@sipsolutions.net>
         <CABVgOSnBq0QE+Cq+SDeV-LxOQYbGZ6Bqbjix6h-UpNj0GMicPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 2022-02-19 at 16:00 +0800, David Gow wrote:
> On Fri, Feb 18, 2022 at 8:26 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > 
> > On Fri, 2022-02-18 at 15:57 +0800, David Gow wrote:
> > > 
> > > Note that, while this does build again, it still segfaults on startup,
> > > so more work remains to be done.
> > 
> > That's probably just a lot more stuff getting included somehow?
> > 
> 
> Yeah: it used to work (a couple of years ago), but something has
> broken it in the meantime. It's just a shame that bisecting things
> with allyesconfig takes so long...

Heh, right.

But I guess you could "Kconfig bisect" first, i.e. see what option
breaks it? It might not even help to bisect, if it's just some option
getting enabled over time. Or perhaps the kernel is just too big for the
address space layout if you have allyesconfig? Though that shouldn't be
an issue, I think.

> I didn't realise X86 wasn't defined in UML: 

X86 is the architecture, X86_{32,64} is kind of a selection for how you
want things to be built, and it's thus required for UML on x86, because
UML imports stuff from X86.

> that's definitely a bit
> cleaner than !UML in a number of these cases.

It looks like some (most?) of them don't really work that way though
since they're not really platform specific, they just know only about a
handful of platforms that they're compatible with.

> Not all of those issues are fundamentally solved by "depends on X86",
> though: there are a few which might be other missing things in UML
> (maybe the 'dma_ops' issues?), and/or might be the result of -Werror
> being enabled.

Right.

> We do want the ability to build PCI drivers under UML, as it makes
> running KUnit tests for PCI drivers much simpler and more pleasant.

OK, fair point. I'm thinking about this area in general also right now
for iwlwifi, and obviously we're probably the only user of the virtual
PCI code that lets us connect the driver to a simulated device on UML
(but the driver doesn't really know) :-)

> And indeed, it does work for KUnit in general, it's just that some
> drivers do have the issues mentioned above, so allyesconfig picks up
> every broken driver.

Right.

> We don't actually build the PCI drivers by default, only if the
> "--alltests" option is passed, which does include them, as we do have
> tests which depend on PCI we'd like to run (like the thunderbolt
> test).

Makes sense.
> 
> I did try this as well, and it just got us a different set of issues
> (there are a bunch of drivers which depend on IOMEM but don't state it
> -- I'll try to send fixes for those out next week). 
> 

Fun.

> Ultimately, the 'broken_on_uml.config' file is just there to pare back
> allyesconfig a bit for KUnit's purposes, but we still definitely want
> as many options (and hence tests) enabled as possible long-term. So I
> think actual fixes to either the code or Kconfig do make sense.

Makes sense.

> Is 'make ARCH=um allyesconfig' something we actually want to be able
> to build? If so, no amount of adding things to KUnit's
> broken_on_uml.config will solve the underlying issues, and we'll need
> to at least update the Kconfig entries.
> 

That's a good point, as long as people are doing allyes/randconfig
builds on UML, we probably need to have these fixes anyway rather than
disabling something for KUnit specifically.

johannes
