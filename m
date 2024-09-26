Return-Path: <linux-kselftest+bounces-18390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ADE986FB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66F41F2303A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 09:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C01AB51F;
	Thu, 26 Sep 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyUaenZD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26415532A;
	Thu, 26 Sep 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342101; cv=none; b=CduheW2hvAyNPBGz+V4N97UHk9FOuquLrV9aDSUU/4Bp3Y3Icon6TKx5Uls60eNqf4IU379Zw7Q5odGWXRcr+u16lcgKRic1Dlpt7F0LY/s36IucpNCknyGNeADx64CbpI9iHdgrHK/ZOi5c26EoaJg/P2KJDO+UC5a2OHoadSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342101; c=relaxed/simple;
	bh=5CRALTb60twaABfzMtifOzQaiO9ApKULKNiRaSr55Og=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4NP6UkdIZYCc1gjFbqqlpNf8VnFLZJ7hohoDMiSux8GBo5jaNHIj7eSXGoMsQJSeKPuSb/BPbo3dGC+y98p/XwAUyfiD3UuECAUTXPVCKqHi/pzM8BNBaL7i57+9daa/eoiCkuUCvgfl71Q5RCJ4Brd4MXIuVJHQVC7iZnopbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyUaenZD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a90188ae58eso93188266b.1;
        Thu, 26 Sep 2024 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727342097; x=1727946897; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CRALTb60twaABfzMtifOzQaiO9ApKULKNiRaSr55Og=;
        b=EyUaenZDmPVWrlL7GXFz7XO9GlyuRiFdDZxwXmDklH9zMo0o2B034aHrhmFO6KOA9T
         7ZuHgBLy0eofILEy8AJRCtAy5eEFbV7edO5834DOFBpoQ4lnwzSYIDotN8KNcymVowCD
         R2+t+D1GUrYD4PByygV9jyHz4dUYxIa6XZjKu4byTgomI9JwqaZoNf2sPUQYY5GkYQaP
         EW/8/i6gZdjG31IivudzxvTJG+7PIm/fo4BCoZ+JOtFcj/OzqekKaGdkVnXgwGTXghk/
         5XulnRFgHmWlTWxSQOuIZ3h8/DDasJdjH5N/2Cz3kJnozPUk3fxryufx2CbCzg5ngHE8
         pO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342097; x=1727946897;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5CRALTb60twaABfzMtifOzQaiO9ApKULKNiRaSr55Og=;
        b=ZP83C6GXywtvI9dHdiJ9+eZGZUJVknsZwe9zyyyVZgZOitMQ2JhEbeo9yiq0CkpM4C
         tDtVZxi69v6Wfppabwrkhspn1f+7G755kyTYzCD+aDdU6xde5rjwPJdnTB8e4fK8NKaJ
         ASGFdmm2NsroTE0BJahI4uBCu0PTt4xhfhJ5Olgbf3iGQw4dRkiWLn9ed/72gNsAy022
         Oed1zq27vabTI5X6xEr+r5SXmOMXKWovXn49Zjm/3Qv4l/5w4fY5LL4/Ok089nXsaAuz
         7j4vz65T8wSNkdkP/xxW+d6Zow5YtkdLyQGe0CizkORC96VzqaDw6GsDd9/DQHeaWmG8
         jrWA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ePmPedJ/F7Us8vPXQasxmRmdNv9kS/mzFO5lgflRh6FHCARmtzlZHWVO0VuAp3C1oBQ=@vger.kernel.org, AJvYcCUcGRLWD+6yU6vmjTtYQ5javLsUoGFIjGsiGrVosPiESql8EIHnMb8STPScHJFBw0/crvlaRbwzIDEG@vger.kernel.org, AJvYcCVJk0Vkr98UA/6qTNh65ER74Zl70OlhuxIT3LPl0fxDM6/jrYF6ZD1bNmI3CsRJ9kKObAwNWyNKUrSS0PTr@vger.kernel.org, AJvYcCVPAn0k/HdWYrz67U2wkxn4OBiS6t8ds1K6IJy7zYZ8P0UqWf7WbzTLJbXR8AvTA07KP3kio+DYXcNDG6UhPegM@vger.kernel.org, AJvYcCXmjXYOBZav78RpDtK9X+7UseGwIZL7mImpMnwPCHSh8eWSnrX+jInNsgNuMH2151V4OnKObsVsycI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHjNJsiTVCl2sD0ntlMpijgt2IdQV9IqQgRdbsWqRAntNtMYf
	c2J/avguajjhFqyQRges1bKz+Q0X97kDPowkk7PAvvluSRGshqo1
