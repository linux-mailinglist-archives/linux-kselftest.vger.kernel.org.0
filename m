Return-Path: <linux-kselftest+bounces-4169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F7584AA7A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 00:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E624B26336
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85571487B2;
	Mon,  5 Feb 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clJhanTW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12048780;
	Mon,  5 Feb 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175544; cv=none; b=CW0plM7UF7k2Cq3MJboSd75xtq1uXR4ttIQHzykKhr7XfrXQfIEu0JYkOCua8O31q0hjEBAiIxQ0tbaKPzkzSK+RPP9bteXC4r5Pl/L9kLoW4GFdSLq8N0fD4Ri1+jzI3L0wkpz+MebWaMU35xw7bc3vJite8sgpT659NiPPPsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175544; c=relaxed/simple;
	bh=fW2gUjmEBK07kBoTo6ueV64P6xM+RJDfUTaEZcMoC6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itUgRQa9Fr3HEwFrfYl3IxXcXImzXdAcTPbBQehYTCWKxBsZCtHU8s33JCAehXYqQJus/qBImctHWlsXw8oU4LITEo0w9kzsfKEOACvUweaq2wdQ1YRczZhDPqMaTZ4JW4fPA4m1VU2jLIOxLTvqJrB1j8yKBgJeL2NZJLktCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clJhanTW; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bed9f5d35dso209714439f.3;
        Mon, 05 Feb 2024 15:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707175542; x=1707780342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ugMJGHaGWxp0pUPigivjGhTqcGxS4Rq93Uu934LF4Q=;
        b=clJhanTWnfoB+zzPyiFrwipCu2SCIuOK64LHQfUypbk/JwEPu3xoN9jc0z2hdWQioB
         6b0ZzJJcFa6CaiuNQjdF3XbKz9IyeUID65SHN+FenY02qDHuH5mTHKDmynx4HnIa3rtA
         62KKeDQvQWfPKL6WvXr63QAHep5hjhWcGpUvoO17fWvJweiKxLggiWkmEOt+k6zBn0W7
         PybPQez9KObt5tF8MkaTCpaMoPfxJC3U9gY48EEz8H7FsrA3fv8KVPisjEAtMx2ddKZ2
         MAdRSpYoKAAwn0+bOXW9nRE6Cg8O0mm5tpMgC9L9cPOnyVfTFebERJajVuTGpmqeDqZM
         A7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707175542; x=1707780342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ugMJGHaGWxp0pUPigivjGhTqcGxS4Rq93Uu934LF4Q=;
        b=SYvJZ6lcCok2nJyTYPXvYwHu+RZ5oR/ttw5ieFFpf3ID0qoSfxM2SzzL9hiGs/Mw9U
         R+rlMmnzmgjRjP5P7AkkdRk8I9dHUHA7+ZmzclpA6Wxp1t7U/JDEoWuRi+wPv5WF+S4e
         +RBLaaiJFaTA/P0Lp84x2fPr8tsa1EI2L3ItjHAUGjxnu0JTzh62RnqE53H37JtVPdD7
         89DTbqqqbtXlEkaKBlBeyDFhVPJeiYmq7p+pGrTBRKmT721w533E4jxTQPn6OPNC16/n
         zBxgjTYbhCC9ktGC8eZAiYhhN3LDrOvgJYyVFj+64HxdsWV2KyuAHPSglqK783sBQoOf
         QMOw==
X-Gm-Message-State: AOJu0YyQY87A01sxRIKYjr9hBkJGO+ak1fnyE24jgJQc7wAcRnBN2M1r
	Obzfe835kSe1HgH0xCDZinSQl84iGkOcDsVyvlLqkXPm+xN67SmiealfJH5gnM+8ZjMLYb0YMKV
	KAisjTvgHjliqGEJOJTohfxbECFk=
X-Google-Smtp-Source: AGHT+IGul1c0QX1L47pxhWxkZzO3jqo/vxPVnFARBXErdA/39RlnvKsLQQM1lJu+EOuCUImve/YHK88yBpG4n4ZJrTM=
X-Received: by 2002:a6b:7301:0:b0:7c3:d874:a320 with SMTP id
 e1-20020a6b7301000000b007c3d874a320mr1173338ioh.3.1707175541774; Mon, 05 Feb
 2024 15:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205225608.3083251-1-nphamcs@gmail.com> <20240205225608.3083251-4-nphamcs@gmail.com>
 <ZcFpnokh3W1DFBCj@google.com>
In-Reply-To: <ZcFpnokh3W1DFBCj@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 5 Feb 2024 15:25:30 -0800
Message-ID: <CAKEwX=NxoO6OjjHBK8tHy+ayzT+4gsXWjYYfPv6wut=3Joq7jA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests: add zswapin and no zswap tests
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, riel@surriel.com, shuah@kernel.org, 
	hannes@cmpxchg.org, tj@kernel.org, lizefan.x@bytedance.com, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:05=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Mon, Feb 05, 2024 at 02:56:08PM -0800, Nhat Pham wrote:
> > Add a selftest to cover the zswapin code path, allocating more memory
> > than the cgroup limit to trigger swapout/zswapout, then reading the
> > pages back in memory several times. This is inspired by a recently
> > encountered kernel crash on the zswapin path in our internal kernel,
> > which went undetected because of a lack of test coverage for this path.
> >
> > Add a selftest to verify that when memory.zswap.max =3D 0, no pages can=
 go
