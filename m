Return-Path: <linux-kselftest+bounces-31936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC9FAA1C58
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26403165EA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE5267714;
	Tue, 29 Apr 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3XptLNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123DB2641DE
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959431; cv=none; b=m9RC4SOjW8Euv8Rl8iy1xVMS16vyaTppQyf3n1br3KftohOE9RXTcaC121Kb6EiuktjB4EemlU/LOhpMRYGoOfLMc9zetV/rLu95jU4XAMH8cdGVcksk5fxmWQTDpea62WNNqzgVlbyay7Inmz6He7n8iaocqnS1V6G6EQaOQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959431; c=relaxed/simple;
	bh=LkyLQBwTJJGrpnl1CxZI8tvol6HSznSH55H78Vjrl60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsWRX+SmchcB/ENXQFljoy4CQfUB4XyoRkXPpdHBqgskiWDh9jDLRPBm6HBzFr/c4stFDUgjKqDWR/FZesSN5pcYVSvtwwB3DCq3tku5KumRBswhmujdtZMpDij9MJFRLuUk5ZtcCDz+SfRQW9OjluBqtlFIW1hT9HiPob3Q0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3XptLNU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so13091a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745959428; x=1746564228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkyLQBwTJJGrpnl1CxZI8tvol6HSznSH55H78Vjrl60=;
        b=E3XptLNUg/wymo+FIfGVkQiWi+w8I8L5TP+SWtfvnvUJFJs+KLhmdczklK2HzZK6gg
         7Y7siAKdD2ZonjAqG0+w9voLPGpm5xHHWzRsDXUhQea87WJhmCXcjxWLx7DjPBIwwBlh
         G9X/X58rOGqgZCsnRC3JkmzGA7xV+qTJ1yD0Pke16W9I2ZNWuzZWFW9i8zgzEqma98R2
         doivSSxy73MT8RuVztlEHeJ0isvIorxXW8GY0ADlKxHhz70S2ZhFX8XvXafX84xg5AKl
         DezH2wJ1WeTGW3tiqZA8kzTqmC+IIUqY5Y6T6KqQpLUv+zOsVi1hM7VDpV3vmqG9LzOq
         KUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745959428; x=1746564228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkyLQBwTJJGrpnl1CxZI8tvol6HSznSH55H78Vjrl60=;
        b=KDA9sXw9LrbgCl3tncsPpMwmt8dOSq79u9lrWzDZCqLhkGjYgX+oWLieIXzOkMH769
         K7TmwqQO2TD5KuzCTT+8ijakQyKzrwtsnS7muZyn9VxllSfTVnk+4WXqpoD+dJiD4QX1
         RJURACBSrx5oLs71rN7wtsenJMCBkLqbGGgqSoMmJoL7sFTsPDVmFBjk29Iz+7DliKsy
         1dSz4ABoyiZXhC566l/qQvOWBQVmvOgOPebK6/SGUE1JRhfGXnRg9TbhgEbppuGJSYfP
         F/HFNeXBVZawyhh1+6m13OnLN9TTGtFfiJS93NonSwL9o0I3AuUTuy54fML/cl/ckj//
         AV2w==
X-Forwarded-Encrypted: i=1; AJvYcCVfZeWGsGNe36YJoQ7qSgHOBHZYp6axGZnJvRIy18OHNx6Lnv3+jpd3vAfNoG9R9A06woo+bkML4BTwlEWEHv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8HDEYcK+klJjGFGPH/Pue4mHEu0z8QHB+lEmzNoHiMNvVNjR
	kk/l2bYVZDiWSzoKX6vHYc622QgqD2vvsiu7VNJf7GdubmJ6tqEeH1LGLEUv3g/TonvL2XsQ6hM
	JiUdWL83jcEBX5fgaglwQczGmu1KGNTPoDxpn
X-Gm-Gg: ASbGncvB6soBeT/eTs0or/ZKKVvKLL6t8Fc6pWA6f65FKWKQUZec2v6m0+oUXlFDmvL
	k1bldr0+pDfyNFWIwF5R2E6BsyhMJnGanIw9VwQcNfmK/dMkKI7vURQeoGy0LrM0zDYF9tT8hsR
	dJNuPtWuMqIlcVRT2pSaUNzwTrUgbbl/z+CiHT0HT6WB52ILEWjA==
