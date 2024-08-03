Return-Path: <linux-kselftest+bounces-14759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB379468CF
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A668E1C20B90
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA78120C;
	Sat,  3 Aug 2024 09:26:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA828376;
	Sat,  3 Aug 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722677166; cv=none; b=HGisKhXHsyutLUPSMJPVnnf6pLlLg7iXO/2IzmhwgStRYOgex6/BbyhdmsaK140klZwEqTn2aXz4e85L/VG1XIKt5E8PUiityjtkAIZO1xnuq8UgJZQridP72a+agfGgDjsshqnxPmk4cCQyuZCxh/Q7qG60igVnpNEfq1p9aIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722677166; c=relaxed/simple;
	bh=sfKNAiuNXhQmegmZ5oy0KIU9CdaGjk8LJURbpGSbsN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxysYaYzbHT4sXphGX8QLTUHelLkHG3xhotr4gxWsc0aQavuPx48IubxazBtOoif83mrWTnE3UlfYo/IPkudJqqJg714GXWc07oHkrp6x/qtwzKmLK8SxrEY/Yph6NhMwGbFwMgKCU0rzh+calGx/GvXRoJBF4C0QyF0qefp0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4739PwT2029198;
	Sat, 3 Aug 2024 11:25:58 +0200
Date: Sat, 3 Aug 2024 11:25:58 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/12] tools/nolibc: use attribute((naked)) if available
Message-ID: <20240803092558.GB29127@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-4-bc384269bc35@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240728-nolibc-llvm-v1-4-bc384269bc35@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jul 28, 2024 at 12:09:58PM +0200, Thomas Weiﬂschuh wrote:
> The current entrypoint attributes optimize("Os", "omit-frame-pointer")
> are intended to avoid all compiler generated code, like function
> porologue and epilogue.
> This is the exact usecase implemented by the attribute "naked".
> 
> Unfortunately this is not implemented by GCC for all targets,
> so only use it where available.
> This also provides compatibility with clang, which recognizes the
> "naked" attribute but not the previously used attribute "optimized".
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/compiler.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
> index fe3701863634..f77bb7d3e1a8 100644
> --- a/tools/include/nolibc/compiler.h
> +++ b/tools/include/nolibc/compiler.h
> @@ -9,6 +9,15 @@
>  #define __entrypoint __attribute__((optimize("Os", "omit-frame-pointer")))
>  #define __entrypoint_epilogue() __builtin_unreachable()
>  
> +#if defined(__has_attribute)
> +#  if __has_attribute(naked)
> +#    undef  __entrypoint
> +#    define __entrypoint __attribute__((naked))
> +#    undef __entrypoint_epilogue
> +#    define __entrypoint_epilogue()
> +#  endif
> +#endif /* defined(__has_attribute) */

I would find it cleaner to enclose the previous declaration with the #if
rather than #undef everything just after it has been defined. Also it's
not very common to undo declarations just after they've been done, and
it makes quick code analysis harder.

I think that it can resolve to roughly this:

#if defined(__has_attribute) && __has_attribute(naked)
#  define __entrypoint __attribute__((naked))
#  define __entrypoint_epilogue()
#else
#  define __entrypoint __attribute__((optimize("Os", "omit-frame-pointer")))
#  define __entrypoint_epilogue() __builtin_unreachable()
#endif
 
What do you think ?

Willy

