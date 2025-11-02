Return-Path: <linux-kselftest+bounces-44625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA40C28CB5
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 10:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E109C3ACD8F
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FEB26CE25;
	Sun,  2 Nov 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="l7ldJ0RE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0726A257842;
	Sun,  2 Nov 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762076997; cv=none; b=AJPxZKqjTlumaHKDctkErr6IQq+oLbaB7hH3+JDE5fbiZxX+ju4M/H1DHa+VZOEz0Lqe9jKHTKahOm7DFZbZ2dgk9IjXS5fIdnrISD1kBLX0UYeVfyyi2eQ9cczwAbhFg+aCEGitKpNbJbnqwH/cNWOkTXPzFum28RuiNzUziJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762076997; c=relaxed/simple;
	bh=JyzyZoT0hdHGiPv6MEgKGiCSaD8L3ellhr0wx8v2fxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9PK1XBSXFeXZH8geoJ8LKTfsC++E5pQuhzTytpOaWFMGLucr77vY003Vkjwg1ad+842fXlYoOCH27d1X3NO4Xjpt4nsMp4skPBUclq1QPWfgv+3aYs+ZmRyCMROB0Tgnn0qv/sU1BRccCkJ+VEHmbzLO6v3ix5lFpvY9o8t/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=l7ldJ0RE; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762076991; bh=HferrhtE5jm80jTeO4fDjUKOnnrDX9Durj8VCbS8x6w=;
	h=From:Message-ID:From;
	b=l7ldJ0REn7dlK8RqharqsTUwdupHhjl9q4ZnXLvfJT0EDmgjiALsoxbeZquSriKV8
	 lSO4+i2LFDFr1RyZ4EUTBm+GX+AVvUe1/PzUVRxtIAWIxxYv6n+pI+oQzs6p1Avxav
	 7ll4oSEovUHeUCpCBi6P+20wdJisCjgdv89IIyu8=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id D9D2EC06EE;
	Sun, 02 Nov 2025 10:49:51 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A29npBh014628;
	Sun, 2 Nov 2025 10:49:51 +0100
Date: Sun, 2 Nov 2025 10:49:51 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 08/12] tools/nolibc: gettimeofday(): avoid libgcc 64-bit
 divisions
Message-ID: <20251102094951.GB26041@1wt.eu>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-8-e79de3b215d8@weissschuh.net>
 <20251102083156.GA10797@1wt.eu>
 <69c383ef-0d05-4f9a-bdd1-85dbf3d0100b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69c383ef-0d05-4f9a-bdd1-85dbf3d0100b@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Nov 02, 2025 at 10:27:18AM +0100, Thomas Weiﬂschuh wrote:
> On 2025-11-02 09:31:56+0100, Willy Tarreau wrote:
> > On Wed, Oct 29, 2025 at 05:02:58PM +0100, Thomas Weiﬂschuh wrote:
> > > timespec::tv_nsec is going to be 64-bit wide even on 32-bit
> > > architectures. As not all architectures support 64-bit division
> > > instructions, calls to libgcc (__divdi3()) may be emitted by the
> > > compiler which are not provided by nolibc.
> > > 
> > > As tv_nsec is guaranteed to always fit into an uint32_t, perform a
> > > 32-bit division instead.
> > >
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > >  tools/include/nolibc/sys/time.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
> > > index 33782a19aae9..6dd3705c6c9d 100644
> > > --- a/tools/include/nolibc/sys/time.h
> > > +++ b/tools/include/nolibc/sys/time.h
> > > @@ -33,7 +33,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
> > >  	ret = sys_clock_gettime(CLOCK_REALTIME, &tp);
> > >  	if (!ret && tv) {
> > >  		tv->tv_sec = tp.tv_sec;
> > > -		tv->tv_usec = tp.tv_nsec / 1000;
> > > +		tv->tv_usec = (uint32_t)tp.tv_nsec / 1000;
> > >  	}
> > 
> > Good catch! I'm wondering if this one shouldn't be marked as a build
> > fix for 5e7392dc82ed ("tools/nolibc: fall back to sys_clock_gettime()
> > in gettimeofday()") so that it can be backported.
> 
> Right now timespec::tv_nsec is of type 'long', so it should only be
> 64-bits on architectures which have native 64-bit division instructions. 
> But marking it as fix shouldn't hurt either.

Ah yeah you're right. Don't bother with that then.

Thanks!
Willy

