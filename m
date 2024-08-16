Return-Path: <linux-kselftest+bounces-15544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35358954F6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C302822FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFA81BE85C;
	Fri, 16 Aug 2024 16:59:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593F077113
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827554; cv=none; b=T+3Gr6L13vsqTXoafrDxNbpcx15s+5skS6yPxphhK7zONsCNwwH13aF4YX7CIIDI39K6Y4tnW1G7bNPqgZfK//RJv7d+/kQizwPkmE95hin3Bc4UdNiUo20z4S+Bye8GJ6tXZOs/SQI5pbrjLvUHOjT/whWKnUAuoq7y9rVly7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827554; c=relaxed/simple;
	bh=rTu1h9K04Gtcctupd+UjOoOe59ZK7VWWfTUNfczXwsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCp4CumbklKdsJfvxascdtNzqC3w6N/ZN21j5JClWCGisOzzZ+KBgKtfCaEvB7bJMGZL21Be6ec78al57N6NobL+hZ4enSBxUL8bpmBiFHYBAqGvZ11ba7SIP22Ndspyx5OGxdNUU2gYfBH6Oe1ckeklY/o7yNOWYNGgcg1LnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94A1A13D5;
	Fri, 16 Aug 2024 09:59:38 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636903F58B;
	Fri, 16 Aug 2024 09:59:11 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:59:08 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Shuah Khan <shuah@kernel.org>, Amit Daniel Kachhap
 <amit.kachhap@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 7/8] kselftest/arm64: mte: fix printf type warnings
 about pointers
Message-ID: <20240816175908.5f4721eb@donnerap.manchester.arm.com>
In-Reply-To: <f7d77597-cba6-42ee-9b50-ac4b7984aff8@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
	<20240816153251.2833702-8-andre.przywara@arm.com>
	<f7d77597-cba6-42ee-9b50-ac4b7984aff8@sirena.org.uk>
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

On Fri, 16 Aug 2024 17:32:39 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Aug 16, 2024 at 04:32:50PM +0100, Andre Przywara wrote:
> > When printing the value of a pointer, we should not use an integer
> > format specifier, but the dedicated "%p" instead.
> > 
> > Fixes: e9b60476bea0 ("kselftest/arm64: Add utilities and a test to validate mte memory")  
> 
> This is another one where calling it a fix seems like it's pushing it,
> it's a modernisation rather than a correctness thing.

Well, I get compiler warnings, so I thought "fix" would be adequate. But
in general this confusion between pointers and integers sounds not good,
and not using %p looks like a genuine bug to me (though it's admittedly
working fine (TM) for now).

> Otherwise
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks for that!

Cheers,
Andre




