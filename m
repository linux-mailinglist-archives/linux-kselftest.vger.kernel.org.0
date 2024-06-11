Return-Path: <linux-kselftest+bounces-11642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F6902F79
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 06:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E8283621
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCB316FF23;
	Tue, 11 Jun 2024 04:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8fthV5o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028BC16F916
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079687; cv=none; b=CHZW1TYK5wXlICmnsM7aB53vM9JDQsE9TLO0nL50LLVL/4jQuym5TFbBA8H9UnvPrDWY9aaeQIiWalIPcW59bE9BEuMYW5TxFIVuoZvI9jO1KTSxGmHOnTgtqzgyv6pwIqVmpPeQI7X6UIEdKIg6gliu5NE0EXl82NEr/QbE+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079687; c=relaxed/simple;
	bh=b44GjkyNBqeujCH+NPzsvRUdiEqakkwjTTaJH94UXZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVLZxe5gxaeIFv1jquOgOJsqHtN7wLzbvG6M5teuglq/X6panhv8fqTTbiKJrQY3EcmlDo6Jltvvv90uxURoMySn2f5MgiN1WtA8fhIXdzPTZjo1+oPq+d862Po6JM53EbfdOIRq7ezY0x2ltaLzARSHAd0RGVnOeKlq32bWjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l8fthV5o; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f96445cfaeso364958a34.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 21:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718079685; x=1718684485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EklVdHyvDTr3/lo2FpeHs1y2+JvBE7tPTVB+SmPAdQ4=;
        b=l8fthV5odZYqGeWe6LixQUjf3z2WeX1cN7e9dRUbkeoIv/YhzHonPGj8fqTqNXX2ft
         k8UUV7KE4GuYtBhMIlrj5s0ZDCsY8ymYq24cF+aB2HNJN6yNbZ3LxDe9830sIcQeTRQg
         TLWHgHwVDtrBWYCgo4ldSP5a9ELMbXoDFAItA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718079685; x=1718684485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EklVdHyvDTr3/lo2FpeHs1y2+JvBE7tPTVB+SmPAdQ4=;
        b=JkkzM+sFgaD0R4CdFCZeEnusYPPQYzKWwP0f1+BbPZXNhDp/ZB6vIZkL6PVM0kR6Z1
         1C5JXu1W5mwwJfzKLqKCQhJDvQICuJoHrJr7fV7pdwB/SCICngcnUC+ZDII+ueOilQLn
         +MTtv9cXQhgfPjKnCuLMDGLMivppSzhZ7cicU0L3iCM/oMDrPDr9Wc18dMxpr1sH9YDn
         r6rqBXPV020Sn5pVZEjxa+VI++5yCupG2jSxTU+7MnPvrBfe5BBy69RAEL7CQLWtYCqK
         alQ3r7ADNPkdZrf3gLX9XI9T5XquzfUKTaBsvmTwKb4dD+oGCIUvSv26Z/3F9h6tt+tb
         iTjg==
X-Forwarded-Encrypted: i=1; AJvYcCUvyfEKTSlAAZSBhlQmgPow3oHpgEgqTKv5sIt+gmB9hk5hi3uhRyzkzxCR8TnyJ6Qt5/HaBnqhrsbVduhi/0aN8ihgklbCO7iem5pTGzU4
X-Gm-Message-State: AOJu0Yy6J46ruyDEmIKXtSEbr23qh/j9vHkijxWRznkH3coZsikuf+ib
	CrfKb+pBAndtAOuXmFZcqy2TgBv+bcqyhC9P5JYMPzXiziJK+1uEiNv4Vq56tuReoeqH7AXVf/o
	4zr3mEd6ImOozwJf1lYh28jrvottlxuMICBap
X-Google-Smtp-Source: AGHT+IEeRKtmtjxMmre/EUaXcUHS9SCDfRXDteIausMJyVW1Gdf5SYIeYK/MjKfHWpWWOOhhqHhMBUFCuUsJFlAg34E=
X-Received: by 2002:a05:6870:231a:b0:24f:c9e3:b76f with SMTP id
 586e51a60fabf-2546441a4e7mr13254702fac.19.1718079685006; Mon, 10 Jun 2024
 21:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608021023.176027-1-jhubbard@nvidia.com>
In-Reply-To: <20240608021023.176027-1-jhubbard@nvidia.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 10 Jun 2024 21:21:13 -0700
Message-ID: <CABi2SkVoNyXLrfU71gnv1qVUAADpUmFXiDoKKPc54MLb5JpB+Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make headers"
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, 
	Rich Felker <dalias@libc.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi


On Fri, Jun 7, 2024 at 7:10=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> Eventually, once the build succeeds on a sufficiently old distro, the
> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
> after that, from selftests/lib.mk and all of the other selftest builds.
>
> For now, this series merely achieves a clean build of selftests/mm on a
> not-so-old distro: Ubuntu 23.04:
>
> 1. Add __NR_mseal.
>
> 2. Add fs.h, taken as usual from a snapshot of ./usr/include/linux/fs.h
> after running "make headers". This is how we have agreed to do this sort
> of thing, see [1].
>
What is the "official" way to build selftests/mm ?
I tried a few ways, but it never worked, i.e. due to head missing.

1>
cd tools/testing/selftests/mm
make

migration.c:10:10: fatal error: numa.h: No such file or directory
   10 | #include <numa.h>
      |          ^~~~~~~~
compilation terminated.

2>
make headers
make -C tools/testing/selftests

make[1]: Entering directory
'/usr/local/google/home/jeffxu/mm/tools/testing/selftests/mm'
  CC       migration
migration.c:10:10: fatal error: numa.h: No such file or directory
   10 | #include <numa.h>

Thanks!
-Jeff

