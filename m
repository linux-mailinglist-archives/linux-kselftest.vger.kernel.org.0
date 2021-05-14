Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6C380567
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhENIoq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 May 2021 04:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231452AbhENIop (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 May 2021 04:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620981814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsAavQGtZZQfxxuNta+2PaMZ+gKpW3kyTUx2+4IIAWk=;
        b=YxlcmwxVHOceWjTKAGrIUdEot99VucH4vxjA3qjNsFknrZE7IXHazHM13viWykVqBYy5X5
        VM71SW5cAV+9j5Ym6YI6WGbtkINZy3T2wJUjOcktgu6sJWqNVprSe1SzUqtQkob8aT1KH+
        jmNR+YduELejNqcSBKUmHafKfcTRvj0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-3pNJ1p8_PPeiO5SreU-PKg-1; Fri, 14 May 2021 04:43:32 -0400
X-MC-Unique: 3pNJ1p8_PPeiO5SreU-PKg-1
Received: by mail-ej1-f70.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso9318662ejn.10
        for <linux-kselftest@vger.kernel.org>; Fri, 14 May 2021 01:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lsAavQGtZZQfxxuNta+2PaMZ+gKpW3kyTUx2+4IIAWk=;
        b=p+0l86hN3MgdH/oG9rN5wOzl0Z7Izhyz0ZjF9eLBVUkXR/NOldhEXb9T+ItTZWr3FA
         9OlaArNrT0fR8yrqmgDNJ3GDwI6M1LpmwiNIspojh7ClH616kvqS1ymLWMzr4sqHqj+4
         oKusI52IWWsHZmr+2G+onaUjEZADv434FqO83jSCl/CrV8j/AT46w7/Rb+gDYw3cHMFy
         BVBcCPWwDh4Ha8cowdVJDWCkNRQPRwD1XjVART7K3KLyzMZfEWFqMhWgcnW5dOSYZjOk
         QwO0/2ypZZME7cpRzUrG3MAEXoaaMxhejsJmeWwc3eVhrOMdVa8gK160N24kzqLneVL1
         fxlQ==
X-Gm-Message-State: AOAM531LXBZ99BYunrE0GVkQyF0nuy2CMwZhBW9e9eu2u2DxjzFHb/SP
        VVRnmIgDHUQ19bIuZCb08yCxFjEH+oTbxD4U4kQDbjhjZJWxHj71VnIoL6CWBdooVpH1e7GFz8K
        teU39Gc5IVHdHy6B+24V4Jt8cT7/i
X-Received: by 2002:a50:ed0c:: with SMTP id j12mr54641141eds.12.1620981811579;
        Fri, 14 May 2021 01:43:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypI4ge2hxqi/JfrvWJM2sA3w80IXDC+WmQ5wQdEdZZtqA+keJm9IEpbNTASfWRrXFPNSGQBQ==
X-Received: by 2002:a50:ed0c:: with SMTP id j12mr54641100eds.12.1620981811327;
        Fri, 14 May 2021 01:43:31 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id k12sm3969468edo.50.2021.05.14.01.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:43:31 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-4-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v19 3/8] set_memory: allow set_direct_map_*_noflush() for
 multiple pages
Message-ID: <858e5561-bc7d-4ce1-5cb8-3c333199d52a@redhat.com>
Date:   Fri, 14 May 2021 10:43:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13.05.21 20:47, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The underlying implementations of set_direct_map_invalid_noflush() and
> set_direct_map_default_noflush() allow updating multiple contiguous pages
> at once.
> 
> Add numpages parameter to set_direct_map_*_noflush() to expose this
> ability with these APIs.
> 

[...]

Finally doing some in-depth review, sorry for not having a detailed look 
earlier.


>   
> -int set_direct_map_invalid_noflush(struct page *page)
> +int set_direct_map_invalid_noflush(struct page *page, int numpages)
>   {
>   	struct page_change_data data = {
>   		.set_mask = __pgprot(0),
>   		.clear_mask = __pgprot(PTE_VALID),
>   	};
> +	unsigned long size = PAGE_SIZE * numpages;
>   

Nit: I'd have made this const and added an early exit for !numpages. But 
whatever you prefer.

>   	if (!debug_pagealloc_enabled() && !rodata_full)
>   		return 0;
>   
>   	return apply_to_page_range(&init_mm,
>   				   (unsigned long)page_address(page),
> -				   PAGE_SIZE, change_page_range, &data);
> +				   size, change_page_range, &data);
>   }
>   
> -int set_direct_map_default_noflush(struct page *page)
> +int set_direct_map_default_noflush(struct page *page, int numpages)
>   {
>   	struct page_change_data data = {
>   		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
>   		.clear_mask = __pgprot(PTE_RDONLY),
>   	};
> +	unsigned long size = PAGE_SIZE * numpages;
>   

Nit: dito

>   	if (!debug_pagealloc_enabled() && !rodata_full)
>   		return 0;
>   
>   	return apply_to_page_range(&init_mm,
>   				   (unsigned long)page_address(page),
> -				   PAGE_SIZE, change_page_range, &data);
> +				   size, change_page_range, &data);
>   }
>   


[...]

>   extern int kernel_set_to_readonly;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 156cd235659f..15a55d6e9cec 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2192,14 +2192,14 @@ static int __set_pages_np(struct page *page, int numpages)
>   	return __change_page_attr_set_clr(&cpa, 0);
>   }
>   
> -int set_direct_map_invalid_noflush(struct page *page)
> +int set_direct_map_invalid_noflush(struct page *page, int numpages)
>   {
> -	return __set_pages_np(page, 1);
> +	return __set_pages_np(page, numpages);
>   }
>   
> -int set_direct_map_default_noflush(struct page *page)
> +int set_direct_map_default_noflush(struct page *page, int numpages)
>   {
> -	return __set_pages_p(page, 1);
> +	return __set_pages_p(page, numpages);
>   }
>   

So, what happens if we succeeded setting 
set_direct_map_invalid_noflush() for some pages but fail when having to 
split a large mapping?

Did I miss something or would the current code not undo what it 
partially did? Or do we simply not care?

I guess to handle this cleanly we would either have to catch all error 
cases first (esp. splitting large mappings) before actually performing 
the set to invalid, or have some recovery code in place if possible.


AFAIKs, your patch #5 right now only calls it with 1 page, do we need 
this change at all? Feels like a leftover from older versions to me 
where we could have had more than a single page.

-- 
Thanks,

David / dhildenb

