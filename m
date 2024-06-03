Return-Path: <linux-kselftest+bounces-11151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FD08FA5FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7AB28469F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092BD13CABB;
	Mon,  3 Jun 2024 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2YEB+x82"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1C135A46
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Jun 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454798; cv=none; b=uoe5lmWtjhdhseLR8PjFjFex/KdHEer+M7RINl4/yXDCElwFMvzcloWzZyJLENU9e+v+aR9a0Jw41hJ9H1TazMBqUgoo8RNQvcabYuypmTJNh85r4egRCa87mYDG07FTE3BiJhmdEJI06W+3KnIFivvguq9cqPmO1prTXsWh1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454798; c=relaxed/simple;
	bh=0SDC8BkbIu6webNUXhyFkkBsSVcdj+Sq6u/l89WhDUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLPzJCsQipJDgPkScI1TIFAtnkpAp+GRZ5BSWuBLCRJ6ECpF5PSUmzxTx4PQ9d0Hrc9xnneqKlWJt+U6jk33LZ4laqscnodrwAe5qJLLxDICNDWzKli1xOh3C6r4ggymUbS17aiUrS4XJWRisPFd/wsp5QZcU0Rs3Q4dasvPqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2YEB+x82; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43fe3289fc5so50521cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2024 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717454796; x=1718059596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwApvMmCxi6kRvhFpeZNrHVjs/fSYi202Vq8O0y7Pvc=;
        b=2YEB+x82iaPcRGgd758Wy0mcQv/zPOKnypfOsXwRqgtxaDBACdtrIJl9FVHN7nGTyB
         ev9S31pkK8Blef/fm/dVZ5QuTEmXM0RBQRF0tFNYF3D1fJ8EsNW5ww+rFKGaWTD6g5Fz
         az9/wdiJrTuQLUfBBMB/+9tMrh+WDScVdUwHEthj+IKVYorJQtKUYJLOXMmYDl5T5+p4
         92iG8gHWXb794e/vtE7iyZZnFTFD+QDzoMPnzSFbIiqL3qRIyYOyDLok+SrYmnaYX66Y
         1J0f383XKM8jo/SdztHum0F5latvbmw0xnnn6jZeBJN9V54Hw10OS40G9eqbjlzCcTxZ
         M9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454796; x=1718059596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwApvMmCxi6kRvhFpeZNrHVjs/fSYi202Vq8O0y7Pvc=;
        b=Pt07z/DfiGpzVn4jlqgL7N78FEFEMtkI7YzW82Y0zVUgkh1/QOFHOlNIS6WrqBOFxF
         Ym/BLLUYi9IxqbeBRZ8AsMcURa5PnNDd+YRrRDM3gyKd/uupJ3Fv34EMH+V3FB9Q+8HK
         BdKWafS+qE/pBC4+Fe3cSR9XHh+n0gMU2UL6P3weMxy8Ct+Flc0LGAos6tp4ZA+dUiHZ
         gm7pffZBvZolNGV53FVIFPIdWN8MjoGEzx4sxIfl6XMV/kwZXo3LNnxnhQCpOGUEg+Ll
         pE8rg9No8jXmRfXoAIoCrIZEq235+DAA3lmG7wU+7zoOunEXXNmjEBJBMAnsmIbcefK5
         Z/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWLt80qeWlray4XCcgwWmoSrFMhRQn4eFEon6Yl6Kgm2UhWBJUkeCXN1t8yCDa20fa2LYkMHJg4DdFmBWNAZuFYXKr6lh/n1YrcuWzobldl
X-Gm-Message-State: AOJu0YyGOckUJpmKPPfqfetPYNKXNErRgUq5O4d17YGcpgaL9oYE4yaa
	6lV4+cOzWDsvuzddsWXoFxDkHXrL51XgpCKsuVr827apwZuBTd/dYXUWbotJVihdnUwTrXEUXUk
	WiqEN6p9EmdwgJ6+9Fx/MEmKXbMJ3iYg2asmG
