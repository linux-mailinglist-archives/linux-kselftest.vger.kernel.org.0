Return-Path: <linux-kselftest+bounces-44559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31147C272BB
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 00:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EDB3B08DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 23:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753AD32A3DE;
	Fri, 31 Oct 2025 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkN8RXiA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA11329E52
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761952385; cv=none; b=nZN/bnbljydBZlXaf43T2GEc/3/j0yO/ee58p14g/FTZry2mFkPoIQL1RBd7A8QEsgYOs2eveHYgRGpJDM3aWlWNjKGsrPmICM/nXlev9WU8wv1wUdTxaqIY3zL9oLS9BTZ68DlpXAfKBmEpUzdC2Bdyh5THz/3PymiSoaQzMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761952385; c=relaxed/simple;
	bh=gY82JgAv1A8rYj9MCaiZVHVrEMWrbrCoiDwppP0oGWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoCPc3jcmMnh0lAqhva+7sdpYJ4bcnvULtSW9YNcXSD6bmszP5elDWrmyzlSAisLGaX0VN5C8VN4+yVvrKJWjDwf+jAxUc75dMI3cYF2L4o+3N3tXX0KCLwflbcBstl88HWzahAPhn0QEi2l9XwGTZVkd+fLf4wR0O9NCj9CXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkN8RXiA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ea12242d2eso82021cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761952382; x=1762557182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY82JgAv1A8rYj9MCaiZVHVrEMWrbrCoiDwppP0oGWg=;
        b=pkN8RXiAjdXxo7BRN5+terCdOCJFnliS5crjawRNQ5x3UOuShVrfTVS7/ndcHb9rK5
         XPJ77kaAfE9BoNEsCAXr+3d7DjfbmCPZOQqZf+0sLjvImi4VgycqCUfkOtLOAmTdrDqM
         3Bv9NiHCI/pUxNMCL0SOrzD13yYc80M8iJDj/Pn7SZ3hbTAkVzseB+I44xaHwZHA25UG
         b+hXRc179Gp9+IkCuj9XXiHOpqoqvqHp3E5Ukq/gnBpfTc2s78WdqUj0cUM4lPrlaEwI
         mHUfMlzOadgUghqvFM4HClQq/fB5XEAjzx7T87V82BTE+F1ZZ4+GhbaYdFyLbY/HG3NT
         Ad3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761952382; x=1762557182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gY82JgAv1A8rYj9MCaiZVHVrEMWrbrCoiDwppP0oGWg=;
        b=JDMrPRdvufsRmmst5R6wIKOUawabwJrA0+mEKC776BGh3smxui0lfFxCTJfrXSEiRC
         K8ChLhLmuexh71okiY8lk2j/Qhu1YqUW7kseVLZl+2+tfBtY9Hx4NbzP0i4YAkj/84lb
         947gZhl5vM7zoFnJ9KnqbUTFMxuz3eR1h77uF8lgfW9FbiNP0e0RXnPXwPH1xM8f4j+/
         4nZJFQyPKyE73IzcVCYYlB592qHtEkUpOoIcqAXc/iqEUmW2BuDmgyd7+Q7W/h62skCG
         O8kw4lYSrOuWBxsrAFJNsUL5OX3ezAMKJLVRIYsDpx1Oq/N1thOS7wht6CtJIjItnjje
         BaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxKfqS8sm/RUkCA5jecrXMttRkoTqQBZNk1KINY0dqpdqdWVEFz2/NrJrJE2tIghbP9zZiYO9zrmIgrCOqDvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyML+qa/OjddlX8ZSvcpuchcf9USWuJM0nTyLpVqSOwRYOtpCTu
	ofqUldcVFTe1esPRaxI9mPryEYL1JTQlWzijCZzCtxHYevmdsVWOV5TDEKf2h7yNqNK+DATgv16
	6Bb2m7deXlCy9nzCgillk46yYmWp+YJAnfXjvDAVU
