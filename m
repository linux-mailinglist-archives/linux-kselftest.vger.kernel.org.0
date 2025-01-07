Return-Path: <linux-kselftest+bounces-24011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE074A047AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6101887D58
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1321F473E;
	Tue,  7 Jan 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LihkKnYL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D751F3D35
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269814; cv=none; b=DfdQRrofxyVbjEFLNQd7v1b7Y/qkPzUjrsA+V1ehCydo0cVxJu3bAB7RM1bNQifr2P7yctFVS870vksuFl2V04p8B6h5LWUP72zfaXHmJb1fUrRLRA9HLLltBw+jyH+pX94HQAt+o75I73e+7NvrJwMeRDrfjYntQHbJormtn8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269814; c=relaxed/simple;
	bh=k6MVnlt34ZD0SBO9MSU8T78C7vNtxZTkYcttZnmsriY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/TkRelIajbYdqXT3rKxMQfCPK+nrKh8isG7m/ZuhtNjH8tSlbwwqoaUzkoSm6K8JHvitopmg9e9qD12sGF5gA4cof1UU5tYCmuGK4DFpUZm6hZiSOzsNZlG1pZuZvyZ0DYxMRyBRvH/9f1ginMzCoor3jTslo54GcHbb7s4sXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LihkKnYL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736269811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwQkyTcOMsZ2EjZrTGgt+ipO0/RY4nS6QVm5/aGbi9U=;
	b=LihkKnYL6MWH+UyAoy3TYoMIKBqQqLCVWP6YTNNDg2/W9DN5l/+FaiQwBcWtuecYvC6TYn
	DTQsT5c7BLUgWve2y+1gBzB9vXaz8ARMrsDn470W2r47DcPrQthFrCloSlZ194KUNxdFiR
	cg9zRjOEb2+ECJ1ENGDNMG3+QmrPr7k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-VvKULfRGNUCX8K3eHg_yQg-1; Tue, 07 Jan 2025 12:10:08 -0500
X-MC-Unique: VvKULfRGNUCX8K3eHg_yQg-1
X-Mimecast-MFC-AGG-ID: VvKULfRGNUCX8K3eHg_yQg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436379713baso76691905e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2025 09:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269807; x=1736874607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwQkyTcOMsZ2EjZrTGgt+ipO0/RY4nS6QVm5/aGbi9U=;
        b=mycmbTaArHqofckEVS4b+Q3GbtUyDqmZElexlCs3ZRCxkAchHAf91p8ZVgvH9O0CgL
         tIGqMevrQrs1pjiGhzNPoymDJGutBXdWodh5WaIZXf+NoX73V3woCSiDcrFXlTOaBGgj
         2LV+wt9AsDdMQvC5SOJ716/MaCK2TMap3cJvJroPdqQuhWW28Lgry7ms9HdTQSNn29O0
         IcN7suy1iY2Q80oBv34GdgBDWYy+nNta9OwfRxrxDtj8T+jsza11BW7Mq6jz5Ulm0sxG
         qLk5NuoZutkdoqFU5/ArsYCq8P2IDY+rx/8dwfkvvzEf/Y3lSqK7UP1IHjZDUtEZBJ7K
         811A==
X-Forwarded-Encrypted: i=1; AJvYcCXeEh/7fP6leU+RnRf9ONoCbthhoMgZ9+tg/zgISY95EnNqWhNu0EMRxo9QmGG6JKmSa3UF698fzbv9/hvOSto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYL62611QhzhU1TfRfTNk6WDDfyRbunG6utDNSoqaO3wkPaqYP
	UGmjXVbi6vMC7foMGHe7fjV/foevqTbrnL4dXWp828Dx8+t6+Ft8JvBliLZSg4i9gPIrPkhG+FS
	H++qzzX2snvQ+ugKA32YERPeO8i3Pw55UxyQPJCPPei2CIbVkiudirNzv4bs3tJMsHAWh73xGxI
	JanlqcNqbvfuyq3kx3nEMMS35CK7Srl8LOqoXmwj2x
