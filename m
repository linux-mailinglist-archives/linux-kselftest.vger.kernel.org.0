Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95E365BFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Apr 2021 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhDTPSj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Apr 2021 11:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231391AbhDTPSh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Apr 2021 11:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618931883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5ndW6k8mLw6k1PzLhNPYJ9rDrEc5/TU+m57YMg1P3Q=;
        b=WPao2PBCT8VCVztS0643OoMTG3z7JahyW4Oyj9PUp5obQQw9gW49+y+tAFZp0h5s2eUBzR
        y5rjBy5WsA4EK2ebAESchETM5p7HgZabg9JVnJRAsUXvI0CAWknj/5ct65iLI5WfEScgTL
        i1TyOllo2/+xcmmwJBjuTZrmxrd7nw0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-xZSswY_OM-KrU9c6FoDd-Q-1; Tue, 20 Apr 2021 11:18:02 -0400
X-MC-Unique: xZSswY_OM-KrU9c6FoDd-Q-1
Received: by mail-ej1-f72.google.com with SMTP id x21-20020a1709064bd5b029037c44cb861cso4902204ejv.4
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 08:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I5ndW6k8mLw6k1PzLhNPYJ9rDrEc5/TU+m57YMg1P3Q=;
        b=iUcI9yrWLMzSP29TFMqh3ti+xVkIPOzSY+8w9YgHS6RelH8YYJk/5QAjUzSeC4CFt4
         3bho8G1OrhO7B/oUa8D8JMV94h6q+Io9+LhmZzF4yw5M+K35Pi3njRgo1Im9ZBK0plxk
         sgb+FuikePvwJFtvbUQMjVQ2n4P3OO6WJc+N2wB7S3MmwwMppdjwfH4hpH5yqFL3A5Cq
         0++GbZtahrQQ0/N2T+/a08+SJUI/09ayukEkok9gKlP7rIs05/sHC+reUb46MP0N0qe4
         3GfGx8UDJsp2ZHmx1dU1maIKW/eUc/ko1MRnmvUR3WWs2JpZe7McNVQ+FTbI/HCbIUY2
         GDWw==
X-Gm-Message-State: AOAM530k/SOx2HU+WwdWvLMq/tMQ0ESl5YBG/UXgVlGiLLEgS4u9G90E
        iy0X5F5QisWpORnNluGhywk24hAviVWWduTemnapyABBJ7ztIyQs7w4fJddv+/tPkP5uqzNRXzw
        CUCL2H3DxLVVCk0K6kBrw9068Y4dI
X-Received: by 2002:aa7:c683:: with SMTP id n3mr32232746edq.214.1618931880952;
        Tue, 20 Apr 2021 08:18:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKrP/Z3igfJPaQi8yJZtC2FjNZPIjMXhA64NexGRfIVc/CrlZnXvE6wVD3xtThrpBxYqmr/Q==
X-Received: by 2002:aa7:c683:: with SMTP id n3mr32232708edq.214.1618931880725;
        Tue, 20 Apr 2021 08:18:00 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id a17sm13193206ejx.13.2021.04.20.08.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:18:00 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] secretmem/gup: don't check if page is secretmem
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
References: <20210420150049.14031-1-rppt@kernel.org>
 <20210420150049.14031-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f906a634-ee25-5a8b-6cdf-3651832dbe99@redhat.com>
Date:   Tue, 20 Apr 2021 17:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420150049.14031-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 20.04.21 17:00, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The check in gup_pte_range() whether a page belongs to a secretmem mapping
> is performed before grabbing the page reference.
> 
> To avoid potential race move the check after try_grab_compound_head().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   mm/gup.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c3a17b189064..6515f82b0f32 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2080,13 +2080,15 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
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
> +		if (unlikely(page_is_secretmem(page))) {
> +			put_compound_head(head, 1, flags);
> +			goto pte_unmap;
> +		}
> +
>   		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>   			put_compound_head(head, 1, flags);
>   			goto pte_unmap;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

