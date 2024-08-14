Return-Path: <linux-kselftest+bounces-15317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C3C951BD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 15:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1201F22622
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96081B012D;
	Wed, 14 Aug 2024 13:28:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946811879
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642087; cv=none; b=CQDUJSN4NRRr0EU2njN2YKac0TJf8MXuexqiM89yut/7EYNX5On5Dp5k/vgyqr/q2x4eo81/XJpI8sw/JbOo/UqJQ0SCQrloh7fiWmfqaTlLJ7gAUuo6nIEPtbUGqfDyzmpfQq70l9OulGUqNOB1eC/iUdmrgReZc5SnURL26uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642087; c=relaxed/simple;
	bh=trKvhccKbOqrKAkK0fIjUhwMUFgvH+CeZAMgKLE94lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqyJBzo7WpRrR6crYkVjGHZ6mL2RTrq8UNCyGX02TM5BSBZJww2erAo8INCNfqdZ7+QrfDVTY7w2ZssGMA8vvP+zonW6FwpL8hsmqWmIHN/cMhacsRJIX1usaGSvMQAB/yxnPJjAVT5mNuw7BNwMBn7mrVKPFAQmRrNmwJb40yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E30DDA7;
	Wed, 14 Aug 2024 06:28:30 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D91B3F73B;
	Wed, 14 Aug 2024 06:28:03 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:27:54 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: signal: fix/refactor SVE vector length
 enumeration
Message-ID: <Zryw2o0lAzKX0ZDj@e133380.arm.com>
References: <20240812140924.2100643-1-andre.przywara@arm.com>
 <561f31a7-6813-499a-a6b5-83bccb69a3e0@sirena.org.uk>
 <20240813135546.6c91fc8b@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813135546.6c91fc8b@donnerap.manchester.arm.com>

On Tue, Aug 13, 2024 at 01:55:46PM +0100, Andre Przywara wrote:
> On Tue, 13 Aug 2024 12:00:06 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
> Hi broonie,
> 
> > On Mon, Aug 12, 2024 at 03:09:24PM +0100, Andre Przywara wrote:
> > 
> > > +		/* Did we find the lowest supported VL? */
> > > +		if (use_sme && vq < sve_vq_from_vl(vl))
> > > +			break;  
> > 
> > We don't need the use_sme check here, SVE is just architecturally
> > guaranteed to never trip the && case.  Unless you add a warning for
> > broken implementations I'd just skip it.
> 
> Ah, thanks, I wasn't sure about that, and wanted to mimic the existing
> code as close as possible. Will surely just drop it.
> 
> Thanks,
> Andre

Maybe at least worth a comment?

I was looking at this code the other week, and this puzzled me until I
went and looked back at the architecture.

Cheers
---Dave
> 

