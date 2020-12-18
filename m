Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B4F2DEBBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 23:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgLRWpa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 17:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgLRWp3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 17:45:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C86C0617A7;
        Fri, 18 Dec 2020 14:44:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608331487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSvGwnCoAalQdHR+Ln4Q2sS79B4UxqMN+RD1afn6GC4=;
        b=WLPlBrXYqR/QHDC+jzhTogdMRUXRoXK7xVn6httZGE/POOtKQOICxm2Vx7GbejEFjraKCp
        8FtPz4HV4CtlPx6lsNBoWhtimmNasXfdHmGCB3HmbMpO6jtChbcJzok72ZwXgYgiPqi/+W
        TVo3o8mEE5wxXl7oVY4N8wC2y8Fd1c5dq3sp22pGFacd1ybmBMogWCrnWhS0YH/Yv6bOLv
        jy76FaA3txWF3rrqdIiM/E1ZuVFE2VhdGDiw8WjIanN7S0vT61aUViIeTCTFVaKx6xUytw
        RvdtJ7Gjd4DRTiq5bs+kLdz+fgJOLnKr2p1wVbJxp5o5kFLaeENoshm8pvRMtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608331487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSvGwnCoAalQdHR+Ln4Q2sS79B4UxqMN+RD1afn6GC4=;
        b=adzlxci9JislJbxDWr9PbAbA3shNaiVRFjiwlYUSAoyCp+6io/bqTAyHyqeJm/zADQxY5/
        Mn3qg+DY7xHFSeBA==
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Weiny\, Ira" <ira.weiny@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <CAPcyv4gqm5p+pVmX4JL0fT2LY0dfoT+UXAfsGLA9LMr42vp33A@mail.gmail.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com> <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de> <878s9vqkrk.fsf@nanos.tec.linutronix.de> <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com> <875z4yrfhr.fsf@nanos.tec.linutronix.de> <CAPcyv4gqm5p+pVmX4JL0fT2LY0dfoT+UXAfsGLA9LMr42vp33A@mail.gmail.com>
Date:   Fri, 18 Dec 2020 23:44:47 +0100
Message-ID: <87wnxepwdc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 18 2020 at 13:58, Dan Williams wrote:
> On Fri, Dec 18, 2020 at 1:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> kmap_local() is fine. That can work automatically because it's strict
>> local to the context which does the mapping.
>>
>> kmap() is dubious because it's a 'global' mapping as dictated per
>> HIGHMEM. So doing the RELAXED mode for kmap() is sensible I think to
>> identify cases where the mapped address is really handed to a different
>> execution context. We want to see those cases and analyse whether this
>> can't be solved in a different way. That's why I suggested to do a
>> warning in that case.
>>
>> Also vs. the DAX use case I really meant the code in fs/dax and
>> drivers/dax/ itself which is handling this via dax_read_[un]lock.
>>
>> Does that make more sense?
>
> Yup, got it. The dax code can be precise wrt to PKS in a way that
> kmap_local() cannot.

Which makes me wonder whether we should have kmap_local_for_read()
or something like that, which could be obviously only be RO enforced for
the real HIGHMEM case or the (for now x86 only) enforced kmap_local()
debug mechanics on 64bit.

So for the !highmem case it would not magically make the existing kernel
mapping RO, but this could be forwarded to the PKS protection. Aside of
that it's a nice annotation in the code.

That could be used right away for all the kmap[_atomic] -> kmap_local
conversions.

Thanks,

        tglx
---
 include/linux/highmem-internal.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -32,6 +32,10 @@ static inline void kmap_flush_tlb(unsign
 #define kmap_prot PAGE_KERNEL
 #endif
 
+#ifndef kmap_prot_to
+#define kmap_prot PAGE_KERNEL_RO
+#endif
+
 void *kmap_high(struct page *page);
 void kunmap_high(struct page *page);
 void __kmap_flush_unused(void);
@@ -73,6 +77,11 @@ static inline void *kmap_local_page(stru
 	return __kmap_local_page_prot(page, kmap_prot);
 }
 
+static inline void *kmap_local_page_for_read(struct page *page)
+{
+	return __kmap_local_page_prot(page, kmap_prot_ro);
+}
+
 static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
 {
 	return __kmap_local_page_prot(page, prot);
@@ -169,6 +178,11 @@ static inline void *kmap_local_page_prot
 {
 	return kmap_local_page(page);
 }
+
+static inline void *kmap_local_page_for_read(struct page *page)
+{
+	return kmap_local_page(page);
+}
 
 static inline void *kmap_local_pfn(unsigned long pfn)
 {
