Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7D69B73E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Feb 2023 01:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBRA5o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 19:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBRA5o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 19:57:44 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D53B5F27C
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 16:57:42 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 71so1574088pfy.4
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 16:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0usceKggNKCGc1nrj8ml4jt1oiNoxfaCBZe8A/bFNJE=;
        b=a3YUzlbPFk6TdZwQ3LJJCtJ9Cg3GMFX2Wu/wOR/8mPXmDZuUH+tPej/7kvCa9/2l+y
         BEemwWr1jsgvcoxsBcDVl3+p2z0KY3giNpGmvJcVlU3h9IJczoEv1Ijv+r5RAbasuNCI
         mUzeD149j9+TCqEfjDzU52A69nKfwtJ8Paj9uJW20ghePk+29UdghGXmKkSiOg7g+tIF
         iO6yxTCT56fADdP2gBorhs9TvtLPy0B/eqzjW6L4xRbcAEXLjWOGnenqcKaPqvu0z5FJ
         uj/DQdIdU8fwSR/mnq3v2kZSl/nZjMUgPZf4nJ0qlVKMjXNTsUVNaxfDpiR9n2wY+8iA
         Ei3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0usceKggNKCGc1nrj8ml4jt1oiNoxfaCBZe8A/bFNJE=;
        b=q0Wme5fDo2F51SkzovBwSsuO6ZE5crCJmRtegkO85H1kDTGkNzujE42JM8TWcmuB9P
         HTDEGnnzr/Ku80DOMwngtqwRlCuq2awfsYtjS7rLgZ4ZS9Esp91FEnHDxkswoMOZS+xc
         LwvErO/3WWjKYPLR7oJQzcz6H5yk2dWnz0vf5QXtx7UdXKmFs9/zUeOMvc9M9Z0tWs+8
         b8hizTIaScx2ZZVbE9UJIh7Ln8JB9h7ygN5QCZ/RXUOlb9uNjnMvb5OC4pZwbYvUCJq0
         eo4mwkG2ep0GiHFMPFOpI0XPPnFJ6kdTbuPvufFxzlnQb4u98KErvTB21EiHpyf77QUi
         2VqQ==
X-Gm-Message-State: AO0yUKU2hNOmUyZYj78WPvKkiJIvIrTDCe6fsbFFw5V7KdLPlQNmIXfx
        UR0D16GbnGnSuDj9nCsG34TuVA==
X-Google-Smtp-Source: AK7set/LXZrK5+seQgidJp1G/DYMPwiRrF7zemmtKS2OaKJrTRzgkApTRwKGRRfLGDWD9/z3fxrNFQ==
X-Received: by 2002:a05:6a00:4305:b0:5a8:51a3:7f69 with SMTP id cb5-20020a056a00430500b005a851a37f69mr6923585pfb.2.1676681861601;
        Fri, 17 Feb 2023 16:57:41 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78757000000b005a8beb26794sm3602449pfo.132.2023.02.17.16.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 16:57:41 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:57:37 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Aaron Lewis <aaronlewis@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 3/7] KVM: selftests: x86: Add check of CR0.TS in the
 #NM handler in amx_test
Message-ID: <Y/Aigdf8rV0b9LJQ@google.com>
References: <20230214184606.510551-1-mizhang@google.com>
 <20230214184606.510551-4-mizhang@google.com>
 <CAAAPnDFG+9x5A24cDs8344k9W6zddpJ7cKBFOXmzaLhMhvmR=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAAPnDFG+9x5A24cDs8344k9W6zddpJ7cKBFOXmzaLhMhvmR=g@mail.gmail.com>
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

On Fri, Feb 17, 2023, Aaron Lewis wrote:
> On Tue, Feb 14, 2023 at 6:46 PM Mingwei Zhang <mizhang@google.com> wrote:
> >
> > Add check of CR0.TS[bit 3] before the check of IA32_XFD_ERR in the #NM
> > handler in amx_test. This is because XFD may not be the only reason of
> > the IA32_XFD MSR and the bitmap corresponding to the state components
> > required by the faulting instruction." (Intel SDM vol 1. Section 13.14)
> >
> > Add the missing check of CR0.TS.
> >
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  tools/testing/selftests/kvm/x86_64/amx_test.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> > index aac727ff7cf8..847752998660 100644
> > --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> > @@ -215,6 +215,7 @@ void guest_nm_handler(struct ex_regs *regs)
> >  {
> >         /* Check if #NM is triggered by XFEATURE_MASK_XTILEDATA */
> >         GUEST_SYNC(7);
> > +       GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
> 
> Can't we infer that the #NM is the result of an XFD error due to the fact
> that IA32_XFD_ERR is set?  Is this check needed?
> SDM vol 1, 13.14, EXTENDED FEATURE DISABLE (XFD)
>  - Device-not-available exceptions that are not due to XFD - those
>    resulting from setting CR0.TS to 1 - do not modify the IA32_XFD_ERR
>    MSR.
> 
We don't infer from the reasons of #NM and that is the purpose of this
selftest. Yes, this looks a little bit pedantic. But still, it is worth
adding the check since violation of that indicates either 1) the
selftest mistakenly did not clear XFD_ERR prior to #NM or 2) hardware is
broken.

> >         GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
> >         GUEST_SYNC(8);
> >         GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
> > --
> > 2.39.1.581.gbfd45094c4-goog
> >
