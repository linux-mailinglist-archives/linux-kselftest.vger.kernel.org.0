Return-Path: <linux-kselftest+bounces-48437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A14CFFDA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 20:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA77316D6AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5D2339875;
	Wed,  7 Jan 2026 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vX1yjyBh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66474339868
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813956; cv=pass; b=fpuFB257uLUqiDe6lz0ops6zDdiqngNYPuDMDIIMM0kRn5TFLrkCpr9pz7OuUD9JWYEaAoXnZW5YxQDWddUzKEVtP9iF5TyJfIQg9Ks/nx+wQotwE0YQy7s/pKnQU0ey/jBPhHdbsSUxGbNdhf9c81XicYC43vlgGd7vP6b4rgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813956; c=relaxed/simple;
	bh=y8s3ifhfbIRmZEac0G5rIHRfhu/0TKZaV0wEbXVBJlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q72zNSmamyCszdam99j9bJajXwmpTPMRYP6TKAAgyUfOyIf57l31TX+ETIoDlduqoY+2zD9T3UxluuOLvrd/JNgD+N/61SXMWKmlWxoXUw1gQGh4dgEDKOsLQAA52pvGSWPQp7Vl0EgbAwKAwpL2vqXOMA2ET2jYPyLAsJHiN9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vX1yjyBh; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee243b98caso481011cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 11:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767813953; cv=none;
        d=google.com; s=arc-20240605;
        b=Y/YWNdobDA8p0pg2EzSP0QCw3x1a/+V8CnQ2KKnOwRq/EE9u2BvJPEhvMJBsFJej8S
         x2QzUU5emriEyXemuOrwdjswkwk1fcytcRYwHDnWN2e01imD157DIqPt56kyZQPVqd62
         3rOxCKAWOYjkTB2CEacD7nBWD07eIvJ8F9/BbI+ysiDF821qe8KN9UxAxWH2YiKl6Ws4
         djk7o/0dhH/f7M+CxW1xaCWRyAh7Rh7yLBsBoLmS9Bd1HJlQqjEwY6t2f5nLRUa2pgEE
         4zZi4lF+OTVvmAgspmnECSnsGnELTApIHAnM+Kmiu6IjVpbMBpkHNOXp8kJYrnB6J3zU
         iQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DwyOUMrzmFja205ZMg1MEdCnMMj8lyhbUqchQTaZ7Og=;
        fh=l/LqJlJdpYmLrmfZ2GpXv8+Vu7cgevMbLLUlEyrGvsg=;
        b=em02qohei031N4bMZytKrjPJ/XB4J8oHPMEunV5H9x8KlV2BfNE35Tp5fc7RL1JUXI
         n7k9SPRnW1ek5dsmc71ScsXbNmDjm0R56PNNRAJiAx6kXLJLhEa337MO2WoS3MzGchXR
         vwjl5LF38L+rpdn7/gmEm0dZTzQu5Rk6skmJ7wq51mzwS0lC3xRqRDuJiLVNdJ26M2oi
         4ejJkvVBkjG6beY1/OqVYpPvDhcnq6SZPHZBy6tqtRmnhq82tCrtzDWzuMyylXKay8lR
         5KaIn21vd1V3/vKG2zwomKeVJGzg38mvgPYpNFAXAIiz3D8l5rXZM1vfV3dcnpAa442x
         qQNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767813953; x=1768418753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwyOUMrzmFja205ZMg1MEdCnMMj8lyhbUqchQTaZ7Og=;
        b=vX1yjyBhmp4CWQ4DaMo8exjlJpva15g3y7A8NIWIfFtzZc0X1a9orno9wSfz+cw3OV
         WNDPy7lGp3OYsX5b2+nd/yizBSFaHc7yHrGOSkQ3olLdVoJsvy7mAsFNCdfmE8P81BSX
         32o3vWMMHtzFj1PYnniArCiMwjmvRFzstZrhXAS+pBtqLh832gytaaIwsMCZej6PUgnI
         r3BxARqmyjA6lP1iFfz8pylBy4pq+YcCeU0DB45P4lHDqwBlFZCeBfpmdRUmYxYvaLc0
         AlYrAzq7PG4R1U9xtApgeNttuusHLanB4wkOynd4RQCGV91+S8n0GJ5pATM/CNIyNSPZ
         LUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767813953; x=1768418753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwyOUMrzmFja205ZMg1MEdCnMMj8lyhbUqchQTaZ7Og=;
        b=XQy0sA0BXvNuo4zsy/RL97JMB/ycMq+Zki/Lf8na26/vMZfMcnlQjUxFCpH5KvXTxM
         2kmti+j4LziK4xLRlzMe8Btq0kQeIr/P8ISHad2dfUFDvII0UUBk8TByZJgRYxf79X+q
         PM29eWYUu+ho71XZDgCRA22WJs4jiGTt4J4nbN4dmldyJ/o1gKn3tbCOskgqoMIBvWwv
         ddS5npw0d6/tcWF6zNZqzU3k3RrLbgnWcT6+paMRBombrExJPuZZdHUvmW0c0clRZPRm
         f1vpqYWiT1rQmHeETwQJoh6huDKUJjDwPo7QAJ6WjjqvZvLT7UchoZht3tehR/iyx+BG
         8dMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4lj8suo9EVw9vD9KjIQzRrYfG9lh7/D545Z4RdiF6MrAENuTbqtsDqkL6g65HnxuLUXFT6R4NgmMURNPplt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4VPdqWRvtwh9BP+xusuHmFDTWlszxBZRUdTtYsA9wZLnZaFk
	xRldybBfr8tJqpPZbBJrErWnSjBaX2SpdNYOHpkCaQKfmuERhVGazkDqp9mSwTODXWz5DyjvYTD
	EA61VUUOP1LvqrC+I1wkN2GNH8HQi7UqKKMtn+109
