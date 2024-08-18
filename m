Return-Path: <linux-kselftest+bounces-15589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4A955B59
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 08:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0657281EA1
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 06:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC7EC152;
	Sun, 18 Aug 2024 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehz4zDEC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF50D515;
	Sun, 18 Aug 2024 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963000; cv=none; b=ZGkv5h+Pmd22FBvqVj9ftEj/5jVw/O/qvAkKfzcpjQuzr2YYGEvTf+1L/T6/6NFRPufw7FsUeUl1Wcv7M8XD6Or65g5x4VZO4iRkITr20BM3Gy1DgEaJ287sVbmzhppSD5wCe+8weEvGevQeNVTzQwUdUhUA8SzvSToeZtdc2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963000; c=relaxed/simple;
	bh=cmwJOfGRINdC9eNirCR0v368/sKckH2gDfeG1BPkfhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mraIiGi7qt3eYle4diHud2feprSdHGhTtQ5Jg5yLuT/b/AqEtgAmFpfhyKf5nQQJoudGHyAN4nnJUr9MOSMfZKWhygi0FOydti5zjlorugmSN4QgmqK16aOoK2V2BPia47xJdhBBkJaOcLWMj/amkp+8NlS5//skzJ6rZiLkgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehz4zDEC; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f51981b1beso1083505e0c.2;
        Sat, 17 Aug 2024 23:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723962998; x=1724567798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhhLeU16UIaSURwOIjTFGnW/8lJXcoPE5+u9c33DNJE=;
        b=ehz4zDECJuninCaT2cKJfQuYiaJ9j++2KqtqUhDvqSQvbgMSqSNVdZ83QyW8xq0Dmx
         pzA3ARPJgh9cL1x8/dwCPYhhL0pCqrRvlmz1F4ivjfz4g04ZNPh4FOEa7LoUiTaBSSwp
         206er3IIwoNP9nyvatnbteA/b35Trk6aQuqlTemhEClbRptmTASzMxrHE/WsrT+n+ZUI
         F56hrHoEQBGvwUj0o8HxEFHyVz4RKAnVpbeZWmBg1fq3c+PakYUIRWEo5X/lEMc56Q6C
         Uk97kJ1h4I7T2XBSZpL704LlonzsDqfUzGlm7mvk97HxzXk/xfD+TiESdjUTlP3VGIqi
         uWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723962998; x=1724567798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhhLeU16UIaSURwOIjTFGnW/8lJXcoPE5+u9c33DNJE=;
        b=JAOqBD9sKBa9NFWfC897yaX1MmMrhu6ZbuNEaCW/5AjZ+2s1lg7qScNXqvZ6tXVzDi
         HWf3bR8TK3DgUUTRfx1dPkqYkI7Zzaf6xTMgS9hdz23dvsX7298D6sFdv1mN4WCkkA7J
         D9T/rG7eaPwXH482ED7Nu7zIOTVOjuNCFBree1JnvwYXoj0XF3kWR/QTBdH3JTPvZC7g
         ZquKLEx6aBkpbRWZ+w/xGZdQ4f8jEB5C7PFADvCXhEIsnIkXXus2pstlvgruVxz4yTR2
         6ULgNa8eRav93F3/qdgCQUO84e8uZ+NBfr6eChamQwO+Kw7iOloou45UM67gTbPBZZUP
         wtvA==
X-Forwarded-Encrypted: i=1; AJvYcCWLAAwOyR+TBjO3pW38eorj7/U1LahsZLeSLEx2SixssczbTH2gR42AbKf7xbSnriOGi3tf5i+RdjT5AO+ZoPasuE1xFxjCmOoKAwyVOzD4mOKDCBQjIHS28AGBBSw5W3AtMAZf4UkU6vI26KJW
X-Gm-Message-State: AOJu0Yx7t2Shos3shq7rlwFJ6uV7A2bQAaJHkYuZGyHVveztGjNtEwdv
	2fN9h5RNxJG1HOqDaffY/YXhXhS6o7IdLBPgGx4vn/cep0fleS1Su2zQZoN1S8EhpQ0JUsxdKv1
	ih28r2+HyacjJIDQeTPxaJ3DPAAQ=
X-Google-Smtp-Source: AGHT+IEko2GfN0dNu+2mfgzBxN5cTLajQWzx4nzczvmU1AenlierGwmKiBWginPTJ0iSjxOhz48+A0QcGpjG2DH037U=
X-Received: by 2002:a05:6122:2092:b0:4f6:ad39:dab1 with SMTP id
 71dfb90a1353d-4fc6c5f094fmr9153942e0c.5.1723962998054; Sat, 17 Aug 2024
 23:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com> <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>
In-Reply-To: <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sun, 18 Aug 2024 07:36:26 +0100
Message-ID: <CAKbZUD1dA2q9Yv_Z0S4SgvddHxnR9KZddYHAbMLsV+dt+bf8dg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] selftests/mm: add more mseal traversal tests
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 1:18=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
> @@ -983,6 +1019,41 @@ static void test_seal_munmap_vma_with_gap(bool seal=
)
>         REPORT_TEST_PASS();
>  }
>
> +static void test_seal_munmap_partial_across_vmas(bool seal)
> +{
> +       void *ptr;
> +       unsigned long page_size =3D getpagesize();
> +       unsigned long size =3D 2 * page_size;
> +       int ret;
> +       int prot;
> +
> +       /*
> +        * Check if a partial mseal (that results in two vmas) works corr=
ectly.
> +        * It might unmap the first, but it'll never unmap the second (ms=
ealed) vma.
> +        */

Bah, obviously this comment isn't true, munmap is never partial.
I'll change this locally for v4 if there ends up being one.

--=20
Pedro

