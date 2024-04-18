Return-Path: <linux-kselftest+bounces-8360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4068AA22E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 20:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5BA283754
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 18:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69DB17AD71;
	Thu, 18 Apr 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCB5+i6h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915093D62;
	Thu, 18 Apr 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465692; cv=none; b=i5qTTuJwe65d8zfSWzDvtsvuuugsnmqwggF54paP1U6dwSmb1ZJEExOYAqVYVv3NAJ2k2O9IaEWRD7HPjx3FTDtba/VkfCuQPoRChmVcwk63z2XsrKbmoyqFL8K7Wfefs0VSuEcICz+lzvI/cpiT5RUif2phieS89GrkhOB5sOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465692; c=relaxed/simple;
	bh=kEWHQmsJ7jcAxlIEcpREBxKEUkYR0ejcefjSl8M/NeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz5AUfoKSBAPiF4prR0yqq4Yf11VL/O/fJYLj9/LC/s+SYMPek3/lXxwyPo/taV4Cvi+OkuHYfgWut5HO4Q6pP3D8InjUb8/qVteFtOVWrfwyPNsY+DpnjJaJjAH21dMX4dc3EII+oepinRqU9G6b050uSwxdnR6X1sso78Cu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCB5+i6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579B2C113CC;
	Thu, 18 Apr 2024 18:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713465692;
	bh=kEWHQmsJ7jcAxlIEcpREBxKEUkYR0ejcefjSl8M/NeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCB5+i6hXvtGQUKyYNSOAgZj/U/0hMKrNf8a0QI97T9JtHWodoLi7koIZZ0J+zIDb
	 8EjU6qAzoiLHW7PmnoNTwLI088osMLiL4r0di9DyFYBqOqMxpr6e+L4xu2cJyNoRMW
	 1gLKDXwwVKmyRDstr+b7gDbTIcdVAlKVHGJYkhNCYkYRwrg2NjskAdXd3RrKELU28K
	 jFP/47pp9xP1vNNSoqBKOPzkNBY/TMMBEkX0f74rYVsMB8l9iJwkT8sycFX8FIVHoh
	 +RMBkCqXo58gzhYcxpfIg+8zfP6OCAuEvyZGetaoSS0Y9YXzRcJw4a3RueaRsdNkq9
	 zHrlrWnvNfvKA==
Date: Thu, 18 Apr 2024 11:41:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Jerry Shih <jerry.shih@sifive.com>
Subject: Re: [PATCH v4 7/9] riscv: vector: adjust minimum Vector requirement
 to ZVE32X
Message-ID: <20240418184129.GA1071@sol.localdomain>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-7-e0c45bb6b253@sifive.com>
 <20240418-brook-chili-4d3e61d1a55c@wendy>
 <20240418155256.GA2410@sol.localdomain>
 <20240418-ultimatum-yam-11de4b063b83@spud>
 <20240418173203.GA1081@sol.localdomain>
 <20240418173946.GB1081@sol.localdomain>
 <20240418-sterling-sanding-d59c3b0a2aaa@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-sterling-sanding-d59c3b0a2aaa@spud>

On Thu, Apr 18, 2024 at 07:26:00PM +0100, Conor Dooley wrote:
> That's great if it does require that the version of the vector extension
> must be standard. Higher quality spec than most if it does. But
> "supported" in the context of riscv_isa_extension_available() means that
> the hardware supports it (or set of harts), not that the currently
> running kernel does. The Kconfig deps that must be met for the code to be
> built at least mean the kernel is built with vector support, leaving only
> "the kernel was built with vector support and the hardware supports vector
> but for $reason the kernel refused to enable it".
> 
> I'm not sure if that final condition is actually possible with the system
> ending up in a broken state, however - I'm not sure that we ever do turn
> off access to the VPU at present (after we mark it usable), and if we do
> it doesn't get reflected in has_vector() so the kernel and userspace would
> both break, with what a crypto driver does probably being the least of
> your worries.
>
> > I am just concerned about how you're suggesting that non-standard extensions
> > might be pretending to be standard ones and individual users of kernel-mode
> > vector would need to work around that.
> 
> I am absolutely not suggesting that non-standard extensions should
> masquerade as standard ones, I don't know where you got that from. What
> I said was that a non-standard vector extension could reuse riscv_v_vlen
> (and should IMO for simplicity reasons), not that any of the APIs we have
> for checking extension availability would lie and say it was standard.
> riscv_v_vlen having a value greater than 128 is not one of those APIs ;)

It sounded like you were suggesting that a CPU could plausibly have a
pre-standard version of the vector extension but also have standard Zvkb.  I
don't think this makes sense, due to the dependency.

> > I think that neither has_vector() nor
> > 'if (riscv_isa_extension_available(NULL, ZVKB))' should return true if the CPU's
> > vector extension is non-standard.
> 
> riscv_isa_extension_available(NULL, ZVKB) only checks whether the extension
> was present in DT or ACPI for all harts. It doesn't check whether or not
> the required config option for vector has been set or anything related
> to dependencies. has_vector() at least checks that the vector core has
> been enabled (and uses the alternative-patched version of the check
> given it is used in some hotter paths). That's kinda moot for code
> that's only built if the vector core stuff is enabled as I said above
> though.
> 
> We could of course make riscv_isa_extension_available() check
> extension dependencies, but I'd rather leave dt validation to the dt
> tooling (apparently ACPI tables are never wrong...). Either would allow
> you to rely on the crypto extensions present only when the standard vector
> extensions unless someone's DT/ACPI stuff is shite, but then they keep the
> pieces IMO :)
> 
> Hope that makes sense?

If the RISC-V kernel ever disables V, then it should also disable everything
that depends on V.

This would be similar to how on x86, if the kernel decides to disable AVX to
mitigate the Gather Data Sampling vulnerability, it also disables AVX2, AVX512,
VAES, VPCLMULQDQ, etc.  See cpuid_deps[] in arch/x86/kernel/cpu/cpuid-deps.c.

Sometimes CPU features depend on other ones.  That's just the way things work.
Whenever possible that should be handled centrally, not pushed down to every
user both in-kernel and userspace.

- Eric

