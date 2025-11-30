Return-Path: <linux-kselftest+bounces-46749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 958EEC94DCA
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EE154E04E4
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2926F297;
	Sun, 30 Nov 2025 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="FG8cAkfS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64E149C6F;
	Sun, 30 Nov 2025 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499347; cv=none; b=nTGYLhUvk0uBZnBJbXIYDdmhX09/A/8JbYZfNvMOInk8NkEYE3MdlOtQ05G533cuu/qEvuDXfK376PgNRz4VAjKFLlIcjDn3/l1jJ8C6ly7vUAJApxuwIsyxIXf/2Qbm6Ptx3YS0YObFWeQckTC/zm9kFfvC9zg+6iuWyyiLE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499347; c=relaxed/simple;
	bh=0ddfX5lIQPZLihRXIMcb7a8kEkCDpKD4a5Fq0hKBrwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8jvbrSrmyGSkwS8vr2Yuj1oX3XjwRl1dz7apbk5sOZwpi/mEr08uJD8xG78QQXGvcZ+/ucAtYc+U0Zd313Nv+3msxRm3aczXIVGycXES1rUh6pSIz+GHga2vtiHh1CBgpHJiwIOxsmJL4mWUnL2mV38+J0rEE0YRl2kWyinAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=FG8cAkfS; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1764499342; bh=0ddfX5lIQPZLihRXIMcb7a8kEkCDpKD4a5Fq0hKBrwI=;
	h=From:Message-ID:From;
	b=FG8cAkfStxxq1DgOXnWTqfshDd5Q5qjQ+OceubIlnWWrYwymXVP6A25V0RWKxzkv3
	 JaH704o4/UAM49Xss20KOzjyrz7kFTIAy4uEwowzDUz7q2gK37FuoSuG51YA5G+SCs
	 yNCJWt6Hw0dmnsxhXridPW2syjfcz+qDs4mXVGXw=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id B5D18C04AB;
	Sun, 30 Nov 2025 11:42:21 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5AUAgLiv032740;
	Sun, 30 Nov 2025 11:42:21 +0100
Date: Sun, 30 Nov 2025 11:42:21 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/13] tools/nolibc/time: drop invocation of
 gettimeofday system call
Message-ID: <20251130104221.GC31522@1wt.eu>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
 <20251122-nolibc-uapi-types-v2-4-b814a43654f5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-nolibc-uapi-types-v2-4-b814a43654f5@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Nov 22, 2025 at 05:59:10PM +0100, Thomas Weiﬂschuh wrote:
> This invocation uses libc types with a system call. While this works
> now, upcoming changes to 'struct timeval' would require type
> conversions. If types are converted anyways, the clock_gettime() based
> fallback can be used everywhere, simplifying the code.

I must confess I'm not happy to see the simple, lightweight and efficient
gettimeofday() quit, with the alternative being a bit bigger, but after
enough testing, aside the code size increase I cannot spot any problem.

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

