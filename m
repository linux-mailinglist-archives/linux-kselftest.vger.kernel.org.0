Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF52C406A
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Nov 2020 13:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgKYMm4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Nov 2020 07:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbgKYMm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Nov 2020 07:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606308174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+jgAoXCcc+2e3woKE/RD7YJatBg4rpbL38pBlAO/5Y=;
        b=NAmjrcRhnPM8JGpgHTrb5n2QN5hbv+5+0lU/rpwQGjg7suA1cH+ap68KXG3TeeigsvS4iG
        DHjK6DGtLe6QFL8ddVHy4leoapTo+IEQtMMT13bvb69zFBJyC2+8xpVIkBSZOHxZQPpZ6I
        QXDZgt8Cz0pKiiPQ9z7jCymv0u8hsoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-DI1Pfe2wOHqV_YxKmpoagw-1; Wed, 25 Nov 2020 07:42:50 -0500
X-MC-Unique: DI1Pfe2wOHqV_YxKmpoagw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E63451E7C7;
        Wed, 25 Nov 2020 12:42:44 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C339A5D6AC;
        Wed, 25 Nov 2020 12:42:37 +0000 (UTC)
Subject: Re: [PATCH v12 04/10] set_memory: allow querying whether
 set_direct_map_*() is actually enabled
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20201125092208.12544-1-rppt@kernel.org>
 <20201125092208.12544-5-rppt@kernel.org>
 <5ea6eacd-79e8-0645-da39-d3461f60e627@redhat.com>
 <20201125121138.GJ123287@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <bb27ab9e-8c74-e297-acc1-a92bcc4087a9@redhat.com>
Date:   Wed, 25 Nov 2020 13:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125121138.GJ123287@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25.11.20 13:11, Mike Rapoport wrote:
> On Wed, Nov 25, 2020 at 12:22:52PM +0100, David Hildenbrand wrote:
>>>  #include <asm-generic/cacheflush.h>
>>>  
>>>  #endif /* __ASM_CACHEFLUSH_H */
>>> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
>>> new file mode 100644
>>> index 000000000000..ecb6b0f449ab
>>> --- /dev/null
>>> +++ b/arch/arm64/include/asm/set_memory.h
>>> @@ -0,0 +1,17 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +
>>> +#ifndef _ASM_ARM64_SET_MEMORY_H
>>> +#define _ASM_ARM64_SET_MEMORY_H
>>> +
>>> +#include <asm-generic/set_memory.h>
>>> +
>>> +bool can_set_direct_map(void);
>>> +#define can_set_direct_map can_set_direct_map
>>
>> Well, that looks weird.
>> [...]
> 
> We have a lot of those e.g. in linux/pgtable.h
> 
>>>  }
>>> +#else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
>>> +/*
>>> + * Some architectures, e.g. ARM64 can disable direct map modifications at
>>> + * boot time. Let them overrive this query.
>>> + */
>>> +#ifndef can_set_direct_map
>>> +static inline bool can_set_direct_map(void)
>>> +{
>>> +	return true;
>>> +}
>>
>> I think we prefer __weak functions for something like that, avoids the
>> ifdefery.
> 
> I'd prefer this for two reasons: first, static inline can be optimized
> away and second, there is no really good place to put generic
> implementation.

Fair enough

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

