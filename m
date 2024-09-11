Return-Path: <linux-kselftest+bounces-17754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9127797576A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 17:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE85282BC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 15:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A11AAE01;
	Wed, 11 Sep 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="X4fD2COp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A31E498;
	Wed, 11 Sep 2024 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069492; cv=none; b=YKWYoSxq7t0wrOtUMN3jby4DpwpVEAfeV9dZ3BMm/F90dMY1sC8TII5FtEzF+MXLhiLlj0Gkw6KpmnezD3zjh6j26zgYaG7FYc/QcGxXEyc4Ql1BlbWwGfn2XZLDc5lkAri/QA7i21yzOCOUvGj7EGQ8v9IN4jAc7/u9GtSsVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069492; c=relaxed/simple;
	bh=i9g1MHZOIqU5gpjiHW+mieXpOR1PWzNUM+FJdayIZeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2VLea1DdiGen3isF6cYhn11qYl/hRrtYRH+WlUSNOrCtKXf0hCgcVhKK8xYfzhQlAjB7mahW9p7r/S1tPYFPsRzDF85ARhKp7okxYx/JokyqK7G+OZJAo+M/khH/rYTNPyQY4cDDxW0NNdPBm7yR4VIgmq125O+qxtkdfOix9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=X4fD2COp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1726069481;
	bh=i9g1MHZOIqU5gpjiHW+mieXpOR1PWzNUM+FJdayIZeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4fD2COpLqpKjGUyxSMROYBtMJI1pM+p82/yvxw9usiDmi/oF+yDFLKZ0C6W2ddgr
	 PDa0VVgW24UmTEP4owCHJEGCA+SbhlA8JuYOdR43dIrW20A4P6fdY22zvhW2+IXOOy
	 MvYTuijqBRVtRd8vGYYT6w0HjlflKiZMhwAIF4Fk=
Date: Wed, 11 Sep 2024 17:44:40 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, shuah@kernel.org
Subject: Re: [PATCH] selftests: kselftest: Use strerror() on nolibc
Message-ID: <16611552-10d8-46d0-8163-460c0cbec2e5@t-8ch.de>
References: <20240911044230.5914-1-zhangjiao2@cmss.chinamobile.com>
 <1c94b9bd-78d1-433a-959e-420a456bd40c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c94b9bd-78d1-433a-959e-420a456bd40c@linuxfoundation.org>

Hi Shuah,

On 2024-09-11 09:36:50+0000, Shuah Khan wrote:
> On 9/10/24 22:42, zhangjiao2 wrote:
> > From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > 
> > Nolibc gained an implementation of strerror() recently.
> > Use it and drop the ifndef.
> > 
> > Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > ---
> >   tools/testing/selftests/kselftest.h | 8 --------
> >   1 file changed, 8 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> > index e195ec156859..29fedf609611 100644
> > --- a/tools/testing/selftests/kselftest.h
> > +++ b/tools/testing/selftests/kselftest.h
> > @@ -373,15 +373,7 @@ static inline __noreturn __printf(1, 2) void ksft_exit_fail_msg(const char *msg,
> >   static inline __noreturn void ksft_exit_fail_perror(const char *msg)
> >   {
> > -#ifndef NOLIBC
> >   	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
> > -#else
> > -	/*
> > -	 * nolibc doesn't provide strerror() and it seems
> > -	 * inappropriate to add one, just print the errno.
> > -	 */
> > -	ksft_exit_fail_msg("%s: %d)\n", msg, errno);
> > -#endif
> >   }
> >   static inline __noreturn void ksft_exit_xfail(void)
> 
> Adding nolibc maintainers for review.
> 
> Willy and Thomas, please review.

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

I did the same for another kselftests function when introducing
strerror(). This one was apparently missed or didn't exist yet.


Thomas

