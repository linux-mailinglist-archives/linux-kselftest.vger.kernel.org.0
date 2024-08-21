Return-Path: <linux-kselftest+bounces-15891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D265F95A3FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF6CB20F36
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0702D1A7AC6;
	Wed, 21 Aug 2024 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+4VSyKZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760F13BAC2;
	Wed, 21 Aug 2024 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261807; cv=none; b=g0qD6ojaCNIY+Gz8Mv2QbPUW9QjtTq6jnYwBZ7PA0jHfNbAxfx/7tuvZlw5HJt9HnzVHbq6heOp3X25RAcr9FrZidFhr4p88JDN7e8ejPYw47JycdLytPgZrrINEHzrNVN7r6Iyee8moLHCyu4sS3j/NkYgSumYDn9TsxbA/BQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261807; c=relaxed/simple;
	bh=aHMiN4EaB/UdCj4RPaF7ba0pXTDjY7ukxf24IF/FuOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GV040el4Oul50X55Zl4wZdL+sjRRYWZxSds0+9zz1a/4V7RS1rXg5RV0jyPA4wvrmtn7rgiZW76d/AsB80yFLPGgkSiRYS6OVWl259/UZeljWstCy3/0aksiWPNa8NjvIrjo4LCINz+1FtvnX7Ewx369zq8bHO4n4/e5trgVyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+4VSyKZ; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498cd1112c3so465248137.0;
        Wed, 21 Aug 2024 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724261805; x=1724866605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzmV3dq/6WL1tHil16o4FRJDEyqanWxlT+lh/pdRUxA=;
        b=F+4VSyKZzKkSiDxahcnh95mmK++tEE6VLUxCSvxvjTWgFLVIuLEsHiKjD7A1ZGwm5l
         l4D9ZFePmd+nF+KL/tMmTnadX6YgqAtLmYl+uZyMdeSvYlhkJniiNPC817qtA4cSx4AD
         Y7/3iE8fnsWx54z5az0FA5hdBX2Fvwtva8rii5IF7sOI32BAi2t3sJOIhjmXMxVaalN7
         hYr90EzHEj9rXyp9PDSbgDUt8/MRsMFFIMVeRR32voVu/OsNq0Cay66xrP5gUafx+xZR
         FQlbDm1nfLFxn8bUHO4n0Jr0hXTeZtKzk9Rw1ALF64UMGV87X2rKLkP+3athsXkNaPoa
         8fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724261805; x=1724866605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzmV3dq/6WL1tHil16o4FRJDEyqanWxlT+lh/pdRUxA=;
        b=m06z+HNsBwVvBCh41CJJqFvWZpciYBoPahb1EzmroxzcggtXUw4KIN49sx3hjXRmVx
         nvleShQ2ZIxbh97fYdR0e1+NwQz9A7g3BSjZa1QMwS9a53RseTGwJtNTH6wVQPu1yzLc
         38nbo4BJOGN9iynSq1AnOXOf5ga/M+1hEuU8oo/ukLmwhGBCYdy8kKQ8pV4wF+CkfyiE
         apuvBTa5O1E9nd/ljNilvSzEFBQ5wdmeB6QW+V1kS5zuTG7dP5Dhk5T23A9vm+WJE/Zs
         ycYWham+A/M48rEVJzhbfNnfo9uTCZ2W3K6U8i5ET/QVK5nxIcaJpFPua6u0tyKhqAvn
         cXLg==
X-Forwarded-Encrypted: i=1; AJvYcCU1AIitOA5H+GyN1GsSt7NvSgCExgiSqXj915w2c5g/OQ9N4gA8qQGhsJbruPtRHTLpVBdVCogkaCRGd/jjFo8B@vger.kernel.org, AJvYcCU4pJ32yxPTqIaSqUMopBVfIe5tyc0kRA97086tNsAVxcrIlqgAq96feV1lkwcSfHVhNJXkAAJdgcTzeB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0XiO+s5ERiqOCP3HAeK8jjEl7WI5BmQH2cwSQNHRvU1oWUeF
	XppzXa+gNIcOFmkF06gIcJbjhKAuTX++Gs5m0WEFosZpH0Xfg4DM7TDZk0qeEO8m7/SiGvrWCNW
	S6Ii09OVnsdzgNsvcebIG9osi450=
X-Google-Smtp-Source: AGHT+IGZ6NGVAvhIhrLmHVtAEJ3MrzrRe11p5YEwxDxGQJGa5BkvBZS8kr5jvmZ0pUzzyyzH4ZW8NEbARZf733g7LB4=
X-Received: by 2002:a05:6102:b13:b0:492:a883:e1d with SMTP id
 ada2fe7eead31-498d2eab0damr3810936137.11.1724261805127; Wed, 21 Aug 2024
 10:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com> <CABi2SkWPiGJTv3FEPxD1OJYUAoePab8jG+CSd58UHqEsBeOYbA@mail.gmail.com>
 <CAKbZUD3Siwq4GZdOy-2n_txG2BMQ=m7PypB53sQxeLcBE4xYGA@mail.gmail.com>
 <CABi2SkXaBv85JF6gTd1w-f_i700YSj5JoK8z605bzd6gbPjKkw@mail.gmail.com> <CAKbZUD2ae80KNzqjK5RuB569+ZTv9YoCDgXmrC46P9a5gcxzWg@mail.gmail.com>
In-Reply-To: <CAKbZUD2ae80KNzqjK5RuB569+ZTv9YoCDgXmrC46P9a5gcxzWg@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 21 Aug 2024 18:36:33 +0100
Message-ID: <CAKbZUD2ZzxRzLjeXwix=i-tdfbEC6Lrv6d0VRirJvSm8PxLmJA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] selftests/mm: add more mseal traversal tests
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 6:28=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
> > ok.  Then this test should be as below ? (need to add PROT_NONE page
> > before and after)
> >   size =3D get_vma_size(ptr, &prot);
> >   FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> >   FAIL_TEST_IF_FALSE(prot=3D=3D0x4)
>
> That doesn't work because this region spans two vmas. I'll write
> something similar for the fixup.

Actually, I won't because this might cause spurious test failures on
e.g !TOPDOWN mmap architectures.
setup_single_address (and co) need a fresh coat of paint (wrt
PROT_NONE guard regions around it) and I don't want to be the one to
do it, at least not as part of this series.

--=20
Pedro

