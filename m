Return-Path: <linux-kselftest+bounces-26133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB5A2DEF4
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC55B3A645A
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A71DF26B;
	Sun,  9 Feb 2025 15:55:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8751632DF;
	Sun,  9 Feb 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739116528; cv=none; b=eiQlYrCikOPAifMZrnLxFi2OnGyPFa3/kqxFs1zgn6sp6BsPBChGCiKaNu7Y2Vq2tA3EvJ9Kkg5OyJC6brojSuEvzAovJq8+NyOL6t5i2H/tbI4C7v8mFAtmjS2JIdaH+2qCEoiD+HP58yiy3VrEIDvK/gfi/g+ZNqlxVnABEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739116528; c=relaxed/simple;
	bh=4XsqJRCY4BqhuFjDgOWpOadL4veHTCpzVln2DCnMYIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHgfaD+b0SIjyTK8bM7lCavUo2BYEJtZda6EUjvbnhdP2amPw6vGCxAm3N625FNZJ6Wn/7EQ08zUhYZZn69wDxm4M702GEeHncwjegEmvArnGfvyR8VlqGhab7VEafxF8zYgnydHaRK8Fh9kEpaxVyX2lawqfA3KtzSwmnHOvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 519Fh4lO009403;
	Sun, 9 Feb 2025 16:43:04 +0100
Date: Sun, 9 Feb 2025 16:43:04 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v2 0/2] tools/nolibc: add support for directory access
Message-ID: <20250209154304.GA9389@1wt.eu>
References: <20250209-nolibc-dir-v2-0-57cc1da8558b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250209-nolibc-dir-v2-0-57cc1da8558b@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Feb 09, 2025 at 02:25:44PM +0100, Thomas Weiﬂschuh wrote:
> Add support opendir(), readdir_r(), closedir() and friends.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Move definitions to dirent.h
> - Reserve space for the trailing NULL byte of d_name
> - Implement readdir_r() instead of readdir()
> - Expand commit message
> - Link to v1: https://lore.kernel.org/r/20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net

Nice!

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