X-Google-Smtp-Source: AGHT+IEIgZvYUxouglxxEc1B25bVszxW3uDj1Plpsi1Xo6RrFU9lPw27AjHq3/sFGlfsqKdKORoMM5aPYW2Otdj+c1I=
X-Received: by 2002:a05:6402:1d21:b0:5f6:c48e:82bf with SMTP id
 4fb4d7f45d1cf-5f89409483amr28294a12.0.1745959428013; Tue, 29 Apr 2025
 13:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com>
 <CAJuCfpGGiwTbMeGAeYNtQ5SsFenUw8up6ToLy=VstULM_TSoXA@mail.gmail.com>
 <CAG48ez15g5n9AoMJk1yPHsDCq2PGxCHc2WhCAzH8B2o6PgDwzQ@mail.gmail.com>
 <CAJuCfpG+YjyVE-6TaAQEjwc0iixqN8Epf25jo2awtL=gqY=afA@mail.gmail.com>
 <CAG48ez0ntTH_sOaPiqML715jyTCujwyh3Og1wBq9RNLbu55C5Q@mail.gmail.com> <CAJuCfpFA0Kqt_KOceq6bxbJG80z-RaxcFbC+-59F_sPOXAorQA@mail.gmail.com>
In-Reply-To: <CAJuCfpFA0Kqt_KOceq6bxbJG80z-RaxcFbC+-59F_sPOXAorQA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Apr 2025 22:43:11 +0200
X-Gm-Features: ATxdqUEqqoG4LoIyZ4OwQmz6A4H2tBfAsqh63IM1Om7wtHRV6kYoe8YBb1fcZ7Q
Message-ID: <CAG48ez0qqFenDtrWu6xB+5voYMYX9VRiEpe3_8NOZjT8Wz4eFg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Suren Baghdasaryan <surenb@google.com>, Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:33=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> On Tue, Apr 29, 2025 at 11:55=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > On Tue, Apr 29, 2025 at 8:04=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > On Tue, Apr 29, 2025 at 10:21=E2=80=AFAM Jann Horn <jannh@google.com>=
 wrote:
> > > >
> > > > Hi!
> > > >
> > > > (I just noticed that I incorrectly assumed that VMAs use kfree_rcu
> > > > (not SLAB_TYPESAFE_BY_RCU) when I wrote my review of this, somehow =
I
> > > > forgot all about that...)
> > >
> > > Does this fact affect your previous comments? Just want to make sure
> > > I'm not missing something...
> >
> > When I suggested using "WRITE_ONCE(vma->vm_file, NULL)" when tearing
> > down a VMA, and using get_file_rcu() for the lockless lookup, I did
> > not realize that you could actually also race with all the other
> > places that set ->vm_file, like __mmap_new_file_vma() and so on; and I
> > did not think about whether any of those code paths might leave a VMA
> > with a dangling ->vm_file pointer.
>
> So, let me summarize my understanding and see if it's correct.
>
> If we copy the original vma, ensure that it hasn't changed while we
> were copying (with mmap_lock_speculate_retry()) and then use
> get_file_rcu(&copy->vm_file) I think we are guaranteed no UAF because
> we are in RCU read section. At this point the only issue is that
> copy->vm_file might have lost its last refcount and get_file_rcu()
> would enter an infinite loop.

Yeah. (Using get_file_active() would avoid that.)

> So, to avoid that we have to use the
> original vma when calling get_file_rcu()

Sorry - I originally said that, but I didn't think about
SLAB_TYPESAFE_BY_RCU when I had that in mind.

> but then we should also
> ensure that vma itself does not change from under us due to
> SLAB_TYPESAFE_BY_RCU used for vm_area_struct cache. If it does change
> from under us we might end up accessing an invalid address if
> vma->vm_file is being modified concurrently.

Yeah, I think in theory we would have data races, since the file*
reads in get_file_rcu() could race with all the (plain) ->vm_file
pointer stores. So I guess it might actually be safer to use the
copied VMA's ->vm_file for this, with get_file_active(). Though that
would be abusing get_file_active() quite a bit, so brauner@ should
probably look over this early and see whether he thinks that's
acceptable...

> > I guess maybe that means you really do need to do the lookup from the
> > copied data, as you did in your patch; and that might require calling
> > get_file_active() on the copied ->vm_file pointer (instead of
> > get_file_rcu()), even though I think that is not really how
> > get_file_active() is supposed to be used (it's supposed to be used
> > when you know the original file hasn't been freed yet). Really what
> > you'd want for that is basically a raw __get_file_rcu(), but that is
> > static and I think Christian wouldn't want to expose more of these
> > internals outside VFS...
> > (In that case, all the stuff below about get_file_rcu() would be moot.)
> >
> > Or you could pepper WRITE_ONCE() over all the places that write
> > ->vm_file, and ensure that ->vm_file is always NULLed before its
> > reference is dropped... but that seems a bit more ugly to me.
>
> Ugh, yes. We either ensure no vma->vm_file tearing or use
> __get_file_rcu() on a copy of the vma. Or we have to stabilize the vma
> by locking it... Let me think about all these options. Thanks!

