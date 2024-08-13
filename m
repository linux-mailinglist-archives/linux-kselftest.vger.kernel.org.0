Return-Path: <linux-kselftest+bounces-15221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F79505B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E56B26333
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CA8199EB4;
	Tue, 13 Aug 2024 12:55:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3232A1898E6
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553753; cv=none; b=SEqB+pSrP9KNz/vUwxEKtRnAlqfQcJV9EjcxLSFprAo41ggIspP1Eqt9FUmjnUbeMk6dh1KWrQ38fVzn/HQqktZlUwFvLDly9pXdINokPppYGZPb4nSGzhN/GsXhS9LJ5HZgQxbPO05RYyxKP7KLTmP35CSNeBIUX7Pfc/TiN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553753; c=relaxed/simple;
	bh=ImJtN3H6UiTafzBF1o0ECIiMneJUtPXqRxHcJ+5GqO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4Cp9T2PH78rnHnGyX+P/ETsVBorp/B0jhq7w1O1rBcsTysyur8x50ofgXYvsvzbdhSyj5w4nay4hY/OAbklbmZM/b5Em/1uxmaJ1gg4Dbpwogz9nHFEc404FdCInCYAFgTEwZ9pREIiPsWDcEj+B5+1f1BB9mTYyWQfgreU+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70BB212FC;
	Tue, 13 Aug 2024 05:56:16 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719C43F73B;
	Tue, 13 Aug 2024 05:55:49 -0700 (PDT)
Date: Tue, 13 Aug 2024 13:55:46 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: signal: fix/refactor SVE vector length
 enumeration
Message-ID: <20240813135546.6c91fc8b@donnerap.manchester.arm.com>
In-Reply-To: <561f31a7-6813-499a-a6b5-83bccb69a3e0@sirena.org.uk>
References: <20240812140924.2100643-1-andre.przywara@arm.com>
	<561f31a7-6813-499a-a6b5-83bccb69a3e0@sirena.org.uk>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 12:00:06 +0100
Mark Brown <broonie@kernel.org> wrote:

Hi broonie,

> On Mon, Aug 12, 2024 at 03:09:24PM +0100, Andre Przywara wrote:
> 
> > +		/* Did we find the lowest supported VL? */
> > +		if (use_sme && vq < sve_vq_from_vl(vl))
> > +			break;  
> 
> We don't need the use_sme check here, SVE is just architecturally
> guaranteed to never trip the && case.  Unless you add a warning for
> broken implementations I'd just skip it.

Ah, thanks, I wasn't sure about that, and wanted to mimic the existing
code as close as possible. Will surely just drop it.

Thanks,
Andre

