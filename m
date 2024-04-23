Return-Path: <linux-kselftest+bounces-8724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE1B8AF718
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 21:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68F31F253C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459613FD8C;
	Tue, 23 Apr 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H91vs80+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45F13F458
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899751; cv=none; b=sD42MgTUbU49mA9L3nd5Hw7U33TrNwtpcHbGFjrxSY6soYh2nOHrSHdgG0ZBMjC4FuYDSjpSxZjnegp4WFSTVYsH4slYOtsebpzaPsmVUearEPvHZhuoElsOS4vAgYE8Q5IsAIxzv+Uli+rLPi2zTN5StmU96LYA1dvqAMXvxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899751; c=relaxed/simple;
	bh=pyZkFd0ABGXFz76xB8ZWfDAQUqX2Kd3JVR9/s4wDQ0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SvKbMwsU+9eZ6KHHrFMkfQjJ29OYcXcHJ2unF1mU6tNhP+DBhQJCEXYLrh27B5DCkptcvw4MDIUd+E9P6Qbw94WPs4gzUCU9ks1ErImuwWYKZ2iAx1eeYcaeXKy9djXOIuiMyQvVeEjmnToSaK+K2wsNvScB7Im4fXHgWfP5KZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H91vs80+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so131173147b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713899749; x=1714504549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tK2a7Yr/IypNmsegnHAW+Bnt+5x2FeODOQAPDg+FlVY=;
        b=H91vs80+0vhLlQRld5mKn0esvXzuo53+damSa4uR9KQk3+XTq7XIfiHK7tixMkn6Nh
         mvTytOiFPvDlordDYdYMFT0xAFTdBvgEqF0xd6mWrg/9+bjFznB5YYT2VULbt494w6mj
         Ln5GDvEqcw8uaYc8edieTZKSlIEXOEEsHD8P3F63tLh0o8S0owdhnEI6cklZGVtXVxkI
         ER+xFbFkzBn+WGCwKYJ6gs3ZOZkmQUrzavGU4zvCGqN6g4sh0eZsRLRoSO9gCN4/p60D
         QDPQwoBjvhrq8vfQhA0NfbEBZ19M5EMGV1BCF8pJIDenLFhZebVXnW7aikXenjIbHI/y
         nYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713899749; x=1714504549;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tK2a7Yr/IypNmsegnHAW+Bnt+5x2FeODOQAPDg+FlVY=;
        b=WmHntFSseQSDwAlB0fB+bJNfDx7bhLRWvWIdKrO2HA50Y4plcE44dlNIlWnoW85++B
         cIoW5E889GkZOVnL/aV9bKYdQBOQJO9z9dhJk9xO/SR5PeVRwuSTS21T+7Y4Ocflu8j0
         t54smge9K2bgWbS95JUsdSFPPADwEYgJE3NTMpbuQC5xRBI2+3oqk4f+r72ECjUb5eNs
         bUZWdXplXZo117FUlDJui88UbrG+0kDsEoUnU8ITdVRyzNCRp5xpQToHCgnKOLUq2pl6
         qBkG8ONKT0eKx1+l7pAU2fnM5VmDKCbAPpR4mksW5IwifGC0gW5ZQo8KBxU4i4yoqBAW
         XUiA==
X-Forwarded-Encrypted: i=1; AJvYcCVc9wawz+pKxbR9a2aEkIuDZXgp+q5XDYJNGLohvztx2vUQ+ZrrKqzHFyvbLGLx6LmiYV1w1ijlEIeHGsgGAvH1+Mz92oEMYR20k9RBDQrW
X-Gm-Message-State: AOJu0YwYv+I09CZQKPy9UXgv5R1XlX3xFwFOC4MoMqaWmUReQjnf24U6
	ZNDOH1UZg0gieGcQoa7RYglOnR/ADPefnXLYnWV+Nrh5btOLxLrZYMr4jF6cka6TD49MRXYOHBZ
	eqg==
X-Google-Smtp-Source: AGHT+IEvSlfNjEiKtO0MizSy6GuLnGVpFnCxv9glIn50ZYKyRHDelAswgazaeeQioA8vby3KBnB39hEe4k8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:52d1:0:b0:61a:d420:3b3e with SMTP id
 g200-20020a8152d1000000b0061ad4203b3emr106057ywb.5.1713899749077; Tue, 23 Apr
 2024 12:15:49 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:15:47 -0700
