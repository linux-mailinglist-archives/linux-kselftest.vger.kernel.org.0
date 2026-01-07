Return-Path: <linux-kselftest+bounces-48438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC89CFFC21
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 20:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8094830052D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4A333431;
	Wed,  7 Jan 2026 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKqTNx/d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F287331A44
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813987; cv=pass; b=DF4a5ALGd6QwD+rfjcQTmq/BKAkftgQzORQr314TKv0kYFiiRZVj8a5kuR7ngkua48NlM5+YFUwjRzuKDSrTeHvFSF/uVh9lRyfmfriabsCpwftjWCPenbKpq3IyHQ06CdteYZ1uluJA1Zsui+Z7PzIjhQc6Nj3Wsd7cDz3BrH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813987; c=relaxed/simple;
	bh=2LhpsPeSyE8bX8HA6xDr9D/rfFVNInchGx8D0QTzubs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUpOYeM/xt2VVeuZRZ8rUxKlrZEpNKySMq7fGmkueiyw+aHQdZyOLEgrJr4XjLyACBvzut154nD0NOPaldyyI1W64n19cktKt2iiasJ72uH87ZrkRhClAmcajFdtsokE1+6xesvNrDCHOBEov7nj/+pm75kRZV+qKGXhrkdTZlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKqTNx/d; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edb8d6e98aso720451cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 11:26:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767813984; cv=none;
        d=google.com; s=arc-20240605;
        b=bnOua7812etd/BQJd5S7kV0WvpAp64ejLW+OEtO9CKI0+UyCBQKHsByxDDkXbLDxKs
         6GsqYQb05sx6KUZvzEOkC9bfzDWDG2qUIMN6aiK7emWiQ34PnIMl1KiKP/6AXv3qdR5i
         t9alxC+vOqtGIIxjfzYBUiHbmfNBQg34m41E/xmzGc2EuYzDU272o9TDRDeNoT+ITZiU
         Xx+H6w1nmoyH1v6MUv9OgXke6bfAp34v2CIB1zjshNPaYpwvagjH5NZ50jbRueuM+v1i
         9P3ZQSQzIXsqKhKwdLffZLQNLlDU+U2LedXWUPjc80hdhQjWH0V2sPyWuBoVfq/J/X4p
         x7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bWQBkRucMfj+8IZule2bckxNws/YyczMOLNESP4WNJk=;
        fh=9im28Xpf7byW1l9zhfepaISpwiQ875ulQCnktNnSfFU=;
        b=kkp4SSs4aOhgow57ldMW3HT+Gm/eVYimsQQSJeg/IW3O3K7siezAGGSkXwUIV5ZKCl
         csoMS/dlBe1AAluQlnCBWCBbOkJHyz9SFLiqXMJXmpdPTIVR8rXqU434MkagYOluQfaH
         vxZgSTX5fZ2NEQ44slHR/opQcz7K+OZzOYceU0NpMlxA3puXEaSvXxAIT5ZBlCx+k4Kj
         4xjanXdDu/VHjavT6byHEw3wWR6mwFpUE0f1s2RyUlqRZc6o4lcpIQKThgA+DTMjfFoR
         cHD51VUl9fYuNAZT7WwbFTnmbdE1xadtbhgOAek7oRzMQlOH18lw99nPMMPqwNMAZ2t7
         N8mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767813984; x=1768418784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWQBkRucMfj+8IZule2bckxNws/YyczMOLNESP4WNJk=;
        b=BKqTNx/dRzg0zFWE+h3P30e/ZQqpYPrHRtHwoRfzxIAMhrBgKBcjzdydRIWKSg7SsE
         gtx/suaYozcBSsVPh/jsxJ8K4yYllQM04FpNTciw4x9uqYOPxzU4DagpLhl+AuOCVb6V
         n6vKWwcYnNdh/C/rtKnDVvRWHGhHqg4vk9NxYrAocwehf/0+1Jg7E05p1dt2alT3f5Se
         xY0Dd9X/odEq6muhhXAtLUZDliohR0oXSgivre+tCIuLte29h6eVCTefIOxnLpL68/jj
         hl1Elt21T+wHa26chyGvc5W/2or0/a+CTq8udA1rc+POmXxWfMzFQqmLa38dIxuob25S
         uJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767813984; x=1768418784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWQBkRucMfj+8IZule2bckxNws/YyczMOLNESP4WNJk=;
        b=C02c8o/gpB9aFM4AUgQcRvQiMXI0ysdABMyJOQtPcCtoOH9WEfi1yb6E6rAGeYjQp9
         BXjG7SjXH2x4KmcGYky1gnSXxkERFZXRC1fTZV8MsJCRFi20jCykJgM2TySZv/5VGTc0
         MP6H5gbXKTCcChCWUZlVfJNbdVDWU6il+7bIi5By8FMGaRAW6UxRuFxCVeS5CIUsZsE+
         jzwjiHaT20A4llpzZx/QlsVdCrOsV1kqJeppUQ79jYu1u0TiNp6yCMxTaFSf40JxyyTk
         83NV07GomJ2uaZRLZ+cnExaEtEjcjR/RScF26qewF3HHj3eQ/zbZ2cJvwn+7V05NPGxt
         azOA==
