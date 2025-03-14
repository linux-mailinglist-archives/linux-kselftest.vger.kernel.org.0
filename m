Return-Path: <linux-kselftest+bounces-29071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263DDA61D2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0A13B891D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAB19883C;
	Fri, 14 Mar 2025 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWwo3YnW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE2193436;
	Fri, 14 Mar 2025 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985484; cv=none; b=ec5aBP1Ss565yHaNXfkucSoQCTdkePIjfBqD3ccZ2Y9GaILPU//LjBByjucZoM+gs2dhwsjOHBFg9OoCVWfE/ltU5zaCAEMdlFR2Jc/RyHEmeyB/gXpOdiWugSmoeMqP0yT2PO/+qBfuGn6l5Xju2usX/fs2Av0dBrQuFDUXfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985484; c=relaxed/simple;
	bh=trvATQMMtPARmBs7+3eThby+EHuM+0LllJlUov6evOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJgxGOcis8rAIhg2T+Rtc72JdpriK4SpoZCsSMoIH1pE8nihRx/Ti+opirhq7vUpKDsvy9EqSVgkqPe3Skcfgn9juw+ZPu61h+pClAreb2p7E48WRj5C2H76nMhsYCV9mqDRqwSshvLnfsVjKSdvlkUhMH7aGXIUcz+SfR3XOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWwo3YnW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30beedb99c9so23063081fa.3;
        Fri, 14 Mar 2025 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741985480; x=1742590280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NXsVqALyqPmkoI2/lvbd4sss+flvtw87rVkDHiqm+I=;
        b=HWwo3YnW7efdfJ2rrWcYOgIfcsJ4LuU6wkL+KPscrJHyw3sD1gK3mex5vhKIuSPzBq
         R5PZEzzaIe6hrFKdssWKi3rM0SA+4BzOIXiGtgdqemCdiuKywjKOYDpd0e3dgP043BrN
         gWO9henHLSTArVQ1ERHRW7seZjBy5aYr3Sw44dggub6v+JCHb4c4TSCHKi2LNyd1ljy8
         JwwKNLjaCiejFiwWTD0fCxkX91V9/CsKpAEb74vK+VfITYHUcMcJfbzuLJn2x9mrOnX2
         UR7GXtKMTUA38Rx4U5KoXfrB1q879AMPqgVwc5rzRrqKfS55t13WCa4QrpuPkfYc6mSp
         c5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741985480; x=1742590280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NXsVqALyqPmkoI2/lvbd4sss+flvtw87rVkDHiqm+I=;
        b=utPBcGLXXdFUanQZ1GN1S45cUIWRhJA1cevegdtQPM8Hl+BVlxVD7c43mBRFHvqPsd
         E3A9aAvqQ0RvmstNBkHrUk4oF9KMpuIML0xRpIzixtjecIuDthVWga3LmlHlOdQv7s4l
         ORGMlR65A21FvUD17FdFg1luqRrFErAwhEfNN0awA3y/hIOHBvu9uLjh1G360m3PxSd8
         oQ6CkFP4qhJiE911itecDj3qTaot2KJk1Sf817am8Bnw+iGfXtlJBnKhZ51McdkQ9JoO
         ZVhBuFVZO+89usMsn7l47uDFsxB2rXxbg/F0+7UEvLcIPeOZyYhto2/00trlxem9La+g
         psOg==
X-Forwarded-Encrypted: i=1; AJvYcCVsEENyfNG7/mntZF42NG3BqmupJIi2KAzB8Oe9p7UR3EW4174fq19w2yMwzTpPFpi6XW9rL72hwSsLMNe8uDk6@vger.kernel.org, AJvYcCXz2e/GDc3FlE/1mW+yThPzE6z5m0HoGtEFvSbY6oo7DdSTjW9P073ht0bhOnw7sQ1eZd4bN4DYKf5/C2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwq8sSiFex+e9v2DadkOt/5gYHqBNK2cgGX5eo5memxSOUC7Cj
	acP7MxBfxrDZVwYJsUllXXrZ04VHDmIwXuAeXim6iBETTWNK0IOR/CqrGy2qJxuWwzoL8DbkeQB
	40JcOCKPHXh22o6rMxHrjrmQ7CT4=
X-Gm-Gg: ASbGnctrg8p31E6c5JmVgCeX0ZyHosVs+hjWdCdASFCopiZ2nyBRvyvPpjUA2s7UmwT
	klYrZZ0dudfYY/+H6B49YSTiWRlGvxg2/fpqCtE8pbTtABaX1fjkIEzP4vW28903E0dEHMx5THS
	pRNkGjeKN/wu4/7cHmTTDznCCXljhD1Qg3mLeYcp2FfTi0K7wZ4yJ8CxKV49M=
X-Google-Smtp-Source: AGHT+IH41BeW/qFxhnbrNR8x+Pf2zBTBkxytoQmSHIk8JKw5d67KiImMumHFlJc+VGTnd2eDvdZEcibxlZuJvLQGhZs=
X-Received: by 2002:a05:651c:2101:b0:309:26e8:cb1a with SMTP id
 38308e7fff4ca-30c4a8dcaaemr15718661fa.30.1741985480089; Fri, 14 Mar 2025
 13:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <Z9QvRJE0Yun5mfsN@pathway.suse.cz> <202503141345.0D3FB87E3@keescook>
In-Reply-To: <202503141345.0D3FB87E3@keescook>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 16:50:43 -0400
X-Gm-Features: AQ5f1JqKvqsnOkg3fCVQBg496CuK5LRwjHHqovMNU5iXxqYwVehvh-xWtC7AKek
Message-ID: <CAJ-ks9=zFuH=4Sm-zqR_kAuv=fmwpCh__fXgxcoRgc5XuQ46Fg@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] scanf: convert self-test to KUnit
To: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 4:45=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Mar 14, 2025 at 02:29:40PM +0100, Petr Mladek wrote:
> > On Fri 2025-03-07 06:27:33, Tamir Duberstein wrote:
> > > This is one of just 3 remaining "Test Module" kselftests (the others
> > > being bitmap and printf), the rest having been converted to KUnit. In
> > > addition to the enclosed patch, please consider this an RFC on the
> > > removal of the "Test Module" kselftest machinery.
> > >
> > > Tamir Duberstein (6):
> > >       scanf: implicate test line in failure messages
> > >       scanf: remove redundant debug logs
> > >       scanf: convert self-test to KUnit
> > >       scanf: break kunit into test cases
> >
> > Kees, could you please take the above 5 patches as well
> > via the tree moving the KUNIT tests to lib/tests ?
>
> I think you mean 4? Sure!

4 by my count as well :)

Please let me know if you'd like me to respin with conflicts resolved!

