Return-Path: <linux-kselftest+bounces-31197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4389EA942C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E7E8A4FCD
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C31ACED2;
	Sat, 19 Apr 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RnFR0kyj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31860136347;
	Sat, 19 Apr 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745057433; cv=none; b=OCZ9rDY5g6CFRAT7jovH/tsqVAIHVPWV+SGwlTZlp08Z3/gwqsCG+qeHhkCeNdf4AYpaJp3Vl2aXOX3pcQjK44p13kSkwZbwdz57gYbsXE5WCt7W/ivtNfzBUxauO0nUJXBiF+wtl0wKaaAvAy+DM1dwxTxQiZxJUqSVMMAe2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745057433; c=relaxed/simple;
	bh=BysPsT7ANdRFjBu/Ui8fcsmGFHpnkB2GIzJ96l7psEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkMLZuyHWUTSJZeg9KkktIjzSdagKCvkwXFv1EkAEdLSb2Mqc6UIizWNOqTTl0oVrGu4whuWI27YKf25Ljvi5gyBZclSDiwr8lRTvFZd0ZjvKKDZ9XpmDJZhhznANQbRgUadTpGUuDzCj05pvPBjdD2a588dwEFWUlS7TT7IlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RnFR0kyj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745057425;
	bh=BysPsT7ANdRFjBu/Ui8fcsmGFHpnkB2GIzJ96l7psEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RnFR0kyjHOq+TdfQwcRHChjW5kkbnEu7vEtRsHJi0gWoeFq5mwaOtp4nFT6oq8i5K
	 9XPb6m3uTKxoNsR0ZRhZZHRRPisCXrpD/KPxJ6mJQhMIupGSdtk98R+20pSISSU+zO
	 8LRCeLpDuCzBJhJ1J7dZMXuhEg5035FJD+1ueTJQ=
Date: Sat, 19 Apr 2025 12:10:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/6] tools/nolibc: disable function sanitizer for
 _start_c()
Message-ID: <96891976-1f46-4080-91af-1a810fe4498c@t-8ch.de>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
 <20250416-nolibc-ubsan-v1-2-c4704bb23da7@weissschuh.net>
 <20250419090631.GB31874@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419090631.GB31874@1wt.eu>

On 2025-04-19 11:06:31+0200, Willy Tarreau wrote:
> On Wed, Apr 16, 2025 at 08:40:17PM +0200, Thomas Weißschuh wrote:
> > Both constructors and main() may be executed with different function
> > signatures than they are actually using.
> > This is intentional but trips up UBSAN.
> > 
> > Disable the function sanitizer of UBSAN in _start_c().
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/include/nolibc/crt.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > index c4b10103bbec50f1a3a0a4562e34fdbd1b43ce6f..961cfe777c3564e705dfdd581de828b374d05b0b 100644
> > --- a/tools/include/nolibc/crt.h
> > +++ b/tools/include/nolibc/crt.h
> > @@ -7,6 +7,8 @@
> >  #ifndef _NOLIBC_CRT_H
> >  #define _NOLIBC_CRT_H
> >  
> > +#include "compiler.h"
> > +
> >  char **environ __attribute__((weak));
> >  const unsigned long *_auxv __attribute__((weak));
> >  
> > @@ -25,6 +27,9 @@ extern void (*const __fini_array_end[])(void) __attribute__((weak));
> >  
> >  void _start_c(long *sp);
> >  __attribute__((weak,used))
> > +#if __nolibc_has_feature(undefined_behavior_sanitizer)
> > +	__attribute__((no_sanitize("function")))
> > +#endif
> 
> I'm wondering if it wouldn't be more reliable with:
> 
>   #if __nolibc_has_attribute(no_sanitize)
> 	__attribute__((no_sanitize("function")))
>   #endif
> 
> Because in the end, what you want is to always place that attribute
> whenever it's supported, no ?

That doesn't work because GCC does knows no_sanitize but not
no_sanitize("function").
Also no_sanitize is not specific to UBSAN but works for all sanitizers.

> 
> >  void _start_c(long *sp)
> >  {
> >  	long argc;
> 
> Willy

