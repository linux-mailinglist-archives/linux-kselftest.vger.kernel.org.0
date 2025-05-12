Return-Path: <linux-kselftest+bounces-32843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE3AB3525
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6706818870E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4188625CC7D;
	Mon, 12 May 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TsyAOowP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97232255F5C;
	Mon, 12 May 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747046831; cv=none; b=BJDUgZN6TehKcLBOXXslGRLxLWFw8nGitehcStFQNUNGR2UZ5Y777bHHQGMbrbN36xoYikKyfCL7rFqRXM/f/MDWI+bAJueH3T2i1lybEHGTGNsDAqb3WDgJQN0Rw8dUWWMWxAB/I/vNuAe0qQaYfO+VZhO1rU0sEUDnzxJpQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747046831; c=relaxed/simple;
	bh=/rFrybh1O6IKMVdzTuSoLOE4EcbxwXBXr/BK+3YH3BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRNsr60XxHS7nS3gmZc3Jpe3bboo96l9aTe5PT+lQ0a8vyjOZCRk7WpMpxLBf8f5KUBwU/6NuV9qQmLzoVPeRl+NDqmLCGzLFTr0ty/eF5stati9OEJ5hzRjq23w+5EFJ4jeovPJTzCnfkkZh17ES/o4tDJO7jZGuQuGg/wo5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TsyAOowP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 630F140E0241;
	Mon, 12 May 2025 10:46:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MbnzxVTh5zNV; Mon, 12 May 2025 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747046814; bh=ZT4L6wW3svfUqPMnz7jrknf7b4/Jl2ODl132oTnDyKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsyAOowPxcs3IkxdaVogioPfn45IjE2j907OnHpA4leMNhHF7kttE7UgubIfjfsr2
	 MXvQs/uxjuqtVIigWMKW+Wa63kAvVG7DH/pN0RGamUImaZ8EWNVO3U2hWSDyQhWY0w
	 StMwUJ4vIMChqjvnvejwkiIsUBw0wWHnQnHGKIg+FXn6iFs+UZ4JKl/FIa3VHJB9tR
	 tZPHDHAdFeUWcrxuxM3iu/qPK423ZkeU4wxggzWxIz7VuX/1Ki40OdechtNpnkiA6a
	 8v75Mqmyo2dAzon5OyFMneKMBDfdCaLTi0ySUDsroLMHmM9U8eXr9WQEJL9XZBOfku
	 Gb/MwOZaEkroBS3xB9QLlKWmG4ctA1mRwy1B7R44j2yOYpqy3ARTxixsPTpFSANZmn
	 VFjDMNlWqz8GcJKCVVddobSuFeUwBzgHBBB4iXEpfBtWPvN7DzoQwUUjXw/QxWA5jj
	 I2sTxyZ0ZBc48VRqfQn0wTRtmWsYIOH19mj/PsQdiQ8OTS44kiTNQw5prPXMgfbyPL
	 yHarpgpR5hBVXCSIi30Bql2nnxv+CLA6SfwU1RoZB4/Nt5jU2M9c2DFgHb8S64Cs/T
	 5rp8BvQSUHzIBPanwRjOrAWvlIg8VYIrnImORb6BzuSYhbtNzca9T58rNo4Q7dZMii
	 1SAbd+9q233sqSZMi6MfzYK4=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60E9540E023B;
	Mon, 12 May 2025 10:46:48 +0000 (UTC)
Date: Mon, 12 May 2025 12:46:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, seanjc@google.com,
	pbonzini@redhat.com, nikunj@amd.com
Subject: Re: [PATCH v5 2/5] x86/cpufeatures: Add CPUID feature bit for the
 Bus Lock Threshold
Message-ID: <20250512104647.GBaCHRl3nOp83WHZ9v@fat_crate.local>
References: <20250502050346.14274-1-manali.shukla@amd.com>
 <20250502050346.14274-3-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250502050346.14274-3-manali.shukla@amd.com>

On Fri, May 02, 2025 at 05:03:43AM +0000, Manali Shukla wrote:
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
> index e95a8e9ef22b..b51f3ce84032 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -378,6 +378,7 @@
>  #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
>  #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
>  #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
> +#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* Bus lock threshold */
>  #define X86_FEATURE_IDLE_HLT		(15*32+30) /* IDLE HLT intercept */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
> -- 

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

