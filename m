Return-Path: <linux-kselftest+bounces-38050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DB6B14EDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18252189404C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA891CBEAA;
	Tue, 29 Jul 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="PTA1ouYO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AA19D08F
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797382; cv=none; b=an+LIRSDHF3mXQcjMSZjXq+WuPFwZpybTRhsTQzPwQGF9o7WRpyKkpHGEWqUscuDHtDXbGqQrdmP93bnIbhvNKu2hbaQJXHVzPleA8NaQmRkWeP8geTVeNODhVMLyb48GxmJ+lreJU240DihSS6+DAtrEXn6NDHbb96Wze2dNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797382; c=relaxed/simple;
	bh=5l+kX3TlXyRbsgOTyGA3oWiH4eVSrFAAaoihgsCn8ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFwnAe9LLorcMXvSh+imv7/QXby9AqygLHLINMgsC6IlxBtyLmMCrycUzn+Xpsec74H2My9zEIJNs1D2dj12nfyGSIZpstE3BP83nx07Z+W0vY0SI/wa8gonzRZROCuN8KDHgVUz3PaRXUMVzLfeBrQsY0lgjSg+GLYy3fI8Q7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=PTA1ouYO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2401b855980so19550985ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1753797379; x=1754402179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv8soW1s35ahL418D8VF6q42tDzqNXV2suiJtYXndw0=;
        b=PTA1ouYOCta6b9E2k13otpsr1iRxjwhcz9xBk5iuvLUR2TdBxwGpU2kyo9RS2gM3cQ
         hfE/EERq9kzJltnYLeDIaoveE6nTXYG/21mXimsgKRVL7t5MDADKPBmrcwtaDsEz64Xm
         6/djBTZMN2XfljN7PYi+70GdCCRJMa13+jsTL+5IBJl8Fo4I0/dHumNgcWKYsYXwArle
         CZs7gIYEsV/bvIk3yIxMRbICV4kAoaPs5c3EBtyvYmshMCv1q7OvKtfITx9cib4oOmhx
         0J6QIFbjaBUtetMlc+OQR8ak6BhksrOdb+OoxRJ4et5quIXpzLlfHmbcWqsBRllQbPFS
         RvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797379; x=1754402179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mv8soW1s35ahL418D8VF6q42tDzqNXV2suiJtYXndw0=;
        b=T9QoP10Ak/U5hbqRclRS0FURwJ33nyodL78dFiRrJPXcDFw2c7fD/NKItzdjuWSb4b
         K0DAH1WHkGN4M4mNsWxFHDhkQAwcet2Z65PKNGwrcSsL5L3Le+4yQ9W9CRfhsKKt9CbX
         W6s9IqtNOD6xCXKl2lu8r9Z8On7VyknR8B8DWTATca26jMw+iQeZO72F9s76xkC6EmjO
         fh3myCTgfVKBAgCTBYa8OToGWV/omBDrpwBJPyi9+bPHYxXgO7VYjHzJ6tKykD+8Aqb1
         GUMEdm51+GbP+wXM+EHow6V2U397frmMQFV0xsZNNN3K4clC3UN8i4ACfNs7yQlJBnHo
         XotQ==
X-Forwarded-Encrypted: i=1; AJvYcCVehfWZrN6FATSACYdC5aGneSGO5SO0++ExGHkBdOG7eMCnTedzgzxZHluAiSZ20FzszAq/N9DRboQ2VCJ8J/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSNvRKkg8U8yd9TtVZcNyI/ZnaPS6vqf8vA54t99Kn1YuPjlM
	1vwHcHy2c0GsXDgD6YnXhiSf/oxC+/ZHiPSOMat55yEFm9GjTYwzCSLGBM/ZSOZA8D5MhzuHUeN
	9nb2KQhx9eVQJnlEtjsSIOXwdYHWQUwM89BP6ZdOAlg==
X-Gm-Gg: ASbGncsz54UdgZOWZJJdt/wzkFfJhF4UU/+Z5OxFa0dS1SW6UFP/VTMUUICK3rSVAWU
	zmW1zgXx4saSrsKq9rT4+fitUzxxfHQQTgioHaMv/9kFbnjwoUpH6Mael0ghPGX0YabcXhe6J/r
	Iz5Sno3mjGa0OMrKNRSwSQ3if9syAiIeB6WPqCjczhyXaYiGitJz4hEPC/obwFBkoRZTm8p8Wgg
	JEijaTP5d8NTBY/b+agedM=
X-Google-Smtp-Source: AGHT+IF6uEUYENM3G9dCl88PHF00oq2dRXfczisPYmPfnfZrmOLAxA2y+iiVlrzNEWcQwWHX0TDJK6HbPzYzjVZQifM=
X-Received: by 2002:a17:902:e0d2:b0:23f:ed09:f7b with SMTP id
 d9443c01a7336-23fed091110mr101344245ad.48.1753797378920; Tue, 29 Jul 2025
 06:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722150152.1158205-1-matt@readmodwrite.com> <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com>
