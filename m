Return-Path: <linux-kselftest+bounces-48745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 194D5D12D14
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 14:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6875730142CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 13:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837D3596F3;
	Mon, 12 Jan 2026 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhnzU/Oa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFEB3590AB
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224570; cv=pass; b=ScYJcKV4/5cAvDrxmYg0vebzGlC6JZAXuuSgT0vauTEz2x9gmM94SDmhP7M3PFgudwzT7x5gAfbojVAZa6SRpKVNOQKC8PQJTsCTRFB7rxBptCmilFbkLHoOqXRff/Jpbgaf+CGhcNZPqCFol1exM9Y8MJ70Fac7ek+iSGi0kuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224570; c=relaxed/simple;
	bh=nNsvMblRGGki6ohemJFCJRABNbnFZNgKUtyaxPDO2cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdxouPsoCy5JFsQoQ3lKlRfYOM5ZB4Yg9wMCNcxl7UmW9zHjKBAzFrmDbkZLCHqduYXduxmHjgdjO8wUoTdaLTy6Rxti7lNKymQ96exRHJtbmIPyGR0Z2SS/tLvYOEa65bjS15uNWVshavSKpwcVeOpMPmD3l7s9OEX3AMWX9hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XhnzU/Oa; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee147baf7bso825081cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 05:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768224568; cv=none;
        d=google.com; s=arc-20240605;
        b=JUcwcaeWsNWmTB97hm9Dv+6YySlHjlqBELcikRjCLkPz6lq5tRyAjUsxZcOJdIYTTJ
         ItbEHlsqLygPX4MiLJe2Dmz0ZvvgP9MKR0SvQI7ok6+zYdmRi+PuuwrekYpJkmGLcbXP
         jNFdsJlo3Ak2dAgAEH+kU1fcK3doIArElKLb2BI3p7I0C+EgXFquU5GHmWGW/iITh6gm
         8i3x1i3EpsDcNwJUz1e92MWbXtK2ieO/1IOHQ/owxbdLL5+PEfYsS/cyRKOBoCuZvbfo
         05XWRhFuqGE8xhAwzubMb6mkudT/4KJJTqaox1JT2FxrPVxN0C3rQksuW46eIY/c/XPc
         rwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jaGuPXqFXeyZwxS5wActQiEFDVDRQPMhfrfAWEZUdIY=;
        fh=Mx+xzmizAWVOYnawSRVvreT+w7ojauchZfAqPANzc6U=;
        b=AzWaBoXAi+ip9PNLUIdChPO+3YBqUXnAXWeJ58tiegv/85ke1V5hR6mrOMXgLpuKkJ
         OXDYkK3Bu9LDJYO+QOsxDWbOvkcRJilQtFxlXnQB0pl9tAmO+mFEoYa84TX5J84NcxnD
         3tnczf8mT9GBWbm79o0t12yaClE2VyEuDYnlfSLYXDQWDP/O+Ye6WzyLgmqHWzoa+i2Y
         O/dLNu6Yla12Hld7i8vJ+d2oDHk0VGZaRC90FMrCFQlWrdnPHj/NcUKjECTZAAQ+GwOo
         IGF27lFiNCXWK5Gjr5PR7KfrVNXKhI7i2QgUh0g/tC2+dSQH7jq681Mg7d8tsGAbRm13
         0rUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768224568; x=1768829368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jaGuPXqFXeyZwxS5wActQiEFDVDRQPMhfrfAWEZUdIY=;
        b=XhnzU/OazUV0/DISFr0GHJ+waTpgosZSjtk093b+5BKr+7lBd+gd2X1kwkAI7+2uEK
         4ZOI8KqpXTaomRaQ0nXCk8d1EnNL1rKWEl7n9jC733FniDOhDprgoxq7AFs+08/x96Tl
         WlfFcRGgnrZN6z2Q1t5hyYHbMT40TuYrK8i2M0CSSHcWyVrjPUa6adfG19fPvesxNojy
         y9MiuOMv4mIqdmgn1cUgn2eiOhRZTDyNXXU2Ao/qwOSVh2suz3vCb22qoiIEaGfVMtp6
         61CQ2PfyQNXvFtXjsSDzWVQNPLnn1TiQDzzm4CdYPZL1pk2S+UtxjxRWZa/MwcGc6E3D
         QyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768224568; x=1768829368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaGuPXqFXeyZwxS5wActQiEFDVDRQPMhfrfAWEZUdIY=;
        b=MU5oYHn0r6IvqY2f2HWrHECJ1wsf7E9o8jS+mu6qBGp9AKA6dbG5LbhshAKW5MTvPD
         I7ha2Bdkhcgove3TrXw9oLvt5lWWhPB5hlADNC2HgKYkho847XlM62dTPihvFKESnvxv
         fY/LeSmpdaqIOVWfS9YB0supqbPDtBYNwgdY/hNed+LFa1kFlZpomByMdJ/phRhO3GBa
         I+v3nWgJRzmZato3sfZ9KajK3587VpRgl2sOVn7Ue56d2LTS37TjrVzVrCYn0u6KmunF
         FSorUffs2pYnr24DZQPg5r5U/ZfIdDgzBAtqyeL37YeyFbY6DliXZkTiscwJsW+ZhLsr
         nRXw==
