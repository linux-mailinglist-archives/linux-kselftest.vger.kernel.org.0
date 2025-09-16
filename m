Return-Path: <linux-kselftest+bounces-41601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57FB59B11
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 16:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA411881B1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E283375B5;
	Tue, 16 Sep 2025 14:57:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDFE3043AB;
	Tue, 16 Sep 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034625; cv=none; b=CIUqEkC/Df3KlEzacmvRqZGaGtmavaAgljAaAgd7xwUVVWhS1aQMq494n0slDX/FAQIl+mRhm9SdagbVrxSupbO0Styin/Gv+4oBG1l+07l1Nr+jlWeus8D8NXvfWozJ4TMV3KxkOsi2MnHiDc07DoFOgGIFb+ZxJB7epyCNcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034625; c=relaxed/simple;
	bh=18aNrZxoeFZmz6760M41TP3U4fPTvpf9mbhpx8Df3k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBY2cLaExjlS/Q5Aa7ITdVZCRlYGtFB8JKa+MCRDylZjY8vdVfWu3/jkjvana0zHtuK4aWfcViaN+ozvmn1NwhwMm9B2lPcldNq1T4OlsE3i49rttLlTKWmm6glSiFkR9zqEufRn/w8J4gD/fw/+PUPQtJjwYQ3vV7NjibwtvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC69C4CEEB;
	Tue, 16 Sep 2025 14:57:01 +0000 (UTC)
Date: Tue, 16 Sep 2025 15:56:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: Will Deacon <will@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	yangyicong@hisilicon.com, maz@kernel.org, oliver.upton@linux.dev,
	corbet@lwn.net, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, shuah@kernel.org,
	shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com,
	tangchengchang@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v4 5/7] arm64: Add support for FEAT_{LS64, LS64_V}
Message-ID: <aMl6u7xTDLhrZmqK@arm.com>
References: <20250715081356.12442-1-yangyicong@huawei.com>
 <20250715081356.12442-6-yangyicong@huawei.com>
 <aL7Fgx__LeLfbDyU@willie-the-truck>
 <5d2ba565-715b-9b17-951b-f805dde5988b@huawei.com>
 <aMLvtpaCgRqPAU2Z@willie-the-truck>
 <20250912144736.00007673@huawei.com>
 <666e3588-2e42-2275-f9ec-94ba0954bdc6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666e3588-2e42-2275-f9ec-94ba0954bdc6@huawei.com>

On Mon, Sep 15, 2025 at 04:29:25PM +0800, Yicong Yang wrote:
> On 2025/9/12 21:47, Jonathan Cameron wrote:
> > On Thu, 11 Sep 2025 16:50:14 +0100
> > Will Deacon <will@kernel.org> wrote:
> >> On Tue, Sep 09, 2025 at 09:48:04AM +0800, Yicong Yang wrote:
> >>> per ARM DDI0487 L.b section C3.2.6,
> >>>
> >>>   When the instructions access a memory type that is not one of the following,
> >>>   a data abort for unsupported Exclusive or atomic access is generated...  
> >>
> >> That's about the memory _type_. I'm talking about a supported memory type
> >> (e.g. writeback cacheable) but when the physical location doesn't support
> >> the instruction. That's captured a little later in the same section:
> >>
> >>   | If the target memory location does not support the LD64B or ST64B
> >>   | instructions, then one of the following behaviors occurs:
> >>   |  * A stage 1 Data Abort, reported using the DFSC code of 0b110101,
> >>   |    is generated.
> >>   |  * The instruction performs the memory accesses, but the accesses
> >>   |    are not single-copy atomic above the byte level

Is this a new addition to the L.b release of the ARM ARM? Maybe it was
there before in some other form (or a different place). At least it
doesn't say "unpredictable".

> >> and I think that's a bad interface to expose blindly to userspace solely
> >> as a boolean hwcap.
> > 
> > Nasty, so now I'm curious. Any thoughts on how to expose what regions it is appropriate
> > for?  I can think of various heavy weight options but wondering if there is a simple
> > solution.
> 
> in my understanding the hwcap only describes the capabilities of the CPU but not
> the whole system. the users should make sure the function works as expected if the
> CPU supports it and they're going to use it. specifically the LS64 is intended for
> device memory only, so the user should take responsibility of using it on supported
> memory.

We have other cases like MTE where we avoid exposing the HWCAP to user
if we know the memory system does not support MTE, though we intercepted
this early and asked the (micro)architects to tie the CPU ID field to
what the system supports.

> may raise the similar question if use other atomic instructions (e.g. LSE) on the
> memory does not support atomicity. find this restriction in ARM DDI0487 L.b section B2.2.6
> 
>   Some system implementations might not support atomic instructions for all regions of the
>   memory

With exclusives or atomics, we require that the general purpose (system)
RAM supports the feature, otherwise Linux won't work properly (I don't
think we specifically documented this but it would be fairly obvious
when the kernel doesn't boot or user-space randomly crashes).

> and if perform atomic instruction on unsupported memory it's allowed to implement as
> 
>   * The instruction generates a synchronous External abort.
>   * The instruction generates a System Error interrupt.
>   * The instruction generates an IMPLEMENTATION DEFINED MMU fault reported using the Data
>     Abort Fault status code of ESR_ELx.DFSC = 110101.
>   * The instruction is treated as a NOP.
>   * The instructions are performed, but there is no guarantee that the memory accesses were
>     performed atomically in regard to other agents that access memory. In this case, the
>     instruction might also generate a System Error interrupt.
> 
> if instruction performed without generate a SEI in the last implementation, it's quite similar
> to the condition of LS64.

The difference is that we don't support Linux on such systems.

Arguably, the use of LD/ST64B* is fairly specialised and won't be used
on the general purpose RAM and by random applications. It needs a device
driver to create the NC/Device mapping and specific programs/libraries
to access it. I'm not sure the LS64 properties are guaranteed by the
device alone or the device together with the interconnect. I suspect the
latter and neither the kernel driver nor user space can tell. In the
best case, you get a fault and realise the system doesn't work as
expected. Worse is the non-atomicity with potentially silent corruption.

So, to Will's point, the HWCAP is not sufficient for user space to make
an informed decision on whether it can safely use the LS64 instructions.
Can a (generic) device driver tell or do we need additional information
in firmware tables to advertise the correct behaviour?

-- 
Catalin

