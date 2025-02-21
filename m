Return-Path: <linux-kselftest+bounces-27204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7408A3FD5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B912A426077
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40D12500BA;
	Fri, 21 Feb 2025 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZ5ZBNUp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0071DC9B0
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158717; cv=none; b=orI3+74mqoAFazjrRewHoMvdEJXsUyl/pNWhmnjVOF+79QvMpWxBda4L89tOjC+QYXSWYD+I0lXIkZNkg3OtwYWcFsYlrqvHOc7Ibljm71G8fkBNJAeML5rfObcxl83dFEKjzoWm58jXqBlp7IERaxHB93AD/uhuUHis9syINSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158717; c=relaxed/simple;
	bh=/ncBsIXZNHpHN0gN+Ld2krKX7WhegguiyI+QveCr+e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiA/eVdkhiiq2kY0UnCI05EoOz0ocAJ+71hZifN+Lhm0LZPuQOD+cNZ8bFWMiUNrOOYVjzMrupGijPW5cTg7jgejvwMml38xR8rfA29OqyPVIyDckVtvwM10qiLwzcwsCEC6yO7nmBGLsv1j9MKVf1o9Yk/W/LJd9fnLea5a5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZ5ZBNUp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so12352a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 09:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740158714; x=1740763514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ncBsIXZNHpHN0gN+Ld2krKX7WhegguiyI+QveCr+e8=;
        b=AZ5ZBNUpPt7nYAbrPdG8nNME1pgo12U3WjlX4QJm3m2sYmW9nGR8+55o3AgpmspCQ/
         i/isPhehOl0erdqPWg8Qcb7FFXx65Jr92bM0YecAtxF3vWgZiFkNP5Yh93AOs7X3+qjM
         iqwNITIhj8gD1gjqDTMj+gntgAb7J9HGgw6a/e1aYMmClKPorHHINamEU54kF76JG+o0
         408hWo6JZFtk8XAKuERTZ+aIB3UQJyLkrvNW2FQHwgTbqSBkwNwTExGRJOn6ySdAvj8u
         lDGxsXko9tXuNDhs2IuQVmqxt8suAO8bUn02s2v6L3+hSARhc1ThE9yMu/kINkV5xYkO
         fJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158714; x=1740763514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ncBsIXZNHpHN0gN+Ld2krKX7WhegguiyI+QveCr+e8=;
        b=qcmU7ea37uOxjc2GWAgC0vHD7pCfocfnonzAY+/VUDG2OEmmk1cdc+g7zMWlDDAJI+
         LQ0NspRMG6uMz7Wu6ae59pRMh1zwr4Wd1J+/GTkZWg6TkDrqM/8EY2RXzpyrPvcYzIue
         2tA/8qtmiY3pqtBN2HAuL0ySq9Ymj/Xdb5zC2DxlODgMmEj8t+EVqJBHXSdJEZHHHP70
         0Riu3MZEvF3ugvwp+Kw7d3kGAiGj/syuGKqVrjARTOP7xeE1RycZ8NCbR12zvy0A1fXm
         MdU+8sjZQPZpv4ZOU+39tv7gj6JNWnDEZOp8c4m6H5zqE/Zr2b+n9BxEnxD2VYnO9ZN8
         pgEA==
X-Forwarded-Encrypted: i=1; AJvYcCXF+bnWua/PlR96O1v7B2FVBLz8T8x6cpLiNh6xed65+IdJI4jJyssvQ1Hi1xcSHUkNAUI69Swm1bAx7oRwU8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhOtsduY9eOZhE5NsSEKqTH4Dp3pwkdCryd5//AvfY/NMj5/n
	a3vTaP0lW1hLGRHPLLXonXaoJrwC3zgXHy7TU4RohnkG8w7W/3jHeei1UnGzFgChBrviPVCAKqx
	TZtcPQprfUXrr8S5yaZ2k5hdAFxcihBzBOa07
X-Gm-Gg: ASbGncuPnryDY+kqUtt6FcZb6GTFfHANpnoroIzeqD9AY7PysQFO0jtgCmkrJ2z+ZXN
	9AZ3DHR6fk5VgtTt4+Y4yVM+uDxQ9xp48DAVdLGqNJrsCjXg0rmBe6rXtkNodGv6m5M8iNMdKiB
	6rMmrbf5M6+RPBPPLiPr1pDuwgdjzJpe4BITD6nQqX
X-Google-Smtp-Source: AGHT+IF/mE/upBZOdr7pG47eeKvsSM7BgM6wQXtyL0HhiPJHpy7IiE39CO8Vv/dnFrDxUC6lHMyPi9HwaDMwaO4ANKM=
X-Received: by 2002:a50:d657:0:b0:5e0:788e:296c with SMTP id
 4fb4d7f45d1cf-5e0b6dedcc7mr116523a12.4.1740158713841; Fri, 21 Feb 2025
 09:25:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local> <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
 <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local> <4f5a9c19-9bdd-47eb-bb14-205e3dcced90@redhat.com>
 <1e959451-2534-44b7-bf62-bc75305048fe@lucifer.local> <bd4597b5-2da2-484c-9410-384e04336a9d@redhat.com>
 <31a007c0-884f-495d-ba27-08e3e0dd767d@lucifer.local> <CAJuCfpHpchh0CzEgh5CKmRLwpscBLx32A-mGi4eudpir1wm=cQ@mail.gmail.com>
 <CAC_TJvd2Y-EnavZkt5_nQUXmRpjo8AYMu6rND7eMUwXn27ab0A@mail.gmail.com> <87bae232-b01d-4962-bbe1-3677b71ff752@lucifer.local>
