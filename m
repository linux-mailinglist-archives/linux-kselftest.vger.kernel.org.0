Return-Path: <linux-kselftest+bounces-10894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5A8D442C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 05:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A3728888A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 03:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68B956B91;
	Thu, 30 May 2024 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yD0l2WJW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F056440
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039704; cv=none; b=mXpwr90UavxUGyukWcDGKZNxAXZBJxjrhqcGebjMjLgx1603SqQJ6bB4X6Uf/a/4IHC3/8yFgzE4tyVF1c24ar0jdlhXyEt6BQeE66xAtV2+uteiTXAe2YBBd0G991jh1doOHC0ZycgNMJArMjQKspDDT5bpc+IQF3LvjwgZCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039704; c=relaxed/simple;
	bh=lj90chMb5O0KncpLqzXDubS3cuPfyVvzEjua9aYNaYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3X3+tFmy0aBmPd2nDqQ6l2vS0m7Np48OUOF3p1QZmCHTkZGeSQAWOXpJwEtdQ0nj5LLRpJTEDp3aWxlPOs2bc5rORq1v5cXIm5xiIJKL0LY+AxuKDfguy22Ub4hb50OadCGBpOCUvi0JWbrTW8Km10tntW9vGAVv8q3H913/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yD0l2WJW; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43fe3289fc5so118421cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 20:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717039702; x=1717644502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyFUQdvGKe8UpOcfXmkz33OD4v6xcNcft6Wk6HjbLrw=;
        b=yD0l2WJWsKOG1zMBscp/d+Uwbn7OEEGaETPRVGgBkPKMriKH1UX96/wnam4Nfm+FFh
         fn9E2HHZG3aZ7+XyQdrRAqJlWSV86ARq4sg6iXkapBSUFWrj+S3pPINPwje6cHKTeENq
         3ZYii34TdqQcBtd54afejudEW3D7apxROWnpmlhUWw7brozFBYa2CGl7dkLn2kAeOGzU
         de35IAwvGIIwLJ86QCVBOttVDrMb1JG7GlfZk/cpeeiGF+HAE4QX5kY8R4NkG0TwF2P+
         1V5i3O0kufjodFjqkNfHzfT0dAkaTnmcMcxwsli2zYO4tiK38yZGxx2stwXN4QPm/PFW
         l91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039702; x=1717644502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyFUQdvGKe8UpOcfXmkz33OD4v6xcNcft6Wk6HjbLrw=;
        b=Y88yY5PEvURsB4DBEkD+h4agRWLNCUMqFc1P/6wgaqa8Vj9Dib8mjaw4CYpHvrgRlJ
         M2e+qSS5bbk9LFzkAlgr1KyEmmnMpRUqOufam73Ap9juVHWmCp1MkjXv4wKC6UcuHGAN
         eOouVMNke6DLqgNn0vrh/koGvf+YFt46MJvJiRabjZ0Tp7FSrhnMYBXTcIWsnZJSSXP+
         V+fBGB/pCpdowmW+iAytXHqCLiU4YoeXGnoB+2Sj7z1i5ovODR5hVMa1JnLeo9Fh3PzQ
         4Ld87xo32SDT4BXIP2cjZ4+qDL1DVNVG08yri2mvr0Mgr+ovZV6pP5xf97ZZB3oMLgd7
         Vm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDVG/biVEHpwKkw8x4Q5kMQA/WrdSEWd4QRX/U3OgEL9dxPfgJvKOqTco2edsBauhulYrujxbuTWd7tVI1cJCQAId+p6fHkVAmbf+1Zx2I
X-Gm-Message-State: AOJu0YxV12abs2p8dfv7uti4vgMBaWWjUZbwp6l77a5XKjlHjYszZqGb
	9KDBK5V7bh2Tt+Er4tblqMWp36vSICWBKJ0Wy4X3sVuIl6VNQ4peEVpCpU4MX9BIdgjn+sxHTJm
	nNydZUj5KeIWRvd56BtuGxUV4mEPVVst4pBJ4
X-Google-Smtp-Source: AGHT+IGBhNbFRaaD0WOEIsVSMflxCvd13kkSSK1hcGeX1B4TzLlXvTq7xC3rTsBmGx8uhqPHEIa2GYmfEXsD+JkYxAs=
X-Received: by 2002:a05:622a:90e:b0:43e:cb4:1d10 with SMTP id
 d75a77b69052e-43fe8e5f830mr1851431cf.14.1717039701993; Wed, 29 May 2024
 20:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-5-jthoughton@google.com> <ZlekYljG7KJwblUj@google.com>
In-Reply-To: <ZlekYljG7KJwblUj@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 29 May 2024 20:27:45 -0700
Message-ID: <CADrL8HVZxoO33F2UJBoTjF_SXpxyZmH=RTM5G3stgo_kRPjazA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] KVM: Move MMU lock acquisition for
 test/clear_young to architecture
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

On Wed, May 29, 2024 at 2:55=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 29, 2024, James Houghton wrote:
> > For implementation mmu_notifier_{test,clear}_young, the KVM memslot
> > walker used to take the MMU lock for us. Now make the architectures
> > take it themselves.
>
> Hmm, *forcing* architectures to take mmu_lock is a step backwards.  Rathe=
r than
> add all of this churn, what about adding CONFIG_KVM_MMU_NOTIFIER_LOCKLESS=
, e.g.
>
> static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notif=
ier *mn,
>                                                          unsigned long st=
art,
>                                                          unsigned long en=
d,
>                                                          gfn_handler_t ha=
ndler)
> {
>         struct kvm *kvm =3D mmu_notifier_to_kvm(mn);
>         const struct kvm_mmu_notifier_range range =3D {
>                 .start          =3D start,
>                 .end            =3D end,
>                 .handler        =3D handler,
>                 .on_lock        =3D (void *)kvm_null_fn,
>                 .flush_on_ret   =3D false,
>                 .may_block      =3D false,
>                 .lockless       =3D IS_ENABLED(CONFIG_KVM_MMU_NOTIFIER_LO=
CKLESS),
>         };
>
>         return __kvm_handle_hva_range(kvm, &range).ret;
> }

Thanks Sean, yes this is a lot better. I will do this for v5.

