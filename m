Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7F631AFF4
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Feb 2021 11:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhBNKA3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Feb 2021 05:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhBNKAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Feb 2021 05:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613296735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FB1Zi7Y2SkOv/JvlFfpIv8DdC9H5NuowZUsuUzsgYnw=;
        b=fad4dWRm90PFswTbJv9iB9qi1jJhfRMe61awqZs1ietSewBteDCq5TGY+aozecZ2lHLZrm
        WV/23VXrLqLZMwGpuWSuBwNI5sf4S/zzZ9UxNxqExEWqRG4WccX7F0naK4jzhiVObtfZte
        XsoYCVyAxcontsUVJ3GbOhQ2cJeStLo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-1fxlIBbDN12eZjEivYgBLw-1; Sun, 14 Feb 2021 04:58:54 -0500
X-MC-Unique: 1fxlIBbDN12eZjEivYgBLw-1
Received: by mail-wr1-f69.google.com with SMTP id l10so6162837wry.16
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Feb 2021 01:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FB1Zi7Y2SkOv/JvlFfpIv8DdC9H5NuowZUsuUzsgYnw=;
        b=bQV0IrlqXYQRclDQDXiW3KUw0sXqCKLPhgML7xF8EiIyy6zEDiSqbqYQ2x9fYy0/vH
         7xdcD9OHJouYZtUsRmFkBinFpKXYhZu6qHOt/eRxm4uXdNLSsk0TeEOeFRIICwO6bi62
         P1FyH9xA+6kzT6hIH3nyexPsi+zxp/qLEGVaztp6GpGiXFhII7S70hJPtZw6HSuaGPpP
         3j8ULzxhZVTwNLOXaDC/za42eYo1PVOpxBeVtcKbsd6ae0/Ns/yXfz1+Xv1GHKK7nQkk
         VCOPglQA78wzvGS0fkCpVs3EK//A0zuY5Yq6hFmQgcqYH5e3i1q9vNdLCqOzkj7CO/YY
         U3oA==
X-Gm-Message-State: AOAM533snGkADImb8Od0dfZUYS+XgiinV40+SSvCDe2LjetfugM2GNDm
        RQHvhVzTV9wzhVLfXVtN1pUBnoBV8YljkDtcPII3kF5ZI6GiMreidpuPKeVHCG4dhJQR3IzmLKo
        wgXGbpAu00PIhNkHMd5nESsNVZ7Bv
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr9687107wmk.163.1613296732936;
        Sun, 14 Feb 2021 01:58:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6AiGKsLxdVOEv3lcfmH3b0B76nApmRsRYcgYL0hyAbXvIT8wdTN/HlT3/mJBi3lug6LzkMg==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr9687058wmk.163.1613296732697;
        Sun, 14 Feb 2021 01:58:52 -0800 (PST)
Received: from [192.168.3.108] (p4ff23363.dip0.t-ipconnect.de. [79.242.51.99])
        by smtp.gmail.com with ESMTPSA id x15sm18554557wro.66.2021.02.14.01.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 01:58:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to create "secret" memory areas
Date:   Sun, 14 Feb 2021 10:58:44 +0100
Message-Id: <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
References: <20210214091954.GM242749@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
In-Reply-To: <20210214091954.GM242749@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> Am 14.02.2021 um 10:20 schrieb Mike Rapoport <rppt@kernel.org>:
>=20
> =EF=BB=BFOn Fri, Feb 12, 2021 at 10:18:19AM +0100, David Hildenbrand wrote=
:
>>> On 12.02.21 00:09, Mike Rapoport wrote:
>>> On Thu, Feb 11, 2021 at 01:07:10PM +0100, David Hildenbrand wrote:
>>>> On 11.02.21 12:27, Mike Rapoport wrote:
>>>>> On Thu, Feb 11, 2021 at 10:01:32AM +0100, David Hildenbrand wrote:
>>>>=20
>>>> So let's talk about the main user-visible differences to other memfd fi=
les
>>>> (especially, other purely virtual files like hugetlbfs). With secretmem=
:
>>>>=20
>>>> - File content can only be read/written via memory mappings.
>>>> - File content cannot be swapped out.
>>>>=20
>>>> I think there are still valid ways to modify file content using syscall=
s:
>>>> e.g., fallocate(PUNCH_HOLE). Things like truncate also seems to work ju=
st
>>>> fine.
>>> These work perfectly with any file, so maybe we should have added
>>> memfd_create as a flag to open(2) back then and now the secretmem file
>>> descriptors?
>>=20
>> I think open() vs memfd_create() makes sense: for open, the path specifie=
s
>> main properties (tmpfs, hugetlbfs, filesystem). On memfd, there is no suc=
h
>> path and the "type" has to be specified differently.
>>=20
>> Also, open() might open existing files - memfd always creates new files.
>=20
> Yes, but still open() returns a handle to a file and memfd_create() return=
s
> a handle to a file. The differences may be well hidden by e.g. O_MEMORY an=
d
> than features unique to memfd files will have their set of O_SOMETHING
> flags.
>=20

Let=E2=80=98s agree to disagree.

> It's the same logic that says "we already have an interface that's close
> enough and it's fine to add a bunch of new flags there".

No, not quite. But let=E2=80=98s agree to disagree.

>=20
> And here we come to the question "what are the differences that justify a
> new system call?" and the answer to this is very subjective. And as such w=
e
> can continue bikeshedding forever.

I think this fits into the existing memfd_create() syscall just fine, and I h=
eard no compelling argument why it shouldn=E2=80=98t. That=E2=80=98s all I c=
an say.=

