Return-Path: <linux-kselftest+bounces-16795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452D9661E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546A51C210D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF1199942;
	Fri, 30 Aug 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xysu3aPx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5381898E5;
	Fri, 30 Aug 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021719; cv=none; b=UNFk29G3Yud1KYrku6IWZAkdEKtkxDmUzH38lho9wpnlilox9DXQnu5bi6yFwFsJp4ygScdXX3KClWsHfy/+p9MZPO7SlmtQIZBfeQkDk+uwVMvFisQ6OW3muADeugaSGiMQaIx1EVDTLVX+SEHWrEslPUr2AYxvS2nKuSHAHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021719; c=relaxed/simple;
	bh=D5HhCkXQX4yRjdGD7QmOEhonhj42UCq3giLzMl/+iqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suRxNgd5qexQUPRK8v4bEtOORzbrDF3tQDg8ycz4GBpNz36/r/1hQXPrKZcjhRaTC8SgqhPFUCo/W3mdWp6GXIdEAF2QdBJZzoHozMM8Z0u9qhWASvPVzkvv+94U8Q7PNRwvRWzWSdHg/JIZWB/FeEoQ/tFb9iw4gTJj+zDpmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Xysu3aPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7567C4CEC6;
	Fri, 30 Aug 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xysu3aPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725021716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5HhCkXQX4yRjdGD7QmOEhonhj42UCq3giLzMl/+iqs=;
	b=Xysu3aPxk9gqaPPw9eJs8PDHznvdVk/jJAzzYZB3aued/dJemICWfJy1ZuRkI/Qutjb9w1
	u540vDW7pnO7zUNjKq9vsuM9HR1fHcfe/tMLbcfVOWrLoPxcXqasNdgicyI1K5+JJ7ZhfJ
	JQxtOadin8G1W7lnR5RttpDno2HR+cA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b8d780d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 12:41:54 +0000 (UTC)
Date: Fri, 30 Aug 2024 14:41:50 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Shuah Khan <shuah@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@mit.edu>,
	"H. Peter Anvin" <hpa@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5] selftests: vdso: Fix vDSO name for powerpc
Message-ID: <ZtG-DqWo8kBMocVh@zx2c4.com>
References: <6c5da802e72befecfa09046c489aa45d934d611f.1725020674.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c5da802e72befecfa09046c489aa45d934d611f.1725020674.git.christophe.leroy@csgroup.eu>

Hi Shuah,

No 0/5 patch, so replying to the first one.

These are fixes to the vDSO selftests that Christophe is ostensibly
providing as a preamble to his work porting vgetrandom to PPC. Do you
mind if I take these via my random tree so his PPC vgetrandom code can
go on top of it?

Jason

