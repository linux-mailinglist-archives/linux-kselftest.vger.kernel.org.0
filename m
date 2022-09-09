Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE695B2F6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 09:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiIIHBk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIIHBd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 03:01:33 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA0A9C3A;
        Fri,  9 Sep 2022 00:01:29 -0700 (PDT)
Date:   Fri, 9 Sep 2022 09:01:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662706887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RWCELvBZAP7UK2m8DqFciqCKvSVVz5+g8uq2bLhQwA8=;
        b=SwQYFx2gTSYfpujoytL1i5+wwGrG5ThpC5gpq83EFjxVv08IzH3LHBjo9RP/GlHkgGOw+H
        HeeegsKUNc+JjU+Sv1kpinOYC8BKj8TSA5OHWn9vO1uwvGowpyeVAvU1Zev38vM91Nynir
        A5iEQktvI19mNnzP4EwHBlASsW56ZUI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     David Matlack <dmatlack@google.com>
Cc:     Vishal Annapurve <vannapurve@google.com>, x86 <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>, oupton@google.com,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        drjones@redhat.com
Subject: Re: [V1 PATCH 2/5] selftests: kvm: Introduce kvm_arch_main and
 helpers
Message-ID: <20220909070125.dtqfa6neq46fvns2@kamzik>
References: <20220903012849.938069-1-vannapurve@google.com>
 <20220903012849.938069-3-vannapurve@google.com>
 <20220905074609.ga4tnpuxpcgppx4r@kamzik>
 <CAGtprH9Kaemwupgoo_kgM-Ci2cnN2kpXa+ZwEymSnYNFhS9Fsg@mail.gmail.com>
 <Yxpc8NDdtdOl9wpH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxpc8NDdtdOl9wpH@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 08, 2022 at 02:21:52PM -0700, David Matlack wrote:
> On Tue, Sep 06, 2022 at 03:46:20PM -0700, Vishal Annapurve wrote:
> > On Mon, Sep 5, 2022 at 12:46 AM Andrew Jones <andrew.jones@linux.dev> wrote:
> > >
> > > On Sat, Sep 03, 2022 at 01:28:46AM +0000, Vishal Annapurve wrote:
> > > > Introduce following APIs:
> > > > 1) kvm_arch_main : to be called at the startup of each test.
> > >
> > > With this, AArch64 can move the content of its constructor,
> > > init_guest_modes(), into kvm_arch_main(). Or, instead of the
> > >
> > >  main()
> > >  {
> > >     /* common main stuff */
> > >     kvm_arch_main();
> > >     __main();
> > >  }
> > >
> > > approach we could have each arch provide a constructor
> > >
> > >  arch_init()
> > >  {
> > >     common_pre_main_stuff();
> > >     /* arch specific pre-main stuff */
> > >  }
> > >
> > > I personally prefer the latter.
> > >
> > 
> > I agree with your suggestion of using constructors here. This will
> > help avoid changes in all the selftests.
> > Maybe I can add a common constructor that can invoke arch specific
> > init. I will add this change in the next series.
> 
> In case anyone else is confused like me: "constructor" refers to
> __attribute__ ((constructor)), which causes the function to run before
> main().
> 
> I have a slight preference for having as few constructors as possible,
> since they are somewhat subtle. So how about one constructor for all
> selftests, e.g.:
> 
> void __attribute__ ((constructor)) kvm_selftest_init(void)
> {
>         /* Tell stdout not to buffer its content. */
>         setbuf(stdout, NULL);
> 
>         kvm_selftest_arch_init();
> }
> 
> Per-arch:
> 
> void kvm_selftest_arch_init(void)
> {
>         /* arch-specific pre-main stuff */
> }

WFM and I think that's what Vishal was suggesting as well.

Thanks,
drew
