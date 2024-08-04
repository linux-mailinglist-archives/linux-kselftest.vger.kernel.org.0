Return-Path: <linux-kselftest+bounces-14778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05421946FB8
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Aug 2024 17:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C901F2125D
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Aug 2024 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A020745F2;
	Sun,  4 Aug 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YUlNGKC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A841DFDE;
	Sun,  4 Aug 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722786962; cv=none; b=V7isiTNEBW+VoNfw6XS9b7Ao6ULrTbOW3ZZUP9LKI3s9CDwoUS0VpsYeO0bpJ9GZ0JCqNWrmQ/ZB2r5QWBOzLzgChRilt2T47nexCG9BLfOHwbJNYTmdD08DTT6CaVVZRAMMvlvyVqyl9GkfitotoZOw+uo+PRSQP7C8pqwRJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722786962; c=relaxed/simple;
	bh=G2NS3MhWkwMkIy/WVUdScvwYIvOgbCHRoQdCiImEu9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LivSIjNyH3rnlr54J2Z/CgJHZ1HH6nXurehy8YejqATtVdirkEzQbL2ysSmHCG5cxv2M0wOn9tHw1mQDcJ86w3TCozYt2c+TMq/bpgdYn+dDhGtibsgHVUZInyDFoO468e6QUPEiCjTVwe/RpTE9/lEDJxDeOPpUHMnCQ9LVYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YUlNGKC4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722786949;
	bh=G2NS3MhWkwMkIy/WVUdScvwYIvOgbCHRoQdCiImEu9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUlNGKC4qJPldtESicBWxdcWXBGqTzHXJD+LaYJ4RMrFqAAdgeiniCn45iKn4Kdly
	 eZV2yN/sDkqm6/4CLqhTNGvEpqKrZ2oq3JSp8yMa7egbHFhlOrrdq0eEYrg4NwurtL
	 /dKW7SI+QVz7eqnsiPWa4FDfbgytAI55i0No96LA=
Date: Sun, 4 Aug 2024 17:55:48 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/12] selftests/nolibc: determine $(srctree) first
Message-ID: <812c6752-4404-4082-910c-732e049aa54e@t-8ch.de>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-7-bc384269bc35@weissschuh.net>
 <20240803094024.GD29127@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240803094024.GD29127@1wt.eu>

On 2024-08-03 11:40:24+0000, Willy Tarreau wrote:
> On Sun, Jul 28, 2024 at 12:10:01PM +0200, Thomas Weißschuh wrote:
> > Avoid needing relative includes.
> 
> I'm not opposed, but what's the benefit ? IMHO relative paths are
> generally more flexible and robust. you could imagine a completely
> made up example in which you have a symlink to selftests/nolibc in
> your home dir, which works perfectly with relative paths when you
> cd into it while it would not anymore with absolute paths (unless
> you use cd -P).

This commit is solely about relative includes in the nolibc-test
Makefile.
The actual code is unaffected.

include ../../../scripts/utilities.mak
->
include $(srctree)/tools/scripts/utilities.mak

This commit is not necessary, just a cleanup.
IMO consistently using $(srctree) is nicer.

And yes the message for this commit is really not great.

> Thus if we are decided to lose that flexibility at least it should
> be argumented in the commit message.
> 
> Thanks,
> Willy

