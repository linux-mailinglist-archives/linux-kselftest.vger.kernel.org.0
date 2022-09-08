Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E715B2877
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 23:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIHVWF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 17:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIHVWC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 17:22:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380AC11C141
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Sep 2022 14:21:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 9so15936693plj.11
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Sep 2022 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iRCxAqW31No4R523yMeowHDDm6ZPMY3cVOG5h+SWhss=;
        b=ekRV5++2oqlgPM6t48Xr8iBpXq4/1mPod6LtzGovgAgMeYZ3yGdFCD1C+jzu/CDrmT
         +iy4VkigNiuTT/IAJEQnHvet8I9oYkHFruxWZof7W/MXKkguDIjcOhxUHJC3SUOCjoXy
         Ju/+fzoI0xmojvDXeTmm78Mnsk5Vrkfyi6LLVVT/tE1WeQ7WTKZWBxC2jl8kmx4otO/k
         l+WtBhqvSqxbNsla0R81wZmhQ+fl60W9WaHvkJcXEI6NbELqWwfnd9L/X7hTEdBx4kDh
         HFZHAP00FAK1kYtrJdU3oMqnZouRV7Js3DCRqyDMVZ7c+u/mH4wZ7ycD2IzvClduU32z
         hiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iRCxAqW31No4R523yMeowHDDm6ZPMY3cVOG5h+SWhss=;
        b=AVj5uQTqkGQN8jCwycW4I6SPVOANQZiR/KJ/KRaNPiuDRpC45oUdMSgjPdfSFzKEU9
         dmkmGPh6DUb84+Nd0WB9SJ81hrgwvoBYI/5O//wXuJbQx3/ZTzPMTsQuhLDpgAcPSNWd
         8NV3K/aDE4yx34JlNQxMjYQEXExxqH/C9Z6MhyuNLWkgE3YsVwaVhcMv9cq7mrze/yML
         PTy+yMNcRz2i7GxekZVc1ChrVap5Aj7CdhvgpITMO6u7o2w1ar3d8bFlOIkdLN8QItCQ
         x5XStmHbB1pmISs9lJLjCIP/p/HkNQi+pQDJsCYtIt+G/CFShGTguBPopbNtakVHNkNp
         ZT3A==
X-Gm-Message-State: ACgBeo1tpoGbqarVkFz2IrNG0DOvHv8uVRIkfCAaHzxhcJHjmislCBFI
        nWSSbewWEAIGgATVTHZcWTtn/Q==
X-Google-Smtp-Source: AA6agR48kO9V03khtYOuaO5emQ3zVXXDHHKXaSE9s9WsyqXbAsszqoXX/UCR9xGQJwmGhYbPGMK1aQ==
X-Received: by 2002:a17:90b:1803:b0:1fb:45e2:5d85 with SMTP id lw3-20020a17090b180300b001fb45e25d85mr6225074pjb.163.1662672118552;
        Thu, 08 Sep 2022 14:21:58 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b00177ff4019d9sm671365plg.274.2022.09.08.14.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:21:57 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:21:52 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     Andrew Jones <andrew.jones@linux.dev>, x86 <x86@kernel.org>,
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
Message-ID: <Yxpc8NDdtdOl9wpH@google.com>
References: <20220903012849.938069-1-vannapurve@google.com>
 <20220903012849.938069-3-vannapurve@google.com>
 <20220905074609.ga4tnpuxpcgppx4r@kamzik>
 <CAGtprH9Kaemwupgoo_kgM-Ci2cnN2kpXa+ZwEymSnYNFhS9Fsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH9Kaemwupgoo_kgM-Ci2cnN2kpXa+ZwEymSnYNFhS9Fsg@mail.gmail.com>
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

On Tue, Sep 06, 2022 at 03:46:20PM -0700, Vishal Annapurve wrote:
> On Mon, Sep 5, 2022 at 12:46 AM Andrew Jones <andrew.jones@linux.dev> wrote:
> >
> > On Sat, Sep 03, 2022 at 01:28:46AM +0000, Vishal Annapurve wrote:
> > > Introduce following APIs:
> > > 1) kvm_arch_main : to be called at the startup of each test.
> >
> > With this, AArch64 can move the content of its constructor,
> > init_guest_modes(), into kvm_arch_main(). Or, instead of the
> >
> >  main()
> >  {
> >     /* common main stuff */
> >     kvm_arch_main();
> >     __main();
> >  }
> >
> > approach we could have each arch provide a constructor
> >
> >  arch_init()
> >  {
> >     common_pre_main_stuff();
> >     /* arch specific pre-main stuff */
> >  }
> >
> > I personally prefer the latter.
> >
> 
> I agree with your suggestion of using constructors here. This will
> help avoid changes in all the selftests.
> Maybe I can add a common constructor that can invoke arch specific
> init. I will add this change in the next series.

In case anyone else is confused like me: "constructor" refers to
__attribute__ ((constructor)), which causes the function to run before
main().

I have a slight preference for having as few constructors as possible,
since they are somewhat subtle. So how about one constructor for all
selftests, e.g.:

void __attribute__ ((constructor)) kvm_selftest_init(void)
{
        /* Tell stdout not to buffer its content. */
        setbuf(stdout, NULL);

        kvm_selftest_arch_init();
}

Per-arch:

void kvm_selftest_arch_init(void)
{
        /* arch-specific pre-main stuff */
}
