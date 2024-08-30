Return-Path: <linux-kselftest+bounces-16810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4139665DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5B8B25954
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322B01B78E8;
	Fri, 30 Aug 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CiSoI/uv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DEF1B7909
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032331; cv=none; b=Z+lDTEd2qtvDGeIxPkX+ysFlihbNd8w4CqO1Oklsaxx0Fbc6/ISE8NIDRfaebginZ10gEOfO+kpF2iRZkh/Olq9ZG6Pehy5b3nms0/wIQRfbBnRjwPr8+SrDr9o8tF8nn18vmMzIPN0+wMtK6zUt47ULGOvtlUMzOtQMtk5DdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032331; c=relaxed/simple;
	bh=SUwxwdTKpoD+McoYuZdYTN3po1Up3ZeUUvAKwl9UHF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5W5fMsYzEfIDaEvgBQzAG48NKHftgU4XHnKid4xZctAKGPbgbhSArpOh65CLmDY+oMEObUcjb8C9yv0KP55mwvzOWNxxtHS1CQCV4O/ZbOK48fr4qEgQiJS754zxvQU5V6sx00MrkJv6Vxz3/IeCmJiqCKhP2tU0bRQs9xeWLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CiSoI/uv; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2611dcc3941so101083fac.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725032328; x=1725637128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+4o4v4tcr8rbwr78IwtuGgqIqaHJtCiQhKM2B3jmuI=;
        b=CiSoI/uvufHcpelcebQGFY88JntjVmGPOTGbl+8LK6Q0W45x8kvDpXOrHyQuEs29PS
         7xX5jgTJZCWoG05AUkkdFmArCwnd6DASqM+DaMQfqD1H+kQH5um7HDRvK5n2gpFRfZ8D
         1Wc9Y6iMSyBP7pffgktQhbz47irtl3sUlkVgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032328; x=1725637128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+4o4v4tcr8rbwr78IwtuGgqIqaHJtCiQhKM2B3jmuI=;
        b=VDdIR0NlhLAwHkXTYN+Magk2wXiyvb0+0rM2NlR2O3+iU2zD8nLE+wlK+GnCmrNYrq
         5cSWvSndHBCSt5HlMmKdT0g0mTNi5+W1BU7eK2x0HAEg2jBD4bEfs4mVE0w4FVOrz5Kw
         TWVhrxM/T4fgHJFn7SMlZU2QdPdiCHT6NpAPz1t9LxoccACB36faDus/R5JN6aU8DgWH
         oU96ernPCglkggfw5EkoVJFQkkyeOH59UsRmVOtGHsZiks4Qe8q7pqOWE8HYDVgxm5Ic
         ujtkc+IGbymEbmDRHv2Dc5ITkLlZOwT3pPOwg9Xh5NPmbo296Zc5sKo/AZUMcA1Vfc2V
         bnfA==
X-Forwarded-Encrypted: i=1; AJvYcCWf2SwkF/zBChcon+MNxHxWe/D8KrWIiLj5zP50fJ+16/Zzy3PlO1a+nl1kjgteg9aCg4OpKYx/tQjIsVk0tMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrwJkioPr4BesTpVRJXNCRYhKSeH1JE8ASH1ZBpsSSOL8zWAbY
	//0Ji8fUU1/quj93jN6aPS7JpoLGo3TlPIWp6ZV0vKh4QpQVMpx97C0d+UMV7oxpfP5/nYtBttK
	RYzdmDsPP6Xh+3LNuqLxNglfWbwicqrxQjtXrD2a6v928c+Y=
X-Google-Smtp-Source: AGHT+IEJiQTBdvk8h4QsAYlys8jQM2wMdP6B97VqSR8AYorWSjmSCBIEgEV5VPy0sNLSBaQCDqVav2FFWC5OzTvuD20=
X-Received: by 2002:a05:6870:218c:b0:277:6b90:1915 with SMTP id
 586e51a60fabf-277b0e4fcc6mr1280261fac.9.1725032328307; Fri, 30 Aug 2024
 08:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829214352.963001-1-jeffxu@chromium.org> <ixoelxclkikscysvlmfbvciyig7pqjbuwwhhgawk6fy4iookya@kmsjo3oetgw5>
In-Reply-To: <ixoelxclkikscysvlmfbvciyig7pqjbuwwhhgawk6fy4iookya@kmsjo3oetgw5>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 30 Aug 2024 08:38:36 -0700
Message-ID: <CABi2SkWxAVzbZ8A4YOTcOhOOZwj6j_7K2khMs1yFDht1_GuLvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Increase mseal test coverage
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Fri, Aug 30, 2024 at 5:31=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Aug 29, 2024 at 09:43:48PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > This series increase the test coverage of mseal_test by:
> >
> > Add check for vma_size, prot, and error code for existing tests.
> > Add more testcases for madvise, munmap, mmap and mremap to cover
> > sealing in different scenarios.
> >
> > The increase test coverage hopefully help to prevent future regression.
> > It doesn't change any existing mm api's semantics, i.e. it will pass on
> > linux main and 6.10 branch.
>
> I do want to be clear that we shouldn't confuse "test coverage" with bein=
g unequivocally good
> if it has the possibility to paint ourselves into an API corner where det=
ails that should be left
> unspecified are instead set in stone (e.g do we want to test how mprotect=
 behaves if it finds an msealed
> vma midway? no, apart from the property that really matters in this case =
(that sealed vmas remain untouched)).
>
I do not disagree with this. Let's look through code and comment on
the case directly if there is such a case.

Thanks.
-Jeff

> >
> > Note: in order to pass this test in mm-unstable, mm-unstable must have
> > Liam's fix on mmap [1]
> >
> > [1] https://lore.kernel.org/linux-kselftest/vyllxuh5xbqmaoyl2mselebij5o=
x7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt/#t
> >
> > History:
> > V2:
> > - remove the mmap fix (Liam R. Howlett will fix it separately)
> > - Add cover letter (Lorenzo Stoakes)
> > - split the testcase for ease of review (Mark Brown)
> >
> > V1:
> > - https://lore.kernel.org/linux-kselftest/20240828225522.684774-1-jeffx=
u@chromium.org/
> >
> > Jeff Xu (4):
> >   selftests/mm: mseal_test, add vma size check
> >   selftests/mm: mseal_test add sealed madvise type
> >   selftests/mm: mseal_test add more tests for mmap
> >   selftests/mm: mseal_test add more tests for mremap
> >
>
> nit: Please follow a more standard commit naming scheme like
>         selftests/mm: <change description>
> or
>         selftests/mseal: <change description>
>
> --
> Pedro

