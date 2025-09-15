Return-Path: <linux-kselftest+bounces-41466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5CEB57335
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 10:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797F816EC54
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 08:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA392D5C7A;
	Mon, 15 Sep 2025 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BKnF6KPS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DA29D260;
	Mon, 15 Sep 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925605; cv=none; b=CfVnmKUB5ZewcG1oGDl7MATBBEiIMpXdJbSeDFspB74NRbhLMtTNwNVx+owW1Q+djliDFooTh+MENDhVhCoB/9PM6T7Z7WdZ1qvOJYrK50rs8b+m6BF5KoTBNF7cdyOV4Cn8qtkx8JBQWBYVQcTqKwlHhUO1Hj0292ZJY9X53f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925605; c=relaxed/simple;
	bh=DEE0/mm3nae2M+afwZaoC+YIBs/g4NMHQTIGIKkxo3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktN3I8YWNTrFPYX+qxk8+XBYh4UHzMdVQLsqTdLDx7ysa/+4ebYqQThWabjepy0IVaGbGCHP3/+Fx6bbgj13ODVggAkEXWLh7y9ydXYSzFlV/mJbLSOHlNa9HBKNDSIQX8AxTM1lF5+CecHPjcCxjFFJ7IcrtBVpz6a/IMIxos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BKnF6KPS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757925594;
	bh=DEE0/mm3nae2M+afwZaoC+YIBs/g4NMHQTIGIKkxo3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKnF6KPS6FtHcqoF22gXtrxrlrGtR1DML9nfnuH453b1Ua6LIMo+qMwKkMX8I4Ixy
	 TSE2X4mAVyhttY4sMh/RAXs24EOjwm0Eguh+/p1TbVA8isdxmDqzujOcvWqC+e91WD
	 zrImBPHAs8lfcGEOs8OH6YXwL0IoQXMonKRq8jcs=
Date: Mon, 15 Sep 2025 10:39:55 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 1/9] tools compiler.h: fix __used definition
Message-ID: <231ba0cc-b568-4310-a96d-f899689fbfc9@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-2-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915071115.1429196-2-benjamin@sipsolutions.net>

On 2025-09-15 09:11:07+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The define mapped to __attribute__((__unused__)) instead of using
> __used__.

Can you explain why it is a problem and add that it now matches the
definition in the regular include/linux/compiler.h?

Anyways:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> Fixes: e58e871becec ("tools/lib/lockdep: Remove private kernel headers")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
> index 33411ca0cc90..b2c40621d441 100644
> --- a/tools/include/linux/compiler.h
> +++ b/tools/include/linux/compiler.h
> @@ -127,7 +127,7 @@
>  #endif
>  
>  #ifndef __used
> -# define __used		__attribute__((__unused__))
> +# define __used		__attribute__((__used__))
>  #endif
>  
>  #ifndef __packed
> -- 
> 2.51.0
> 

