Return-Path: <linux-kselftest+bounces-19980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26039A286D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021551C20CB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECC51DEFFC;
	Thu, 17 Oct 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0HNBfs8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17001DF250
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182038; cv=none; b=aqHNRphFQszOTzk7czLGmlwkN5ZdiaJ2psPplShBe3Uk2tegb3CepnYdsxeb9G5O9o9MqZh8eO4djXmGDzYnJ9Aitdhdyfxifs9FskeKrJiSeDLrV03RpSuSOj6ZxVpvfO2l0jIb+2JutUSglqi4fWKP1bxBW1OtkBuntf7F79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182038; c=relaxed/simple;
	bh=mBNQcJGarZlgLJSxTPWeDEc/pcZ4v2cyQ0d1mNFRZi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYp07sV1SDtNuHpQ2LbDvfAU5BGiTfGN7Wkiy0j3slYtz5mbZjXrTLV9URePop8QbJSEMRg8amVDcgXb+7oumpSH4DQ661yMSZwCy5Ru3IdRLmgte2JzHXQBzLgT06i4oJwmquc2/WcB7ckYAmL1tVJM1zMU2HSHeVbm31NUNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H0HNBfs8; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-288aacaec92so85625fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729182032; x=1729786832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QymMmt19qYyptlPRJSRQk64je7D5NwoBdyyf/N0dpQM=;
        b=H0HNBfs8mprioFB8NaCegyrlCOAjb9zJ7UzxN2uJ5gCPQCDe1RraICbjwTtG/xv/g0
         AnMw3A9DiyDPzE7GvC/UEcvEcrMzkKKIMNEe/s4qtD+UiOrX9uhye1gPQc0VB6cYQGD0
         fbGDurljAuswxPfrYkJjAFmaecUdeQ/6gOszU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182032; x=1729786832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QymMmt19qYyptlPRJSRQk64je7D5NwoBdyyf/N0dpQM=;
        b=ITy4Oat/+ZW0ptatARSMxxOoKNCPWBmVhChsGofy4S0c51q39p3VBb+jjFxGcxkq8D
         kliqXHK1dIxBbGON16VeLTI5RGJqfOAXE0oJ2i75Kd1B2SNgBGgIiaHcMFUPt0wN1Ypq
         dvnRE0ahwubTUIvGsIQJhngngTNY93pwlijGDEf3wPyDVtsgOok9l6BIxaBOyjH8C1i0
         C5TmWe0tbKBF6LdanOgnE9EwgVC51jc3cTUqivzmwGbAZQEQpN9r4kqc7qMEOyneheDv
         R+727/DZPXZVbOy9A0hjb4UYG+O9wIMYNxqwXxmKrEUtLl3vQPaw6HfWBF+o/v1Js6J7
         gDzw==
X-Forwarded-Encrypted: i=1; AJvYcCVGoi9dydHRzubqU9/iEY1lnOIVbfNGbQoHaUtLy6RCwIRrCE576mztlZhAKtKvPPYbB+AdAeSmNiXKaZJbMYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwREAY65sygOtuYFI3xac/btT0Gosw6acyy81c8G20BkOsh1MKh
	fAFKoAU/E0W922YcTHHsDDylRzTYV5f6teJZ0wjQBAA9O4ItIGNHwkKofuKq67WkqKeljQHj4OC
	FV8bMHwBj9FZ7jmIiXIbz9HVhstBEOH1BxYrT
X-Google-Smtp-Source: AGHT+IEAm4HkCe9fIJHtz5qGXaYcmz/2XucghwW7VoOOeqPX9ksuhDwSqQ6czP4kSZBu+AN3pwdMvWnVobwSCyu8uSM=
X-Received: by 2002:a05:6870:2101:b0:26f:d381:fd31 with SMTP id
 586e51a60fabf-2890c62049fmr974665fac.1.1729182032028; Thu, 17 Oct 2024
 09:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017022627.3112811-1-jeffxu@chromium.org> <3a1bbbdf-1281-4f44-857d-58cba583e3da@lucifer.local>
In-Reply-To: <3a1bbbdf-1281-4f44-857d-58cba583e3da@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 09:20:20 -0700
Message-ID: <CABi2SkU2yX_Pbr6=6uEiQnro88O5Mhq3NLwOsy=A=Qa5xeC6Yw@mail.gmail.com>
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:18=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> NACK. Greg's bot got to it but...
>
> As per Greg's bot, no signed-off-by line.
>
Sorry for confusion, I wasn't meant to send this as a PATCH, but
reporting the issue.
The diff was just sent as reference to repro the bug, and I forgot to
remove PATCH from the title. I apologize for the confusion.

-Jeff


> The subject should be something about adding a test.
>
> You later say you are somehow dependning on things (what?) to make this w=
ork but
> it's broken.
>
> Jeff - you're doing things that were raised on previous reviews as if we
> never said them. It's starting to get annoying now. Please try to listen =
to
> upstream.
>
> On Thu, Oct 17, 2024 at 02:26:27AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > It appears there is a regression on the latest mm,
> > when munmap sealed memory, it can cause unexpected VMA split.
> > E.g. repro use this test.
>
> This is an unacceptably short commit message. You've been told about this
> before.
>
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > index fa74dbe4a684..0af33e13b606 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -1969,6 +1969,79 @@ static void test_madvise_filebacked_was_writable=
(bool seal)
> >       REPORT_TEST_PASS();
> >  }
> >
> > +static void test_munmap_free_multiple_ranges_with_split(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 12 * page_size;
> > +     int ret;
> > +     int prot;
> > +
> > +     setup_single_address(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
>
> I'm not going to accept any test where you do:
>
>         FAIL_TEST_IF_FALSE(<negation>)
>
> As that's totally unreadable. I asked you before for justification and yo=
u
> didn't provide it, no other tests appear to do this, I wrote thousands of
> lines of tests recently without doing this - stop it.
>
> Also referene MAP_FAILED here please. You've been told before.
>
> > +
> > +     /* seal the middle 4 page */
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
>
> Again, you've been told before, stop referencing numbers instead of
> PROT_... flags.
>
> OK I'm stopping at this point, you _must listen to review_ Jeff.
>
> > +
> > +             size =3D get_vma_size(ptr +  4 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  8 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +     }
> > +
> > +     /* munmap 4  pages from the third page */
> > +     ret =3D sys_munmap(ptr + 2 * page_size, 4 * page_size);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  4 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  8 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* munmap 4 pages from the sealed page */
> > +     ret =3D sys_munmap(ptr + 6 * page_size, 4 * page_size);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +
> > +             size =3D get_vma_size(ptr + 4 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  4 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  8 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +     } else
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     REPORT_TEST_PASS();
> > +}
> > +
> > +
> >  int main(int argc, char **argv)
> >  {
> >       bool test_seal =3D seal_support();
> > @@ -2099,5 +2172,8 @@ int main(int argc, char **argv)
> >       test_madvise_filebacked_was_writable(false);
> >       test_madvise_filebacked_was_writable(true);
> >
> > +     test_munmap_free_multiple_ranges_with_split(false);
> > +     test_munmap_free_multiple_ranges_with_split(true);
> > +
> >       ksft_finished();
> >  }
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >

