Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC83319DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 22:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCHV7B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 16:59:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhCHV67 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 16:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615240739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KrspNk2rfZj7/whsGzU05gApqtQxCSoDmRFTVen5Hf8=;
        b=AkB4Qo2keFFZYS9KDs5MdGPTt06GcV3+TN+MEU7eLrW+wUxEYXd0xo3cztAy78wJ9imWVI
        nAIHkdZm1b8hqBvYMCe/tWTXVHll0uVEFzoofsq4TnL17PRR7CCYNbhYgMAAWDhsELiUGJ
        B3v6jmJ8g7AVrz6kzSrE9zAYPrFaMg0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-vKMhLRBsNlK-PM9XibtpIw-1; Mon, 08 Mar 2021 16:58:57 -0500
X-MC-Unique: vKMhLRBsNlK-PM9XibtpIw-1
Received: by mail-wr1-f72.google.com with SMTP id h30so5440948wrh.10
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Mar 2021 13:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KrspNk2rfZj7/whsGzU05gApqtQxCSoDmRFTVen5Hf8=;
        b=cncCsIB0cBT3CVA5jOn6EXjWVcR3/XF3oq0y+0EcWh0ZGmpKF5piGpXBv0M2bnCweG
         oAORt+C8WFZGK5xv5Ujvkzr91ODyPNy3dwnDDVPsTbyVboGv3GLB7laax4LBn7+iVjG8
         2YEpaPW9ZqSdyXdr0YKCcoo09VOaYq0s9u39uvxiv2NfYNgA+s2gf5oQ1OlhkPAfLMUk
         VXaFKtP7Pp8eX3zaxOCUQ5HpJeWTN/qWf7cyBK+Z3vKIgda+Jr+vWNjTEETrJTqHlMtV
         CBqfTTnDrhb0yqtKwUJH5PkCLqfaX6IYC6qocrq16Bw85rWbTR8vajpWkgxQMIqAsLWW
         MsiA==
X-Gm-Message-State: AOAM530MoHvcxxuZXMxvvaMeKftgRa3mzYVNqH8iMNkVn286nWJqMm6c
        5NDOqvPsvh6DDw+WdNJ1msn6SRhs6bX/2VUTLGhXg16ZPRM2jGB/nZ9c0i9umbWzEdlb2NcYQLC
        /pvIUUQ+Lm1cYcj1GmXB7zSm0ytpN
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr769339wmc.164.1615240736303;
        Mon, 08 Mar 2021 13:58:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnMtr0hHT3Ag3D8EwKA/HQC1ulxa/i0rpRvb0QgcVr3VqstcJxdUY/3I38QdQT8QV+qQWpsQ==
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr769332wmc.164.1615240736072;
        Mon, 08 Mar 2021 13:58:56 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6c02.dip0.t-ipconnect.de. [91.12.108.2])
        by smtp.gmail.com with ESMTPSA id b186sm856863wmc.44.2021.03.08.13.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 13:58:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting THP tests.
Date:   Mon, 8 Mar 2021 22:58:54 +0100
Message-Id: <B7E9E82B-70B1-491E-99B9-B6B30AE0DE68@redhat.com>
References: <CAHbLzkpfR=xbnepbriu1b8n5ii8Kp0EgEa3D7+mU2xcS9iGpGg@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
In-Reply-To: <CAHbLzkpfR=xbnepbriu1b8n5ii8Kp0EgEa3D7+mU2xcS9iGpGg@mail.gmail.com>
To:     Yang Shi <shy828301@gmail.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> Am 08.03.2021 um 22:25 schrieb Yang Shi <shy828301@gmail.com>:
>=20
> =EF=BB=BFOn Mon, Mar 8, 2021 at 12:36 PM David Hildenbrand <david@redhat.c=
om> wrote:
>>=20
>>=20
>>>> Am 08.03.2021 um 21:18 schrieb Yang Shi <shy828301@gmail.com>:
>>>=20
>>> =EF=BB=BFOn Mon, Mar 8, 2021 at 11:30 AM David Hildenbrand <david@redhat=
.com> wrote:
>>>>=20
>>>>> On 08.03.21 20:11, Yang Shi wrote:
>>>>> On Mon, Mar 8, 2021 at 11:01 AM Zi Yan <ziy@nvidia.com> wrote:
>>>>>>=20
>>>>>> On 8 Mar 2021, at 13:11, David Hildenbrand wrote:
>>>>>>=20
>>>>>>> On 08.03.21 18:49, Zi Yan wrote:
>>>>>>>> On 8 Mar 2021, at 11:17, David Hildenbrand wrote:
>>>>>>>>=20
>>>>>>>>> On 08.03.21 16:22, Zi Yan wrote:
>>>>>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>>>>>=20
>>>>>>>>>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>>>>>>>>>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process with=
 the
