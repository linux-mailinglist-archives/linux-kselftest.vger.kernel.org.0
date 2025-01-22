Return-Path: <linux-kselftest+bounces-24966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7053A198E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 20:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5B8188E033
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5FA214A9B;
	Wed, 22 Jan 2025 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tNGPjj2j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1E14F115;
	Wed, 22 Jan 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572432; cv=none; b=lw/eShnOOHNazUZivLtJhlZkskrUxFA2T1/EgOwAizbKgCnBo4AZdc07DNjvewOkIeJNHNqeM5UtAmvi210jLVgP+xwIyAxE1HE1XfeECvDGQda7mZGEctqQAy/Sq/PaDqPfxsHzCio9GAPzWjtOLnlKDFswD0jQ/LyU48ygKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572432; c=relaxed/simple;
	bh=sSRdseY+zthRXXs/2o3wNjGYQu84vxEf8JD3NvPK2JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqkBdoZlW9Qc2okglz05NNyYs8Trt29Z6fb8ghmMBUspLxXEmn/5BHjrjjeUKxZ+fg58CZsNnhu+SAVohtLVw/qT5aIFzer+3DHvyM2WgArZqxq0zZOzJFmFHJm96tBIEMlBYQqeS9joF9NDAEUkb2RQaeuGuD6fg5rCIm3JXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tNGPjj2j; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737572428;
	bh=sSRdseY+zthRXXs/2o3wNjGYQu84vxEf8JD3NvPK2JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNGPjj2j+5v75xJ983qkd4ZarFCnSmMw9LVRMXEgJHmNTECRIx6K+BEg+a8dp53Jd
	 RdjTUPHyYwsKC46DkihdkRR95KuAO8U1gbWDP6IW/2mztHWOpcEAd2q3kEGI3Lh4cx
	 NcURPLjyJI4GaWSmefz8ZUeYDImR/c/TNrlGfo2Y=
Date: Wed, 22 Jan 2025 20:00:28 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests/nolibc: always keep test kernel
 configuration up to date
Message-ID: <feb6f196-a6f0-4a42-9b04-6d0083629d40@t-8ch.de>
References: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
 <20250122-nolibc-config-v1-5-a697db968b49@weissschuh.net>
 <20250122185206.GF2867@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122185206.GF2867@1wt.eu>

Hi Willy!

On 2025-01-22 19:52:06+0100, Willy Tarreau wrote:
> On Wed, Jan 22, 2025 at 07:41:48PM +0100, Thomas Weißschuh wrote:
> > @@ -173,7 +170,7 @@ test_arch() {
> >  			exit 1
> >  	esac
> >  	printf '%-15s' "$arch:"
> > -	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" "$test_target" V=1
> > +	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" defconfig "$test_target" V=1
> 
> Just a question, are you certain that dependencies between $test_target
> and defconfig are always properly handled ? I'm asking because "make -j"
> is something valid, and we wouldn't want defconfig to run in parallel
> with test_target.

"make -j" is not only valid but used by run-tests.sh always.
The sequencing is explicitly enforced in patch 4.

> For real sequencing (and making sure targets run in the
> correct order), I normally prefer to run them one at a time. Here you could
> simply prepend the defconfig line before the original one and get these
> guarantees (and also make them explicit). That's also less edit when
> copy-pasting from the terminal to the shell when trying to debug.

Sounds fine to me, too.
That would remove the need for patch 4, but I'd like to keep it anyways.


Thomas

