Return-Path: <linux-kselftest+bounces-5223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D185E6E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 20:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7884287820
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A34A85946;
	Wed, 21 Feb 2024 19:06:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167185C42
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542397; cv=none; b=TB6Tymr+mtF/rbR89cQMBrEGQTMWRzcJftJIinzIb1cY57vBiMny8BTcReFE2429wDb+27BasTcba9LvtlHB8/MC42RBb08dV6Tps6UbQrirXmkHpM2jNHwiW1eTufL1ysP68XH86FieAdvnsiwTSlcNshZELNlQg3LMAm+B0co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542397; c=relaxed/simple;
	bh=tMAboUzIpbI8r0aCkLKiq7wam/35ifq+uf2tH3/h5q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmDL8ioy321lG7AD87OB5L9Y2/30wM0RJkvC/4F0G7xEA3TS0qRjefSU0XL2TCrKCRXO8eBHCxWt0/NU3836gKhRYFqkPEwRSpmqkUBR5V1veX/xlek5Idxn9phUbbaqlwPWicsBS6pPT5xULXFp46K/opZjFlQ+J7Kjv3JqqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Wed, 21 Feb 2024 14:06:39 -0500
From: "dalias@libc.org" <dalias@libc.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Message-ID: <20240221190639.GU4163@brightrain.aerifal.cx>
References: <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
 <20240221175717.GS4163@brightrain.aerifal.cx>
 <f4a54297767eb098d903404cbe8860d655d79bed.camel@intel.com>
 <20240221183055.GT4163@brightrain.aerifal.cx>
 <c3085fbe10193dfe59b25bc7da776e60779b0e8c.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3085fbe10193dfe59b25bc7da776e60779b0e8c.camel@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 21, 2024 at 06:53:44PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-02-21 at 13:30 -0500, dalias@libc.org wrote:
> > > 3 is the cleanest and safest I think, and it was thought it might
> > > not
> > > need kernel help, due to a scheme Florian had to direct signals to
> > > specific threads. It's my preference at this point.
> > 
> > The operations where the shadow stack has to be processed need to be
> > executable from async-signal context, so this imposes a requirement
> > to
> > block all signals around the lock. This makes all longjmps a heavy,
> > multi-syscall operation rather than O(1) userspace operation. I do
> > not
> > think this is an acceptable implementation, especially when there are
> > clearly superior alternatives without that cost or invasiveness.
> 
> That is a good point. Could the per-thread locks be nestable to address
> this? We just need to know if a thread *might* be using shadow stacks.
> So we really just need a per-thread count.

Due to arbitrarily nestable signal frames, no, this does not suffice.
An interrupted operation using the lock could be arbitrarily delayed,
even never execute again, making any call to dlopen deadlock.

> > > 1 and 2 are POCed here, if you are interested:
> > > https://github.com/rpedgeco/linux/commits/shstk_suppress_rfc/
> > 
> > I'm not clear why 2 (suppression of #CP) is desirable at all. If
> > shadow stack is being disabled, it should just be disabled, with
> > minimal fault handling to paper over any racing operations at the
> > moment it's disabled. Leaving it on with extreme slowness to make it
> > not actually do anything does not seem useful.
> 
> The benefit is that code that is using shadow stack instructions won't
> crash if it relies on them working. For example RDSSP turns into a NOP
> if shadow stack is disabled, and the intrinsic is written such that a
> NULL pointer is returned if shadow stack is disabled. The shadow stack
> is normally readable, and this happens in glibc sometimes. So if there
> was code like:
> 
>    long foo = *(long *)_get_ssp();
> 
> ...then it could suddenly read a NULL pointer if shadow stack got
> disabled. (notice, it's not even a "shadow stack access" fault-wise. So
> it was looked at as somewhat more robust. But neither 1 or 2 are
> perfect for apps that are manually using shadow stack instructions.

It's fine to turn RDSSP into an actual emulated read of the SSP, or at
least an emulated load of zero so that uninitialized data is not left
in the target register. If doing the latter, code working with the
shadow stack just needs to be prepared for the possibility that it
could be async-disabled, and check the return value.

I have not looked at all the instructions that become #UD but I
suspect they all have reasonable trivial ways to implement a
"disabled" version of them that userspace can act upon reasonably.

Rich