X-Forwarded-Encrypted: i=1; AJvYcCXcYK6NTa5Awa955qJvnc+benojsL3DGnFLRGW+3iuc4dzwwaDqKakCOHURiFekqhsorjgArMiF8VeejYTfAJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0d2LRYvyJoINtjtJ0QSR72mHVSoZWZqpXv5TNuW6d3IFOUFQ
	gc9b7UzUjLcbAbFuLuwVS7FldRQnGNAvqK12V5zpz24S9xlLVSPC9IuhOUtWTAp3hQJxxlmY95B
	lZ1isXL97nSrDFK4hIQ3lKeCuvWdjefOT8PE254d5
X-Gm-Gg: AY/fxX409U9v90wSItnMI6K/6kQRBXg15v3OfFzTXfjEOTuoxvkKeKuhjRT9Z83is3C
	Tv3HjiLaLH6x5euyDaeIdeTr8Z2PBlSfQNvZ/9oISXYdLITGQd1FkaJ/u349IWsDuKr/MzGWES3
	vS04+9NuEIO3Qkr/GrTu1arZH3humcUTPlV8pGBJGipeaYKqn3ZXFm2GeNrCB+xH4EgxiolxrRR
	JuireOvZEvKrBAM259Al61/8cQy5Pf3I99ZaDG2Ncg/eWvFgmS9pZcTAi8r80cvbzl3KsSS
X-Received: by 2002:ac8:7d0a:0:b0:4ed:ff77:1a87 with SMTP id
 d75a77b69052e-4ffbf94a082mr1122261cf.19.1767813983752; Wed, 07 Jan 2026
 11:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-5-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-5-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Jan 2026 19:25:47 +0000
X-Gm-Features: AQt7F2qO0uzZBb7qE9TqF-7WKMNBoVsC6m-23DUQhmoLKw26Bq83cmx6SM9OSu4
Message-ID: <CA+EHjTycP4Wz0V7S8hzWygpeXGzeehTL8RFfit7Eaq4rT+Eu+Q@mail.gmail.com>
Subject: Re: [PATCH v9 05/30] arm64/fpsimd: Determine maximum virtualisable
 SME vector length
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

Hi Mark,

On Tue, 23 Dec 2025 at 01:21, Mark Brown <broonie@kernel.org> wrote:
>
> As with SVE we can only virtualise SME vector lengths that are supported by
> all CPUs in the system, implement similar checks to those for SVE. Since
> unlike SVE there are no specific vector lengths that are architecturally
> required the handling is subtly different, we report a system where this
> happens with a maximum vector length of -1.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/fpsimd.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index f4e8cee00198..22f8397c67f0 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1257,7 +1257,8 @@ void cpu_enable_sme(const struct arm64_cpu_capabilities *__always_unused p)
>  void __init sme_setup(void)
>  {
>         struct vl_info *info = &vl_info[ARM64_VEC_SME];
> -       int min_bit, max_bit;
> +       DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
> +       int min_bit, max_bit, b;
>
>         if (!system_supports_sme())
>                 return;
> @@ -1288,12 +1289,32 @@ void __init sme_setup(void)
>          */
>         set_sme_default_vl(find_supported_vector_length(ARM64_VEC_SME, 32));
>
> +       bitmap_andnot(tmp_map, info->vq_partial_map, info->vq_map,
> +                     SVE_VQ_MAX);
> +
> +       b = find_last_bit(tmp_map, SVE_VQ_MAX);
> +       if (b >= SVE_VQ_MAX)
> +               /* All VLs virtualisable */
> +               info->max_virtualisable_vl = SVE_VQ_MAX;
> +       else if (b == SVE_VQ_MAX - 1)
> +               /* No virtualisable VLs */
> +               info->max_virtualisable_vl = -1;

I'm not sure about -1 as the "No virtualisable VLs" value. Unless I've
missed something, this value gets used without being checked,
potentially even assigned to an unsigned int:

> kvm_max_vl[ARM64_VEC_SME] = sme_max_virtualisable_vl();

Cheers,
/fuad


> +       else
> +               info->max_virtualisable_vl = sve_vl_from_vq(__bit_to_vq(b +  1));
> +
> +       if (info->max_virtualisable_vl > info->max_vl)
> +               info->max_virtualisable_vl = info->max_vl;
> +
>         pr_info("SME: minimum available vector length %u bytes per vector\n",
>                 info->min_vl);
>         pr_info("SME: maximum available vector length %u bytes per vector\n",
>                 info->max_vl);
>         pr_info("SME: default vector length %u bytes per vector\n",
>                 get_sme_default_vl());
> +
> +       /* KVM decides whether to support mismatched systems. Just warn here: */
> +       if (info->max_virtualisable_vl < info->max_vl)
> +               pr_warn("SME: unvirtualisable vector lengths present\n");
>  }
>
>  void sme_suspend_exit(void)
>
> --
> 2.47.3
>

