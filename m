Return-Path: <linux-kselftest+bounces-23725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B09FA19E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 17:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680F1168EFC
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EECE32C85;
	Sat, 21 Dec 2024 16:36:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652922C80;
	Sat, 21 Dec 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734798975; cv=none; b=DxawB0ypD2aTIWnYOhTGjq2C3UkIxuVXHQpgG8AHjj9pUtNctJtA2p1DF0aUmNJbnig1BVTHM5LTGP69SUz548AOFOTyD8QBmDeDmS7dXkRJtxpGW7K0O7eBqwLns5rI5k22eoUbxTth1C2zdFXV+60cn0rmJ3BPoE4YNXM3sm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734798975; c=relaxed/simple;
	bh=B96iX6NwUEXhTSX2AGFhOgdt7AZRJI9RSK5aHEF+IYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l93+so5HTOzkMhVV0miZ8rWzFpR00geKBYNdTRcaIMRQGOVVXQticn460BmYybPdgF1SDaTm8+6PXeXeWpKGu5RvSCzPNnWTXv1uKGxWI+NFaCHJr9U9j00F2o6f4buRTWVZY5QpWYoXslUZd9nGxoiOLRJFHaIOQYNxPeKgVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4BLGZeKv012220;
	Sat, 21 Dec 2024 17:35:40 +0100
Date: Sat, 21 Dec 2024 17:35:40 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH 1/6] tools/nolibc: add support for waitid()
Message-ID: <20241221163540.GA11984@1wt.eu>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
 <20241221-nolibc-rv32-v1-1-d9ef6dab7c63@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241221-nolibc-rv32-v1-1-d9ef6dab7c63@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas!

On Sat, Dec 21, 2024 at 03:44:28PM +0100, Thomas Weißschuh wrote:
> waitid() is the modern variant of the family of wait-like syscalls.
> Some architectures have dropped support for wait(), wait4() and waitpid()
> but all of them support waitid().
> It is more flexible and easier to use than the older ones.

I'm generally fine with the series, but I'm starting to get concerned
that some simple applications that used to rely on wait() or waitpid()
will not work on this architecture. Just like we did for some early
syscalls that got replaced (e.g. open->openat etc), I think we'll have
to implement a default wrapper relying on waitid() for all these calls
in this case, and maybe as well for lseek->llseek() btw, what do you
think ?

The single fact that you've had to modify some of the nolibc-test code
(which is supposed to be the application here) indicates that we're
progressively going away from what applications need on certain archs.
Ideally an application relying on long-established calls should continue
to work unmodified.

Maybe it will be time for us to run an overall audit of arch-dependent
syscalls we currently have, to make sure that the common ones continue
to work fine there (and waitpid() definitely is as common a syscall as
open() since it's the good old and portable one).

Cheers,
Willy

