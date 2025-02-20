Return-Path: <linux-kselftest+bounces-27089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17147A3E085
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 17:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03A3189BE0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F591FF5FE;
	Thu, 20 Feb 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yU+jcc7g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED01F1521
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068532; cv=none; b=bVyLf+qjYpJYybUhoNU8dHw2+eqU4KGw+jCZly74HV+2R+5OqV4mEq53si7K2vEtOGu1D545anWueBvZ2/WUplcUpxndpmkVZHmz/5oL/BzhueH17zCoLTAHu1wN8y5uLQ55w2iK/JE6zCJDQoDTOuTK78AZYxHTrEMb9BMbAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068532; c=relaxed/simple;
	bh=C5RWv4Oht+LsTsTvLtn0X1kIsGJ2QBZ4Q1SHZfo5328=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoyUIdZRoNLQSMMiPX4yCdxgvipt2WwpQxZhQT+6KWNetbN+r0WM6f2qeskD2mBv9aXBWK8x3alhVapsIlUI//SuncwJZ+wgAHGMRgr96bfXAE6XSh33YwhuRn/t6YvtwfPtjAfktRCdwsKuN4EHFiSXIZd7gdc/5Vi6lP3TIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yU+jcc7g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so53945e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740068529; x=1740673329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5RWv4Oht+LsTsTvLtn0X1kIsGJ2QBZ4Q1SHZfo5328=;
        b=yU+jcc7gTJr2wnn5KigsB351k4YK/gJ7mjSAKHBWWPF9YiCTSoubdNnxAZlN5rHfQs
         /Fg4cGMpMy0fvOeVyZ77Ze0euGebUDhvgYvcfuqT4FKhcLebRuScwWp37mc63NXXQJV0
         mmL3D0Gc1h/oTps1goBLL3D8kJ3i4T1M7qON3wo4/8x0g6UK9H/jFVjf3k78c9ekB2YE
         S/Y5/b+Zumu2l8Etjk8Lbx6nTi83gOeP370nSSFAHj//wJfU8Z/iKbsBLZuKZ6iVsTzF
         Rlau8swbE4eQwCV+GnJIgFRxlbNjJHeyTDtU7VgC79XtEL/kKOkXaQtT05N2/Wy9EI6i
         sTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068529; x=1740673329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5RWv4Oht+LsTsTvLtn0X1kIsGJ2QBZ4Q1SHZfo5328=;
        b=wSNScTBM/GjSxsEgJJaTKrBiM6leO9cOoFxkobLfAFGkfK0ak8ILq8WJmDNBtbMZQV
         QdLGWv2j1Qh5M8KHqeQIPx9SYEuI9ZHVlfB9HNu8lKfwNulyQtjqku4LK9SOMcUpwymH
         rk7PDErpRbkMbalY4Tyzf3E2nVXaYcoWGbqWCxz0yyIFQf4JZnZUxdow2ZbhwYNQ/Lg2
         w2NYH/D1Bf+sXPfa/Bv4fHKGObTw7OkJpOH7TqB1FtvVsoGh6FhnJqogjZVrPQ2PzXQF
         WcQD/tQnG7cqjBBq/2Ktth+jzWNc/olA4VH2Qlhsi4qEE5A16mAjhmenTh8mVbIkCx6I
         Nu5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdQYZxSPrDhJwud7D9KMD4c4EOc/+AOYkUnsCM+L3uqFCQ93dg/poq0nZigd/IVTuVmQbaJPRcQsVfK+ysmgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3b9fMP5s2+MKVCblrupA7tgF8ogyyO00pxMRAeLUsaM5W5D+
	ALQKwrf1BclIjHdq9FwH+Y75KJSCK375V3485xFjSqWmrnIox3UwJfd+8czNKT6EaO41atfpPdr
	i29a2iA6FqTwnSkVzaCU9Z8JBZjJHc3kO9zkr
X-Gm-Gg: ASbGncvngHXQed/A7o+mEGrOUHUN1VNx1K4JsNztZrjMMHHm5CRYP6OKoarHtdSgixh
	+jPYXgvnsPsdSkOrIYiaGuvP9u3UdmalAMNKUMru8OjpRuBpcIZHvnLEyO14hE3SMX/UiIzx7
X-Google-Smtp-Source: AGHT+IEOrIguQcBOjXWtiHCKwopXN+WtboolRWXtVmDAQGp+1Z6t0KvSTIc5/WYVKx9BFIkZehap41ICQaQzIQ/Xh1c=
X-Received: by 2002:a05:600c:210f:b0:439:7fc2:c7ad with SMTP id
 5b1f17b1804b1-439a4767feamr1201225e9.7.1740068528532; Thu, 20 Feb 2025
 08:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local> <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local> <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
 <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local> <4f5a9c19-9bdd-47eb-bb14-205e3dcced90@redhat.com>
 <1e959451-2534-44b7-bf62-bc75305048fe@lucifer.local> <bd4597b5-2da2-484c-9410-384e04336a9d@redhat.com>
 <31a007c0-884f-495d-ba27-08e3e0dd767d@lucifer.local>