>>>>>>>>>> given pid and virtual address range are split. It is used to test=

>>>>>>>>>> split_huge_page function. In addition, a selftest program is adde=
d to
>>>>>>>>>> tools/testing/selftests/vm to utilize the interface by splitting
>>>>>>>>>> PMD THPs and PTE-mapped THPs.
>>>>>>>>>=20
>>>>>>>>> Won't something like
>>>>>>>>>=20
>>>>>>>>> 1. MADV_HUGEPAGE
>>>>>>>>>=20
>>>>>>>>> 2. Access memory
>>>>>>>>>=20
>>>>>>>>> 3. MADV_NOHUGEPAGE
>>>>>>>>>=20
>>>>>>>>> Have a similar effect? What's the benefit of this?
>>>>>>>>=20
>>>>>>>> Thanks for checking the patch.
>>>>>>>>=20
>>>>>>>> No, MADV_NOHUGEPAGE just replaces VM_HUGEPAGE with VM_NOHUGEPAGE,
>>>>>>>> nothing else will be done.
>>>>>>>=20
>>>>>>> Ah, okay - maybe my memory was tricking me. There is some s390x KVM c=
ode that forces MADV_NOHUGEPAGE and force-splits everything.
>>>>>>>=20
>>>>>>> I do wonder, though, if this functionality would be worth a proper u=
ser interface (e.g., madvise), though. There might be actual benefit in havi=
ng this as a !debug interface.
>>>>>>>=20
>>>>>>> I think you aware of the discussion in https://lkml.kernel.org/r/d09=
8c392-273a-36a4-1a29-59731cdf5d3d@google.com
>>>>>>=20
>>>>>> Yes. Thanks for bringing this up.
>>>>>>=20
>>>>>>>=20
>>>>>>> If there will be an interface to collapse a THP -- "this memory area=
 is worth extra performance now by collapsing a THP if possible" -- it might=
 also be helpful to have the opposite functionality -- "this memory area is n=
ot worth a THP, rather use that somehwere else".
>>>>>>>=20
>>>>>>> MADV_HUGE_COLLAPSE vs. MADV_HUGE_SPLIT
>>>>>>=20
>>>>>> I agree that MADV_HUGE_SPLIT would be useful as the opposite of COLLA=
PSE when user might just want PAGESIZE mappings.
>>>>>> Right now, HUGE_SPLIT is implicit from mapping changes like mprotect o=
r MADV_DONTNEED.
>>>>>=20
>>>>> IMHO, it sounds not very useful. MADV_DONTNEED would split PMD for any=

>>>>> partial THP. If the range covers the whole THP, the whole THP is going=

>>>>> to be freed anyway. All other places in kernel which need split THP
>>>>> have been covered. So I didn't realize any usecase from userspace for
>>>>> just splitting PMD to PTEs.
>>>>=20
>>>> THP are a limited resource. So indicating which virtual memory regions
>>>> are not performance sensitive right now (e.g., cold pages in a databse)=

>>>> and not worth a THP might be quite valuable, no?
>>>=20
>>> Such functionality could be achieved by MADV_COLD or MADV_PAGEOUT,
>>> right? Then a subsequent call to MADV_NOHUGEPAGE would prevent from
>>> collapsing or allocating THP for that area.
>>>=20
>>=20
>> I remember these deal with optimizing swapping. Not sure how they interac=
t with THP, especially on systems without swap - I would guess they don=E2=80=
=98t as of now.
>=20
> Yes, MADV_PAGEOUT would just swap the THP or sub pages out. I think I
> just forgot to mention MADV_FREE which would be more suitable for this
> usecase.
>=20
>>=20

Can you elaborate? MADV_FREE is destructive, just like a delayed MADV_DONTNE=
ED. How would that help here?

>>>>=20
>>>> --
>>>> Thanks,
>>>>=20
>>>> David / dhildenb
>>>>=20
>>>=20
>>=20
>=20

