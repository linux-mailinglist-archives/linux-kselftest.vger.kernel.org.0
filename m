Return-Path: <linux-kselftest+bounces-15634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378EF956997
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 13:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E774E281758
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9D166F11;
	Mon, 19 Aug 2024 11:46:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D5200CD;
	Mon, 19 Aug 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067981; cv=none; b=gGEQSY0Ckh3NNLlCZxyRgz77sEC5EB50H8YQGNWNw56fDmyAaTcXGP43uGJRFZCIEuf6V0o5cjAqbE/E5Qd+0hdNDDzcL65+mZO32Lrcgy6BL8vyouC9nY3PUrTO2DciWhDjlDMKE+hhnKH27cEJniV/2belXsuv5fb6/SMW18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067981; c=relaxed/simple;
	bh=zEv87BYt6wC90sTxda6kAJTqECnwIwmYypAIQB4STro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gneyyNuMBQuFKgihfokeRww84QsvHft1VyZySh9F5OtllBmGi0vROVlwB0YV76DF+17UcCp0fpVbwf8tr3XGmUepoI54PElZbF041VEKS20LdajVdqh45jilaFrylFlVDccChQkphpcN1E4XybHggxzRcG/Ri4++mCa5yuhDaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF1DC32782;
	Mon, 19 Aug 2024 11:46:15 +0000 (UTC)
Date: Mon, 19 Aug 2024 12:46:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 19/40] arm64/gcs: Context switch GCS state for EL0
Message-ID: <ZsMwhdmE_Ai9BbM9@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-19-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-19-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:46PM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 4ae31b7af6c3..5f00cb0da9c3 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
[...]
> +static void gcs_thread_switch(struct task_struct *next)
> +{
> +	if (!system_supports_gcs())
> +		return;
> +
> +	gcs_preserve_current_state();
> +
> +	gcs_set_el0_mode(next);
> +	write_sysreg_s(next->thread.gcspr_el0, SYS_GCSPR_EL0);
> +
> +	/*
> +	 * Ensure that GCS changes are observable by/from other PEs in
> +	 * case of migration.
> +	 */
> +	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
> +		gcsb_dsync();

Could we do the sysreg writing under this 'if' block? If no app is using
GCS (which would be the case for a while), it looks like unnecessary
sysreg accesses.

What's the GCSB DSYNC supposed to do here? The Arm ARM talks about
ordering between GCS memory effects and other memory effects. I haven't
looked at the memory model in detail yet (D11.9.1) but AFAICT it has
nothing to do with the system registers. We'll need this barrier when
ordering is needed between explicit or implicit (e.g. BL) GCS accesses
and the explicit classic memory accesses. Paging comes to mind, so maybe
flush_dcache_page() would need this barrier. ptrace() is another case if
the memory accessed is a GCS page. I can see you added it in other
places, I'll have a look as I go through the rest. But I don't think one
is needed here.

-- 
Catalin

