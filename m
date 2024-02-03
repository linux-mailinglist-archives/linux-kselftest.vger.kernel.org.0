Return-Path: <linux-kselftest+bounces-4066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD40B847DEF
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1AA1F2CFC5
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7190E64B;
	Sat,  3 Feb 2024 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1RnFX3p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FC6FB6;
	Sat,  3 Feb 2024 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920806; cv=none; b=YZNA6p5QXnD6y8XF1QDYxO4O+6ODae7CJZ/lDZ2kebN3rkPwTX1gGT4f4m4ZJ65U/+Tsvg2NuikfF7G82UH5vFRAd41R2ATVnzM9kHSFfnFmWICEKcxfvNJSPL7N0ypsVEm/U5qkm7kXCjCh1SEzhnhKVmImbw2qsBk0YkIK5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920806; c=relaxed/simple;
	bh=hY9D3IvgVlygL48OZ0YO4gZgMH1F6qxN5QAYMCEfR/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8uifXmltN6gEKe3vHfho+4rPcNleGcljDY3NQl6PBXsMBFPQ6V8vrYsBpyQlh98mu/ctra4LQB8Xig4g223T2dhS+Vy6lseiw9l8NuMAiHG8g2DbWaI2YC0KtJRTRyeQ0m4+BXmTSsZJJ80Cwhb09ch+4GlHLktFz/TjtlrMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1RnFX3p; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3638eb3ead6so10371155ab.0;
        Fri, 02 Feb 2024 16:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706920803; x=1707525603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPmEee8EW9ZVTqL0gdWpHjFhQp8lEG44ByVdqeX0Gus=;
        b=E1RnFX3p0qXFhB/yWyu9fbC8gdVyuTqplMHyWaE60mwt1HkLbTNMEyDctAkPwRENys
         zLDgTqiSzzfuaHPqcZkhJZEB03N6LbOmHN41MtbNyCNEAdWxds/933pyNyXjV+p3l1Go
         8A/z6gQRAPCG+/ToxXih1yQBfdOShfzvYyTzrCC6m/oqqZLjyhiW3VlHRC9OwZ53+pGz
         HzoB7/BB7OC5bdjssciuNLw1TNAn7inE4FMPM+00iuz1ew5Beq35P2HjygXqnrq6B7y8
         7MVWDL+CBTkADgArLkqq4toZCtlsY3xxnnR1s9/9SvflH6WnvH7wWni9LLv2loJxtLCW
         mXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706920803; x=1707525603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPmEee8EW9ZVTqL0gdWpHjFhQp8lEG44ByVdqeX0Gus=;
        b=bxE7y66DvSMKWeta2QrbzUtKasbHkMEUVcUZiiGS86T2QiRP0e4JQFvddpDiZ5PWui
         gK7xSNVZAK9LHGpwTd/hGFu91x2eWIycLRv6UMasiK9DfhoXUTEBImHdJ+xd8NqUOXCt
         s32RHwy3JXQmzLcoFUoplK3kuVBdfmQIiU/H7kWsEkVvXf0db4IWRqN1aNPtjCSRZOkD
         +63TwoHoJd2dzc4kf1v1VQmS410lkGyjsuOytTP1rFaJCsamA53syGnYJuhdaq7rTSXV
         oRafYdaY0o8U4TsTQupTpBvP1ce4YyMYoiZdZkUprd+Jxu1+M9IzPouutnVo85mpT1M8
         4XqA==
X-Gm-Message-State: AOJu0YxqNT8cctP+A4aaeDvMTTzlQy61sR8p3Qi+dY7AStdusx4w7V3l
	UukXkd98VriB0X0/+KaNaEWBXCwQalIxjybGUhdTT4TuQgD2YckpqUofCG9yALpUOMGd5N1FMf3
	MdZRPVr0JUjHZh87QR7fKo5AA3KQ=
X-Google-Smtp-Source: AGHT+IFgqdwHEV8JgvmsaWSumu8uHPzWdEdZa0O2YyVDQXw0gYpAVHhFLtVsDIFjRN0/CAeQGvTso/hxPnI2oKTHPOc=
X-Received: by 2002:a92:c9cc:0:b0:363:b641:cd7f with SMTP id
 k12-20020a92c9cc000000b00363b641cd7fmr2599920ilq.8.1706920803622; Fri, 02 Feb
 2024 16:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201032718.1968208-1-nphamcs@gmail.com> <20240201032718.1968208-4-nphamcs@gmail.com>
 <Zbtfku0wVGXBHDTD@google.com>
In-Reply-To: <Zbtfku0wVGXBHDTD@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 2 Feb 2024 16:39:52 -0800
Message-ID: <CAKEwX=PH5abBFCjYHL+d99v8MMwiASqP83aF2vSv1iwezX3UHA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests: add zswapin and no zswap tests
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, riel@surriel.com, shuah@kernel.org, 
	hannes@cmpxchg.org, tj@kernel.org, lizefan.x@bytedance.com, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:08=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Hey Nhat,
>
> I have a few more comments, sorry for not catching everything the first
> time around.

No worries :)

>
> Adding Roman to CC.
>
> On Wed, Jan 31, 2024 at 07:27:18PM -0800, Nhat Pham wrote:
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
> > ---
> >  tools/testing/selftests/cgroup/test_zswap.c | 97 +++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testin=
g/selftests/cgroup/test_zswap.c
> > index 32ce975b21d1..14d1f18f1098 100644
> > --- a/tools/testing/selftests/cgroup/test_zswap.c
> > +++ b/tools/testing/selftests/cgroup/test_zswap.c
> > @@ -60,6 +60,27 @@ static long get_zswpout(const char *cgroup)
> >       return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
> >  }
> >
> > +static int allocate_bytes_and_read(const char *cgroup, void *arg)
>
> I think allocate_and_read_bytes() is easier to read, but I don't feel
> strongly about it.

