Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC56724A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 18:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjARRRh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 12:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjARRRS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 12:17:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEE959576
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 09:17:16 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p24so37528950plw.11
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 09:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FL8JJKN1LVzWkPF+aKtJUdwHaz9en8xDzUW2zFOrSY=;
        b=bl5IHfblF7oi96NNkA5U8SF7wUtop9rpLyHBYs/4MD+DADCJ6isUH3ZccvjespkLZD
         gXwGmB8IdvutFO2kyTnloszSczWHCoKGfI0xG1j2Ve7NarDvGd+URgpodYb19MJaH0zX
         RPikpRZqC7VGmj+XI1sO0dpytVz5VH0NFQdvEeeYc2H4LDBAQ8i2KWpNvjQ/zdZ64Aif
         Ta6Gn9SHn1KpN21U6TsCYRCkzVuVZVycpaUyRvdubCEtUP/O+Sejy1reztba8QfEwtde
         Ky7f0b80BDeXQbMn20TkFDFRyyL5nozpU7s/VU/Vzb6+D3GxrVXlO1/pwwFhTV96xl/G
         WGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FL8JJKN1LVzWkPF+aKtJUdwHaz9en8xDzUW2zFOrSY=;
        b=AaiercfBhwHcqF1hhKDm46uKkPckzkAj4VljGefeD+2SAqMRX33mkTu2roAFu5+y1i
         LtusgK1CnRvqqWgXjlFm05cMpEQx7e9BEmgKk9BUocoBAC90xlBImSEN/aTFiNhamHoP
         JKyok0Jfwxg6RcOLOnsKC2RFxRHJKzgiQxTeU9CJn0Kl+iZW20Yem9xkzkK5qFc/z6Uk
         0qwYxT1N/m7NJHj+LlC8NpsPUB9tOM46+SdHwBz2QhQjejdnvI5DFiSCPFQHw9XMamS+
         fPTM2l82NixyYHI2B6OTM5V6gHzs3JLxrDR0YpNRFNqgQ9tv77hFWnoQzRnDyVB4tVWs
         69Lg==
X-Gm-Message-State: AFqh2kqip6kK9wBWQa+lMfdpCxWevbcN0w0cki0/6HlrNBVMDrwpz7A5
        cBOzvPUXoDzeBvctluhPs+LnmA==
X-Google-Smtp-Source: AMrXdXtOORgNGTIyd11R2eMP7ByXXE52rPFRkTZwXhynNFuQSIdozZ7e3gP+UEGWXjWMQ6ldDAX2Ig==
X-Received: by 2002:a17:902:e808:b0:189:b910:c6d2 with SMTP id u8-20020a170902e80800b00189b910c6d2mr3394337plg.1.1674062235976;
        Wed, 18 Jan 2023 09:17:15 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001895f7c8a71sm6609409plg.97.2023.01.18.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:17:15 -0800 (PST)
Date:   Wed, 18 Jan 2023 17:17:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [V2 PATCH 0/6] KVM: selftests: selftests for fd-based private
 memory
Message-ID: <Y8gpl+LwSuSgBFks@google.com>
References: <20221205232341.4131240-1-vannapurve@google.com>
 <Y8dG3WDxY2OCGPby@google.com>
 <20230118112511.wrljyng2xiz3yktv@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118112511.wrljyng2xiz3yktv@box.shutemov.name>
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

On Wed, Jan 18, 2023, Kirill A. Shutemov wrote:
> On Wed, Jan 18, 2023 at 01:09:49AM +0000, Sean Christopherson wrote:
> > On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> > > This series implements selftests targeting the feature floated by Chao via:
> > > https://lore.kernel.org/lkml/20221202061347.1070246-10-chao.p.peng@linux.intel.com/T/
> > > 
> > > Below changes aim to test the fd based approach for guest private memory
> > > in context of normal (non-confidential) VMs executing on non-confidential
> > > platforms.
> > > 
> > > private_mem_test.c file adds selftest to access private memory from the
> > > guest via private/shared accesses and checking if the contents can be
> > > leaked to/accessed by vmm via shared memory view before/after conversions.
> > > 
> > > Updates in V2:
> > > 1) Simplified vcpu run loop implementation API
> > > 2) Removed VM creation logic from private mem library
> > 
> > I pushed a rework version of this series to:
> > 
> >   git@github.com:sean-jc/linux.git x86/upm_base_support
> 
> It still has build issue with lockdep enabled that I mentioned before:

Yeah, I haven't updated the branch since last Friday, i.e. I haven't fixed the
known bugs yet.  I pushed the selftests changes at the same as everything else,
just didn't get to typing up the emails until yesterday.

> https://lore.kernel.org/all/20230116134845.vboraky2nd56szos@box.shutemov.name/
> 
> And when compiled with lockdep, it triggers a lot of warnings about missed
> locks, like this:

Ah crud, I knew I was forgetting something.  The lockdep assertion can simply be
removed, mmu_lock doesn't need to be held to read attributes.  I knew the assertion
was wrong when I added it, but I wanted to remind myself to take a closer look at
the usage of kvm_mem_is_private() and forgot to go back and delete the assertion.

The use of kvm_mem_is_private() in kvm_mmu_do_page_fault() is technically unsafe.
Similar to getting the pfn, if mmu_lock isn't held, consuming the attributes
(private vs. shared) needs MMU notifier protection, i.e. the attributes are safe
to read only after mmu_invalidate_seq is snapshot.

However, is_private gets rechecked by __kvm_faultin_pfn(), which is protected by
the sequence counter, and so the technically unsafe read is verified in the end.
The obvious alternative is to make is_private an output of kvm_faultin_pfn(), but
that's incorrect for SNP and TDX guests, in which case "is_private" is a property
of the fault itself.

TL;DR: I'm going to delete the assertion and add a comment in kvm_mmu_do_page_fault()
explaining why it's safe to consume kvm_mem_is_private() for "legacy" guests.

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 35a339891aed..da0afe81cf10 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2310,8 +2310,6 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
-       lockdep_assert_held(kvm->mmu_lock);
-
        return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
 }

