Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1FE387613
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 12:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348343AbhERKIL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 06:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348337AbhERKIG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 06:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621332407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFkmeu2athwSt2LK0RUUi/E/grHFe/dKRRuvCpK8qJo=;
        b=DvVzlLIiJep/n8KFdyk90AQKKEfVlBjAvuImkvRCnAa+n4SDjle9QfWbVVpmdRDeLPBv2f
        j0na5zyruwqd0Wm5AYftDDxCVuAB07sAUHDMgs96LVcZ5ESuaDymKgn/uuwpLF6lKa0GSA
        svnPAxFEKZ30Cr8VG6jmjfXjxMmsgcE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87--Tdn5UwpPwihEEhZg_18vg-1; Tue, 18 May 2021 06:06:46 -0400
X-MC-Unique: -Tdn5UwpPwihEEhZg_18vg-1
Received: by mail-wm1-f72.google.com with SMTP id l185-20020a1c25c20000b029014b0624775eso376925wml.6
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 03:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dFkmeu2athwSt2LK0RUUi/E/grHFe/dKRRuvCpK8qJo=;
        b=BvRVzBRhITx0pb+QwmnXioW+JNdeDDu9B9qmUVD9Ke+GiKSTFolECx2QkAQdLHjkSB
         cjnTbqoL90u4qm7Mu+/+4M/bQdf97EoENufwwN1ZS6puGb21l/WbQTsxGVh2QwwVAFLe
         HDZUoEINUpY1xNnLayJ5u69Z8eE/7gGrhVCHhk0cyUTnHKHlq85GccMfexg4QrndIBfA
         bM0F/wFGb66gF+ZsjfjxNSfvsPSV5uvDnptRY5e6n+0RiHY84Ngu3o5CVKsX26MZ9zDd
         ANOUsy9j2Iq6IBNdusS5VJ7GTxPfSAqt28eBSPkQxmjju8KK88AgSV/6OZxt/XPkMyu7
         eZEw==
X-Gm-Message-State: AOAM533WVyuPQ5xyxfi8hXmzbt51NePvs9E0QGiJa5feEY3BvlU5pXaU
        KfE7FbYjhRCFsmaNXfisCkyRbVn45nLso9IFNGGnF6gXlaPVhuC3Pvdkifv4mSYZyY78lmMrRUb
        4BE/cFCrW1ysXQPK4ZH3U+rRPRGbn
X-Received: by 2002:a05:6000:1ac5:: with SMTP id i5mr5879830wry.6.1621332405357;
        Tue, 18 May 2021 03:06:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiVxI2VqHM3UC3HkCv7YVP9ChZhf/paSvmhTbK/1R/b2aClM7EAkaKYj9OwIH5AzvG3tEX6Q==
X-Received: by 2002:a05:6000:1ac5:: with SMTP id i5mr5879787wry.6.1621332405164;
        Tue, 18 May 2021 03:06:45 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id f14sm8395872wry.40.2021.05.18.03.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 03:06:44 -0700 (PDT)
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
To:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <20210513184734.29317-6-rppt@kernel.org>
 <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
 <YKDJ1L7XpJRQgSch@kernel.org> <YKOP5x8PPbqzcsdK@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8e114f09-60e4-2343-1c42-1beaf540c150@redhat.com>
Date:   Tue, 18 May 2021 12:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKOP5x8PPbqzcsdK@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18.05.21 11:59, Michal Hocko wrote:
> On Sun 16-05-21 10:29:24, Mike Rapoport wrote:
>> On Fri, May 14, 2021 at 11:25:43AM +0200, David Hildenbrand wrote:
> [...]
>>>> +		if (!page)
>>>> +			return VM_FAULT_OOM;
>>>> +
>>>> +		err = set_direct_map_invalid_noflush(page, 1);
>>>> +		if (err) {
>>>> +			put_page(page);
>>>> +			return vmf_error(err);
>>>
>>> Would we want to translate that to a proper VM_FAULT_..., which would most
>>> probably be VM_FAULT_OOM when we fail to allocate a pagetable?
>>
>> That's what vmf_error does, it translates -ESOMETHING to VM_FAULT_XYZ.
> 
> I haven't read through the rest but this has just caught my attention.
> Is it really reasonable to trigger the oom killer when you cannot
> invalidate the direct mapping. From a quick look at the code it is quite
> unlikely to se ENOMEM from that path (it allocates small pages) but this
> can become quite sublte over time. Shouldn't this simply SIGBUS if it
> cannot manipulate the direct mapping regardless of the underlying reason
> for that?
> 

OTOH, it means our kernel zones are depleted, so we'd better reclaim 
somehow ...

-- 
Thanks,

David / dhildenb

