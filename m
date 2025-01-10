Return-Path: <linux-kselftest+bounces-24208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A6CA08F0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 12:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6047A130D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F08120ADF6;
	Fri, 10 Jan 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="u/Udx6Lc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5E205ABA
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508206; cv=none; b=ZI9Ls2mPX3DoBiV7EEcAxsdvYKcD744nop/YUo6xBTmMWuUee8W+H5NPItFpwKaKsizggPg61nnkULDzykAMbMcOwDVrFkDPBayv0Q8haFVPGgpv6DSOOJ1CDWqpsSHFffhJitilYjo06fN0P91rv8t8FukMGL5KwiEVNfqqsFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508206; c=relaxed/simple;
	bh=bdlNO3yKK05ZKaN4uWfxIVSK8c7+0EObM46B915nyxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux5wzYxLyV7C9CpiZp5ZwhuCeaY9Xxwxo+nhh4dHmDZXvqaRaXV2kk4DLD9gml6dFBqOZBUP/L58/0cjSy0xxD1H+3LxZjeHhTAMwSzHHwCYwLjY8GEREhtDkCH3ziWrBi68pwIcX916n7mfiXbpJuy2hlOAL6gw3F4Jd6k59PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=u/Udx6Lc; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTzmL28vDz11R;
	Fri, 10 Jan 2025 12:23:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508194;
	bh=6UiB4shNTla0uuyYvlN+y8UqueiEnbyVowti7Z7Fy3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/Udx6LcGTElwlVYakcX6ULQO4MtCGvlOA7z3CX9rJ+KmZJ7p0iR4GtyB0tZI24bc
	 fIyHkDU0PH79iFUBHDWG8rOOgwZPljQJKHIl5+5KCQ4xuov1CHD4/LAMEVwVwajW1T
	 +PYmiHVXRlMblpitihGAEaW48f90Yow2BTPfUGBw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTzmK4p7Czknk;
	Fri, 10 Jan 2025 12:23:13 +0100 (CET)
Date: Fri, 10 Jan 2025 12:23:12 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Ba Jing <bajing@cmss.chinamobile.com>, Jeff Xu <jeffxu@google.com>
Cc: gnoack@google.com, shuah@kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] landlock: ptrace_test: remove unused macros
Message-ID: <20250110.do3boi0AeKee@digikod.net>
References: <20241118042407.12900-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118042407.12900-1-bajing@cmss.chinamobile.com>
X-Infomaniak-Routing: alpha

Thanks!  This is now merged in my next tree.

On Mon, Nov 18, 2024 at 12:24:07PM +0800, Ba Jing wrote:
> After reviewing the code, it was found that these macros are never
> referenced in the code. Just remove them.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/landlock/ptrace_test.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index a19db4d0b3bd..8f31b673ff2d 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -22,8 +22,6 @@
>  /* Copied from security/yama/yama_lsm.c */
>  #define YAMA_SCOPE_DISABLED 0
>  #define YAMA_SCOPE_RELATIONAL 1
> -#define YAMA_SCOPE_CAPABILITY 2
> -#define YAMA_SCOPE_NO_ATTACH 3
>  
>  static void create_domain(struct __test_metadata *const _metadata)
>  {
> -- 
> 2.33.0
> 
> 
> 
> 

