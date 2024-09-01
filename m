Return-Path: <linux-kselftest+bounces-16912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829D9967BAB
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FA0B20A66
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A118454E;
	Sun,  1 Sep 2024 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="E7YjuNk0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B817E8EA;
	Sun,  1 Sep 2024 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725214099; cv=none; b=qw0XzuyglWtqZ6bJn7N5EIB+Crk+4wWHVZgpgtpSO1anSNbOsRlAiYmY2cjLPVVy+Mz503sJzcinQpg2bXH9Jp+jsk0d6bxaebUJCFIbgXy1Kp9nLFdx5fASi8aVeujaaYyztKjWK793RqBF12XJ5JYQgRf0W52bz/1iwE2H9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725214099; c=relaxed/simple;
	bh=6106yr3WQ3UcfRTu0ZouwrH98zSis+pqwH78yprtdEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ4OQ8UauHmnwR61LBjOXyd1BeSp7EIlb45oq6Hr6P+o64ikFJEq6t2Ojn8XHvWHCysRCjTMuNhinVzLmLzXA2LIu/e2Df3te4lZsJ0K5YIoQ0QWI6S4ZgCSr62ZemT6ZOVTk5V5TViY2idYH6iuk1Zm9uCqsK1Olp+NI43LoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=E7YjuNk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136D5C4CEC3;
	Sun,  1 Sep 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="E7YjuNk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725214096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDcbmJFVf51B3DxM7aIxiA7R5RQ5bYbOxlx/Tq3o184=;
	b=E7YjuNk0zpHf+yksVPfbo/nQ72vo8pY5DqufJkzPd5LMag1IeraDXdasiNltC7NhrvEU5C
	EGOw+nxG2LiejYjHNqTMtGD2ZGPSx0a6pmrVWHdSNakLRAwK3iqTEpmeB3+mu29zk903Ix
	BrYVYIwP0k+6CdWnWlsDUb0Itv5vvHo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5b555000 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 1 Sep 2024 18:08:16 +0000 (UTC)
Date: Sun, 1 Sep 2024 20:08:13 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: vDSO: Also test counter in vdso_test_chacha
Message-ID: <ZtStjU_3K9yIJsmp@zx2c4.com>
References: <f9f64c5ded3925ae408f01c1c61e2fdf6f645a71.1725212364.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9f64c5ded3925ae408f01c1c61e2fdf6f645a71.1725212364.git.christophe.leroy@csgroup.eu>

On Sun, Sep 01, 2024 at 07:40:33PM +0200, Christophe Leroy wrote:
> -static void reference_chacha20_blocks(uint8_t *dst_bytes, const uint32_t *key, size_t nblocks)
> +static void reference_chacha20_blocks(uint8_t *dst_bytes, const uint32_t *key, uint32_t *counter, size_t nblocks)
>  {
>  	uint32_t s[16] = {
>  		0x61707865U, 0x3320646eU, 0x79622d32U, 0x6b206574U,
> -		key[0], key[1], key[2], key[3], key[4], key[5], key[6], key[7]
> +		key[0], key[1], key[2], key[3], key[4], key[5], key[6], key[7],
> +		counter[0], counter[1],

While you're doing this, also add the remaining, `0, 0` elements.

> +			if (memcmp(output1, output2, sizeof(output1)) ||
> +			    memcmp(counter2, counter2, sizeof(counter1)))

counter2 will always be counter2. You meant for the first argument to be
counter1.

> +	reference_chacha20_blocks(output1, key, counter1, BLOCKS);
> +	__arch_chacha20_blocks_nostack(output2, key, counter2, BLOCKS);
> +	if (memcmp(output1, output2, sizeof(output1)) ||
> +	    memcmp(counter2, counter2, sizeof(counter1)))
> +		return KSFT_FAIL;
> +
> +	reference_chacha20_blocks(output1, key, counter1, BLOCKS);
> +	__arch_chacha20_blocks_nostack(output2, key, counter2, BLOCKS);
> +	if (memcmp(output1, output2, sizeof(output1)) ||
> +	    memcmp(counter2, counter2, sizeof(counter1)))
> +		return KSFT_FAIL;
> +

Why repeat these two stanzas? Also, same issue with counter2 used twice
in that memcmp.

