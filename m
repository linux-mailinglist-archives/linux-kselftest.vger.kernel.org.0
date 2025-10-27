Return-Path: <linux-kselftest+bounces-44149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73CBC11EE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B5819A25C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98E32C31A;
	Mon, 27 Oct 2025 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE4BQbJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E06230BEC
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606313; cv=none; b=axGceaPhdt5JETOen+rRcKuqwR33LjUudOsjI883typMMKyeXmOtFM/NPnsV/X5Sv7NwzbJSxZE66snZ7ROrzQhdHE22OA5z/ndzmS2z6Bt6Iv/lLRHoOBX7Zd0B3TYszmI5fqMICj81XhpI5JctgVstoYUjAJx01PCCCBCrvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606313; c=relaxed/simple;
	bh=4QcjKyTr9fdqx3O9SBoesqfDFwLKYeF8Vx1HeQeexLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZ6CFFwzzuZIF3sr7jeXaBKDgZ7qAxi6w8OkheouzHH0L+o2jiRnjOEtYyfWwiJH65tIKE/rNCv+pfs7JP5oaEreUqVoJ+Q7y43+orHevg3E7OSliWqlfKdKVW97Tiwb9BM6awUlUK13sZVwdQ0jDR9wVXc31qa+wHOoBl83wS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gE4BQbJ7; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5d96756a292so8310832137.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761606311; x=1762211111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QcjKyTr9fdqx3O9SBoesqfDFwLKYeF8Vx1HeQeexLA=;
        b=gE4BQbJ7X3rwZgUz6v9Q3KIinB+iUorKImgepggtFv/UY/yTdwDo0nmdstSibyY0cW
         mEjhLwpkCgPXGOwWVkbHoGKbPfQZbEAtArNXBD2D0KvF2X+1tZdLk7HkUo4WvfWxzQki
         ecTl3Sp6GE174VCXt2Qpqs0blj6tOgL97yugL36bQNplq67Z/ie8zMIS711jyG3jHPJk
         RNWYKwiw7dJfZOVBpimnfyVZZVwDGzL5kM38kAyjWn2uhgqg/XOQlz55rr0bC+LriLQ7
         qkouSAU5zQ8DQ1c3V0cgvMIdlRZGBiYhaZaCcMpEi8qMsrPFOt+cdY1mGwyDEUo7gKRY
         T/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761606311; x=1762211111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QcjKyTr9fdqx3O9SBoesqfDFwLKYeF8Vx1HeQeexLA=;
        b=CunR/8dLcZsp3Jg74VxHuXlBAwa3eJaVo7EJWzV3JQ7m8RC80OK0yhS4tb6KtOQjuw
         TzmLtzSt6vPzsT2x2SlZ8kVxaysZ4J368RtC0eER0Frrl2LablABu175E29LT8UF/Prm
         Be81L0Z6Enll0YONvRyCHe051pOvFnAlQRWNRW3IdjuCJWOMklR829M5v+at461Je0jY
         Gn6WZRJxFWN/U9llF+56wEfh8A/wMqwsVpETj8Pt+SL16Gg20rRMwzlID2oBRBAlgySK
         MM2rZs5GWBplgAPDCch7g09UTTONTcr+up/7zRj8CRRy1VsUV4+Vfoz2XjoJkEBNeHPo
         ZGWA==
X-Forwarded-Encrypted: i=1; AJvYcCW7urwMR+Y50xTgzOdWJv96BEuVT5DPDKmAS50KlSagm+GPtjGWvB+1VN8O7aC+r+HyP2qa8zn/HXU2uHnobEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmcLGiuxXH95bi0E8EBiHRMM7lQeCTHGw62lyPFvP6a/45xFe
	jZSxgnwgKj7AvddPIn7virhNgKESMf43LeLBJ87V9jnbUQ1WYZYhTsiSc/0QwgCt0C6j2EoJvMf
	FVlsVWSHRqFboMeCwYvt0rdGyVF518idHsZ0AwuZz
X-Gm-Gg: ASbGncvmUdN0jIWoJWlNlT9TnjgFy7mXzldEmpBD6Om5IzcgtdJdSYTLYqbfxlVuMGj
	Y2W08LYx1XCIsVWeG5+ZFbA6a03T8NgSQuOTVu/EwYt7WePRGXc7J7+eJcX2C8qM8WyvHxfRGGO
	UdMz5+RzqjTAy0SRIdGaQS/4/MH5Sjyc1pn60jsx4BNzQt5iKkgIOMgAYXw5WxJoU+ABH0AuGqG
	k6RC6ln+3NYX124nBmK3iYRsoM5YaZKML7yZLtHAhxVS4lf2I/IlXmvh0Nrpf7ELYz4nU8=
X-Google-Smtp-Source: AGHT+IHpaQt5+0pcMaIPZPH6gSZTkFVrpAwY4H8c4baBjFBSVkthH7idSXvBuMd/bzOIGy2JEPxjML5/b0vPbAuuafA=
X-Received: by 2002:a05:6102:18d7:b0:596:9fd8:9268 with SMTP id
 ada2fe7eead31-5db7e0ae09amr369527137.8.1761606310932; Mon, 27 Oct 2025
 16:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com> <20251021000852.2924827-4-pasha.tatashin@soleen.com>
In-Reply-To: <20251021000852.2924827-4-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 16:04:42 -0700
X-Gm-Features: AWmQ_bkP7kzVj43hv33PyztzJtnw3ebpuh-wFqU7ylSkamn2ND777xZJOuB-IiQ
Message-ID: <CALzav=fa0rxnf-ufDmV0uhA+zhoOB2vp9ksfNpeE0amxnLt0jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] liveupdate: kho: allocate metadata directly from
 the buddy allocator
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> KHO allocates metadata for its preserved memory map using the slab
> allocator via kzalloc(). This metadata is temporary and is used by the
> next kernel during early boot to find preserved memory.
>
> A problem arises when KFENCE is enabled. kzalloc() calls can be
> randomly intercepted by kfence_alloc(), which services the allocation
> from a dedicated KFENCE memory pool. This pool is allocated early in
> boot via memblock.
>
> When booting via KHO, the memblock allocator is restricted to a "scratch
> area", forcing the KFENCE pool to be allocated within it. This creates a
> conflict, as the scratch area is expected to be ephemeral and
> overwriteable by a subsequent kexec. If KHO metadata is placed in this
> KFENCE pool, it leads to memory corruption when the next kernel is
> loaded.
>
> To fix this, modify KHO to allocate its metadata directly from the buddy
> allocator instead of slab.
>
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: David Matlack <dmatlack@google.com>

