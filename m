Return-Path: <linux-kselftest+bounces-43689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8C7BF90F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9026519A5EC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369229A326;
	Tue, 21 Oct 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHsKOKQb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9E287507
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086077; cv=none; b=k+O18HTywgGwmjsNK894zOtAbl0VF9juXuVC5vjze1OG8aYLXPVbkMcVzrtYgbSO7D7/Ds63d4xl/seU8cOKwQyO2rlQXPyrz/Hs5SJ3BaM49MiuvITrozjcVfAdg58+crR1GexeVQjENHKXrk0BDtbQ+OSrOn0Eo8plesGGgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086077; c=relaxed/simple;
	bh=IeoT7WRzABBSz4YfCNDzlegECV0bAt318h7fRGN5RJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsfsBGafVDLgMLAcILwcYkG59Bv7irTifHmxiVEiNOD/N94zYPQlWz0BuuF22fBfMnUfh+L28ECo3aOKpWIi4dmRc2LGapVFmVddDcwv0vWoHRqaeRqfjLFX+nv9dGd9xHjoKHGHlO05IkZ/JH70LW4yQaENiMOcosPcql3hVwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHsKOKQb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so4258a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 15:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761086074; x=1761690874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKO4Kp6dH5qBsfNYhJL1nx41dfgyVlu5TgJiEzgyusc=;
        b=bHsKOKQbtxRS7PfqyFqsWbg3XtGVQcaD5nH0+kY0bFMJF8GoVMgfRA/bpAk8xx3nDi
         LCc/1Gbz3IkLueOji+gvuuZ9SU9OeAIaMLrm+AgkHjL8Yd1q2FvDuVYEQw5QmLZO/i/s
         rTyYSmcRhAGj1j5QM7AebUFZ8qVmb3CpZln7uQUHPN6yG5AmbwCsso41FUFOBEAbtFYR
         hI77sJZ3/f0YFU3nf8QrRC/qtuAMigQ9YCIr+XxTkKWuIJWJa3HZdgvrqkQ7CMNciLLR
         jn37l45ZjbDSQzKLW0qppKF1H4i37/VNvFnZi42oqB8FG6y/ad1ncsFk2WoXkwEBbLep
         ynzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761086074; x=1761690874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKO4Kp6dH5qBsfNYhJL1nx41dfgyVlu5TgJiEzgyusc=;
        b=HWw3dNCPfdxxrDtrBPa2sEJhZ52AQn1xBEfgvFNKl69zmEA7raDUAY6/53YmqbTcqs
         iBeAjtrf2rQTWk4p2jbjOUrHEQ/LBiBpqydnwRKM/zz9cfMv9j4TNgBQYfBL0uEuW7Ct
         60zGl9UpyntPOocZ3RX9gOK77KAKk+XRw2Rz5wbI/Cb7mr3wo+fgay3frJbif5Ucj80j
         1H+WcS4iEED4P+v/1IqhLjGG9HFOnhtJJtBU4MEHxCBnvL8s6xvhdbA3s8ghD0HDRLO9
         wilqwB9KAn7tDBSk/iKU5YFEC2F+2TJhsDNPOcA0Qx6u6CztWPu5NmVNeorEpYWwnR/k
         HJyA==
X-Forwarded-Encrypted: i=1; AJvYcCWzK7RsyKWa2qdIbWRdTLHIjR3B5JUamL57+EKLmZaseoTUTqQ7AP2PPtCSrm/UoqnJC6ssGpQQV8LwiLTb3xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxL0ScVSGWoyfxi/KYonktsagNb1Jq+rHj3sv3Sakd4FY0ksw
	xB6pu3+uJ9dDmW5Ev9KyBT4Nrvx1VbDYbN+oPV/DJiFDUWSP6O3SLs/sUrcLnri2fX/gtlqD9Zg
	fnFG4eUsKLqBN5dwwMpkL0ccW3cYqnj5wtlRo42a2
