Return-Path: <linux-kselftest+bounces-36851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F451AFF0F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D84D3B49A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B7D239E89;
	Wed,  9 Jul 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kSmM4r4m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B22367D7
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086213; cv=none; b=g1ahhncHTktgbVxHOtxgZOfR7fKZwc0y9JjABYJboplKWjATLpr0cSHgiSds174Me2/+TN+B36tNqR6brvAXuTIrVohSn2vcWsXQNQn8/+x8oZkb//2llge9r9xBL0O1Y+iv/9nP7X2dfyd3otmPEjwShTjzO1HHbNL0iykXwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086213; c=relaxed/simple;
	bh=NVoT+A5bakGJgVtuLkAn5t6ho67skfuEp+NXaEZU2zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooSHgoufhXClZbOdWW4v0oDCIJW7ChzBZm262oo/+iMxvgQKCdZGWTzsFhhDMETAZVikOboQj9MofjEMoFWoCdyszZ73PtOux1pU7wLeMhAvFPGCqpVW5dvW8tRfWgcgNqwJ8e9UnckPk2uxLnQOmHjCl/0CzyNUqMS2NYx1lO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kSmM4r4m; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752086209;
	bh=NVoT+A5bakGJgVtuLkAn5t6ho67skfuEp+NXaEZU2zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSmM4r4mtP3O1tVznavLTBkC+bZutUZsg9sJIuaPAg/SPPt7HC8IYk65yjW0/vT0Z
	 Z85XRBUfGMZagAAo0fqmACrGbZrJOpF4YL+QbBLbp+hUphsNcPkwfDsgwZzhv3NZWI
	 AIPlIQHLT2rHWHCLSoLw0SXA3C/nYo6VvEKVLSnA=
Date: Wed, 9 Jul 2025 20:36:49 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 2/3] tools/nolibc: add more generic BITSET_* macros for
 FD_*
Message-ID: <1f927eac-15b4-41f2-843a-5226015da96b@t-8ch.de>
References: <20250709155512.971080-1-benjamin@sipsolutions.net>
 <20250709155512.971080-3-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709155512.971080-3-benjamin@sipsolutions.net>

On 2025-07-09 17:55:11+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The FD_* macros are assuming a specific type for the bitset. Add new
> macros that introspect the type of the passed variable in order to know
> the size of the bitset. This way the same macros can be used for other
> purposes.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/nolibc/types.h | 67 +++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
> index 16c6e9ec9451..3100771e21ad 100644
> --- a/tools/include/nolibc/types.h
> +++ b/tools/include/nolibc/types.h
> @@ -115,48 +115,53 @@
>  #define EXIT_SUCCESS 0
>  #define EXIT_FAILURE 1
>  
> -#define FD_SETIDXMASK (8 * sizeof(unsigned long))
> -#define FD_SETBITMASK (8 * sizeof(unsigned long)-1)
> -
> -/* for select() */
> -typedef struct {
> -	unsigned long fds[(FD_SETSIZE + FD_SETBITMASK) / FD_SETIDXMASK];
> -} fd_set;
> -
> -#define FD_CLR(fd, set) do {						\
> -		fd_set *__set = (set);					\
> -		int __fd = (fd);					\
> -		if (__fd >= 0)						\
> -			__set->fds[__fd / FD_SETIDXMASK] &=		\
> -				~(1U << (__fd & FD_SETBITMASK));	\
> +#define BITSET_CLR(num, set) do {					  \

__NOLIBC_BITMASK_CLEAR()

To avoid conflicts with user code, being clear about the intent and
having some constency with the kernel code.

> +		__typeof__(set) *__set = &(set);			  \
> +		int __num = (num);					  \
> +		if (__num >= 0 && __num < 8 * (ssize_t)sizeof(*__set))	  \
> +			(*__set)[__num / (8 * sizeof(set[0]))] &=	  \
> +				~(1U << (__num % (8 * sizeof(**__set)))); \
>  	} while (0)
>  
> -#define FD_SET(fd, set) do {						\
> -		fd_set *__set = (set);					\
> -		int __fd = (fd);					\
> -		if (__fd >= 0)						\
> -			__set->fds[__fd / FD_SETIDXMASK] |=		\
> -				1 << (__fd & FD_SETBITMASK);		\
> +#define BITSET_SET(num, set) do {					\
> +		__typeof__(set) *__set = &(set);			\
> +		int __num = (num);					\
> +		if (__num >= 0 && __num < 8 * (ssize_t)sizeof(*__set))	\
> +			(*__set)[__num / (8 * sizeof(set[0]))] |=	\
> +				1U << (__num % (8 * sizeof(**__set)));	\
>  	} while (0)
>  
> -#define FD_ISSET(fd, set) ({						\
> -			fd_set *__set = (set);				\
> -			int __fd = (fd);				\
> +#define BITSET_ISSET(num, set) ({					\

__NOLIBC_BITMASK_TEST()

> +		__typeof__(set) *__set = &(set);			\
> +		int __num = (num);					\
>  		int __r = 0;						\
> -		if (__fd >= 0)						\
> -			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
> -1U << (__fd & FD_SETBITMASK));						\
> -		__r;							\
> +		if (__num >= 0 && __num < 8 * (ssize_t)sizeof(*__set))	\
> +			__r = (*__set)[__num / (8 * sizeof(set[0]))] &	\
> +			      (1U << (__num % (8 * sizeof(**__set))));	\
> +		!!__r;							\
>  	})
>  
> -#define FD_ZERO(set) do {						\
> -		fd_set *__set = (set);					\
> +#define BITSET_ZERO(set) do {						\
> +		__typeof__(set) *__set = &(set);			\
>  		int __idx;						\
> -		int __size = (FD_SETSIZE+FD_SETBITMASK) / FD_SETIDXMASK;\
> +		int __size = sizeof(*__set) / sizeof(**__set);		\
>  		for (__idx = 0; __idx < __size; __idx++)		\
> -			__set->fds[__idx] = 0;				\
> +			(*__set)[__idx] = 0;				\
>  	} while (0)
>  
> +#define FD_SETIDXMASK (8 * sizeof(unsigned long))
> +#define FD_SETBITMASK (8 * sizeof(unsigned long)-1)
> +
> +/* for select() */
> +typedef struct {
> +	unsigned long fds[(FD_SETSIZE + FD_SETBITMASK) / FD_SETIDXMASK];
> +} fd_set;
> +
> +#define FD_CLR(fd, set) BITSET_CLR(fd, (set)->fds)
> +#define FD_SET(fd, set) BITSET_SET(fd, (set)->fds)
> +#define FD_ISSET(fd, set) BITSET_ISSET(fd, (set)->fds)
> +#define FD_ZERO(set) BITSET_ZERO((set)->fds)

These could be inline function I think.

> +
>  /* for getdents64() */
>  struct linux_dirent64 {
>  	uint64_t       d_ino;
> -- 
> 2.50.0
> 

