Return-Path: <linux-kselftest+bounces-25656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6929DA26F96
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0783A4317
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198D620AF97;
	Tue,  4 Feb 2025 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxoUsYWn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0DC20AF69;
	Tue,  4 Feb 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666377; cv=none; b=asxQtKDrzqB8u3R+2Mg146bLqKDnq6fxVpSTtrn5zQV7S8lxpULtSWw4o1HYp/xHUK51zJb0c66YI8itLs70VbLOWJADicNqLO4ZSq1zBLErvbPWiuGdtXAiJ3Prx5liqrO4o/+CiLwa96GFlWEC13wFIWS7LpKNYJghNgT5iQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666377; c=relaxed/simple;
	bh=9d4/gBYvqMNyQp+nCbwY4qBNlFydNGFAOPyBNTetf6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV627RomfF9okLeY4VgVKb1Jpo2+Mic1au7x+faPH/Udrll3EzMyK8OVw1KvryBNzRQqjahf6gTxaDPhrTNOhJWkuvrVLLABPR0BMOM3MyKumH4cRw141Ecjky42uQrNQ6zLWq8XCqLvfjz6PpFmA3MvrpJ5h0aDM0+ff27MJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxoUsYWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204D9C4CEDF;
	Tue,  4 Feb 2025 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738666376;
	bh=9d4/gBYvqMNyQp+nCbwY4qBNlFydNGFAOPyBNTetf6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxoUsYWn6U2/ajJt7DaA3LCVADvRHNZ3061UfLLEGHjMgUvClfoaojxl0bMa70M2o
	 zlT0cXqCbLvP8KvTG5ngvjBXcTn6rc5Gntxn9uc7cmRXqjGsCoAErhB8UWZeGg0EBT
	 ytnhl7ILWKs0YpThsCg7Y2U9JsBI53IbS06iFWpltoSOsy5ofn7LVnpulHUPv9TMUz
	 gnUW2LX3TTLM+JVNeMTuNunEuoJY6uFoVCYenO7Z/sYnWvfyhgbLeaHq2vX5jC2R8P
	 b+yLOqIGLSa7ZHbUebb8QK5Bnc1xTqnAy+DouxeCK6nQAnYakFE1uQ1+BbXutijqdk
	 eeAFKbvNYLGVw==
Date: Tue, 4 Feb 2025 10:52:51 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net-next v3 08/10] net: pktgen: fix access outside of
 user given buffer in pktgen_if_write()
Message-ID: <20250204105251.GO234677@kernel.org>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-9-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203170201.1661703-9-ps.report@gmx.net>

On Mon, Feb 03, 2025 at 06:01:59PM +0100, Peter Seiderer wrote:
> Honour the user given buffer size for the hex32_arg(), num_arg(),
> strn_len(), get_imix_entries() and get_labels() calls (otherwise they will
> access memory outside of the user given buffer).
> 
> In hex32_arg(), num_arg(), strn_len() error out in case no characters are
> available (maxlen = 0), in num_arg() additional error out in case no valid
> character is parsed.
> 
> In get_labels() additional enable parsing labels up to MAX_IMIX_ENTRIES
> instead of (MAX_IMIX_ENTRIES - 1).
> 
> Additional remove some superfluous variable initializing and align some
> variable declarations to the most common pattern.
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

...

> diff --git a/net/core/pktgen.c b/net/core/pktgen.c

...

> @@ -872,7 +886,8 @@ static ssize_t get_imix_entries(const char __user *buffer,
>  		if (size < 14 + 20 + 8)
>  			size = 14 + 20 + 8;
>  
> -		len = num_arg(&buffer[i], max_digits, &weight);
> +		max = min(10, maxlen - i);

Hi Peter,

10 is used as a magic value here. I think it would be best if
it were a #define so it has a name. Likewise for other constants
used as arguments to min() in this patch.

...

