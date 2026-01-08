Return-Path: <linux-kselftest+bounces-48514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1FD039BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C42832DE840
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE0448C8D8;
	Thu,  8 Jan 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRz6DqXa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD948AE18
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881421; cv=pass; b=ILe4aYj3SLMmb0pWo1qkHvqNoO30sV5iIIq2yfS0nsyi8iapzHXkvvfbq3vpQHSPjbrEMwhK6b4z2NIc7INFfjpFKm2ZvR6qMozVbFw5aQPPvSx5gHOaCYwiVVb4kh8bdygLv8agKDwux4hHaaWOzyS0Hm4bfxoJ9ffLUxaQe7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881421; c=relaxed/simple;
	bh=nd9v6rOTsgtmeIcSOzUf+JTIDj5sX0xCl7dm1iZzN1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFQSCERJ46hF0WGDa3nbVGguPbAKvexjjU+D+MBEpsB3iNyzSHvOc9hUgEGIRL493B2VggEMUs4NLnSM9jEkVoFsRFRLsEzpwsFFonZBnPW8z7PjyGtMK1xFuR8WLFnqstc7sMjQjgo2bi1b7B1A255qNFZjDRy3XOMsz8LcuSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRz6DqXa; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ffbaaafac4so742931cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 06:10:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767881418; cv=none;
        d=google.com; s=arc-20240605;
        b=XpTCDZWRMxyPR2ZH+MZrToG18+hMSqX0X9fWV2P2T0cEBJH7KqHBr36bkQXBiPwhtR
         Biqxo8YafMVhIBZW8xamtqGkvmWpd7KnZXAgzxTJsihF8EFfLXvhDcf/DwBtCpO48F8H
         3LEPhMUFN7h2tXu8xcWDIiMIGBaVtJYVjLO+sjkIw9gZlkGm+TuWKYd1rxO6LeDuZ/Ow
         qvC7Ubobl0C9vF+mgcjCWMds6PBQ9FpNqlBxi0cUlBdoswwqCbS6SxagHFW4ms28ANX1
         6owblSqRub2Yg6N7jYKYRHy1kKoxhp86lUw8YlliglZg8bD2DTjyyqBdbJkj6VLTU+Z8
         IYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M6v8yJzivCkGRPQD2RD9WlokTdTcLOTAtGeFegCEmXw=;
        fh=g/EYUZujxXTnMrRRayERPUaUMP21tyISENkYJ8wcPcI=;
        b=LtBrJtA0lOQQp5B8iLjaTYRa9jMb1UCVo2fRCLyopcMlyFXkh9WHjN4XDOFJ4iwwup
         H3LWhKBJj+dqmQpR+3p23xBBml4Huu7I51BsxKO9K/RhaSGCS7bb2DXWDDUyQLFE0cMn
         6QYWuKP4H00b0k9Mgg0P/Age+uouH/nOJ6/gZi9ARfQM00m6p4lQEUowHZDQg8uzuNHy
         7RwysKeFzO2eIPFriPMhj0mUwR/cDgqu7nJwQYnSEj411T3MAXCS692PgtPqmOrIiTCi
         Fj5ck47oSJxQ+TEgnHM4Q2XrhFt1Sg/vMZ2tZ95JPSx48cVtuqoyz3RydItRcxiYDlRy
         +h/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767881418; x=1768486218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M6v8yJzivCkGRPQD2RD9WlokTdTcLOTAtGeFegCEmXw=;
        b=NRz6DqXa4ClVdKehiDwldRMqmgo3ZwyGOugTTSKJGN7TMEzEW730F1zQwwvuFOPK/t
         K+Ug2iifvUaf+MWX0jmC6f42mdd8oXTHeeZIxbypxamL9QvATvZO0EnRW0VHEhAo37MT
         pOD9fdVkJyXCsMQ8pFWzPv/8to/m9zXiHo9y5X/nkzObA1dOfrsjuCR2bmepspAWt60r
         huLuUEqGosGpeB0yBFBt9BYswxRdbBasEHIUJKLstIMjR3uktGB7D5fSPEtZWFXt5I5W
         1miepmmRdpppRQCPv2/KLURU7U8bt+T3sb6stn9yUzAQNyy89j0yJ30leftE/x6kj2cm
         LqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881418; x=1768486218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6v8yJzivCkGRPQD2RD9WlokTdTcLOTAtGeFegCEmXw=;
        b=BZ1VK+iHeyiVXFnqibJhGr949XzIBA4lvwXNgftktWEINIGU+dYi9dcCRSUzUf/CYz
         vvyL6rg6EnFPZuHlyk5PvLU5emzPGEHtAjDrW0uqoWGSBmpPBLZAttEbEsSFBHENM7Jy
         yzinHqO7bvo+S40bux86ZljiD4r7O2317QaYQViILLoVvcrqElJ4x3Rhrqs5tJzup2bP
         ublAi4y++P2HdCFJNkJhs33vpA6izAMri1gX3ds0IIgHgMv6HGmw+rkFiXgy+oVP1xqg
         9yvbpiA5/bWYE2aZy3Dj2JcCrKOJNTuyUKjO2HEVNNfD8K173nlyWw38SNNW2/8HBZYG
         zi/g==
