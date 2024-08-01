Return-Path: <linux-kselftest+bounces-14666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE594510A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE04289419
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867211B3F24;
	Thu,  1 Aug 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KscuT4xq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363D1B151B;
	Thu,  1 Aug 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530752; cv=none; b=AQ9x3S1GWiMQSQs+hOXX9xD0rGlQGNTon+MNyZu/KzclMR1sVTqCm2kwrDpI7eoSi4zXLK3+l554YWxfYuWZoWC9wMfarzTj9ewNPaiaSu+UeEyqmpMTJLQt+jVGXu4mT73r4Ex5fa8np2OYERRyyM02lS9bhNIoGVuFtBQJokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530752; c=relaxed/simple;
	bh=9K8/1ZKy51T9Ax3Xh2WIgRnxkcihHgffb1DNF0IENQQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1sXNHunNnXwp1dT1UFkXW1u36cNg8HIYWNmcb68TaECTolVBscpaqycRo8smEolAXBCnQf9hSwYTptB3SBRJzQnAyJmR4TNZs96B/nixdrqhIvbH3QAbwuxGOP75U43g2nOtC+F/+d1UBP8OdzPJok/86tFViFYrRR6WbD2cX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KscuT4xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB49EC32786;
	Thu,  1 Aug 2024 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530751;
	bh=9K8/1ZKy51T9Ax3Xh2WIgRnxkcihHgffb1DNF0IENQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KscuT4xqJXdHZXNNabFmnRhf9Y+fGFdNBEfaZHinesb/+F44xEIOj28bdj+DHMD7O
	 qegrmkvL4KFgE4UK/dVJvnqeg8awqUImJbw0dXGzbkqTlcWWnqodHRwH61q5TcOhy4
	 pS4B/RFonxyvQ/Kw0tbWXc8twvOZLF5+YL27DxUe6ugYEZN280C/ZN7851On1DNpU+
	 KxrkszkzkoCf9DCCsjAEZXc0kxOUjaoyg3gGtFAS4j/Voe0gMqJgXPl1JmBQaZMh7J
	 tIRiyVdns9GVeGnuJIa3AG/splbo8jObmHDdRWTEHFx2b5IHRINuVw2YmkcKRQ3ohW
	 pP6fqmGeqt7Jg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sZYw1-00HTHq-IK;
	Thu, 01 Aug 2024 17:45:49 +0100
Date: Thu, 01 Aug 2024 17:45:49 +0100
Message-ID: <86le1g19aa.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: arm64: Correct feature test for S1PIE in get-reg-list
In-Reply-To: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
References: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.3
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, pbonzini@redhat.com, shuah@kernel.org, catalin.marinas@arm.com, joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 31 Jul 2024 17:21:13 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> The ID register for S1PIE is ID_AA64MMFR3_EL1.S1PIE which is bits 11:8 but
> get-reg-list uses a shift of 4, checking SCTLRX instead. Use a shift of 8
> instead.
> 
> Fixes: 5f0419a0083b ("KVM: selftests: get-reg-list: add Permission Indirection registers")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/kvm/aarch64/get-reg-list.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> index 709d7d721760..4abebde78187 100644
> --- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> @@ -32,13 +32,13 @@ static struct feature_id_reg feat_id_regs[] = {
>  	{
>  		ARM64_SYS_REG(3, 0, 10, 2, 2),	/* PIRE0_EL1 */
>  		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
> -		4,
> +		8,
>  		1
>  	},
>  	{
>  		ARM64_SYS_REG(3, 0, 10, 2, 3),	/* PIR_EL1 */
>  		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
> -		4,
> +		8,
>  		1
>  	}
>  };

Thanks for spotting this. However, we are fixing it in a very backward
way.

Can we please switch all this stuff to symbolic naming instead of
magic numbers? Given how much effort is going into the "automated
generation" thing, it is mind-boggling that the tests still rely on
handcrafted numbers. We just end-up with two different sets of bugs.

At the moment, the level of confidence I have in this stuff is
sub-zero.

	M.

-- 
Without deviation from the norm, progress is not possible.

