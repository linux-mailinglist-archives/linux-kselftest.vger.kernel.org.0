Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC27C6C52B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 18:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCVRlN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCVRlL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 13:41:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F85D76B
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Mar 2023 10:41:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id p36-20020a056a000a2400b005f72df7d97bso9412643pfh.19
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Mar 2023 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679506870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YesdF1o+GzhDJuZ/Udj8ca6OlrwlbgmV+ssn/MViB3Y=;
        b=ES3MTTWVJF3Lh9miyIydYMrcdquqjUJ6i1dtVLAn9HvdFiW7C/QyBtdCE/0BVmIKgH
         w6st+X+tszk3NDXWw53/EQYGIAVOUgS2EmGWTB2b21oAw8mMThn8Lq3NbR4D8xa9Ex5W
         DAW36YpqcBa6iPM2REL2rxdGH1wW4ICNysGSfxLlirqGVqyK69b1abef6wBYCUOOhquI
         hp7L58cwWLIe0NtUUUi6//q4MXht6OYjPUJHcNQrLkD/sIS78oEaMtQKT8nt+1L+JN28
         Znfy7kT/t8aI0yxigNLVwKwPzLjAqs9GAlPmEuwczJQIXlHVKQWf9UldkRLaNke8wKIn
         i06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YesdF1o+GzhDJuZ/Udj8ca6OlrwlbgmV+ssn/MViB3Y=;
        b=x4IuHeH+qD0t9rAuoWDL21ZBhrZ9MH6M4d7uhvMw34NBBK8mc4AFm8bJT/VISYIs3A
         7f4oLKt904jxICODTpy0LHIXpL+dAQBHfBEu9horTyzxGY4j4H7ki0BJKmFjWW475X6S
         X2O7mwGb/jOwestEV/1y2THFzEHZM9SLIjVN6dzt5R/k5DLGDsPX8pzxrgRQlfvA8a+g
         t9W3fk5ffILKOhdg3DPQVa7Uqy5Go3xUTbq9AkY3jPxvRf9E+JuvHh+grQFjk24IPumk
         DGKDCnTSn36C7+2EPMrCWtGvAiveTmHdMM2t7Ml3KB9QF2xwv+ko4Rp6XeENiT4iAInE
         /8uA==
X-Gm-Message-State: AO0yUKVejIOdAugTZi7p671p260NVmh2o4dxd5zZBHl0/8Ahbky4POPc
        q8BNntVd0YuOdx7FI9t3f9MFcPhE4Ow=
X-Google-Smtp-Source: AK7set8qlHUyhwjwk3c90JV8Tq1N4wnyQ//6TF16RskTAhQJfsd+IUr4994tmY3YTrka7GXpTeNq0/ISbns=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6399:0:b0:50f:53aa:f662 with SMTP id
 h25-20020a656399000000b0050f53aaf662mr991438pgv.5.1679506869873; Wed, 22 Mar
 2023 10:41:09 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:41:08 -0700
In-Reply-To: <87ilf0nc95.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
References: <20230316031732.3591455-1-npiggin@gmail.com> <87ilf0nc95.fsf@mpe.ellerman.id.au>
Message-ID: <ZBs9tGkI5OQqtIqs@google.com>
Subject: Re: [PATCH 0/2] KVM: PPC: support kvm selftests
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 16, 2023, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> > Hi,
> >
> > This series adds initial KVM selftests support for powerpc
> > (64-bit, BookS).
> 
> Awesome.
>  
> > It spans 3 maintainers but it does not really
> > affect arch/powerpc, and it is well contained in selftests
> > code, just touches some makefiles and a tiny bit headers so
> > conflicts should be unlikely and trivial.
> >
> > I guess Paolo is the best point to merge these, if no comments
> > or objections?
> 
> Yeah. If it helps:
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

What is the long term plan for KVM PPC maintenance?  I was under the impression
that KVM PPC was trending toward "bug fixes only", but the addition of selftests
support suggests otherwise.

I ask primarily because routing KVM PPC patches through the PPC tree is going to
be problematic if KVM PPC sees signficiant development.  The current situation is
ok because the volume of patches is low and KVM PPC isn't trying to drive anything
substantial into common KVM code, but if that changes... 

My other concern is that for selftests specifically, us KVM folks are taking on
more maintenance burden by supporting PPC.  AFAIK, none of the people that focus
on KVM selftests in any meaningful capacity have access to PPC hardware, let alone
know enough about the architecture to make intelligent code changes.

Don't get me wrong, I'm very much in favor of more testing, I just don't want KVM
to get left holding the bag.
