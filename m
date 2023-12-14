Return-Path: <linux-kselftest+bounces-1963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF86813B4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 21:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8975FB2110A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FDA6A028;
	Thu, 14 Dec 2023 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dka7iRwj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED86A006;
	Thu, 14 Dec 2023 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b9f727d94cso2331719b6e.1;
        Thu, 14 Dec 2023 12:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702584704; x=1703189504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfh8Dy6cQrhts0Y+UCJGg173DSLFoHSRig78lNgd6Fg=;
        b=Dka7iRwjqy3XnAaS8QUUWkywJDET06cor2wo8xod1fSukvDJhMmtCSP9lYgHPROffT
         l4isFcvnZkZahKSlvTXBToQ3YXAPpmM+E+72jLVaqrdxydicjFfsQ+aLCkfStZMOesvt
         Lx+IyW4BeeSUzUzEBB2oauywMiQVTkoeflGX79GK4p/eYAKxYNow4KUa25B0dczXJXVS
         iSII0Wn82S6CRPKALbbwg7qfHy2fU6AcFjsNW2vb0mvgkFaxH30XFsTLrGW3waG5Q5pX
         FfAmedMffsnbT5M1dWIwJWbI9hbhiLM97wh6KiBsG7wd7q2R4GHBdeAkR6Ki+pLFQhvq
         MyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584704; x=1703189504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfh8Dy6cQrhts0Y+UCJGg173DSLFoHSRig78lNgd6Fg=;
        b=TN2NxRhCDJZZxVlPeDurQOL3rAt0cSRb0LU53gztzNiWHkOy5kHJdZcvOFDQo1ibQ8
         3xUm8TNJCBcSOnEybJy26zweCLBO4X9evsMUQrX6mObk9kCa9QfZ0pqKfJmxaQuKKWDq
         FYmVDEJ2Yfp54X9ksQWNdRd9h7rIX4ZC4oudp3bU2Zr84CydD2DdLtIzHDMT1rvJwfio
         fvigWYJ7ozaFd3OmmEkEiFUx4WiGKJYM2OcqKu60XIdDFtABkkL8uO/XgNXjDpoBMG+Z
         y9dI2bCek+3YD1y1GtrwGkvRuu+0/sG6YFlHQGxSKdGTommJw0Z/sUif/YXO6Jc2Ccb0
         05QA==
X-Gm-Message-State: AOJu0YxzUIoH/n3PaIU04beB4ulbaofvEq7ninchLooOnfXJuNSemFA1
	FI6tZdOE/w0sN7elnSWGwd1XsvkmAhrzkTL6A1coFag3
X-Google-Smtp-Source: AGHT+IE5OtfH6BmGn7Qjmv1Kb5hVv+UX/aLg+H3qizYtKhsIVRhRCc9OkzMWNCWsZ1PQBkFFBiPeRwTjP8svWjT4CCo=
X-Received: by 2002:a05:6808:3849:b0:3ba:c52:7245 with SMTP id
 ej9-20020a056808384900b003ba0c527245mr9035807oib.95.1702584704448; Thu, 14
 Dec 2023 12:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
 <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com> <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
In-Reply-To: <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Thu, 14 Dec 2023 20:11:32 +0000
Message-ID: <CAKbZUD09VKfxsz4VCp+0-Y-cWJ-n=dV+t45Aan10HEhFCjxWdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Xu <jeffxu@google.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:07=E2=80=AFPM Stephen R=C3=B6ttger <sroettger@goo=
gle.com> wrote:
>
> On Thu, Dec 14, 2023 at 2:31=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 13 Dec 2023 at 16:36, Jeff Xu <jeffxu@google.com> wrote:
> > >
> > >
> > > > IOW, when would you *ever* say "seal this area, but MADV_DONTNEED i=
s ok"?
> > > >
> > > The MADV_DONTNEED is OK for file-backed mapping.
> >
> > Right. It makes no semantic difference. So there's no point to it.
> >
> > My point was that you added this magic flag for "not ok for RO anon map=
ping".
> >
> > It's such a *completely* random flag, that I go "that's just crazy
> > random - make sealing _always_ disallow that case".
> >
> > So what I object to in this series is basically random small details
> > that should just eb part of the basic act of sealing.
> >
> > I think sealing should just mean "you can't do any operations that
> > have semantic meaning for the mapping, because it is SEALED".
> >
> > So I think sealing should automatically mean "can't do MADV_DONTNEED
> > on anon memory", because that's basically equivalent to a munmap/remap
> > operation.
>
> In Chrome, we have a use case to allow MADV_DONTNEED on sealed memory.

I don't want to be that guy (*believe me*), but what if there was a
way to attach BPF programs to mm's? Such that you could handle 'seal
failures' in BPF, and thus allow for this sort of weird semantics?
e.g: madvise(MADV_DONTNEED) on a sealed region fails, kernel invokes
the BPF program (that chrome loaded), BPF program sees it was a
MADV_DONTNEED and allows it to proceed.

It requires BPF but sounds like a good compromise in order to not get
an ugly API?

--=20
Pedro

