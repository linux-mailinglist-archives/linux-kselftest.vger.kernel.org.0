Return-Path: <linux-kselftest+bounces-10767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB3F8D156F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 09:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE5E1F21785
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960E7316E;
	Tue, 28 May 2024 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CVQ1GlzN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E52629C;
	Tue, 28 May 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882160; cv=none; b=IfOx6WxC7KKwUUrMObt3Lcb6+jkrw/sh195UhslPaxKtZ/SgjwoeK7+Srj9Pkl1mbGoNUazD8Xp4SdzvPZWOv5810A/OeekoFGoqB6xqM1yVaSNznTqJmDuSqc5vVq7CLHIbvaGYYNi+A6nc+DAaq0HcJUkl4jIxqsDKub+WSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882160; c=relaxed/simple;
	bh=O+SJh11x24oVG0LRa1hpJ0RJyBL1icWzCjOnJC5jTD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSBRhTtuu41U2XXa3G4bxPiuInhZ4/cc5j3mKD1jOBxtyJfvFDCZh3TphQ8JDYD3QXcKclZDC8rqY4rZo/8oIhku7HOaogixCLGQpm54SGCwINDxCywl2zFpna8vZP/vxw+xTTJQLtvVCfi5QuG5gOmhZd1ZPlkMiOCbWlQpErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CVQ1GlzN reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D957A40E0244;
	Tue, 28 May 2024 07:42:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id N3d_IMW0tLtI; Tue, 28 May 2024 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716882151; bh=iTw1v9mA7GB/WhSSmXpBEKADLAPXWnBE1YHmBrlKZ5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVQ1GlzNJvxMahfCNH1om6Qk5OdDgB+W2fMOljjk2OvkHyhnUSnGsHWYpdvHc8SmA
	 BOXLOrteKLMiV/9T4Hlx+suwDYknpGIv/IDvNQWDPFrBe/Ru/EudjlxZax37++bABY
	 m55ustNO+tel9oiHyp9Z/UH5Cv99tceGSPWuyoRmHfU/v3Ud2J0M8ZxIX/K6Avt0g2
	 FtS4YEHWUs3L9t6WkUOqntPBvnU9FMnNfS6RMvrsRDEiwUv9+IgNpwnspUOqrm588p
	 sc0Lwu6LjgR/CVUGSKW7QlFjgrT5MS9nLloJ0BMG12aOMWUBXMNMs+wLfzQgHJd/3D
	 Eifm52fYW7ciqwjt2owPMuObwAPHZF1B7O1x0eP+mAjla9cib/uOJ+wT74u85MVo2n
	 nlr0Rx6v3WaPn0JKm6WRdb7CmeE5e0Mj8dQ99QlXCAI4xx81BGLsKUTnEDAM+YekeB
	 zAZdwxXEYp86K9W5IG/9+BJcuwtEKdA+v7NaIETq0STpcrcwoNgyLn40udTi1R1hiA
	 P/KSCZkRG6BsO99TZhBX6+JXJFvkKWxtdITfCCkPMrN7t/8nEJmQOwMtufcPtwizKb
	 pZDoN4Lry7XgmYhRTRnWI6Ef7QjU0HjclfGjmC4lKxeYHpIKwvUnYfg5894FeEwSRM
	 tDYpycYOcEDfkdu4CL7DUVcw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D544B40E01E8;
	Tue, 28 May 2024 07:42:20 +0000 (UTC)
Date: Tue, 28 May 2024 09:42:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org,
	nikunj@amd.com, thomas.lendacky@amd.com, vkuznets@redhat.com,
	ajones@ventanamicro.com
Subject: Re: [PATCH v3 1/5] x86/cpufeatures: Add CPUID feature bit for Idle
 HLT intercept
Message-ID: <20240528074214.GBZlWK1gslLYbBSkX0@fat_crate.local>
References: <20240528041926.3989-1-manali.shukla@amd.com>
 <20240528041926.3989-2-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528041926.3989-2-manali.shukla@amd.com>
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 04:19:22AM +0000, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
>=20
> The Idle HLT Intercept feature allows for the HLT instruction execution
> by a vCPU to be intercepted by the hypervisor only if there are no
> pending events (V_INTR and V_NMI) for the vCPU. When the vCPU is
> expected to service the pending events (V_INTR and V_NMI), the Idle HLT
> intercept won=E2=80=99t trigger. The feature allows the hypervisor to d=
etermine
> if the vCPU is idle and reduces wasteful VMEXITs.
>=20
> Presence of Idle HLT intercept feature for guests is indicated via CPUI=
D
> function 0x8000000A_EDX[30].
>=20
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> index a38f8f9ba657..a8c5dec042dc 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -381,6 +381,7 @@
>  #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
>  #define X86_FEATURE_VNMI		(15*32+25) /* Virtual NMI */
>  #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
> +#define X86_FEATURE_IDLE_HLT		(15*32+30) /* "" IDLE HLT intercept */
> =20
>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16=
 */
>  #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* AVX512 Vector Bit Manipu=
lation instructions*/
>=20
> base-commit: d91a9cc16417b8247213a0144a1f0fd61dc855dd
> --=20

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