In-Reply-To: <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Tue, 29 Jul 2025 14:56:07 +0100
X-Gm-Features: Ac12FXxSY86YYUNk9ahjFEIXjGzaAjdeUoQ5VugkiuP2RpgzCdnBA11sRvUpiYc
Message-ID: <CAENh_SS2R3aQByV_=WRCO=ZHknk_+pV7RhXA4qx5OGMBN1SnOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 3:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Please make a full description of what the test does,
> since it's not trivial to decipher from the code.
> If I'm reading it correctly, first, the user space
> makes the LPM completely full and then lookup/update
> use random key-s within range.

Yep, that's correct. I'll provide a more comprehensive description in v4.

> But delete looks different. It seems the kernel delete
> operation can interleave with user space refilling the LPM,
> so ...
>
> >   lookup: throughput    7.423 =C2=B1 0.023 M ops/s (  7.423M ops/prod),=
 latency  134.710 ns/op
> >   update: throughput    2.643 =C2=B1 0.015 M ops/s (  2.643M ops/prod),=
 latency  378.310 ns/op
> >   delete: throughput    0.712 =C2=B1 0.008 M ops/s (  0.712M ops/prod),=
 latency 1405.152 ns/op
>
> this comparison doesn't look like apples to apples,
> since delete will include user space refill time.

Yeah, you're right. Though we only measure the delete time from in the
BPF prog, delete throughput is essentially blocked while the refill
happens and because things are measured with a 1-second timer
(bench.c:sigalarm_handler) the refill time gets accounted for anyway.
I could try extrapolating the delete time like I've done for the free
op, i.e. we calculate how many ops were completed in what fraction of
a second.

> >     free: throughput    0.574 =C2=B1 0.003 K ops/s (  0.574K ops/prod),=
 latency    1.743 ms/op
>
> Does this measure the free-ing of full LPM ?

Yes, this measures the total time to free every element in the trie.

> > +static void __lpm_validate(void)
>
> why double underscore ?
> Just lpm_validate() ?

The double underscore is used for the common validation parts, but
I'll rename this to include "_common()" (along with all other uses of
__).

> > +       /*
> > +        * Ideally we'd have access to the map ID but that's already
> > +        * freed before we enter trie_free().
> > +        */
> > +       BPF_CORE_READ_STR_INTO(&name, map, name);
> > +       if (bpf_strncmp(name, BPF_OBJ_NAME_LEN, "trie_free_map"))
> > +               return 0;
> > +
> > +       val =3D bpf_ktime_get_ns();
> > +       bpf_map_update_elem(&latency_free_start, &map, &val, BPF_ANY);
>
> Looks like there is only one lpm map.
> What's the point of that extra map ?
> Just have a global var for start time ?

Sure, I can make this a global variable for the start time instead.

> bpf_get_prandom_u32() is not free
> and modulo operation isn't free either.
> The benchmark includes their time.
> It's ok to have it, but add a mode where the bench
> tests linear lookup/update too with simple key.data++

Good idea.

> Since the map suppose to full before we start all keys
> should be there, right?

Yes.

> Let's add a sanity check that update() succeeds.

Will do.

> > +static int delete (__u32 index, bool *need_refill)
> > +{
> > +       struct trie_key key =3D {
> > +               .data =3D deleted_entries,
> > +               .prefixlen =3D prefixlen,
> > +       };
> > +
> > +       bpf_map_delete_elem(&trie_map, &key);
> > +
> > +       /* Do we need to refill the map? */
> > +       if (++deleted_entries =3D=3D nr_entries) {
> > +               /*
> > +                * Atomicity isn't required because DELETE only support=
s
> > +                * one producer running concurrently. What we need is a
> > +                * way to track how many entries have been deleted from
> > +                * the trie between consecutive invocations of the BPF
> > +                * prog because a single bpf_loop() call might not
> > +                * delete all entries, e.g. when NR_LOOPS < nr_entries.
> > +                */
> > +               deleted_entries =3D 0;
> > +               *need_refill =3D true;
> > +               return 1;
>
> This early break is another reason that makes
> 'delete' op different from 'lookup/update'.
> Pls make all 3 consistent, so they can be compared to each other.

Hmm.. I'm not quite sure how to do that. lookup/update don't modify
the number of entries in the map whereas delete does (update only
updates existing entries, it doesn't create new ones). So when the map
is empty it needs to be refilled. You're right that somehow the time
to refill needs to be removed from the delete throughput/latency
numbers but fundamentally these 3 ops are not the same and I don't see
how to treat them as such.

