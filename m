Return-Path: <linux-kselftest+bounces-48867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C2ED198DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F1E30942E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C42BF00D;
	Tue, 13 Jan 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Kfo9pME"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465A287254
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315118; cv=pass; b=PIHcjqlY9r2HL17nunP3tQisB84glnJ+o2zfliz79evkR7p1PZbyhaXLMgLSCPNWzD1Y+6e6H29OMqi0isNnmTc0KDuOHwm4bOTcOXWtiLsK14mf50jvs0GiQ3aOPYP/QK7ZOay1tEGyUV0pCKVPc3D4Ghitn1qyHImQHq9/Kgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315118; c=relaxed/simple;
	bh=HCdvS5NkY0vXw8KWKY8kVRjAzF9gX4xS/N5ZGLvpz88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7tqU0k5sUcN9DmIAhRxw2LZEqF2lN2tRxNtCtgbwfR41Htm5TQVXnuE2YizGEtcP5cUN6HPnmNst61cHW9x0Fm02H7wIVQNi6quKKCuYtkMeCKg3eRJZkUR9aMXfuXlt8+I+yYWIcJcNyTLiiQVtguTTjgHC2SmCUpaMqke7Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Kfo9pME; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee147baf7bso320881cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 06:38:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768315116; cv=none;
        d=google.com; s=arc-20240605;
        b=AxR56B8D/wLhFDe0qK9yZMGSYF5TmgCttTunolVNd8TN4Z2a4x9InIHeGYX6rjLa4K
         yXecBQCs1kdMWss52NzhYFYJZy+RTS47ro9kvAE09ISyW9iC/7ewsM7H1w8+a5zR0/6q
         n9gP4sjhKsz51Df5iATTA1Jz4VRDvn/fD+js/bd8MYLihx/Kn9Gl+IYVj3jYA5CmGKVA
         /Uod1BPQkaSe+3ZsBGVMDN+VFwxgFviknxYJRG2AwhNaVuQ+pG0eX6WLiNpx6mGHjjgf
         eLZ8MUMG4Ib+IRYKcMa5W6QYfww8sDHwdY3P3xSryQTM41N0A1ghVtXrJZ6or8WP6oK3
         BFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z0SrzDaVUXRmKWRvPdSPBpUEx4WP+XB1ix/xiAgEPgg=;
        fh=pDcUDK5UsLXNLXjmlwXvK9vKvlYc0I+HHa4PJvCq/w8=;
        b=gQzNYb1ZE1n65X3ybRMhcwdQBY4zdHyBOZu8BKbV2E4qS/Id8i7jlyde5jJq+0k1MA
         Wj13yMmTk/3pVSRU7gA50YfpOLDo1FuKyMfuN09+65mJcs6fVNLBvPGbExSSjEzjYTtj
         4NUlmjkKqqD2Zir3OcYHw8krq8K0fjdgjb8kQ6LHTwjoIxFoH4pE09A1VJgLQ4vfEEPM
         a3se2N8hiRDE7ZR1dopa+1ps4H6dK6dDzsB/3pTGicGjSqlLPp6akFJW0SYWL7MUpw9u
         olXgaK7XG51tk1jBoCbGyelL8hH6wKulueP//wqthqspNFsRLgqTQpIfslFlKvINsUPw
         IyOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768315116; x=1768919916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0SrzDaVUXRmKWRvPdSPBpUEx4WP+XB1ix/xiAgEPgg=;
        b=3Kfo9pMEuU9AQPTMSP7KjhmahlErlXGn4E0euTU7WbUvjOk/93PI8BCBzWMJZdcMSX
         wHbxi88+CFd/plzvNFD5w9P/AXMhwLqveoVYT+y4ept78PTtXfYbreWsBsKUj9qhduHa
         M47aloV5zJIb7N0fYJz9ni7W1nwlyh04eZqiOXk0KK44AEXykqudsH9XkZ5vvI3hbPnq
         aSrt65yS6yKgBlHWYt7iZtldd5aD/d7F+7ivB7Jj91UP+BGAws/rknP1Hc/E5HU8eV7H
         XeVEXO6/tPY0tV1/sfe+X0nbsOxAZtGcJJav/dCtmdiIgFZFAgT7UJAAC/AeZGHSyG/q
         hoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768315116; x=1768919916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0SrzDaVUXRmKWRvPdSPBpUEx4WP+XB1ix/xiAgEPgg=;
        b=Nmj9/ZvENF1+qX1TRX4Y1+fX6yeVWBswQ0bN+iA093ROpHPCxcWgNzrAJRO4d1mlkr
         DIlD2bRuLU14woYZqLEBmP/0LSMhZ9/JOYuaF2Lw5sh9Zx4bvQ9ZlT4xdltbn16UfKyH
         lQcPzLFx78MP7jlp7qUqUlBpt12ebYUjA+MYuZtAJqafEjm9j/actvdeCEekHhwwv0hj
         HXltcBhyLS1pET50hkiF2bVeFOk2MUJAMf/Uksne2YlPZY6EP3OP8Smx8KVnhM+95yyv
         rS3AaxB3UZz7aluyTk7E2A9iKMeU8bStwtJGhW36T3Q4yvbL0SWnQXJ3RmU04XQ/s7Gz
         viUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkR/sehicQDDldpqZdrlcY5oO8zP3lgmZias9k2Oz1CMU7beIOaotoF1kYuRjFqQrr1KgfVEkt7s4K5sQ9JK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0/t99Doh4+NjMdyGcClow+Q/11K8uf9ek42qMeTjIHZhQ56t
	/O78m3e4K7mRIagaip87kpHk+p1Tf4Zd9UkbfpRXS65bZg//cVoQIo86y0Ms56XfPJqKxmhfRrs
	kbFRTRPH5jTlFw0tAJMMotLAu1uKJgFvB4ijtQoZ9