X-Gm-Gg: ASbGncvaytuMRu7ffjPPtlAuZTlFjVJKVwg2+EsAC8g7b1XkcZcqAjWAzgG8vad5jhU
	6GiWNnuqWRAI0VZpXS3+LIhMkWk/kqvm51Cr1/o0a8yQblaKKKc06IA3gHN/32FS+AW8pQaQUvY
	MPO1aQFDeZPmA47NZaVJ55oeDodJjneriJYKxeLVX1I5fKoYdp4u+MoBj/XWEduh/OnFZjU4+a+
	wEFD8LKuJqltUp2ZWHWZudgXaDrV7wd0LmE1l9iTa9wzbhy3ehaLA/zPb2dD+KfA3VzBBM=
X-Google-Smtp-Source: AGHT+IHemPTjIsdR1YNb/+xlTiLW1G5LRjaPzAhpWFbk4sYlRCe9oYxSANNytekk/pnnXGKW/F8DhZvLGLEWjJAFktw=
X-Received: by 2002:a05:6402:326:b0:63c:1167:3a96 with SMTP id
 4fb4d7f45d1cf-63e1d9d8d81mr17578a12.5.1761086074095; Tue, 21 Oct 2025
 15:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-4-jmattson@google.com>
 <l7txoioo3gntu3lyl542jg3n3wvkqruf2qh33xy7lmr5mjgfq5@iw4wsfdurlc7>
In-Reply-To: <l7txoioo3gntu3lyl542jg3n3wvkqruf2qh33xy7lmr5mjgfq5@iw4wsfdurlc7>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Oct 2025 15:34:22 -0700
X-Gm-Features: AS18NWD_K5CQ6npFasemkAoeOhQEDgS2K8RB8qQWd7NRuStJGw86eRedF-qkt_U
Message-ID: <CALMp9eSPgy7RdT9TwKkRD5oh6-74XfCCP_UZ1mJWj6Nb9P4P7w@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 2:23=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Wed, Sep 17, 2025 at 02:48:39PM -0700, Jim Mattson wrote:
> > Add a new VM mode, VM_MODE_PXXV57_4K, to support tests that require
> > 5-level paging on x86. This mode sets up a 57-bit virtual address
> > space and sets CR4.LA57 in the guest.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 21 +++++++++++++++++
> >  .../testing/selftests/kvm/lib/x86/processor.c | 23 ++++++++++++-------
> >  tools/testing/selftests/kvm/lib/x86/vmx.c     |  7 +++---
> >  4 files changed, 41 insertions(+), 11 deletions(-)
> >
> > ...
> > diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/=
selftests/kvm/lib/x86/vmx.c
> > index d4d1208dd023..1b6d4a007798 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/vmx.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
> > @@ -401,11 +401,12 @@ void __nested_pg_map(struct vmx_pages *vmx, struc=
t kvm_vm *vm,
> >       struct eptPageTableEntry *pt =3D vmx->eptp_hva, *pte;
> >       uint16_t index;
> >
> > -     TEST_ASSERT(vm->mode =3D=3D VM_MODE_PXXV48_4K, "Attempt to use "
> > -                 "unknown or unsupported guest mode, mode: 0x%x", vm->=
mode);
> > +     TEST_ASSERT(vm->mode =3D=3D VM_MODE_PXXV48_4K ||
> > +                 vm->mode =3D=3D VM_MODE_PXXV57_4K,
> > +                 "Unknown or unsupported guest mode: 0x%x", vm->mode);
> >
> >       TEST_ASSERT((nested_paddr >> 48) =3D=3D 0,
> > -                 "Nested physical address 0x%lx requires 5-level pagin=
g",
> > +                 "Nested physical address 0x%lx is > 48-bits and requi=
res 5-level EPT",
>
> Shouldn't this assertion be updated now? We technically support 5-level
> EPT so it should only fire if the mode is VM_MODE_PXXV48_4K. Maybe we
> should use vm->va_bits?

I did update the assertion! :)

init_vmcs_control_fields() hardcodes a page-walk-length of 4 in the
EPTP, and the loop in __nested_pg_map() counts down from
PG_LEVEL_512G. There is no support for 5-level EPT here.

>
> >                   nested_paddr);
> >       TEST_ASSERT((nested_paddr % page_size) =3D=3D 0,
> >                   "Nested physical address not on page boundary,\n"
> > --
> > 2.51.0.470.ga7dc726c21-goog
> >
>