X-Google-Smtp-Source: AGHT+IFNqO3Eeca3fb/gjbGejzk9epZFQKuRMTX94UERp2ub7SAJHzg0ElHPjQ2U8grOlDfvsiNhgYwFk5rOK4wQGMU=
X-Received: by 2002:a05:622a:59ce:b0:43f:ff89:dfb9 with SMTP id
 d75a77b69052e-4401bd281f4mr1732131cf.6.1717454795966; Mon, 03 Jun 2024
 15:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-3-jthoughton@google.com> <CAOUHufYFHKLwt1PWp2uS6g174GZYRZURWJAmdUWs5eaKmhEeyQ@mail.gmail.com>
 <ZlelW93_T6P-ZuSZ@google.com> <CAOUHufZdEpY6ra73SMHA33DegKxKaUM=Os7A7aDBFND6NkbUmQ@mail.gmail.com>
 <Zley-u_dOlZ-S-a6@google.com> <CADrL8HXHWg_MkApYQTngzmN21NEGNWC6KzJDw_Lm63JHJkR=5A@mail.gmail.com>
 <CAOUHufZq6DwpStzHtjG+TOiHaQ6FFbkTfHMCe8Yy0n_M9MKdqw@mail.gmail.com>
In-Reply-To: <CAOUHufZq6DwpStzHtjG+TOiHaQ6FFbkTfHMCe8Yy0n_M9MKdqw@mail.gmail.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 3 Jun 2024 15:45:59 -0700
Message-ID: <CADrL8HW44Hx_Ejx_6+FVKt1V17PdgT6rw+sNtKzumqc9UCVDfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] mm: multi-gen LRU: Have secondary MMUs participate
 in aging
To: Yu Zhao <yuzhao@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Ankit Agrawal <ankita@nvidia.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Bibo Mao <maobibo@loongson.cn>, Catalin Marinas <catalin.marinas@arm.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:06=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, May 29, 2024 at 7:08=E2=80=AFPM James Houghton <jthoughton@google=
.com> wrote:
> >
> > Hi Yu, Sean,
> >
> > Perhaps I "simplified" this bit of the series a little bit too much.
> > Being able to opportunistically do aging with KVM (even without
> > setting the Kconfig) is valuable.
> >
> > IIUC, we have the following possibilities:
> > - v4: aging with KVM is done if the new Kconfig is set.
> > - v3: aging with KVM is always done.
>
> This is not true -- in v3, MGLRU only scans secondary MMUs if it can
> be done locklessly on x86. It uses a bitmap to imply this requirement.
>
> > - v2: aging with KVM is done when the architecture reports that it can
> > probably be done locklessly, set at KVM MMU init time.
>
> Not really -- it's only done if it can be done locklessly on both x86 and=
 arm64.
>
> > - Another possibility?: aging with KVM is only done exactly when it
> > can be done locklessly (i.e., mmu_notifier_test/clear_young() called
> > such that it will not grab any locks).
>
> This is exactly the case for v2.

Thanks for clarifying; sorry for getting this wrong.

