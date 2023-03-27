Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6906CAC08
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjC0Rn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 13:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjC0Rn6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 13:43:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E811110EA
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 10:43:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5416d3a321eso95151397b3.12
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679939037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XlpSa++Ck7W+hH+1OiuQ4wL4Keih2CLgElX+Jr8IDOg=;
        b=NRewYmivbp7xrd5bl7JWEYaQ9BEiQxehXzYs4JPD27Ag/vs1+EGoigQA/eGrdDVwpI
         6HrxgSZwown5PltC2Waeqpp6KGdrJb/dSApcJ1OUEukUIu3e0Ezq/NVjnhkAzin2oeIi
         XSws12m/6pB4Il8LiHkXWqb8AJMCdtVH2B+cO5e4Nti183f4YVeFl+atpkWvaCwSlrLh
         LmtRmg6bJTE0Nq9XTncpVNfM5/aW7PEvzyPI3l+G5UFhZ8iI/LdGA8oPEpZSPXw4sf/Y
         oWbVtkgHQtAjTuo6pRD+inMv48nJ8KN5jmFbZAnYg8/yiZPVZ9a4faH4l6132Clgz6B7
         ZpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679939037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlpSa++Ck7W+hH+1OiuQ4wL4Keih2CLgElX+Jr8IDOg=;
        b=5BZ0RaZSmHyA+dOFmfsbiipdO6YBHXTyI/Vp3+rAyKLm/XR9QqquZbVi3GMHIGXeBn
         ybITrdyr1rjL6aDuEvbIVEq4MFx1VAmqyQNv+Gvjb6UvshU1tZre6GRDptwcdbAO7QtK
         FONgRwkcoq6p+QCgS2e2kakbiZkyOTyble+dpf14rzCxuDWTkWH9+9qRp869O5DOYaLP
         Uhjc0Ok7nyG0bpRwE8RL4R32TmZFvMbMl1PBECbLQUFmJv/Gbp8mZ6ekuRvkCw7yOrub
         JwEWBBIREOoIKh/xuxr5156ZNnVLKHNfl6AMtmIZBljbY2rc47S417SgpQ2GpIKOjBMO
         cUiQ==
X-Gm-Message-State: AAQBX9dawM+Up76SzF5fwjj6kNe5h6hyS3ALrM3ZjtDY1HRVPi1znVD2
        dtFqXbxTECw6QFqMi5Ge/Y+vDLcWA2k=
X-Google-Smtp-Source: AKy350YnFdRnDAztI/QAWGplLtVR70FJRJ184l6fxPJaxU9DXrlOhocThQPENwgRN3HxnQV8PG1Jwq59fUM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1141:b0:b73:caa7:f06f with SMTP id
 p1-20020a056902114100b00b73caa7f06fmr7834435ybu.5.1679939037193; Mon, 27 Mar
 2023 10:43:57 -0700 (PDT)
Date:   Mon, 27 Mar 2023 10:43:55 -0700
In-Reply-To: <CRGX867PJCBF.1MV46YLYXMBYZ@bobo>
Mime-Version: 1.0
References: <20230316031732.3591455-1-npiggin@gmail.com> <87ilf0nc95.fsf@mpe.ellerman.id.au>
 <ZBs9tGkI5OQqtIqs@google.com> <CRGX867PJCBF.1MV46YLYXMBYZ@bobo>
Message-ID: <ZCHV20oFkFzp/AZs@google.com>
Subject: Re: [PATCH 0/2] KVM: PPC: support kvm selftests
From:   Sean Christopherson <seanjc@google.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
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

On Mon, Mar 27, 2023, Nicholas Piggin wrote:
> On Thu Mar 23, 2023 at 3:41 AM AEST, Sean Christopherson wrote:
> > On Thu, Mar 16, 2023, Michael Ellerman wrote:
> > > Nicholas Piggin <npiggin@gmail.com> writes:
> > > > Hi,
> > > >
> > > > This series adds initial KVM selftests support for powerpc
> > > > (64-bit, BookS).
> > > 
> > > Awesome.
> > >  
> > > > It spans 3 maintainers but it does not really
> > > > affect arch/powerpc, and it is well contained in selftests
> > > > code, just touches some makefiles and a tiny bit headers so
> > > > conflicts should be unlikely and trivial.
> > > >
> > > > I guess Paolo is the best point to merge these, if no comments
> > > > or objections?
> > > 
> > > Yeah. If it helps:
> > > 
> > > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> >
> > What is the long term plan for KVM PPC maintenance?  I was under the impression
> > that KVM PPC was trending toward "bug fixes only", but the addition of selftests
> > support suggests otherwise.
> 
> We plan to continue maintaining it. New support and features has been a
> bit low in the past couple of years, hopefully that will pick up a bit
> though.

Partly out of curiosity, but also to get a general feel for what types of changes
we might see, what are the main use cases for KVM PPC these days?  E.g. is it mainly
a vehicle for developing and testing, hosting VMs in the cloud, something else?

> > I ask primarily because routing KVM PPC patches through the PPC tree is going to
> > be problematic if KVM PPC sees signficiant development.  The current situation is
> > ok because the volume of patches is low and KVM PPC isn't trying to drive anything
> > substantial into common KVM code, but if that changes... 
> 
> Michael has done KVM topic branches to pull from a few times when such
> conflicts came up (at smaller scale). If we end up with larger changes
> or regular conflicts we might start up a kvm-ppc tree again I guess.

A wait-and-see approach works for me.  I don't have any complaints with the current
process, I was just caught off guard.

> > My other concern is that for selftests specifically, us KVM folks are taking on
> > more maintenance burden by supporting PPC.  AFAIK, none of the people that focus
> > on KVM selftests in any meaningful capacity have access to PPC hardware, let alone
> > know enough about the architecture to make intelligent code changes.
> >
> > Don't get me wrong, I'm very much in favor of more testing, I just don't want KVM
> > to get left holding the bag.
> 
> Understood. I'll be happy to maintain powerpc part of kvm selftests and
> do any fixes that are needed for core code changes.If support fell away
> you could leave it broken (or rm -rf it if you prefer) -- I wouldn't ask
> anybody to work on archs they don't know or aren't paid to.
> 
> Not sure if anything more can be done to help your process or ease your
> mind. It (KVM and kvm-selftests) can run in QEMU at least.

Updating the KVM/powerpc to include selftests would be very helpful, e.g

  F:	tools/testing/selftests/kvm/*/powerpc/
  F:	tools/testing/selftests/kvm/powerpc/

and ideally there would be one or more M: (and R:) entries as well.  I'm not
all that concerned about the selftests support being abandoned, but the lack of
specific contacts makes it look like KVM PPC is in maintenance-only mode, and it
sounds like that's not the case.

Thanks!
