Return-Path: <linux-kselftest+bounces-38549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A3FB1E6D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 12:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0A9565EAA
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255725333F;
	Fri,  8 Aug 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VEQX2CzC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yW/vCaSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A15246BD3;
	Fri,  8 Aug 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650479; cv=none; b=UhX7ZhiE5RHht9G7ZKP6iluG0dgTWeaTMWaNV3OUpyHwf5ZB7EaSQyvR70axT1PL7AGNwpqB7aSjzt7OsUYbH2Zt4KhcbLA3j18QSVdJ9dgS+YjCf8Co8uKzWjLKwapRt8w3kCVMFJNGOmdvivIRPhBu8nn/mODxxpmCLOlPfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650479; c=relaxed/simple;
	bh=SeqFsg92gTjt6oNuIFtbxosj0dfjvbF+NXlUxNZKgNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5GbIMwWstxPDGt6QFIGx0VOueW02Oc0/KsTDAvyd6NHJwJMgZZYCTj0cDcKS7yoygto31gTqw3QU9TfWVNlTl+3+8m6/o5UXnakPgub1bPu+mH8IgOI4eK2ncu7+8wT/ljkQ7w/bsHjgVOrI9nhN68mj7XblF4+ReBER4U/ez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VEQX2CzC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yW/vCaSQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 12:54:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754650476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5vnCU1O/Ixk0NZvVID0rNo65pgIgk5MYdY/Hc45WZJU=;
	b=VEQX2CzC5qh0rsPOzTUgtodAwX1Yp+yjc41JaE7uDlShCQ87MyaeAqeLSHdIWZTbAAqteT
	6oxijT6P6jPQQdzP3++m5CESXvguaGNpxSPCGRZBA4mi9tIe+aPJqqRbct2ZgX54OWe1+8
	ZQ0itC+BZZQQV1qLL74quNLGXc0n9a3dLNDxgdYywrTvM2PnP/kitemafOmTCk4BhUiobl
	3/m8gjrN3SLFwhcfcr/UNLZKlInhWJoYGrg+G9hH7zD6cHf4XaVflv6trxuIhfkivuuMGV
	XB4VxOx3yz5xX5VrmnSd81AOuEQZPY+exEZhPow7SGKolS1DFW3Z99LCQrkXIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754650476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5vnCU1O/Ixk0NZvVID0rNo65pgIgk5MYdY/Hc45WZJU=;
	b=yW/vCaSQpqSv3ZTerxozLf+j03Sfmnsnaj2SINuUs4gjXrlmjv0Nf1f29AoCgBykjRfwiz
	p/UNw/rgOEUlCfAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: selftests/futex: issue with -g option help text
Message-ID: <20250808105435.PYwBvZ-6@linutronix.de>
References: <2e01e85c-a833-4725-8a62-156c737422eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e01e85c-a833-4725-8a62-156c737422eb@gmail.com>

On 2025-08-08 11:40:23 [+0100], Colin King (gmail) wrote:
> Hi,
Hi,

> Namely:
> 
> static void usage(char *prog)
> {
>         printf("Usage: %s\n", prog);
>         printf("  -c    Use color\n");
>         printf("  -g    Test global hash instead intead local immutable
> \n");
>         printf("  -h    Display this help message\n");
>         printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
>                VQUIET, VCRITICAL, VINFO);
> }
> 
> 
> there word "intead" for the -g option should be removed, but I'm also
> finding the resulting text hard to parse, perhaps it needs to be rephrased?

   Test global hash instead instead private hash

?

> Colin

Sebastian

