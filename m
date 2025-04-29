Return-Path: <linux-kselftest+bounces-31913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA6AA1490
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 19:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE141659A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8922522A8;
	Tue, 29 Apr 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvmqP7+3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF7251793
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946907; cv=none; b=SpDzrVZxezrf2ptK1blLY/6toCcAgn7hsbFXvUXKQ0RDLaN0Q1JyIKs8qu/EcEIpa94lanxn6V805fcDQmb931xvKcAnb17Kquebr0WWWc05pxWcVfA7AWwysJq1jvqEN4tBgf1OaaI5cmrtSQ5GcSc8YfQgocADpXZX8n3H9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946907; c=relaxed/simple;
	bh=8N3PFLJdo2BL64kwpJnok05xXM6XlOssovMurdNnZcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIT36XsUOI15UkmEX09AC6mzPgLUj9zjFoyrnOTgsnaWLNq0SBRYpR5CrNnSvuWISC5x8FB+uBFMSOpTG7CQJRhtt+GDIhHnINX83k8dFEdiZX6xkV61cZ33H4dwmRlK7YVYLWs1tQXl7u5Cf4WCqomgJagOnlZmBUr+QRpos6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvmqP7+3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47681dba807so49621cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745946904; x=1746551704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N3PFLJdo2BL64kwpJnok05xXM6XlOssovMurdNnZcM=;
        b=yvmqP7+3ya/94l2fLXHmzE6OXyONki4Xwo85mIw4cNtpqTl/qs8hAr2ABt+SaZ0QpA
         MYGuvB4sAXZH6Ii29Hi8yjnPEriSGC569nRP4LCCSSPt3PlHxWeX2nbrJav22e5G/hqL
         maAIK8mfK1UJL4cNT/E4VRzp7BNiPn+pbpEzT5PE9uQvCgDhXzMXvtg7hTfR9Eb0gEdK
         Opl2qfaV3OMjpjpitYgTUd2z6gDLjVLWMNIuxsTc33v76DvuaImb93farIhfhf18apM9
         TQGc7+fPjcKhRm86LJY1thr/z+K4jka+VRSsTiKOhBEYDvskkYvAnkeW7zwSb+EtaMFs
         rpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946904; x=1746551704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N3PFLJdo2BL64kwpJnok05xXM6XlOssovMurdNnZcM=;
        b=S6eRThQXh43QSaG8WE0QlKRI0WJ7E7Q+DFbI/UKx1vJfGc321BmyzTljwlj+y055km
         XfSpyx/nksQECDwR5Nub6FOe79ktlDJUYJ1DhC5i6dShhkQ6oj1TZUMAASDlaTSHFtMV
         yMLjpLqNkfQfbMpFpNG0E/g/8kpUnl8DNKzAwVY7QR5TU4GKBrVMRLQKczzxjl9GnLMx
         UH5bD7rkLy7zM9XgMmvKhEJYAJQkDln350t8NI1SQd9xgU8ZkFPjc2obrVy4U8Uuym1b
         Wr9C4WMJWodTtPT37HNLnB3X5M8HMXaj47/2t+GE/rW3/qHat2bePCszdfZBaYJBhcEz
         1KLg==
X-Forwarded-Encrypted: i=1; AJvYcCWVZKTfXXnZudck1o88ftNrGNRmyNXt4KSn53cqqoy68EeP1xNlTwjbBpPQkqmIFBsTx0htwS3e0Vz3vvatFIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9NiKoeGqOI1LzT7yWtZuzkOa5mF3mQXrt41TTrkHKSrvN9Z7P
	5N42NS+Boj4ykJbqRnd1dvs5Fmxf7akPNpt438HoRuY5Bycq5mvg6RIwt+UZgzTikCPOFuS/jyz
	TVd/6TLC+nf0LxWuR42TQPVdLVjqfw+GNwMeu
X-Gm-Gg: ASbGncudFlye0YV1XFCOM0E73D8WIGbcYEL+vPUXkfugpre1gjd+KcMi0T/9KYcZxRC
	1w86+qI+gtWncEHR6du6nIqMY2D+D+8ITE9AFe5BcjX6uUU6sALeI8E1+t3sxL6hvXEIAVKeAZs
	bzqv+yUbEnOPoo0AIu+HK3KryhmN4GToGQXlzpQl4cnMgz5JBIUqrP
X-Google-Smtp-Source: AGHT+IHc2d7Lags5IXA2jqjdd8Wrmu7oiMjs4V+SDYbkXeZnsbeXFEB5FbDmi3+9UCay73uMesmQXy8B2gOJYxFd2N0=
X-Received: by 2002:a05:622a:1ba7:b0:47d:cdd2:8290 with SMTP id
 d75a77b69052e-488a5dee905mr4983031cf.9.1745946904330; Tue, 29 Apr 2025
 10:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
 <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com> <CAG48ez29frEbJG+ySVARX-bO_QWe8eUbZiV8Jq2sqYemfuqP_g@mail.gmail.com>
In-Reply-To: <CAG48ez29frEbJG+ySVARX-bO_QWe8eUbZiV8Jq2sqYemfuqP_g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 10:14:52 -0700
X-Gm-Features: ATxdqUGDGzBEh9QYdQgSp_gL9D3xJRJOqR7cGNBprwi1rNdXNpRqj3ts5tZZ_ww
Message-ID: <CAJuCfpGxw7L67CvDnTiHN0kdVjFcPoZZ4ZsOHi0=wR7Y2umk0Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:56=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Apr 23, 2025 at 12:54=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > Utilize speculative vma lookup to find and snapshot a vma without
> > > taking mmap_lock during PROCMAP_QUERY ioctl execution. Concurrent
> > > address space modifications are detected and the lookup is retried.
> > > While we take the mmap_lock for reading during such contention, we
> > > do that momentarily only to record new mm_wr_seq counter.
> >
> > PROCMAP_QUERY is an even more obvious candidate for fully lockless
> > speculation, IMO (because it's more obvious that vma's use is
> > localized to do_procmap_query(), instead of being spread across
> > m_start/m_next and m_show as with seq_file approach). We do
> > rcu_read_lock(), mmap_lock_speculate_try_begin(), query for VMA (no
> > mmap_read_lock), use that VMA to produce (speculative) output, and
> > then validate that VMA or mm_struct didn't change with
> > mmap_lock_speculate_retry(). If it did - retry, if not - we are done.
> > No need for vma_copy and any gets/puts, no?
>
> I really strongly dislike this "fully lockless" approach because it
> means we get data races all over the place, and it gets hard to reason
> about what happens especially if we do anything other than reading
> plain data from the VMA. When reading the implementation of
> do_procmap_query(), at basically every memory read you'd have to think
> twice as hard to figure out which fields can be concurrently updated
> elsewhere and whether the subsequent sequence count recheck can
> recover from the resulting badness.
>
> Just as one example, I think get_vma_name() could (depending on
> compiler optimizations) crash with a NULL deref if the VMA's ->vm_ops
> pointer is concurrently changed to &vma_dummy_vm_ops by vma_close()
> between "if (vma->vm_ops && vma->vm_ops->name)" and
> "vma->vm_ops->name(vma)". And I think this illustrates how the "fully
> lockless" approach creates more implicit assumptions about the
> behavior of core MM code, which could be broken by future changes to
> MM code.

Yeah, I'll need to re-evaluate such an approach after your review. I
like having get_stable_vma() to obtain a completely stable version of
the vma in a localized place and then stop worrying about possible
races. If implemented correctly, would that be enough to address your
concern, Jann?

