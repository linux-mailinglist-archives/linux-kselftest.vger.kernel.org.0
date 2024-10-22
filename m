Return-Path: <linux-kselftest+bounces-20375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC679A9E8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 11:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90BDB22715
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F3A154C19;
	Tue, 22 Oct 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fH2SpGPp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495B12D75C;
	Tue, 22 Oct 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589590; cv=none; b=paA1ucSVky89sfyjpV+421/Ev2cfDruw0r+fbPht0BxnZmaJ0uIqpJYB1FOMGHDTO4xjyJYq2YkNiqbMoL7Oeo/3cZimsapnAMuaUYt/wDtI+w3a/3kV1x0hRrdPGs7L0pBW/d9/hScXWIJJzueBpTwp+I9bWai1kAE0IqSnOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589590; c=relaxed/simple;
	bh=mtBUN9O6XwNgU6hepxjh0Fx8PkgjIAjfIprd/U9o5+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rymxx0Gx4cnqFDvekCXhCLaSKejzb39+ZiTb39pg+V123+hxchhVuTilp1APqVIYmRwTH7ofLBm/X1OIRAl2MaUxgsJk00Nm8ISjPKAvpHmR5vi4GS9ITsWjtn0JmeAKEjCEpKQizL0+XMIPhpAdS9/mg1mtnTal7vjMCJbzH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fH2SpGPp reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 422B440E01A5;
	Tue, 22 Oct 2024 09:32:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ANcwB4Fk7Jbm; Tue, 22 Oct 2024 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729589572; bh=SH+rPM7WUYQemldaYJuuNTQyZ/vEN4oDTFLL1xY0pXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fH2SpGPpQ3Z0ynfqyrm5xcO2/+LM65BHRTAFGA7zo+dkpb4s5C0KdtWaW2vCpcUS/
	 4Nubi1BdnZFPVQPQbH3RhzoBto7/PGtNy5BqQICRgJC94MMeHj6Tbfjwbh3C602tdA
	 HnzL7+Ld10SgfpAlGAxJyEnaMNJydwH+gASMR8Fmb3tW1N4mbHVzt2RFboPsb3MnVp
	 HVSexQrc9QfI36iDT/Y5pbi9KAhHGBPxkH0QS7Op2jYhJ0IZH7I1mVwam55pQqSVXL
	 F93KyiQhLo/Puja2TYb4X3ciekfPdpKkFR1q8PS1p0xFb9IYGR93iAjjqifv22tt2K
	 4v7WGy8fADbdnPKjA+iQfFVceCse1q3GJFOFHv9z6PB1qEC8inOy2FazDmrgmcgSRC
	 0CTV9/UjY05IhNO3W9omvr9wZnhiFL08i81vHX6gatpvuvR20RKpKRuUqlix2A5x2Y
	 AEGTV8NXZ2DCdYUswUC42BBWMmrh+u2pnn2jDLBNkFL6t1v7l8Qte9/zfw0Ev2rgkF
	 3sx0tYTld+c01gcrK73OWnk5xtJ8LgmgW1J1fjcsB1T4eVNMCzo4ScP7zGY2coClwD
	 4b+UxMGLZIu7bw94hwbC5La1UdyZaX5YBQrAPdxYhXewv3ZeBR7dNqUH6NsEJvK2cS
	 SIzzoieOXvPSkASp0Ton2S+0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 986C440E015F;
	Tue, 22 Oct 2024 09:32:42 +0000 (UTC)
Date: Tue, 22 Oct 2024 11:32:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org,
	nikunj@amd.com, thomas.lendacky@amd.com, vkuznets@redhat.com,
	babu.moger@amd.com
Subject: Re: [PATCH v4 1/4] x86/cpufeatures: Add CPUID feature bit for Idle
 HLT intercept
Message-ID: <20241022093236.GAZxdxNCTki88ttFmy@fat_crate.local>
References: <20241022054810.23369-1-manali.shukla@amd.com>
 <20241022054810.23369-2-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022054810.23369-2-manali.shukla@amd.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 05:48:07AM +0000, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
>=20
> The Idle HLT Intercept feature allows for the HLT instruction
> execution by a vCPU to be intercepted by the hypervisor only if there
> are no pending events (V_INTR and V_NMI) for the vCPU. When the vCPU
> is expected to service the pending events (V_INTR and V_NMI), the Idle
> HLT intercept won=E2=80=99t trigger. The feature allows the hypervisor =
to
> determine if the vCPU is idle and reduces wasteful VMEXITs.
>=20
> In addition to the aforementioned use case, the Idle HLT intercept
> feature is also used for enlightened guests who aim to securely manage
> events without the hypervisor=E2=80=99s awareness. If a HLT occurs whil=
e
> a virtual event is pending and the hypervisor is unaware of this
> pending event (as could be the case with enlightened guests), the
> absence of the Idle HLT intercept feature could result in a vCPU being
> suspended indefinitely.
>=20
> Presence of Idle HLT intercept feature for guests is indicated via CPUI=
D
> function 0x8000000A_EDX[30].
>=20
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> index dd4682857c12..7461a49e1045 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -382,6 +382,7 @@
>  #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual S=
PEC_CTRL */
>  #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
>  #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
> +#define X86_FEATURE_IDLE_HLT		(15*32+30) /* "" IDLE HLT intercept */

Whoever commits this, you can remove the "" in the comment now as they're=
 not
needed anymore.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