X-Gm-Gg: ASbGncvw7P20eLU5dXVev1mUdpcDKuUwcVs7QFbxDtTdNBmq97o+skAdDRXtBhTtApt
	nzFPZGfR7Pc9YYj/epRGIi/lLjI/9tgbwJ6Kxm5cUyelRycUuqROXdH4vqTd3I5k0sfpw6WYtsf
	yXFzzcl2PpfgFL7rOW4P1B7/b21WAduteuRxHkDIn5Z6JVNCzKyIbVWN9R6cpc2JgrfuBudFmoj
	S0mR8TCbyN/BXT9ZZwNvNQ6POWGYfglKnrSWlk7O0B9rVNvKdagq9PvlLA=
X-Google-Smtp-Source: AGHT+IENbX2I9QLWCzbGqCz+aeN8c925eFyi708BVOjF22TIfxJHEaH3VCvZrnHqn6i5au9Z3HH9DEYcpuxXzSR6lhg=
X-Received: by 2002:a05:622a:1991:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4ed424d7c14mr1098221cf.11.1761952382100; Fri, 31 Oct 2025
 16:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local> <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
 <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local> <72ee2324-d599-44b6-92ce-ed0afafed78f@suse.cz>
 <3ae457cd-6c18-4870-a617-7f937b107cb4@suse.cz> <88b72728-fa3f-4a70-9ea2-40ff50673047@lucifer.local>
 <a3bcac19-78b7-4918-81b3-641a65a19a9d@suse.cz>
In-Reply-To: <a3bcac19-78b7-4918-81b3-641a65a19a9d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 31 Oct 2025 16:12:51 -0700
X-Gm-Features: AWmQ_bnVgpHA3Q0hYHvJgIIm_FpBFlpB9mdVzh6mL8zZeBp2jS4PiSvnDoBUG6c
Message-ID: <CAJuCfpEs1JTywfZNPrVmeTHUUyK+7waCU9fqfur2Q_xxx7hacw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Pedro Falcato <pfalcato@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrei Vagin <avagin@gmail.com>, Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 2:48=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/30/25 20:47, Lorenzo Stoakes wrote:
> > On Thu, Oct 30, 2025 at 07:47:34PM +0100, Vlastimil Babka wrote:
> >> >
> >> > Could we use MADVISE_VMA_READ_LOCK mode (would be actually an improv=
ement
> >> > over the current MADVISE_MMAP_READ_LOCK), together with the atomic f=
lag
> >> > setting? I think the places that could race with us to cause RMW use=
 vma
> >> > write lock so that would be excluded. Fork AFAICS unfortunately does=
n't (for
> >> > the oldmm) and it probably would't make sense to start doing it. May=
be we
> >> > could think of something to deal with this special case...
> >>
> >> During discussion with Pedro off-list I realized fork takes mmap lock =
for
> >> write on the old mm, so if we kept taking mmap sem for read, then vma =
lock
> >> for read in addition (which should be cheap enough, also we'd only nee=
d it
> >> in case VM_MAYBE_GUARD is not yet set), and set the flag atomicaly, pe=
rhaps
> >> that would cover all non-bening races?
> >>
> >>
> >
> > We take VMA write lock in dup_mmap() on each mpnt (old VMA).
>
> Ah yes I thought it was the new one.
>
> > We take the VMA write lock (vma_start_write()) for each mpnt.
> >
> > We then vm_area_dup() the mpnt to the new VMA before calling:
> >
> > copy_page_range()
> > -> vma_needs_copy()
> >
> > Which is where the check is done.
> >
> > So we are holding the VMA write lock, so a VMA read lock should suffice=
 no?
>
> Yeah, even better!
>
> > For belts + braces we could atomically read the flag in vma_needs_copy(=
),
> > though note it's intended VM_COPY_ON_FORK could have more than one flag=
.
> >
> > We could drop that for now and be explicit.
>
> Great!

Overall, I think it should be possible to set this flag atomically
under VMA read-lock. However, if you introduce new vm_flags
manipulation functions, please make sure they can't be used for other
vm_flags. In Android I've seen several "interesting" attempts to
update vm_flags under a read-lock (specifically in the page-fault
path) and had to explain why that's a bad idea.

