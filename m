Return-Path: <linux-kselftest+bounces-31698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7C9A9DA1D
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 12:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17F3920BD3
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539421B91F;
	Sat, 26 Apr 2025 10:33:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7068E4A11;
	Sat, 26 Apr 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745663638; cv=none; b=ZyGkBfD1dIj2RrNGitg15IwI39dGEF7LiJSPI63Eo1h1TVxnIYhBnDvRmtOTLHPeZFLtYd960ttmQYf+8R2p4tu+s9bJY1XXlAG6smwgm2TDRxfzobG6qkV+CYLxB/9gd6tdbFOz1Ma0Q/+h7f9UhqeQoMVX2ReVfryycGgHD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745663638; c=relaxed/simple;
	bh=JOH/+s9EZG7yPcC8pv8z+r2xKA5wTEjd3Y5s7ygrQVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIRlCB0ERsXfbamNOIyUofZmfmAQZAMnAq6J3107SbNezr5mdRpqWW6TPKFi6Kmz82AHTLC3avFzNNcM4p80GsBlc0flqD+gISeaBPcLre3R4/NwkbUwaefzq8nBtGA+FUc+1GnTMU8lqVA14P0Lny5+BNJSpEtMnwxdJ8OYKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53QAXpWx018124;
	Sat, 26 Apr 2025 12:33:51 +0200
Date: Sat, 26 Apr 2025 12:33:51 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 10/15] tools/nolibc: add timerfd functionality
Message-ID: <20250426103351.GC17549@1wt.eu>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
 <20250423-nolibc-misc-v1-10-a925bf40297b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423-nolibc-misc-v1-10-a925bf40297b@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 23, 2025 at 05:01:40PM +0200, Thomas Weiﬂschuh wrote:
> diff --git a/tools/include/nolibc/sys/timerfd.h b/tools/include/nolibc/sys/timerfd.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..2d61fc76fe9a9ba7571f52ff157a8a4807d7d9c9
> --- /dev/null
> +++ b/tools/include/nolibc/sys/timerfd.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * timerfd definitions for NOLIBC
> + * Copyright (C) 2025 Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> + */

Same note about not forgetting to add the nolibc include from the other
series here.

> +#ifndef _NOLIBC_SYS_TIMERFD_H
> +#define _NOLIBC_SYS_TIMERFD_H
> +
> +#include "../sys.h"
> +#include "../time.h"

Willy

