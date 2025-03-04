Return-Path: <linux-kselftest+bounces-28195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C33A4DBE3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 12:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47954188E140
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA081FF1DB;
	Tue,  4 Mar 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2vJmZgVp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eliXuU4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF371FF61E;
	Tue,  4 Mar 2025 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086541; cv=none; b=PNgqvfYvvy7gywk83FJd8f/ETqESSCSRDxljz3584zSKBfyTQ3M6gaRE+KocEfVR3VaLt1IKwC4vbSn7/v0G6WF93KWm7BuEzt6M3RrI157vjdIRw/mgQaczcn6TtreXe2uGeSuGIac+mBhL3RxhRWJdt3V0onJ8PkPE9Hq3Ddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086541; c=relaxed/simple;
	bh=ysRu7kFtTN9qf41iuj6eo21vLISj48KUiMCBUemBsOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAixSuQjr1thNEhI1knA2L6DJKdAH1brO6KP18HiQxD5swI5NIgx/O+/pxbiijWoMr28fwDZSR1188VuveC5iEzFCIhSforWXOyA+tc1ygS3gyJEy1aFCcci6aw61bnL18qRv9GbyOmSCDO4kgljJfeUB+6FQ2wATKUoAdi9FfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2vJmZgVp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eliXuU4v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Mar 2025 12:08:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741086537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ez1oyLFhdZRI9rrcMpyl3L441onYQPr1EXQhanRODC0=;
	b=2vJmZgVpu9KlkhAUrMG1DBjyNMX4Bjyvr/f7jfoCGkWG3EAkw7L+ip2ccLVH6LBGz90z37
	wc/jef3TS3ErbIpyS/LSGhukbll+u7IXo3Ty3MKno+MUFSxql3HW26aUBJEJiKL7IuQvmY
	/pSbMjxqtbxLjScyX8KXMKX4Mu7Jzxyd/t9SbU5v27zkHEu6Ir8UZDRc/gUzmboEr1IshV
	tXUqD8s85E0HTIYtyyZg5Ms2Ha0QsVah8hqfih9Zj8iUnETljv8WmGQ6QLvuN+CLZGlvFs
	ElrBTs7yB1WKxXfsQIYvFW1e3MiMJ80EvNfNetb55Bna6pr/JiMTrrlDuYMAVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741086537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ez1oyLFhdZRI9rrcMpyl3L441onYQPr1EXQhanRODC0=;
	b=eliXuU4vRK4OOm3Z6jDReqRW+PTI/bUWfhwZkPMcVfAOrTqfQoGO7ur+5p1+E/QZ2D7iOt
	7eke14g7GmiHRSCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 15/32] tools/nolibc: use intmax definitions from compiler
Message-ID: <20250304120124-78579418-a44c-47d6-acbb-41ce64fa355e@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
 <20250304-nolibc-kselftest-harness-v1-15-adca7cd231e2@linutronix.de>
 <20250304073742.GA9911@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304073742.GA9911@1wt.eu>

On Tue, Mar 04, 2025 at 08:37:42AM +0100, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Tue, Mar 04, 2025 at 08:10:45AM +0100, Thomas Weiﬂschuh wrote:
> > The printf format checking in the compiler uses the intmax types from
> > the compiler, not libc. This can lead to compiler errors.
> > 
> > Instead use the types already provided by the compiler.
> > 
> > Example issue with clang 19 for arm64:
> > 
> > nolibc-test.c:30:2: error: format specifies type 'uintmax_t' (aka 'unsigned
> > long') but the argument has type 'uintmax_t' (aka 'unsigned long long')
> > [-Werror,-Wformat]
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  tools/include/nolibc/stdint.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> > index cd79ddd6170e05b19945e66151bcbcf840028d32..b052ad6303c38f09685b645268dad1fa8848370d 100644
> > --- a/tools/include/nolibc/stdint.h
> > +++ b/tools/include/nolibc/stdint.h
> > @@ -39,8 +39,8 @@ typedef   size_t      uint_fast32_t;
> >  typedef  int64_t       int_fast64_t;
> >  typedef uint64_t      uint_fast64_t;
> >  
> > -typedef  int64_t           intmax_t;
> > -typedef uint64_t          uintmax_t;
> > +typedef __INTMAX_TYPE__    intmax_t;
> > +typedef __UINTMAX_TYPE__  uintmax_t;
> 
> Just thinking loud. While I understand the rationale behind this
> change, it somewhat contradicts the one on printf where we explicitly
> use it as an "unsigned long long" that's expected to be 64 bits:
> 
>    CASE_TEST(uintmax_t);    EXPECT_VFPRINTF(20, "18446744073709551615", "%ju", 0xffffffffffffffffULL); break;
> 
> Do we really have guarantees that a compiler will always declare
> it as a 64-bit or unsigned long long ?

It should always be 64bit. But not necessarily unsigned long long.
In the case from the commit message it is unsigned long.

> E.g. we could see new
> compilers decide that uintmax_t becomes 128-bit. Well, maybe in
> that case it will simply be a matter of updating the test case
> after all...

uintmax_t is only guaranteed to hold "any basic unsigned integer type supported
by the implementation", while 128bit integers are not "basic" but "extended" and
nolibc as implementation does not support them in the first place.
Also uintmax_t is used in various ABIs which would get broken if its definition
would change, one such example would be printf() itself.

The "correct" definition of uintmax_t constants would use UINTMAX_C().
I'm not sure if it's worth adding these macros.

