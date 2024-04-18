Return-Path: <linux-kselftest+bounces-8355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78768AA11D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E77F1C21FAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA35174EDB;
	Thu, 18 Apr 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgMkaLsZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77B15B98A;
	Thu, 18 Apr 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461526; cv=none; b=MFYwXpQhPpdeU9EooLClyfSSkBsRSiMn5a8j0JqAlnkwMul0bQT+Sje5XbQ0sq5wqhia46yR30hmHA5TgCQdC7nSlR/wsgEfUj78orei/6+HHJsGg1wzlbKHMxe85jAmNMEXCmtgvJJwtPKflO82fAM8SRpde/yyGbJNnPd/Et8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461526; c=relaxed/simple;
	bh=ackjtFhEwPS1DWwxwOO1J3VcSzyK+7bkMK70V249e+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRIL8OG13++xbFEbWnf4r2QdMw0ryjitzQuIjMyz4sUrWEE18qM8R27RJVoPCK+uG4UaXmZxnjN8f7SYsl/tWiCoY7/bd9ROksqN3I4dASKbbC+JunllOpRDcFLaI51UTo8xPnjKWibDRbVhv4fxGdabksWw2A2JBooq4cxqKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgMkaLsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FF2C113CC;
	Thu, 18 Apr 2024 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713461526;
	bh=ackjtFhEwPS1DWwxwOO1J3VcSzyK+7bkMK70V249e+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgMkaLsZL6MDFoi5pOJZ9Uqc06yo9NSEFh/o7HjCO5s0W2kKW8/U8XwpEcOUYkfLR
	 RuShVXQimLY85SYSdAYAGrsNvGnXS93Uc1J1h/iz1t1C0rXIsyT4PVPW+7qXgaB/3t
	 Juw3kluI6GsEYo+wBLEAUHqdVfx4jtG9iLK5WLn2sAQJfO8LkAyTesefKFebGggfpT
	 ZcwNGzTFBXyDliQUc3GCmxAlTaeGDadJB6/zE1C49B9xuJ4O2vgHuFfiiC9aiRqCSS
	 AuIwkH53dn5sKGtUxzs8vuwWfGgpcuBk1DUz6E+3eX29bWLAiD2Y+mab6KB+Zjvrpj
	 lHERzYdAahI+w==
Date: Thu, 18 Apr 2024 10:32:03 -0700
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
Message-ID: <20240418173203.GA1081@sol.localdomain>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-7-e0c45bb6b253@sifive.com>
 <20240418-brook-chili-4d3e61d1a55c@wendy>
 <20240418155256.GA2410@sol.localdomain>
 <20240418-ultimatum-yam-11de4b063b83@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-ultimatum-yam-11de4b063b83@spud>

On Thu, Apr 18, 2024 at 05:53:55PM +0100, Conor Dooley wrote:
> > If it would be useful to do so, we should be able to enable some of the code
> > with a smaller VLEN and/or EEW once it has been tested in those configurations.
> > Some of it should work, but some of it won't be able to work.  (For example, the
> > SHA512 instructions require EEW==64.)
> > 
> > Also note that currently all the RISC-V vector crypto code only supports riscv64
> > (XLEN=64).  Similarly, that could be relaxed in the future if people really need
> > the vector crypto acceleration on 32-bit CPUs...  But similarly, the code would
> > need to be revised and tested in that configuration.
> > 
> > > Eric/Jerry (although read the previous paragraph too):
> > > I noticed that the sha256 glue code calls crypto_simd_usable(), and in
> > > turn may_use_simd() before kernel_vector_begin(). The chacha20 glue code
> > > does not call either, which seems to violate the edict in
> > > kernel_vector_begin()'s kerneldoc:
> > > "Must not be called unless may_use_simd() returns true."
> > 
> > skcipher algorithms can only be invoked in process and softirq context.  This
> > differs from shash algorithms which can be invoked in any context.
> > 
> > My understanding is that, like arm64, RISC-V always allows non-nested
> > kernel-mode vector to be used in process and softirq context -- and in fact,
> > this was intentionally done in order to support use cases like this.  So that's
> > why the RISC-V skcipher algorithms don't check for may_use_simd() before calling
> > kernel_vector_begin().
> 
> I see, thanks for explaining that. I think you should probably check
> somewhere if has_vector() returns true in that driver though before
> using vector instructions. Only checking vlen seems to me like relying on
> an implementation detail and if we set vlen for the T-Head/0.7.1 vector
> it'd be fooled. That said, I don't think that any of the 0.7.1 vector
> systems actually support Zvkb, but I hope you get my drift.

All the algorithms check for at least one of the vector crypto extensions being
supported, for example Zvkb.  'if (riscv_isa_extension_available(NULL, ZVKB))'
should return whether the ratified version of Zvkb is supported, and likewise
for the other vector crypto extensions.  The ratified version of the vector
crypto extensions depends on the ratified version of the vector extension.  So
there should be no issue.  If there is, the RISC-V core architecture code needs
to be fixed to not declare that extensions are supported when they are actually
incompatible non-standard versions of those extensions.  Incompatible
non-standard extensions should be represented as separate extensions.

- Eric

