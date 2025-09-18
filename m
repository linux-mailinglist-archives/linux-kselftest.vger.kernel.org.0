Return-Path: <linux-kselftest+bounces-41865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE7B85CF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A93E4E334B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D13148DC;
	Thu, 18 Sep 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTniQnn1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E92313E31
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210925; cv=none; b=bX3yKx+5hM36llP/w41AGCjBIuGvVhvBTB1uvAv6/+DzafH6P9+furNyIb/BYXuuKamXDS/L92cH0X2Vey+ZMra+zDTtLe9K8sd2aAr6mZsJIVuAlUyz4OzREfvQ3yRnCbhcm+grF3kCYT7a85zC/q/pvJVKCN3A42NAq/vsrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210925; c=relaxed/simple;
	bh=MjopfM6zKfXfv97zUg4k3gKM2XwfKig6ByXDbihgQ2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d21MFb69UO5g/BVtlRB8aR9woY+wB0KYhMzJw/havfp6R1LUjQ28E8e/8qiHqTc38xJMsfPuk1ggT1R1kZntmq+kJU5TOLVKVcWtLKgG75KBXisaqqFwS+zsIvWnOSlO+dO96XbKkfBFu6Ek1FbHOu+CC6ztfOB0nlWe/VGFP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTniQnn1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681645b7b6so193195ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210923; x=1758815723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB56UEO0mNP2hRYBRO1UDnRhREYhvCPXWZ0EMOooGbY=;
        b=XTniQnn1LQUeVXVkXCIo3LNLGbS+G9UgXGsPMp4lZMx4cWk1CLhNGiG+461rdJ7kWu
         xJyJYa9c+4+doCrf6YeIW4V/vC3QunuOfshrh0p1ZdD739EMYwZO/RSXAUVx/Y2ROe/W
         NuLtYM3FGfRlgIzQBcPuoqWioSDJ6k0EMTlomW2CLtEWdAcVWpSpJIXjMyzhHnnYukCW
         OJgNFaSgVmSYXzfGpe/fsSuALyDoGM2wPUmsE6Kf/bSzdkRnIBi6Yt+cltuytQg4nFph
         xGGNA15ZXKlhJ8D1GLawQgIyQVf1hBS8rTQvZvH5m7TkWLJ5lFrcGdmfcgVD8UwaFcsL
         vmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210923; x=1758815723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB56UEO0mNP2hRYBRO1UDnRhREYhvCPXWZ0EMOooGbY=;
        b=wrxnyUbeka0mQi7a6zvlZ0ukfmglgHD0sj8G8oBmCzlnZUS/NfNLBZqoKBsbg8IH4c
         n2xL9c7NuDznH908voLgsntXThKdy4IV6G13KsfkxyaNATCVxrdzKqLOsX+wKMR3X41o
         QE4ftpsTXz+3aVKlK7Tr1zWEK//mLlR/A8rk8Jm0u0lpPECTtNDj4HqPulgwMOLdsNrg
         ogFx/Sp4tahUrit5H8k+FC9IgUJ5VDH0lXtS3lxv2Asxltxa9kYXpcOpfiu7kKNvOrRQ
         AkP5vr5Gnk8HFvwbwaBTkU2qaF//vN9gA4PhMrx34ExFi6TAcxA56yQ62KqwykIb+VVr
         FZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5nKzXo7IMTWsjk106lCnplb1DGnOZYnrCbgomy4dEBFrJvph8jXxs1XwW6JhBD9YYOvHV7lyH5x3nVH97sUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWy4A+wOdloulUAIgLTA2FCrUlDG3j53rcLujV77/bM6kqbzK
	ytAtm76OiLbpzUOeb/pNuOzECTeqFhboK7UjQFgGrO1jGSazjLPav6k1GKUhFU9bKULwe3ZD6xd
	+S9mDolWiXGy30+Jb2GO2I2sQ39wuvkzE/JGR63Bo
X-Gm-Gg: ASbGncvRfh+BOWAUPj1k6WUcHqK2xuP8tnl3lGbDZip0ohB2lIMlh4SmZevYbektGxU
	PTA/vrbArWpsxEfMOQbli24ASoYdGa0R4ERDVhdB43D0Yg4GwU5c2wTjxVZHxucq04YHTG3xmjV
	X6V9L8CECWcsy4Ub8byICBDm2N6aVFCr7z9D31uTryMv11KJptJr4NDgXKUZAxDLoyT07KQcO1A
	DyQqF2BCddEi1QBtHva1Mx5eJ/aJIVciHa4YSTFyFHmijkxnzNq3g4BFCFvaWA=
