Return-Path: <linux-kselftest+bounces-41745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EE5B8120A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B6434E2037
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B72940B;
	Wed, 17 Sep 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujduGSxP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AE34BA5E
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129038; cv=none; b=LSW8xRSkkHrBw9cJ6j0t9wec1TDKtN4ScJMMI6yLAgJx+YrpeeLMBv9/EHmOUAP7C54nmWlXFCAxlvnvb74S6VS8iNvQ1BDbnC6RDHv+m0vsJ/jNeZBoCLcT5t1EB5DgfkQd68jDW8H3DXmfLihi0ui47L+KsMaZEca14P46fZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129038; c=relaxed/simple;
	bh=G2z78z3yauMJqPaeDTmkhMVkVrKmoIUwOjIXhNMkTQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClvAWL1pMjyovxBfNaVLxOPFFX7fRff1MK5EtMJjQ6DarLQuioAyotEGuw52BaBUuD6p984YBJz4CnCoKqb6yR7syzrz2JQmsVoIbvq17Q+trBLULPkuhHzY6k7R6080jbycX6i6jT2Nek0btBvx7rDvXqeFBx6IWNFoJjFX2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujduGSxP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-265abad93bfso9795ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758129036; x=1758733836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15u2gJ63Nvc+ryjb04blM2EZvX2JTQ7zkIDCOHZzkRg=;
        b=ujduGSxPFIlAG+QnsapeuoRpdNPIxfZ9pixacot+GaT7TVfx3VFarvazf80LYhjHG7
         z3AWLjVXCbpIZAhrXU5l6l2FrByts4/SFUrXCvBesRk9boBIAsxXtqF+m5h1fE7oO2TT
         MdjRRq17ZUUHniuJW/UJ7HcmMspXTl8eAg2MAAnZ4ZdODotG5zo/iWesO/eXsN/YFk5w
         1/1p4vWEtIVE1ESkjapUMg/Txi+SkFjkTPJbaKZ+jEOgENsjiiKsei8ierZjiLzp5mEh
         YjPBcpoAyQhfPb1ls6gHI45hiAi2lQ3zDjjG+QoRxrA2m6IDUYUGf2j1/c7AfoRTY2p0
         ZVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129036; x=1758733836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15u2gJ63Nvc+ryjb04blM2EZvX2JTQ7zkIDCOHZzkRg=;
        b=d9rjQS4L0PC6AtA+Mn9xijLuZ5LFfvfeqNeuD/Bgc2VnR6jUX96ZRsESGho4fsdZk0
         bjSpvQ/D9p8yeZ8hiefOO83HOi4FzO0IevuP2yf0rnvlyhG5z14X3MVHK42WG+hjH9/S
         1RrKhexcLWgJdNGla3+BWS/3/t8SDEuzrAaoTF3KDf8fS6AOl0BGABuppHIoiSdJk9Lc
         jnXH+hW2THKXW+LIw/4avS8/CGANDnaGwiFTek9qzHtzitJe03AYjaKREbj2YA9oXfAQ
         wJJjN53Ghc5e7qvoG/ZU4YeEpiLIBvnTDxBfyWJBchO3IIsGlk2ycg8DZnrw6wj77Hj4
         0m+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNccfAvDe6BJM+qM74MzbeMkwh31RjL7r0Y2Ni/DHoSHrQE9ZXygM1N4z78bJoPX+o0fCFNvpa9jpwNEJFuPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM9CeHEK97QBRaeDGv2h2rl/HohRSAW5l68bqt57d+D9I59YIS
	oPc7nlhgGXNnjx9gX/VQ0V/DX7yd2z3JpK1FeSWGYpGqlJifsDJLJATFITWjQQ4+LobhumjhpKK
	crVBysipUTjdMEb4XzhsyLOm7mUVCB18gTyG4J4is
