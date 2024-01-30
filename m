Return-Path: <linux-kselftest+bounces-3750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B65A842BCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC351F25C58
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8615B976;
	Tue, 30 Jan 2024 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZqUTkyy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4C915B31C;
	Tue, 30 Jan 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639498; cv=none; b=gvnA7f9JbeMrZkKCln/iqaPZLLOSRFSLPnjh/gRuDH7aT3X+S8LiBOdzt4x0Wq4x+5qmoQ2L+hXjbWbDQ6lGRcyuIYyPN+f9SzfaJeEW/YwxTjT8emRBl/BTUNztTN3nf5jyW2Y7TuB5MbxvAFlLxhRUeXa/Hvjx+A3l/CMpaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639498; c=relaxed/simple;
	bh=wmW5J1Tj/wtLsyHHDLI8FB1VAG3iyVs+j/yeBcTZHdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuY0ASqCBUBaHBrlzycdkh6fGNipcWRn7H/h0LWfx5mDX07FITlI3ZWy0AoLAh9irdlYtOgYQPIIMMz1lj6YY2T1zUtzooEFZ6ddxm82kFvqGr0qGX2Vp0y7TJAHpIoc7f4pT4NnMuWetZJSRPaIS2u+VMYT+jS2+bDYLne7+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZqUTkyy; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7baa8da5692so229109039f.0;
        Tue, 30 Jan 2024 10:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706639496; x=1707244296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4BTRkkumRWS7a29JYn1bsYyn8iQweTdqX0+5Jq8L/I=;
        b=lZqUTkyyUSAKj8mnLWNmRc4QSufDFiUzs9LjAea63JvpLwZKta34rczHEzsz49G+bb
         MCEj9lseb8z36A4tn30hiBUYHisJp2kqVTwzJ14uGx1P968ADCkPOEwUcBU9In2oUPhb
         985kxqvRlAQDtql6NDBAxE7rt3OPdMpEWtPumWwW9u8XHT+BIgIfKeiPAVBWSnPKaeI0
         fMhND4pvFCS28uXte9O8Ni9+t1cKbHc8a0EJGhJOlAlxsmUSp4fDTzbgqzFTGyiKESew
         d8kdjDdwphSM9yGyK8J7aO5hErJ41MPYt+PDp2eNoz1M0oyG9rI6/kmXL+9yn+1YXFOZ
         Ft5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639496; x=1707244296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4BTRkkumRWS7a29JYn1bsYyn8iQweTdqX0+5Jq8L/I=;
        b=qz5ipVyBdMedoCt9WVGfQAw3PTAFBY2dq+c+jVrQ1TyGK4/V6bZHxiuacOt8NE5c1e
         JFsJWIJWZ1Gdl7QraxioamxanZmUwaa1195kCWjP9PH7ZOxDVNkShFqqxzpp29UPmDFj
         Ii0SfIiJx3fwuAVc6zk44qDEAFIEpcoFf9MSgOr8EOlPfVyE1fOhtqnnwchOAt0E09UE
         SqWpc/ynHvdiTCE5KxVyKMeAyt77IDtXSBBBSrRaM8U5tNrPMXCr1hg1GY+nijlk2Jdy
         wORbTNrh0YGILQAN4yUBmUJovOwHpLrRovN8lNt8f47SL8k8jDl5V3hRs0CiaCSBnqNd
         g87w==
X-Gm-Message-State: AOJu0Yzt2tuvzEJHGNecug5G95mr9sYEPpjGaawKOXdSPvVotGi1FX7E
	D3+/sqOzA920vOaAN4v3qChkd3jdTynzxEGSduIb1ZvWUbmj3mzZKeFa/bpQdazfDjJJDgNlVO2
	kPpB43fnWJ1nynvuAVoBeK/JtCXJxPeLOMrQ6Zg==
X-Google-Smtp-Source: AGHT+IGhQVQ3vc88KQYAMP/He0t9hm5odiWA9YrIXE2nGn/Cmcw+/qEXsVaCQBpT8FK5MgL1cc2PvU8T/ZJi5gRZ+sc=
X-Received: by 2002:a05:6602:2f14:b0:7be:d961:6b0a with SMTP id
 q20-20020a0566022f1400b007bed9616b0amr14660719iow.18.1706639495901; Tue, 30
 Jan 2024 10:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129224542.162599-1-nphamcs@gmail.com> <20240129224542.162599-4-nphamcs@gmail.com>
 <ZbhP0JkEe39g3yqk@google.com>
In-Reply-To: <ZbhP0JkEe39g3yqk@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 10:31:24 -0800
Message-ID: <CAKEwX=Pj+ncE=wZTOBVzT8E-=YVbqr-1CtsMNuZWLAhuaf7wAg@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: add test for zswapin
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, hannes@cmpxchg.org, 
	tj@kernel.org, lizefan.x@bytedance.com, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:24=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Jan 29, 2024 at 02:45:42PM -0800, Nhat Pham wrote:
