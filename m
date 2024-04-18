Return-Path: <linux-kselftest+bounces-8345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B68A9F25
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9473B24FCC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042316F85E;
	Thu, 18 Apr 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi83tpc6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFAC16C84E;
	Thu, 18 Apr 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455579; cv=none; b=mgwJHIXDG9K1R/X6afqfXz/TL+4m4iw7kDkIqhQOjnckwMBoW0BwEdJ7ACvRzSKpQgnKgFbjLHiB8x3hLp6Ro9YWl5A6K3dk5hRdDjbMSPBoL97tbPhpEvL65xW1C7eD7gKD3EC1XNug81tbKoKsoXHRCTe1HaZJofTezzbIVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455579; c=relaxed/simple;
	bh=6yP7DNU81gVVaBLvr4Yz015ghuSP2nPtHJYZrJGgZkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4zEJ044xwT1oY1h2EVH5GK0AiFyTzpSf9XnahgKwT3rIwCqjL1jHhBNYEoHb8lLMqnwQZjwN4dJTrRTalT7E3XjuVT3uw/LTVmiun1OyVq/RCWptDNdme/izA5reAd6t3xxuY8sAga+gfGwRP66qjqhGcBXh4fpJ7kVqSQsbnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi83tpc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3773FC113CC;
	Thu, 18 Apr 2024 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713455579;
	bh=6yP7DNU81gVVaBLvr4Yz015ghuSP2nPtHJYZrJGgZkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zi83tpc6ru6TyArQhR6ravdTE5SWs2XiYm2p5hQUcjNinfQDw2cHCSmtmm6RwfWZV
	 mptYHPMCzvu4Y0fz5PNnv4MkCgjUVgtC/A7m6CcFgB8RkDUgOANAcuBIZWN7X2b3Fi
	 v/xjqf97txq8FkqnuDHLw3th53BtVEFnlXTFtnkRQJuyijFHXeKtoA/ux82SRH+ba0
	 7PHwOlUjBi8jQfeGgz9stAJ4AFCbmooPwKFAj4gzV6saPUSUc1j4wy9OIQDsThF2vT
	 tNRVlc3dBP7B7wp3WPYnzVcAFyHYu5IV7X3TotEjKuTGgrugDkjP2sbVgNymPmtKrU
	 lNW6hPVqMU+nA==
Date: Thu, 18 Apr 2024 08:52:56 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Andy Chiu <andy.chiu@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Message-ID: <20240418155256.GA2410@sol.localdomain>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-7-e0c45bb6b253@sifive.com>
 <20240418-brook-chili-4d3e61d1a55c@wendy>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-brook-chili-4d3e61d1a55c@wendy>

Hi Conor,

On Thu, Apr 18, 2024 at 12:02:10PM +0100, Conor Dooley wrote:
> +CC Eric, Jerry
> 
> On Fri, Apr 12, 2024 at 02:49:03PM +0800, Andy Chiu wrote:
> > Make has_vector take one argument. This argument represents the minimum
> > Vector subextension that the following Vector actions assume.
> > 
> > Also, change riscv_v_first_use_handler(), and boot code that calls
> > riscv_v_setup_vsize() to accept the minimum Vector sub-extension,
> > ZVE32X.
> > 
> > Most kernel/user interfaces requires minimum of ZVE32X. Thus, programs
> > compiled and run with ZVE32X should be supported by the kernel on most
> > aspects. This includes context-switch, signal, ptrace, prctl, and
> > hwprobe.
> > 
> > One exception is that ELF_HWCAP returns 'V' only if full V is supported
> > on the platform. This means that the system without a full V must not
> > rely on ELF_HWCAP to tell whether it is allowable to execute Vector
> > without first invoking a prctl() check.
> > 
> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > Acked-by: Joel Granados <j.granados@samsung.com>
> 
> I'm not sure that I like this patch to be honest. As far as I can tell,
> every user here of has_vector(ext) is ZVE32X, so why bother actually
> having an argument?
> 
> Could we just document that has_vector() is just a tyre kick of "is
> there a vector unit and are we allowed to use it", and anything
> requiring more than the bare-minimum (so zve32x?)must explicitly check
> for that form of vector using riscv_has_extension_[un]likely()?
> 
> Finally, the in-kernel crypto stuff or other things that use
> can_use_simd() to check for vector support - do they all function correctly
> with all of the vector flavours? I don't understand the vector
> extensions well enough to evaluate that - I know that they do check for
> the individual extensions like Zvkb during probe but don't have anything
> for the vector version (at least in the chacha20 and sha256 glue code).
> If they don't, then we need to make sure those drivers do not probe with
> the cut-down variants.

As far as I know, none of the RISC-V vector crypto code has been tested with
Zve* yet.  Currently it always checks for VLEN >= 128, which should exclude most
Zve* implementations.

Currently it doesn't check for EEW >= 64, even though it sometimes assumes that.
It looks like a check for EEW >= 64 needs to be added in order to exclude Zve32x
and Zve32f implementations that don't support EEW == 64.

If it would be useful to do so, we should be able to enable some of the code
with a smaller VLEN and/or EEW once it has been tested in those configurations.
Some of it should work, but some of it won't be able to work.  (For example, the
SHA512 instructions require EEW==64.)

Also note that currently all the RISC-V vector crypto code only supports riscv64
(XLEN=64).  Similarly, that could be relaxed in the future if people really need
the vector crypto acceleration on 32-bit CPUs...  But similarly, the code would
need to be revised and tested in that configuration.

> Eric/Jerry (although read the previous paragraph too):
> I noticed that the sha256 glue code calls crypto_simd_usable(), and in
> turn may_use_simd() before kernel_vector_begin(). The chacha20 glue code
> does not call either, which seems to violate the edict in
> kernel_vector_begin()'s kerneldoc:
> "Must not be called unless may_use_simd() returns true."

skcipher algorithms can only be invoked in process and softirq context.  This
differs from shash algorithms which can be invoked in any context.

My understanding is that, like arm64, RISC-V always allows non-nested
kernel-mode vector to be used in process and softirq context -- and in fact,
this was intentionally done in order to support use cases like this.  So that's
why the RISC-V skcipher algorithms don't check for may_use_simd() before calling
kernel_vector_begin().

Has that changed?  If so, why?

Some architectures like x86 do provide no-SIMD fallbacks for all skcipher
algorithms, but it's very annoying to do.  We were hoping to avoid that in
RISC-V.

- Eric