>
> > I like the v4 approach because:
> > 1. We can choose whether or not to do aging with KVM no matter what
> > architecture we're using (without requiring userspace be aware to
> > disable the feature at runtime with sysfs to avoid regressing
> > performance if they don't care about proactive reclaim).
> > 2. If we check the new feature bit (0x8) in sysfs, we can know for
> > sure if aging is meant to be working or not. The selftest changes I
> > made won't work properly unless there is a way to be sure that aging
> > is working with KVM.
>
> I'm not convinced, but it doesn't mean your point of view is invalid.
> If you fully understand the implications of your design choice and
> document them, I will not object.
>
> All optimizations in v2 were measured step by step. Even that bitmap,
> which might be considered overengineered, brought a readily
> measuarable 4% improvement in memcached throughput on Altra Max
> swapping to Optane:
>
> Using the bitmap (64 KVM PTEs for each call)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Type         Ops/sec     Hits/sec   Misses/sec    Avg. Latency     p50
> Latency     p99 Latency   p99.9 Latency       KB/sec
> -------------------------------------------------------------------------=
---------------------------------------------------
> Sets            0.00          ---          ---             ---
>     ---             ---             ---         0.00
> Gets      1012801.92    431436.92     14965.11         0.06246
> 0.04700         0.16700         4.31900     39635.83
> Waits           0.00          ---          ---             ---
>     ---             ---             ---          ---
> Totals    1012801.92    431436.92     14965.11         0.06246
> 0.04700         0.16700         4.31900     39635.83
>
>
> Not using the bitmap (1 KVM PTEs for each call)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Type         Ops/sec     Hits/sec   Misses/sec    Avg. Latency     p50
> Latency     p99 Latency   p99.9 Latency       KB/sec
> -------------------------------------------------------------------------=
---------------------------------------------------
> Sets            0.00          ---          ---             ---
>     ---             ---             ---         0.00
> Gets       968210.02    412443.85     14303.89         0.06517
> 0.04700         0.15900         7.42300     37890.74
> Waits           0.00          ---          ---             ---
>     ---             ---             ---          ---
> Totals     968210.02    412443.85     14303.89         0.06517
> 0.04700         0.15900         7.42300     37890.74
>
>
> FlameGraphs with bitmap (1.svg) and without bitmap (2.svg) attached.
>
> What I don't think is acceptable is simplifying those optimizations
> out without documenting your justifications (I would even call it a
> design change, rather than simplification, from v3 to v4).

I'll put back something similar to what you had before (like a
test_clear_young() with a "fast" parameter instead of "bitmap"). I
like the idea of having a new mmu notifier, like
fast_test_clear_young(), while leaving test_young() and clear_young()
unchanged (where "fast" means "prioritize speed over accuracy"). It
seems a little more straightforward that way.

>
> > For look-around at eviction time:
> > - v4: done if the main mm PTE was young and no MMU notifiers are subscr=
ibed.
> > - v2/v3: done if the main mm PTE was young or (the SPTE was young and
> > the MMU notifier was lockless/fast).
>
> The host and secondary MMUs are two *independent* cases, IMO:
> 1. lookaround the host MMU if the PTE mapping the folio under reclaim is =
young.
> 2. lookaround the secondary MMU if it can be done locklessly.
>
> So the v2/v3 behavior sounds a lot more reasonable to me.

I'll restore the v2/v3 behavior. I initially removed it because,
without batching, we (mostly) lose the spatial locality that, IIUC,
look-around is designed to exploit.

>
> Also a nit -- don't use 'else' in the following case (should_look_around(=
)):
>
>   if (foo)
>     return bar;
>   else
>     do_something();

Oh, yes, sorry. I wrote and rewrote should_look_around() quite a few
times while trying to figure out what made sense in a no-batching
series. I'll fix this.

>
> > I made this logic change as part of removing batching.
> >
> > I'd really appreciate guidance on what the correct thing to do is.
> >
> > In my mind, what would work great is: by default, do aging exactly
> > when KVM can do it locklessly, and then have a Kconfig to always have
> > MGLRU to do aging with KVM if a user really cares about proactive
> > reclaim (when the feature bit is set). The selftest can check the
> > Kconfig + feature bit to know for sure if aging will be done.
>
> I still don't see how that Kconfig helps. Or why the new static branch
> isn't enough?

Without a special Kconfig, the feature bit just tells us that aging
with KVM is possible, not that it will necessarily be done. For the
self-test, it'd be good to know exactly when aging is being done or
not, so having a Kconfig like LRU_GEN_ALWAYS_WALK_SECONDARY_MMU would
help make the self-test set the right expectations for aging.

The Kconfig would also allow a user to know that, no matter what,
we're going to get correct age data for VMs, even if, say, we're using
the shadow MMU. This is somewhat important for me/Google Cloud. Is
that reasonable? Maybe there's a better solution.

