Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAEB3659D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Apr 2021 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhDTNUj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Apr 2021 09:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231769AbhDTNUj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Apr 2021 09:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618924807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYX7/AuHi6hgPHf6tRYqK2+HrNaM+fnSnNKD7KzrRzs=;
        b=fTJz8bd2ajNGxw3Wb3iuvAa697e6s5nqngRdfCpc4QSuwXa+4b3Ns021ap1NSxes5I1tkU
        vN00C0U/pMpPm++E9UBYrjezKjQRjvV3Xv818NwieI100DoaVSw8pF9PkD3vfPXuiMw1UX
        IInzwU2vtekwVA6cAfRr7XzgGkT2PtA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-m9yGrex4MjW35h4hLiQyBQ-1; Tue, 20 Apr 2021 09:20:00 -0400
X-MC-Unique: m9yGrex4MjW35h4hLiQyBQ-1
Received: by mail-wr1-f71.google.com with SMTP id o14-20020a5d474e0000b029010298882dadso10852392wrs.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 06:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QYX7/AuHi6hgPHf6tRYqK2+HrNaM+fnSnNKD7KzrRzs=;
        b=BGIT8jxIAYUB0O2fDCplwaKx2Uoa2hfE4mXmBAmOfmwQWtxpVweJ6bsKKWTNSPFXOx
         PIwwGgS4iJKjUSbc0Jqe0QQoJMQ/wR1mhmmB4QYo80+FnJPJEBrjlagurL48UMp/q8mj
         mlozkP+yTeputh6PkSukU2BZqDHwu5PPxeV2s9QH4IIRq1Xqutj/7ol3Cl19qhxIu1uB
         dqshlQwz4/f99kEPWPDE6loOME9+H3C89BaQCLjstlX8Sho1NlvwNkpxQk81OHSGU8Fb
         6k97USYcrzXfhnh7d866c7FjSn8tJCEMlaSemG7zHOiioW4RB2AbmVMN2t+cWPHvClB2
         xf7w==
X-Gm-Message-State: AOAM532m+6SbdriVQcQGaVgcrb1Yay+Wd3ZlcwWTYyp2B48TcYYMIfQs
        jD4SIC4m4ZMdph8wiDUNct8STsHL0RN1fHvkPJ+l6ACFJZRuOL1MsvUhVunYV66jhPXNfRXi7L6
        W6RuN1TODIeX33M3hh/WroQDnaM6u
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr20916777wrx.19.1618924799171;
        Tue, 20 Apr 2021 06:19:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfOGjRv02X/zmH7pcY7EIgqs8w+z5KR0gU0RfoaYN+dlGesRC5fI0lFDDiwZRbvB39JmbKYA==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr20916761wrx.19.1618924798995;
        Tue, 20 Apr 2021 06:19:58 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id f6sm3291518wmf.28.2021.04.20.06.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 06:19:58 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] secretmem/gup: don't check if page is secretmem
 without reference
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
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
References: <20210420131611.8259-1-rppt@kernel.org>
 <20210420131611.8259-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <95b7fa81-f72e-c63f-0456-4c25dee8a5eb@redhat.com>
Date:   Tue, 20 Apr 2021 15:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420131611.8259-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 20.04.21 15:16, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The check in gup_pte_range() whether a page belongs to a secretmem mapping
> is performed before grabbing the page reference.
> 
> To avoid potential race move the check after try_grab_compound_head().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   mm/gup.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c3a17b189064..4b58c016e949 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2080,13 +2080,13 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>   		page = pte_page(pte);
>   
> -		if (page_is_secretmem(page))
> -			goto pte_unmap;
> -
>   		head = try_grab_compound_head(page, 1, flags);
>   		if (!head)
>   			goto pte_unmap;
>   
> +		if (page_is_secretmem(page))
> +			goto pte_unmap;
> +

Looking at the hunk below, I wonder if you're missing a put_compound_head().

(also, I'd do if unlikely(page_is_secretmem()) but that's a different 
discussion)

>   		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>   			put_compound_head(head, 1, flags);
>   			goto pte_unmap;
> 


-- 
Thanks,

David / dhildenb

