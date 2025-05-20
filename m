Return-Path: <linux-kselftest+bounces-33440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89922ABE822
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B4D8A1476
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8897B25B69E;
	Tue, 20 May 2025 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phYVTxvS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99B256C7D
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784356; cv=none; b=Qwa6dWkj8qNi8LxheTZtcjXtzLHdfEYxAQobvStDP9dDoV025fJB8SaiFiE2G/tz3DlRELcN9VEWtE4frAfxMriN7WuTjJm5BPcRmiBAEUwnPwsqrJ7tTUihryligNjidi2bzvH8tP9GXq2ksNjc3juBLlGLOx8H+HDABht4y4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784356; c=relaxed/simple;
	bh=qNW0arWXlRmhF4tOVFZz0ZKha2LDMSjtrVhlYdBNed8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTioAKS+E8Kk4K2HLfoLaGA5mfOiP2GILl2h8YcHtRre9HvKkxLb0AjkMbxbFS14DN1kbP1Wez8NMVsWf8bcT4CzPhocXmdbm4JvMvz9jcUqvA1LtdDbOcro9sI2t3CjV4UbalvKuMxD2MHQ20WFIOn05Na4W8JpOBTAuuD4j8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phYVTxvS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442f97af707so193335e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747784352; x=1748389152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRuU/m5dc5FtJi/f3Rrw2anhfRohi0i8yf3iq1OlqJ0=;
        b=phYVTxvSAmpqz/M4n0Rk87yvA4M6W32UAkrZOlT+psyUIysRvKkFuoqSDcX7S/opnV
         KL1GpAF6jpi8WvDGCdm6/uPZxx04PV/Ec/eimFSmmQcEzU6QlJxack6+QC0ZKphw0QNU
         icmO0QZFLgXcvOmizZm0nzwJsg/F+tqJIMNq/yOLB83J6WD9Updphm1gva09AyIA6iq7
         JqZLYj4gII8JO+I/V5Oo0z8XvJJ94Vatwwg9cOVD6VB9kW2jaixtyNHNVR+l6Ejc1/iY
         tzpeGbsD9iIixVs7zVpE11lv45+lShP3mgpinP4pnyN2SFXJnc5rbdRAF2Ql2Chd/18E
         vwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747784352; x=1748389152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRuU/m5dc5FtJi/f3Rrw2anhfRohi0i8yf3iq1OlqJ0=;
        b=pZhuMpW6lfcA1bU5xfZL5B8igApgf1HGL9d3fezIZMvZrUG7PdYVLY7AbdW1wjkjBQ
         xaj/3becuofDLQRjJzl8UV0P7qb0VWTZFB93NzARlvPWKod/qGYBzmUjRPh9vKprQLnz
         /ov0+nINsViZvppena2ZTt8kr9VPY7v9/KiYk8kGr/y4d4E1sswn7MMgSbZDAOGU7c+6
         M+gvWpi9JFN3MhzCfizwGhWBvqK9BP4e7KknpPoOEzBAD66WwLice8Aeqae1VNDKwdz+
         GO+IbJJOwUgKRNM5hfDc7nljw4WCEIeBzZhJn5839O71p4w57ZHxZzwXhjR1fzg+Y9jP
         VC6g==
X-Forwarded-Encrypted: i=1; AJvYcCXIhQ1Qe1ZHsUDUpHyRRRP6+0rCXfCwhkVHZgNXUuJh9pF53VRaJ6dCaBN/pHZfr/d9H6dwYjKf99g/ZPSoBeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf5jsRm4fvI7Nfo7rBD8b6W6O6rl2NrC+LBll2B1sfCVYN+fHN
	6FQuYOy5cu3tpB+xNQtONy2Bxp1njpmT213EEbJxg9PRNDRELYuPdh1MZE+xe9kxyeR9X1D7qbM
	KCZ5lm6ApQEW5uhvADgepLux9ZaluNVUHn8A+pgdK
X-Gm-Gg: ASbGncuBGc1xf9FRpOMRrkLMkAhckAwe8ePCL2Nnh+IPtX0+6sKrk1sw0jolEyh1hSd
	CUmI9H5xfjRIoKddgSKv9XXTL8lkUbH0+z/dKiVXyx9ZNjqppEdu+X7GkJh89gcTPQRSB7pbbAb
	7Zo9qlNI/DSKuFamcPDUhnQbfAgVDle3UIvQILyLuxPV77ApSO3pC28WRh5uzr2VFRvLs63bn8
