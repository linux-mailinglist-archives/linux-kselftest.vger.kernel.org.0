Return-Path: <linux-kselftest+bounces-1263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 725E3806C4F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006EA1F21486
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32B22E3F3;
	Wed,  6 Dec 2023 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZA0JY6sY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B71B5
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 02:39:52 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db7d198e791so3859044276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 02:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701859191; x=1702463991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQdifr2abX3HSlYGNn9HZ0F9hnYIWmyEvcln+QnyZu0=;
        b=ZA0JY6sYzQ/jma2tyO02AcQA7bVyW6bB2WA00xr1dxomv8CTzVw9lCIAJu3BEWSiHt
         4B7ZHctwldguKE6PEK9VfadO8oZ2KrQsSMzEEHSN7EgMIpJjgqaMdzMtGyZq7+ZKW2hs
         G2m+o1q241/t1Q9Rq9KG5dq6VQwU4DkV9HuQnLMzh+Y177kuxgwTmoocyNK/qtn0m1+F
         t92gf18JDNn3eUisFoH/WYKPXll7WXeg2qtd4PmMgTfDMv9+cwwqw7ITtwdCO8NDwx9y
         3GXJYEedk056RgRkY1cLYo3qiAg6sZF1Nlb6o2TK0phsa1ld6jg8/6JjNZayj9qtD50x
         61Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859191; x=1702463991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQdifr2abX3HSlYGNn9HZ0F9hnYIWmyEvcln+QnyZu0=;
        b=Vlw8AOfwpSXuirBuKHIpfqsYPzDendTR9wPx2O9QdPxY95CNB9O57H5cEmsaB0K6RE
         fmjJYEOOX9yyti2Me/iJ7geD4TRY3/wH1d8e9/Yp/dmtBRBDQBNm1uKgaj71qdUVRGYu
         xy5PRiGMxUj+UjUGLSYEORbPjlxV5O1mWWukJU1nrWOhxszsxIuFa1c4jMdXNS0xBRRI
         WJHdpzH1rFbltZQg1BmcL7erNJpAwqfJpfudZshfhciuJLlEYzOw64AcSns7NusVaS3+
         6s/AEUD9wm0YK6DMATFxziaWnm6YAn6FqtRc6K71yCCsh4DXUTpKY6/xn6u79nIN69Up
         2OFg==
X-Gm-Message-State: AOJu0YxicAIa9LE8b0D0JfsXl2szLnNvhBryMTb+CkKwjNcAzMMbq47L
	5CkjzX4Rd8tRZXnSUWd4zEDlFHGKHYrV+oUMrGqpYQ==
X-Google-Smtp-Source: AGHT+IER7xjB5IRLvMGcDEKuvEKxXZVwGUfdzV3VDT1Vsv/pO4A7HLd5GLlUs6A0WBOd00lfCGHWzJj94wiAk/VID7E=
X-Received: by 2002:a25:1c2:0:b0:db7:dacf:4d65 with SMTP id
 185-20020a2501c2000000b00db7dacf4d65mr262941ybb.97.1701859190881; Wed, 06 Dec
 2023 02:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com> <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com> <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
 <cb3d3b12-abf3-4eda-8d9a-944684d05505@arm.com> <ccdb1080-7a2e-4f98-a4e8-e864fa2db299@redhat.com>
 <CAJuCfpHS63bXkRGE1_G4z-2fDe72BeLka8t5ioSg2OXjbUrHXg@mail.gmail.com>
 <744be4e0-48e0-4c77-825c-711386dd205f@arm.com> <CAJuCfpHpbz4fWawmYU=B1D5pPE4+x0Wj0V-514Dja9UWcwiL9A@mail.gmail.com>
 <a52284a4-2b8c-4118-965d-04c472fbee05@redhat.com> <CAJuCfpEbxPksw3WtLWRT9mmGUCSZ431E4vaWMtbu8OrXmMxCdw@mail.gmail.com>
 <CAJuCfpG=seLkKbMRjwuWNQozGSQmP-JqKVUuCGRqMqxND2u18A@mail.gmail.com>
 <3ba0015b-b36e-449a-8445-0f6272694db5@redhat.com> <CAJuCfpFPtbZuD53o+jOac97qA6MnK4jTEe5qNrZsH5v-m62oZA@mail.gmail.com>