X-Gm-Gg: AY/fxX6NzeEv1GcjzMUqGe8AY75dot2TqZ4JJVf8qHbeI7bYJpj4MJaLeA+yDKs2Hx5
	cfSlYwy9OkagP1pc+T+GK27DGyOZHfS5TyN31S1ehr78n3RzuNRG0AoWPlADsNJzo2/TWLMo4tB
	1e3g0+H4tvvJdE3QrEBKBDkBx6y2jvOiJ5vAjowVp082JY1LACZ+rzRF3eGCNsCpdzUgFAovZ/B
	2S533+I0khSDa7HYPgN8Bx9Vn6pe/tpk4wPddN7uhhgTTgKeQOJril+PRLp+EF3BIk2WP0hZZPY
	AzyKZBk=
X-Received: by 2002:ac8:5e06:0:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-4ffb3e48178mr14762551cf.14.1767813952742; Wed, 07 Jan 2026
 11:25:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-4-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-4-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Jan 2026 19:25:15 +0000
X-Gm-Features: AQt7F2r6YVCRnMI_bYmOfq7HyyiGhMeA9fZkYBf6xbcFUjdNaJYVtQzKKg3T4fA
Message-ID: <CA+EHjTzDxJsLi315RF43g14psdv44YOuxk6dP6SLgFz4WaY4Hw@mail.gmail.com>
Subject: Re: [PATCH v9 04/30] arm64/fpsimd: Check enable bit for FA64 when
 saving EFI state
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

On Tue, 23 Dec 2025 at 01:21, Mark Brown <broonie@kernel.org> wrote:
>
> Currently when deciding if we need to save FFR when in streaming mode prior
> to EFI calls we check if FA64 is supported by the system. Since KVM guest
> support will mean that FA64 might be enabled and disabled at runtime switch
> to checking if traps for FA64 are enabled in SMCR_EL1 instead.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  arch/arm64/kernel/fpsimd.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 887fce177c92..f4e8cee00198 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1948,6 +1948,11 @@ static bool efi_sm_state;
>   * either doing something wrong or you need to propose some refactoring.
>   */
>
> +static bool fa64_enabled(void)
> +{
> +       return read_sysreg_s(SYS_SMCR_EL1) & SMCR_ELx_FA64;
> +}
> +
>  /*
>   * __efi_fpsimd_begin(): prepare FPSIMD for making an EFI runtime services call
>   */
> @@ -1980,7 +1985,7 @@ void __efi_fpsimd_begin(void)
>                                  * Unless we have FA64 FFR does not
>                                  * exist in streaming mode.
>                                  */
> -                               if (!system_supports_fa64())
> +                               if (!fa64_enabled())
>                                         ffr = !(svcr & SVCR_SM_MASK);
>                         }
>
> @@ -2028,7 +2033,7 @@ void __efi_fpsimd_end(void)
>                                          * Unless we have FA64 FFR does not
>                                          * exist in streaming mode.
>                                          */
> -                                       if (!system_supports_fa64())
> +                                       if (!fa64_enabled())
>                                                 ffr = false;
>                                 }
>                         }
>
> --
> 2.47.3
>

