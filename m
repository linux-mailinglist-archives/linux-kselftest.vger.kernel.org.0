Return-Path: <linux-kselftest+bounces-3245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D4F832A9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 14:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F901F24FCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D352F6C;
	Fri, 19 Jan 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC6t6GIz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE14EB27;
	Fri, 19 Jan 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671588; cv=none; b=ctJzBBQia16LwRLJ52fK4SizZzvMyPN5epwJFtJ38NEKXIR+KDgIQq6TWhhACPjKMl05aBqXEqMCiIhUlAnXBVVnmsoV2jgRpazWDBO5aWhoEGXMT4stjXxBb86BGPwX0F6MHCh1FvSNxeFM9QbDL56DQ+BxRsCSRP2DSjZIw58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671588; c=relaxed/simple;
	bh=0e3299HIfeGN0FOc/l05T16XyLWG8o2Q+NeqnbVKOEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ4Xm2BD49X2Dx0TDW8HDTg0oGyDb10aqxGiQ9anhucZPtgEbWCp12TWirS/8EqGsPVWMMdc3toPq1Mf9ttUg3N5Mz2SDEOtNrkNiqf2hdJedQGLh6REGaUfbEt3aSmCwwDWAVN1/2Miq3kTY6I+Q0EaP2ss+I1bLbZchPngWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC6t6GIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AB1C433C7;
	Fri, 19 Jan 2024 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705671587;
	bh=0e3299HIfeGN0FOc/l05T16XyLWG8o2Q+NeqnbVKOEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VC6t6GIzV1VygwqCER/Nr6tzYJGTv7V6ntBXydwwK/WpZjt3olAeW/3mCNmBvl/p4
	 CNdib6G77tuULPM3HCbtFCdLclLmdoBc/UU63e5luRVfBxQ8PZnR7jvAf39HaFNODT
	 Dz4t/6t6RCWx1IsqBEpFaf32anCTN6eU36cOjNhqxa7xsqb8gT9Y1hKK0j1Czy5adA
	 KsO3nT2fqHjBqIHDX5Zu83zSH+mFlyxY/9d66dcLA0RK00hVYTI/emm/b9lWu6xR1/
	 4lgFjlif8m4k+jwMW2bWTIDd+1a+OmoSakzmri/CjSmjj6+0aG8kWt1d6aUSMLe8iX
	 yGYCrNqiGQLKQ==
Date: Fri, 19 Jan 2024 14:39:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Huyadi <hu.yadi@h3c.com>
Cc: "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "514118380@qq.com" <514118380@qq.com>, 
	"jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "mic@digikod.net" <mic@digikod.net>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIHNlbGZ0ZXN0cy9tb3ZlX21v?=
 =?utf-8?Q?unt=5Fset=5Fgroup=3AMake?= tests build with old libc
Message-ID: <20240119-zuletzt-unausstehlich-5a254df4450d@brauner>
References: <20240111113229.10820-1-hu.yadi@h3c.com>
 <20240118-sezieren-neurologie-6690110057ca@brauner>
 <8918d5e83d54418b9db3ee9c055d675d@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8918d5e83d54418b9db3ee9c055d675d@h3c.com>

> May I take the liberty to ask why I don't see patch applied to above branch?

Just wasn't pushed yet. It is now.

