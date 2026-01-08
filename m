Return-Path: <linux-kselftest+bounces-48513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A239ED0393A
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64823251F38
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C14891AF;
	Thu,  8 Jan 2026 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Lr61i3e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBA481FBD
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881416; cv=pass; b=gx6pKDtPMwgYJXZt50R49cT9OeLsjiHfhfvgBy5ph02KJnXbFi6BwSRX0/adg9yElR4gz/STzaxXNxMZdt7eIIUJV/u+Q/K4lBakS9vAlpcXD4MPEevBDYmYBKBoVIVVaW7kF5uAZtc4YJ3EkliAB/l9/1cJMMkrAcQVltiDwNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881416; c=relaxed/simple;
	bh=YkKdPv86ApMrpTeTFnhz+IcSUQLsILOLPvJQz1PDFUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNxuv/lHApG4ghn9yUefO82GgBUpCFplQGgVFdFtJDhBldyxJZwHvyjSzBuEH9CcLFMFx/jm/HAX8jEm1VGLMIcesgAT90vdAuzvE3CgTLR7HieE7fULbbqLU4gRmH7Ia2vFqz5dIyTwKHeZE81lrvfpsqRkAp5jMhlZUYERKDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Lr61i3e; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee243b98caso845821cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 06:10:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767881412; cv=none;
        d=google.com; s=arc-20240605;
        b=X6py3EnW8fJPGCypV7Ut4jAhNDyMu5KZoxQ1THSUJHSxFqYNZr6yJbUmssEzMpXDZf
         K9oi3BPQFOJ6R+/Fg77njHokbWZ1fFndtPBjhwqnXZqr4+ryBfeaZbUQLbu5oii4sV3c
         Pc53/5sieGEfJr5IIhhJujPhwK75t+1s1AcE8mAyGu7lIxQLp3SboufIV0jKx/YemmyG
         6XnO7fYqdlELp1/cq9Ab/vlRr4jYRxp0pG1i9/MsZyLwFU1iYbkuBjjJ3J/m1ZHHQ++S
         yT6QV8uDKQxyus/CbqOPDJd6Btiz3CPwloqRUEF7EJOn50asL/CFZbJYckSvGXUnmmdK
         a8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TGOhyPqsKhZPttb5gff3fg7ZFzXcVrSNwuwgJbbCpXM=;
        fh=orPB/6Ioo1sMc2an8a7DYTixacBYCVfBdYXU4axe6Xs=;
        b=esRHXf6O/05a0QmlbJzt4w2ZYh6IXC3nIzsK35XBF7V+sKAo94fkXF1y/0UShuWeBT
         yhBDfUTKaKiC2ZKr0n9HzEWOH1Ti7sB2iFBUY3DSH0zeoHbUOJLMlfBO2lud/uo2vnLV
         RDK61tZif3DMd2bO/g42fca1+vHxQEnq+kgyFP+UEws0fuEfWOegqQP62pN147u58kst
         IGJ0C2yarMdBCEc9lJV7yGkQwg3W2CUC1D+AY3+l6No6rpt4LuvOSCVMgwJgrETgZOOA
         UurhUZW7fv1GihQbv+NUwq7IOlqKRVgYU4xOQBYGMocz5V7UUUj6IAJLUW2VwGaPb2tk
         +dYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767881411; x=1768486211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TGOhyPqsKhZPttb5gff3fg7ZFzXcVrSNwuwgJbbCpXM=;
        b=1Lr61i3ejjuzjBDwzz9hNjPH8mrKdYOQvs0KRSmaqZBdAwd46owOzQvS79kps4o3Ys
         S8Iyzeu3RqJ9dm16+UozeXBE8pA2m4QhhAQBcT0fEnLoLISmes3zFYmBwJad031yHn1H
         RevwtTlCy64aOddXXsK1Pa4qJnpJ5qyFJozKVS1/tEGVBKm8WACX+RPVw1sSRo7EOgVZ
         D0y3OyxitBZR7zEZR0edoVeRehD+TuF0m4ZUowROoEWRYZGwd7rgkU1/OwfIe5t964lc
         cCjcGh9A6Ed4GuXSIgUMVsWp0ETxYAGvWbnHBYkxNN38+qefiWcIU9QFaLi70Ku85lXH
         GS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881412; x=1768486212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGOhyPqsKhZPttb5gff3fg7ZFzXcVrSNwuwgJbbCpXM=;
        b=Z9lYdEH+zb1/N/rZMnKq0YeIQVNt1wLny/4/r+Zc7a2hu15tiPBPmEGjKRwFTW7yNR
         lGPru1QOs66d1S3f5mYaFtWrQMG2FTdOtWMfUSLO5cLBHX3VQ0l8MmDpVegTV3I/RoMS
         9UbkV8qLUSiqsg3OafhOv4B0hjW19WFbe0UBElQXMhgYosz8vx8SI8NyZc0gjREOkkuu
         XD6WuAKdftVRRLyCPXUCRwS6WMQgVQnoTS67vX2xvLV9k6mCRmrVsYNgKXp+EYfzyE19
         2pFgTBkIrWQAEHXtutmwq9kXWtrgHXITScFYW4JxWXmy9eGMBrQG3VpWy0qn0HBncMRM
         I2CA==
