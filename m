Return-Path: <linux-kselftest+bounces-26644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFABDA35A33
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 10:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25820166366
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 09:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728F423027C;
	Fri, 14 Feb 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDWIymUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F124227BAB;
	Fri, 14 Feb 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525047; cv=none; b=jtqUjNH0hWLs96cfhU7bVzeq8QfpnwQ/+DN/XsXC/w2Ux2rwysXmbJ+ORF7rhYqq/WxxqhToQJ+Gy2c0MlmGNG+CR1x/HEAkTxcbQn5deIVhM+K8FoiI1d+RfdGQRS358Bshs7O2H2g6dEMnbDQ6daXLMF0Qkrc9+NkDOrmKze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525047; c=relaxed/simple;
	bh=Mfy+ddENg5qvhmHKsXDrCIS3v98wZceAIoRgJrBPpiE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uma7oPVlQuxsQWFm/3LOe517wE8k5qjV2Rt3WJ6iogv5usc+P5oEhf/62sguAcVOqOmlHtwKDh7hsFj2uHEWsphvYVrefMNWmzjjQ3SqXVNfzDJrV8lK5eU8X3NDQUDuMJ02t4XG4ZKgo4gRDjcUjqSDkkT3je9dkLopKuIijFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDWIymUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F31C4CED1;
	Fri, 14 Feb 2025 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739525046;
	bh=Mfy+ddENg5qvhmHKsXDrCIS3v98wZceAIoRgJrBPpiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QDWIymUw7wH10bLW2shWeKckkb0k5SLz7UsvShpl02/TVwsNy+jWlkSE9VZIPeB+O
	 6DQe7BXlahbQY5v4V9BCdhnXBUfrbwbzO7GsYsHNXeIYlSNWlcWkP1M+4ML/fzfPv4
	 LSkqE1iD/nLQI5ZIuu7p174UBm4WINc9D37mgl73PgRR6ddnAI66xzkpgskmsYqmIB
	 CHuqLZJslaE+wQ13WMoMH7eLgKQ5Cl1hnjPzyDNllLEuVf6Yhv6YxvEvz6D+gD94Rg
	 lXjC7ou10W7jkPVjsQSFjXekuaZkk7UZ6qrVHb5iBsiA2XIYLW3oK9Ezc2lLimq1wb
	 DZJsROpGN5toA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tirvX-00412s-VH;
	Fri, 14 Feb 2025 09:24:04 +0000
Date: Fri, 14 Feb 2025 09:24:03 +0000
Message-ID: <86pljkswuk.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 00/27] KVM: arm64: Implement support for SME in non-protected guests
In-Reply-To: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, Dave.Martin@arm.com, tabba@google.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 14 Feb 2025 01:57:43 +0000,
Mark Brown <broonie@kernel.org> wrote:
> 
> I've removed the RFC tag from this version of the series, but the items
> that I'm looking for feedback on remains the same:
> 
>  - The userspace ABI, in particular:
>   - The vector length used for the SVE registers, access to the SVE
>     registers and access to ZA and (if available) ZT0 depending on
>     the current state of PSTATE.{SM,ZA}.
>   - The use of a single finalisation for both SVE and SME.
> 
>  - The addition of control for enabling fine grained traps in a similar
>    manner to FGU but without the UNDEF, I'm not clear if this is desired
>    at all and at present this requires symmetric read and write traps like
>    FGU. That seemed like it might be desired from an implementation
>    point of view but we already have one case where we enable an
>    asymmetric trap (for ARM64_WORKAROUND_AMPERE_AC03_CPU_38) and it
>    seems generally useful to enable asymmetrically.
> 
> This series implements support for SME use in non-protected KVM guests.

[...]

Just to be clear: I do not intend to review a series that doesn't
cover the full gamut of KVM from day 1. Protected mode is an absolute
requirement. It is the largest KVM deployment, and Android phones the
only commonly available platform with SME. If CCA gets merged prior to
SME support, supporting it will also be a requirement.

> Much of this is very similar to SVE, the main additional challenge that
> SME presents is that it introduces a new vector length similar to the
> SVE vector length and two new controls which change the registers seen
> by guests:
> 
>  - PSTATE.ZA enables the ZA matrix register and, if SME2 is supported,
>    the ZT0 LUT register.
>  - PSTATE.SM enables streaming mode, a new floating point mode which
>    uses the SVE register set with the separately configured SME vector
>    length.  In streaming mode implementation of the FFR register is
>    optional.
> 
> It is also permitted to build systems which support SME without SVE, in
> this case when not in streaming mode no SVE registers or instructions
> are available.  Further, there is no requirement that there be any
> overlap in the set of vector lengths supported by SVE and SME in a
> system, this is expected to be a common situation in practical systems.
> 
> Since there is a new vector length to configure we introduce a new
> feature parallel to the existing SVE one with a new pseudo register for
> the streaming mode vector length.  Due to the overlap with SVE caused by
> streaming mode rather than finalising SME as a separate feature we use
> the existing SVE finalisation to also finalise SME, a new define
> KVM_ARM_VCPU_VEC is provided to help make user code clearer.  Finalising
> SVE and SME separately would introduce complication with register access
> since finalising SVE makes the SVE regsiters writeable by userspace and
> doing multiple finalisations results in an error being reported.
> Dealing with a state where the SVE registers are writeable due to one of
> SVE or SME being finalised but may have their VL changed by the other
> being finalised seems like needless complexity with minimal practical
> utility, it seems clearer to just express directly that only one
> finalisation can be done in the ABI.
>
> Access to the floating point registers follows the architecture:
> 
>  - When both SVE and SME are present:
>    - If PSTATE.SM == 0 the vector length used for the Z and P registers
>      is the SVE vector length.
>    - If PSTATE.SM == 1 the vector length used for the Z and P registers
>      is the SME vector length.
>  - If only SME is present:
>    - If PSTATE.SM == 0 the Z and P registers are inaccessible and the
>      floating point state accessed via the encodings for the V registers. 
>    - If PSTATE.SM == 1 the vector length used for the Z and P registers
>  - The SME specific ZA and ZT0 registers are only accessible if SVCR.ZA is 1.
> 
> The VMM must understand this, in particular when loading state SVCR
> should be configured before other state.

Why SVCR? This isn't a register, just an architected accessor to
PSTATE.{ZA,SM}. Userspace already has direct access to PSTATE, so I
don't understand this requirement.

Isn't it that there is simply a dependency between restoring PSTATE
and any of the vector stuff? Also, how do you preserve the current ABI
that do not have this requirement?

	M.

-- 
Without deviation from the norm, progress is not possible.

