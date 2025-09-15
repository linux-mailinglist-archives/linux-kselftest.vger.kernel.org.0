Return-Path: <linux-kselftest+bounces-41468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B285B57355
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB8217730F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031F2F0689;
	Mon, 15 Sep 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cRRdwmmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CBE275B02;
	Mon, 15 Sep 2025 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925924; cv=none; b=KXj2P5xANaEk9kN4LEtp5YZkzTWJiWwJpgf4Ag/Wh0ciiPw5gr9VTL0wPpaz2RofytkO9geo00fc4doOOPTN0l50D2mZ0TT+wdqPR2lkoySUJkr7bqrbBOVyWP7qCJerGijmNiCifsKrle7MZg6nPPbE3YF9tNcnJP6nKuURelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925924; c=relaxed/simple;
	bh=OwQvqJhcj6BAWEZyrl7CaKqNbJZO3h3KE9AB37M7yyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgnWMDc793mNLVGsFE6oDyERw3qGsci64E0ieTWJCsn24C4d+P91Mdb8/scvTxAAz3aU+Mb+wqxtxBYb8BZWwEha3s7jLyIkvA6ujQFutOYoqlcnOz4IW812eUvhMpR13bBn6SmoNR1cTkC5Dr/12m/bvPPXlGCo10ktlTYd/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cRRdwmmj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757925920;
	bh=OwQvqJhcj6BAWEZyrl7CaKqNbJZO3h3KE9AB37M7yyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRRdwmmjba3LR4S3DYxn9cDv3cY9lET+O4RhVdJSs8Mgo74IeDwY9o5AnNrRzsPvb
	 aCEQk22aLUC3J0X0pdQdC85bLJJfVlrAHfJEf4SAGpYPnRcGQuVglBCdqAQPl46VGh
	 jyU0T+d+oUqO5KUeTubCg72fwyzGNpQmFHWHqSco=
Date: Mon, 15 Sep 2025 10:45:20 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 4/9] tools/nolibc/dirent: avoid errno in readdir_r
Message-ID: <97fd7c74-bfb5-4ff1-9698-e60d7b3c9a11@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-5-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915071115.1429196-5-benjamin@sipsolutions.net>

On 2025-09-15 09:11:10+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Using errno is not possible when NOLIBC_IGNORE_ERRNO is set. Use
> sys_lseek instead of lseek as that avoids using errno.
> 
> Fixes: 665fa8dea90d ("tools/nolibc: add support for directory access")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/dirent.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/include/nolibc/dirent.h b/tools/include/nolibc/dirent.h
> index 758b95c48e7a..61a122a60327 100644
> --- a/tools/include/nolibc/dirent.h
> +++ b/tools/include/nolibc/dirent.h
> @@ -86,9 +86,9 @@ int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
>  	 * readdir() can only return one entry at a time.
>  	 * Make sure the non-returned ones are not skipped.
>  	 */
> -	ret = lseek(fd, ldir->d_off, SEEK_SET);
> -	if (ret == -1)
> -		return errno;
> +	ret = sys_lseek(fd, ldir->d_off, SEEK_SET);
> +	if (ret < 0)
> +		return -ret;
>  
>  	entry->d_ino = ldir->d_ino;
>  	/* the destination should always be big enough */
> -- 
> 2.51.0
> 

