Return-Path: <linux-kselftest+bounces-19115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87485991762
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 16:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D039B21940
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2014EC62;
	Sat,  5 Oct 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvSDtyHP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA4D2FA;
	Sat,  5 Oct 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728138834; cv=none; b=NBoLE1vFrA7dpdOdwIoTvKsOUwCmxemcs7q6Tl+HCzOpdOCiPmYRwWzZCfZeqiWac4/2Sx19rYTaUvwezgrfr2C12lXV9a3FcCHar1vwZjjNVne5KWVDCKdmWH2dIyw84+m2B+raOJ7QBcFfBtY6dcyjqA0wUrJDLiv6Dk/KmTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728138834; c=relaxed/simple;
	bh=MU0fRAPqCrXvULNmVt/pnSMsmzjWy+uOjBzDEn46sHE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAJFMI1etX6OOYg8hfu5d3/oTOXlolXACJFK0Mepe2TKsMlFb4L6tdKJG3dJ/hEKKFD211sDZgCUN5Qgp03ynuExhRaGCXhStmhZCVI6CVqoXu4nkEq5Zi0cUiztIpVpqdbQgD3IZIWuQaW7cH7YlhVm1/dDckmjeyHfZ73CwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvSDtyHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58532C4CEC2;
	Sat,  5 Oct 2024 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728138833;
	bh=MU0fRAPqCrXvULNmVt/pnSMsmzjWy+uOjBzDEn46sHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OvSDtyHPg97pm18qhn1VmhnVbVIflurs/GIKYIChPgjZmpfPcEe8bzCwGaHlMUzCO
	 9sofmVYLI2aEjdevyG2GSBb0lyLgVCY2I8zPB0CwaQvPy3h13YMPCKdu9k/DhxevcJ
	 b66WVnfhDqEw6Od/M2ICj7imsUfr53fm0QgVGrLr8ioMJSOveJj6/IakXZTG6PDJTZ
	 Dfv7vAe3nJmjoWfnSZtKvLnhTjKceM/CqIMgHgIds/YsVGVwzkPiLdv0Q/JlTs+jzI
	 +ozv3FgXSgMv9uZOOqtwR+H9R978wQtRNalF8ISMpTOcwItPym41W7JJ05sdiDmAZ5
	 X1oFfmJH/bPCA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sx5qw-000cXV-BW;
	Sat, 05 Oct 2024 15:33:50 +0100
Date: Sat, 05 Oct 2024 15:33:48 +0100
Message-ID: <87cykevctv.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 3/5] KVM: arm64: Manage GCS access and registers for guests
In-Reply-To: <ZwFMnhXGV_Nj31tE@finisterre.sirena.org.uk>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
	<20241005-arm64-gcs-v14-3-59060cd6092b@kernel.org>
	<87iku6vl4z.wl-maz@kernel.org>
	<ZwE6V9cqf7jD1rTc@finisterre.sirena.org.uk>
	<87frpavgam.wl-maz@kernel.org>
	<ZwFDmaeIgPKfmJnj@finisterre.sirena.org.uk>
	<87ed4uveam.wl-maz@kernel.org>
	<ZwFMnhXGV_Nj31tE@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 05 Oct 2024 15:26:38 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> [1  <text/plain; us-ascii (7bit)>]
> On Sat, Oct 05, 2024 at 03:02:09PM +0100, Marc Zyngier wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > > Ah, I see.  I'd been under the impression that the generic machinery was
> > > supposed to handle this already using the descriptions in
> > > emulate-nested.c and we only needed handlers for more specific actions.
> 
> > From that very file:
> 
> > /*
> >  * Map encoding to trap bits for exception reported with EC=0x18.
> >  [...]
> >  */
> 
> > Everything else needs special handling.
> 
> I see.  I had noticed that comment on that table but I didn't register
> that the comment wound up applying to the whole file rather than being
> about a specific part of the handling.  I'm a bit confused about how
> things like the SVE traps I mentioned work here...

Like all ECs, the handling starts in handle_exit.c.

	M.

-- 
Without deviation from the norm, progress is not possible.

