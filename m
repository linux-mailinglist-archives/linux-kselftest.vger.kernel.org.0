Return-Path: <linux-kselftest+bounces-40008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B385B3747A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E8736180B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7628D850;
	Tue, 26 Aug 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kYNzSa1y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E06F289805
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244319; cv=none; b=JYQs49Vqs6c+BMYbbY3VminOOQE75+3t+RUCAHBvjIQKtfqgQyGRrB8P1dbbqf0AuPmI2TgqwNE0IeqfKjkgThYS9/h1DxkPvlsW2WtoSqgzADrSNBv9wpmZ8tTmhhlgVLQJNZ6gz9+MWD2jAb4hkbEiS0Bb9vhuLl7E2we+b6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244319; c=relaxed/simple;
	bh=tjjntmHYd9yX/bQsKUBCFfyjm57RPvKrOHRwfskNRjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha0EFKjIr/to8l0Cs8HRty2XXj9x/1kRQBKola582AaiYSprRyq+0uwaJH8hWQELhaqySjzwHHhQpbzE253ObQC5TQjo+uLWT5Hyqk/IrQeQNN9jsvaPI/zv17mDDA/7Yb8bt8oTvIrsIhMHs+TtkkmcbKsMVtbx2QDgYDpcbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kYNzSa1y; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b2dc20aebbso150701cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756244317; x=1756849117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89nUNyghQOdbDMTzejcrMWxMjVoZp0QLNZEDRB294gQ=;
        b=kYNzSa1yl5SEOrAw2kMSyJYcMsEqJqtN2FQ+75SCQp0+JkP7QwFI0Ib7rTsIfXT3Ko
         3xJvrJ+d0idnSejODRLcyKroSSKeMIN4wWLsh4j+k+Sp8xpiEyEEyiCLW85VHsMVcNrD
         1v9egOQ/jjN4Ui9Tbz1POJluvCjQYQbcoD5iJJq7kcg2k1oxLNQw/9GArUCge6kEZyLC
         qH3KbliDM+klvSahqKbeqz4THu6rDJg58tJfJRrL++1uZnlKecZWsGkvZnsVEYZ2uNSd
         t71TZ8c1F2yTLqrnuWpdruBjmUbyw4q4Tv6j4LI+BJw3Mes4OF4s5p6hGzgPsFEBBpER
         TvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244317; x=1756849117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89nUNyghQOdbDMTzejcrMWxMjVoZp0QLNZEDRB294gQ=;
        b=TuTVp5sIB0EB8YAeGgBWscHrYa6JohfKRPGoD/hfakOEoH/2cAYBa0/lqaCG3aRejs
         ebFkehWCg+MOT8BiPLnPsSqaVpAAH14G7BcZF8F232cJ5iKizy49IxrrlX0MY1mPUk0v
         MFZT1IDvp/4E5hTDkEjFhQOiZZxrRqsElSoh3ZXH4Zz6xz3x6m8STjQ9FyqZcztter6r
         Y6aezt3yb+20TxcJM4Yer4AG1crCCqS7HC8DSfCJfAfzq53DUwAAkfMFALVQSEAOHMV4
         +SWlUAjEp9BeqYUasOtTRPwT0yjmlrV3bSPM/qpoKXRn/Uiw3ApNED5BJY37EbhN31PY
         FVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvsfRkWoS8OIPQa76W5Uuav62Oha8gEeWTj5zqzbO91wYI0du1BAOiHDxXEOZTpPXwr8HaPi0Ty6vc9g/GjRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwlUBAqwfu6WBLiCQobu9B3Gqyr0HcM25navivuwO0CLwTDgpF
	Lxw07uHmTA5+7Qo3PvtPL+a2xo0AQyVOzStOdZMMTGbSgN9Yb7Mg7IP8Z2ay7BQB9a5Vz3UeoP+
	JcjYkUGhouuucb1fHwfwuAXgcY6WUAwU6ahBa87Tz