In-Reply-To: <31a007c0-884f-495d-ba27-08e3e0dd767d@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 20 Feb 2025 08:21:54 -0800
X-Gm-Features: AWEUYZmUc3XJIdBmrSxEVAYvHGFXnZ-DZGtTP2XuTCRhGTOphXLfooYmt5dVI1Y
Message-ID: <CAJuCfpHpchh0CzEgh5CKmRLwpscBLx32A-mGi4eudpir1wm=cQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 5:18=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Feb 20, 2025 at 01:44:20PM +0100, David Hildenbrand wrote:
> > On 20.02.25 11:15, Lorenzo Stoakes wrote:
> > > On Thu, Feb 20, 2025 at 11:03:02AM +0100, David Hildenbrand wrote:
> > > > > > Your conclusion is 'did not participate with upstream'; I don't=
 agree with
> > > > > > that. But maybe you and Kalesh have a history on that that let'=
s you react
> > > > > > on his questions IMHO more emotionally than it should have been=
.
> > > > >
> > > > > This is wholly unfair, I have been very reasonable in response to=
 this
> > > > > thread. I have offered to find solutions, I have tried to underst=
and the
> > > > > problem in spite of having gone to great lengths to try to discus=
s the
> > > > > limitations of the proposed approach in every venue I possibly co=
uld.
> > > > >
> > > > > I go out of my way to deal professionally and objectively with wh=
at is
> > > > > presented. Nothing here is emotional. So I'd ask that you please =
abstain
> > > > > from making commentary like this which has no basis.
> > > >
> > > > I appreciate everything you write below. But this request is just
> > > > impossible. I will keep raising my opinion and misunderstandings wi=
ll
> > > > happen.
> > >
> > > Well I wouldn't ask you not to express your opinion David, you know I=
 respect
> > > and like you, and by all means push back hard or call out what you th=
ink is bad
> > > behaviour :)
> > >
> > > I just meant to say, in my view, that there was no basis, but I appre=
ciate
> > > miscommunications happen.
> > > > So apologies if I came off as being difficult or rude, it actually
> > wasn't
> > > intended. And to re-emphasise - I have zero personal issue with anybo=
dy in this
> > > thread whatsoever!
> >
> > It sounded to me like you were trying to defend your work (again, IMHO =
too
> > emotionally, and I might have completely misinterpreted that) and slowl=
y
> > switching to "friendly fire" (towards me). Apologies from my side if I
> > completely misunderstood/misinterpreted that.
>
> Right this was not at all my intent, sorry if it seemed that way. I may w=
ell
> have communicated terribly, so apologies on my side too.

Sorry for being late to the party. Was sick for a couple of days.
Lorenzo is right, there was a breakdown in communication at Google and
he has all the rights to be upset. The issue with obfuscators should
have been communicated once it was discovered. I was in regular
discussions with Lorenzo but wasn't directly involved with this
particular project and wasn't aware or did not realize that the
obfuscator issue renders guards unusable for this usecase. My
apologies, I should have asked more questions about it. I suspect
Lorenzo would have implemented this anyway...

To make guard regions work for this usecase, first we (Android) need
to abstract /proc/pid/maps accesses. Only then we can use additional
interfaces like /proc/pid/pagemaps to obtain guard region information.
I'll start figuring out what it takes to insert such an abstraction.
Thanks,
Suren.


>
> >
> > To recap: what we have upstream is great; you did a great job. Yes, the
> > mechanism has its drawbacks, but that's just part of the design.
>
> Thanks :)
>
> >
> > Some people maybe have wrong expectations, maybe there were
> > misunderstandings, or maybe there are requirements that only now pop up=
;
> > it's sometimes unavoidable, and that's ok.
> >
> > We can try to document it better (and I was trying to find clues why pe=
ople
> > might be mislead), and see if/how we could sort out these requirements.=
 But
> > we can likely not make it perfect in any possible way (I'm sure there a=
re
> > plenty of use cases where what we currently have is more than sufficien=
t).
>
> Sure and I"m very open to adding a documentation page for guard regions, =
in
> fact was considering this very thing recently. I already added man pages
> but be good to be able to go into more depth.
>
> >
> > > > I just want to find the best way forward, technically and am willin=
g to
> > do
> > > whatever work is required to make the guard region implementation as =
good as it
> > > possibly can be.
> > >
> > > >
> > > > Note that the whole "Honestly David you and the naming. .." thing c=
ould have
> > > > been written as "I don't think it's a naming problem."
> > >
> > > I feel like I _always_ get in trouble when I try to write in a 'tongu=
e-in-cheek'
> > > style, which is what this was meant to be... so I think herein lies t=
he basis of
> > > the miscommunication :)
> > >
> > > I apologise, the household is ill, which maybe affects my judgment in=
 how I
