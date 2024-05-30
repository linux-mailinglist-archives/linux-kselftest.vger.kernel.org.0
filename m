Return-Path: <linux-kselftest+bounces-10888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657808D42B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6562854A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB112E71;
	Thu, 30 May 2024 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CxcI6FD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F5F510
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031327; cv=none; b=ERkRZJBWYcg8dVKKUGfWzPQuhKEG9wo/Yg1U9JAaxpPkdgwA8+GTWoc1jjiTR/zAIW7Wm9KiDq+zzpRQ4ISKzSkLzOCXZRnV1ZrSeHlwtOVn08MLSU6Iu0SuNOWgHyek/94Vf/3/ZdBfQSrt0rRrJbvvIptnUSoqEmvaZ8AU7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031327; c=relaxed/simple;
	bh=HUAN0/h1uUnwVHvw5+gjjvN2wmVD3N2hYhH/W+fSmng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpjUns5GN0k027J71G/CByflM/nxQsukblVZ+9ykzqnj5fh3mXtfpKgw9ECUGnTltx1oqsFwRzTRXuAsFK6YkqODpoZLfhvsI7R9fivG6PTG9YA2AKz23DK84+cCBrDs2kIxjfCMIY0bps6GzgqqhIcxujNVMUPZHbVycziE4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CxcI6FD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43f87dd6866so167741cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 18:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717031324; x=1717636124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNCYiTPJ+jmwqf05JMT+AdSr7J72TbIz2CKFhve3Jy0=;
        b=0CxcI6FDl7jFDQxcpUYxZt5vBPgkc6u9I8kDHvOF1t4nxhy5YdkqiDc92+E1QFjBKt
         YCnld08mSd/EPuEkf9cN83p9ZGJJdSW1vvAqiO/uDlNSvEm0FQt2Jy2+4B9UXiqUcGEJ
         OMmxgGvT/L6gqZ+1JZL5PvL6gN2g0y/Kmaeikr1QToKJV8EDaLiGXPfNpYax2gnxj1yJ
         srEhKv09Q2KyuZNzA3YxHQ/f5WAHQYjlh24DdofT0tWdgnqQb0JPldGS8QQrXG7IqGQJ
         wUN35PyD3tV/2alPCcwAPx4CXGaiPkWVQyS5BbJM15JNAZk9NnU+TDEmQCLy9iKPRlmS
         u8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717031324; x=1717636124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNCYiTPJ+jmwqf05JMT+AdSr7J72TbIz2CKFhve3Jy0=;
        b=eMBuWgGHoOhDuXwkZvCO/l/EO39BCjv2cU4sIgEV2tv//84Ay+uA645S4P7dKge7hA
         /NrS2erT1b/KkVsvegtho178V92Cdiu5LKu51nHuOHOJMBOtcma+G4xH9Qk9607riLLg
         ihnhLSinYLhveSK1RQjzyO4fELCQjIzTAkviAmhaPGQ4AaizF80lhOYYfbkLLYr1Genj
         tviSZuRDaoJXyyrqIrrsW06eGeq5FrdJecFpjDLus0u+gAkHIoNJ2/zR1AGOsE40Zk07
         m40g0FnMcZy+o4wSppLqNX3SqqRGpVJAGjzi8GTlqGmpl4Lm3vV/Cbbg04rwixdl1kIO
         /lgA==
X-Forwarded-Encrypted: i=1; AJvYcCUBvy4ek7mA9XxgaaxB3VSjEUTYZcp/X+Nq2mX8RgfWyqMU2CcwyqG8PC6UJ6aUsjQkKX5b6n8Yn9pUbFmyKXh876Oibx7ZO6CTgbssts3Z
X-Gm-Message-State: AOJu0YwGwfo6FLzBJgsAFetrcRfM5h0HbnonmD4LOre43GStPRw1KtPw
	944uuK1lBXs4UVOM+UT0uafuEZ8ph9CSFVrB4UuyCk0ug7s81D95uRDiprXs6Vt/ew8u4DsL+Qd
	t2pSZuQM7uNxSEmTkhQUr5E3rUDbvf2wcD4LJ
X-Google-Smtp-Source: AGHT+IFJBPRQlkDyYJeSsGM/RxiiiLg1VsLLsha8SGwYsobiZXs39Abfff+lsGr1GDYLgVu96Cm8k7GvNnaVZDK3Ruk=
X-Received: by 2002:a05:622a:5509:b0:43b:6b6:8cad with SMTP id
 d75a77b69052e-43fe8e0b1dfmr1268341cf.10.1717031323987; Wed, 29 May 2024
 18:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-3-jthoughton@google.com> <CAOUHufYFHKLwt1PWp2uS6g174GZYRZURWJAmdUWs5eaKmhEeyQ@mail.gmail.com>
 <ZlelW93_T6P-ZuSZ@google.com> <CAOUHufZdEpY6ra73SMHA33DegKxKaUM=Os7A7aDBFND6NkbUmQ@mail.gmail.com>
 <Zley-u_dOlZ-S-a6@google.com>