In-Reply-To: <CAJuCfpFPtbZuD53o+jOac97qA6MnK4jTEe5qNrZsH5v-m62oZA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Dec 2023 02:39:39 -0800
Message-ID: <CAJuCfpHpDKfqHPuxfy1trbeM0LaEGT3J3gH6+2X4+b6-F5fO1Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: akpm@linux-foundation.org
Cc: David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com, 
	lokeshgidra@google.com, peterx@redhat.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 2:30=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Dec 6, 2023 at 1:21=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 05.12.23 05:46, Suren Baghdasaryan wrote:
> > > On Mon, Dec 4, 2023 at 10:44=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > >>
> > >> On Mon, Dec 4, 2023 at 10:27=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> > >>>
> > >>> On 04.12.23 17:35, Suren Baghdasaryan wrote:
> > >>>> On Mon, Dec 4, 2023 at 1:27=E2=80=AFAM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> > >>>>>
> > >>>>> On 04/12/2023 04:09, Suren Baghdasaryan wrote:
> > >>>>>> On Sat, Dec 2, 2023 at 2:11=E2=80=AFAM David Hildenbrand <david@=
redhat.com> wrote:
> > >>>>>>>
> > >>>>>>> On 02.12.23 09:04, Ryan Roberts wrote:
> > >>>>>>>> On 01/12/2023 20:47, David Hildenbrand wrote:
> > >>>>>>>>> On 01.12.23 10:29, Ryan Roberts wrote:
> > >>>>>>>>>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
> > >>>>>>>>>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move=
 source
> > >>>>>>>>>>> into destination buffer while checking the contents of both=
 after
> > >>>>>>>>>>> the move. After the operation the content of the destinatio=
n buffer
> > >>>>>>>>>>> should match the original source buffer's content while the=
 source
> > >>>>>>>>>>> buffer should be zeroed. Separate tests are designed for PM=
D aligned and
> > >>>>>>>>>>> unaligned cases because they utilize different code paths i=
n the kernel.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >>>>>>>>>>> ---
> > >>>>>>>>>>>      tools/testing/selftests/mm/uffd-common.c     |  24 +++
> > >>>>>>>>>>>      tools/testing/selftests/mm/uffd-common.h     |   1 +
> > >>>>>>>>>>>      tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++=
++++++++++++++++
> > >>>>>>>>>>>      3 files changed, 214 insertions(+)
> > >>>>>>>>>>>
> > >>>>>>>>>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
> > >>>>>>>>>>> b/tools/testing/selftests/mm/uffd-common.c
> > >>>>>>>>>>> index fb3bbc77fd00..b0ac0ec2356d 100644
> > >>>>>>>>>>> --- a/tools/testing/selftests/mm/uffd-common.c
> > >>>>>>>>>>> +++ b/tools/testing/selftests/mm/uffd-common.c
> > >>>>>>>>>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long o=
ffset, bool wp)
> > >>>>>>>>>>>          return __copy_page(ufd, offset, false, wp);
> > >>>>>>>>>>>      }
> > >>>>>>>>>>>      +int move_page(int ufd, unsigned long offset, unsigned=
 long len)
