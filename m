Return-Path: <linux-kselftest+bounces-31763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5603A9EE21
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CF07A9703
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4563625F785;
	Mon, 28 Apr 2025 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a+uiKmJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HVCoze0X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80D25EF9F;
	Mon, 28 Apr 2025 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745836883; cv=none; b=u6V/z1kFEPCJSY+RnagtX2gwG/xeE/frEzW883ciqjx2n+lI8WwjpTetErawUGyQW/vW5cmRB7Rm030NAcHld3zlsqSvPqeoBpApBB357n9KkPyBXW4+aORPnbDyS6SrLTrkA9r0UYcr+Jp2ici/5X5ksQ1KNSRmHt0+ezRcjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745836883; c=relaxed/simple;
	bh=iJBBvAmJmalamc+8YOZLp2zXk2ztuI8xnZZR9+nzW0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGdu9scRbn6Hd3gO7cg4JwmOlckEGf49iYMWnolye0FUV19fO13ryn18AEbJqVjD1eibdCLStEN4NFfGMhWeTEmtPPidbhrXYI8R27dvKYGBLAjmn37c4ruWFoda16bdQmi4xZHQRj9W6O9pb+VGHWRZgmMB/1PsNdGuHdE9zW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a+uiKmJJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HVCoze0X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Apr 2025 12:41:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745836879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+I2M0UkWdhpD96ij43HQHPTOpq526vcHcH8seBMuv5E=;
	b=a+uiKmJJD344kWYLHrbbGopPCCDKEox1g7IWpQlS2xEgq0B0NfjoL3kJ+IbbhP+60Ty/uo
	042QnYLTPdhHkl0w7+fMdAfWpDQJmObl+/h5ngxcpAsWH4XirOaviwEMEu0V67f6nRiq+6
	RUeBTTnzbGOInd1JhakyGRyfi/iDJ/YPQBdBg+DLnFHtxShlkxESVhVdlTrIuKkFeIKBvS
	+Q9pNnjp4wi4JQlOu9cDmpdxm2b8o8fXyvFO9F1d80hPGQZgDMxZUnWPoS+cNwurgZLNEM
	yoI8IJ1uaRN5jmyPn3tK6OFlYF5QUul5wQMu7Zei/T6AoPtRjERIxxdzGDvxeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745836879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+I2M0UkWdhpD96ij43HQHPTOpq526vcHcH8seBMuv5E=;
	b=HVCoze0XnnmUQXGZXedsPZT/MhsrCNToZNgIwOtJtSN26Oh26v/3FjjQh1eaeV2mX1MHkz
	w8g+c6paAAXtUsDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 11/15] tools/nolibc: add difftime()
Message-ID: <20250428123809-70bb912e-51e0-4b4b-9870-a02e41a079fe@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
 <20250423-nolibc-misc-v1-11-a925bf40297b@linutronix.de>
 <20250426104520.GD17549@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250426104520.GD17549@1wt.eu>

On Sat, Apr 26, 2025 at 12:45:20PM +0200, Willy Tarreau wrote:
> On Wed, Apr 23, 2025 at 05:01:41PM +0200, Thomas Weiﬂschuh wrote:
> > This is used in various selftests and will be handy when integrating
> > those with nolibc.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  tools/include/nolibc/time.h                  | 7 +++++++
> >  tools/testing/selftests/nolibc/nolibc-test.c | 1 +
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
> > index 28a1549adb14e2087fa8fbdb7e9c35e1c3f22c2a..760133c574ece97165e3bba5616a387deaf07aff 100644
> > --- a/tools/include/nolibc/time.h
> > +++ b/tools/include/nolibc/time.h
> > @@ -105,6 +105,13 @@ int clock_settime(clockid_t clockid, struct timespec *tp)
> >  }
> >  
> >  
> > +static __inline__
> > +double difftime(time_t time1, time_t time2)
> > +{
> > +	return time1 - time2;
> > +}
> 
> Thanks for making me discover difftime(). I've never heard about it, and
> seeing it return a double looks totally weird, but that's how it is indeed.
> 
> In case time_t would be unsigned, this would return a large unsigned
> value. I think it could be more robust to explicitly cast the two
> inputs to long:
> 
> 	return (long)time1 - (long)time2;

time_t is explicitly defined as "signed long" in nolibc's std.h.
If we change it at some time in the future we will have to audit any usage site
of time_t in any case.

> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index aed71de4b4f3dd1f183c7fc25e5a5cee466600ed..fd8bab42e75157967658690005bc9142360fc135 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1423,6 +1423,7 @@ int run_stdlib(int min, int max)
> >  		CASE_TEST(toupper_noop);            EXPECT_EQ(1, toupper('A'), 'A'); break;
> >  		CASE_TEST(abs);                     EXPECT_EQ(1, abs(-10), 10); break;
> >  		CASE_TEST(abs_noop);                EXPECT_EQ(1, abs(10), 10); break;
> > +		CASE_TEST(difftime);                EXPECT_EQ(1, difftime(200., 100.), 100.); break;
> 
> Then here maybe test it in reverse to make sure the types don't cause trouble:

Ack.

> 		CASE_TEST(difftime);                EXPECT_EQ(1, difftime(100., 200.), -100.); break;