X-Google-Smtp-Source: AGHT+IFuQpCkW97RwiXsH3H+4pPmO2s5+Udb73F6RcjEM6YRZ3bpHYtgsjXjgkpzlG78J1VZAoyE3w==
X-Received: by 2002:a17:907:7d8a:b0:a8b:6ee7:ba29 with SMTP id a640c23a62f3a-a93a05e7e95mr521203166b.44.1727342097231;
        Thu, 26 Sep 2024 02:14:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:438a:71d4:3b8a:6ddf? ([2001:b07:5d29:f42d:438a:71d4:3b8a:6ddf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93931336b4sm322256666b.188.2024.09.26.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:14:56 -0700 (PDT)
Message-ID: <709968e9b2a947787177f7ea3eefcc89546bffd2.camel@gmail.com>
Subject: Re: [PATCH v4 2/6] KVM: arm64: Add PSCI v1.3 SYSTEM_OFF2 function
 for hibernation
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>,  Jonathan Corbet <corbet@lwn.net>, Marc Zyngier
 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, James Morse
 <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui
 Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Shuah Khan
 <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 kvm@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev,  linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Thu, 26 Sep 2024 11:14:54 +0200
In-Reply-To: <20240924160512.4138879-2-dwmw2@infradead.org>
References: <20240924160512.4138879-1-dwmw2@infradead.org>
	 <20240924160512.4138879-2-dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 17:05 +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> The PSCI v1.3 specification (alpha) adds support for a SYSTEM_OFF2

Can remove (alpha).

> function
> which is analogous to ACPI S4 state. This will allow hosting
> environments
> to determine that a guest is hibernated rather than just powered off,
> and
> ensure that they preserve the virtual environment appropriately to
> allow
> the guest to resume safely (or bump the hardware_signature in the
> FACS to
> trigger a clean reboot instead).
>=20
> The beta version will be changed to say that PSCI_FEATURES returns a
> bit
> mask of the supported hibernate types, which is implemented here.

Since the final spec has been released, we can revise or remove the
above wording.

> Although this new feature is inflicted unconditionally on unexpecting
> userspace, it ought to be mostly OK because it still results in the
> same
> KVM_SYSTEM_EVENT_SHUTDOWN event, just with a new flag which hopefully
> won't cause userspace to get unhappy.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> =C2=A0Documentation/virt/kvm/api.rst=C2=A0=C2=A0=C2=A0 | 11 +++++++++
> =C2=A0arch/arm64/include/uapi/asm/kvm.h |=C2=A0 6 +++++
> =C2=A0arch/arm64/kvm/psci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 37
> +++++++++++++++++++++++++++++++
> =C2=A03 files changed, 54 insertions(+)
>=20
> diff --git a/Documentation/virt/kvm/api.rst
> b/Documentation/virt/kvm/api.rst
> index b3be87489108..2918898b7047 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6840,6 +6840,10 @@ the first `ndata` items (possibly zero) of the
> data array are valid.
> =C2=A0=C2=A0=C2=A0 the guest issued a SYSTEM_RESET2 call according to v1.=
1 of the
> PSCI
> =C2=A0=C2=A0=C2=A0 specification.
> =C2=A0
> + - for arm64, data[0] is set to
> KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2
> +=C2=A0=C2=A0 if the guest issued a SYSTEM_OFF2 call according to v1.3 of=
 the
> PSCI
> +=C2=A0=C2=A0 specification.
> +
> =C2=A0 - for RISC-V, data[0] is set to the value of the second argument o=
f
> the
> =C2=A0=C2=A0=C2=A0 ``sbi_system_reset`` call.
> =C2=A0
> @@ -6873,6 +6877,13 @@ either:
> =C2=A0 - Deny the guest request to suspend the VM. See ARM DEN0022D.b
> 5.19.2
> =C2=A0=C2=A0=C2=A0 "Caller responsibilities" for possible return values.
> =C2=A0
> +Hibernation using the PSCI SYSTEM_OFF2 call is enabled when PSCI
> v1.3
> +is enabled. If a guest invokes the PSCI SYSTEM_OFF2 function, KVM
> will
> +exit to userspace with the KVM_SYSTEM_EVENT_SHUTDOWN event type and
> with
> +data[0] set to KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2. The only
> +supported hibernate type for the SYSTEM_OFF2 function is
> HIBERNATE_OFF
> +0x0).

The spec says that the HIBERNATE_OFF parameter value is 0x1, not 0x0
(which is kind of unfortunate because it doesn't match the
corresponding bit in the feature flags).
So, either the BIT(PSCI_1_3_HIBERNATE_TYPE_OFF) value should be used
for the SYSTEM_OFF2 functions in the code, or the definition should be
changed in the header file (unless the text in the spec is wrong).


