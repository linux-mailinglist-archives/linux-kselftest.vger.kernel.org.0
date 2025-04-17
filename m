Return-Path: <linux-kselftest+bounces-31025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C955A9111D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 03:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9769190477B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 01:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201FB199EAD;
	Thu, 17 Apr 2025 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="airZdFGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663319AA5D;
	Thu, 17 Apr 2025 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853167; cv=none; b=ATw00v4is9Ii0iNFbLCugD3JQkI5pHQCzXmbkBNffawItn8d/Y31gnH9DHlO/brqMpvHOCSnMKoKbMk2aDn0RzQ43BlnHqkEBdympC/owWE3/hZVaDhTTRZa3IasMBDCBr3Flc/G/9Etqtcl7zIeHkc/vOlnqLPlM5+P2yHzw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853167; c=relaxed/simple;
	bh=Pb9pVqKpDofUm9GlwrhQ7qK1jHIfS2Iexjbs+sWfBWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNRR8V0atTHfOH5yoO3RdV5Gb1Lck7rDIMUPHn5xk3GkcR828VHLvr6J63vNgHVDBH9i/q9zGbDbT7dtjp4BZwhn5Ud+15pyUBq6+nqS9E4LGLVUkLRRhNtlgc5/GcJqjV/TZTMc/qi0L6GribNzfhCI10FqKw+Z9ItCwI7XI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=airZdFGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A19C4CEF2;
	Thu, 17 Apr 2025 01:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744853166;
	bh=Pb9pVqKpDofUm9GlwrhQ7qK1jHIfS2Iexjbs+sWfBWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=airZdFGw3wpvOs40mW8E2YLru8wKJmhYXXJD0BFDmfADYDBUMviTecaZGkl7LqzLG
	 5+qYPv331/DuQi6JkA9bylQHRpkECdd6M8dWfwaGLlUyu/caUFmfTqTSm1b0saM8Vw
	 Niaj949lhqYDglKwgumwONPzxhpRVI6OqVuAFHqqqHoCKD5TCllIroudCtHWygAsZL
	 BehR13jsV8jC2jQky+D97kPAjPdvbO5C8yBcSTFpEWieubXFAkK1D+QIA4txyswnyf
	 kt3fQQ9ts1uoQuLVCknhKoJ3iDRh/k7WMNshJtAQLtz/PiKqBcHRQqXLYkfSJAMGx9
	 usGqfkWtOCnSQ==
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47688ae873fso2614471cf.0;
        Wed, 16 Apr 2025 18:26:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+b/m/R/BfmUmC4my/cYrLFLkwPPQ3ydBYDBRwwE265uFySHzTKFmCRybkF4EsLhSvzvDQjtb4GbMj1kTq@vger.kernel.org, AJvYcCUfghfjipWU/c1TGkptruw7+U/eb1iEwu/tk2jgARtMsI4dKjcTw98VCyV9+1Awm8zym8k1LJTeGJ5CTOc=@vger.kernel.org, AJvYcCUmjV67qLFjwuDUbNsBi57R0t+GicAeKFGpx75fM8+lUVLJtd7RnPsGKewg5KRT8EBz0hd8TUTeqo7E@vger.kernel.org, AJvYcCW7Ehe9Y4esHtPLN3j4h+nMCqKA3u7VCyOE2Mf2Sls4nDPlPWS3EhHboN9rXyqeaoWureE=@vger.kernel.org, AJvYcCWEBbIe25TPJYTh1KJwd2XMGGMco3fqe7rjMhQb/GO3nVDP4IGnWjkBH3SRY6sq2eG8atbboKNZ0IkQIJrC2k3l@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1t03tzySJtaKYw1/3NXe+SjbgymcWOYiX1wR7viGo96x8bPqj
	PUTMjgD0UxslsUpQeP/FfKhgq9hczfv2oWSgQifcRiBiPNoKneqEfLAhGhbHaDFCR792+Gz9F+w
	IJpuzZa/89qXy65BzzPFB4W8nXoc=
