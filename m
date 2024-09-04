Return-Path: <linux-kselftest+bounces-17142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D096C2C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 17:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F144D1F21EE9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BFE1DEFDA;
	Wed,  4 Sep 2024 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgDzxzMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FDA1DEFC7;
	Wed,  4 Sep 2024 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464683; cv=none; b=mmxHCfi60cyRRh7mqL+VZ3PIgFKqltqbanHP3WrwNl0vwS2lCI4GsUsq8Rm+vVwamC5r1rEc4cfgZ5k1Rdmmgwou3zxXa4Pk9evQGL4viZJhMWnoyLo4faKE/v89p1CFr/YIVvE6LBqRRjpVwcZ4B9eUXtqQZCmPuisk8ngDcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464683; c=relaxed/simple;
	bh=M5kDyk3KDJrwNFQ/gMQLuv75Z5Xu3qZfJ8KRs3eNRhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwTFImudYBte0kziPFhRzKVJXIKhIFJISq5+UnpBEfx76n7fL9ZlWEz1fVHMnQeq6M859kAkz3rsBmp3Dc7XV3eN23M3ZdXogTtNfSLzgQOuHaVJP4bydbtbCGhJrFyJDqVR7HGOL04CW1v/++RygOscuQRb26T1qXYpC0f6pZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgDzxzMt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bfb50e4e6so39007175e9.2;
        Wed, 04 Sep 2024 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464680; x=1726069480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umDL6mMF2LGIC/gv7mZ3udOWUJnQiCok84gUZNiT1Zg=;
        b=YgDzxzMtMr/zAoWxRdZOiKGF4xEY/5V8B5Kg+pUTuAhn83qmAuDnmXz5qXsxZInL9M
         XRy8eudNWi10ZRxEecvucFQqnzG3hLPiCF5OX1pUDAbtNgCi/AN4kxSoXa0HlhdTLgY8
         UNt/KIvRjAS7rVDZklCabDL1RUiyvG76l2cZO5rZldQfaB2b4IUWJE8OcZvglRWBdEzG
         rmf5QNAseJHFvCMPGax0EzicqIbVHpCRE1HmLh3FHjrzu8uZeGp6ELo+P3Uowx9aY77p
         FnJQFVANaF297DndnRi+dXBI53UhE0F84L7eWgbSdHMvIuH56M5/xjfMBJQD2mTrsk2H
         5UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464680; x=1726069480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umDL6mMF2LGIC/gv7mZ3udOWUJnQiCok84gUZNiT1Zg=;
        b=SJMHEpC+CKyMW9xOk6hEccJj1McQ4fcWhJqzr9waWz/zcc8sr+hSnyIUA2QdvfYlCQ
         2Lqg2B72CQlH0bsdRk//1NXvVv4T2J/mxTSXavnRFrsB821/f5Ls8VOVvlOcBaoKm8Dz
         /H+OKBDtt9GJwwDzjPyqPneZ9q50LYRDRV/XWz8PR6pXJAPl97nOcf0txLq8vWT03ya4
         O65SgyeWgNdVZHZm9wU7iNvkQgC2ThTHDN9x/+2cCrZ/lG4LV5Cq5rxEzfs3O9hsKIok
         6tDLRiHJIvSgIC1F9p+1MoqbOnzkFQ4Y+FqYbC8CJKF86yS0q1WW5t4yZgMGO+pi79m9
         Sezg==
X-Forwarded-Encrypted: i=1; AJvYcCUUagofSYhIoZif73Sjo94LSIcKDT95O3yvJ0GtkmCyhRKUVXTIMvTAiphnqYSyThbB4ePPl9gQ@vger.kernel.org, AJvYcCWzaeC44eJuroV1dwgZKeA99mR17Vjbe9DTdvgv7JNBjDoXAzptaWlFWQNfB4EGqQ6Tpcvk3jiWgNNphnz/tOs/@vger.kernel.org, AJvYcCXnrDlOK4hBaSbZfH2HfBN5pQVCh29dQuy+3/NInZGPRi+xkDlG/yqUu01axyXx6BYPR2oE9rVFWpGcMvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85OkQQUrDtEzrQh4gU762WJ57lx4Q7wn8lqiOOmtmuWvauomy
	FypRlYCa5MWA5OpZ77I7cE7CjXkL6S4jdxUYJ5y9PJIewAtGM/q0iUddT4x3YJYwlrqy1y3ajqX
	Sbdvb900ArhK76sj5UOKmEPM9djg=
X-Google-Smtp-Source: AGHT+IG/BmSVshTuSzwHzg4qPrMOTOCDcwQIxT7cdW1azDwNVPeYpby/rAXvfjK9JwzNmGKJtZBXoDCTRKBu22h8oBE=
X-Received: by 2002:a05:600c:1914:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-42bb27a9eedmr160835315e9.29.1725464680483; Wed, 04 Sep 2024
 08:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902120314.508180-1-linyunsheng@huawei.com> <20240902120314.508180-3-linyunsheng@huawei.com>
In-Reply-To: <20240902120314.508180-3-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 4 Sep 2024 08:44:03 -0700
Message-ID: <CAKgT0UeHFm9Oy_TwHgtsWpr6EMRAxsKn+H-p8dUTgAtBJwbzpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v17 02/14] mm: move the page fragment allocator
 from page_alloc into its own file
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 5:09=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> Inspired by [1], move the page fragment allocator from page_alloc
> into its own c file and header file, as we are about to make more
> change for it to replace another page_frag implementation in
> sock.c
>
> As this patchset is going to replace 'struct page_frag' with
> 'struct page_frag_cache' in sched.h, including page_frag_cache.h
> in sched.h has a compiler error caused by interdependence between
> mm_types.h and mm.h for asm-offsets.c, see [2]. So avoid the compiler
> error by moving 'struct page_frag_cache' to mm_types_task.h as
> suggested by Alexander, see [3].
>
> 1. https://lore.kernel.org/all/20230411160902.4134381-3-dhowells@redhat.c=
om/
> 2. https://lore.kernel.org/all/15623dac-9358-4597-b3ee-3694a5956920@gmail=
.com/
> 3. https://lore.kernel.org/all/CAKgT0UdH1yD=3DLSCXFJ=3DYM_aiA4OomD-2wXykO=
42bizaWMt_HOA@mail.gmail.com/
> CC: David Howells <dhowells@redhat.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/gfp.h                           |  22 ---
>  include/linux/mm_types.h                      |  18 ---
>  include/linux/mm_types_task.h                 |  18 +++
>  include/linux/page_frag_cache.h               |  31 ++++
>  include/linux/skbuff.h                        |   1 +
>  mm/Makefile                                   |   1 +
>  mm/page_alloc.c                               | 136 ----------------
>  mm/page_frag_cache.c                          | 145 ++++++++++++++++++
>  .../selftests/mm/page_frag/page_frag_test.c   |   2 +-
>  9 files changed, 197 insertions(+), 177 deletions(-)
>  create mode 100644 include/linux/page_frag_cache.h
>  create mode 100644 mm/page_frag_cache.c
>

Looks good to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

