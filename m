Return-Path: <linux-kselftest+bounces-42023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0759AB8DFEC
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 18:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73D53B4EBD
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93161254846;
	Sun, 21 Sep 2025 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Mb0PqSL9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C32522A8;
	Sun, 21 Sep 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472662; cv=none; b=fFIIx187LoR6QiC352gaHXjqPiXwTwZP7OvouV0OW8RoMCgcSNm4NaZms6ur8W7Ph23ZOf6uOpKtsPfCFrHvNs4+tkD5qKfxsSUpWBiN2ozOcFbSeodyW3Ok5Wr8o7q3N90TkjUI06IvrmdlFGYOExt5ReBmfLwAFP5DW3RMvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472662; c=relaxed/simple;
	bh=7JvBPeJoxKqTRyUBKzE8ehwiAfyw1+bPlIevTM3eY5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R85SRbwRNeoz8LieNr4TnYqPHPFmkTmpvsvXjW/4HsmxuCODuaPE2E6Nm29gkHZH5j+he/ydqLIuPyIDVDqecz7thPi2tOp9GLrYrNThML+UecugSAgwUZ1Uz7v51e7W3N8tdW2TeDuGAs2n029lAGUedZq9gyRDkSuHy+WDq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Mb0PqSL9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758472650;
	bh=7JvBPeJoxKqTRyUBKzE8ehwiAfyw1+bPlIevTM3eY5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mb0PqSL91m8i4951Fstrdpubh9U1v1a53JdmQxCU9diI+Bskx+JxdPgSrrdpMg9ly
	 72CIQue9FqDAWbtLzX58n0oHUC2PdnEyOGEj2oLsC/ui3ilnckEELVJBGz8ifkMg/n
	 Wleb+z0eSgBEklXghZFaRgYzSo685DbgWwZTMhhM=
Date: Sun, 21 Sep 2025 18:37:30 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250921075511.GA16684@1wt.eu>

On 2025-09-21 09:55:11+0200, Willy Tarreau wrote:
> Hi Benjamin,
> 
> On Fri, Sep 19, 2025 at 05:34:12PM +0200, Benjamin Berg wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> > 
> > There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> > the perror function does not make any sense then and cannot compile.
> > 
> > Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > Acked-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/include/nolibc/stdio.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > index 7630234408c5..c512159b8374 100644
> > --- a/tools/include/nolibc/stdio.h
> > +++ b/tools/include/nolibc/stdio.h
> > @@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format, ...)
> >  	return ret;
> >  }
> >  
> > +#ifndef NOLIBC_IGNORE_ERRNO
> >  static __attribute__((unused))
> >  void perror(const char *msg)
> >  {
> >  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
> >  }
> > +#endif
> 
> Please instead place the ifndef inside the function so that code calling
> perror() continues to build. The original goal of that macro was to
> further shrink programs at the expense of losing error details. But we
> should be able to continue to build working programs with that macro
> defined. There's nothing hard set in stone regarding this but here it's
> easy to preserve a working behavior by having something like this for
> example:
> 
>   static __attribute__((unused))
>   void perror(const char *msg)
>   {
>  +#ifdef NOLIBC_IGNORE_ERRNO
>  + 	fprintf(stderr, "%s\n", (msg && *msg) ? msg : "unknown error");
>  +#else
>   	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
>  +#endif
>   }

For the plain `errno` variable and printf(%m) we don't have such
fallbacks. With NOLIBC_IGNORE_ERRNO the compilation either fails or the
results are undefined. Personally I prefer not defining perror() here.


Thomas

