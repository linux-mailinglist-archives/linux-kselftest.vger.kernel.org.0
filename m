Return-Path: <linux-kselftest+bounces-48434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7454CFFE1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 20:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 602B330EA2E5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776273328EA;
	Wed,  7 Jan 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="md6V+HBO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E930274D
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813933; cv=pass; b=ApvWL1pcIP3QHEa93mi0Vi4ozY1nen3BSZkbc+4eLu3xLd+VbAAChA0Ip6HQBYAXVE9kzTOVPLb7kBDk7X4d9J6rnvilXo7oSYcN9khG1rp3mQPNCQiji5jhghbJ9SG+g06gLquWC2YQgoB7KxWcD2qdAqwC52Z9GFSw2HZkLJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813933; c=relaxed/simple;
	bh=z8fphxS7A/1Qur4z0EwbQJFYY7ZrGXkIomdruCTWhiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnAIbuNvEUvGtSW1E3z0lmZCKi0hoj6JLJQZ7K8ErfUbFw0lEcgFJwp3kLjc2zBokh2AUax7GWdR7g8GmC4IzjZyMiU2+0o2RFdRCIUksXHqV2DbXiApfqKq5r7FLbjL+rl+p4DK6JzLB0I1nbF+6Bg/drKzRtamOeBPz3L4tB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=md6V+HBO; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee147baf7bso575701cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 11:25:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767813930; cv=none;
        d=google.com; s=arc-20240605;
        b=Oa85ZTBotb9N6o23JAcp5xO+UIrYxQ2RdjBX4ydHOiNB7dTiZLURA7AGnM4qdkzc1G
         ol76Vk6uT37hQGUaAWaRdzKy03OVgXu2eBDqmqbOYHP3/EbV9+IX4Fic9/35EbzbqEuK
         aLBXgOihaW7GIVC/OT+BClD6aWmm4wz/qnFrtsy1WIsC51RF1UvT3MRxMQn9H2p9b3mM
         mj5WoWS1uTcXsmSvyPBi12Dqx8hgizo79eL6Ljr7b3vz8uMGgq1RcqBKKwvx1UkVRf9K
         6QxNVMJo0KMbOvAvQi1YAnBBle1h+3PEk/cWQbFjEKfOntpW16/s3OLXSmZ5TDeK4Ujp
         bk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sdQze0tFMfdCcZRE+Fz1xsHkvoih7BkzLiCp0crO/Bc=;
        fh=7ry5S5T/vIfIW85Y4z8Bzu+O5UW6433mk6ZfdY2TN5E=;
        b=fbYdrQLh1JILLYn0EejAn11WzwKzIlS38y1HtJ3O3Ng7SdMIypyob+pjk8dQ+6ITho
         k834YjvvZ+4M5HY6nH/VgJ2hG3fRaES2H/XY2+/3nGVFZqi1vfR1IYFLNHdA9u6L1WA4
         oCC6NRAPr75DrJWLFfFaPvDtLW/5UPGRG2q8UXpRVZZpAXni2DjL6b6JiRx1dtI60oAq
         k3/tvihBsh1kbrYfJ8nBQCXg5FHcq19XqX+pvMuDD4J1suiFDkNdUM2p3ihV8IHY2GRl
         YwZqnuBDfxBi+G7EIunZADHzvYoj8sNh5VBlXPqZ8HRVsR156O5Lbt9RYqSFo4dcD1qw
         5ADw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767813930; x=1768418730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sdQze0tFMfdCcZRE+Fz1xsHkvoih7BkzLiCp0crO/Bc=;
        b=md6V+HBOPniNT9Y/pRAoZBDQhjcszlVdyKa+xECql/xfCKUBkHI49FBoMgYD9STLgV
         iP9h5KoAv32fDrbf2kHOGhvP4wcYPWZz/g8dZYgqMD8Wi/3mOyNWmEdY+9BXlIhq1nPL
         4Aukl4E3l3MU9V8jR5URmnHstzKmTxFvYCRMr3LjNxJE0B5P79uX8SVYW172m3lM7alB
         Zu9y0e+RkvL/j7jJGpaUUe/k5O6mQBGWO8I4t6Mba6z4kTmiXWQCkLsOm1dvOo0s6Ocp
         JjRIHshv4SJjpToVrA7dNTGHU8xBkuEdUPGw3GAz8P8Earvyydb0ZXriMqCSk1VlnRZB
         v/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767813930; x=1768418730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdQze0tFMfdCcZRE+Fz1xsHkvoih7BkzLiCp0crO/Bc=;
        b=gDsNjhmyYEm0ktkrlwQvXMNRgNaWDA+2Ezt1a2sdtIuPAQsEel4ka8YdohmpD7Nzm9
         n6pa28UjjNI9/CpqErago290hWR/MMp/D8erplXLsEcEKPfGpOntIrTEvLcHWCN02JWd
         Egxz4on946lR7Gd3OzF22NICADixSEO/1Dlr2sZvxkJBpIbrf2vBiskNg2+4ChI+2y48
         G6ux+RGjy0HbR4QwZ5FP49dvrdGr8v8YDTxUrUlOMhpIUyDNZ2ryWceQ+cButvYPCHvW
         TFXpYM+RS8rFIwes8piTHkvV0HfrtFsbtswJqGXhjgUyo8hXEvzhyNjPjVJ6o6zkklEv
         +AnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfcQYnmEJJpcytZEEwMesy8XE8UaovEp1CHv7tAcTuZc5sDfnrbtOa5B4CXCsDaAomdsPH9HYziPaeMoT4d0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9R+AtZ6UBfutu+QvBx8A+bxB4SUCcdgiEQ3NdAyHRAhoYlhmC
	pZ/l/4g4J8/3O01WrKztu5JDdNnqzQB6y9OPOxp6MTI6bUBjPq6FV/GlbKbSOqEO+6slfxnl0DQ
	xDqd6ewfvjlJpiChnRFt0jqrORexvhkIMx7j/7EC6
