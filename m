Return-Path: <linux-kselftest+bounces-18272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D08983F53
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDCE282D46
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE601494DB;
	Tue, 24 Sep 2024 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2F2xhpmz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6E148316
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163517; cv=none; b=YS1CBpRPQmd187V2v7/fyicCElvza5Dvx7r9btOWMCmW2m5fa5JIIGabWUHs7m35TcZQW5X7efzff18RFausUTL3yGAPZ4P0+arK5EFOOcQBjZfOXBG1tfpyoJdGfjJQGQG4i+xOo0Jo6Tr/8gjP54WFkcVtpICkfBn7ZEQAUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163517; c=relaxed/simple;
	bh=MDgohN12nsf9M2mRFuJEw+fa/KxZISPlzEO6ManVUSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WbbhXqgk362VgH78XgPWDrRBzaO95ums84yBdHHints+m9/YpZk1806jzsSvlCP9qCQbHyeC4L4UtVD61MKqaMIiAb0oIU+K5dYIxYy1pbyptg/tYjvcKq8ddEgLLP3SbOne7OD7ygkgSf2PqZQEgsPRvVoTOvDqSeLrz6HavAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2F2xhpmz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718d873b1e8so7254435b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727163516; x=1727768316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZkYWJqNf6eoiBM6WqGlfzoIuo2kVyjLaKv1M7ETX4c=;
        b=2F2xhpmzxYNgUcnhbQ9PTCZaxurWsu0umOflsfFz74AbdO5sDj/KY1SKzHcHBIazlr
         orfjRUrn7AlklQLN98ybwVisBwAfu7uAtgxIREmHdrLvHadkq46bgYQSV1dxogb62hwq
         bzIsqxt1RP04bcOwhRk7Tgstp1FXdpFKZK3NrtVCKVlhQlILhBhfWPpr7XAOEbKsZZGS
         taw08TmnTK2+UQZxwGTn5Xl31EzZvUY+5lfHUd6ex/JIAXOCTk0jzFL053l97FgbdXLh
         nUJigFDo95DEMOyOtnfqG9AkYjMYfE5INpFUBMeDD4e/f6g++dnGX9wSZOn/VkcovRkN
         p9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163516; x=1727768316;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ZkYWJqNf6eoiBM6WqGlfzoIuo2kVyjLaKv1M7ETX4c=;
        b=U8gDd4Oy1f+UIL8CMjMOs1iTGZpBnGYiFxE5uTOnuuTlmls24d/OMf787xYd7FaoGL
         x+7eQH/Jwf8tTBIC2Yu5vUlLwwzCNmK/fPGKiwRn8xxYPStaVEuAZCw4ORCuTZE6REdR
         U3GdOtHoPkiejzb1W2180TXvhJuL6UupzZNiDEZnNGpciiNFspwZlk5+Yo7HKhirTx9V
         PtfhcQo2oXfHHmmtcpkk06z7mS39Soq22QISTsAjXoDpChmnDY23g/G5kYVwrlW3lc3d
         MGhSTmt9Pz+9mkkGi22eHKQuIbL5u6sznOp+xM7E+oZMU/pdtWoUxqdPIcXv/12+mKD3
         rY0A==
X-Forwarded-Encrypted: i=1; AJvYcCWwHRdxLPJnyL67Sig/rrHA+rKwONudnMSuKPC49TKX87kNV4rIZzJerIoRj6FxHuOlLBqVlW1L2hBzivDRHzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+Neky3gpTUtTMS82BimeAqreeeP9Rp7/lT5WPb/n/YdlHckh
	Fw0a4rv8xAd+kFwvNu1p80h7LM9EkuvFQShKCPwJfqUEcyXX1I1GwFXGG6CYx1mptMI9UoLejLi
	jmQ==
X-Google-Smtp-Source: AGHT+IGqaVfCjWT7w9L72pzk8ZvtxcHt2q2D2SKW8JkbXsTB6bk6jQAflozKkKgLgVrGHRgS43NAgT8SMao=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:66d1:b0:717:8e0f:3e5c with SMTP id
 d2e1a72fcca58-7199caac6b7mr20285b3a.5.1727163515356; Tue, 24 Sep 2024
 00:38:35 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:38:33 -0700
In-Reply-To: <cb06b33acdad04bef8c9541b4247a36f51cf2d36.camel@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923141810.76331-1-iorlov@amazon.com> <ZvGfnARMqZS0mkg-@google.com>
 <cb06b33acdad04bef8c9541b4247a36f51cf2d36.camel@amazon.co.uk>
Message-ID: <ZvJseVoT7gN_GBG3@google.com>
Subject: Re: [PATCH 0/4] Process some MMIO-related errors without KVM exit
From: Sean Christopherson <seanjc@google.com>
To: Jack Allister <jalliste@amazon.co.uk>
Cc: Ivan Orlov <iorlov@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024, Jack Allister wrote:
> On Mon, 2024-09-23 at 10:04 -0700, Sean Christopherson wrote:
> >=20
> > On Mon, Sep 23, 2024, Ivan Orlov wrote:
> > > Currently, KVM may return a variety of internal errors to VMM when
> > > accessing MMIO, and some of them could be gracefully handled on the
> > > KVM
> > > level instead. Moreover, some of the MMIO-related errors are
> > > handled
> > > differently in VMX in comparison with SVM, which produces certain
> > > inconsistency and should be fixed. This patch series introduces
> > > KVM-level handling for the following situations:
> > >=20
> > > 1) Guest is accessing MMIO during event delivery: triple fault
> > > instead
> > > of internal error on VMX and infinite loop on SVM
> > >=20
> > > 2) Guest fetches an instruction from MMIO: inject #UD and resume
> > > guest
> > > execution without internal error
> >=20
> > No.=C2=A0 This is not architectural behavior.=C2=A0 It's not even remot=
ely close to
> > architectural behavior.=C2=A0 KVM's behavior isn't great, but making up=
 _guest