X-Forwarded-Encrypted: i=1; AJvYcCXVWm6FRWmmmpN63P0K3mWEMF6a7nGc6guqfOv2qdyA7VndK54jmU2v8KO8yYhM9hSC3o+ZrFdz5AURp1H3OV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAEwg5jR9W/bTVHMzL1ZTfTf2sGe5eEP2Vba6dC82V2WMeNlb
	PUJjNElooBf/UKoNxhj7C5xx0WdpBx5FplaoZA4xHeMTMiq3oJw9TOC9AswTv0Is0h77G8oxQnI
	0RMLr5Kmqm+cm4RQ7Maf+ZAUBNKohHyqFNNEbAZMO
X-Gm-Gg: AY/fxX4yFnl9xgs7sOmNSLiRwrlSl0edndc8+S3Kci7KFQbAjxprJs5xEuE5L+SB3wO
	qOLRURSyxfDPwwbDVx9+1zZN7N5s0CqGRmNPHyAKDvG/i9n+e7j/ipNBQAe1+jyCVrsOsolDBB9
	sgX74Y6FL8yre60gn+E+M4nyQw/3PcZiCJqftPTSN0w5bH1Lgi6HyyZ6PxDz/8lXADa5wpfxV/d
	PXNeuN6ql/mUltZhfBZe07pP3/p0TglR4yeuWeB3gEetLsHUvTeaVKOn0gV9wm+Bip31Iu8
X-Received: by 2002:ac8:5891:0:b0:4ff:bfdd:3f46 with SMTP id
 d75a77b69052e-5011979b086mr18062621cf.15.1768224567393; Mon, 12 Jan 2026
 05:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-14-8be3867cb883@kernel.org> <CA+EHjTw-6-BFcr60+tgDzOE-OfcetD7yQtbNMkqr7BgiMXfeJA@mail.gmail.com>
 <96efc90e-bf1f-4b87-ab7b-0e24970eb967@sirena.org.uk>
In-Reply-To: <96efc90e-bf1f-4b87-ab7b-0e24970eb967@sirena.org.uk>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 12 Jan 2026 13:28:51 +0000
X-Gm-Features: AZwV_Qhr0cnxEyY0NvApe2jyI_fTASUjPe1TmX1ATOL61XV_IRaHe4gUVPwKxys
Message-ID: <CA+EHjTxQUADWmCbSgUiFcXz_BxDPLE+THHnF6Mwx73hnhc7OJw@mail.gmail.com>
Subject: Re: [PATCH v9 14/30] KVM: arm64: Implement SME vector length configuration
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

On Mon, 12 Jan 2026 at 13:27, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jan 09, 2026 at 03:59:00PM +0000, Fuad Tabba wrote:
> > On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:
>
> > > +
> > > +#define vcpu_cur_sve_vl(vcpu) (vcpu_in_streaming_mode(vcpu) ? \
> > > +                              vcpu_sme_max_vl(vcpu) : vcpu_sve_max_vl(vcpu))
>
> > nit: This isn't really the current VL, but the current max VL. That
> > said, I don't think 'cur_max` is a better name. Maybe a comment or
> > something?
>
> It is the current VL for the hypervisor and what we present to
> userspace, EL1 can reduce the VL that it sees to something lower if the
> hardware supports that but as far as the hypervisor is concerned the VL
> is always whatever is configured at EL2.  We can obviously infer what
> the guest is doing internally but we never really interact with it.  The
> existing code doesn't really have a concept of current VL since with SVE
> only the hypervisor set VL is always the SVE VL, it often refers to the
> maximum VL when it means the VL the hypervisor works with.
>
> > > +       if (WARN_ON(vcpu->arch.sve_state || vcpu->arch.sme_state))
> > > +               return -EINVAL;
> > > +
>
> > Can this ever happen? kvm_arm_vcpu_vec_finalized() is checked above,
> > and vcpu->arch.{sve,sme}_state are only assigned in
> > kvm_vcpu_finalize_vec() immediately before setting the finalized flag.
>
> I don't expect it to, hence why it's a WARN_ON.

I understand. My point is, by code inspection we can demonstrate that
this isn't needed.

Cheers,
/fuad

