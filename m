Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB352670C3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 23:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjAQW6I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 17:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjAQW5f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 17:57:35 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF334392D
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:39:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so29999667plo.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hK7iCT/l53H8F02D5jWSmMF8OJg0mxY4hx/WOh8zXHQ=;
        b=WeQcFSECVbAwjsxpoYAUDsDmT3LUgopGEqpjAQgQI1CIGKL0Aw2fjnbTlwHci2civl
         f0Siy/nZinODvzTENbBnDhXli4GylTAUxiBI/VyHa82CtAxQ7gbT8igBoTEd5n4SA6vd
         2VmR04LOt/8/0NYujHvKX8syEaz8kQJwSMYFMDQ4BPmRuvr2ZR8L8XlXcspW1n3KQlUu
         tRz/LGOuU4EBu4uvrr8LdIIMT/ZsgrMo7ES4mwROwnXgemFdIR485MboWclY3XLZIjkF
         MLFlKgyXOPpEStKfnPzGyUG5OnUhbxreOj1rEaGhEez7JwmuyyrERsC/ULIjoYV8fPbr
         gPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK7iCT/l53H8F02D5jWSmMF8OJg0mxY4hx/WOh8zXHQ=;
        b=M23LyTE4t/IztIbUOiVSjht7xZngEAkfuFbt5SZ3DWXRSnY/kr24fUbzGvroaHW17Q
         3r11fR0XZvh0iAbpbvPP/c6kUz5GDqKhIQyVYzo9MZOm/jxxpJqdbm4I3KInOI2ulZPE
         pA3lXSe7BPotkUbeb8kjIolpdNfn3Sqyz71ZmytTMUF48UXcp+nLhw2wvONSutqApHsq
         EGpvWxgLSHTr3GDJZi5EZuYwc9hshXmWy3kOdPaAhYeVe+77TCDzz0ZSESz0lJsGSL2F
         FA9Pixddf5Xoa/9ogsyLC/rRujKSUJnxjTQTjChnrzRYrp1IXDipwwK8XPj1iUKZV3vP
         tYEg==
X-Gm-Message-State: AFqh2koe2UFRKwtR2EjE5pPuPX8/rzx1kiqurOMsh6S4JnBbM++lIC8b
        7SMtxFgNROOyCd/KbLhBdH6xRQ==
X-Google-Smtp-Source: AMrXdXtz4++aL4Ab6dxo4T1C7BIxWZ7VFFwnA/Q6q1uy8e+3S2IXuSo+S89TSMhkxkMLQu5/dcJ+3g==
X-Received: by 2002:a17:902:e808:b0:189:b910:c6d2 with SMTP id u8-20020a170902e80800b00189b910c6d2mr2989344plg.1.1673991560262;
        Tue, 17 Jan 2023 13:39:20 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b0019338ecad52sm16912238plh.190.2023.01.17.13.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:39:19 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:39:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
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
Subject: Re: [V2 PATCH 1/6] KVM: x86: Add support for testing private memory
Message-ID: <Y8cVhFIM1EoLHO/V@google.com>
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-2-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205232341.4131240-2-vannapurve@google.com>
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

On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> Introduce HAVE_KVM_PRIVATE_MEM_TESTING config to be able to test fd based
> @@ -272,13 +274,15 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  		.rsvd = err & PFERR_RSVD_MASK,
>  		.user = err & PFERR_USER_MASK,
>  		.prefetch = prefetch,
> -		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
> +		.is_tdp = is_tdp,
>  		.nx_huge_page_workaround_enabled =
>  			is_nx_huge_page_enabled(vcpu->kvm),
>  
>  		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
>  		.req_level = PG_LEVEL_4K,
>  		.goal_level = PG_LEVEL_4K,
> +		.is_private = IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING) && is_tdp &&
> +				kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),

After looking at the SNP+UPM series, I think we should forego a dedicated Kconfig
for testing and instead add a new VM type for UPM-capable guests.  The new type,
e.g. KVM_X86_PROTECTED_VM, can then be used to leverage UPM for "legacy" SEV and
SEV-ES guests, as well as for UPM-capable guests that don't utilize per-VM
memory encryption, e.g. KVM selftests.

Carrying test-only behavior is obviously never ideal, and it would pretty much have
to be mutually exclusive with "real" usage of UPM, otherwise the KVM logics gets
unnecessarily complex.
