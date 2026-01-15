Return-Path: <linux-kselftest+bounces-49035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F2D24E32
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 15:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A9643024881
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70137334C14;
	Thu, 15 Jan 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YT+/xq0R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8obr3nLf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB919E968;
	Thu, 15 Jan 2026 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486280; cv=none; b=JABVz7884XOGQeLLM9IfK+aXRxtJ7Ji9Oqh5IMTs+mbykpAUOQHMCgvX2SE9tcnzEgtBTnorCevBZcs6b7ZxBnbx30WYPv203PoO3KwYKSdCuTCnCMYqlvhgIl5+X/dtLqWhA7lTVs+1dd//VNWLVtX7yNwK23kne0lg4aWnM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486280; c=relaxed/simple;
	bh=iyuRrsLNB5IjB7BM5NAOUFxuK8uz/5Sy2ivw0/atpFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFhcuCri+qXYFbl5ly0we/EvCHTozl5UXkWc/EEoH+q5OFfY4jTugO9B0z2GFh6h7CuOApT5JpAdtFi1oWvxRyHnHpushrN1/BORVJqkOLDEtp6Kbnb8E+DfKM/1BkbgxFJCs1uifWAfVR5QmRQVTgz0+SHdEqpwS1vzVFmRbXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YT+/xq0R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8obr3nLf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 15:11:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768486277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RySapn2NeFzbRCBfZwrUCZiIpE9M9tjcAL8EpTI9i9k=;
	b=YT+/xq0Re5u6a0nGfrlqYLnm1HTBrN7JCFSWDdmOubEBKagb2+uWrdlsC1rKrolqfRiTTK
	2PmDnq+j0Q2bWxQjp/c9RMy59guiIn2Ui2RiaogOyB4loAaRiLH7YvpOuEq30b794cOlwu
	asIh8yV6JnPGDa8kIUXkIvSut6pcKY3mn0cYQxB47Am/fY6CapdM263czQvpSSDxLACRtj
	8aLMwAtiSxkr+gcEiEj0gcyFllaqWaASSfAsmXWR+vY9kKd+jnHMiuEm9Jd+Z63cEZUWsb
	4iMw4sLXBOL+WVeplFVAXb6SQLCI5vUNCQUDu2hW06MHnG82P7iopOHmdM3qAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768486277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RySapn2NeFzbRCBfZwrUCZiIpE9M9tjcAL8EpTI9i9k=;
	b=8obr3nLfBcjK2ShEIkwdreHgxqzsNsSjgfMUqE5XlwJwxSsMgW7bmJE+kaJQjq2k/3yaWX
	AwNY8JkIw4NP4XDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: vDSO: getrandom: Fix path to s390 chacha
 implementation
Message-ID: <20260115150904-39b7e692-4bf5-497e-865c-c8d71a097e82@linutronix.de>
References: <20260115-vdso-s390-getrandom-v1-1-771dfa6d1c6d@linutronix.de>
 <20260115140557.7060C9f-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115140557.7060C9f-hca@linux.ibm.com>

On Thu, Jan 15, 2026 at 03:05:57PM +0100, Heiko Carstens wrote:
> On Thu, Jan 15, 2026 at 02:56:52PM +0100, Thomas Weiﬂschuh wrote:
> > The s390 vDSO source directory was recently moved,
> > but this reference was not updated.
> > 
> > Fixes: c0087d807ae8 ("s390/vdso: Rename vdso64 to vdso")
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  tools/testing/selftests/vDSO/vgetrandom-chacha.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Should this go via s390 or will you take it?

You can take it via s390.

The test framework I am using lives in a custom branch anyways, so I'll
can carry the patch for myself. And nobody else seems to run these tests.

> In any case:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Thanks!

