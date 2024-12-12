Return-Path: <linux-kselftest+bounces-23236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B679EDC9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 01:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C292E28371B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 00:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB88EEA8;
	Thu, 12 Dec 2024 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxL2NKsa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B51C2E0
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964259; cv=none; b=cSaPcLuSih6301QOpevZnE3RN5U0PAVQ9J+8uGaDBJtA+pgjBEUMLePU9iHtKNOOo1uZk+UnHtnpxJSnMkAdTyyA/SaMwpa1oYXLwnCzS1PJJ8h8W7aNmI304vwOo+LU8QyZQ7h9Tkwbt5WWrOUhX1lnJTorq2QvZsd35LnvDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964259; c=relaxed/simple;
	bh=ZFVS4I3U02G+MOb/WaONSbROPbwinmZnTdyZOIJYGQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Odi79oI2DpHkKP7Q/8j25O4YJMJaJxbT9sBpZVwymVIk0pk/bYCb6q+OYTnCQsrvy57QMn74fOoXc96Tv2VKP5exl5bAF9dV9cD2NtxfGZT+1RlO7EjtNOTXicsRF6paselMfHxAu8XA6+GnMrbaYEii9FMZG/QI/5aOZp4YIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxL2NKsa; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725e2413114so69668b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 16:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733964257; x=1734569057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GkRvpUyUUxLXXslAyZysQj7PHEnMJz+mUJ4HaWmPQU=;
        b=NxL2NKsaFnI7LLLaQWsL5BXo632MnXwwcESwnsfPqlpKvuVNEPM7TE2ZynILTdROEQ
         w+BnkEr/V0MZkvYr5fUyVdhiGgcKWeptTlA4pm8V8xWM1URGV31Gfh2DWt+mN/oDI0oQ
         LJdhhYYEIfkCTPYfphv2T00YfkYcKW3ehLOwlBT7OCVYIRuQZIjtQiXp108o9alZ0STQ
         jdjeo2QlGKQL67dXKRh+oHHRaQpPOPK0yfLx8mfHXBWC0UwfSIZsvQh1WAXPtXSxvt5s
         +NxNpstKZX4YJqMp2B2tLZhRqoJx/ZOSNBMARE9cYX1rHp9YuzWTgbYxu/MSUDvCdsbN
         xrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733964257; x=1734569057;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0GkRvpUyUUxLXXslAyZysQj7PHEnMJz+mUJ4HaWmPQU=;
        b=t8zHO8RRljfk/gjLE68a6IEispBCeibetfm74S1F21qGdyS2vc5Pbm/vkuVRTGy2PX
         V7kxnYHME/tHaIdncARv80/RaxPjY7gxPB/8mpggn2z8n1mbyVIxVNAe/4xHP7mPBnAq
         60NJL1bmYuZF0tRV6sQL1WIIDLZg2x/cTzFcY2d5xHvN1xtRTAmZ2hr5Yko5LKUK1H0Z
         paWiyA1oyy678346y7fqMAbN9nG9waOSgERO3Ky8DItC2yfDObaI8G8p+AvO+HxP94Up
         qoNswbkBb3T8dZ3w9ei/JiM8yhyuO+tMDddtT1dXt7YnzHGIRWyRlliB6HQA3wdRP/F7
         Dvrw==
X-Forwarded-Encrypted: i=1; AJvYcCV5WIlcmapPgMjgmbIiL4h520KDsf36ComTEp4YryhrxywJ6ZhfiIYArUJLlDZtQM1qQc0nFZ37nQ4oHZoUHTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1JSUeYb3Lq6POoeIhM9PlOdtQWTDWeLLURHwXq7vtcXgVwyI
	T1l2a37+f6+rCcB0CrZoP7vNsJKyYA7Frq3iDkFDpD/1VFgsfMJQpolyjASmvghf0CYeAi5xWft
	oSA==
X-Google-Smtp-Source: AGHT+IGLrPsupm3n9RQUU7cbKc9unNn4H+/lMc4HrwrVEhDZfESFsJ247bMXfY2t5iDDz2zu6UJGqgtdBP4=
X-Received: from pfaw15.prod.google.com ([2002:a05:6a00:ab8f:b0:725:d24b:1b95])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2394:b0:725:1de3:1c4a
 with SMTP id d2e1a72fcca58-728fa9b8597mr1999672b3a.3.1733964257283; Wed, 11
 Dec 2024 16:44:17 -0800 (PST)
Date: Wed, 11 Dec 2024 16:44:16 -0800
In-Reply-To: <20241211193706.469817-2-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211193706.469817-1-mlevitsk@redhat.com> <20241211193706.469817-2-mlevitsk@redhat.com>
Message-ID: <Z1ox4OHNT6kkincQ@google.com>
Subject: Re: [PATCH 1/4] KVM: VMX: read the PML log in the same order as it
 was written
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024, Maxim Levitsky wrote:
> X86 spec specifies that the CPU writes to the PML log 'backwards'

SDM, because this is Intel specific.

> or in other words, it first writes entry 511, then entry 510 and so on,
> until it writes entry 0, after which the 'PML log full' VM exit happens.
>=20
> I also confirmed on the bare metal that the CPU indeed writes the entries
> in this order.
>=20
> KVM on the other hand, reads the entries in the opposite order, from the
> last written entry and towards entry 511 and dumps them in this order to
> the dirty ring.
>=20
> Usually this doesn't matter, except for one complex nesting case:
>=20
> KVM reties the instructions that cause MMU faults.
> This might cause an emulated PML log entry to be visible to L1's hypervis=
or
> before the actual memory write was committed.
>=20
> This happens when the L0 MMU fault is followed directly by the VM exit to
> L1, for example due to a pending L1 interrupt or due to the L1's 'PML log=
 full'
