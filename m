Return-Path: <linux-kselftest+bounces-12760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F605917586
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 03:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9FD284D58
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 01:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA04210A11;
	Wed, 26 Jun 2024 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4yJyVlH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DCD51D
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364921; cv=none; b=lJjwutaM96ORnGec5wDYN/s4TSU2KvIT9tbtcgzsezz74LdBWPH/qzuT+jMbwrzPvijsIChv792dG/nvgQ36foRMDc7P54SeA0wE30M6Fy7LkVjemn1GvLS3TTpPEcbRUyxohdouIb2Ch6x9+yAYNrR5ZSuxSM/Jg7hDOHqcCX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364921; c=relaxed/simple;
	bh=UFZ9PY+GDSA9BNrYdHIS8Xjr5b2tAoCZFEY+1AZ/7t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUOsjh40bklkprwFEFSy2NG6xrHQNfzmisCSY1K/eP7pltdTq9MVi7iW5qk5RkcBNWwfIFVMEDeYzDZmuTnZkjSMyL/iFxVP99uK7llQgL8cncn6uwOGpr4icT0bJ6ikYrco/bq/MEL74IC2R2TOInaFWMs/1jY4kcicN5YE1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4yJyVlH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so4138a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 18:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719364918; x=1719969718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDXzXy/x3VAMGE4telAkJ0AkS3Dvfn3YkfUIsKfqDwQ=;
        b=Z4yJyVlHfzMxe/ddao59NTkIs2o5QUVqvZf9ZptaOHKqJYdaZBjUDCXNvNd1KgJhqq
         ULJiS+zcFLsSxQ8czSy0OAYnZ9RwSk+1roN+1bG04dxjNWkS7THUkNquF8woe8i6L8pQ
         jAwx7aPXlQBd1JKY9fNVOejmymfsfgbf/QYlquMoRqDqyr7X+u9+GOhEYbo5jyLIbab8
         GflZ9PsVsaX4Syssapjp260tELPdmoFpvHDH+W2ERx0BlmFUfGKsCTs96a2YgDkF5KhY
         gSjdzGHEd88nrkAQ/kCebRW6Fysj6yFTAR/EP89ylnjngoY8flJus4qxhMUunqef5miL
         etEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719364918; x=1719969718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDXzXy/x3VAMGE4telAkJ0AkS3Dvfn3YkfUIsKfqDwQ=;
        b=LqehXLNfCjYNp/ljy3fuenFwKd51FsQRlLyHtODFT+8EEILxRYP+IFMQk5hByDZ7nd
         KsQTcG++jRbiJHw6GeEYoodWiKBhwzec3ByX/fQfYFAefHNvLraxb0AlNN07eyWguuR9
         tbPVA3IkzbB23kQEyep4PpnikRTtlvC/KEOsMrYyVd4ELKwJc2GG3j6mWQ15xojyfMIG
         VSESuB0IRmFspgXqxPKgSJZhSlExwBvqD88BeRtQhRtcM2/wZuvLo3WIdDfOIi6gnFux
         5RSHXJXoDyIomu7thwbmXsH1i+PHLLJ/kWYy397OMJK9rUmdWgqIguT3Fh+qvrLL1DMF
         o8uw==
X-Forwarded-Encrypted: i=1; AJvYcCVWwvPkwgLXU9UAqlhRZAxUErGL1RaglO7fgjxSTG1v8xm/yQf0f/8L1f9HnVXss1Mxh648mh/CWRBDjSiJAa94b1Zy2EKh/fBKNzg08oef
X-Gm-Message-State: AOJu0Yzle97i3fcFAxZBg+SesoUyv2y0XFCAxwpgQ/hMqKM4YzR9BRum
	YOzcaSY2xQndFNG0ci9ge08C0YbMrvTHVTk1aTkC6iRRWlrZbQX20sU5G4R74UcdG5Y2NSsfhAS
	SqVX5+ibD6969zK5oiS4i5zrvisa7w0JhVA+h
X-Google-Smtp-Source: AGHT+IHX6Dw13lvp9tA5r1Nr3EDVBrqZjzt46+AZrMqkD9VDrFcqyfsc9zQwLVqS3nH7c8fc7LBij/O5GqbVZ/GRwBU=
X-Received: by 2002:a05:6402:350c:b0:582:f117:548e with SMTP id
 4fb4d7f45d1cf-5832c353bf0mr116598a12.0.1719364915083; Tue, 25 Jun 2024
 18:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com> <20240625135234.d52ef77c0d84cb19d37dc44f@linux-foundation.org>
 <f975fe76-92f4-4af0-a91d-0f3d8938f6b2@linuxfoundation.org> <CAG4es9V0XAqe-eqPgjU+sdRS00VOEr0Xda1Dv-gtfEvqsODjiw@mail.gmail.com>
In-Reply-To: <CAG4es9V0XAqe-eqPgjU+sdRS00VOEr0Xda1Dv-gtfEvqsODjiw@mail.gmail.com>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 25 Jun 2024 18:21:27 -0700
Message-ID: <CAG4es9WHUSC7qm_6fJjQm5nM_iYEjXO75DWC8e5tzqc7fLEtfw@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] Centralize _GNU_SOURCE definition into lib.mk
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, linux-mm@kvack.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 5:41=E2=80=AFPM Edward Liaw <edliaw@google.com> wro=
te:
>
> On Tue, Jun 25, 2024 at 4:34=E2=80=AFPM Shuah Khan <skhan@linuxfoundation=
.org> wrote:
> >
> > On 6/25/24 14:52, Andrew Morton wrote:
> > > On Mon, 24 Jun 2024 23:26:09 +0000 Edward Liaw <edliaw@google.com> wr=
ote:
> > >
> > >> Centralizes the definition of _GNU_SOURCE into lib.mk and addresses =
all
> > >> resulting macro redefinition warnings.
> > >>
> > >> These patches will need to be merged in one shot to avoid redefiniti=
on
> > >> warnings.
> > >
> > > Yes, please do this as a single patch and resend?
> >
> > Since the change is limited to makefiles and one source file
> > we can manage it with one patch.
> >
> > Please send single patch and I will apply to next and we can resolve
> > conflicts if any before the merge window rolls around.
>
> Sounds good, I sent:
> https://lore.kernel.org/linux-kselftest/20240625223454.1586259-1-edliaw@g=
oogle.com

I realized that in this v6 patch, I had accidentally sent it in the
middle of a rebase, so it's missing the last change to
selftests/tmpfs.  I've fixed it in v7.

>
> >
> > thanks,
> > -- Shuah

