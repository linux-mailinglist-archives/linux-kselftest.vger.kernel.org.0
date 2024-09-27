Return-Path: <linux-kselftest+bounces-18500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B29889A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB5D283316
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992B1C174D;
	Fri, 27 Sep 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lL0XU8kv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A69613AD1C;
	Fri, 27 Sep 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457851; cv=none; b=ZR7e1GwFqDhGe4riJRcNQbLxDmygbK+0nrEdw+DJNLzggwHVu2bUlkTLfmjjHfgDsowbwdYJqmvkPpljJE1tjRYerWN6gjwhC95p3IDiWFisAZwO8ZJtzNQBmix7WsFLC5WQafiPOkwIe1AZvdtT4OpUTbSOxgpf/7d7swO0pGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457851; c=relaxed/simple;
	bh=wnv7RPPgGCLIynbMHaq85HN0wyTllmJ1Kt4B7AqPZ04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp89X88MhZpHffIxFFvb5Qas/ze8B1mkYZ6iDHK3awUXUU3HuyiAD5CNdMJqGMvXf5TkHEnhb7235OCMw0fAzl8OA5KXvBIpb+84pHac14WNP6MUzrf8OX6zQOzhgU4E/a5wffLtdH54PyDGcXlJwVxzKab2o/YFsVLu/3jsUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=lL0XU8kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6EEC4CEC4;
	Fri, 27 Sep 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lL0XU8kv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727457847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BequuRoJr1pAWOgY2c3ww2p0CVBUraXUs5WRnDceAkw=;
	b=lL0XU8kvoFp6NdtHZLgjSD5mVsgYWyEiVmL/m5DIArEYdF+dhYgE7lPdlsUxBnrWdQQK4M
	wSs79zMYy328fMX+DEtGGSoj4Qc5XqvvVy5t7Ee/E49slo3LuldbUvf2eBuUzEpqkBGEcH
	0a0UAD8/Qtc50D7Uu/m21PSOuW3KUZ0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1df0590a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Sep 2024 17:24:07 +0000 (UTC)
Date: Fri, 27 Sep 2024 19:24:05 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: christophe.leroy@csgroup.eu, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Cc: kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] selftests: vDSO: align stack for O2-optimized memcpy
Message-ID: <ZvbqNZz547IGq7vy@zx2c4.com>
References: <202409241558.98e13f6f-oliver.sang@intel.com>
 <20240924115001.916112-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924115001.916112-1-Jason@zx2c4.com>

Hi Shuah,

On Tue, Sep 24, 2024 at 01:47:23PM +0200, Jason A. Donenfeld wrote:
> When switching on -O2, gcc generates SSE2 instructions that assume a
> 16-byte aligned stack, which the standalone test's start point wasn't
> aligning. Fix this with the usual alignnent sequence.
> 
> Fixes: ecb8bd70d51 ("selftests: vDSO: build tests with O2 optimization")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409241558.98e13f6f-oliver.sang@intel.com
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
 
Just FYI, I'm expecting that this is a patch you take through your tree
for 6.12, and hopefully before rc1, as automated testing is failing.

Jason

