Return-Path: <linux-kselftest+bounces-25896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FEDA2A311
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 09:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1133C3A7EE5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AAB22576E;
	Thu,  6 Feb 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ATwaph+K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0621CFE8
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830019; cv=none; b=jE1mNIOLX3q6TRz/Hc1g4+cW1zoNft+5PC24guk9byXQk9VzODvCTIyF0aAgK7169VZDjrSA4GobpYMU5DnvHGOiNJ19iph0eFxAkpSsQMHFSDTrF3dlusyd4Z6JuvSLGF9mURnTl1w7UiWs59zQ9T3Dx2RfEvNJ0QbCzhXXGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830019; c=relaxed/simple;
	bh=rBPgLdYbPihyaky2hnQ8FQF68vDmlGkVz0ysOpo0/7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ur3/bSZvf1KVHoecv3d4/Du1ir+uFN+ZB8AFyOr/IIn7m3viTo0DfjULfvHOOcryngvTyZPXKuOhIlyou0u2Cboi7J9oZDQg0fcNCrKTv8Om7b+GCmbbwvK1iuPrsLrYSffV2uhGNSFHkAFIWbxwEH87inr4TNrNhGhLlgogcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ATwaph+K; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7430e27b2so116662066b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 00:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738830014; x=1739434814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KKFRxvTKkIRVzPWFS+gc9L0xlnhlH0bcVyfiDKtFtA=;
        b=ATwaph+KPWd55Fmd42l0m2iWqQfm/73qjFySUo77TbBrTAfFZzWh99ijOWD+pEB2YY
         N5aNtjV9QWBJe/nOXszM/6bHAWDlF+5nLT7tKPu0CY0Qnf4ztN6QFtDBKIA9/7LtM27l
         Vd1aw0j61e5sXrBL3nVaycEEKZWlLjEF6KVXMKViIf+iamlh0fAwNQs3hex3f9TP6iVG
         ULihiHdCsOgWIvfo/7iN/4yNbgsJakxaEEtIaIlr0I5oaaWr2T9UWwNoaCMgyjh9GV7v
         /j2UIS6UypwdzGnmbLnSb1xGj447/9bXiEL1HkZ9k7SITWhIrixi16i9TgRfK5YSLpAD
         tAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830014; x=1739434814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KKFRxvTKkIRVzPWFS+gc9L0xlnhlH0bcVyfiDKtFtA=;
        b=Pjx7pWmqy3IPUDMG3IqZ1NDX2wyxyNgRoxi8JEEDHkkaanqDLR4LMjcrbv0Qqcaa7F
         QHZ4UmXwIaoJbNP+k5GYcSt6tXqiD+ho9eEtRHRWlz6gU7ddac2+y51Dnt0/Y1cjykjh
         ePGXsiM9M7ne2SSpoyzwYmZwToOGRW+JiXic0IkpmD3YlHlvbGG+ZvtMxR0EBt20yyGg
         dZ6zG+vHh4vDK1V3Ri1yayr64K7d5FsfjVTQQcB4+j0ObrWGbw5XiYU0BqFk2TKBqMbl
         SK6QGDUqZ9OzsztrodCXu/CJxwzrs50SmqAjRJohX65b4ISdzslZTVeV8/7taado40Q2
         QZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXEz/TEWSSrRTR3cDSQ52fZT1ULX7X+Om1Nh4pcd+sH8w0cD7B6ygUY0DTcRnB4jwY/6dDNWptGyQeyPbkq4mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ekb1sN3jB55FWmY5SxRLXmlLcfZxoTzztKjVROi6tRLBSAzD
	R4eKThq8f+lDbM84T1dPpfyY8gh/YTwqj6Yfhh/O4bxklXvk23mX38hgPNOkRk3VPCccXihyobe
	pR/6qgttMHHbJznmtD+QK6silg4+k4T4jcVX4Og==
X-Gm-Gg: ASbGncsXXNeh5kDFw1YOskDS2xnzPyUJabAiRVDsAE5JoP5hpT8dg+y6/DQi5wHGZ8o
	JkX+2fV5o0tArBoRTfKhD0uECSm+I/XO2jVNdz14VUymId18+z196uc0OhWeWH4oU6OADdqL/Aj
	BDTBQ4lVpkQx+XCjk=