In-Reply-To: <87bae232-b01d-4962-bbe1-3677b71ff752@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 21 Feb 2025 09:24:59 -0800
X-Gm-Features: AWEUYZnlx1AFsGScoTaTL8obzT8Lj2nGvmv_mtWZZvKaCSW5_GYIYY42YitT7zo
Message-ID: <CAC_TJve7NVqT5atUgdRkFN+U65RY8HYcfXx_CD8rxjra342-Yg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:04=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Feb 20, 2025 at 10:08:36AM -0800, Kalesh Singh wrote:
> > On Thu, Feb 20, 2025 at 8:22=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 5:18=E2=80=AFAM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 01:44:20PM +0100, David Hildenbrand wrote:
> > > > > On 20.02.25 11:15, Lorenzo Stoakes wrote:
> > > > > > On Thu, Feb 20, 2025 at 11:03:02AM +0100, David Hildenbrand wro=
te:
> > > > > > > > > Your conclusion is 'did not participate with upstream'; I=
 don't agree with
> > > > > > > > > that. But maybe you and Kalesh have a history on that tha=
t let's you react
> > > > > > > > > on his questions IMHO more emotionally than it should hav=
e been.
> > > > > > > >
> > > > > > > > This is wholly unfair, I have been very reasonable in respo=
nse to this
> > > > > > > > thread. I have offered to find solutions, I have tried to u=
nderstand the
> > > > > > > > problem in spite of having gone to great lengths to try to =
discuss the
> > > > > > > > limitations of the proposed approach in every venue I possi=
bly could.
> > > > > > > >
> > > > > > > > I go out of my way to deal professionally and objectively w=
ith what is
> > > > > > > > presented. Nothing here is emotional. So I'd ask that you p=
lease abstain
> > > > > > > > from making commentary like this which has no basis.
> > > > > > >
> > > > > > > I appreciate everything you write below. But this request is =
just
> > > > > > > impossible. I will keep raising my opinion and misunderstandi=
ngs will
> > > > > > > happen.
> > > > > >
> > > > > > Well I wouldn't ask you not to express your opinion David, you =
know I respect
> > > > > > and like you, and by all means push back hard or call out what =
you think is bad
> > > > > > behaviour :)
> > > > > >
> > > > > > I just meant to say, in my view, that there was no basis, but I=
 appreciate
> > > > > > miscommunications happen.
> > > > > > > So apologies if I came off as being difficult or rude, it act=
ually
> > > > > wasn't
> > > > > > intended. And to re-emphasise - I have zero personal issue with=
 anybody in this
> > > > > > thread whatsoever!
> > > > >
> > > > > It sounded to me like you were trying to defend your work (again,=
 IMHO too
> > > > > emotionally, and I might have completely misinterpreted that) and=
 slowly
> > > > > switching to "friendly fire" (towards me). Apologies from my side=
 if I
> > > > > completely misunderstood/misinterpreted that.
> > > >
> > > > Right this was not at all my intent, sorry if it seemed that way. I=
 may well
> > > > have communicated terribly, so apologies on my side too.
> >
> > Hi everyone,
> >
> > Thank you for all the discussion.
> >
> > I don't find any personal issues with the communication in this
> > thread, but I appreciate David being the object voice of reason.
> >
> > I understand it can be frustrating since you have made many efforts to
> > communicate these tradeoffs. Unfortunately these issues were not known
> > for the file-backed ELF guard regions for my particular use case.
> >
> > >
> > > Sorry for being late to the party. Was sick for a couple of days.
> > > Lorenzo is right, there was a breakdown in communication at Google an=
d
> > > he has all the rights to be upset. The issue with obfuscators should
> > > have been communicated once it was discovered. I was in regular
> > > discussions with Lorenzo but wasn't directly involved with this
> > > particular project and wasn't aware or did not realize that the
> > > obfuscator issue renders guards unusable for this usecase. My
> > > apologies, I should have asked more questions about it. I suspect
> > > Lorenzo would have implemented this anyway...
> > >
> >
> > Suren's use case is different from mine and this design fits perfectly
> > for anon guard regions from the allocator. :)
> >
> > So I think in conclusion, these aren't VMAs and shouldn't be treated
> > as such; we will advertise them from pagemap for those who need to
> > know.
> >
>
> Thanks Kalesh, glad there were no issues here and we have found
> constructive common ground! :)
>
> It turns out implementing the pagemap side of things is _really_
> straightforward, so I'll be sending a series for that shortly. Hopefully
> this provides some basis for whichever use cases need this information, a=
s
> it is the best and least invasive place for this information at this stag=
e.

Hi Lorenzo,

Reviewed your patches, agreed that is the cleanest way to advertise
this information.

Thanks,
Kalesh

>
> Cheers, Lorenzo
>
> > -- Kalesh

