Return-Path: <linux-kselftest+bounces-36129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AF6AEEA62
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 00:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F4047AC22E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C8299957;
	Mon, 30 Jun 2025 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d37JAXtr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481E292908;
	Mon, 30 Jun 2025 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322646; cv=none; b=gXSxsoIh4w+z+qNQIcKMUfWAEVjcfuo5UUlw//UBQ0zGkFK5lOrji6CXRvi3sLH4jZCs7mkgL4TJJsbf3T7Pq2dC2Z8yXq98uwuj25VZ9woLMr6t1s4jvTIA2El29WUc5KOJc+8ZT3afwgObLFKKtZ05ib6rTEeOz3QWlsYOpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322646; c=relaxed/simple;
	bh=OjuwjnPigupGETd25+YFG96asjLqZRDL9oiRjkxVrfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVNy+O6ZlRjC6u3TY5L8XV6+9+WfSlIRsUemSz5QjI86mynXsQ1G+5Z9uqPRDr2wdIpJHWETXL3sCSZectJpTuF1ODzyH++pd/i270nMh9Pz2FGjF/k36JZfyxE2RiKO5VgnmDDtD+ihxbLPNo4UFiv7R8ZFgynKv2euY7tjl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d37JAXtr; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fd0a3cd326so31537546d6.1;
        Mon, 30 Jun 2025 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751322643; x=1751927443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai192T8zNk4t68iyaDXYtFbddTpkDSzsYqRpmCFuNrY=;
        b=d37JAXtrpzRhW6fjuafnW5/ZatLJcv+IxsJ3gAE2Gq5XBLt08HeXaKGCZ3y8LHwt+I
         hj+7dKawM33kagJyOsig5dcSLRCebl8ekzaLFL3duivOLwMuGZQqv+DN8+9OVVuxv0eo
         7d2XoIRfY0FOfliYNLnIl/aYLdDC0WILswbPC24LtcjmczCn63w6SpJNE4uczUNuLNHi
         gIpwJXt8MDcBNrK2WOM40ay6ULh6eVNCuN1MwinnDiw0F+mT/VNBKR6t04pyhSbSYQuc
         JQp2fDOnp6L0EZHLYDUfPUyU+oTk7WFH4Q8MdtRB9D4QMguKqP4WKhkk3Hl883egwjnM
         FH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751322643; x=1751927443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ai192T8zNk4t68iyaDXYtFbddTpkDSzsYqRpmCFuNrY=;
        b=p4uSQMi0wiY1krS6/CkUNVDgL4cixrLp8ePxOTTzkHcGloxn+CCzKfuauwVRsm0A5w
         yEEM3Dr4RyQbZyPabPdXV5epyZKI1hcTQiWq33vdnQ+als6KkV8iDXniZw8aS1o25zZo
         EuaR8AReW4LLoHl/feIYAMHhdH73ecxULXFI0GLEt5/6oKef/n/dKtmwG1nliuJReajv
         lvHQ9JWw7i/LepmcXMZn84OEWooiVIloDYz8/vArQIPOfbGFie3QYWYcmn+gKXF5DM66
         9YVcG6MtbdalEQdJItYatBqDBIjRwQtgBPDtsGGIVnb2CRfb+c3soNuR3qYbx/HWuXOJ
         QOnA==
X-Forwarded-Encrypted: i=1; AJvYcCVJRa44A/gxxZwlMBc9dmr+OBeYRvH0IzL2CcfunSm24ElMxf7cHap/097HeigUAZy7Qj6uRcM9jUK87RSgbNca@vger.kernel.org, AJvYcCXv8RQ7gfodO7H6M0kxNG3nljk5eBCH4qrUNiBFx2rO4HAAMxYCcYZPZQOs5HHun5sL1/81yi5Y61rnyOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynMcgUsJ1wF5AcyyqpMhHJ0OfRAti/lkFb1DMUpsr6HclXpUn7
	Wzqv8Dzvf368nqcdpx2N9xzHyJdCGIC35H7x2TGgHxvcKmOrqYiX+wBaGMf1aV6ygeC/A6MDO2N
	PqwM2g0FxNIHa8SHPH7vk9iAce/nOKtI=
X-Gm-Gg: ASbGncsOkpDaK0cKvHRYTqenALdxzhVKBMXLThRvI8/mTaxcUnabR4ysSL2Oqd8vRHR
	EPtL2lupf+/TAQHYWPskiJNpsBqWxIxkWFg4OlXqJcuod3ke1rqP4lXGxyCCJAumT8+oUpWmdDp
	Cv+7sR2OPGGqAP9lBPX3KtEk05l4FuhfjOVyTVrAxh0+Y=
