Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924EC67118E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 04:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjARDLh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 22:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjARDLg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 22:11:36 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71164FC0B
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 19:11:34 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id z9so6318757qtv.5
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 19:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O/O6TD2UxbHDujiY75DmgUHIPiPd0aX829avGoEwLLE=;
        b=WqLneCjmhoTwRgGiLm+Ml7BnvpEfV6yRe8J6XaBaq6pWJyj70uS10AGwEOJYrMkRDX
         hTl89dIowzLO/LiwhInh6/g7gYzYWMXtSxMTMMKqKNp+ck4Jd2q5QFXZq0tp6lYCoqkn
         lHmMMrOJc9Q9l9YkQFgwT1JfHwjeApUk05ME5gWbvPkxol0PwNjul8cMCuUhjno3xAz8
         pOyJjFf5W5tjyYMW+Su9eN8z//WRLf3MvTAWmB0rf7LI7LOJO8h6YA+mgCy33oL2xPsF
         Ted19SuOrljFn161n7k37VqVyZ6YmZUsupAKLUg1zuNE6kN667wpoAbANdJuCQ3Sb5Qp
         8MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/O6TD2UxbHDujiY75DmgUHIPiPd0aX829avGoEwLLE=;
        b=EmpJR4PW4GL9vnwj3oEAiWwOrOVtdw/p6g7OALiKIquL0uWav//V/JwYy0k1T/Anms
         mpeUUvmpQi/dj5s9C+0hcDn3EymCEIlq1ciq6l5pGipjskux6lFf4x0ht8ESJjrPIMJ6
         hULGzbv1YLG9p4i9BP9irXXqlJkBMdJcDvA+bEieOLuo9IvCjMGAOI1FGuz96Smz1lcS
         o+PReCAr5F2dfApD582q3i4I+Hf8kfbqHn18XJ3N8FCn4Ysh7pKCKWsYzkweXCFQE9s2
         QtPFrhDjwj5qxHzhIXgPLlmhkfE1yZIu38xpJoTd8T9Uu1Le9vgKik8M4sMsw9XlR7wf
         ZtHQ==
X-Gm-Message-State: AFqh2koklBYaehZgGLTy+a8LuIUC1M5Z93ttDY7WCs6Rac4EWcP9lfwk
        rG8BThCw2/GoW4fUxgy/nvysbD2gefyr37CncrgGag==
X-Google-Smtp-Source: AMrXdXsNuQYklUXOFJf3Rc0J/2dCMJ2WqQvDmdpaawKr/fUxyI25Cx//ZShQv4veGsp/RtXzV/66alDe+xzAYDxpsnE=
X-Received: by 2002:a05:622a:2308:b0:3ab:754e:f0b3 with SMTP id
 ck8-20020a05622a230800b003ab754ef0b3mr248629qtb.583.1674011493792; Tue, 17
 Jan 2023 19:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com> <Y8dG3WDxY2OCGPby@google.com>
In-Reply-To: <Y8dG3WDxY2OCGPby@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 17 Jan 2023 19:11:22 -0800
Message-ID: <CAGtprH_hsLPDzFREbSehsxQRj7piVC75xPXD7OsKLUULWiS1fw@mail.gmail.com>
Subject: Re: [V2 PATCH 0/6] KVM: selftests: selftests for fd-based private memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 17, 2023 at 5:09 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> > This series implements selftests targeting the feature floated by Chao via:
> > https://lore.kernel.org/lkml/20221202061347.1070246-10-chao.p.peng@linux.intel.com/T/
> >
> > Below changes aim to test the fd based approach for guest private memory
> > in context of normal (non-confidential) VMs executing on non-confidential
> > platforms.
> >
> > private_mem_test.c file adds selftest to access private memory from the
> > guest via private/shared accesses and checking if the contents can be
> > leaked to/accessed by vmm via shared memory view before/after conversions.
> >
> > Updates in V2:
> > 1) Simplified vcpu run loop implementation API
> > 2) Removed VM creation logic from private mem library
>
> I pushed a rework version of this series to:
>
>   git@github.com:sean-jc/linux.git x86/upm_base_support
>

Thanks for the review and spending time to rework this series. The
revised version [1] looks cleaner and lighter.

> Can you take a look and make sure that I didn't completely botch anything, and
> preserved the spirit of what you are testing?
>

Yeah, the reworked selftest structure [1] looks good to me in general.
Few test cases that are missing in the reworked version:
* Checking if contents of GPA ranges corresponding to private memory
are not leaked to host userspace when accessing guest memory using HVA
ranges
* Checking if private to shared conversion of memory affects nearby
private pages.

> Going forward, no need to send a v3 at this time.  Whoever sends v11 of the series
> will be responsible for including tests.
>

Sounds good to me.

> No need to respond to comments either, unless of course there's something you
> object to, want to clarify, etc., in which case definitely pipe up.
>
> Beyond the SEV series, do you have additional UPM testcases written?  If so, can
> you post them, even if they're in a less-than-perfect state?  If they're in a
> "too embarassing to post" state, feel from to send them off list :-)
>

Ackerley (ackerleytng@google.com) is working on publishing the rfc v3
version of TDX selftests that include UPM specific selftests. He plans
to publish them this week.

> Last question, do you have a list of testcases that you consider "required" for
> UPM?  My off-the-cuff list of selftests I want to have before merging UPM is pretty
> short at this point:
>
>   - Negative testing of the memslot changes, e.g. bad alignment, bad fd,
>     illegal memslot updates, etc.
>   - Negative testing of restrictedmem, e.g. various combinations of overlapping
>     bindings of a single restrictedmem instance.
>   - Access vs. conversion stress, e.g. accessing a region in the guest while it's
>     concurrently converted by the host, maybe with fancy guest code to try and
>     detect TLB or ordering bugs?

List of testcases that I was tracking (covered by the current
selftests) as required:
1) Ensure private memory contents are not accessible to host userspace
using the HVA
2) Ensure shared memory contents are visible/accessible from both host
userspace and the guest
3) Ensure 1 and 2 holds across explicit memory conversions
4) Exercise memory conversions with mixed shared/private memory pages
in a huge page to catch issues like [2]
5) Ensure that explicit memory conversions don't affect nearby GPA ranges

Test Cases that will be covered by TDX/SNP selftests (in addition to
above scenarios):
6) Ensure 1 and 2 holds across implicit memory conversions
7) Ensure that implicit memory conversions don't affect nearby GPA ranges

Additional testcases possible:
8) Running conversion tests for non-overlapping GPA ranges of
same/different memslots from multiple vcpus

[1] - https://github.com/sean-jc/linux/commit/7e536bf3c45c623425bc84e8a96634efc3a619ed
[2] - https://lore.kernel.org/linux-mm/CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com/