X-Google-Smtp-Source: AGHT+IHtle2Bol/8iJ1CI7SONgmRyw+7KDNF3rjHCoT0hB77tatWLPJOO/VLwsIgvGtPKBGy3m8lRqkiHkO7GeZDCgQ=
X-Received: by 2002:a17:902:ea06:b0:265:cb5f:3a66 with SMTP id
 d9443c01a7336-26808aeb835mr11034625ad.13.1758210922376; Thu, 18 Sep 2025
 08:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com> <385df771-961c-4fc1-971c-81314c231f5d@lucifer.local>
 <53ade9bf-5cdb-49b6-b8c9-1f653c861bde@lucifer.local>
In-Reply-To: <53ade9bf-5cdb-49b6-b8c9-1f653c861bde@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 18 Sep 2025 08:55:10 -0700
X-Gm-Features: AS18NWDy23QFicFxq7eonAAZapCtI7hAuF1vOI9oXz3unSnA7mgzsm9MtU96rN4
Message-ID: <CAC_TJvdRf3xJg7FgTzAxa-ZrHkGA0G3dEDVWWWttg3ri2B-FNw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded trace event
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com, 
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

On Thu, Sep 18, 2025 at 6:52=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
>
> On Thu, Sep 18, 2025 at 02:42:16PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Sep 15, 2025 at 09:36:38AM -0700, Kalesh Singh wrote:
> > > Needed observability on in field devices can be collected with minima=
l
> > > overhead and can be toggled on and off. Event driven telemetry can be
> > > done with tracepoint BPF programs.
> > >
> > > The process comm is provided for aggregation across devices and tgid =
is
> > > to enable per-process aggregation per device.
> > >
> > > This allows for observing the distribution of such problems in the
> > > field, to deduce if there are legitimate bugs or if a bump to the lim=
it is
> > > warranted.
> >
> > It's not really a bug though is it? It's somebody running out of resour=
ces.
> >
> > I'm not sure how useful this is really. But I'm open to being convinced=
!
> >
> > I also wonder if this is better as a statistic? You'd figure out it was=
 a
> > problem that way too right?
> >
> > >
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Cc: Mike Rapoport <rppt@kernel.org>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Pedro Falcato <pfalcato@suse.de>
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> >
> > This breaks the VMA tests, please make sure to always check them:
> >
> > cc -I../shared -I. -I../../include -I../../arch/x86/include -I../../../=
lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=3Daddress -fsanitize=3Dundefined=
    -c -o vma.o vma.c
> > In file included from vma.c:33:
> > ../../../mm/vma.c:10:10: fatal error: trace/events/vma.h: No such file =
or directory
> >    10 | #include <trace/events/vma.h>
> >       |          ^~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make: *** [<builtin>: vma.o] Error 1
>
> Trivial build fix:
>
> ----8<----
> From fe4c30abbd302ccc628ec92381ac10cea31c6d85 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Thu, 18 Sep 2025 14:47:10 +0100
> Subject: [PATCH] fix
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c                         | 2 --
>  mm/vma_internal.h                | 2 ++
>  tools/testing/vma/vma_internal.h | 4 ++++
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 26046b28cdda..a11d29a2ddc0 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -7,8 +7,6 @@
>  #include "vma_internal.h"
>  #include "vma.h"
>
> -#include <trace/events/vma.h>
> -
>  struct mmap_state {
>         struct mm_struct *mm;
>         struct vma_iterator *vmi;
> diff --git a/mm/vma_internal.h b/mm/vma_internal.h
> index 2f05735ff190..2f5ba679f43d 100644
> --- a/mm/vma_internal.h
> +++ b/mm/vma_internal.h
> @@ -47,6 +47,8 @@
>  #include <linux/uprobes.h>
>  #include <linux/userfaultfd_k.h>
>
> +#include <trace/events/vma.h>
> +
>  #include <asm/current.h>
>  #include <asm/tlb.h>
>
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index 07f4108c5e4c..c08c91861b9a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1661,4 +1661,8 @@ static inline void vma_count_dec(struct mm_struct *=
mm)
>         vma_count_sub(mm, 1);
>  }
>
> +static void trace_max_vma_count_exceeded(struct task_struct *task)
> +{
> +}
> +
>  #endif /* __MM_VMA_INTERNAL_H */

I made a point to build and run your tests, seems I forgot to actually
test it with this last patch.

Thanks for the fix.

--Kalesh

> --
> 2.51.0

