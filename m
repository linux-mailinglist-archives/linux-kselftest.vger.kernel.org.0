Return-Path: <linux-kselftest+bounces-49139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B228CD2F5D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 11:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F175B305A462
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF5135F8CD;
	Fri, 16 Jan 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oHWRvHPv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928131960D;
	Fri, 16 Jan 2026 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558391; cv=none; b=NawAbWZyh/ZuaJuOPmAkP6TcJevzxHClpDjzWF1M5bOgqXp0nVuC0P/FxoiF69WFi67qAiBUUeaBxV5sujmBm0F+BETz1e9vEXlpYGVSpnvKUeUmOZp401ctOhtop0AJGG5YR3vVgJ4RhL0RZZiGP1ZX2q0O2g6ghLgMSUEfhi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558391; c=relaxed/simple;
	bh=dD4ktUXSdzPxh0/i3Mr5JrynjVkQ61mtOqVLiI9+UHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyUPzxEpquodOFXaSVp8KmApb0CW2/xDQwdElmZZRR+zYamx8I/xu1pkcc08YCQtNemRIN07/53sdfP65+Qh+o0Rr78KfVLRuRWPU6kTlTBdrvBCVTs48Gk9dmtPxVG93ATOFgf8KsXFh6yPyzAeJ4Ian+rnrI7EALgDdhWlkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oHWRvHPv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 935271A28A8;
	Fri, 16 Jan 2026 10:13:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6129560732;
	Fri, 16 Jan 2026 10:13:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E19110B68A09;
	Fri, 16 Jan 2026 11:13:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768558386; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CPzGsjCOcQw08nSbm42HGUOHFechIwaV6RDhIkpehf0=;
	b=oHWRvHPvq0FBMMzmrorg/CGO2/SQ8eG4KA8rBOT6wf4NHgzLFLkEzG4+n2F7DEPsAyFtWt
	4QwJpreD0EHxEk0Huq8kmNHVhwrSE8ItIcReRuQrgYkC4L1lhw8BDr4xGBmbcZUbsWfoD5
	XgOmAfAOYgozh+Je98icNPsIMJ9sClntRW6SRupT5FiaXByY2pixWEBrru7a0f0q9bdTVS
	GJfWPXosWKmm2DpUItcb+riwG6IYpP+R3zoGuV8fsa7aw3y9r+3/2QtRovSyP+qGZO3jUc
	IGNYPQ0On53Yova6TZnUuOMrEDKuHKSh8iIZZ/eIjPbc9EAc9VmIgyhmY2l7RA==
Message-ID: <f6fef672-a657-451c-b60e-d9786f743cc4@bootlin.com>
Date: Fri, 16 Jan 2026 11:13:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: net: csum: Fix printk format in
 recv_get_packet_csum_status()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <8b69b40826553c1dd500d9d25e45883744f3f348.1768556791.git.chleroy@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <8b69b40826553c1dd500d9d25e45883744f3f348.1768556791.git.chleroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe

On 16/01/2026 10:48, Christophe Leroy (CS GROUP) wrote:
> Following warning is encountered when building selftests on powerpc/32.
> 
>   CC       csum
> csum.c: In function 'recv_get_packet_csum_status':
> csum.c:710:50: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>   710 |                         error(1, 0, "cmsg: len=%lu expected=%lu",
>       |                                                ~~^
>       |                                                  |
>       |                                                  long unsigned int
>       |                                                %u
>   711 |                               cm->cmsg_len, CMSG_LEN(sizeof(struct tpacket_auxdata)));
>       |                               ~~~~~~~~~~~~
>       |                                 |
>       |                                 size_t {aka unsigned int}
> csum.c:710:63: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
>   710 |                         error(1, 0, "cmsg: len=%lu expected=%lu",
>       |                                                             ~~^
>       |                                                               |
>       |                                                               long unsigned int
>       |                                                             %u
> 
> cm->cmsg_len has type __kernel_size_t and CMSG() macro has the type
> returned by sizeof() which is size_t.
> 
> size_t is 'unsigned int' on some platforms and 'unsigned long' on
> other ones so use %zu instead of %lu.
> 
> This fixes commit 91a7de85600d ("selftests/net: add csum offload test").
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> v2: Removed use %zu instead of %u and removed Fixes tag
> ---
>  tools/testing/selftests/net/lib/csum.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
> index 27437590eeb53..e28884ce3ab39 100644
> --- a/tools/testing/selftests/net/lib/csum.c
> +++ b/tools/testing/selftests/net/lib/csum.c
> @@ -707,7 +707,7 @@ static uint32_t recv_get_packet_csum_status(struct msghdr *msg)
>  			      cm->cmsg_level, cm->cmsg_type);
>  
>  		if (cm->cmsg_len != CMSG_LEN(sizeof(struct tpacket_auxdata)))
> -			error(1, 0, "cmsg: len=%lu expected=%lu",
> +			error(1, 0, "cmsg: len=%zu expected=%zu",
>  			      cm->cmsg_len, CMSG_LEN(sizeof(struct tpacket_auxdata)));
>  
>  		aux = (void *)CMSG_DATA(cm);


