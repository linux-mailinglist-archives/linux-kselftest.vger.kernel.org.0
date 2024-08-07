Return-Path: <linux-kselftest+bounces-14934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8F94AE42
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C39B21457
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A641369AA;
	Wed,  7 Aug 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiKz9yac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFF2209B;
	Wed,  7 Aug 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048710; cv=none; b=cEYvbpczp3VsFJZCRh0Q1ysfe2HNC7H4o3bMgyVyly+LnObMrxn+N9Rs8uHrJdvGtJvUU/T3qjeVHb/e3S+7tfe+pUtB+myst/H1G8wPf5QPb5vYxBGaCENWBBjblrr7+rZvqvTxggru8XNLBq9wkoDRUIAEhPNEApVm+1nfnBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048710; c=relaxed/simple;
	bh=7UoBEwKBvrQT2AMxf80k+ltND63+oKRLomyxe7Y1++A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tif4CgMWzKNibvrmHeQtUuoPMaLsgdB6KnpQlIczLCF8/Iy/3rSdMTbZoTDc/arrC7tw+917vVAQjBxSB9B+QJx6Hjx2qgdndiBJSEafXYx3XKVen2MbARkWgP66K/6KzjeBWqLThr3UDFoErFuvsfecfAiVEPZ6mQA44rqTzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiKz9yac; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f527c0c959so17793e0c.1;
        Wed, 07 Aug 2024 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723048707; x=1723653507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mgCmD2KAcrYzQNy1uvrHNBnFb3EiB9zFOmW/TFGDZ8=;
        b=kiKz9yacHSeNozVU3nKAoo/EazPIftDagpxFYFzQle4Ow3OHr59Fnw6oOZ+ZFUe2j3
         AfBqzag2EFHTLiC/pQhhwEipEcQbgblwrRijpa2X6acnNYQVW1ck0zFWGJKXyLWSjVJF
         lGt5WDsUDuGiVmI/VYZHHEwjc5HhJl0heZ4Ln13NZ0pIIpDOOqdvAcw8D1yV/fpiZ8QK
         tQ3Q+MP7ouSBI8kmq6A/Jc4gOt4kVheE2ld/Wblht5j2MRqNl4r9MFEXkuWVK0R4vQar
         bJrbjS4wOSa3ysAYevwZGxIhQf+AkGGrg7ut3muAUzBi0UPGP4QvCdVhUmyJNj9zoVId
         xTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723048707; x=1723653507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mgCmD2KAcrYzQNy1uvrHNBnFb3EiB9zFOmW/TFGDZ8=;
        b=HBe23N8gPVMREHCd75i0ZzhY3mUjch1DO++hrSktCGopZX4wwjS7smsCo8k+F8Y9ZT
         ifgIVmEW1wzLuIazeJPRaSp/S33gtJfSXmqsfSN5qszDXgxcq1fGN4b5Q+HX/njF+4ac
         IKCtSOv8G6gUwixjt84qVa6DH3kMSoi8uVfNd5ebNE8Yc36/TTgGbQKifPIGCE4hTF41
         yiLy8sAfnvae+cQJWbpypGGyEIA888F2RAx7oXI3t2o9lFueYN6zhYb2rsYd/0/k1Mdx
         c9G1m2sNKlx/tJEQgc/HJkTevLye+v+UKypcTJ2ZEPSV+F+YMzHi/7N6knj6+Vf2ln2L
         UGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3jMJiPsdQHtf1GDAdPY7d1PeDeSQyi478MohMQO6T7gfA1Yg1q7py5R71hYlwngncAXd8owdI7sY2rO+KqAedenixlahWyjxwdJl2ym8rcObhMdmu+EdqEC6d8q8HiP/HHv9iM/g+klK+rqSpVbeBCJH1DV8fpW8P2H2xBSSMtV0EppeRJ5exMLbcGSKY
X-Gm-Message-State: AOJu0YwAutz9oQAi0h9VN1na83hUAhPVOH41b2CaMDGBIKaXTHLNKAE2
	bsKBvfr1htGlcEv6g7CCSJ46zAWN41yebI2hxngJTGtjn8nOVObosXXUu6RRKPrWnQUeif6APl0
	KskLz4y2SJRCYjKsKZEVZtX3I2+k=
X-Google-Smtp-Source: AGHT+IEaPdM7pIWYj7gKtQjNufq1NVzXdVjvhAsj0E+4bsWTLCUCwCLraq7BAD6I5PzYhwVL6S2vmNZdAhIlxFNafD8=
X-Received: by 2002:a05:6122:1d16:b0:4f2:f1f1:a9f2 with SMTP id
 71dfb90a1353d-4f89ff6c61dmr22140799e0c.4.1723048707355; Wed, 07 Aug 2024
 09:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153544.2754247-1-jeffxu@chromium.org>
In-Reply-To: <20240807153544.2754247-1-jeffxu@chromium.org>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 7 Aug 2024 17:38:16 +0100
Message-ID: <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
Subject: Re: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, jeffxu@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 4:35=E2=80=AFPM <jeffxu@chromium.org> wrote:
<snip>
>         /* shrink from 4 pages to 2 pages. */
> -       ret2 =3D mremap(ptr, size, 2 * page_size, 0, 0);
> +       ret2 =3D sys_mremap(ptr, size, 2 * page_size, 0, 0);
>         if (seal) {
> -               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> +               FAIL_TEST_IF_FALSE(ret2 =3D=3D (void *) MAP_FAILED);

MAP_FAILED is already void *

<snip>
> @@ -1449,18 +1457,16 @@ static void test_seal_mremap_move_dontunmap_anyad=
dr(bool seal)
>         }
>
>         /*
> -        * The 0xdeaddead should not have effect on dest addr
> +        * The 0xdead0000 should not have effect on dest addr
>          * when MREMAP_DONTUNMAP is set.
>          */
> -       ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMA=
P,
> -                       0xdeaddead);
> +       ret2 =3D sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONT=
UNMAP,
> +                       (void *) 0xdead0000);

You still didn't explain why this test is actually needed. Why are you
testing MREMAP_DONTUNMAP's hint system?
This has nothing to do with mseal, you already test the
MREMAP_DONTUNMAP and MREMAP_FIXED paths in other tests.
You also don't know if 0xdead0000 is a valid page (hexagon for
instance seems to support 256KiB and 1MiB pages, so does ppc32, and
this is not something that should be hardcoded).

I'm not a fan of just throwing random flags for tests, it should be
somewhat logical.

--=20
Pedro