X-Gm-Gg: AY/fxX7A0H6uQjR0qcl1RXCRu1sfRSeearfWJA8HkNAkQK+Lw3/oqiKn9fn8MYY2tB5
	fK6OVhaEaF668S/Rrbu50OYoHCmtOHkXaVD05xVYYQjQFvyUWG8rnEq0bGkpt0FFli190ODgB1o
	mu25UYj+UMXqzNoEJ6JIiQlVH+aikVdUaIeIMbT82SODCZNFQ/TSXGxI9O2+sWaPzPFvH51Y7kB
	ZNSaLAGy/P+8RsVLPomFmGIEWAEJ4+oxGqVrjluWofZqFuey8JnZVqsYus9iCBeCH+rG1MVD1NP
	wR6K3eh4nPj3pNWyVZCAyZjBMw==
X-Received: by 2002:a05:622a:90:b0:501:19ce:5bdd with SMTP id
 d75a77b69052e-5013a21b63dmr4606041cf.6.1768315114958; Tue, 13 Jan 2026
 06:38:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-25-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-25-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 13 Jan 2026 14:37:57 +0000
X-Gm-Features: AZwV_Qi2DCwvCxhy1IBJRUhKVRAZLawBqR0npBrkyjREHFYNX_l_ocigtzC7uIo
Message-ID: <CA+EHjTwZCcMFT6gAM2oaQz5V_vqEBmVuggFBbABbXPvC+U919Q@mail.gmail.com>
Subject: Re: [PATCH v9 25/30] KVM: arm64: Expose SME to nested guests
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

On Tue, 23 Dec 2025 at 01:23, Mark Brown <broonie@kernel.org> wrote:
>
> With support for context switching SME state in place allow access to SME
> in nested guests.
>
> The SME floating point state is handled along with all the other floating
> point state, SME specific floating point exceptions are directed into the
> same handlers as other floating point exceptions with NV specific handling
> for the vector lengths already in place.
>
> TPIDR2_EL0 is context switched along with the other TPIDRs as part of the
> main guest register context switch.
>
> SME priority support is currently masked from all guests including nested
> ones.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kvm/nested.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index cdeeb8f09e72..a0967ca8c61e 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1534,14 +1534,13 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
>                 break;
>
>         case SYS_ID_AA64PFR1_EL1:
> -               /* Only support BTI, SSBS, CSV2_frac */
> +               /* Only support BTI, SME, SSBS, CSV2_frac */
>                 val &= ~(ID_AA64PFR1_EL1_PFAR           |
>                          ID_AA64PFR1_EL1_MTEX           |
>                          ID_AA64PFR1_EL1_THE            |
>                          ID_AA64PFR1_EL1_GCS            |
>                          ID_AA64PFR1_EL1_MTE_frac       |
>                          ID_AA64PFR1_EL1_NMI            |
> -                        ID_AA64PFR1_EL1_SME            |

Should we also limit this to SME2, i.e.

+ val = ID_REG_LIMIT_FIELD_ENUM(val, ID_AA64PFR1_EL1, SME, SME2);

That said, we don't do anything similar to SVE, but it might also be
worth doing that there.

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>                          ID_AA64PFR1_EL1_RES0           |
>                          ID_AA64PFR1_EL1_MPAM_frac      |
>                          ID_AA64PFR1_EL1_MTE);
>
> --
> 2.47.3
>

