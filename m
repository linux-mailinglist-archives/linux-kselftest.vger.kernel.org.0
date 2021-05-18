Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A501387672
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348499AbhERK2i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 06:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348484AbhERK2g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 06:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621333638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Th9b0uelp+zuS5Dolk9edCcQodErGvwWmi6QbbSzCQ8=;
        b=hu4cwNlgqIF9y6apOx12S2Ln9ed/WSIc5qETK3CNvMU7q+r+gTr9soTYGttRGNOEuNjaSM
        pif+hPFuDmB8R2mJotHO4CzpzJhMpNxX4EHGbSKhfFIAr+uY9x3aA88hXNFEMEcnWGVn3z
        Gw01N0VUayxiTcznVWu9omKv/9drT/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-F1Gh6Q5cPEOH89B2ugSe5g-1; Tue, 18 May 2021 06:27:16 -0400
X-MC-Unique: F1Gh6Q5cPEOH89B2ugSe5g-1
Received: by mail-wm1-f72.google.com with SMTP id r15-20020a05600c35cfb029017373d9f318so230971wmq.4
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 03:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Th9b0uelp+zuS5Dolk9edCcQodErGvwWmi6QbbSzCQ8=;
        b=ul8HsZegGA8E/4KDUFBzz1V6E2bGrdiHsSqmG5JtexC1fON0SHlCDJi9NKflXe/LRX
         4iPrSI2rJqFsPtB0dgEZuri0M61BU0xdfCmd1e3T/fh/OK3gryZHSxBaYSQsrjpxFLsE
         F8t152s3G+nSRWRVwliAl9RnEU+Y9gJuB4EpMviz0Jv7veHU1tGotkAvzD6O69pn6wAx
         JpvF/y0/ILyF/Nycpil1JIuTmmiRwWHiNskn8QxCz46pBxWyonTBjrwLsTV361GptKJr
         UbYeQnszSY+3OHhAI64sooyyanxv0qGXFX/p5eo692Fv5mQYyRNha2nr+BakQDmVTP2/
         VMKw==
X-Gm-Message-State: AOAM5318TX1uJ+5CqKI0jTeAY5wiRBv4uRvKyJgD0gvUkT7AilQj0oIs
        xE+EDfpDBOhVkeirGlQyY6kVfR57bfeIp0N/eC380TIZYIVEwX0o2xbCKAxC7RgRYHR2wWLc5hd
        wPh8fC4h6cUZFhQWi5IFnkAOvtvZu
X-Received: by 2002:a05:600c:35cc:: with SMTP id r12mr4525780wmq.157.1621333635632;
        Tue, 18 May 2021 03:27:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL+bP4BGJ/+tDiLE4ZHcq1wv671RbTKwVIAcgFztdQnfjanbuq/Gm2r3B/QzaKSEduy6Y9Cg==
X-Received: by 2002:a05:600c:35cc:: with SMTP id r12mr4525739wmq.157.1621333635433;
        Tue, 18 May 2021 03:27:15 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id z3sm1173826wrq.42.2021.05.18.03.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 03:27:15 -0700 (PDT)
Subject: Re: [PATCH v19 6/8] PM: hibernate: disable when there are active
 secretmem users
To:     Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>
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
 <20210513184734.29317-7-rppt@kernel.org>
 <20210518102424.GD82842@C02TD0UTHF1T.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <47d0e5b1-ffee-d694-4865-8718619c1be0@redhat.com>
Date:   Tue, 18 May 2021 12:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518102424.GD82842@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18.05.21 12:24, Mark Rutland wrote:
> On Thu, May 13, 2021 at 09:47:32PM +0300, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> It is unsafe to allow saving of secretmem areas to the hibernation
>> snapshot as they would be visible after the resume and this essentially
>> will defeat the purpose of secret memory mappings.
>>
>> Prevent hibernation whenever there are active secret memory users.
> 
> Have we thought about how this is going to work in practice, e.g. on
> mobile systems? It seems to me that there are a variety of common
> applications which might want to use this which people don't expect to
> inhibit hibernate (e.g. authentication agents, web browsers).
> 
> Are we happy to say that any userspace application can incidentally
> inhibit hibernate?

It's worth noting that secretmem has to be explicitly enabled by the 
admin to even work.

-- 
Thanks,

David / dhildenb

