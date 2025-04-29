Return-Path: <linux-kselftest+bounces-31906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48741AA1110
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871933BDCC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7D2417D4;
	Tue, 29 Apr 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/USvDw8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE50241679
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942199; cv=none; b=AXFDb3tuDQvUSapfMmnr8piFCAPgkhnocCsJqdfla3nWgKlkXEw2Kb63D2HW55eKTBkJRy0vl2KHD5Wop2lT+pVmR8zpE1o18zOr9EFifK4e7xBcHMDWJFMrBbdZehTE0lMKVmIJae3gnDmkLRwtC7/o7kWTm3KCq57CczGux9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942199; c=relaxed/simple;
	bh=PksiWfpMfxllb9cMtMeDE5xqZSJKQGuK3D2npFWtovY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N39S6pP1ep/pC4fqFTjODihydJajbVLTusO6DLzHN1lWKm70Pd8d49bGcdV+4H/9aO8Oqecd6HPNkmkEv9pJ+dE53PA6dcYwDwYKbD8MBCAyXmx7MoZ5oo7ywbQf4V8pC6lCuMF9orQcud2B5V/ICnVP59JO5S4z8dvYWiBaHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/USvDw8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso1994a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745942196; x=1746546996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PksiWfpMfxllb9cMtMeDE5xqZSJKQGuK3D2npFWtovY=;
        b=O/USvDw8of1oGQ9GiuPDnsjhFb+4Hax6Oh5hkKMjDJozdj2o1GWvM+XqwdOhdzlgDf
         4MCRPNyTVTo3rrOYBImstWzN7PdKlwN6zIO5QMaRqgv2g9kNUb2JmWZpSUnwzJPASmvw
         ojVKVpD5HoBJhaAn+n/Cl/Cj/LX9+PJMApIeIuVN3TKi6mCNqC4NbDsZEeZLhS5amTcX
         6NiH9H1rkZNn//7U6BdmGEa/o9x3f1LnBQNSkT3fW+qtBaiaq0idGJHLqIW9IpoGLsEC
         j5RH6TXJ/0fHjj9zb+PGhwVvYTR7OYo0ka98XXaLGv9wgvilcm7osgx1dKjYeywpsLQ6
         mLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745942196; x=1746546996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PksiWfpMfxllb9cMtMeDE5xqZSJKQGuK3D2npFWtovY=;
        b=OsFhYX9kjNgeRWsK6P39tB1uUzds2Y4g2B7nnnoBSuU5pnuScieT4d2d7vLyW1qZ2F
         iaerPqWTFYiJ77coF2S4TjGSoJOFhj2nyLTHprlH+Atr3KAmNFQmpBGES3P4jYH0EuBL
         YEZD9fOdELakYrJHVc9QMzbyombh673eMX/F52t2SNRL4g/DDfZqgnCzt/yHhea/DzJH
         ADweoxTr/wmgTeT4RCNH2Pw9g8A8Bwp1KXePXp9G2nwznTFqza0ID4F0MWecmHX7tsfE
         iNLZUNpq3PnOAgv8BNY2dPjQVvMbQkZo2ujIbJKBEWagz4iqiYVBQGf4hn8YmlfaerfS
         eOBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXqQxZQlTghZy8/qu55IfZ7owPfVdMRsFtsc6raNl2t7I81WAxSu+CbUtd68E606ExPNrkyg0QJeJJ8SWGSNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytHP4fbQJOQIOhE4FHszvRS8UYs5cO6AMNkYQUNqQ2wSst6KnW
	7eLBsplTcbht20K+pD4IfxCoBxySmjE0lPzYdfS57ySE6nIfhRo7tQC1cunilY9cBd3ZGY5cdyX
	129wQVc2IyjoGO0vPe3vVMwjl0nHIkd2SSNeS
X-Gm-Gg: ASbGncu6udr4jINhjgn0okYPSfkVK6IRXo8iB3HlMkf8Ac0zJHYR0iPF/ZduP14zW43
	c+8bEoGD9lWFRpEp6C9LqIw9iRhp0Suo7J3GaAsHo/vqHNZZPOAkkwL42Y8WVu0ttEeBrp6hBrx
	GEhk8dnfRdLbNNlCZc5J1wqvBRd37gjgSU+ic4JnGfCE/hw3eaig==
X-Google-Smtp-Source: AGHT+IGtxlZGWu2Je/bOBDJTv80S1Q80Y7hLVWaw/Dsh1sFOZ7mVM95j4NTnHLX0IbqUIKK8zCAe/YhlOZPXyx67i/w=
X-Received: by 2002:a50:cd0f:0:b0:5e5:7c1:43bd with SMTP id
 4fb4d7f45d1cf-5f83c1b5a74mr91868a12.1.1745942195429; Tue, 29 Apr 2025
 08:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
 <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
In-Reply-To: <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Apr 2025 17:55:59 +0200
X-Gm-Features: ATxdqUFo7EtQYKmtjBK-XwiZ1ZSWDYl5j8WIiYqQOeXkDF7OdcxVClYh41AITzo
Message-ID: <CAG48ez29frEbJG+ySVARX-bO_QWe8eUbZiV8Jq2sqYemfuqP_g@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 12:54=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
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

I really strongly dislike this "fully lockless" approach because it
means we get data races all over the place, and it gets hard to reason
about what happens especially if we do anything other than reading
plain data from the VMA. When reading the implementation of
do_procmap_query(), at basically every memory read you'd have to think
twice as hard to figure out which fields can be concurrently updated
elsewhere and whether the subsequent sequence count recheck can
recover from the resulting badness.

Just as one example, I think get_vma_name() could (depending on
compiler optimizations) crash with a NULL deref if the VMA's ->vm_ops
pointer is concurrently changed to &vma_dummy_vm_ops by vma_close()
between "if (vma->vm_ops && vma->vm_ops->name)" and
"vma->vm_ops->name(vma)". And I think this illustrates how the "fully
lockless" approach creates more implicit assumptions about the
behavior of core MM code, which could be broken by future changes to
MM code.