X-Google-Smtp-Source: AGHT+IEmTo+oS9URXfIuKouUY0B0Y62o5TMKaVmZC8slqtUcsFC1AZMBLwucs8WQvvTTsv5lG6xeERtZDgSchwhBuX8=
X-Received: by 2002:a05:600c:2e49:b0:439:961d:fc7d with SMTP id
 5b1f17b1804b1-443ae3dbdfdmr4250875e9.6.1747784352208; Tue, 20 May 2025
 16:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505161412.1926643-1-jiaqiyan@google.com> <20250505161412.1926643-3-jiaqiyan@google.com>
 <86zffcefk9.wl-maz@kernel.org>
In-Reply-To: <86zffcefk9.wl-maz@kernel.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 20 May 2025 16:39:00 -0700
X-Gm-Features: AX0GCFtfiDim2rVM9--MtRE7iY2zI_cJEhnOXz73-OdjqCpU57FjKEAM9M0zDCo
Message-ID: <CACw3F52v_WSR=HkmeW7be+YRFkUzA-n-=mVHHw4wvJK7ongkYQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] KVM: arm64: Set FnV for VCPU when FAR_EL2 is invalid
To: Marc Zyngier <maz@kernel.org>
Cc: oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 8:33=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Mon, 05 May 2025 17:14:08 +0100,
> Jiaqi Yan <jiaqiyan@google.com> wrote:
> >
> > Certain microarchitectures (e.g. Neoverse V2) do not keep track of
> > the faulting address for a memory load that consumes poisoned data
> > and results in a synchronous external abort (SEA). This means the
> > faulting guest physical address is unavailable when KVM handles such

Actually this is not relevant to the code, I think it is just
sufficient to say "This means that FAR_EL2 holds a garbage value and
therefore kvm_vcpu_get_hfar holds a garbage value too".

> > SEA in EL2, and FAR_EL2 just holds a garbage value.
>
> I don't understand. FAR_ELx holds a *virtual* address, and never a
> physical address (that'd be PFAR_ELx).

Sorry my writing is misleading. If you are still interested, the
scenario I meant to describe is
1. There is a SEA taken by KVM when memory load from the guest
consumes poisoned data.
2. The guest physical address (or IPA) of the poisoned data will not
be available in HPFAR_EL2 per architecture register documentation [1].
3. Although HPFAR_EL2 is unusable, KVM can still attempt address
translation with the guest virtual address in FAR_EL2 to get the
poisoned IPA.
4. However, FAR_EL2 is not valid on certain microarchitectures (e.g.
Neoverse V2), so in the end it is just impossible for KVM to know the
poisoned IPA.

Does this clarify things? But again, it is confusing and will be removed.

[1] https://developer.arm.com/documentation/ddi0601/2025-03/AArch64-Registe=
rs/HPFAR-EL2--Hypervisor-IPA-Fault-Address-Register?lang=3Den


>
> >
> > In case VMM later asks KVM to synchronously inject a SEA into the
> > guest, KVM should set FnV bit
> > - in VCPU's ESR_EL1 to let guest kernel know that FAR_EL1 is invalid
> >   and holds garbage value
> > - in VCPU's ESR_EL2 to let nested virtualization know that FAR_EL2
> >   is invalid and holds garbage value
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  arch/arm64/kvm/inject_fault.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_faul=
t.c
> > index a640e839848e6..b4f9a09952ead 100644
> > --- a/arch/arm64/kvm/inject_fault.c
> > +++ b/arch/arm64/kvm/inject_fault.c
> > @@ -81,6 +81,9 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool =
is_iabt, unsigned long addr
> >       if (!is_iabt)
> >               esr |=3D ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
> >
> > +     if (!kvm_vcpu_sea_far_valid(vcpu))
> > +             esr |=3D ESR_ELx_FnV;
> > +
>
> I don't understand what this has anything to do with the uarch details
> you talk about in the commit message. If the VMM inject an exception,
> surely it has populated the exception context itself. I don't even see
> how we'd end-up here (__kvm_arm_vcpu_set_events? seems unlikely).
>

KVM_SET_VCPU_EVENTS is indeed the case this commit wants to fix.
Instead of populating the exception registers itself, VMM can use
KVM_SET_VCPU_EVENTS to let KVM do that per existing KVM doc [2], e.g.
when VMM handles the KVM_EXIT_ARM_SEA introduced in the previous
commit. The intent is to tell guest, for example, to not use FAR_EL1.

[2] https://www.kernel.org/doc/html/v5.10/virt/kvm/api.html#id3

>         M.
>
> --
> Without deviation from the norm, progress is not possible.