X-Forwarded-Encrypted: i=1; AJvYcCUMGYMehytW+sHpMGyNf+cBfN6A60n7NM9Zxv44/uUp/0f7TBj9LjXI1tmX7NYFZNDHBKqNhxBuQo3R2s88qvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHTm4xXn31DBGxLYSXYwIicdwvt8GKYvlZ2cpJb3Q/SN4aJDV
	q+ld8ji+TsJMmS+XHycXhuS21zCnKQP8sFvJaAkzFOGE0kJDnnfwkeheAa8qbDhmu3yFpOiVzaF
	oDnv/2XC2UbK9H54XcQsPZTt7wq78YC0acIftiNMU
X-Gm-Gg: AY/fxX7PPAALc0FXWkSy8b63bOVWZPJzFceQIV69wXVDFndGMietzieqv/Uw0nYU3Cb
	QTJgezxRuqGebCos7QRes3/bDiFzJJEnmtb09QyyKt1MqUXNXvnhUcdyu2Ai51Jpqhu52Ok5nK1
	f4uIcsQAvDC+0SKnrhKVJWNRmT9N1jpkC7eYqWGfzrOS2FdQRpTaVjwgfnYJZWJ+/e9fdOk5Lze
	/l1aloq5ncWFBmW9m5VL/hX+kW5Qceeqt7yKD6/sWIHhwwyoBa0FA99iT6QMSCzeZfMth/f
X-Received: by 2002:a05:622a:1191:b0:4fb:e3b0:aae6 with SMTP id
 d75a77b69052e-4ffc0897ee3mr8604171cf.1.1767881418089; Thu, 08 Jan 2026
 06:10:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-6-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-6-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 8 Jan 2026 14:09:41 +0000
X-Gm-Features: AQt7F2rcFTpAi-WrxH-BJGuce-rrvqsGKbxHYZVaorpjl6SSauHiDAfYA3cghe4
Message-ID: <CA+EHjTznG=6+bYW+mmmBs_QqZ2rXkKTzNxA5KSh3S67H_BBaHg@mail.gmail.com>
Subject: Re: [PATCH v9 06/30] KVM: arm64: Pay attention to FFR parameter in
 SVE save and load
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

On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:
>
> The hypervisor copies of the SVE save and load functions are prototyped
> with third arguments specifying FFR should be accessed but the assembly
> functions overwrite whatever is supplied to unconditionally access FFR.
> Remove this and use the supplied parameter.
>
> This has no effect currently since FFR is always present for SVE but will
> be important for SME.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  arch/arm64/kvm/hyp/fpsimd.S | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
> index e950875e31ce..6e16cbfc5df2 100644
> --- a/arch/arm64/kvm/hyp/fpsimd.S
> +++ b/arch/arm64/kvm/hyp/fpsimd.S
> @@ -21,13 +21,11 @@ SYM_FUNC_START(__fpsimd_restore_state)
>  SYM_FUNC_END(__fpsimd_restore_state)
>
>  SYM_FUNC_START(__sve_restore_state)
> -       mov     x2, #1
>         sve_load 0, x1, x2, 3
>         ret
>  SYM_FUNC_END(__sve_restore_state)
>
>  SYM_FUNC_START(__sve_save_state)
> -       mov     x2, #1
>         sve_save 0, x1, x2, 3
>         ret
>  SYM_FUNC_END(__sve_save_state)
>
> --
> 2.47.3
>