X-Forwarded-Encrypted: i=1; AJvYcCXv24kkvgJ7j8RPjdLQhGtuSzXBNFQdQGtMdy9wGX0iE7rYwmTtFUFfXM9vo8Xi1B5A8VWB7Ny5z55LINY10jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBh12uhX4nMpsy7XQ24L7WayRc+gZKyg2ykA5kew0UKd/4Yy8b
	UhtXLrQSxhb04o02bFRsiS+aPSr29YJTyUJb1bu9lWwrvHSWxvelGmES1D1jS2fpo9BvTIDxGJo
	JSuqZCzu3Y/IjdXZhp3cMx0KMsXscBJJfO8XZKME/
X-Gm-Gg: AY/fxX5lUIu2jdXjGsHy/rd5RtmCgf4tDCrTkBiGbciRN3l5MZ0f4oVMkMO5BEo5geI
	WKOEVEILd7XJip3aq0ynePRRtDN7Q299qqmc7eHi+BXDpqEvNhz6Q9alRaTXbonl0c2TZ6eznjS
	p/Fm9SEKQ/l9tDUz90FXgAiolz7xakgYkkn9hpnDJYL98zvN8yqIlPLPQF84H1Lv3X/Fe1VW9+Q
	kbeALRvUAybsBzeJ8FYcVcPXHl4MsVF5igSKBcGFndNWsEPNfbh48gDqF94UVFf1yVrflRS
X-Received: by 2002:ac8:7d45:0:b0:4f3:7b37:81b with SMTP id
 d75a77b69052e-4ffc0a80347mr7952831cf.18.1767881411175; Thu, 08 Jan 2026
 06:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-2-8be3867cb883@kernel.org> <CA+EHjTxdSnpFHkm6o85EtjQjAWemBfcv9Oq6omWyrrMdkOuuVA@mail.gmail.com>
 <3c8b4a5e-89f4-47e0-9a5d-24399407db0c@sirena.org.uk>
In-Reply-To: <3c8b4a5e-89f4-47e0-9a5d-24399407db0c@sirena.org.uk>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 8 Jan 2026 14:09:34 +0000
X-Gm-Features: AQt7F2rujxIGY5_NcyYbFMLNUJyJwV68zqszeu4LHx3dTWaBmmJ-A6j-sa3_670
Message-ID: <CA+EHjTxLkLjPj=1vwDqROXOUXi2LhOQb90WP6dFaTiYG1nWovA@mail.gmail.com>
Subject: Re: [PATCH v9 02/30] arm64/fpsimd: Update FA64 and ZT0 enables when
 loading SME state
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, 
	Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Jan 2026 at 11:54, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jan 07, 2026 at 07:25:04PM +0000, Fuad Tabba wrote:
> > On Tue, 23 Dec 2025 at 01:21, Mark Brown <broonie@kernel.org> wrote:
>
> > > +#define sme_cond_update_smcr(vl, fa64, zt0, reg)               \
> > > +       do {                                                    \
> > > +               u64 __old = read_sysreg_s((reg));               \
> > > +               u64 __new = vl;                                 \
> > > +               if (fa64)                       \
> > > +                       __new |= SMCR_ELx_FA64;                 \
> > > +               if (zt0)                                        \
> > > +                       __new |= SMCR_ELx_EZT0;                 \
> > > +               if (__old != __new)                             \
> > > +                       write_sysreg_s(__new, (reg));           \
> > > +       } while (0)
> > > +
>
> > Should we cap the VL based on SMCR_ELx_LEN_MASK (as we do in
> > sve_cond_update_zcr_vq())?
>
> Yes, although I fear if we've got to the point where we've ever got a
> bigger value going in we're going to have bigger problems.

Yeah, but I think that we should be consistent with the SVE case, at
the very least, not to confuse the next person (e.g., future me) who
might look at the two and wonder why they are different.

> > Should we also preserve the remaining old bits from SMCR_EL1, i.e.,
> > copy over the bits that aren't
> > SMCR_ELx_LEN_MASK|SMCR_ELx_FA64|SMCR_ELx_EZT0? For now they are RES0,
> > but that could change.
>
> My thinking here is that any new bits are almost certainly going to need
> explicit support (like with the addition of ZT0) and that copying them
> forward without understanding is more likely to lead to a bug like
> exposing state we didn't mean to than clearing them will.

I understand the 'secure by default' intent for enable bits, but I'm
concerned that this implementation changes the current behavior of the
host kernel, which isn't mentioned in the commit message. Previously,
both the feature enablement code (cpu_enable_fa64) and the vector
length setting code (sme_set_vq/write_vl) performed a RMW, preserving
existing bits in SMCR_EL1. This new macro zeroes out any bits not
explicitly tracked here.

In terms of copying them over, if they were set from the beginning,
doesn't that mean that that explicit support was already added?

Cheers,
/fuad

