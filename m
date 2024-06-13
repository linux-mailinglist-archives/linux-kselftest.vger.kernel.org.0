Return-Path: <linux-kselftest+bounces-11845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B584D906728
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 10:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2691F21650
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063D13D60A;
	Thu, 13 Jun 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rCuBfqHf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB713CABC
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267926; cv=none; b=iP1a21XGFgdca+w+fwli2Vs2fDWgbHPaVhLX7qNDO5mu8CJkUS74GPS7KwSXgvL5NMLTVQtTGtUpuMZwI/C13ypv9X4w6c440DMqsU69hMFoVBvWW03rP05wSCmo64G4NUOX/V4J8VDm94IsXrnwWD40QaUatnc453yrZAFTNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267926; c=relaxed/simple;
	bh=9SUeiVi1T9oGrBbo854n3vOCgOUM0D7zt4AESPxaOPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXTcKOdWe7HpW1bC4ZCXxuyhAjGrsqDrX7HhwS8rPCzm380XyIxrCfz0rmL76i/QKWux25Ly13XsSOVHNIy4Y+0WBY/XjB9bAdaxhqcEQuBNf5BS8PVzqRuQ8v1ZdtuGYS8QXiQH9fMoDaFlm/l77hCudENv/4L/mEUCWdzb9Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rCuBfqHf; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shahuang@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718267919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bowi7EOkTndTQt3cslYbea98TP7rJlt6kYEQxSxfRQU=;
	b=rCuBfqHfkguMUdlF6u8DRs0d0yksqiHxDzN0PlaV3AhxkrAUcUy96qZD4WDSx8mjOqPEX4
	Jws3URRCEyxeDtGrSJeDq393+zqy++RBmNHTLS2jgV4plUQozy3596VX4auQ2kFZY3S6H1
	XR2XCNV1A3JN7SyJMZKf3aMAz5N5Rxg=
X-Envelope-To: maz@kernel.org
X-Envelope-To: kvmarm@lists.linux.dev
X-Envelope-To: eauger@redhat.com
X-Envelope-To: sebott@redhat.com
X-Envelope-To: cohuck@redhat.com
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: james.morse@arm.com
X-Envelope-To: kvm@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: pbonzini@redhat.com
X-Envelope-To: shuah@kernel.org
X-Envelope-To: suzuki.poulose@arm.com
X-Envelope-To: will@kernel.org
X-Envelope-To: yuzenghui@huawei.com
Date: Thu, 13 Jun 2024 01:38:33 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	Eric Auger <eauger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [RFC PATCH v1 0/2] KVM: arm64: Making BT Field in
 ID_AA64PFR1_EL1 writable
Message-ID: <ZmqwCbxvBErCZ43v@linux.dev>
References: <20240612023553.127813-1-shahuang@redhat.com>
 <Zmkyi39Pz6Wqll-7@linux.dev>
 <8634pilbja.wl-maz@kernel.org>
 <7f1ca739-42f5-4e3a-a0c9-b1eac4522a97@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1ca739-42f5-4e3a-a0c9-b1eac4522a97@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 13, 2024 at 04:31:45PM +0800, Shaoqin Huang wrote:
> Hi Marc,
> 
> On 6/12/24 18:07, Marc Zyngier wrote:
> > On Wed, 12 Jun 2024 06:30:51 +0100,
> > Oliver Upton <oliver.upton@linux.dev> wrote:
> > > 
> > > Hi Shaoqin,
> > > 
> > > On Tue, Jun 11, 2024 at 10:35:50PM -0400, Shaoqin Huang wrote:
> > > > Hi guys,
> > > > 
> > > > I'm trying to enable migration from MtCollins(Ampere Altra, ARMv8.2+) to
> > > > AmpereOne(AmpereOne, ARMv8.6+), the migration always fails when migration from
> > > > MtCollins to AmpereOne due to some register fields differing between the
> > > > two machines.
> > > > 
> > > > In this patch series, we try to make more register fields writable like
> > > > ID_AA64PFR1_EL1.BT. This is first step towards making the migration possible.
> > > > Some other hurdles need to be overcome. This is not sufficient to make the
> > > > migration successful from MtCollins to AmpereOne.
> > > 
> > > It isn't possible to transparently migrate between these systems. The
> > > former has a cntfrq of 25MHz, and the latter has a cntfrq of 1GHz. There
> > > isn't a mechanism for scaling the counter frequency, and I have zero
> > > appetite for a paravirt interface.
> > 
> > Note that there *is* an architectural workaround in the form of
> > FEAT_CNTSC. But of course:

Heh, I should've further specified a per-CPU mechanism :)

> > - it is optional (and likely not implemented)
> > - it is global (hence affecting all SW running on the machine)
> > - it invalidates the requirements of ARMv8.6 (who cares?)
> > - KVM has nothing to do with it (yay!)
> > 
> > So if the two systems (from the same manufacturer) were ever designed
> > to allow migration between the two, they would have at least baked
> > some of that in.
> > 
> > As for the paravirt interface, I agree that this is a non-starter
> > (been there, done that, dumped it in the bin).
> > 
> > The patch itself is interesting and may be of use once it has been put
> > to a compiler and not just dumped on the list without any testing.
> > 
> > 	M.
> 
> Thanks for putting your comments here.
> 
> If we don't care about the FEAT_CNTSC right now. Could I fix the compile
> issue and respin this again without the background of enabling migration
> between MtCollins and AmpereOne, and just keep the information of the
> different BT field between different machine?

I don't think cross-platform migration is relevant for the KVM UAPI
you're trying to augment. We want to give userspace the ability to control
the visible feature set for a VM, which *could* be used by userspace in such
a way to transparently migrate VMs.

So if you could focus the changelog purely as an improvement upon the
existing controls we expose to the VMM then the patch is more obviously
justified.

Please do respin.

-- 
Thanks,
Oliver