X-Google-Smtp-Source: AGHT+IG14HrVwN4QZgDMflUz/jurLDXjApULHqz/YtoTmowsLIAXSuzPC2YLeQElYTxerNAAglKDOGJaDVlm1AVCvP0=
X-Received: by 2002:a05:6214:5c04:b0:6fa:c054:1628 with SMTP id
 6a1803df08f44-7000214ff6amr253828816d6.23.1751322643335; Mon, 30 Jun 2025
 15:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630180803.12866-1-suresh.k.chandrappa@gmail.com>
In-Reply-To: <20250630180803.12866-1-suresh.k.chandrappa@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 30 Jun 2025 15:30:32 -0700
X-Gm-Features: Ac12FXyjCYGreweB0bkFxQ-UDbnU0CajEdwIFsh56FbrAVpbzdoYdkJzqo4ZDjs
Message-ID: <CAKEwX=PRdkDEmP5N3t70qg7ugreLvyNHVxR0SGwU8pwasgqG4A@mail.gmail.com>
Subject: Re: [PATCH] selftests: cachestat: add tests for mmap
To: Suresh K C <suresh.k.chandrappa@gmail.com>
Cc: hannes@cmpxchg.org, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 11:08=E2=80=AFAM Suresh K C
<suresh.k.chandrappa@gmail.com> wrote:
>
> From: Suresh K C <suresh.k.chandrappa@gmail.com>
>
> Add a test case to verify cachestat behavior with memory-mapped files
> using mmap(). This ensures that pages accessed via mmap are correctly
> accounted for in the page cache.
>
> Tested on x86_64 with default kernel config
>
> Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>

FWIW, the tests passed :)

> ---
>  .../selftests/cachestat/test_cachestat.c      | 39 ++++++++++++++++---
>  1 file changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/t=
esting/selftests/cachestat/test_cachestat.c
> index 632ab44737ec..b6452978dae0 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -33,6 +33,11 @@ void print_cachestat(struct cachestat *cs)
>         cs->nr_evicted, cs->nr_recently_evicted);
>  }
>
> +enum file_type {
> +       FILE_MMAP,
> +       FILE_SHMEM
> +};
> +
>  bool write_exactly(int fd, size_t filesize)
>  {
>         int random_fd =3D open("/dev/urandom", O_RDONLY);
> @@ -202,7 +207,7 @@ static int test_cachestat(const char *filename, bool =
write_random, bool create,
>         return ret;
>  }
>
> -bool test_cachestat_shmem(void)
> +bool run_cachestat_test(enum file_type type)
>  {
>         size_t PS =3D sysconf(_SC_PAGESIZE);
>         size_t filesize =3D PS * 512 * 2; /* 2 2MB huge pages */
> @@ -212,27 +217,43 @@ bool test_cachestat_shmem(void)
>         char *filename =3D "tmpshmcstat";
>         struct cachestat cs;
>         bool ret =3D true;
> +       int fd;
>         unsigned long num_pages =3D compute_len / PS;
> -       int fd =3D shm_open(filename, O_CREAT | O_RDWR, 0600);
> +       if (type =3D=3D FILE_SHMEM)
> +               fd =3D shm_open(filename, O_CREAT | O_RDWR, 0600);
> +       else
> +               fd =3D open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
>
>         if (fd < 0) {
> -               ksft_print_msg("Unable to create shmem file.\n");
> +               ksft_print_msg("Unable to create file.\n");
>                 ret =3D false;
>                 goto out;
>         }
>
>         if (ftruncate(fd, filesize)) {
> -               ksft_print_msg("Unable to truncate shmem file.\n");
> +               ksft_print_msg("Unable to truncate file.\n");
>                 ret =3D false;
>                 goto close_fd;
>         }
>
>         if (!write_exactly(fd, filesize)) {
> -               ksft_print_msg("Unable to write to shmem file.\n");
> +               ksft_print_msg("Unable to write to file.\n");
>                 ret =3D false;
>                 goto close_fd;
>         }
>
> +       if (type =3D=3D FILE_MMAP){
> +               char *map =3D mmap(NULL, filesize, PROT_READ | PROT_WRITE=
, MAP_SHARED, fd, 0);
> +               if (map =3D=3D MAP_FAILED) {
> +                       ksft_print_msg("mmap failed.\n");
> +                       ret =3D false;
> +                       goto close_fd;
> +               }
> +               for (int i =3D 0; i < filesize; i++) {
> +                       map[i] =3D 'A';
> +               }
> +               map[filesize - 1] =3D 'X';
> +       }

Joshua is right. We're already doing the write_exactly() for both
cases? Let's write_exactly() (i.e using the file descriptor-based
write syscall) only for FILE_SHMEM.

And why do we need the 'X' at the end?