X-Gm-Gg: AY/fxX6YZ6koPyRA5Ve5WDXCag6aRbYb00j1LLRCTHTlw59kuLddIuOYP6MMLSn3WYT
	ohdzjngCQSlRKaPheF4edgWxGlm4FrlBeAHAFPFuufV/g2LENZLQsrliZ5SH+TSP/BzTm7572g7
	Rz4z2U1dLZZfL7vs5aKlVwEzNZe8faKUSLSUSWjDphu3vgE1jU/e9Hwwke1wK2Fd2La3y6djuB/
	GJny+2m5EIpGIER85qmDCzF5n3MLU/QT2Bd4MbQKGNVD/XyQ6PrIVDDrrj8Xelvfakanbsj
X-Received: by 2002:a05:622a:5cc:b0:4ff:7d0c:c1cf with SMTP id
 d75a77b69052e-4ffb3aa6b6bmr15709851cf.0.1767813929956; Wed, 07 Jan 2026
 11:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-1-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-1-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Jan 2026 19:24:52 +0000
X-Gm-Features: AQt7F2osm9O_NLuokFKY_-m1ya4_XJF8FlJHLjM1yNQTzxjP3vc84G0MiN9eNTY
Message-ID: <CA+EHjTwsX9+3XZBZo8PHvaP24fVxBKSdg_raJGL46nX5hE-4rA@mail.gmail.com>
Subject: Re: [PATCH v9 01/30] arm64/sysreg: Update SMIDR_EL1 to DDI0601 2025-06
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
> Update the definiton of SMIDR_EL1 in the sysreg definition to reflect the

nit: definiton->definition

> information in DD0601 2025-06. This includes somewhat more generic ways of
> describing the sharing of SMCUs, more information on supported priorities
> and provides additional resolution for describing affinity groups.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

It matches the spec.

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad



> ---
>  arch/arm64/tools/sysreg | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 8921b51866d6..6bf143bfe57c 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -3660,11 +3660,15 @@ Field   3:0     BS
>  EndSysreg
>
>  Sysreg SMIDR_EL1       3       1       0       0       6
> -Res0   63:32
> +Res0   63:60
> +Field  59:56   NSMC
> +Field  55:52   HIP
> +Field  51:32   AFFINITY2
>  Field  31:24   IMPLEMENTER
>  Field  23:16   REVISION
>  Field  15      SMPS
> -Res0   14:12
> +Field  14:13   SH
> +Res0   12
>  Field  11:0    AFFINITY
>  EndSysreg
>
>
> --
> 2.47.3
>

