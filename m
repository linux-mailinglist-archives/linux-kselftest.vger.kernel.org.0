Return-Path: <linux-kselftest+bounces-28196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DE5A4DC13
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 12:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB8D3B31D6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36CA1FECDC;
	Tue,  4 Mar 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3wPPBYO6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i6/56Pwy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7FA1FCFC9;
	Tue,  4 Mar 2025 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086636; cv=none; b=AngtJWqCcNc1qdpYJw/FiuYGp1v+C9CrVoY1FBrp3W4awTQ1ck06DZvSZ82Bhnd7kTBLFaMXOTPv9WJvBa/vacZKOvqrotEXnzP4Fk/bWrG4FvfgFu4xXkr0IlMxNqNgPInZPDqA9ZLXP0IH9g28PThf3MIZDH5xD1Y1zCv9+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086636; c=relaxed/simple;
	bh=o8pV7LiC1HAPjce0nZYzrkmFV9kB16o0ZyOOSic1Roc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLYYq1cPM+O7VGWnELrxd+XBCeFwXo+b3Vx66L+I+nnfIwuhJ+Fbxay/gyfJT3FY9uEazH25VJSGMNf4k7pCGqth/CeqRaYj1+sqCteYG98wp90TcjppVfb0jNgo/r6yRulV9v+wUmWAgC1awtocT2d7c5sIQTHDQUfmt7Gcs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3wPPBYO6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i6/56Pwy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Mar 2025 12:10:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741086633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y86laKqtxZGXfzc8gw8EE43zQLw75ddKvx0R7AfVXYI=;
	b=3wPPBYO6A9bcv7fi+C0tb0a/l1lp3nepoagyNIul9JN+LprR9LEQ4LbE8xgW+xafWQqsEY
	4k8aER88f3dExfknJHD4xQuIxz/T6HAh+YwYhgGcSLgosY+hxhT7FEbiE422Gr2enJXtNA
	SZrMpMG55OfkQRNbk+M6g6pse7hdiTxD7De/FtAtwtAQnH5H8cw8hgdl5qBpYRFoUtADYn
	hLKa900OyqsmcBj5x42N0bTEm+8oKgK2eZw089/qtAYWpINGSegTje0/JsEKUgQF1x+/bz
	7HZeNRGljo5YiG9W40t4u6+frCknAuC4bfOR+IWi05lZe96MWWh5kTEnFOyaeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741086633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y86laKqtxZGXfzc8gw8EE43zQLw75ddKvx0R7AfVXYI=;
	b=i6/56PwyySHprOiuvCBL5lQ6LHKZW+byBmFagA3vt2+8wH1rE14rbLIetN4QnFr79GP0YS
	uGWqWdCJmUaXKeDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 25/32] tools/nolibc: allow different write callbacks in
 printf
Message-ID: <20250304120932-827df661-9aa6-488e-8935-70915caaab15@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
 <20250304-nolibc-kselftest-harness-v1-25-adca7cd231e2@linutronix.de>
 <20250304075923.GC9911@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304075923.GC9911@1wt.eu>

On Tue, Mar 04, 2025 at 08:59:23AM +0100, Willy Tarreau wrote:
> On Tue, Mar 04, 2025 at 08:10:55AM +0100, Thomas Weiﬂschuh wrote:
> > Decouple the formatting logic from the writing logic to later enable
> > writing straight to a buffer in sprintf().
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  tools/include/nolibc/stdio.h | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > index 262d0da4da9062e0c83b55661b2509f36548cf88..434fbaddae7a216159fecf618da85889d631dff7 100644
> > --- a/tools/include/nolibc/stdio.h
> > +++ b/tools/include/nolibc/stdio.h
> > @@ -208,13 +208,15 @@ char *fgets(char *s, int size, FILE *stream)
> >  }
> >  
> >  
> > -/* minimal vfprintf(). It supports the following formats:
> > +/* minimal printf(). It supports the following formats:
> >   *  - %[l*]{d,u,c,x,p}
> >   *  - %s
> >   *  - unknown modifiers are ignored.
> >   */
> > -static __attribute__((unused, format(printf, 2, 0)))
> > -int vfprintf(FILE *stream, const char *fmt, va_list args)
> > +typedef int (*_printf_cb)(intptr_t state, const char *buf, size_t size);
> 
> Keep in mind these ones will appear in the application, so you'd rather
> appropriate the type name by prefixing it with "nolibc" as we've done in
> a few macros and internal structs.

Ack. Technically it should be fine as names with leading underscores are
reserved for the implementation, but let's make it clearer.

> > +static __attribute__((unused, format(printf, 3, 0)))
> > +int _printf(_printf_cb cb, intptr_t state, const char *fmt, va_list args)
>        ^^^^^^^
> Here as well, since it's not meant to be exposed to the application.

Ack.

> > +static int _fprintf_cb(intptr_t state, const char *buf, size_t size)
> 
> Likewise here I think.

Ack, also to the same remarks in the other patches.

