Return-Path: <linux-kselftest+bounces-31457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4902CA99B03
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 23:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F253BA1AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 21:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3921FCFE7;
	Wed, 23 Apr 2025 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+I0yi0r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B91DE3AD
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445215; cv=none; b=NHcmZ71BdbegKliaYEbP0TmUXlhM8P1+zzGd67axaDYakDVJglzLQThceLbzjvZ8akJWZ2hBgRB/RpVAG0eJRX4kK6jvEB6hTO71qZg7NTZK8cs9jsPBRS0WZo/RMzrZYyDJ9AFwD/ZT+7PdfbHUZsSMvUjRMMm4UPiivfjObao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445215; c=relaxed/simple;
	bh=1VENgflOh3MnWBXlewKcXCnf2iJGOO5S/6TsTkBKJjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAKiwBE8+5AJXYCkmWrNxSrOjIK9oZBO4tDwZ+HXwnyi27DttwvNWFwAVW0c4dp9L6MdKSYTvO9yYchtUKKQwAnjmV72JK2EdWf9ZW0KZ/W6Wpo+XdVR/hTbB734UTID6+PMHf/2oVUsKcKqe2BmsikyZLBVVjimQY6rSd0Lcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+I0yi0r; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47e9fea29easo43391cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745445213; x=1746050013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wxOEPg2lzGGAAEWxyMxHF7QDi50JL+cgIXLanH/rmg=;
        b=w+I0yi0rZZufAMzk4tikYMnTXTZf++GbQxgW+IxjOi5cx4TQwMsstWg0p0bO7Mrlw+
         mxitFGHMdZvDFJ668oSWaAqR3oCstXTO7c7qiiWrg7wIL0jSThMu31JybgLVOttLJllW
         pthV4qTsN9eW7jF6CXDBlF+4XNjlXxDHjtTxNz2faxldy4W67NIO66rKa7v6NRMvxy8V
         XsQ0pWldRNWHyrvP6kuFgsBhV4AMSZEt/tpepJQCbYx3ZiK99GX6ipj3sip0Q/6G6NZp
         +hKn4VIqvVqzXQvJvu0ZH2X94qkbaqdjs/6zOL2j1hYX6qi//7lwXIfp2qTO24e9wlqh
         fciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745445213; x=1746050013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wxOEPg2lzGGAAEWxyMxHF7QDi50JL+cgIXLanH/rmg=;
        b=oqSGt7xciY4SyutDCCD/jAEPok2SHIBBVOS39EJ3aG1rba1h1mcDBb1VsTyeZu50vj
         6V3VGR+nNLxWNKXebpbdGX4tqOAKne8GNhv8PHgLeOweP7d0N2xYf/7xjcTNGDRWWJL2
         +ulE5eI+P/wX4vo72QbzjyCB8zoMyOSdNC2pbVEXKMNvTkgvD6Fpyc8mxsHqmdUGNLls
         bZ9Gj/4mfjXu4WN+f/dcHGwXGonm96SQpYdbcAQNcISnLyH/pJsX+FYoLwLpBJSNUjWc
         19BcCeGKtaXc9buyW1OfAVTeRYuzFLpp97xyYvqKXJXfkSLeYuhjRdhFUETzJessyVZx
         ZmkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU+VmDVpxQ8pmxfuDO6k84DzhJEc+aqzwwzv8giFDRyuX7ylpPCqCYkASgdU8RsTz8PRi6sxCAY6R/4Y6Xb1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs41jYHPv6ti63yVKoKzeTtde1M6hvtM4LsZ7qKvijRdW10up3
	JteYQFgCKBDD3vZevmOCufVa84Ajb59cEQOA6D0MzD3XXk4FO3rFVVlTo6LRH7HJ393UfhReFNG
	xga/fCrGzca2O7+7nWd0Kv9JJ2YBbDIJtfCwG
X-Gm-Gg: ASbGncsuYPuPLIkyGlqgnoE+S85dqsgH6ydpLLbihT5AOkKASvDEMHX1eA9hxjUTryE
	os3743sVnuuiHD+f4CUN2Wz9CtzTpAlToa616h19Y0y1YAA6WpQWjsJQIUpSV8Sfhl182kwRgZE
	0lvaKSUVBcEC4WaOx7xcV42tYS6mKMYfRNZCCXnXoM2XGSl1yewqtJ
X-Google-Smtp-Source: AGHT+IFxKf4JMsoiImdRCM9Gv2EFQUjIOz6bkJ3ODyiXPnj15zTxtQdogrWnY80WdKRS5ErJulohCQQ1CRC+j+mpd8k=
X-Received: by 2002:a05:622a:1bab:b0:476:d668:fd1c with SMTP id
 d75a77b69052e-47e79cbfd5emr1736981cf.2.1745445212617; Wed, 23 Apr 2025
 14:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
 <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
In-Reply-To: <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Apr 2025 14:53:20 -0700
X-Gm-Features: ATxdqUFczXuJ3MtAVzm6hOXwKgR46ihWvXXCSbcxhMDhIph3juTGEiPJwzlaPbY
Message-ID: <CAJuCfpGQPO5AqiZxfb9JYUqd5suS2C+qWt-_acjU0zFf-g-eGA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 3:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >
> > Utilize speculative vma lookup to find and snapshot a vma without
> > taking mmap_lock during PROCMAP_QUERY ioctl execution. Concurrent
> > address space modifications are detected and the lookup is retried.
> > While we take the mmap_lock for reading during such contention, we
> > do that momentarily only to record new mm_wr_seq counter.
>
> PROCMAP_QUERY is an even more obvious candidate for fully lockless
> speculation, IMO (because it's more obvious that vma's use is
> localized to do_procmap_query(), instead of being spread across
> m_start/m_next and m_show as with seq_file approach). We do
> rcu_read_lock(), mmap_lock_speculate_try_begin(), query for VMA (no
> mmap_read_lock), use that VMA to produce (speculative) output, and
> then validate that VMA or mm_struct didn't change with
> mmap_lock_speculate_retry(). If it did - retry, if not - we are done.
> No need for vma_copy and any gets/puts, no?

Yeah, since we can simply retry, this should indeed work without
trying to stabilize the vma. I'll update the code to simplify this.
Thanks!

>
> > This change is designed to reduce mmap_lock contention and prevent
> > PROCMAP_QUERY ioctl calls (often a low priority task, such as
> > monitoring/data collection services) from blocking address space
> > updates.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 63 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 55 insertions(+), 8 deletions(-)
> >
>
> [...]

