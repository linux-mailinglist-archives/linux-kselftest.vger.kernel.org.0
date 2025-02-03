Return-Path: <linux-kselftest+bounces-25602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796BAA264A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 21:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AACCB7A3FB5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952020E32F;
	Mon,  3 Feb 2025 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f4RxBxKj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC720CCEB
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738614954; cv=none; b=YuR1VWHsea2MF440adRH/jWZEfyQILS+yENYJa/L9EMuA+ckHHJHN+hww/r5vgIrh0RV6NxI3yY0kxFXAPiJhigAE8zKC0YSK69pc2s4RPKUTWAY6uSuyER9O+zKrf2IoS0m8uySBx02dxZXHKxiGNY7ah6K9llT2jkRv1TNUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738614954; c=relaxed/simple;
	bh=iHOgsgbTLasT+mAbTKI3kNcpK3vJNjZYaHQEoQJJPkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H24K0Oa4GaDgO6WzDkZ5naUx2tvSCN3w90MHGBjmJn7lkjqE8VejICUa7iFnuh9MKRmuOGp8evA5sOrwmVJLYiXxkbr+FknehrRdXuUrYDUMSvMqzJzriLm1acD60iy3CTL9S9g+2Oic4b4Mu9V22XhHh5JTmktSjs9wN5cxsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f4RxBxKj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaec111762bso450655366b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738614950; x=1739219750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7Ns3FLfIAZYGDFkK3fA+Vs5Q3I4AHQ7nr4KJPOKX0U=;
        b=f4RxBxKjDTdDjBsIYLtm5ozeuzWueyoa/Rj8pjPgVkKjSJoTXu68kEtwUnPwHifA/h
         NXZeBuQZcby81GQC0VeHQe9Ed0n0qTX2A6qxudxe4rqveZc/05092q+Bv2SxJW22K4gI
         uiSzwjlxjoKNwl4paBJTen2GJiOpL1O+479Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738614950; x=1739219750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7Ns3FLfIAZYGDFkK3fA+Vs5Q3I4AHQ7nr4KJPOKX0U=;
        b=p/PwUjNw4hA3TUnCwZLPjIWbwmVLaPoUuq68c41u1lB+BH31gs6xfVspAWdiy9Dp+q
         ZI6d4L68zAkx9kiQ8gkxD8zWLjoA7dxK4YLiLAsCTxgZk5OHzbWX9V9z4whJOdt0drS0
         TYadD/GrGjU9O6NoFKiQcU8nN4SMXdmuY9wFJJPiEknQFD3qhniYY1ekii+JVbpiCjdz
         y1HEiVczmz754lg92TdAOPSNiK3AbBENjTiqWF+/i9Quz9OfHkgchOAtDESCJ96C3tid
         DATB6QuelR2JqYTfq3NvUJf5PE7jJR3feKTvqFnyOBQFM38ipr3GMX8yN69tn5BuCMRn
         Tivg==
X-Forwarded-Encrypted: i=1; AJvYcCW+NBK3GIQwSvTYinott5skCi8q4L1ddrUhhtlBu7dqwwVi32V8PywRczz311LUvaACG4wfmKDXu/QWmjxVU6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZ5PIqZ561relT91GdybtbSTmjiP49B0uQNo1J//dW+7i0u3W
	2I65L+9Qe/JzC7yj7JDvb+V3vB37D5w4w8Ba6RkvmmT22XwSvHDl0VwsO4adk3lOyob8lUhydbd
	RsvbHOnOUDIVR4ry//fpqDmlafKTCDGcV0b9yLQF7OPbDjLIEQxUJcCtAXKIoD4ftk6OpTx8/7d
	lVNMwaiA8SDilEU0AaYk+gD1MKoPfMxg==