In-Reply-To: <20240423-0db9024011213dcffe815c5c@orel>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423073952.2001989-1-chentao@kylinos.cn> <878bf83c-cd5b-48d0-8b4e-77223f1806dc@web.de>
 <ZifMAWn32tZBQHs0@google.com> <20240423-0db9024011213dcffe815c5c@orel>
Message-ID: <ZigI48_cI7Twb9gD@google.com>
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in test_vmx_nested_state
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, Kunwu Chan <chentao@kylinos.cn>, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kunwu Chan <kunwu.chan@hotmail.com>, Anup Patel <anup@brainfault.org>, 
	Thomas Huth <thuth@redhat.com>, Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024, Andrew Jones wrote:
> On Tue, Apr 23, 2024 at 07:56:01AM -0700, Sean Christopherson wrote:
> > +others
> >=20
> > On Tue, Apr 23, 2024, Markus Elfring wrote:
> > > =E2=80=A6
> > > > This patch will add the malloc failure checking
> > > =E2=80=A6
> > >=20
> > > * Please use a corresponding imperative wording for the change descri=
ption.
> > >=20
> > > * Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?
> >=20
> > Nah, don't bother with Fixes.  OOM will cause the test to fail regardle=
ss, the
> > fact that it gets an assert instead a NULL pointer deref is nice to hav=
e, but by
> > no means does it fix a bug.
> >=20
> > > > +++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.=
c
> > > > @@ -91,6 +91,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
> > > >  	const int state_sz =3D sizeof(struct kvm_nested_state) + getpages=
ize();
> > > >  	struct kvm_nested_state *state =3D
> > > >  		(struct kvm_nested_state *)malloc(state_sz);
> > > > +	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
> > > =E2=80=A6
> > >=20
> > > Can =E2=80=9Cerrno=E2=80=9D be relevant for the error message constru=
ction?
> >=20
> > Probably not, but there's also no reason to assume ENOMEM.  TEST_ASSERT=
() spits
> > out the actual errno, and we can just say something like "malloc() fail=
ed for
> > blah blah blah". =20
> >=20
> > But rather than keeping playing whack-a-mole, what if we add macros to =
perform
> > allocations and assert on the result?  I have zero interest in chasing =
down all
> > of the "unsafe" allocations, and odds are very good that we'll collecti=
vely fail
> > to enforce checking on new code.
> >=20
> > E.g. something like (obviously won't compile, just for demonstration pu=
rposes)
> >=20
> > #define kvm_malloc(x)
> > ({
> > 	void *__ret;
> >=20
> > 	__ret  =3D malloc(x);
> > 	TEST_ASSERT(__ret, "Failed malloc(" #x ")\n");
> > 	__ret;
> > })
> >=20
> > #define kvm_calloc(x, y)
> > ({
> > 	void *__ret;
> >=20
> > 	__ret  =3D calloc(x, y);
> > 	TEST_ASSERT(__ret, "Failed calloc(" #x ", " #y ")\n");
> > 	__ret;
> > })
>=20
> Sounds good to me, but I'd call them test_malloc, test_calloc, etc. and
> put them in include/test_util.h

Possibly terrible idea: what if we used kmalloc() and kcalloc()?  K is for =
KVM :-)

I like test_* more than kvm_*, but I'm mildly concerned that readers will b=
e
confused by "test", e.g. initially thinking the "test" means it's just "tes=
ting"
if allocation is possible.

The obvious counter-argument is that people might also get tripped by kmall=
oc(),
e.g. thinking that selftests is somehow doing a kernel allocation.

I almost wonder if we should just pick a prefix that's less obviously conne=
cted
to KVM and/or selftests, but unique and short.

Hmm, tmalloc(), i.e t[est]malloc()?  tcalloc() gets a bit close to Google's
TCMalloc[*], but I suspect that any confusion would be entirely limited to
Googlers, and I'll volunteer us to suck it up and deal with it :-)

[*] https://github.com/google/tcmalloc