X-Google-Smtp-Source: AGHT+IEDiIJNdCd57ZfdtaEVN/3xhTrCwYfUmuU+1JMnppeSE8LzhQi+CD/IlSePCDmwgvmwDpW8jib+Im13pkW5O7c=
X-Received: by 2002:a17:907:3e11:b0:a9a:bbcc:5092 with SMTP id
 a640c23a62f3a-ab75e2f15ffmr684125066b.39.1738830013673; Thu, 06 Feb 2025
 00:20:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6OYbS4WqQnmzi2z@debian.debian> <5f6610a1-3cd0-764e-0f49-91af1004ea50@huaweicloud.com>
In-Reply-To: <5f6610a1-3cd0-764e-0f49-91af1004ea50@huaweicloud.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 6 Feb 2025 02:20:02 -0600
X-Gm-Features: AWEUYZkiuqjywIeCSpX91jAJl2VLTme8PWd3srM8kIfgaH60HCogFdWij-XCr0I
Message-ID: <CAO3-PbrGR-U0+TxgeUUZHSwvNw2Dx=o6_EYf60ND7BLiLA-xWQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: skip non existing key in generic_map_lookup_batch
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Brian Vazquez <brianvv@google.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 12:40=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/6/2025 12:57 AM, Yan Zhai wrote:
> > The generic_map_lookup_batch currently returns EINTR if it fails with
> > ENOENT and retries several times on bpf_map_copy_value. The next batch
> > would start from the same location, presuming it's a transient issue.
> > This is incorrect if a map can actually have "holes", i.e.
> > "get_next_key" can return a key that does not point to a valid value. A=
t
> > least the array of maps type may contain such holes legitly. Right now
> > these holes show up, generic batch lookup cannot proceed any more. It
> > will always fail with EINTR errors.
> >
> > Rather, do not retry in generic_map_lookup_batch. If it finds a non
> > existing element, skip to the next key.
> >
> > Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
> > Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  kernel/bpf/syscall.c                          | 16 ++----
> >  .../bpf/map_tests/map_in_map_batch_ops.c      | 54 ++++++++++++++-----
> >  2 files changed, 45 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c420edbfb7c8..5691fc0d370d 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1979,7 +1979,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >       void __user *values =3D u64_to_user_ptr(attr->batch.values);
> >       void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
> >       void *buf, *buf_prevkey, *prev_key, *key, *value;
> > -     int err, retry =3D MAP_LOOKUP_RETRIES;
> > +     int err;
> >       u32 value_size, cp, max_count;
> >
> >       if (attr->batch.elem_flags & ~BPF_F_LOCK)
> > @@ -2026,14 +2026,8 @@ int generic_map_lookup_batch(struct bpf_map *map=
,
> >               err =3D bpf_map_copy_value(map, key, value,
> >                                        attr->batch.elem_flags);
> >
> > -             if (err =3D=3D -ENOENT) {
> > -                     if (retry) {
> > -                             retry--;
> > -                             continue;
> > -                     }
> > -                     err =3D -EINTR;
> > -                     break;
> > -             }
> > +             if (err =3D=3D -ENOENT)
> > +                     goto next_key;
> >
> >               if (err)
> >                       goto free_buf;
> > @@ -2048,12 +2042,12 @@ int generic_map_lookup_batch(struct bpf_map *ma=
p,
> >                       goto free_buf;
> >               }
> >
> > +             cp++;
> > +next_key:
> >               if (!prev_key)
> >                       prev_key =3D buf_prevkey;
> >
> >               swap(prev_key, key);
> > -             retry =3D MAP_LOOKUP_RETRIES;
> > -             cp++;
> >               cond_resched();
> >       }
> >
>
> Let's move the new thread for further discussion.
>
> >We are probably not on the same page. Let me clarify:
>
> >By "retry logic" I mean this code snippet:
> >               if (err =3D=3D -ENOENT) {
> >                       if (retry) {
> >                               retry--;
> >                               continue;
> >                       }
> >                       err =3D -EINTR;
> >                       break;
> >               }
>
>
> Yes, the retry logic doesn't change the previous key. Thanks for the
> clarifying.
> > And by "skipping to the next key", it's simply
> >
> >   if (err =3D=3D -ENOENT)
> >        goto next_key;
> >
> > Note the "next_key" label was not in the current codebase. It is only
> > in my posted patch. I don't think this would break lpm_trie unless I
> > missed something.
>
> I was trying to say that the proposed patch may break the lookup_batch
> operation for lpm_trie, and let me explain step by step:
>
> For LPM trie map:
> (1) ->map_get_next_key(map, prev_key, key) returns a valid key
>
> (2) bpf_map_copy_value() return -ENOMENT
> It means the key must be deleted concurrently.
>

