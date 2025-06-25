Return-Path: <linux-kselftest+bounces-35781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F74CAE87E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D71BC64AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98EA2BD590;
	Wed, 25 Jun 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ac74SO+b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81C29C344
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864934; cv=none; b=qrWD3X+Y6VYlmAc+ZYgkOPcKz161D/tAZ1MWDZJIaEUXDQqbVD6hAYNPWxBDxA3hRcyelZtcQVnMQOIp2HG9FMnV1JglGwVEBMhuyG+8bAaXfdGclmQmmx9gFPpqOKX8O6phhCcArOIVLSXvpimbwIxuMIleN58208zuEsddRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864934; c=relaxed/simple;
	bh=CkP4Zii5yEFnjEpnjpmU8yomUCDwhFbpaCZV6rMyG4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8uhGVyoxN57jgkdk0hHgsa+cLixbCmwfgHM0/jnNKbOjlMuMeZ/WzjwxuAzwd8KpkeGkI9E36sZGer0JGZScLnsh30uO6JaYuLOGChT01HAYkNP+zLsZ7131BsIWe9a6Ph5H6/EBfgnaOLPmxhnJDRDpvaEa2qIl/Etw0d8Oug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ac74SO+b; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58ef58a38so174971cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750864932; x=1751469732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJ5P0u/6xcg1NtaqnGcLvqTOCLTnaVcDdgVW1OPXhxk=;
        b=ac74SO+bXQSpktt/NQgPXOw8n0qyYQEtL9Qu8SaqtLijnACeUk3QX0c4Gq3LLWwHvm
         873xAuPBg563ut2+95zgEXaL3KKzEkSyHZ5lTaCVLbjjRKfxjR3tmUe0Irm4cOV2cCDd
         YgRE/5pptYf23aV/5nHnJcvPg7LewX7ze+bYkygHMU0Wk+RqWB7KmJ6HPnURTXGxnLdw
         8Un0uUZ9cgAPOaRAhRkiVUpWiJc7VHhYwH5UT+qnmGBMGKAKsPIeMIYUP1vSzNTPpEu8
         ZKFrvfSTpFDTX0y2Bpn0Pc8jef0pWHerHaCbEsQS2Obg20aby8mMIWg/Jj/R5OAqpLpq
         zPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864932; x=1751469732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJ5P0u/6xcg1NtaqnGcLvqTOCLTnaVcDdgVW1OPXhxk=;
        b=kiidLL2siXjDHTHtWIhdDE2KQmeRdhC7BJe8PAfcmPLn/YM1qKAiC+gySCdOcgndKQ
         dIdfJTLfB84h6Aek05BOk0XaeNbeXdUVry1R0adR6wg9/vtGAWcNWq2W06yrnty+EmJI
         scbWbrDa3qC9aJp5jw1VRtiNDCEr7nGyPQ5qN8B0fyxFB/r3rYzq5bf0rRrJC0sVOudG
         lqR57SZqcvBUTmnpj8dCGRiSEIfqgsW+WRmNbjaO0aW5uCDJVuQQjk3zk3tCikJIvjYX
         Woi0isfQ9MBpFqBHbLOLohHAyu3uKQhsNyJ6yl9ZgoOU4GEYhiSgQuVEKMPlBPtDYji4
         T6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAskzugT/9ADV7mTwxC0CNVGT5LMogGMAiQ0iK2FSNaxafpVFFNUWHBWBQLobnkPJvEu+kZGIsD43J8BL/7kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybcJlLxzK24kuRNn9d9BZCCTJLI/872UQUDSZAUT4ZEbzpoTt1
	huhmzExvLGBcBxxPBh2vigOKkev0K9EjemHi8sBCoyPUGOCzlzgoZy66nblmoWYl9OWRX9oMLJW
	D6Rj9TCnhqRiqfwqlRfLEau0Jf2/uzZoOiVOQL7mL
X-Gm-Gg: ASbGncsVGzM/8Ap3RpLnh3JIqAlp9rFxOMJrc+znkOiMc2M+PWR/LHFikFLhcwwefAO
	8vLNOS1jLSm6FvwWc/DLx0ZCPRbeQMdq+w7OodqB5bz4WT/ESOMR6xuwe8Gppa3FkzDQ6OvnM/1
	2c5RX7r4a55pBwsU5nMKazSpkLxBhEz2FbjTD7vJPwMQ==
X-Google-Smtp-Source: AGHT+IG8U6qG5KYMo+nkavpDTx/PPdha23r+RnimIC8ktx5xvsAvgguafO1U53hsdch5/27popiTWWkJKAGkT/NKfVc=
X-Received: by 2002:a05:622a:85:b0:4a6:f9d2:b547 with SMTP id
 d75a77b69052e-4a7c236b037mr3595081cf.20.1750864931337; Wed, 25 Jun 2025
 08:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624193359.3865351-1-surenb@google.com> <20250624193359.3865351-7-surenb@google.com>
 <fd305c41-b2a3-4f0c-a64d-6e2358859529@lucifer.local>
In-Reply-To: <fd305c41-b2a3-4f0c-a64d-6e2358859529@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 25 Jun 2025 08:22:00 -0700
X-Gm-Features: Ac12FXxttU6uD8NTsD-TnCGNT9pqqB3547DZqQ19Bc1hh7qCrrhXbmy4EDhP4xU
Message-ID: <CAJuCfpEpshf7L-Axt4MJf=onoz4F=Sw4nk5Z1yVwvwkzSYx9qA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] mm/maps: read proc/pid/maps under per-vma lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 5:30=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> This patch results in some spam :) there's a stray mmap_assert_locked() i=
n
> anon_vma_name() that triggers constantly.

Ah, damn! This was triggered before and I completely forgot to fix it.
Thanks for reporting it!

>
> Andrew - I attach a fix-patch for this, could you apply as at least a tem=
porary
> fix? As mm-new is broken at the moment with this patch.

Yes please.Andrew, if you would prefer me to respin the series please
let me know.

>
> Suren - could you check and obviously suggest something more sensible if =
you
> feel this isn't right.

This is exactly what I was planning to do but it slipped from my mind.

>
> I'm not actually sure if we'd always have the VMA read lock here, maybe w=
e need
> an 'assert mmap lock or vma lock' predicate?

For now this is the only place that needs it. Maybe we can wait until
there is more demand for it?

>
> Worth auditing other mmap lock asserts that might have been missed with t=
his
> change also.

I'll go over it once more but this was the only reported issue with
the previous version.
Thanks,
Suren.

>
> Cheers, Lorenzo
>
> ----8<----
> From 1ed3bd12d43be1f8303fd6b7b714f5ef7e60728a Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Wed, 25 Jun 2025 13:28:36 +0100
> Subject: [PATCH] mm/madvise: fixup stray mmap lock assert in anon_vma_nam=
e()
>
> anon_vma_name() is being called under VMA lock, but is assert mmap lock w=
hich
> won't necessarily be held.
>
> This results in the kernel spamming warnings about this on startup.
>
> Replace this with an open-coded 'mmap or VMA lock' assert to resolve.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/madvise.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c467ee42596f..0530d033b3dd 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -108,7 +108,8 @@ void anon_vma_name_free(struct kref *kref)
>
>  struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
>  {
> -       mmap_assert_locked(vma->vm_mm);
> +       if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> +               vma_assert_locked(vma);
>
>         return vma->anon_name;
>  }
> --
> 2.50.0