> > > write these, but in general text is a very poor medium. It was meant =
to be said
> > > in a jolly tone with a wink...
> > >
> > > I think maybe I should learn my lesson with these things, I thought t=
he ':p'
> > > would make this clear but yeah, text, poor medium.
> > >
> > > Anyway apologies if this seemed disrespectful.
> >
> > No worries, it's hard to really make me angry, and I appreciate your
> > openness and your apology (well, and you and your work, obviously).
> >
> > I'll note, though, if my memory serves me right, that nobody so far eve=
r
> > criticized the way I communicate upstream, or even told me to abstain f=
rom
> > certain communication.
>
> I wish I could say the same haha, so perhaps this was a problem on my sid=
e
> honestly. I do have a habit of being 'tongue in cheek' and failing to
> communicate that which I did say the last time I wouldn't repeat. It is n=
ot
> intended, I promise.
>
> As the abstain, was more a British turn of phrase, meaning to say - I
> dispute the claim that this is an emotional thing and please don't say th=
is
> if it isn't so.
>
> But I understand that of course, you may have interpreted it as so, due t=
o
> my having failed to communicate it well.
>
> Again, I must say, text remains replete with possibilities for
> miscommunication, misunderstanding and it can so often be difficult to
> communicate one's intent.
>
> But again of course, I apologise if I overstepped the line in any way!
>
> >
> > That probably hurt most, now that a couple of hours passed. Nothing tha=
t a
> > couple of beers and a bit of self-reflection on my communication style =
can't
> > fix ;)
>
> Ugh sorry, man. Not my intent. And it seems - I literally OWE YOU pints
> now. :) we will fix this at lsf...
>
> Perhaps owe Kalesh some too should he be there... will budget
> accordingly... :P
>
> >
> > [...]
> >
> > > > > > > Yeah that's a good point, but honestly if you're reading smap=
s that reads
> > > > > > > the page tables, then reading /proc/$pid/pagemaps and reading=
 page tables
> > > > > > > TWICE that seems inefficient vs. just reading /proc/$pid/maps=
, then reading
> > > > > > > /proc/$pid/pagemaps and reading page tables once.
> > > > > >
> > > > > > Right; I recently wished that we would have an interface to obt=
ain more VMA
> > > > > > flags without having to go through smaps
> > > > >
> > > > > Well maybe that lends itself to the idea of adding a whole new in=
terface in
> > > > > general...
> > > >
> > > > An extended "maps" interface might be reasonable, that allows for e=
xposing
> > > > more things without walking the page tables. (e.g., flags)
> > > >
> > > > Maybe one could have an indicator that says "ever had guard regions=
 in this
> > > > mapping" without actually walking the page tables.
> > >
> > > Yeah this is something we've discussed before, but it's a little frau=
ght. Let's
> > > say it was a VMA flag, in this case we'd have to make this flag 'stic=
ky' and not
> > > impact merging (easy enough) to account for splits/merges.
> > > > The problem comes in that we would then need to acquire the VMA wri=
te
> > lock to do
> > > it, something we don't currently require on application of guard regi=
ons.
> >
> > Right, and we shouldn't write-lock the mmap. We'd need some way to just
> > atomically set such an indicator on a VMA.
>
> Hm yeah, could be tricky, we definitely can't manage a new field in
> vm_area_struct, this is a very sensitive subject at the moment really wit=
h
> Suren's work with VMAs allocated via SLAB_TYPESAFE_BY_RCU, putting the lo=
ck
> into the VMA and the alignment requirements.
>
> Not sure what precedent we'd have with atomic setting of a VMA flag for
> this... could be tricky.
>
> >
> > I'll also note that it might be helpful for smallish region, but especi=
ally
> > for large ones (including when they are split and the indicator is wron=
g),
> > it's less helpful. I don't have to tell you about the VMA merging
> > implications, probably it would be like VM_SOFTDIRTY handling :)
>
> Yeah indeed now we've simplified merging a lot of possibilities emerge,
> this is one!
>
> >
> > >
> > > We'd also have to make sure nothing else makes any assumptions about =
VMA flags
> > > implying differences in VMAs in this one instance (though we do alrea=
dy do this
> > > for VM_SOFTDIRTY).
> > >
> > > I saw this as possibly something like VM_MAYBE_GUARD_REGIONS or somet=
hing.
> >
> > Yes.
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
>
> Best, Lorenzo