I see what you mean now, thanks for the detailed explanation!

So for lpm_trie, if an element is deleted between get_next_key and
copy_value, then retry would still proceed to its next tree node. But
with or without retry, I think we cannot prevent the key from cycling
back to the beginning: an element can be deleted after copy_value, so
the key becomes invalid. After swap with prev_key and call
bpf_get_next_key, it cycles back to the leftmost. Similar can happen
if during retry the prev_key also gets invalidated. IIUC the rcu
locking in lookup really cannot prevent the tree structure from
changes.

On the other hand, bpf_map_get_next_key manual already specifies "If a
key is not found, the operation returns zero and sets the next_key
pointer to the key of the first element.". IMHO it probably makes more
sense that, regardless of normal or batch lookup, it is ultimately the
user's responsibility to properly synchronize, or deduplicate what is
returned from the kernel. I intend to keep the "skip to next" to save
the unnecessary complexity here, unless there are strong objections
that I should not.

> (3) goto next_key
> It swaps the prev_key and key
>
> (4) ->map_get_next_key(map, prev_key, key) again
> prev_key points to a non-existing key, for LPM trie it will treat just
> like prev_key=3DNULL case, the returned key will be duplicated.
>
>
> > diff --git a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops=
.c b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
> > index 66191ae9863c..b38be71f06be 100644
>
> It is better to split the update of map_tests into a separated patch and
> it will be more friendly for stable backport.

Sure I can do that.

