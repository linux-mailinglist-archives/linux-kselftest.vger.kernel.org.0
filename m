Return-Path: <linux-kselftest+bounces-7785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73228A2BBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 12:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D0A1F2319C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C98653378;
	Fri, 12 Apr 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmcw5Ldy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iit2OFQH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053F5467B;
	Fri, 12 Apr 2024 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916077; cv=none; b=MPxoiOCy2i4miAXxJN/c+I/tOGv7LGkPFkZtBdTWzB/eP7S5DTuoFCquEvpNdMQNuVnjimzc35HEG7milKMpfaJvCNuPURV5LBT1JfX/rKv3lwJWEenjtuwzzxv0wHkiD0LBHllkdCvPTWewTGjbJCbyR7RvRGfTTpsuwnKR+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916077; c=relaxed/simple;
	bh=/b/JY6+q8uW4ss7SkNT5zl6FCSo3lR6uNSQwGZE1dYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ojTWtxQiBanoubI5Trn1L1PYQ8iqKANA3XthLuOCu7UCJ4Qc1IWpfSBCRBfM3aVoRI4lMqJXxmIlr3j7UCEp4GPQ2lslM9vICV+RhlozCVEVED5AVQ58ma1WVA+lt6vQrGLXpFldCR7LU5cbZK8RbUwa1E+7kzufjXNU1+NAU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmcw5Ldy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iit2OFQH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lusYEh2FsMdpjmzFxzQyoNMi7sLpNoE7TBXwdEbGwiI=;
	b=xmcw5LdydkXw1n+fKYwVQ3fVFKzHOSPeHwdu9hjDlheWB8djh/KMrpi66NDJ0vZgLI1DuV
	WzUjwxhyddhGRawKvxxJ7FQ6soE2ZOhi9+QFt/2awG/+HvAzluHcJ/lJAWXSZinMCZoKWR
	4U7K1z5L8qeUz3PoXtmzCW2DhQBrbQlF0L3INm8OgapyxoA4lIOU9xvI1EBzTf/Ml5mIaV
	SlFdTI8AxnPOf4jsD7po2a9rcw9GcRgSgd1e2V9wvCgvBDgYeU04wECnroNchxmAK3o99p
	u2ErLPXovEvwojjjGaUzw+P2p0hWGd+0h4fupRiusoMxL6oSsPV7tSFGmCh+Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lusYEh2FsMdpjmzFxzQyoNMi7sLpNoE7TBXwdEbGwiI=;
	b=Iit2OFQHJ4cfHZdR273Hy/TtXz6YDSWchh1/+Q6fY10oYOX3HYFciGRh9VyZw8rMSVLdBd
	eqAkVcuLM7GsHtCg==
To: Shuah Khan <skhan@linuxfoundation.org>, John Stultz
 <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Lee Jones <joneslee@google.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests: timers: Fix valid-adjtimex signed left-shift
 undefined behavior
In-Reply-To: <dcb1a59b-55a0-4a33-99a5-3800660b04b1@linuxfoundation.org>
References: <20240409202222.2830476-1-jstultz@google.com>
 <dcb1a59b-55a0-4a33-99a5-3800660b04b1@linuxfoundation.org>
Date: Fri, 12 Apr 2024 12:01:14 +0200
Message-ID: <87v84mzyqd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shuah!

On Thu, Apr 11 2024 at 15:01, Shuah Khan wrote:
>
> Applied to linux-kselftest next for Linux6.10-rc1.

I took this already through my tree as I have more timer selftest
related stuff pending and coming up soon along with actual kernel
changes.

Thanks,

        tglx