> > visible_ behavior is not going to happen.
>=20
> Is this a no to the whole series or from the cover letter?=C2=A0

The whole series.

> For patch 1 we have observed that if a guest has incorrectly set it's
> IDT base to point inside=C2=A0of an MMIO region it will result in a tripl=
e
> fault (bare metal Cascake Lake Intel).

The triple fault occurs because the MMIO read returns garbage, e.g. because=
 it
gets back master abort semantics.

> Yes a sane operating system is not really going to be doing setting it's =
IDT
> or GDT base to point into an MMIO region, but we've seen occurrences.

Sure, but that doesn't make it architecturally correct to synthesize arbitr=
ary
faults.

> Normally when other external things have gone horribly wrong.
>=20
> Ivan can clarify as to what's been seen on AMD platforms regarding the
> infinite loop for patch one.

So it sounds like what you really want to do is not put the vCPU into an in=
finite
loop.  Have you tried kvm/next or kvm-x86/next, which has fixes for infinit=
e
loops on TDP faults?  Specifically, these commits:

  98a69b96caca3e07aff57ca91fd7cc3a3853871a KVM: x86/mmu: WARN on MMIO cache=
 hit when emulating write-protected gfn
  d859b16161c81ee929b7b02a85227b8e3250bc97 KVM: x86/mmu: Detect if unprotec=
t will do anything based on invalid_list
  6b3dcabc10911711eba15816d808e2a18f130406 KVM: x86/mmu: Subsume kvm_mmu_un=
protect_page() into the and_retry() version
  2876624e1adcd9a3a3ffa8c4fe3bf8dbba969d95 KVM: x86: Rename reexecute_instr=
uction()=3D>kvm_unprotect_and_retry_on_failure()
  4df685664bed04794ad72b58d8af1fa4fcc60261 KVM: x86: Update retry protectio=
n fields when forcing retry on emulation failure
  dabc4ff70c35756bc107bc5d035d0f0746396a9a KVM: x86: Apply retry protection=
 to "unprotect on failure" path
  19ab2c8be070160be70a88027b3b93106fef7b89 KVM: x86: Check EMULTYPE_WRITE_P=
F_TO_SP before unprotecting gfn
  620525739521376a65a690df899e1596d56791f8 KVM: x86: Remove manual pfn look=
up when retrying #PF after failed emulation
  b299c273c06f005976cdc1b9e9299d492527607e KVM: x86/mmu: Move event re-inje=
ction unprotect+retry into common path
  29e495bdf847ac6ad0e0d03e5db39a3ed9f12858 KVM: x86/mmu: Always walk guest =
PTEs with WRITE access when unprotecting
  b7e948898e772ac900950c0dac4ca90e905cd0c0 KVM: x86/mmu: Don't try to unpro=
tect an INVALID_GPA
  2df354e37c1398a85bb43cbbf1f913eb3f91d035 KVM: x86: Fold retry_instruction=
() into x86_emulate_instruction()
  41e6e367d576ce1801dc5c2b106e14cde35e3c80 KVM: x86: Move EMULTYPE_ALLOW_RE=
TRY_PF to x86_emulate_instruction()
  dfaae8447c53819749cf3ba10ce24d3c609752e3 KVM: x86/mmu: Try "unprotect for=
 retry" iff there are indirect SPs
  01dd4d319207c4cfd51a1c9a1812909e944d8c86 KVM: x86/mmu: Apply retry protec=
tion to "fast nTDP unprotect" path
  9c19129e535bfff85bdfcb5a804e19e5aae935b2 KVM: x86: Store gpa as gpa_t, no=
t unsigned long, when unprotecting for retry
  019f3f84a40c88b68ca4d455306b92c20733e784 KVM: x86: Get RIP from vCPU stat=
e when storing it to last_retry_eip
  c1edcc41c3603c65f34000ae031a20971f4e56f9 KVM: x86: Retry to-be-emulated i=
nsn in "slow" unprotect path iff sp is zapped
  2fb2b7877b3a4cac4de070ef92437b38f13559b0 KVM: x86/mmu: Skip emulation on =
page fault iff 1+ SPs were unprotected
  989a84c93f592e6b288fb3b96d2eeec827d75bef KVM: x86/mmu: Trigger unprotect =
logic only on write-protection page faults
  4ececec19a0914873634ad69bbaca5557c33e855 KVM: x86/mmu: Replace PFERR_NEST=
ED_GUEST_PAGE with a more descriptive helper

> This was also tested on bare metal hardware. Injection of the #UD within
> patch 2 may be debatable but I believe Ivan has some more data from
> experiments backing this up.

Heh, it's not debatable.  Fetching from MMIO is perfectly legal.  Again, an=
y #UD
you see on bare metal is all but guaranteed to be due to fetching garbage.

