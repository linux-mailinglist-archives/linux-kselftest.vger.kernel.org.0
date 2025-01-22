Return-Path: <linux-kselftest+bounces-24973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E9AA19AB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 23:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F1E16A345
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277D1C8FD7;
	Wed, 22 Jan 2025 22:14:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46750149E17;
	Wed, 22 Jan 2025 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584060; cv=none; b=KN2wWIwJp2jjVJZFJfUdB0KUOGt8Ht6kTN00Vi+msR+JT2e3Rw1ibKadYibXKy3Tq92mme4LyS1dDukq3RSArbgoOCLnk/gpJbb2L2vLWdkgimGHLTTLxwml/1xLjj+v2lsyUnmn9CO+aYcOUwwf39nmb/wTCBPkwi7vFWKBJ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584060; c=relaxed/simple;
	bh=MQ+CWGKrSlb2bZ8YX1tW7Hn+bK7DIbrwDUNc851Jpqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbMNFZhcVJN+pmsbaYSHls1CIPavLmpEo9mRTAY4IndYyC7YkVL/Nc4wJHhqOE3aDntCi7S0v9YPeiThdRFRL+QV87Uj/hBP1oQ554cH4rDhWIdRNVhPTpuVKCqQ7XRCbvmAgk5Zqh5UHlMaI7MfycQngtaUCOSp3KFY+0yZs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 50MMEBcG006121;
	Wed, 22 Jan 2025 23:14:11 +0100
Date: Wed, 22 Jan 2025 23:14:11 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests/nolibc: always keep test kernel
 configuration up to date
Message-ID: <20250122221411.GA6099@1wt.eu>
References: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
 <20250122-nolibc-config-v1-5-a697db968b49@weissschuh.net>
 <20250122185206.GF2867@1wt.eu>
 <feb6f196-a6f0-4a42-9b04-6d0083629d40@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feb6f196-a6f0-4a42-9b04-6d0083629d40@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 22, 2025 at 08:00:28PM +0100, Thomas Weißschuh wrote:
> Hi Willy!
> 
> On 2025-01-22 19:52:06+0100, Willy Tarreau wrote:
> > On Wed, Jan 22, 2025 at 07:41:48PM +0100, Thomas Weißschuh wrote:
> > > @@ -173,7 +170,7 @@ test_arch() {
> > >  			exit 1
> > >  	esac
> > >  	printf '%-15s' "$arch:"
> > > -	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" "$test_target" V=1
> > > +	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" defconfig "$test_target" V=1
> > 
> > Just a question, are you certain that dependencies between $test_target
> > and defconfig are always properly handled ? I'm asking because "make -j"
> > is something valid, and we wouldn't want defconfig to run in parallel
> > with test_target.
> 
> "make -j" is not only valid but used by run-tests.sh always.
> The sequencing is explicitly enforced in patch 4.

I learned something today, I didn't know about order-only rules.

> > For real sequencing (and making sure targets run in the
> > correct order), I normally prefer to run them one at a time. Here you could
> > simply prepend the defconfig line before the original one and get these
> > guarantees (and also make them explicit). That's also less edit when
> > copy-pasting from the terminal to the shell when trying to debug.
> 
> Sounds fine to me, too.
> That would remove the need for patch 4, but I'd like to keep it anyways.

Agreed!

Willy

