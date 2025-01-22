Return-Path: <linux-kselftest+bounces-24967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2682DA198FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 20:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA396188E4A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138D215F52;
	Wed, 22 Jan 2025 19:06:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B1215F40;
	Wed, 22 Jan 2025 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572785; cv=none; b=LYu8N3gmjV3GshToL5jnU0QYVFZDrSh6vOF8gnle4u6T6Q1iMVgGVNG1QC40+/k+UaD/q2rVrIIN6gGVyxC0FqiceI296DF4kHdgweSenUf1pI+6A6+XnF0EdPI6WZ3GcDQFwf3U7FRgJpR10EiqhTnalLN1jQ1tjQQ3nt0zK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572785; c=relaxed/simple;
	bh=wmeEUrNmZKgpnQshT1lov08sWy0LmTCRmjWAvGg43SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1IGpLyccCftGyNF+7SjDD17WIKoyXsGU1cdFB2zhXbbyDkUwCmxcHaX1K5xsZQYh7uDivJCqD3OZSj0+b4X0hNwLWdV1pxG8odwj+LblvYlh3UEHufnN5NK6YOAW9/BXQ0NDQZEEuKfdgKaBXNqAMHYJL9Mpwe1Af6GObnGXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 50MIq6Ym005321;
	Wed, 22 Jan 2025 19:52:06 +0100
Date: Wed, 22 Jan 2025 19:52:06 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests/nolibc: always keep test kernel
 configuration up to date
Message-ID: <20250122185206.GF2867@1wt.eu>
References: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
 <20250122-nolibc-config-v1-5-a697db968b49@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122-nolibc-config-v1-5-a697db968b49@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas!

On Wed, Jan 22, 2025 at 07:41:48PM +0100, Thomas Weißschuh wrote:
> @@ -173,7 +170,7 @@ test_arch() {
>  			exit 1
>  	esac
>  	printf '%-15s' "$arch:"
> -	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" "$test_target" V=1
> +	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" defconfig "$test_target" V=1

Just a question, are you certain that dependencies between $test_target
and defconfig are always properly handled ? I'm asking because "make -j"
is something valid, and we wouldn't want defconfig to run in parallel
with test_target. For real sequencing (and making sure targets run in the
correct order), I normally prefer to run them one at a time. Here you could
simply prepend the defconfig line before the original one and get these
guarantees (and also make them explicit). That's also less edit when
copy-pasting from the terminal to the shell when trying to debug.

Just my few cents ;-)
Willy