> > We recently encountered a kernel crash on the zswapin path in our
> > internal kernel, which went undetected because of a lack of test
> > coverage for this path. Add a selftest to cover this code path,
> > allocating more memories than the cgroup limit to trigger
>
> s/memories/memory
>
> > swapout/zswapout, then reading the pages back in memories several times=
.
> >
> > Also add a variant of this test that runs with zswap disabled, to verif=
y
> > swapin correctness as well.
> >
> > Suggested-by: Rik van Riel <riel@surriel.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  tools/testing/selftests/cgroup/test_zswap.c | 67 ++++++++++++++++++++-
> >  1 file changed, 65 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testin=
g/selftests/cgroup/test_zswap.c
> > index 32ce975b21d1..86231c86dc89 100644
> > --- a/tools/testing/selftests/cgroup/test_zswap.c
> > +++ b/tools/testing/selftests/cgroup/test_zswap.c
> > @@ -60,17 +60,39 @@ static long get_zswpout(const char *cgroup)
> >       return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
> >  }
> >
> > -static int allocate_bytes(const char *cgroup, void *arg)
> > +static int allocate_bytes_and_read(const char *cgroup, void *arg, bool=
 read)
> >  {
> >       size_t size =3D (size_t)arg;
> >       char *mem =3D (char *)malloc(size);
> > +     int ret =3D 0;
> >
> >       if (!mem)
> >               return -1;
> >       for (int i =3D 0; i < size; i +=3D 4095)
> >               mem[i] =3D 'a';
> > +
> > +     if (read) {
> > +             /* cycle through the allocated memory to (z)swap in and o=
ut pages */
> > +             for (int t =3D 0; t < 5; t++) {
>
> What benefit does the iteration serve here? I would guess one iteration
> is enough to swap everything in at least once, no?

There might be data races etc. that might not appear in one iteration.
Running multiple iterations increases the probability of these bugs
cropping up.

Admittedly, the same effect could, perhaps, also be achieved by
running the same test multiple times, so this is not a hill I will die
on :) This is just a bit more convenient - CI infra often runs these
tests once every time a new kernel is built.

>
> > +                     for (int i =3D 0; i < size; i +=3D 4095) {
> > +                             if (mem[i] !=3D 'a')
> > +                                     ret =3D -1;
> > +                     }
> > +             }
> > +     }
> > +
> >       free(mem);
> > -     return 0;
> > +     return ret;
> > +}
> > +
> > +static int allocate_bytes(const char *cgroup, void *arg)
> > +{
> > +     return allocate_bytes_and_read(cgroup, arg, false);
> > +}
> > +
> > +static int read_bytes(const char *cgroup, void *arg)
> > +{
> > +     return allocate_bytes_and_read(cgroup, arg, true);
> >  }
>
> I don't like how we reuse allocate_bytes_and_read(), we are not saving
> much. Let's keep allocate_bytes() as-is and add a separate helper. Also,
> I think allocate_and_read_bytes() is easier to read.

Fair!

>
> >
> >  static char *setup_test_group_1M(const char *root, const char *name)
> > @@ -133,6 +155,45 @@ static int test_zswap_usage(const char *root)
> >       return ret;
> >  }
> >
> > +/* Simple test to verify the (z)swapin code paths */
> > +static int test_zswapin_size(const char *root, char *zswap_size)
> > +{
> > +     int ret =3D KSFT_FAIL;
> > +     char *test_group;
> > +
> > +     /* Set up */
> > +     test_group =3D cg_name(root, "zswapin_test");
> > +     if (!test_group)
> > +             goto out;
> > +     if (cg_create(test_group))
> > +             goto out;
> > +     if (cg_write(test_group, "memory.max", "8M"))
> > +             goto out;
> > +     if (cg_write(test_group, "memory.zswap.max", zswap_size))
> > +             goto out;
> > +
> > +     /* Allocate and read more than memory.max to trigger (z)swap in *=
/
> > +     if (cg_run(test_group, read_bytes, (void *)MB(32)))
> > +             goto out;
> > +
> > +     ret =3D KSFT_PASS;
> > +
> > +out:
> > +     cg_destroy(test_group);
> > +     free(test_group);
> > +     return ret;
> > +}
> > +
> > +static int test_swapin(const char *root)
> > +{
> > +     return test_zswapin_size(root, "0");
> > +}
>
> Why are we testing the no zswap case? I am all for testing but it seems
> out of scope here. It would have been understandable if we are testing
> memory.zswap.max itself, but we are not doing that.

Eh it's just by convenience. We already have the workload - any test
for zswap can pretty much be turned into a test for swap by disabling
zswap (and enabling swap), so I was trying to kill two birds with one
stone and cover a bit more of the codebase.

>
> FWIW, I think the tests here should really be separated from cgroup
> tests, but I understand why they were added here. There is a lot of
> testing for memcg interface and control for zswap, and a lot of nice
> helpers present.

Yeah FWIW, I agree :) I wonder if there's an easy way to inherit
helpers from one test suite to another. Some sort of kselftest
dependency? Or maybe move these cgroup helpers up the hierarchy (so
that it can be shared by multiple selftest suites).

>

