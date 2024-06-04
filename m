Return-Path: <linux-kselftest+bounces-11156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1218FA6F1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 02:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCA02874BE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357C04A04;
	Tue,  4 Jun 2024 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1m8ckvv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872410F1
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717460590; cv=none; b=AT81JCxgPeXIz/tqzPpZFfvNbdtCdct7BHf0rwHYGEUYqvwjUMvHm+zrYMDEei/6aPrZhOAijChlc2viDKUJtAhnjt0x4Mi8wohLTG7tOF644y0WkIQFLElLIS98dygO06s6i96huaRgtVK+G7RbYbBoWK9kNaJT4p7jvFT8AV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717460590; c=relaxed/simple;
	bh=ouvtVl7K0PAyNCf/CqS8kHiqugncCwG8s3P79l84eTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PYSuFlcShJydTgXpDwo8K4p4mFqMIuCNhNjlZigardY0dOudge8rC4engaM9PI6BtAgnSR3kMir39wbJEuuj51W00JKs/xWmuFD/7mq+NjvpZZcVUK2ctlVET+bLjMbOSfmzL0p9fOk1z0zZIq9Yd8DaW5GExCanYDByTs1lolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1m8ckvv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df77196089eso7608210276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2024 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717460588; x=1718065388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRuXM8qP8LdDvX6fn1r8scesSI9q9pU2JyFDr4cXXhA=;
        b=c1m8ckvvboOwe3KrhHvNr9scMkhS5hbZHC4OO/9AxaPB6cCwQnHZkr1ZxTFGKbGpkm
         U21tzIPxW2xS0YzG453o80rah9rxwfBOjzEmsykJnWgK1SAIOVPBUwK0zkGXDxnLvj9Y
         AW52RCSShShES3RR2ozc8dVWoh4Rol47IrwsXyYIjm9WoimEaT/lmnet4RIuodPntggB
         plcafDYVXkQZKOa2/m+6wAbjOL8xRJ4yw2rmCGeDmLiOFT4aRZX2dRsU0hNekfENabM1
         QUUPAvur26jvp92Z4K1CWzFxCO3JvEs1jfPGBZr3MkUhu/xkSfVGyyCe838x5bftgUlq
         UPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717460588; x=1718065388;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HRuXM8qP8LdDvX6fn1r8scesSI9q9pU2JyFDr4cXXhA=;
        b=PkP6Q+j6AQbbAUwT+PsBpplJVZLw+iFxTU0jnZCDZJ3Mnppag6Xji+G0iP8Ca8QKHB
         +lH9FHSEIR78WXbXPuD8JvqIeYsuRu7Oo4I20jMYCmkGZH1EWAyGUA+VOP3WAZWpCguH
         mFWmtI4b7iGaAJAP+fb6RJ3V9aYtAS1aewlijr3O/FCRZhJAr5BPO00WFKqgEGgNCPpT
         Ew0R6KxfCGRhCU8p2mYYXQsCL2lhoyY8Zf5slSxCiUW7KpNty5PpdaS7LLcmnuvOCOAR
         969OvAoUdsi21EzacQlBYupDUp0V7a4IkVqJMDkPpNoQqAOLcayox+3V73Yn81d/GMBd
         orew==
X-Forwarded-Encrypted: i=1; AJvYcCW/dS+Zd+hG6DpqG7tcqRCMdT63uyZXmy6gtoPyRJW5u61UsHOE8X6Wftdz8SuPTRJ4i3mopPnOCZVkZrGFCsm+sReV3R5I9zpJU3TgnI/+
X-Gm-Message-State: AOJu0YxVMlHBqgec9wrGimJ1LO8sbxWzBoyFTTt+WLegEgbCwIUmA2t7
	z4yn4p3Dm3CP1vnAkE4D2fbAtHIJVF85KSsNOOiBEPQwlApH3fAZU8sWOJwT/LXmN88yutmqnnN
	cUA==
X-Google-Smtp-Source: AGHT+IEk24C6d/QoiBbCyIExMW7OdPZLjaBEK4ZPTTj/IX3O1NfqjnOFuoealUEhXp84xV+hhBOGjvPTh7s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:707:b0:dfa:ba40:6f43 with SMTP id
 3f1490d57ef6-dfaba407295mr112473276.2.1717460587664; Mon, 03 Jun 2024
 17:23:07 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:23:06 -0700
In-Reply-To: <CADrL8HU734C_OQhzszWJWMXEXLN6HkBo4yweN2fX4BbOegXrFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240529180510.2295118-3-jthoughton@google.com>
 <CAOUHufYFHKLwt1PWp2uS6g174GZYRZURWJAmdUWs5eaKmhEeyQ@mail.gmail.com>
 <ZlelW93_T6P-ZuSZ@google.com> <CAOUHufZdEpY6ra73SMHA33DegKxKaUM=Os7A7aDBFND6NkbUmQ@mail.gmail.com>
 <Zley-u_dOlZ-S-a6@google.com> <CADrL8HXHWg_MkApYQTngzmN21NEGNWC6KzJDw_Lm63JHJkR=5A@mail.gmail.com>
 <CAOUHufZq6DwpStzHtjG+TOiHaQ6FFbkTfHMCe8Yy0n_M9MKdqw@mail.gmail.com>
 <CADrL8HW44Hx_Ejx_6+FVKt1V17PdgT6rw+sNtKzumqc9UCVDfA@mail.gmail.com>
 <Zl5LqcusZ88QOGQY@google.com> <CADrL8HU734C_OQhzszWJWMXEXLN6HkBo4yweN2fX4BbOegXrFA@mail.gmail.com>
Message-ID: <Zl5eat0sh7rrspUG@google.com>
Subject: Re: [PATCH v4 2/7] mm: multi-gen LRU: Have secondary MMUs participate
 in aging
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024, James Houghton wrote:
> On Mon, Jun 3, 2024 at 4:03=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > But before we do that, I think we need to perform due dilegence (or pro=
vide data)
> > showing that having KVM take mmu_lock for write in the "fast only" API =
provides
> > better total behavior.  I.e. that the additional accuracy is indeed wor=
th the cost.
>=20
> That sounds good to me. I'll drop the Kconfig. I'm not really sure
> what to do about the self-test, but that's not really all that
> important.

Enable it only on architectures+setups that are guaranteed to implement the
fast-only API?  E.g. on x86, it darn well better be active if the TDP MMU i=
s
enabled.  If the test fails because that doesn't hold true, then we _want_ =
the
failure.

