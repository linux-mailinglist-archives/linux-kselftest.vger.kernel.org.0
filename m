Return-Path: <linux-kselftest+bounces-47817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47178CD52CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 09:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB1C30142C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD03239E81;
	Mon, 22 Dec 2025 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="mD9NghJd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52584217733;
	Mon, 22 Dec 2025 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393293; cv=none; b=V6p8LpCyy9AJlFkQUsmwrb8vKHVL4u87aL7gxq6GEnDt9hKjDV0CE4rcuTn0Bbnnu6zhiyBw3NpEWPlTh6iCj+JDFfHxvCRs1/EWxRq49HPvmM6TVAvUgcYCL8kSdH5lQtnvuk9qN1Y0DQUPkChtLPtNO95BPenDYOm+OcN+Qyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393293; c=relaxed/simple;
	bh=UQtbpPkUERDimIaVIksa6Cveb0y4jJprtXFww8b8zh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmXnRNx8PpyK+onKZpYNFnJga6Qz6T8BjhVzx5sIhty2iiwtGpM1xb9TTq80Ocn+U3cSZT7FrXdD6CFJcBgAGJUO2j43X2o+PPNIwUZF8xAYbr5eRovBn9oDsNY/3rsAEqFLsZA7HcPCJ+aq78Ejpwae/LN/2XDLC6ejDh8vILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=mD9NghJd; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1766393288; bh=G4MjxruSLd/BlgDgmukBh/Sk5rDQFYYz1ZrypNbrdEk=;
	h=From:Message-ID:From;
	b=mD9NghJdmCWWUmwg3jiXRL0hulfBdXwUaS/a1nAPGtr7eQuwuLUq0yBI1meJNYUre
	 hNNwyvZJQxfcV8AaxOGNFZQjOMRfyNhPkXTSlA1GWVx37B2T5WL95s9ZsfEStgi7m7
	 hRqvkqaIXb+QtAahOvLtv0xD0oZtPYkS46H9VTrc=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 46089C0847;
	Mon, 22 Dec 2025 09:48:08 +0100 (CET)
Date: Mon, 22 Dec 2025 09:48:08 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 12/14] tools/nolibc: add compiler version detection
 macros
Message-ID: <aUkFyPymJPge2hVS@1wt.eu>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
 <20251220-nolibc-uapi-types-v3-12-c662992f75d7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251220-nolibc-uapi-types-v3-12-c662992f75d7@weissschuh.net>

On Sat, Dec 20, 2025 at 02:55:56PM +0100, Thomas Weiﬂschuh wrote:
> Some upcoming logic needs to depend on the version of GCC or clang.
> 
> Add some helper macros to keep the conditionals readable.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/compiler.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
> index 87090bbc53e0..c9ffd0496dae 100644
> --- a/tools/include/nolibc/compiler.h
> +++ b/tools/include/nolibc/compiler.h
> @@ -47,4 +47,20 @@
>  #  define __nolibc_fallthrough do { } while (0)
>  #endif /* __nolibc_has_attribute(fallthrough) */
>  
> +#define __nolibc_version(_major, _minor, _patch) ((_major) * 10000 + (_minor) * 100 + (_patch))
> +
> +#ifdef __GNUC__
> +#  define __nolibc_gnuc_version \
> +		__nolibc_version(__GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__)
> +#else
> +#  define __nolibc_gnuc_version 0
> +#endif /* __GNUC__ */
> +
> +#ifdef __clang__
> +#  define __nolibc_clang_version \
> +		__nolibc_version(__clang_major__, __clang_minor__, __clang_patchlevel__)
> +#else
> +#  define __nolibc_clang_version 0
> +#endif /* __clang__ */
> +
>  #endif /* _NOLIBC_COMPILER_H */

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks,
Willy