X-Gm-Gg: ASbGncuqJIl+WuOjBYuOUZlAFhZocK1fFWwdh445Qa322ey6AFo1vIqZWF6mIzPjEwr
	oM+NQkzLONHTDTvJA3pzp2sEBNPlflI1tz588fQ==
X-Received: by 2002:a05:600c:1d21:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-4366790e3fdmr593069185e9.0.1736269806956;
        Tue, 07 Jan 2025 09:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSvogatKxKxqA2wBw/+7sDsL67SJLzCtKQockD6aGfvTv8LM12x53+vGigfD/GcR6BSKn5UMxxRiIg0aVgOFw=
X-Received: by 2002:a05:600c:1d21:b0:434:a4a6:51f8 with SMTP id
 5b1f17b1804b1-4366790e3fdmr593068955e9.0.1736269806643; Tue, 07 Jan 2025
 09:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com>
 <c3026876-8061-4ab2-9321-97cc05bad510@redhat.com> <CADH9ctBivnvP1tNcatLKzd8EDz8Oo6X65660j8ccxYzk3aFzCA@mail.gmail.com>
 <CABgObfZEyCQMiq6CKBOE7pAVzUDkWjqT2cgfbwjW-RseH8VkLw@mail.gmail.com>
 <CADH9ctA_C1dAOus1K+wOH_SOKTb=-X1sVawt5R=dkH1iGt8QUg@mail.gmail.com>
 <CABgObfZrTyft-3vqMz5w0ZiAhp-v6c32brgftynZGJO8OafrdA@mail.gmail.com>
 <CADH9ctBYp-LMbW4hm3+QwNoXvAc5ryVeB0L1jLY0uDWSe3vbag@mail.gmail.com>
 <b1ddb439-9e28-4a58-ba86-0395bfc081e0@redhat.com> <CADH9ctCFYtNfhn3SSp2jp0fzxu6s_X1A+wBNnzvHZVb8qXPk=g@mail.gmail.com>
 <CADH9ctB0YSYqC_Vj2nP20vMO_gN--KsqOBOu8sfHDrkZJV6pmw@mail.gmail.com> <Z2IXvsM0olS5GvbR@google.com>
In-Reply-To: <Z2IXvsM0olS5GvbR@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 Jan 2025 18:09:54 +0100
X-Gm-Features: AbW1kvYbICc679MeQNzE1ow2NFvGxOmTuZ13zzWBDAwtldHBRVtXoFV8OfA0EJs
Message-ID: <CABgObfadZZ5sXYB0xR5OcLDw_eVUmXTOTFSWkVpkgiCJmNnFRQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
To: Sean Christopherson <seanjc@google.com>
Cc: Doug Covelli <doug.covelli@broadcom.com>, Zack Rusin <zack.rusin@broadcom.com>, 
	kvm <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 4:44=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> > Changing our legacy BIOS is not an option so in order to support Window=
s VMs
> > with the legacy BIOS with decent performance we would either need to ad=
d support
> > for remote reads of the APIC ID register to KVM or support CR8 accesses=
 w/o
> > exiting w/o the in-kernel APIC in order.  Do you have a preference?
>
> I didn't quite follow the CR8 access thing.  If the choice is between emu=
lating
> Remote Read IPIs and using a userspace local APIC, then I vote with both =
hands
> for emulating Remote Reads, especially if we can do a half-assed version =
that
> provides only what your crazy BIOS needs :-)

Absolutely.  Not quite userspace local APIC - VMware only needs
userspace traps on CR8 access but yeah, it would not be great to have
that. Remote read support is totally acceptable and hopefully win-win
for VMware too.

> The biggest wrinkle I can think of is that KVM uses the Remote Read IPI e=
ncoding
> for a paravirt vCPU kick feature, but I doubt that's used by Windows gues=
ts and
> so can be sacrificed on the Altar of Ancient BIOS.

That's easy, the existing code can be wrapped with

                if (guest_pv_has(vcpu, KVM_FEATURE_PV_UNHALT))

The remote-read hack is not even supposed to be used by the guest
(it's used internally by kvm_pv_kick_cpu_op).

Paolo