> > to the zswap pool for the cgroup.
> >
> > Suggested-by: Rik van Riel <riel@surriel.com>
> > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> LGTM with a few nits below:
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
>
> Thanks!
>
> > ---
> >  tools/testing/selftests/cgroup/test_zswap.c | 120 +++++++++++++++++++-
> >  1 file changed, 119 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testin=
g/selftests/cgroup/test_zswap.c
> > index 32ce975b21d1..c263610a4a60 100644
> > --- a/tools/testing/selftests/cgroup/test_zswap.c
> > +++ b/tools/testing/selftests/cgroup/test_zswap.c
> > @@ -60,6 +60,27 @@ static long get_zswpout(const char *cgroup)
> >       return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
> >  }
> >
> > +static int allocate_and_read_bytes(const char *cgroup, void *arg)
> > +{
> > +     size_t size =3D (size_t)arg;
> > +     char *mem =3D (char *)malloc(size);
> > +     int ret =3D 0;
> > +
> > +     if (!mem)
> > +             return -1;
> > +     for (int i =3D 0; i < size; i +=3D 4095)
> > +             mem[i] =3D 'a';
> > +
> > +     /* go through the allocated memory to (z)swap in and out pages */
>
> nit: s/go/Go
>
> > +     for (int i =3D 0; i < size; i +=3D 4095) {
> > +             if (mem[i] !=3D 'a')
> > +                     ret =3D -1;
> > +     }
> > +
> > +     free(mem);
> > +     return ret;
> > +}
> > +
> >  static int allocate_bytes(const char *cgroup, void *arg)
> >  {
> >       size_t size =3D (size_t)arg;
> > @@ -100,7 +121,6 @@ static int test_zswap_usage(const char *root)
> >       int ret =3D KSFT_FAIL;
> >       char *test_group;
> >
> > -     /* Set up */
>
> We removed this comment here.
>
> >       test_group =3D cg_name(root, "no_shrink_test");
> >       if (!test_group)
> >               goto out;
> > @@ -133,6 +153,102 @@ static int test_zswap_usage(const char *root)
> >       return ret;
> >  }
> >
> > +/*
> > + * Check that when memory.zswap.max =3D 0, no pages can go to the zswa=
p pool for
> > + * the cgroup.
> > + */
> > +static int test_swapin_nozswap(const char *root)
> > +{
> > +     int ret =3D KSFT_FAIL;
> > +     char *test_group;
> > +     long swap_peak, zswpout;
> > +
> > +     test_group =3D cg_name(root, "no_zswap_test");
> > +     if (!test_group)
> > +             goto out;
> > +     if (cg_create(test_group))
> > +             goto out;
> > +     if (cg_write(test_group, "memory.max", "8M"))
> > +             goto out;
> > +     if (cg_write(test_group, "memory.zswap.max", "0"))
> > +             goto out;
> > +
> > +     /* Allocate and read more than memory.max to trigger swapin */
> > +     if (cg_run(test_group, allocate_and_read_bytes, (void *)MB(32)))
> > +             goto out;
> > +
> > +     /* Verify that pages are swapped out, but no zswap happened */
> > +     swap_peak =3D cg_read_long(test_group, "memory.swap.peak");
> > +     if (swap_peak < 0) {
> > +             ksft_print_msg("failed to get cgroup's swap_peak\n");
> > +             goto out;
> > +     }
> > +
> > +     if (swap_peak =3D=3D 0) {
> > +             ksft_print_msg("pages should be swapped out\n");
> > +             goto out;
> > +     }
>
> We can actually check that this number is >=3D 24M instead. Not a big
> deal, but might as well.
>
> > +
> > +     zswpout =3D get_zswpout(test_group);
> > +     if (zswpout < 0) {
> > +             ksft_print_msg("failed to get zswpout\n");
> > +             goto out;
> > +     }
> > +
> > +     if (zswpout > 0) {
> > +             ksft_print_msg("zswapout > 0 when memory.zswap.max =3D 0\=
n");
> > +             goto out;
> > +     }
> > +
> > +     ret =3D KSFT_PASS;
> > +
> > +out:
> > +     cg_destroy(test_group);
> > +     free(test_group);
> > +     return ret;
> > +}
> > +
> > +/* Simple test to verify the (z)swapin code paths */
> > +static int test_zswapin(const char *root)
> > +{
> > +     int ret =3D KSFT_FAIL;
> > +     char *test_group;
> > +     long zswpin;
> > +
> > +     /* Set up */
>
> Yet we added a similar one here :)

Urgh I am stupid :) I meant to remove this, but accidentally removed
it from the old test instead :)


>
> > +     test_group =3D cg_name(root, "zswapin_test");
> > +     if (!test_group)
> > +             goto out;
> > +     if (cg_create(test_group))
> > +             goto out;
> > +     if (cg_write(test_group, "memory.max", "8M"))
> > +             goto out;
> > +     if (cg_write(test_group, "memory.zswap.max", "max"))
> > +             goto out;
> > +
> > +     /* Allocate and read more than memory.max to trigger (z)swap in *=
/
> > +     if (cg_run(test_group, allocate_and_read_bytes, (void *)MB(32)))
> > +             goto out;
> > +
> > +     zswpin =3D cg_read_key_long(test_group, "memory.stat", "zswpin ")=
;
> > +     if (zswpin < 0) {
> > +             ksft_print_msg("failed to get zswpin\n");
> > +             goto out;
> > +     }
> > +
> > +     if (zswpin =3D=3D 0) {
> > +             ksft_print_msg("zswpin should not be 0\n");
> > +             goto out;
> > +     }
>
> Same here, we can check that zswpin is at least 24M worth of events.
> Again, not a big deal, but might as well.