X-Google-Smtp-Source: AGHT+IH+IOWI0C/2mrprWoiDphyhjDZa4XjFqxPGvR745gNdFLLsLYbpwl+N9PVJmnqgIXxV32totXw4girR2aT01Tc=
X-Received: by 2002:a05:622a:305:b0:476:b7e2:385e with SMTP id
 d75a77b69052e-47ad80b9d1bmr51204791cf.17.1744853165338; Wed, 16 Apr 2025
 18:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
 <CABdmKX0bgxZFYuvQvQPK0AnAHEE3FebY_eA1+Vo=ScH1MbfzMg@mail.gmail.com>
 <CAPhsuW72Q2--E9tQQY8xADghTV6bYy9vHpFQoCWNh0V_QBWafA@mail.gmail.com> <CABdmKX1tDv3fSFURDN7=txFSbQ1xTjp8ZhLP8tFAvLcO9_-4_A@mail.gmail.com>
In-Reply-To: <CABdmKX1tDv3fSFURDN7=txFSbQ1xTjp8ZhLP8tFAvLcO9_-4_A@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 16 Apr 2025 18:25:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7xvSYjWvy8K9Ev_tMwDRy2dpEiBcHYai3n-wAa0xvLow@mail.gmail.com>
X-Gm-Features: ATxdqUFeEdI62EdJA7S6mr-T1-xMxtG3tzu_ONZ5VOwpfwB7f0lVzKO-NZuipkk
Message-ID: <CAPhsuW7xvSYjWvy8K9Ev_tMwDRy2dpEiBcHYai3n-wAa0xvLow@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:40=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Wed, Apr 16, 2025 at 4:08=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Wed, Apr 16, 2025 at 3:51=E2=80=AFPM T.J. Mercier <tjmercier@google.=
com> wrote:
> > [...]
> > > >
> > > > IIUC, the iterator simply traverses elements in a linked list. I fe=
el it is
> > > > an overkill to implement a new BPF iterator for it.
> > >
> > > Like other BPF iterators such as kmem_cache_iter or task_iter.
> > > Cgroup_iter iterates trees instead of lists. This is iterating over
> > > kernel objects just like the docs say, "A BPF iterator is a type of
> > > BPF program that allows users to iterate over specific types of kerne=
l
> > > objects". More complicated iteration should not be a requirement here=
.
> > >
> > > > Maybe we simply
> > > > use debugging tools like crash or drgn for this? The access with
> > > > these tools will not be protected by the mutex. But from my persona=
l
> > > > experience, this is not a big issue for user space debugging tools.
> > >
> > > drgn is *way* too slow, and even if it weren't the dependencies for
> > > running it aren't available. crash needs debug symbols which also
> > > aren't available on user builds. This is not just for manual
> > > debugging, it's for reporting memory use in production. Or anything
> > > else someone might care to extract like attachment info or refcounts.
> >
> > Could you please share more information about the use cases and
> > the time constraint here, and why drgn is too slow. Is most of the dela=
y
> > comes from parsing DWARF? This is mostly for my curiosity, because
> > I have been thinking about using drgn to do some monitoring in
> > production.
> >
> > Thanks,
> > Song
>
> These RunCommands have 10 second timeouts for example. It's rare that
> I see them get exceeded but it happens occasionally.:
> https://cs.android.com/android/platform/superproject/main/+/main:framewor=
ks/native/cmds/dumpstate/dumpstate.cpp;drc=3D98bdc04b7658fde0a99403fc052d1d=
18e7d48ea6;l=3D2008

Thanks for sharing this information.

> The last time I used drgn (admittedly back in 2023) it took over a
> minute to iterate through less than 200 cgroups. I'm not sure what the
> root cause of the slowness was, but I'd expect the DWARF processing to
> be done up-front once and the slowness I experienced was not just at
> startup. Eventually I switched over to tracefs for that issue, which
> we still use for some telemetry.

I haven't tried drgn on Android. On server side, iterating should 200
cgroups should be fairly fast (< 5 seconds, where DWARF parsing is
the most expensive part).

> Other uses are by statsd for telemetry, memory reporting on app kills
> or death, and for "dumpsys meminfo".

Here is another rookie question, it appears to me there is a file descripto=
r
associated with each DMA buffer, can we achieve the same goal with
a task-file iterator?

Thanks,
Song

