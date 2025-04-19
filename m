Return-Path: <linux-kselftest+bounces-31194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE8A94288
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F6E3B90DE
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468DA193062;
	Sat, 19 Apr 2025 09:11:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0854782;
	Sat, 19 Apr 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745053909; cv=none; b=qD71W+mJczNQ3rPS7C5PdBUQin6X3YeVy8QG3qoKTgaGIkcmbVyrNu/7B0LU7fdnsQLw6w167MMYk5N653LqEhv+m2BkZ99fzWx8FQAab21cFMAkEsa8TZndXqZuo1ZSrRnRPba/jLmFiiaup/M1t9h4TIpklUxFJXHBJqWLE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745053909; c=relaxed/simple;
	bh=x47pnSISA+L4qEtR9ENKy8IOho8TGTlstk3HSlld7cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXnRGRTZ+ktySGw44ZtEP50fkv0sSTMjcfRZ8rgxc4mdlNerPNB41hrthm3NRPTRD5a7uBvVOQe29ul9yeo6h7IBNU1bEFKRpSpt0hn0KwV5wlWLblAEKHQ43b23w03XbnUn4Xi5GwXAv0D325r4Omajx3oJ6AiKVKVIheijQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53J9BeJE032032;
	Sat, 19 Apr 2025 11:11:40 +0200
Date: Sat, 19 Apr 2025 11:11:40 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/6] tools/nolibc: properly align dirent buffer
Message-ID: <20250419091140.GC31874@1wt.eu>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
 <20250416-nolibc-ubsan-v1-3-c4704bb23da7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416-nolibc-ubsan-v1-3-c4704bb23da7@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 16, 2025 at 08:40:18PM +0200, Thomas Weiﬂschuh wrote:
> As byte buffer is overlaid with a 'struct dirent64'.
> it has to satisfy the structs alignment requirements.
> 
> Fixes: 665fa8dea90d ("tools/nolibc: add support for directory access")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Oh good catch! I already faced crashes in other programs due to AVX
memcpy when doing similar casts without thinking about alignment.

> @@ -58,6 +58,7 @@ int closedir(DIR *dirp)
>  static __attribute__((unused))
>  int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
>  {
> +	__attribute__((aligned(__alignof__(struct linux_dirent64))))
>  	char buf[sizeof(struct linux_dirent64) + NAME_MAX + 1];

I tend to find it more readable when the attribute is on the same line as
the type on variables declaration, often at the end of the line, to keep
declarations alignes, even if that makes longer lines. If alignment concerns
come back often, we could maybe have __nolibc_align(<align>) and maybe even
__nolibc_align_as(<type>) to slightly shorten the lines. Just an idea.

In any case: Acked-by: Willy Tarreau <w@1wt.eu>

Willy

