Return-Path: <linux-kselftest+bounces-36687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7A5AFB3F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3826176E5F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C929B789;
	Mon,  7 Jul 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O34b06xr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nn1Otug6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E0725E44D;
	Mon,  7 Jul 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893849; cv=none; b=BXcC5GKLBwtS6zKHc0QDTG8kZspianHBcZ79Y2EFC1e1Bcv/zcF70AkmDJ5hWWa1Ndd9v58IAMA/lyneM/FQvF7aoR+0Sp1djCSuDDvAoyTI9MPNr/tZbu3ExtvHn04RLyok0jYUQwaMqO+MMba54lwOHUVnCHFQG+wt0UqNS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893849; c=relaxed/simple;
	bh=tzHwrP+v87nZrbUGJ+T0Y3+tQ2KwRXZ0Mc7BtfGk3MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8f9wDa5fLFlIo2ah52hmdjNXmMwDieYeF+oi9jYVo5hKhcCUx8xBk5+4N5OnCnWCETrxaI5YMzRMtTlLtOWVPQDcZW2azVezFsUAyk4dgaB1oSNoJGT+tCaiSG+6mtrZxrMYyeuXT8nM0coLQdQ5qWj7G3vpV0LKH7GRiqXBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O34b06xr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nn1Otug6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 7 Jul 2025 15:10:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751893845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3Fuerkv9gO0H7GSMbl5vL4PK+LUH+2hMI+xyID/KA4=;
	b=O34b06xrC9TsCQqtntWOquwXsDhTVh1hfULVM0RJXbyd/cvOnjYZ6DC7vGjwReSWsdthTz
	bVMfiRA4nC4/PKOTrAwH84W7tkoLAlxecdRF85jF1qdyG/87P3UM3/gu2/AyBe8lG6bN9V
	2vxmt16Xsqk8l6iAffxtPOhOqG5lhoFbUoSIZcPhrPwdFOm4FHxafAqpwOWPGytp+CeToy
	nTG4DolJHk91arpvSjaH1AJ0N3K7smlo16fuys8ZmwVyqYQGIC4HJ4DOLMQbjjZAG2POkn
	QriYakEuk4tlKMdBpA6rC3ZEVVgKC9nimuhQB6dP1YNY8x0Y9ettUkG2o0MhVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751893845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3Fuerkv9gO0H7GSMbl5vL4PK+LUH+2hMI+xyID/KA4=;
	b=Nn1Otug6wPRLaZZESngm43QDgHy/lEqsVLVkCDtfaHuzz+38Z6PFp2nT/N9NzaenWWz0xz
	utWJM3wK+pVymMAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Mark Brown <broonie@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/arm64: Prevent build warnings from
 -Wmaybe-uninitialized
Message-ID: <20250707150830-51f97f11-6ee8-4d91-840d-a7d3a9bc636b@linutronix.de>
References: <20250625020138.3777454-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625020138.3777454-1-anshuman.khandual@arm.com>

Hi Anshuman,

On Wed, Jun 25, 2025 at 03:01:38AM +0100, Anshuman Khandual wrote:
> Arguments passed into WEXITSTATUS() should have been initialized earlier.
> Otherwise following warning show up while building platform selftests on
> arm64. Hence just zero out all the relevant local variables to avoid the
> build warning.
> 
> Warning: ‘status’ may be used uninitialized in this function [-Wmaybe-uninitialized]

Can you give the following patch a try instead?

https://lore.kernel.org/lkml/20250707-nolibc-waitpid-uninitialized-v1-1-dcd4e70bcd8f@linutronix.de/


Thomas

