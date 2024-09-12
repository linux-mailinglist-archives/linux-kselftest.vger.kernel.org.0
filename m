Return-Path: <linux-kselftest+bounces-17796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3D99760EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 08:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF1F1C22C38
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 06:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E618890E;
	Thu, 12 Sep 2024 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Dut6C6Eb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EF5028C;
	Thu, 12 Sep 2024 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121206; cv=none; b=OPFLUE/o6e+3T2Tb2pvD9KtIFWj+a8m24fO3ZKe3qtrP6Svz8Lsx/QLYhit8BOT+8waWYyirCcr/CBu1rT7obiDjRmf+FIoB0LPFX3Uu4KD+91WDgbjFS4adXSHvLoPCoZc3z71duEe33djb1EbtuoSrRFVF2RVBxoWcRrWLb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121206; c=relaxed/simple;
	bh=mN+R3ToxhkuxGdCM/aq45jOkr3+/T3AE3qU1LI66plA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jzmRXal8z/FS1sfw8Qup1byplC0/gc7oOYZw9jEmrBrC/jquKyBFPHpxyYC9B+fhgHy7ukc/9DffURjhgcqEg4g35mvteZa3fI4825PtWjgc8FXVTcv/RUPoAsA9bIwtybif42DJ3GslkHkjG9JO7prdRJT7TJMocmsWKrQUwlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Dut6C6Eb; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3xlRzXI9yb+oNIsqCP0Wa4u5a4LZve9QqMy4C7Th5mc=; b=Dut6C6EbXHKl46S1QMOW38R/r8
	3ekj8fbSVpa3M/4/NfVU0/L2n4YksdJhPe6RCzswqcuWg3XU0BC0sZSZebL3LtKud0noRiobvGk3s
	s/vCZiFAoEpUs3s3m9eG2GLI2hq9hOkVu+/Pyiz7KuUe6mkob8ueP+ie3hXBRJSLcpskkGSmRSJDN
	qrau35IL7NHMtOaOM/vu6KRhLjNPt0bgnC3Zh6h5EfMCiahs5z3wgoDQcFxfm3fN4JbbCQ9+0fccb
	D2WcU7+AMLG+HPRlw3XBvisLeOAhLALpq8oK72eukqxOqnZIqQZ9rgtSG88tBc821hJ2S4hROU7Jq
	VRGE9A6w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1socoG-001u5Y-2v;
	Thu, 12 Sep 2024 14:06:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Sep 2024 14:06:18 +0800
Date: Thu, 12 Sep 2024 14:06:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	ubizjak@gmail.com, davem@davemloft.net
Subject: Re: [PATCH RESEND v2 02/19] crypto: testmgr: Include
 <linux/prandom.h> instead of <linux/random.h>
Message-ID: <ZuKE2sffS3wddU3-@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909075641.258968-3-ubizjak@gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel,apana.lists.os.linux.scsi

Uros Bizjak <ubizjak@gmail.com> wrote:
> Substitute the inclusion of <linux/random.h> header with
> <linux/prandom.h> to allow the removal of legacy inclusion
> of <linux/prandom.h> from <linux/random.h>.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
> crypto/testmgr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