> > --- a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
> > +++ b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
> > @@ -120,11 +120,12 @@ static void validate_fetch_results(int outer_map_=
fd,
> >
> >  static void fetch_and_validate(int outer_map_fd,
> >                              struct bpf_map_batch_opts *opts,
> > -                            __u32 batch_size, bool delete_entries)
> > +                            __u32 batch_size, bool delete_entries,
> > +                            bool has_holes)
> >  {
> > +     int err, max_entries =3D OUTER_MAP_ENTRIES - !!has_holes;
> >       __u32 *fetched_keys, *fetched_values, total_fetched =3D 0;
> >       __u32 batch_key =3D 0, fetch_count, step_size;
> > -     int err, max_entries =3D OUTER_MAP_ENTRIES;
> >       __u32 value_size =3D sizeof(__u32);
> >
> >       /* Total entries needs to be fetched */
> > @@ -135,9 +136,9 @@ static void fetch_and_validate(int outer_map_fd,
> >             "error=3D%s\n", strerror(errno));
> >
> >       for (step_size =3D batch_size;
> > -          step_size <=3D max_entries;
> > +          step_size < max_entries + batch_size; /* allow read partial =
*/
> >            step_size +=3D batch_size) {
> > -             fetch_count =3D step_size;
> > +             fetch_count =3D batch_size;
>
> The change "fetch_count =3D batch_size" may fail the lookup batch
> operation of hash table, because the element in one bucket may be
> greater than batch_size and it will return -ENOSPC constantly. And it
> seems the original implementation of fetch_and_validate() is buggy,
> because for hash map, the returned fetched_count may be less than the
> passed count when there are too many elements in the same bucket. I
> don't know the reason why the bug doesn't show up.

ACK on the ENOSPC part. Should indeed increase the fetch size. The
original code was buggy, my patch failed BPF CI for the unrelated hash
of maps case. The fetch loop should not have assumed a full batch
being returned. But it's purely luck whether tests would fail in
practice, my local vmtests all passed >.< I will fix this in V2.

> >               err =3D delete_entries
> >                     ? bpf_map_lookup_and_delete_batch(outer_map_fd,
> >                                     total_fetched ? &batch_key : NULL,
> > @@ -184,18 +185,19 @@ static void fetch_and_validate(int outer_map_fd,
> >  }
> >
> >  static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
> > -                               enum bpf_map_type inner_map_type)
> > +                               enum bpf_map_type inner_map_type,
> > +                               bool has_holes)
> >  {
> > +     __u32 max_entries =3D OUTER_MAP_ENTRIES - !!has_holes;
> >       __u32 *outer_map_keys, *inner_map_fds;
> > -     __u32 max_entries =3D OUTER_MAP_ENTRIES;
> >       LIBBPF_OPTS(bpf_map_batch_opts, opts);
> >       __u32 value_size =3D sizeof(__u32);
> >       int batch_size[2] =3D {5, 10};
> >       __u32 map_index, op_index;
> >       int outer_map_fd, ret;
> >
> > -     outer_map_keys =3D calloc(max_entries, value_size);
> > -     inner_map_fds =3D calloc(max_entries, value_size);
> > +     outer_map_keys =3D calloc(OUTER_MAP_ENTRIES, value_size);
> > +     inner_map_fds =3D calloc(OUTER_MAP_ENTRIES, value_size);
> >       CHECK((!outer_map_keys || !inner_map_fds),
> >             "Memory allocation failed for outer_map_keys or inner_map_f=
ds",
> >             "error=3D%s\n", strerror(errno));
> > @@ -209,6 +211,24 @@ static void _map_in_map_batch_ops(enum bpf_map_typ=
e outer_map_type,
> >                       ((outer_map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAP=
S)
> >                        ? 9 : 1000) - map_index;
> >
> > +     /* This condition is only meaningful for array of maps.
> > +      *
> > +      * max_entries =3D=3D OUTER_MAP_ENTRIES - 1 if it is true. Say
> > +      * max_entries is short for n, then outer_map_keys looks like:
> > +      *
> > +      *   [n, n-1, ... 2, 1]
> > +      *
> > +      * We change it to
> > +      *
> > +      *   [n, n-1, ... 2, 0]
> > +      *
> > +      * So it will leave key 1 as a hole. It will serve to test the
> > +      * correctness when batch on an array: a "non-exist" key might be
> > +      * actually allocated and returned from key iteration.
> > +      */
> > +     if (has_holes)
> > +             outer_map_keys[max_entries - 1]--;
> > +
> >       /* batch operation - map_update */
> >       ret =3D bpf_map_update_batch(outer_map_fd, outer_map_keys,
> >                                  inner_map_fds, &max_entries, &opts);
> > @@ -219,12 +239,14 @@ static void _map_in_map_batch_ops(enum bpf_map_ty=
pe outer_map_type,
> >       /* batch operation - map_lookup */
> >       for (op_index =3D 0; op_index < 2; ++op_index)
> >               fetch_and_validate(outer_map_fd, &opts,
> > -                                batch_size[op_index], false);
> > +                                batch_size[op_index], false,
> > +                                has_holes);
> >
> >       /* batch operation - map_lookup_delete */
> >       if (outer_map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS)
> >               fetch_and_validate(outer_map_fd, &opts,
> > -                                max_entries, true /*delete*/);
> > +                                max_entries, true /*delete*/,
> > +                                has_holes);
> >
> >       /* close all map fds */
> >       for (map_index =3D 0; map_index < max_entries; map_index++)
>
> OUTER_MAP_ENTRIES instead of max_entries ?

Good catch!

thanks
Yan

> > @@ -237,16 +259,20 @@ static void _map_in_map_batch_ops(enum bpf_map_ty=
pe outer_map_type,
> >
> >  void test_map_in_map_batch_ops_array(void)
> >  {
> > -     _map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_AR=
RAY);
> > +     _map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_AR=
RAY, false);
> >       printf("%s:PASS with inner ARRAY map\n", __func__);
> > -     _map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HA=
SH);
> > +     _map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HA=
SH, false);
> >       printf("%s:PASS with inner HASH map\n", __func__);
> > +     _map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_AR=
RAY, true);
> > +     printf("%s:PASS with inner ARRAY map with holes\n", __func__);
> > +     _map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HA=
SH, true);
> > +     printf("%s:PASS with inner HASH map with holes\n", __func__);
> >  }
> >
> >  void test_map_in_map_batch_ops_hash(void)
> >  {
> > -     _map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_ARR=
AY);
> > +     _map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_ARR=
AY, false);
> >       printf("%s:PASS with inner ARRAY map\n", __func__);
> > -     _map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_HAS=
H);
> > +     _map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_HAS=
H, false);
> >       printf("%s:PASS with inner HASH map\n", __func__);
> >  }
>