> event.

Hmm, this an L0 bug.  Exiting to L1 to deliver a pending IRQ in the middle =
of an
instruction is a blatant architectural violation.  As discussed in the RSM =
=3D>
SHUTDOWN thread[*], fixing this would require adding a flag to note that th=
e vCPU
needs to enter the guest before generating an exit to L1.

Oof.  It's probably worse than that.  For this case, KVM would need to ensu=
re the
original instruction *completed*.  That would get really, really ugly.  And=
 for
something like VSCATTER, where each write can be completed independently, t=
rying
to do the right thing for PML would be absurdly complex.

I'm not opposed to fudging around processing the PML log in the "correct" o=
rder,
because irrespective of this bug, populating the dirty ring using order in =
which
accesses occurred is probably a good idea.

But, I can't help but wonder why KVM bothers emulating PML.  I can apprecia=
te
that avoiding exits to L1 would be beneficial, but what use case actually c=
ares
about dirty logging performance in L1?

[*] https://lore.kernel.org/all/ZcY_GbqcFXH2pR5E@google.com

> This problem doesn't have a noticeable real-world impact because this
> write retry is not much different from the guest writing to the same page
> multiple times, which is also not reflected in the dirty log. The users o=
f
> the dirty logging only rely on correct reporting of the clean pages, or
> in other words they assume that if a page is clean, then no writes were
> committed to it since the moment it was marked clean.
>=20
> However KVM has a kvm_dirty_log_test selftest, a test that tests both
> the clean and the dirty pages vs the memory contents, and can fail if it
> detects a dirty page which has an old value at the offset 0 which the tes=
t
> writes.
>=20
> To avoid failure, the test has a workaround for this specific problem:
>=20
> The test skips checking memory that belongs to the last dirty ring entry,
> which it has seen, relying on the fact that as long as memory writes are
> committed in-order, only the last entry can belong to a not yet committed
> memory write.
>=20
> However, since L1's KVM is reading the PML log in the opposite direction
> that L0 wrote it, the last dirty ring entry often will be not the last
> entry written by the L0.
>=20
> To fix this, switch the order in which KVM reads the PML log.
>=20
> Note that this issue is not present on the bare metal, because on the
> bare metal, an update of the A/D bits of a present entry, PML logging and
> the actual memory write are all done by the CPU without any hypervisor
> intervention and pending interrupt evaluation, thus once a PML log and/or
> vCPU kick happens, all memory writes that are in the PML log are
> committed to memory.
>=20
> The only exception to this rule is when the guest hits a not present EPT
> entry, in which case KVM first reads (backward) the PML log, dumps it to
> the dirty ring, and *then* sets up a SPTE entry with A/D bits set, and lo=
gs
> this to the dirty ring, thus making the entry be the last one in the
> dirty ring.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 32 +++++++++++++++++++++-----------
>  arch/x86/kvm/vmx/vmx.h |  1 +
>  2 files changed, 22 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0f008f5ef6f0..6fb946b58a75 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6211,31 +6211,41 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu =
*vcpu)
>  {
>  	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
>  	u64 *pml_buf;
> -	u16 pml_idx;
> +	u16 pml_idx, pml_last_written_entry;
> +	int i;
> =20
>  	pml_idx =3D vmcs_read16(GUEST_PML_INDEX);
> =20
>  	/* Do nothing if PML buffer is empty */
> -	if (pml_idx =3D=3D (PML_ENTITY_NUM - 1))
> +	if (pml_idx =3D=3D PML_LAST_ENTRY)

Heh, this is mildly confusing, in that the first entry filled is actually c=
alled
the "last" entry by KVM.  And then below, pml_list_written_entry could poin=
t at
the first entry.

The best idea I can come up with is PML_HEAD_INDEX and then pml_last_writte=
n_entry
becomes pml_tail_index.  It's not a circular buffer, but I think/hope head/=
tail
terminology would be intuitive for most readers.

E.g. the for-loop becomes:

	for (i =3D PML_HEAD_INDEX; i >=3D pml_tail_index; i--)
		u64 gpa;

		gpa =3D pml_buf[i];
		WARN_ON(gpa & (PAGE_SIZE - 1));
		kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
	}

>  		return;
> +	/*
> +	 * PML index always points to the next available PML buffer entity
> +	 * unless PML log has just overflowed, in which case PML index will be

If you don't have a strong preference, I vote to do s/entity/entry and then=
 rename
PML_ENTITY_NUM =3D> NR_PML_ENTRIES (or maybe PML_LOG_NR_ENTRIES?).  I find =
the
existing "entity" terminology weird and unhelpful, and arguably wrong.

  entity - a thing with distinct and independent existence.

The things being consumed are entries in a buffer.

> +	 * 0xFFFF.
> +	 */
> +	pml_last_written_entry =3D (pml_idx >=3D PML_ENTITY_NUM) ? 0 : pml_idx =
+ 1;
> =20
> -	/* PML index always points to next available PML buffer entity */
> -	if (pml_idx >=3D PML_ENTITY_NUM)
> -		pml_idx =3D 0;
> -	else
> -		pml_idx++;
> -
> +	/*
> +	 * PML log is written backwards: the CPU first writes the entity 511
> +	 * then the entity 510, and so on, until it writes the entity 0 at whic=
h
> +	 * point the PML log full VM exit happens and the logging stops.

This is technically wrong.  The PML Full exit only occurs on the next write=
.
E.g. KVM could observe GUEST_PML_INDEX =3D=3D -1 without ever seeing a PML =
Full exit.

  If the PML index is not in the range 0=E2=80=93511, there is a page-modif=
ication log-full
  event and a VM exit occurs. In this case, the accessed or dirty flag is n=
ot set,
  and the guest-physical access that triggered the event does not occur.

