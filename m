Return-Path: <linux-kselftest+bounces-18707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5597698B17D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 02:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C101F23879
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 00:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4EB63B9;
	Tue,  1 Oct 2024 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Ziv2p46J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608794A15;
	Tue,  1 Oct 2024 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743056; cv=none; b=tiXQwa/mg+URRk0wDWvAccI9umC7Qwu21I5J5muwEMiNATEYf/Ky7Qzmsw11u423jkmmh1Vv4SoS6C/uIE8EsijLfC4xqXhbDvH91P9AA6P98b252vRA7Eyh6fbjmJfOT12mhMB5bG8BQPKMmk5P1tIxOBRrXyl8y5NnaKHpKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743056; c=relaxed/simple;
	bh=PbrXzqLTbWY5KJDaeFj/n546b+9WTDMtsUAaXDexFTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYh/ht/LbDQ4gOK5POqXJG+ZrfTwL8kyCGMJA/DUkqYqQLs6WxYIEtzIXu2gshCq+xQybORdPuR++vZTJxbzsWvRr9Snli4xpdRPdKOvcsYvWCvDZqXqHzOOrx0p5A6gcMNTJQpJlwADp4BdZZaQYi6+7xyfwSNNHKkCRB8Aw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Ziv2p46J; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RhzDv+P0yHp7rVJxU5AwpoZg82v6v7rn8wwhs8V4CzU=; b=Ziv2p46JOi78oP1BjYuks6Yetm
	BYPTN68OFOVw1HnELeFXkbO+CispyjNFaIgie9zjIcPeToUwY1gXEvHij8YwFbkPrtpVP0VnXmmtw
	VnGzMvZEKtdrK0eJNwgWNhxjCkPGD4DVdnytageTWJ1xxr5W4MC1SjZD+FvLeh2n4A78cCfxtb6EI
	4ZKEewG8FMFGs0sQZAr6APUrd2ChcGqXi6si6ANRO7/NzuuSm7B+0uKIKQH+Z7x891CLgZedYi+Y8
	YalKRylc2TGiuiVfB4ROgOclg797c9AMK8bzg0PuYBF6v7QXrqncCDHwjpBxo11LKF60LkOBLSSlP
	Jt8FBu3A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1svQj9-005w9M-38;
	Tue, 01 Oct 2024 08:37:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Oct 2024 08:37:09 +0800
Date: Tue, 1 Oct 2024 08:37:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 02/19] crypto: testmgr: Include <linux/prandom.h>
 instead of <linux/random.h>
Message-ID: <ZvtENQJvp8h1uvdU@gondor.apana.org.au>
References: <20240930123702.803617-1-ubizjak@gmail.com>
 <20240930123702.803617-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930123702.803617-3-ubizjak@gmail.com>

On Mon, Sep 30, 2024 at 02:33:13PM +0200, Uros Bizjak wrote:
> Substitute the inclusion of <linux/random.h> header with
> <linux/prandom.h> to allow the removal of legacy inclusion
> of <linux/prandom.h> from <linux/random.h>.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
>  crypto/testmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

