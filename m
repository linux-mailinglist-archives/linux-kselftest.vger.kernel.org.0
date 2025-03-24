Return-Path: <linux-kselftest+bounces-29708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C94A6E620
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68313B8191
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6CB1EEA51;
	Mon, 24 Mar 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M70jOz05"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4B1EEA2A;
	Mon, 24 Mar 2025 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853444; cv=none; b=fUghngNvLrR21rNYcoCBXm9wdME3WVe+CdX4D4Ak4RVqS0dfLRE4zsZ+2c7k7gQ0/kSuODkQ6m5RxK0Bvd5ghjL7dZijmSwWXLdzp5RpucveTcKLyh+dJSaa/boGNELuIF0KIllZWi4s2LrIE7o+d8+OqQtpUwrGu4DfC3VrW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853444; c=relaxed/simple;
	bh=SPw06WaF7rAuJ6aypE9uvb+Zn80ypUHUMBRGQVwLkn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgbxFasiFuQMiXOfFy0T1eaI3re9FRa5kAS1AGHMoWiip/qK7+ZMdfc3HCFGos7O67B2+gWGLqkc3ZPaZXnGwsSb9yaGL3AOGVWN+Avl3ATu0RR40Zy4uHYuYAVAwXesuzMobUD9pvMFceiuSzhDTi12WAG84rEExQJ9VBoVsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M70jOz05; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3E05E40E0219;
	Mon, 24 Mar 2025 21:57:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id toGJVVVrRmwC; Mon, 24 Mar 2025 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742853400; bh=PqOq/bs/ShUnBEJSSwXFeQKMcq0JM4RJNBR/Xkr968Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M70jOz05RWbj0VYesoWVq+3GW7RGGcAnG9Gqjsi4E9Ih7yhnevhWtRg5ZXAffG9HB
	 0BoRcf6+l/0npwJppnE3jvYE8TJDiQHnM8yoXNij1w/IXy5lPnTkhkfCJUlnbDnmtF
	 8jED8UyPCuE7r3+tT3XW+iiq2b2qhTcyz3kXtjCM1N43Yn/vmcF1D6UjLHwlQuSjW8
	 DXnETklpCGzWiIXmPPlvueFfqojoPXflsx0RkArljgj3H2UdmdBaxMdSnUmrpZ95T9
	 qnTKakMn82JMAaY2HbHrVLVIo3NRF416j0wJ6CJvTfRA6ykyDkK2nyaf8vCIehh3Zn
	 EM4UmU6ICVSQ2LBH3JDGzlz6rym6X0dRIKec41oUmdPkifAjlOHV3KdbB7jM4EGZ44
	 uVB7LM5fMPmdbxPbH22LXG9i8a7Mwk4X5MFrRFoN70ruAQb1+a5MH0rV3HaD8D2On/
	 ubqQW+Sajwk9KIGtwpwzE8klR1g/K5eO0xNVViCSsjX/8IqOfNrdD/+oYSqS6RuqCS
	 dNJ+wmvFzdy8ihXKtx1QbFQ1L8FkWO/M6wzm0TqTqnyPhpCC+tg8OnwUkk2VHZJ7qG
	 A+vPovK4HTVXAVaRc3nDfL4xfjeHH84uvDlbVp7B76W2rVJHayKgimrqef4L1lnPy1
	 zkfE5qt0OiBVz8cbl847yadM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40CFB40E023E;
	Mon, 24 Mar 2025 21:56:33 +0000 (UTC)
Date: Mon, 24 Mar 2025 22:56:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, seanjc@google.com,
	pbonzini@redhat.com, nikunj@amd.com, thomas.lendacky@amd.com
Subject: Re: [PATCH v4 2/5] x86/cpufeatures: Add CPUID feature bit for the
 Bus Lock Threshold
Message-ID: <20250324215627.GBZ-HVC-KmZiTMxPr3@fat_crate.local>
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-3-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324130248.126036-3-manali.shukla@amd.com>

On Mon, Mar 24, 2025 at 01:02:45PM +0000, Manali Shukla wrote:
> Misbehaving guests can cause bus locks to degrade the performance of
> the system. The Bus Lock Threshold feature can be used to address this
> issue by providing capability to the hypervisor to limit guest's
> ability to generate bus lock, thereby preventing system slowdown due
> to performance penalities.
> 
> When the Bus Lock Threshold feature is enabled, the processor checks
> the bus lock threshold count before executing the buslock and decides
> whether to trigger bus lock exit or not.
> 
> The value of the bus lock threshold count '0' generates bus lock
> exits, and if the value is greater than '0', the bus lock is executed
> successfully and the bus lock threshold count is decremented.
> 
> Presence of the Bus Lock threshold feature is indicated via CPUID
> function 0x8000000A_EDX[29].
> 
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 8f8aaf94dc00..a3ab8d1f5c17 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -386,6 +386,7 @@
>  #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
>  #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
>  #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
> +#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "buslock" Bus lock threshold */
							      ^^^^^^^^^

Please read this before you do stuff like that:

Documentation/arch/x86/cpuinfo.rst

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

