Return-Path: <linux-kselftest+bounces-31702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF706A9DA43
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 12:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608C6160E5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 10:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC622425B;
	Sat, 26 Apr 2025 10:58:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2241AA1EC;
	Sat, 26 Apr 2025 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745665129; cv=none; b=iZCvIuO+c/HmCL0tDPg1wnKwAXSdeeUgpq9Zp/nmIe5v4SNpHBrJaCc32oZ9Ew8N8A58t7CHyMZNYPCB9VTwYTbkikjvHlOf0kkOfUk/F2ez15f8N70tOzTdaPPP3rirTwLcj/KD6J0QKxMtVmHoOx9avTmuYBWkoT1dL8OR73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745665129; c=relaxed/simple;
	bh=RDT4sOXFBQBQdcru+E2S3lVqfwpLJDy7UJ1WRCWy7l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn6W3SZhlds96HMUHdKZL4wE3cXcYENKOXq+AHbGKOJZez85kKCXDFfMJuqzeV4QsMSWLITzc8q4xrMH9S5ZF0ltRO3nZW66y95PS0ZCoLj0GJt9orPEeWVPKS1OWH2NHKqZBzmrYdgUnGkJ1F4CntLr9ngXC2Qt2vvvm1e7yYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53QAwgh0018846;
	Sat, 26 Apr 2025 12:58:42 +0200
Date: Sat, 26 Apr 2025 12:58:42 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 13/15] tools/nolibc: add fopen()
Message-ID: <20250426105842.GF17549@1wt.eu>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
 <20250423-nolibc-misc-v1-13-a925bf40297b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423-nolibc-misc-v1-13-a925bf40297b@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 23, 2025 at 05:01:43PM +0200, Thomas Weißschuh wrote:
> +static __attribute__((unused))
> +FILE *fopen(const char *pathname, const char *mode)
> +{
> +	int flags, fd;
> +
> +	if (!strcmp(mode, "r"))
> +		flags = O_RDONLY;
> +	else if (!strcmp(mode, "w"))
> +		flags = O_WRONLY | O_CREAT | O_TRUNC;
> +	else if (!strcmp(mode, "a"))
> +		flags = O_WRONLY | O_CREAT | O_APPEND;
> +	else if (!strcmp(mode, "r+"))
> +		flags = O_RDWR;
> +	else if (!strcmp(mode, "w+"))
> +		flags = O_RDWR | O_CREAT | O_TRUNC;
> +	else if (!strcmp(mode, "a+"))
> +		flags = O_RDWR | O_CREAT | O_APPEND;
> +	else {
> +		SET_ERRNO(EINVAL);
> +		return NULL;
> +	}

I'm concerned by the size of the function due to the repeated strcmp()
calls (also I find strcmp()==0 more readable that !strcmp() which I tend
to read as "not string compares").

I have not tried the code below but I think it could cover it in a maybe
lighter way:

	switch (*mode) {
		case 'r": flags = O_RDONLY; break;
		case 'w': flags = O_WRONLY | O_CREAT | O_TRUNC; break;
		case 'a': flags = O_WRONLY | O_CREAT | O_APPEND; break;
        	default : SET_ERRNO(EINVAL); return NULL;
        }

	if (mode[1] == '+')
		flags = (flags & ~(O_RDONLY|O_WRONLY)) | O_RDWR;

I think it does the same but should be significantly lighter.

Willy