X-Gm-Gg: ASbGncvWtNO2FS7Pvk5rieFGEgEm0JirOWack/ipyCgTV2tNAZ53yWLRAs3jdGMdtJ4
	f3ScyCHguEeqe0SbnHf1/YoKkd1IPXoRt5t/njQcsSPsrnOBKnr64a5Gg/iKO955mb50RMpplEe
	SF98dV22VUaQ4uTx36vEm/yr3g2hX20WjO8I/dMbgO7e2zI0YbNCgKBCg4xXiin18x/D+P2cA0l
	og8S5nRw/RAHbCk8EUHE5YMS0jrB+92Wuqwls4s7n/F
X-Google-Smtp-Source: AGHT+IFd4BAxZT/ufICRk+rEAu4Df/3LlVy7dl8wb8UYvf1Vkm7Wii7RkWbyYEbSSxpnLkv8kfjaHMhL5z1X210qqcg=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-26808a2fc00mr4248005ad.3.1758129035969; Wed, 17 Sep 2025
 10:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-4-kaleshsingh@google.com> <c6eacb69-86f5-4bdb-9c6b-04e3f7ef7c29@redhat.com>
In-Reply-To: <c6eacb69-86f5-4bdb-9c6b-04e3f7ef7c29@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 17 Sep 2025 10:10:24 -0700
X-Gm-Features: AS18NWB7v1zd5wRtV4XjcNUI2Kl7h_0nJ3bBXH5VRcSHiB0MqTNwu-jJe9fGDsw
Message-ID: <CAC_TJvcXzrxhWFWyE7QEgPVmEJbnfT1W=s4TdgPGGAgCpn=8Og@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] mm: introduce vma_count_remaining()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:38=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.09.25 18:36, Kalesh Singh wrote:
> > The checks against sysctl_max_map_count are open-coded in multiple
> > places. While simple checks are manageable, the logic in places like
> > mremap.c involves arithmetic with magic numbers that can be difficult
> > to reason about. e.g. ... >=3D sysctl_max_map_count - 3
> >
> > To improve readability and centralize the logic, introduce a new helper=
,
> > vma_count_remaining(). This function returns the VMA count headroom
> > available for a givine process.
>
> s/givine/given/
>
> s/process/mm/
>
> >
> > The most common case of checking for a single new VMA can be done with
> > the convenience helper has_vma_count_remaining():
> >
> >      if (!vma_count_remaining(mm))
> >
> > And the complex checks in mremap.c become clearer by expressing the
> > required capacity directly:
> >
> >      if (vma_count_remaining(mm) <  4)
> >
> > While a capacity-based function could be misused (e.g., with an
> > incorrect '<' vs '<=3D' comparison), the improved readability at the ca=
ll
> > sites makes such errors less likely than with the previous open-coded
> > arithmetic.
> >
> > As part of this change, sysctl_max_map_count is made static to
> > mm/mmap.c to improve encapsulation.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
>
> [...]
>
> >       /*
> > @@ -1504,6 +1504,25 @@ struct vm_area_struct *_install_special_mapping(
> >   int sysctl_legacy_va_layout;
> >   #endif
> >
> > +static int sysctl_max_map_count __read_mostly =3D DEFAULT_MAX_MAP_COUN=
T;
> > +
> > +/**
> > + * vma_count_remaining - Determine available VMA slots
> > + * @mm: The memory descriptor for the process.
> > + *
> > + * Check how many more VMAs can be created for the given @mm
> > + * before hitting the sysctl_max_map_count limit.
> > + *
> > + * Return: The number of new VMAs the process can accommodate.
> > + */
> > +int vma_count_remaining(const struct mm_struct *mm)
> > +{
> > +     const int map_count =3D mm->map_count;
> > +     const int max_count =3D sysctl_max_map_count;
>
> If we worry about rare races (sysctl_max_map_count changing?) we should
> probably force a single read through READ_ONCE()?
>
> Otherwise one might trick vma_count_remaining() into returning a
> negative number I assume.

Agreed, I'll add the READ_ONCE when resending.

Thanks,
Kalesh

>
> > +
> > +     return (max_count > map_count) ? (max_count - map_count) : 0;
> > +}
>
> Nothing else jumped at me.
>
> Not sure what the buildbot complains about but I'm sure you'll figure it
> out :)
>
> --
> Cheers
>
> David / dhildenb
>

