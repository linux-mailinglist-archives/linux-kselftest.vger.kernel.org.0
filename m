Return-Path: <linux-kselftest+bounces-46752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06514C94EC9
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 954F23438BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776DB263F5E;
	Sun, 30 Nov 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="XAJ1DXzV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A624A23;
	Sun, 30 Nov 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764500941; cv=none; b=uYe2TNhESUle//k9c0UR4P7aj9nNDnyQDJB+fgPzFIipvIP6myF0//T65hHx5I20AmBBJYubK20dnc/FLf0Av1UQKj3fiZqMuEBFEMpjP2X83HVREYUyN6nQ8ewjJGu9lLHAYXunZh3Sau6ENnp1uPDYQm/QGAl7QG2zRDemo8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764500941; c=relaxed/simple;
	bh=RsugsK+X2juf2r7tAHLC5/ChLxAzlcL+ptlX+dtux6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmmBLS+Y9ccHZk3Mz/3p0iQcPmPvXYZGiv5DBpE/estcnMiEHopr+jcGvmoC2pG2i8nNWlSYyaUqlxFSFJNYUSOzo6yHGV9cFHeJV7Pwmc1Dpu/D6uEy8PyNK79tIkSIT/UfZ7eNYGibQ+w6GEqVI6KiE9JBwSf6ILySYr7DcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=XAJ1DXzV; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1764500936; bh=IABG6YPVmEPR8RXOTOZQXCH/9ARVOI/ZzvN12k6e1pg=;
	h=From:Message-ID:From;
	b=XAJ1DXzVtQS/mgSw7GhZ4gJMYK/y1Jt/5zPf0pq0bSc584zty4elJi2FFB/POpWtU
	 O4Rb5S8yuG/Mn+AyLZjdWGXl9e4Zq0EQdJwUZz5D3pwypyymf9heoFvc1vhE5BJyoF
	 y3t987qxZ5nEPHcQf5CUi9weluVIrTulkMnXVL4E=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 7576FC04AB;
	Sun, 30 Nov 2025 12:08:56 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5AUB8uCT000674;
	Sun, 30 Nov 2025 12:08:56 +0100
Date: Sun, 30 Nov 2025 12:08:56 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 12/13] tools/nolibc: add __nolibc_static_assert()
Message-ID: <20251130110856.GE31522@1wt.eu>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
 <20251122-nolibc-uapi-types-v2-12-b814a43654f5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-nolibc-uapi-types-v2-12-b814a43654f5@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Nov 22, 2025 at 05:59:18PM +0100, Thomas Weiﬂschuh wrote:
> Add a wrapper for _Static_assert() to use within nolibc.
> While _Static_assert() itself was only standardized in C11,
> in GCC and clang dialects it is also available in older standards.
> 
> If it turns out that _Static_assert can't be used in some contexts,
> this wrapper can be adapted.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/compiler.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
> index 87090bbc53e0..ef247e916552 100644
> --- a/tools/include/nolibc/compiler.h
> +++ b/tools/include/nolibc/compiler.h
> @@ -47,4 +47,6 @@
>  #  define __nolibc_fallthrough do { } while (0)
>  #endif /* __nolibc_has_attribute(fallthrough) */
>  
> +#define __nolibc_static_assert(_t) _Static_assert(_t, "")

I'm not super fan of raising the bar to adoption by introducing forced
C11-isms, especially when they're only used to perform extra safety
checks that likely remain fine after you've checked them once. What
about instead:

+#if __STDC_VERSION__ >= 201112L
+# define __nolibc_static_assert(_t) _Static_assert(_t, "")
+#endif
+# define __nolibc_static_assert(_t) do { } while (0)
+#else

Note that this won't work out of code blocks but we very likely don't
care. And if we'd care, we could always switch to __asm__("") which
works everywhere.
 
What do you think ?

Thanks,
Willy

