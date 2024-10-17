Return-Path: <linux-kselftest+bounces-19911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A52B9A18AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 04:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E71B22AC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 02:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB6B3B1AC;
	Thu, 17 Oct 2024 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0AOFhFg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38825537E9
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132729; cv=none; b=JDolW56dcQbs8W87y6Mp5G3Hvnjh8sKDuZXuwwp58Z5k6deQyPN8r3KyexqQ5NJuJjMhOPCBOnkBwqVofqid8HKqV1l4vZ4VBAux0YgA08zLrnL5qjWH9Y2f5jq3XnO6xAKNHLaYh/D1yGEn7tvXJougWPgY3J+YKTEZ0XMMg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132729; c=relaxed/simple;
	bh=MFbE5/HxNE/3MWJa6C+tGfnobv5hU4G4+lDi6051zRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDhWdl3VnIhbCPw+8AIiRyiO9VmFqsVZ6oO0KFO+5PmXoyqsKiDXqregLhj7CdI6kpe3Xmj7Yqwrfw3h3lG2DJB35qJC0/gXlBtQUrr6AL0etmyihSrZQA6kSsmrRybfkrBgFwcuMNJkGfHFMFIUENvH2jWJHL/QGLAHt5MZK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0AOFhFg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so13563a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 19:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729132726; x=1729737526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyoX/VXB6kRQ5Z5Po0ZyyQ1eAQYC/i5UR7HqsdBY26Y=;
        b=g0AOFhFgE3cM49cGnYbYs9oIC/QY/DnenJiLakXKwgo54jg2B1ajj8ipFwGR40CYj+
         2NHPkoLx3TGNbxyiZTCoZu2pYINAxDsOswxGrF8IOP7MW53hXr7Z6yVkE+DC7LczTWI/
         0LesZYEIDMiEJN+sW9Dp7LCpklFBcxuOSL+IXaHMMkaVKkxqWIoSh51ULULDq0PI74c4
         XMOuwW82b3Lu0mmrZ6sycuDy7x1nwNQ0vvHpkxxxTByVtogkiui5pO6IccjpQtgloThy
         pfX4hn0P+gmRooWH2SuCGYKJVW0hRWF20c7kj1Y0J3DbT44tRwVQXyv9TunxVBHWQeVy
         pTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729132726; x=1729737526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyoX/VXB6kRQ5Z5Po0ZyyQ1eAQYC/i5UR7HqsdBY26Y=;
        b=d6UNGRf57Me83GapMTXUHbh03LJ3OxiF+3BaGKsfLQ+V/r7BltOQH6iGP6cVfhSEqI
         IQGhgVjG/P7w2Df79/qepwQBJXQirjwRs9H394wkYhj3DbBNVto/0GH+gzYhKTyJdh8X
         4SMfPtZR3ORzSnHqB1AbWAtYHeeXWKGEMdhpdmX4ac9jdd0igsCuvWoF15pxCe2V8DHs
         EUTexqiSLjl3Um51olDXfiQLPgM+E/5uL/pVCBOc18QzbIEJDERUglbuHSuI84FUTWah
         os83dZzHmx4c4L9z6e+6MK6PuSX3ibLChA4tADFAICb/732pLq+U2o+b9lYmJGqw5a6K
         XSOA==
X-Forwarded-Encrypted: i=1; AJvYcCXJBbx9VtiXO+rywB/4hVjvL0twPILYTrnlrhYLxVSsmxVD9NtFjCW7aeOJMkIYT1koJ78GNzVmASJUJpbSJb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEL/ISOwNrRpqFtiLKmxCAbSTsV1JH3t9Msiz0EOqm3QQYxMvP
	nptnhEG9cfGkpxgzlVb67aBLFO/VyrzsfnJSOzAi3KEcXox0+/vkbp7xnN7Vx1w4/q7vUYiBAWQ
	+nsx3RQppFlVVF1/Uo5OscCF0UYweAazADaNo
X-Google-Smtp-Source: AGHT+IGOV3tbbxDMxDfkL5dTKHJ47DuzvRwXqoEqBnSc9W0BsLddUP4XNhaEM2ZgUZfm9d/AKVluzoXHH1/1goEuskU=
X-Received: by 2002:a05:6402:5107:b0:5c5:c44d:484e with SMTP id
 4fb4d7f45d1cf-5c9ebb55cf8mr149642a12.1.1729132725983; Wed, 16 Oct 2024
 19:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017022627.3112811-1-jeffxu@chromium.org>
In-Reply-To: <20241017022627.3112811-1-jeffxu@chromium.org>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 16 Oct 2024 19:38:08 -0700
Message-ID: <CALmYWFsnx+QvkqLyYRSBW1ueJonEJeXROq6UM7Bbktn3bu+PMQ@mail.gmail.com>
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 7:26=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> It appears there is a regression on the latest mm,
> when munmap seals memory, it can cause an unexpected VMA split.
> E.g. repro use this test.

It appears that this test has some dependency tests that haven't been
merged, so can't be run as is.
This is the repro step:

- Allocate 12 pages (0-11).
- Seal middle 4 pages (4567)
- munmap (2345) - this will fail

Seeing VMA for page (0123) is split as 2 VMAs (01)-(23), those 2 VMA
have the same attribute, and should be merged as one.

> ---
>  tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index fa74dbe4a684..0af33e13b606 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -1969,6 +1969,79 @@ static void test_madvise_filebacked_was_writable(b=
ool seal)
>         REPORT_TEST_PASS();
>  }
>
> +static void test_munmap_free_multiple_ranges_with_split(bool seal)
> +{
> +       void *ptr;
> +       unsigned long page_size =3D getpagesize();
> +       unsigned long size =3D 12 * page_size;
> +       int ret;
> +       int prot;
> +
> +       setup_single_address(size, &ptr);
> +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> +
> +       /* seal the middle 4 page */
> +       if (seal) {
> +               ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size);
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +               size =3D get_vma_size(ptr, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  4 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  8 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +       }
> +
> +       /* munmap 4  pages from the third page */
> +       ret =3D sys_munmap(ptr + 2 * page_size, 4 * page_size);
> +       if (seal) {
> +               FAIL_TEST_IF_FALSE(ret);
> +               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> +
> +               size =3D get_vma_size(ptr, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  4 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  8 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +       } else
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +       /* munmap 4 pages from the sealed page */
> +       ret =3D sys_munmap(ptr + 6 * page_size, 4 * page_size);
> +       if (seal) {
> +               FAIL_TEST_IF_FALSE(ret);
> +               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> +
> +               size =3D get_vma_size(ptr + 4 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  4 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  8 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +       } else
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +       REPORT_TEST_PASS();
> +}
> +
> +
>  int main(int argc, char **argv)
>  {
>         bool test_seal =3D seal_support();
> @@ -2099,5 +2172,8 @@ int main(int argc, char **argv)
>         test_madvise_filebacked_was_writable(false);
>         test_madvise_filebacked_was_writable(true);
>
> +       test_munmap_free_multiple_ranges_with_split(false);
> +       test_munmap_free_multiple_ranges_with_split(true);
> +
>         ksft_finished();
>  }
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