In-Reply-To: <Zley-u_dOlZ-S-a6@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 29 May 2024 18:08:06 -0700
Message-ID: <CADrL8HXHWg_MkApYQTngzmN21NEGNWC6KzJDw_Lm63JHJkR=5A@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] mm: multi-gen LRU: Have secondary MMUs participate
 in aging
To: Sean Christopherson <seanjc@google.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
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

On Wed, May 29, 2024 at 3:58=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 29, 2024, Yu Zhao wrote:
> > On Wed, May 29, 2024 at 3:59=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Wed, May 29, 2024, Yu Zhao wrote:
> > > > On Wed, May 29, 2024 at 12:05=E2=80=AFPM James Houghton <jthoughton=
@google.com> wrote:
> > > > >
> > > > > Secondary MMUs are currently consulted for access/age information=
 at
> > > > > eviction time, but before then, we don't get accurate age informa=
tion.
> > > > > That is, pages that are mostly accessed through a secondary MMU (=
like
> > > > > guest memory, used by KVM) will always just proceed down to the o=
ldest
> > > > > generation, and then at eviction time, if KVM reports the page to=
 be
> > > > > young, the page will be activated/promoted back to the youngest
> > > > > generation.
> > > >
> > > > Correct, and as I explained offline, this is the only reasonable
> > > > behavior if we can't locklessly walk secondary MMUs.
> > > >
> > > > Just for the record, the (crude) analogy I used was:
> > > > Imagine a large room with many bills ($1, $5, $10, ...) on the floo=
r,
> > > > but you are only allowed to pick up 10 of them (and put them in you=
r
> > > > pocket). A smart move would be to survey the room *first and then*
> > > > pick up the largest ones. But if you are carrying a 500 lbs backpac=
k,
> > > > you would just want to pick up whichever that's in front of you rat=
her
> > > > than walk the entire room.
> > > >
> > > > MGLRU should only scan (or lookaround) secondary MMUs if it can be
> > > > done lockless. Otherwise, it should just fall back to the existing
> > > > approach, which existed in previous versions but is removed in this
> > > > version.
> > >
> > > IIUC, by "existing approach" you mean completely ignore secondary MMU=
s that
> > > don't implement a lockless walk?
> >
> > No, the existing approach only checks secondary MMUs for LRU folios,
> > i.e., those at the end of the LRU list. It might not find the best
> > candidates (the coldest ones) on the entire list, but it doesn't pay
> > as much for the locking. MGLRU can *optionally* scan MMUs (secondary
> > included) to find the best candidates, but it can only be a win if the
> > scanning incurs a relatively low overhead, e.g., done locklessly for
> > the secondary MMU. IOW, this is a balance between the cost of
> > reclaiming not-so-cold (warm) folios and that of finding the coldest
> > folios.
>
> Gotcha.
>
> I tend to agree with Yu, driving the behavior via a Kconfig may generate =
simpler
> _code_, but I think it increases the overall system complexity.  E.g. dis=
tros
> will likely enable the Kconfig, and in my experience people using KVM wit=
h a
> distro kernel usually aren't kernel experts, i.e. likely won't know that =
there's
> even a decision to be made, let alone be able to make an informed decisio=
n.
>
> Having an mmu_notifier hook that is conditionally implemented doesn't see=
m overly
> complex, e.g. even if there's a runtime aspect at play, it'd be easy enou=
gh for
> KVM to nullify its mmu_notifier hook during initialization.  The hardest =
part is
> likely going to be figuring out the threshold for how much overhead is to=
o much.

Hi Yu, Sean,

Perhaps I "simplified" this bit of the series a little bit too much.
Being able to opportunistically do aging with KVM (even without
setting the Kconfig) is valuable.

IIUC, we have the following possibilities:
- v4: aging with KVM is done if the new Kconfig is set.
- v3: aging with KVM is always done.
- v2: aging with KVM is done when the architecture reports that it can
probably be done locklessly, set at KVM MMU init time.
- Another possibility?: aging with KVM is only done exactly when it
can be done locklessly (i.e., mmu_notifier_test/clear_young() called
such that it will not grab any locks).

I like the v4 approach because:
1. We can choose whether or not to do aging with KVM no matter what
architecture we're using (without requiring userspace be aware to
disable the feature at runtime with sysfs to avoid regressing
performance if they don't care about proactive reclaim).
2. If we check the new feature bit (0x8) in sysfs, we can know for
sure if aging is meant to be working or not. The selftest changes I
made won't work properly unless there is a way to be sure that aging
is working with KVM.

For look-around at eviction time:
- v4: done if the main mm PTE was young and no MMU notifiers are subscribed=
.
- v2/v3: done if the main mm PTE was young or (the SPTE was young and
the MMU notifier was lockless/fast).

I made this logic change as part of removing batching.

I'd really appreciate guidance on what the correct thing to do is.

In my mind, what would work great is: by default, do aging exactly
when KVM can do it locklessly, and then have a Kconfig to always have
MGLRU to do aging with KVM if a user really cares about proactive
reclaim (when the feature bit is set). The selftest can check the
Kconfig + feature bit to know for sure if aging will be done.

I'm not sure what the exact right thing to do for look-around is.

Thanks for the quick feedback.

