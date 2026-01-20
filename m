Return-Path: <linux-kselftest+bounces-49484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A16D3C4B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 11:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 146A0565468
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3400A3D669B;
	Tue, 20 Jan 2026 09:46:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F47D3E9588;
	Tue, 20 Jan 2026 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902392; cv=none; b=B9RyHYXv37lIvldFEL31TxIxGvXonn36Dlfy7oNt9tc3ajpkOEaggso2Pe83zJiDFO4OhwLBXhD5jUTli7Eh4krVy5msYmnX0fynyo1uj3HU2VeE8XlO8IcNy2HZXFd1+W3N5/u3bHTngWTboGvK0w0n9DAwV2n2MBcQcoiMz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902392; c=relaxed/simple;
	bh=s186feiGqLJdCOT95+dzTzDvIWpSmFlsuahAR4E9xWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SruIP4wDZZKj/Re4CqNKouYFk8DjJ/6PnJpMVtPMSoT++w5Wg1PdRl/uAQld6zxrJKQAkIqtLN6oowa7907S+3wpKVbd8P0LJMuTNPhu+ChJbh9pS9JyhnSOmhaJcJp/GD74QElWvsiy1siAY4HZDSJT/vZgJMyQrUBnt04HCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37A801476;
	Tue, 20 Jan 2026 01:46:22 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04FE43F740;
	Tue, 20 Jan 2026 01:46:23 -0800 (PST)
Date: Tue, 20 Jan 2026 09:46:17 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	catalin.marinas@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
	miko.lenczewski@arm.com, kevin.brodsky@arm.com, ardb@kernel.org,
	suzuki.poulose@arm.com, lpieralisi@kernel.org,
	yangyicong@hisilicon.com, scott@os.amperecomputing.com,
	joey.gouly@arm.com, yuzenghui@huawei.com, pbonzini@redhat.com,
	shuah@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 9/9] arm64: armv8_deprecated: apply FEAT_LSUI
 for swpX emulation.
Message-ID: <aW9O6R7v-ybhrm66@J2N7QTR9R3>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-10-yeoreum.yun@arm.com>
 <86ms3knl6s.wl-maz@kernel.org>
 <aT/bNLQyKcrAZ6Fb@e129823.arm.com>
 <aW5O714hfl7DCl04@willie-the-truck>
 <aW6w6+B21NbUuszA@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW6w6+B21NbUuszA@e129823.arm.com>

On Mon, Jan 19, 2026 at 10:32:11PM +0000, Yeoreum Yun wrote:
> > On Mon, Dec 15, 2025 at 09:56:04AM +0000, Yeoreum Yun wrote:
> > > > On Sun, 14 Dec 2025 11:22:48 +0000,
> > > > Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > > >
> > > > > Apply the FEAT_LSUI instruction to emulate the deprecated swpX
> > > > > instruction, so that toggling of the PSTATE.PAN bit can be removed when
> > > > > LSUI-related instructions are used.
> > > > >
> > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > >
> > > > It really begs the question: what are the odds of ever seeing a CPU
> > > > that implements both LSUI and AArch32?
> > > >
> > > > This seems extremely unlikely to me.
> > >
> > > Well, I'm not sure how many CPU will have
> > > both ID_AA64PFR0_EL1.EL0 bit as 0b0010 and FEAT_LSUI
> > > (except FVP currently) -- at least the CPU what I saw,
> > > most of them set ID_AA64PFR0_EL1.EL0 as 0b0010.
> >
> > Just to make sure I understand you, you're saying that you have seen
> > a real CPU that implements both 32-bit EL0 *and* FEAT_LSUI?
> >
> > > If you this seems useless, I don't have any strong comments
> > > whether drop patches related to deprecated swp instruction parts
> > > (patch 8-9 only) or not.
> > > (But, I hope to pass this decision to maintaining perspective...)
> >
> > I think it depends on whether or not the hardware exists. Marc thinks
> > that it's extremely unlikely whereas you appear to have seen some (but
> > please confirm).
> 
> What I meant was not a 32-bit CPU with LSUI, but a CPU that supports
> 32-bit EL0 compatibility (i.e. ID_AA64PFR0_EL1.EL0 = 0b0010).
> My point was that if CPUs implementing LSUI do appear, most of them will likely
> continue to support the existing 32-bit EL0 compatibility that
> the majority of current CPUs already have.

That doesn't really answer Will's question. Will asked:

  Just to make sure I understand you, you're saying that you have seen a
  real CPU that implements both 32-bit EL0 *and* FEAT_LSUI?

IIUC you have NOT seen any specific real CPU that supports this, and you
have been testing on an FVP AEM model (which can be configured to
support this combination of features). Can you please confirm?

I don't beleive it's likely that we'll see hardware that supports
both FEAT_LSUI and AArch32 (at EL0).

Mark.

