Return-Path: <linux-kselftest+bounces-16913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D8967BAF
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 20:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC43280DC4
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11877183CB7;
	Sun,  1 Sep 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eLtfise2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBE26AC1;
	Sun,  1 Sep 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725214273; cv=none; b=liBkrgm2CFm5RuME1kBGjsTulHHpGPtCOwwAHV6olD0LVMUpJ8wl78aJQXyP7Oz9E6Drgkzx2D7Jneb3nEmH5Q4MEkJJv2tlGs4YLms/dBOCN/Pj2YlnMpGv/PcpIKxMJPRnNgFhBm53uW63UD3Nyb7WwI+jP1f5Q88lDH4QvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725214273; c=relaxed/simple;
	bh=9X6g5Ts9OHDKRyfwQUe0lOf8edLMyW3PxRfHYH1GI0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgblE4yiVtuaYGsLPjp0MfoFEjKx3bl85Tto3Egy9vlbJ8qRdDQkC3M2kDxIi5JcRmE9ye6jgdKdKFGz7T7x+b3cCsLvkKsNOmK1Z/rEU52CsnQcLTzQqKDUKlGhSxz574sVpnaQoY/lG6oy1xPQ8wkaEE89gXECYP9IYZNoE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eLtfise2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BFFC4CEC3;
	Sun,  1 Sep 2024 18:11:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eLtfise2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725214269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mospxNQzEQmi1xlnzeu/+oljFVFe5zggEA3f9yO5JcU=;
	b=eLtfise2dOqooXx5gFA6w1/NpU4xUGopgeSBn9jGRac1l8u8/q+3lHv3SVPcJhs3wIwY1b
	FF0GrRxD8NbNk9xNTQjx50ZcqAwXBTImtmW1im/vz5cdldvXrXD61E1gAjxnB3TTbJNKF6
	kb3N8lUKqbQzsVpXcL85xx7XrcEdVIs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9082c1bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 1 Sep 2024 18:11:09 +0000 (UTC)
Date: Sun, 1 Sep 2024 20:11:07 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: vDSO: Build vDSO tests with O2 optimisation
Message-ID: <ZtSuO2Bzbo5wL9se@zx2c4.com>
References: <46efa1f62e1604c98d10a1b6856a2b2aec0cfe9c.1725211324.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46efa1f62e1604c98d10a1b6856a2b2aec0cfe9c.1725211324.git.christophe.leroy@csgroup.eu>

On Sun, Sep 01, 2024 at 07:24:03PM +0200, Christophe Leroy wrote:
> Without -O2, the generated code for testing chacha function is awful.
> GCC even implements rol32() as a function instead of just using the
> rotlwi instruction, that function is 20 instructions long.
> 
> 	~# time ./vdso_test_chacha
> 	TAP version 13
> 	1..1
> 	ok 1 chacha: PASS
> 	real    0m 37.16s
> 	user    0m 36.89s
> 	sys     0m 0.26s
> 
> Several other selftests directory add -O2, and the kernel is also
> always built with optimisation active. Do the same for vDSO selftests.
> 
> With this patch the time is reduced by approx 15%.
> 
> 	~# time ./vdso_test_chacha
> 	TAP version 13
> 	1..1
> 	ok 1 chacha: PASS
> 	real    0m 32.09s
> 	user    0m 31.86s
> 	sys     0m 0.22s
> 

Seems reasonable. I'll queue it up.

Thanks.

Jason

