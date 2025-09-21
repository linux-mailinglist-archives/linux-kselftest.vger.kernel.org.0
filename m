Return-Path: <linux-kselftest+bounces-42013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D5CB8D6FF
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59603AAE87
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 07:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107452857F0;
	Sun, 21 Sep 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="DB4Dd6b8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F746B5;
	Sun, 21 Sep 2025 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441324; cv=none; b=gqSMQ3fjUtHQ1evzEhv0HHgOU8iE2CMiVpqMKXpa0f0XSwD55VvX5J6bA2+iNdI9EEwdbhABkrnCnoDlDjA5KXX0ibECZcwwxLMCHtXP6LekxvmrNXiV36QFGfLYVD0zBasuEN5MiFnt3HDA7eessHRo/68wz+gx2NMVG2TJCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441324; c=relaxed/simple;
	bh=lKDmDZHl4eHCumYTD88vWQjemvqbC5h5bl4ao4WRI00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/Sdee2120RyRNe4GUwAtW7eYLhtwG90ojollZqcjfN1jRFtlL4I4DiAch/xYexQJVLOUycjn7oBZfeHP8cXG9qSGTkvfBEGZTrGRqtvUKdCTvqApCfMS6eat7Na5pABTzYTIwRKHI5nt34mJOTwE3ZXLRrYXbRz765Szzo5PN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=DB4Dd6b8; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758441312; bh=qtuWRkILHisXI4pbHnjs5IBitzDy5cn+s0usEaACUk4=;
	h=From:Message-ID:From;
	b=DB4Dd6b8tztBECBsHoDwvgsxTvpTO3LN3rTHvuOFbuV7UUv81ZV/TS57SCmDLhsoP
	 L+QmDz5P1gv1qJRuw5BLp6veIeWYt4v/w2phbxq3VN9S/kTOMs72TxCWwPSqpsV6f/
	 w9noQs2v6lPOnb0mUBvm6XAxtZF3kDTHdK3Fd+jA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 005E0C072E;
	Sun, 21 Sep 2025 09:55:11 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58L7tBjS016692;
	Sun, 21 Sep 2025 09:55:11 +0200
Date: Sun, 21 Sep 2025 09:55:11 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921075511.GA16684@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919153420.727385-4-benjamin@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Benjamin,

On Fri, Sep 19, 2025 at 05:34:12PM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> the perror function does not make any sense then and cannot compile.
> 
> Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/stdio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 7630234408c5..c512159b8374 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format, ...)
>  	return ret;
>  }
>  
> +#ifndef NOLIBC_IGNORE_ERRNO
>  static __attribute__((unused))
>  void perror(const char *msg)
>  {
>  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
>  }
> +#endif

Please instead place the ifndef inside the function so that code calling
perror() continues to build. The original goal of that macro was to
further shrink programs at the expense of losing error details. But we
should be able to continue to build working programs with that macro
defined. There's nothing hard set in stone regarding this but here it's
easy to preserve a working behavior by having something like this for
example:

  static __attribute__((unused))
  void perror(const char *msg)
  {
 +#ifdef NOLIBC_IGNORE_ERRNO
 + 	fprintf(stderr, "%s\n", (msg && *msg) ? msg : "unknown error");
 +#else
  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
 +#endif
  }

thanks!
Willy

