Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0D7B2386
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjI1RQL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjI1RQK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 13:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40DC1B0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695921319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iB4+ZJehBJyV1CWWY+MqwDYHFJ2vxRDvHuETyOblfLU=;
        b=Zxw69s3iLpyYupyiG0NhANiixYvDv/aXkoPr64Qc764y9b10sQlCOvvc06nWeompI1ADE5
        F9t1VMph96PIcuPxiuOZIYc8hDecbBw5UDxmA9OFZjqiriNjOq/2vE5KHyDm+QGsk8xbDL
        p/Y8IEcgQJWxnXgmDR7q0N07ronb4jQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-etF-ShArMGm2Qxw97zMqVg-1; Thu, 28 Sep 2023 13:15:17 -0400
X-MC-Unique: etF-ShArMGm2Qxw97zMqVg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32480c0ad52so1445001f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 10:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921316; x=1696526116;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iB4+ZJehBJyV1CWWY+MqwDYHFJ2vxRDvHuETyOblfLU=;
        b=VOzvMaC94tzwvWTCDprPNmKpW5Jcu+uPoBbaLT0I7D8uTHyfhPGQOEarWZtno7Lfri
         S6C+hfGZ1ovr1zNy4N2mb0UXPtcfG6ATsCGRuiIDFJ83sTFeQVTAyry5amJLEB7oLT/l
         MXpwrIPpFOZphqeHF20BUbYuoA2Cmtz/ADLJ6ubOjVTY+XwtRhvhQcWIT6quXFEF+ARR
         XchS8pOIeR/flTN+2jknh//uAEW0eVqMK0gYuCe2kGumVnd9lh86X71ucOkEOAw8x/7M
         PgMQZHe+ullwyVL5KmYJhjS7IDvZEHZ0F1hPyFfOA2T70oYr4S48b2+gGoriUUYK700R
         ixCw==
X-Gm-Message-State: AOJu0YzBWlNM8v4G/U9Sm4cQkKHo7Trv4VRKMbM4VwUzS3MRa6/jj7Wo
        P7cBtkgnj2K6H2HZ2Sk5PjRYbEW0f+iVVdn+jzPZag9iE0PE5vyACSclLvg1j+u/DfmCE9sUMLU
        IqJjeGsXCeRHPzzcdRRxmp5z+O5d3
X-Received: by 2002:adf:fac9:0:b0:319:785a:fce0 with SMTP id a9-20020adffac9000000b00319785afce0mr1778252wrs.26.1695921315869;
        Thu, 28 Sep 2023 10:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMHySBXVM8IbvGir7YCqj8UNThTOXlUJ574EKr5MYsPao0vC5cge2y9Ks7isIE+CxQe6gk5w==
X-Received: by 2002:adf:fac9:0:b0:319:785a:fce0 with SMTP id a9-20020adffac9000000b00319785afce0mr1778223wrs.26.1695921315344;
        Thu, 28 Sep 2023 10:15:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:f00:b37d:4253:cd0d:d213? (p200300cbc7180f00b37d4253cd0dd213.dip0.t-ipconnect.de. [2003:cb:c718:f00:b37d:4253:cd0d:d213])
        by smtp.gmail.com with ESMTPSA id q16-20020adf9dd0000000b0031912c0ffebsm7770278wre.23.2023.09.28.10.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:15:14 -0700 (PDT)
Message-ID: <9101f70c-0c0a-845b-4ab7-82edf71c7bac@redhat.com>
Date:   Thu, 28 Sep 2023 19:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
 <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
In-Reply-To: <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27.09.23 20:25, Suren Baghdasaryan wrote:
>>
>> I have some cleanups pending for page_move_anon_rmap(), that moves the
>> SetPageAnonExclusive hunk out. Here we should be using
>> page_move_anon_rmap() [or rather, folio_move_anon_rmap() after my cleanups]
>>
>> I'll send them out soonish.
> 
> Should I keep this as is in my next version until you post the
> cleanups? I can add a TODO comment to convert it to
> folio_move_anon_rmap() once it's ready.

You should just be able to use page_move_anon_rmap() and whatever gets 
in first cleans it up :)

> 
>>
>>>> +       WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,
>>>> +                                                     dst_addr)); >> +
>>>> +       orig_src_pte = ptep_clear_flush(src_vma, src_addr, src_pte);
>>>> +       orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
>>>> +       orig_dst_pte = maybe_mkwrite(pte_mkdirty(orig_dst_pte),
>>>> +                                    dst_vma);
>>>
>>> I think there's still a theoretical issue here that you could fix by
>>> checking for the AnonExclusive flag, similar to the huge page case.
>>>
>>> Consider the following scenario:
>>>
>>> 1. process P1 does a write fault in a private anonymous VMA, creating
>>> and mapping a new anonymous page A1
>>> 2. process P1 forks and creates two children P2 and P3. afterwards, A1
>>> is mapped in P1, P2 and P3 as a COW page, with mapcount 3.
>>> 3. process P1 removes its mapping of A1, dropping its mapcount to 2.
>>> 4. process P2 uses vmsplice() to grab a reference to A1 with get_user_pages()
>>> 5. process P2 removes its mapping of A1, dropping its mapcount to 1.
>>>
>>> If at this point P3 does a write fault on its mapping of A1, it will
>>> still trigger copy-on-write thanks to the AnonExclusive mechanism; and
>>> this is necessary to avoid P3 mapping A1 as writable and writing data
>>> into it that will become visible to P2, if P2 and P3 are in different
>>> security contexts.
>>>
>>> But if P3 instead moves its mapping of A1 to another address with
>>> remap_anon_pte() which only does a page mapcount check, the
>>> maybe_mkwrite() will directly make the mapping writable, circumventing
>>> the AnonExclusive mechanism.
>>>
>>
>> Yes, can_change_pte_writable() contains the exact logic when we can turn
>> something easily writable even if it wasn't writable before. which
>> includes that PageAnonExclusive is set. (but with uffd-wp or softdirty
>> tracking, there is more to consider)
> 
> For uffd_remap can_change_pte_writable() would fail it VM_WRITE is not
> set, but we want remapping to work for RO memory as well. Are you

In a VMA without VM_WRITE you certainly wouldn't want to make PTEs 
writable :) That's why that function just does a sanity check that it is 
not called in strange context. So one would only call it if VM_WRITE is set.

> saying that a PageAnonExclusive() check alone would not be enough
> here?

There are some interesting questions to ask here:

1) What happens if the old VMA has VM_SOFTDIRTY set but the new one not? 
You most probably have to mark the PTE softdirty and not make it writable.

2) VM_UFFD_WP requires similar care I assume? Peter might know.

-- 
Cheers,

David / dhildenb