X-Gm-Gg: ASbGncvZUZjyCyiP0g7IdzgWdvxSCPjfwwrMA2L6HT/GX/wzUf+YYFXkBJCqyasgr4u
	AzxgWkk4it7VKhBrsSZuKBN92GzdDhhLqXyWaGPmtsiGc6shm1/b5jdJS3nMTBn3eRsTmCjfD
X-Google-Smtp-Source: AGHT+IF5AWWdY4qYzAwQdbOtXfgV9YAbUE+7qvDb3Uh4Avo5Mcb4wzOObn3yCi/awJ7s1audhmtBacpaZff4AJ/3R0o=
X-Received: by 2002:a17:907:9691:b0:ab6:dbd2:df78 with SMTP id
 a640c23a62f3a-ab6dbd2e39dmr2560575466b.35.1738614950459; Mon, 03 Feb 2025
 12:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b1ddb439-9e28-4a58-ba86-0395bfc081e0@redhat.com>
 <CADH9ctCFYtNfhn3SSp2jp0fzxu6s_X1A+wBNnzvHZVb8qXPk=g@mail.gmail.com>
 <CADH9ctB0YSYqC_Vj2nP20vMO_gN--KsqOBOu8sfHDrkZJV6pmw@mail.gmail.com>
 <Z2IXvsM0olS5GvbR@google.com> <CABgObfadZZ5sXYB0xR5OcLDw_eVUmXTOTFSWkVpkgiCJmNnFRQ@mail.gmail.com>
 <CADH9ctAGt_VriKA7Ch1L9U+xud-6M54GzaPOM_2sSA780TpAYw@mail.gmail.com>
 <CABgObfb3Ttfg6H+_RpNQGSYKw9BLEwx3+EysXdL-wbpd1pkGHQ@mail.gmail.com>
 <CADH9ctAzffvDByS1s2PJoD63On-b+pCnCmER4Nf4Zc=62vkbMA@mail.gmail.com>
 <Z6Eb4PfmmHWFTR9A@google.com> <93df442c-8ec3-43ee-aba1-e770a5b7588f@redhat.com>
 <Z6EeyaOZUevXDBiH@google.com>
In-Reply-To: <Z6EeyaOZUevXDBiH@google.com>
From: Doug Covelli <doug.covelli@broadcom.com>
Date: Mon, 3 Feb 2025 15:35:20 -0500
X-Gm-Features: AWEUYZnthUXQ_pnDcokMXb4-W_1h4l_OREU8d1T2--Q60_3QnZjpsz7kj6ouJEQ
Message-ID: <CADH9ctC0=YWJ1S-WVWhasjS+DHSWpzqQ0bbgz6N2vGHAcBrgRg@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zack Rusin <zack.rusin@broadcom.com>, 
	kvm <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 2:53=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Feb 03, 2025, Paolo Bonzini wrote:
> > On 2/3/25 20:41, Sean Christopherson wrote:
> > > -EFAULT isn't the problem, KVM not being able to return useful inform=
ation in
> > > all situations is the issue.
> >
> > Yes, that's why I don't want it to be an automatically opted-in API.  I=
f
> > incremental improvements are possible, it may be useful to allow intere=
sted
> > userspace to enable it early.  For example...
> >
> > > Specifically, "guest" accesses that are emulated
> > > by KVM are problematic, because the -EFAULT from e.g. __kvm_write_gue=
st_page()
> > > is disconnected from the code that actually kicks out to userspace.  =
In that
> > > case, userspace will get KVM_EXIT_MMIO, not -EFAULT.  There are more =
problems
> > > beyond KVM_EXIT_MMIO vs. -EFAULT, e.g. instructions that perform mult=
iple memory
> > > accesses,
> >
> > those are obviously synchronous and I expect VMware to handle them alre=
ady.
> >
> > That said my preferred solution to just use userfaultfd, which is
> > synchronous by definition.
>
> Oh, right, userfaultfd would be far better than piggybacking write-tracki=
ng.

Thanks.  We will look into using userfaultfd.

Doug

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