Ah you're right. I'll fix that in the next version.

>
> > +{
> > +     size_t size =3D (size_t)arg;
> > +     char *mem =3D (char *)malloc(size);
> > +     int ret =3D 0;
> > +
> > +     if (!mem)
> > +             return -1;
> > +     for (int i =3D 0; i < size; i +=3D 4095)
> > +             mem[i] =3D 'a';
>
> cgroup_util.h defines PAGE_SIZE, see alloc_anon() for example.
>
> On that note, alloc_anon() is awfully close to allocate_bytes() below,
> perhaps we should consolidate them. The only difference I see is that
> alloc_anon() does not check for the allocation failure, but a lot of
> functions in cgroup_helpers.c don't, so it seems intentional for
> simplification.

Hmm I didn't know about this function. I think it was Domenico who
added allocate_bytes() for the initial zswap tests, and I've just been
piggybacking on it ever since:
https://github.com/torvalds/linux/commit/d9cfaf405b8ffe2c716b1ce4c82e0a19d5=
0951da

I can send a separate patch to clean this up later :) Doesn't seem that bad=
.

>
> > +
> > +     /* go through the allocated memory to (z)swap in and out pages */
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
> > @@ -133,6 +154,80 @@ static int test_zswap_usage(const char *root)
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
> > +     long zswpout;
> > +
> > +     /* Set up */
>
> I think this comment is unnecessary.

Fair!

>
> > +     test_group =3D cg_name(root, "no_zswap_test");
> > +
> > +     if (!test_group)
> > +             goto out;
> > +     if (cg_create(test_group))
> > +             goto out;
> > +     if (cg_write(test_group, "memory.max", "8M"))
> > +             goto out;
> > +     /* Disable zswap */
>
> I think this comment is unnecessary.

Fair!

>
> > +     if (cg_write(test_group, "memory.zswap.max", "0"))
> > +             goto out;
> > +
> > +     /* Allocate and read more than memory.max to trigger swapin */
> > +     if (cg_run(test_group, allocate_bytes_and_read, (void *)MB(32)))
> > +             goto out;
> > +
> > +     /* Verify that no zswap happened */
>
> If we want to be really meticulous, we can verify that we did swap out,
> but not to zswap. IOW, we can check memory.swap.current or something.

Hmm would memory.swap.current go back to 0 once the memory-in-swap is
freed? It doesn't seem like we have any counters at the cgroup level
for swapout/swapin events. Maybe such counters were not useful enough
to justify the extra overhead of maintaining them? :)

Anyway, I think checking zswpout should probably be enough here.
That's the spirit of the test anyway - make absolutely sure that no
zswap-out happened.

>
> > +     zswpout =3D get_zswpout(test_group);
> > +     if (zswpout < 0) {
> > +             ksft_print_msg("Failed to get zswpout\n");
> > +             goto out;
> > +     } else if (zswpout > 0) {
>
> nit: This can be a separate if condition, I think it would be more
> inline with the style of separate consecutive if blocks we are
> following.

Yeah now that you point out the inconsistency, it starts to bug my
brain too :) I'll fix it in the next version.

>
> > +             ksft_print_msg(
> > +                     "Pages should not go to zswap when memory.zswap.m=
ax =3D 0\n");
>
> We can probably avoid the line break with something more concise, for
> example:
> "zswapout > 0 when zswap is disabled"
> or "zswapout > 0 when memory.zswap.max =3D 0"
>
> > +             goto out;
> > +     }
> > +     ret =3D KSFT_PASS;
> > +
> > +out:
> > +     cg_destroy(test_group);
> > +     free(test_group);
> > +     return ret;
> > +}
> > +
> > +/* Simple test to verify the (z)swapin code paths */
> > +static int test_zswapin_no_limit(const char *root)
>
> I think test_zswapin() is enough to be distinct from
> test_swapin_nozswap(). The limit is not a factor here AFAICT.

Fair.

>
> > +{
> > +     int ret =3D KSFT_FAIL;
> > +     char *test_group;
> > +
> > +     /* Set up */
>
> I think this comment is unnecessary.

Fair.

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
> > +     if (cg_run(test_group, allocate_bytes_and_read, (void *)MB(32)))
> > +             goto out;
>
> We should probably check for a positive zswapin here, no?

Oh right. I'll just do a quick check here:

zswpin =3D cg_read_key_long(test_group, "memory.stat", "zswpin ");
if (zswpin < 0) {
   ksft_print_msg("Failed to get zswpin\n");
   goto out;
}

if (zswpin =3D=3D 0) {
   ksft_print_msg("zswpin should not be 0\n");
   goto out;
}


>
> > +
> > +     ret =3D KSFT_PASS;
> > +
> > +out:
> > +     cg_destroy(test_group);
> > +     free(test_group);
> > +     return ret;
> > +}
> > +
> >  /*
> >   * When trying to store a memcg page in zswap, if the memcg hits its m=
emory
> >   * limit in zswap, writeback should affect only the zswapped pages of =
that
> > @@ -309,6 +404,8 @@ struct zswap_test {
> >       const char *name;
> >  } tests[] =3D {
> >       T(test_zswap_usage),
> > +     T(test_swapin_nozswap),
> > +     T(test_zswapin_no_limit),
> >       T(test_no_kmem_bypass),
> >       T(test_no_invasive_cgroup_shrink),
> >  };
> > --
> > 2.39.3

