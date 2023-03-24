Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49326C877E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 22:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjCXVar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCXVap (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 17:30:45 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F2C1A480
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 14:30:44 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x3-20020a62fb03000000b00622df3f5d0cso1567636pfm.10
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679693443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qqk3VIkkZ+eaNmKFC4g7qKHFQk1Ktr5Ri5CUqa6GS3c=;
        b=gMpJrqX5gNp9x920VhyvpRim8i6UjML4yBPIpJp24QgT0d/OeZow853g+1kfIgvoae
         U9lCbSo55IdjffXIqOt7I/Oqmjny3fp5cQg5k+JuW1pz+QrrSyBaH5Nw4FuIfr2o9ws2
         k1507WSZNJXUyEFW8KjpUvmgG65OukFruUk3vEaSUtvOddVixNBluj3al8mbV5LDN+2M
         Kdx5jYiXYGVYRGNHl2Tz8zdM4q0bJsdAj8Or6cglaOH0HmGtAF80HtKZeKkcBHVUqWX+
         PD2L02yoAjQMavN0syyIfdg7zczvDQTLcRn50T3xQ3a7AyJkMPvdmmZkoelJSKt7kyoP
         PfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqk3VIkkZ+eaNmKFC4g7qKHFQk1Ktr5Ri5CUqa6GS3c=;
        b=RdDZsvLhAkSIp7oxJacs7Ae1QHBl/xJ3a3/sASfJ5icQU+Z/sLe2zl+Erz5JsCoLUD
         jc8+9w07A/RfONBJXC3mmsa3tl4IivhGbuqaS1A6914gwzJ7D2SbjlYtx6PxXwhaJqOH
         4KZOrNRAuuDxhxjmHGzVqJVPB7HqPwmWmyIsFf1F2P4yO4ogP5mKBC/DMhyM2ZiqNHcg
         aXOmmSgewmgYF70zoOIrb2sSSlmHoWRzaBLiny1IXR8NtjDJ9VoAdiBJ4MTKTet935bv
         wj6LJrPqHjgj57OKbra/IAXXJCRmBUyTAcz40hBMgKHNnvNrkaAmY+uAbyZ+OnWpxHD+
         CJVw==
X-Gm-Message-State: AAQBX9dLJogTzOBuj1WlVjSHNByRgwbhcKSn1wB6XWSGocabFo+MVBoJ
        /EZonidlvsnp+mswNCKlaqR0KszCE3k=
X-Google-Smtp-Source: AKy350blyyifafkda063U/S/0uYv8jmG3MBHoNiQ+CQtG/xbECNu7KE46no7R2/W/LjITOLoUNNvUfq24Yk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e74b:b0:1a1:b440:3767 with SMTP id
 p11-20020a170902e74b00b001a1b4403767mr1583993plf.3.1679693443732; Fri, 24 Mar
 2023 14:30:43 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:30:42 -0700
In-Reply-To: <ZB4PqcsZlE8cOo0C@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com> <167969137429.2756469.2347841728687804486.b4-ty@google.com>
 <ZB4PqcsZlE8cOo0C@google.com>
Message-ID: <ZB4WglXwnOe7HFb1@google.com>
Subject: Re: [PATCH v3 00/13] Overhauling amx_test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mingwei Zhang <mizhang@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
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

On Fri, Mar 24, 2023, Sean Christopherson wrote:
> On Fri, Mar 24, 2023, Sean Christopherson wrote:
> > On Tue, 21 Feb 2023 16:36:42 +0000, Mingwei Zhang wrote:
> > > In this version, I have integrated Aaron's changes to the amx_test. In
> > > addition, we also integrated one fix patch for a kernel warning due to
> > > xsave address issue.
> > > 
> > > Patch 1:
> > > Fix a host FPU kernel warning due to missing XTILEDATA in xinit.
> > > 
> > > [...]
> > 
> > Applied everything except patch 7 to kvm-x86 selftests.  Please holler if I
> > missed something subtle about patch 7 (using & vs. ==).  This is at the head
> > of kvm-x86/selftests, i.e. I can fix it up if necessary.
> > 
> > [01/13] x86/fpu/xstate: Avoid getting xstate address of init_fpstate if fpstate contains the component
> >         (no commit info)
> 
> *sigh*  And by "everything" I meant "all of the selftests patches".

Continuing my circus of goofs, I already force pushed selftests due to an unrelated
mixup.  New hashes below (the comment above still stands in case another overwrite
is necessary).

       [1/11] KVM: selftests: Add a fully functional "struct xstate" for x86
             https://github.com/kvm-x86/linux/commit/5de4a3765b7e
       [2/11] KVM: selftests: Fix an error in comment of amx_test
             https://github.com/kvm-x86/linux/commit/bec357a4af55
       [3/11] KVM: selftests: Enable checking on xcomp_bv in amx_test
             https://github.com/kvm-x86/linux/commit/48ad4222c43c
       [4/11] KVM: selftests: Add check of CR0.TS in the #NM handler in amx_test
             https://github.com/kvm-x86/linux/commit/0aeb9729486a
       [5/11] KVM: selftests: Assert that XTILE_DATA is set in IA32_XFD on #NM
             https://github.com/kvm-x86/linux/commit/9cbd9aaa670f
       [6/11] KVM: selftests: Verify XTILE_DATA in XSTATE isn't affected by IA32_XFD
             https://github.com/kvm-x86/linux/commit/bfc5afc37c9d
       [7/11] KVM: selftests: Assert that XTILE is XSAVE-enabled
             https://github.com/kvm-x86/linux/commit/7e1075f05078
       [8/11] KVM: selftests: Assert that both XTILE{CFG,DATA} are XSAVE-enabled
             https://github.com/kvm-x86/linux/commit/2ab3991b0b9b
       [9/11] KVM: selftests: Move XSAVE and OSXSAVE CPUID checks into AMX's init_regs()
             https://github.com/kvm-x86/linux/commit/d01d4a4f7bd2
       [10/11] KVM: selftests: Check that the palette table exists before using it
             https://github.com/kvm-x86/linux/commit/d32fb0714293
       [11/11] KVM: selftests: Check that XTILEDATA supports XFD
             https://github.com/kvm-x86/linux/commit/d563164eaeb1