X-Gm-Gg: ASbGncvnZcPVtSBsnYiStglRRVRa6b+9k+LA583Y1U4BZ+ylJUllZ/zgJKwyoCqmXPm
	v4nCP+Q6NDO/HGdfKxe3gHvE/ncoEmhBNgglgYKhRq647WuWjJf0HZ6PQWkOykfGsTkZK3VG5BN
	e7YYf628yoWW4tT2Tun240KNlMNsuLKDwJtyoJtWMz9QRygz8f9sC3KDen9bZxvBLOH8feRTBcO
	8G0fQ+9JUr+dKIMb9eLHP3Z7F9HQK3ZkVF4/Yp70n+wY21DQmqJR4X8cA==
X-Google-Smtp-Source: AGHT+IHxeU94g08Uyt0q7MmK7MW0edM6nUge+D9EPJ9mUhKKigCb+AZKXdltlf0UfavBccb1nXT9sGeBu0yaftb6UHI=
X-Received: by 2002:ac8:7d41:0:b0:4b2:d4cb:be58 with SMTP id
 d75a77b69052e-4b2e2c1b598mr6770261cf.9.1756244316909; Tue, 26 Aug 2025
 14:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-16-sagis@google.com>
 <aK3vZ5HuKKeFuuM4@google.com> <68ae1604a387c_300e8f2947e@iweiny-mobl.notmuch>
 <CAAhR5DHPMPOb2XCJodyNMf2RTQfTZpAaCGMg6WeWxSWPLtkO4Q@mail.gmail.com>
 <CAAhR5DGeTQ4G-w2o5YCvNWkZZWFcXe=6rro+RcfhR18-4sT+PQ@mail.gmail.com> <aK4nwZ4FE1r8-GYd@google.com>
In-Reply-To: <aK4nwZ4FE1r8-GYd@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 26 Aug 2025 16:38:25 -0500
X-Gm-Features: Ac12FXx43YYHIALem9VlFRybUWvBdHC-shjMO3WBIHuazSzxmrkHbtA3djEtUZc
Message-ID: <CAAhR5DHLhoY=wz3QQLqjtqhSNewSfFqGk5wonA5TiJwnPmPLsw@mail.gmail.com>
Subject: Re: [PATCH v9 15/19] KVM: selftests: Hook TDX support to vm and vcpu creation
To: Sean Christopherson <seanjc@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:31=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Aug 26, 2025, Sagi Shahar wrote:
> > On Tue, Aug 26, 2025 at 3:29=E2=80=AFPM Sagi Shahar <sagis@google.com> =
wrote:
> > >
> > > On Tue, Aug 26, 2025 at 3:14=E2=80=AFPM Ira Weiny <ira.weiny@intel.co=
m> wrote:
> > > >
> > > > Sean Christopherson wrote:
> > > > > Ugh.  IMO, this is a KVM bug.  Allowing KVM_CREATE_IRQCHIP for a =
TDX VM is simply
> > > > > wrong.  It _can't_ work.  Waiting until KVM_CREATE_VCPU to fail s=
etup is terrible
> > > > > ABI.
> > > > >
> > > > > If we stretch the meaning of ENOTTY a bit and return that when tr=
ying to create
> > > > > a fully in-kernel IRQCHIP for a TDX VM, then the selftests code J=
ust Works thanks
> > > > > to the code below, which handles the scenario where KVM was be bu=
ilt without
> > > >          ^^^^^^^^^^
> > > >
> > > > I'm not following.  Was there supposed to be a patch attached?
> > > >
> > >
> > > I think Sean refers to the original implementation which was out of
> > > the scope for the git diff so it was left out of the patch:
>
> Yep, exactly.
>

I took a stab at updating the KVM ABI and sent out a small patch [1]
to fail KVM_CREATE_IRQCHIP with ENOTTY and the test passes without the
special handling for SPLIT_IRQCHIP for TDX.

[1] https://lore.kernel.org/lkml/20250826213455.2338722-1-sagis@google.com/

> > /*
> >  * Allocate a fully in-kernel IRQ chip by default, but fall back to a
> >  * split model (x86 only) if that fails (KVM x86 allows compiling out
> >  * support for KVM_CREATE_IRQCHIP).
> >  */
> > r =3D __vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL);
> > if (r && errno =3D=3D ENOTTY && kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP))
> >         vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
> > else
> >         TEST_ASSERT_VM_VCPU_IOCTL(!r, KVM_CREATE_IRQCHIP, r, vm);

