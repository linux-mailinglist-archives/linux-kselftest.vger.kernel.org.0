Return-Path: <linux-kselftest+bounces-10893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E134F8D441F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 05:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F520288620
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 03:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43F56475;
	Thu, 30 May 2024 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsEGJAf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21486BFA2
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039641; cv=none; b=G+Ulkt9EQkZu3oiDQEnTqiSZG/2J7GWcEHO7WwsO9kmd+x1AThfXKoIOBgpgScvvWoIminCuuTyNMo0I1G+/zB4xdSYn5gAMzIX0aro8RnuZQexAiB5Z4JyAC0cnSMZBpY9RiuKH8JeU02B4bOOVxUJ4s/VxlvUVt7H/3/mCq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039641; c=relaxed/simple;
	bh=xwqfvipxZXJK+B/0mrTj9cWb8eP7mVNihD2LXTHfaSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBN4YhHkKBmcdN62Q/QcF6+8UEkEXmHNqmyuQQhtSLR0A6hOI+pko18HfzgAe0CWWL7JxeMX9pC65NVhmTpHaAdWzYfVdKXWkadOZ4MM2WTNAx1iR4o5Tp4alYooQIdd+uRIC9pe6hseMvvKiMQH8RzsC159fwv/NW9WH6qD3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qsEGJAf2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43e14f0bd75so110811cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 20:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717039638; x=1717644438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzO8DZyZzCqrZIAMGt7yPpLcZJsj3wUliJt03pVmX2A=;
        b=qsEGJAf22FtK1T9YmxDUPjIaTDS2NZnp9Fb63aWXEdLh11vy9K3GUtRHVQ2OvSxy4W
         YOIngawcKAbQ22m7NWqo4A8AJsQ+8jNEsKEeg0cLMRtvfnisqYRy0CT841KLKkbrALaE
         umy4gwWYR0Szf3ttiYYY2CXOia0EyA84rDpG3wbq14ytUoqM9mfqFZQ2jAsEK0K4QYYa
         HGsYbUTAh++b/ElOnZaM8/TvE/1jF87HOOYAHzJ0j1spyV53vdz00+1WV1OfO5eaza6U
         qSeNHoybqgSlvRqzY9z4RhStBbyyvzCLzNVZO9bmWhRKHjuj6+5t73jdH2Rdr/jpchlK
         uU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039638; x=1717644438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzO8DZyZzCqrZIAMGt7yPpLcZJsj3wUliJt03pVmX2A=;
        b=gfeUgtC147k1tuxTstU+FMjI+CUyC8bb9ka6ROnz7PHkc+Px1ZWxpJW/96l9mf4BTY
         lEI80mgfirArZ6TKBzwy4NHkFSUXEUBjHsWD32ignmROXNz7dOnlnLJthM9kJoFQ7EF7
         jVfQJs1q2rfjP9RjK9COK4qOTz6npEhPtKQMY++A5XwP7TOgTn88nALebBhC/JZzBZat
         t3xdYvquJZenQ8cpIsyopvmGQxLGEfASqeYAQNlIwDOlDzmnxA5RKG1WJr+33473kfNg
         dr+WxxZ8stDEo5aMDSlymeJKoPbobx8H5NQ3b6pC+7xHcgV6W9cj6EouHeO4YLyyYp9K
         6R9w==
X-Forwarded-Encrypted: i=1; AJvYcCXR5GxaxcbQiMf6MWK3tefo6XwurNupEiHama76h3EEcYT5C1DJ0mBi7JhgyWgfWqZ7F0o2T1T97by96AWUK8VVzaBuSdOvUulO5FF3y5sm
X-Gm-Message-State: AOJu0YxA69bsWoBc2LP2FnjhkbIV7Ioirvdb+vgY78SbTVmgwE26lLyh
	vgP0/1QAmlEZdS60kfZAu9ihrckixLj4J/kVe8uCVrO+/wiVj+tunilNoGA9O66MPvy+zUAbCOq
	wIE/8cCOH/LO6z9BNut0XUROTMVMdv6Uplwow
X-Google-Smtp-Source: AGHT+IFVU+i/PACo9p4/Bfxh1CqiMIWSQeR950pdjWP8hj1BhsXnC5rRHtunLNirP/Gyt4FL6G7AiU0HcN3VuQYeCls=
X-Received: by 2002:a05:622a:a313:b0:43f:ebce:be50 with SMTP id
 d75a77b69052e-43febcebe65mr835941cf.16.1717039638165; Wed, 29 May 2024
 20:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-4-jthoughton@google.com> <ZlejXCYIuJ7_DlwL@google.com>
In-Reply-To: <ZlejXCYIuJ7_DlwL@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 29 May 2024 20:26:41 -0700
Message-ID: <CADrL8HUa9o+G6-Yn9oWt2LUgoVYGU=sYE2-JhkpoRgrS6Wi57g@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] KVM: Add lockless memslot walk to KVM
To: Sean Christopherson <seanjc@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:51=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 29, 2024, James Houghton wrote:
> > @@ -686,10 +694,12 @@ static __always_inline int kvm_handle_hva_range(s=
truct mmu_notifier *mn,
> >       return __kvm_handle_hva_range(kvm, &range).ret;
> >  }
> >
> > -static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_no=
tifier *mn,
> > -                                                      unsigned long st=
art,
> > -                                                      unsigned long en=
d,
> > -                                                      gfn_handler_t ha=
ndler)
> > +static __always_inline int kvm_handle_hva_range_no_flush(
> > +             struct mmu_notifier *mn,
> > +             unsigned long start,
> > +             unsigned long end,
> > +             gfn_handler_t handler,
> > +             bool lockless)
>
> Unnecessary and unwanted style change.

Sorry -- this will be fixed.

>
> >  {
> >       struct kvm *kvm =3D mmu_notifier_to_kvm(mn);
> >       const struct kvm_mmu_notifier_range range =3D {
> > @@ -699,6 +709,7 @@ static __always_inline int kvm_handle_hva_range_no_=
flush(struct mmu_notifier *mn
> >               .on_lock        =3D (void *)kvm_null_fn,
> >               .flush_on_ret   =3D false,
> >               .may_block      =3D false,
> > +             .lockless       =3D lockless,
>
> Why add @lockess to kvm_handle_hva_range_no_flush()?  Both callers immedi=
ately
> pass %false, and conceptually, locking is always optional for a "no flush=
" variant.

Right, this isn't needed in this patch. But I think I need it
eventually (like, in the next patch), so I'll move it where it is
really needed.



>
> >       };
> >
> >       return __kvm_handle_hva_range(kvm, &range).ret;
> > @@ -889,7 +900,8 @@ static int kvm_mmu_notifier_clear_young(struct mmu_=
notifier *mn,
> >        * cadence. If we find this inaccurate, we might come up with a
> >        * more sophisticated heuristic later.
> >        */
> > -     return kvm_handle_hva_range_no_flush(mn, start, end, kvm_age_gfn)=
;
> > +     return kvm_handle_hva_range_no_flush(mn, start, end,
> > +                                          kvm_age_gfn, false);
> >  }
> >
> >  static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
> > @@ -899,7 +911,7 @@ static int kvm_mmu_notifier_test_young(struct mmu_n=
otifier *mn,
> >       trace_kvm_test_age_hva(address);
> >
> >       return kvm_handle_hva_range_no_flush(mn, address, address + 1,
> > -                                          kvm_test_age_gfn);
> > +                                          kvm_test_age_gfn, false);
> >  }
> >
> >  static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >

