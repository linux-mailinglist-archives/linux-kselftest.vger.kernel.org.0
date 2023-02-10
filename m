Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D252D692788
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 20:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjBJT7q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 14:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjBJT7o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 14:59:44 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D597D3FE
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 11:59:35 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 135so2610895qkh.13
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 11:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+cXK0yN4PVvPYRxqzxPGR9rSHlqnym3PwTLPn4N4Qo=;
        b=FPtXkgzKXuyODmOIzMBgoJqoSB8HG7+xWroxNgcZK10MT1vuDHcFilGYRNjVjmJF+G
         6N3vQ3CJftv2PU+evl/ND/GQc6nQLwQ2cdlQlktnWlbcs6eaov9sjP81nyO8tC+9bOnY
         yz35ewz2YDN7ViNCSigM4DMTNQsXO1TSxxwNL1RVGTpJxtczAvz8fS8vwMhwXNhzmUrq
         z1Txu3KbeTtHQ7P1tsNLTuFKKqyykkgCQYAWwNFohn4Rf0an2kJpH8tDE7zoraq+LFmo
         4H/7zwoXsXKtBSJMBSd22omEbjlLgaxkDjRv6YO97dhDjz+1PfnQR0v7xdPboMgv7kT7
         l4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+cXK0yN4PVvPYRxqzxPGR9rSHlqnym3PwTLPn4N4Qo=;
        b=v9wSkEcVX+u2ZWtH8rGWk2NTmWKUIyBnu1Xq4soBDARTxEfSiGBHQpn8K1B+S26PHg
         M4RdBzdgnCtOjcy4OuGXH0pEnmx3LFTpc0SZRpBn+HokHGLQlzbmcsRCNV7oP26hJ/q4
         RHz0ZlymefZRg6A3KfihVe+hNMT7i3KUf7wTGvezXGRecbfPlzhzOZQp1Xo3o5NYWQpz
         z9GE98hLH/3MV5SuBhVZVgNvgdepQvCcHHljJNw/8pgqdYFv9nsididhKTO1eFglAwKH
         +1n25qqGZoIvQ5uY0/pjLWm1Fod/simVlRoUuix17g6t/3ajcWJGWZBgvau+OUdEs/uC
         QhlA==
X-Gm-Message-State: AO0yUKXtyKMpmhT9uVhDAlrXHc9QOvUjqsuE5TLsrbcOEsK2q+5tuDFi
        aNpZKtBSZqYzALFRGhV01g7P22c7YSVaNtQdcoA1jw==
X-Google-Smtp-Source: AK7set+lUXzv8lrHvcVBMrFCyzd7pF/BI691QOOFHgkZ8TV89SfokjQ+AyFxR7q2uzAIlzMSCQ2N1kGlVuG4qC6M3c4=
X-Received: by 2002:a37:2f85:0:b0:71b:ae71:8eed with SMTP id
 v127-20020a372f85000000b0071bae718eedmr1348116qkh.204.1676059174528; Fri, 10
 Feb 2023 11:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
 <Y8dG3WDxY2OCGPby@google.com> <CAGtprH_hsLPDzFREbSehsxQRj7piVC75xPXD7OsKLUULWiS1fw@mail.gmail.com>
In-Reply-To: <CAGtprH_hsLPDzFREbSehsxQRj7piVC75xPXD7OsKLUULWiS1fw@mail.gmail.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Fri, 10 Feb 2023 11:59:23 -0800
Message-ID: <CAGtprH9jAkCgsNHHK7um7drsLWsUTej+djLrdzv9rzcd5VdNTg@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 7:11 PM Vishal Annapurve <vannapurve@google.com> wrote:
>
> ...

> > Last question, do you have a list of testcases that you consider "required" for
> > UPM?  My off-the-cuff list of selftests I want to have before merging UPM is pretty
> > short at this point:
> >
> >   - Negative testing of the memslot changes, e.g. bad alignment, bad fd,
> >     illegal memslot updates, etc.
> >   - Negative testing of restrictedmem, e.g. various combinations of overlapping
> >     bindings of a single restrictedmem instance.
> >   - Access vs. conversion stress, e.g. accessing a region in the guest while it's
> >     concurrently converted by the host, maybe with fancy guest code to try and
> >     detect TLB or ordering bugs?
>
> List of testcases that I was tracking (covered by the current
> selftests) as required:
> 1) Ensure private memory contents are not accessible to host userspace
> using the HVA
> 2) Ensure shared memory contents are visible/accessible from both host
> userspace and the guest
> 3) Ensure 1 and 2 holds across explicit memory conversions
> 4) Exercise memory conversions with mixed shared/private memory pages
> in a huge page to catch issues like [2]
> 5) Ensure that explicit memory conversions don't affect nearby GPA ranges
>
> Test Cases that will be covered by TDX/SNP selftests (in addition to
> above scenarios):
> 6) Ensure 1 and 2 holds across implicit memory conversions
> 7) Ensure that implicit memory conversions don't affect nearby GPA ranges
>
> Additional testcases possible:
> 8) Running conversion tests for non-overlapping GPA ranges of
> same/different memslots from multiple vcpus
>
> [1] - https://github.com/sean-jc/linux/commit/7e536bf3c45c623425bc84e8a96634efc3a619ed
> [2] - https://lore.kernel.org/linux-mm/CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com/

List of additional testcases that could help increase basic coverage
(including what sean mentioned earlier):
1) restrictedmem functionality testing
    - read/write/mmap should not work
    - fstat/fallocate should work as expected
2) restrictedmem registration/modification testing with:
    - bad alignment, bad fd, modifying properties of existing memslot
    - Installing multiple memslots with ranges within the same
restricted mem files
    - deleting memslots with restricted memfd while guests are being executed
3) Runtime restricted mem testing:
    - Access vs conversion testing from multiple vcpus
    - conversion and access to non-overlapping ranges from multiple vcpus

Regards,
Vishal
