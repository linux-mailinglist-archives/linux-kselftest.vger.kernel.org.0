Return-Path: <linux-kselftest+bounces-43206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C59BDF1A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 16:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A891A19C2705
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410E25D533;
	Wed, 15 Oct 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KB0sj7U1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A157283C89
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539009; cv=none; b=rwInxj4jwDt+jGKzF8k+STEIMMuDu132S5rHlgB1UT8bskY4uFn7F06aPrUMh0IUZeQ0C8MgC1VdGV+/QsiCUMnJct6G9ApdU/qJniqA3evwNORRqWf8bRMZqlVxRJes/YO54yyt9d+XocXTy6T8Ng2CA5O/46Cur/fJop8Iq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539009; c=relaxed/simple;
	bh=ifYwjtgGq5keUbDlKteK0EeKaKXUIahDxueNXQTSmx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIhU3eD1cvXzgx1u2vTVTooThAt1jbu2bVGJJU1XNZS2qtXqCyCD9iswFJNa/c/mDdss2ISzBAvAcnCj7PTOeAOLehbsugyGx2kC7p3b6RHKhaypCag281xiXxblgGmxTTdaGZD6LjeSXJlOTRY+XGUvBK4NJ0/U1GB4LSdbxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KB0sj7U1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eed7bdfeeso12973805ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760539007; x=1761143807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifYwjtgGq5keUbDlKteK0EeKaKXUIahDxueNXQTSmx0=;
        b=KB0sj7U1sEtZ2+Apfh4XHfSWy7Jinq6QDPgOz183tpDIy94QEsMIvQ0JceyG2PKTj5
         s88/tCLUJZCupIzO/LmxRo8UYT7DnV4YB/hx9DcekgxxKY3ncebEloLrHg4imtypAEpc
         TKBE9SDU+cx/aUQr3aLje3NOD06vMW77y4D3mwudTmlwfLVHG7i5WaTHX+1D9Huy1xbD
         ggIqI8aAzwicm7LpPZYWaa8WxrzRN3JzZvr3YIkLx3b2evl3unH0zsFOdWN0LsfOF8sT
         AWe8YaMU/LdGTdKc6hsBylpzgdWJvMXSmJXFL44D48nG/DL8bXNLXulGjFnY2nHbgQUB
         tFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539007; x=1761143807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifYwjtgGq5keUbDlKteK0EeKaKXUIahDxueNXQTSmx0=;
        b=PS0uczwiSmT4/vhZF0m4hTy/MaiZCjgew8itBRS9Q3Yw+WSY78CShYiB+3MdVf4m5i
         KQnrEnvulDs7ZpyNACJOSyDICOfYUNQewCbTvE+Ev1Y9TCgNZaliMjWMZs5ppPY9X0Vr
         ieScplyYDo9GtomcLHFd2JN08g272AdJVzXBLYHoGNUY0cn77FnD6sxN6ASkpZx008Hl
         j7DhuamSzIGFXPAXb1nEd+7HdxfGm/ZrUEf6mAyJUTS7+dDBuDDX/M7VG24VMrkTT8Q5
         h6IlkrqFoGinkXks9aKY/OcKgbsgXjowaRc7FLbAAxGYaNC+ct/DIQszc7t5tYnUWRjQ
         vzsg==
X-Forwarded-Encrypted: i=1; AJvYcCU2XTHPFbjrz0HYikIEMhJBGiyPlm+Jx6NJPCAgIuBsN/LF4ZLsT/Lawj3uYRxom7fi/k/xx9sueX8J7qzQT0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEtBpw3mo1xQcvConOtoh6e6yCY2xayU5RvxFYzqu+/UIbVm5
	Q8QMmBuc0fxNCAfWNJPjfbVGRZb3OEBxzIK7mYgBYfrmW+PvFgp2L4D3rYo4e/RWvCmLl52BjuM
	Tb7wNBl84NBLHrisuElq0nnG2K98ByOp12FznjMY2
X-Gm-Gg: ASbGnct0L+iBjNaCIg+mpT4QEIy+PqPWLHrYWbJY3bW9Od0M7uiPW5kQUf8vne/sYTo
	i2HQOlDNfNQ4guuG7m8K533LnPJmoTXUSR5O0RorTOeSn/QWkbPviNq2kPfLZ3iByHcAWxXZWGB
	nYAjGxFqg9t2VqE01z4/7gggsDULoCQbimstvISQIxSzGSMPE+54svkO24qB1V0PCrRR1G/KWN4
	g2XWB463x0PEXKIpGZFsEXm88kjP/W9piF43ximiNgJy5KKOBHcaia5oeTVr80rXYEa7HmjgA==
X-Google-Smtp-Source: AGHT+IEgJ4Xh7QA5HE+tPAkou2gC/3g0NAsVR8ZhLLf0dUw631bkhU9G1C2LnuWl+YoLKezB9R+Fgv0xDlsaqCPV16w=
X-Received: by 2002:a17:902:ce92:b0:26b:3cb5:a906 with SMTP id
 d9443c01a7336-29091b58552mr3833485ad.16.1760539006951; Wed, 15 Oct 2025
 07:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
In-Reply-To: <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 15 Oct 2025 16:36:08 +0200
X-Gm-Features: AS18NWAisQiMzt2QRK50IWgyiwg1QpdPMU2VVQzYd71ezZ8bUqs0a3UMQudZMqg
Message-ID: <CAG_fn=UNOLezyetfBYd3ztWDHmGwht-01yf1_p+O-JXcPu57TA@mail.gmail.com>
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com, 
	elver@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:19=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
> >
> > +Cc Marco, Alexander
> >
> > On Wed, Oct 15 2025, Pasha Tatashin wrote:
> >
> > > KHO allocates metadata for its preserved memory map using the SLUB
> > > allocator via kzalloc(). This metadata is temporary and is used by th=
e
> > > next kernel during early boot to find preserved memory.
> > >
> > > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > > randomly intercepted by kfence_alloc(), which services the allocation
> > > from a dedicated KFENCE memory pool. This pool is allocated early in
> > > boot via memblock.
> >
> > At some point, we'd probably want to add support for preserving slab
> > objects using KHO. That wouldn't work if the objects can land in scratc=
h
> > memory. Right now, the kfence pools are allocated right before KHO goes
> > out of scratch-only and memblock frees pages to buddy.
>
> If we do that, most likely we will add a GFP flag that goes with it,
> so the slab can use a special pool of pages that are preservable.
> Otherwise, we are going to be leaking memory from the old kernel in
> the unpreserved parts of the pages. If we do that, kfence can ignore
> allocations with that new preservable GFP flag.

I think this is the best way forward.
Changing KFENCE to allocate the pool from buddy will make the
allocation size less flexible (goodbye, CONFIG_KFENCE_NUM_OBJECTS)