> > >>>>>>>>>>> +{
> > >>>>>>>>>>> +    struct uffdio_move uffdio_move;
> > >>>>>>>>>>> +
> > >>>>>>>>>>> +    if (offset + len > nr_pages * page_size)
> > >>>>>>>>>>> +        err("unexpected offset %lu and length %lu\n", offs=
et, len);
> > >>>>>>>>>>> +    uffdio_move.dst =3D (unsigned long) area_dst + offset;
> > >>>>>>>>>>> +    uffdio_move.src =3D (unsigned long) area_src + offset;
> > >>>>>>>>>>> +    uffdio_move.len =3D len;
> > >>>>>>>>>>> +    uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> > >>>>>>>>>>> +    uffdio_move.move =3D 0;
> > >>>>>>>>>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> > >>>>>>>>>>> +        /* real retval in uffdio_move.move */
> > >>>>>>>>>>> +        if (uffdio_move.move !=3D -EEXIST)
> > >>>>>>>>>>> +            err("UFFDIO_MOVE error: %"PRId64,
> > >>>>>>>>>>> +                (int64_t)uffdio_move.move);
> > >>>>>>>>>>
> > >>>>>>>>>> Hi Suren,
> > >>>>>>>>>>
> > >>>>>>>>>> FYI this error is triggering in mm-unstable (715b67adf4c8):
> > >>>>>>>>>>
> > >>>>>>>>>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (e=
rrno=3D16,
> > >>>>>>>>>> @uffd-common.c:648)
> > >>>>>>>>>>
> > >>>>>>>>>> I'm running in a VM on Apple M2 (arm64). I haven't debugged =
any further, but
> > >>>>>>>>>> happy to go deeper if you can direct.
> > >>>>>>>>>
> > >>>>>>>>> Does it trigger reliably? Which pagesize is that kernel using=
?
> > >>>>>>>>
> > >>>>>>>> Yep, although very occasionally it fails with EAGAIN. 4K kerne=
l; see other email
> > >>>>>>>> for full config.
> > >>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fau=
lt() uses
> > >>>>>>>>> default_huge_page_size(), which reads the default hugetlb siz=
e.
> > >>>>>>>>
> > >>>>>>>> My kernel command line is explicitly seting the default huge p=
age size to 2M.
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> Okay, so that likely won't affect it.
> > >>>>>>>
> > >>>>>>> I can only guess that it has to do with the alignment of the vi=
rtual
> > >>>>>>> area we are testing with, and that we do seem to get more odd p=
atterns
> > >>>>>>> on arm64.
> > >>>>>>>
> > >>>>>>> uffd_move_test_common() is a bit more elaborate, but if we alig=
ned the
> > >>>>>>> src+start area up, surely "step_count" cannot be left unmodifie=
d?
> > >>>>>>>
> > >>>>>>> So assuming we get either an unaligned source or an unaligned d=
st from
> > >>>>>>> mmap(), I am not convinced that we won't be moving areas that a=
re not
> > >>>>>>> necessarily fully backed by PMDs and maybe don't even fall into=
 the VMA
> > >>>>>>> of interest?
> > >>>>>>>
> > >>>>>>> Not sure if that could trigger the THP splitting issue, though.
> > >>>>>>>
> > >>>>>>> But I just quickly scanned that test setup, could be I am missi=
ng
> > >>>>>>> something. It might make sense to just print the mmap'ed range =
and the
> > >>>>>>> actual ranges we are trying to move. Maybe something "obvious" =
can be
> > >>>>>>> observed.
> > >>>>>>
> > >>>>>> I was able to reproduce the issue on an Android device and after
> > >>>>>> implementing David's suggestions to split the large folio and af=
ter
> > >>>>>> replacing default_huge_page_size() with read_pmd_pagesize(), the
> > >>>>>> move-pmd test started working for me. Ryan, could you please app=
ly
> > >>>>>> attached patches (over mm-unstable) and try the test again?
> > >>>>>
> > >>>>> Yep, all fixed with those patches!
> > >>>>
> > >>>> Great! Thanks for testing and confirming. I'll post an updated
> > >>>> patchset later today and will ask Andrew to replace the current on=
e
> > >>>> with it.
> > >>>> I'll also look into the reasons we need to split PMD on ARM64 in t=
his
> > >>>> test. It's good that this happened and we were able to test the PM=
D
> > >>>> split path but I'm curious about the reason. It's possible my addr=
ess
> > >>>> alignment calculations are  somehow incorrect.
> > >>>
> > >>> I only skimmed the diff briefly, but likely you also want to try
> > >>> splitting in move_pages_pte(), if you encounter an already-pte-mapp=
ed THP.
> > >>
> > >> Huh, good point. I might be able to move the folio splitting code in=
to
> > >> pte-mapped case and do a retry after splitting. That should minimize
> > >> the additional code required. Will do and post a new set shortly.
> > >> Thanks!
> > >
> > > Was planning to post an update today but need some more time. Will tr=
y
> > > to send it tomorrow.
> >
> > It would be great to have tests that cover these cases (having to
> > PTE-map a PMD-mapped THP, and stumbling over an already-PTE-mapped one)=
.
>
> Agree. Let me post the new version so that mm-unstable does not
> produce these failures and will start working on covering additional
> cases in the tests. The new patchset is almost ready, just finishing
> final tests.

Posted v6 at https://lore.kernel.org/all/20231206103702.3873743-1-surenb@go=
ogle.com/.
Changes are listed in the cover letter.

Andrew, could you please replace the current v5 version in mm-unstable
with this new one?
Thanks,
Suren.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

