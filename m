Return-Path: <linux-kselftest+bounces-46663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD32CC8FEAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 19:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76616343A7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867983002DB;
	Thu, 27 Nov 2025 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTI7NGgd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35E2FFDE2;
	Thu, 27 Nov 2025 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267936; cv=none; b=BlWHh5K95c/2NWt8/HdX9vG3O5/PKagzaqMdXJ29zzQth0mczEuiwbtyeOJaG2cs0bSMqpUiYh0eAHoUTG/aAreK8ZKhLwhp+YCr1LMmGOvovWuwQjm3RKwxw+1gMZzuJ9rXyReIUH20rzRJyKgud+p+TlWlf2kq+fvOnchhlws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267936; c=relaxed/simple;
	bh=4U7GjycIJ0nTS6ErulWOvbKg9W2AgVrJduwNRhinSiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7hj7rb52W1XlRnJ/skwo8SNfo4EVO8zw/bNEQ26MpdZ3e9SpJLz8ZGc0vUIMa4CtUy+s5xPGZ4UVrbx3FyImM7lsA+5hOd0u/N77WV1TnBDobV4nmMHKoWN6mtxx7aFCV5M3qTuJo8pDw4RwYK6QuX7T0KLL5BKFecOLke6Hig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTI7NGgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37560C4CEF8;
	Thu, 27 Nov 2025 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764267935;
	bh=4U7GjycIJ0nTS6ErulWOvbKg9W2AgVrJduwNRhinSiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTI7NGgd5iJCMDj9VTbLzLvskyITR6yKEz4rHf5ZCzjPL5IrOG68MuE9xeG7upxYl
	 ACvs27AikXfSH8ms08Ppm3ESKmg0G4eN4geYd+WzQgM5Gvk0sC2b6b7i+OKfczzebr
	 SRcHEEFFgNbzdRvUTFyM800BHiNztT2Cj11K/VoA/s1r728bbB18Nbsjy6uJbrWuLm
	 jCgH5lwAbm3gPFcN+/47cRRo7uFPpALeLnycB4x42pU2SQKG2XjQxdjRCX65wKG7Tb
	 kFaSVNjrI4DIiVwh/HfmnpaoyXGmW7kNBTuWsDnEryxa5b6eDkRkjPXJ+F9fW4gMh0
	 5rGH3Nmha1ZKg==
Date: Thu, 27 Nov 2025 18:25:30 +0000
From: Simon Horman <horms@kernel.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/net/ipsec: Fix variable size type not
 at the end of struct
Message-ID: <aSiXmp4mh7M3RaRv@horms.kernel.org>
References: <20251126054711.26465-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126054711.26465-1-ankitkhushwaha.linux@gmail.com>

On Wed, Nov 26, 2025 at 11:17:11AM +0530, Ankit Khushwaha wrote:
> The "struct alg" object contains a union of 3 xfrm structures:
> 
> 	union {
> 		struct xfrm_algo;
> 		struct xfrm_algo_aead;
> 		struct xfrm_algo_auth;
> 	}
> 
> All of them end with a flexible array member used to store key material,
> but the flexible array appears at *different offsets* in each struct.
> bcz of this, union itself is of variable-sized & Placing it above
> char buf[...] triggers:
> 
> ipsec.c:835:5: warning: field 'u' with variable sized type 'union
> (unnamed union at ipsec.c:831:3)' not at the end of a struct or class
> is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>   835 |                 } u;
>       |                   ^

FWIIW, I was able to reproduce this using the
-Wflex-array-member-not-at-end (n.b. different option name to above)
option with the GCC 15.2.0 toolchain here [1].

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/

> 
> one fix is to use "TRAILING_OVERLAP()" which works with one flexible
> array member only.
> 
> But In "struct alg" flexible array member exists in all union members,
> but not at the same offset, so TRAILING_OVERLAP cannot be applied.
> 
> so the fix is to explicitly overlay the key buffer at the correct offset
> for the largest union member (xfrm_algo_auth). This ensures that the
> flexible-array region and the fixed buffer line up.
> 
> No functional change.

I verified this does not change the layout of the union (now structure),
by copying it outside the function and giving it a name.
And then analysing the binary using pahole.

So I agree this should not have any run-time effect.

But I've CCed Gustavo and linux-hardening, as their experience
seems relevant here.

> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  tools/testing/selftests/net/ipsec.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
> index 0ccf484b1d9d..f4afef51b930 100644
> --- a/tools/testing/selftests/net/ipsec.c
> +++ b/tools/testing/selftests/net/ipsec.c
> @@ -43,6 +43,10 @@
> 
>  #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
> 
> +#ifndef offsetof
> +#define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
> +#endif
> +
>  #define IPV4_STR_SZ	16	/* xxx.xxx.xxx.xxx is longest + \0 */
>  #define MAX_PAYLOAD	2048
>  #define XFRM_ALGO_KEY_BUF_SIZE	512
> @@ -827,13 +831,16 @@ static int xfrm_fill_key(char *name, char *buf,
>  static int xfrm_state_pack_algo(struct nlmsghdr *nh, size_t req_sz,
>  		struct xfrm_desc *desc)
>  {
> -	struct {
> +	union {
>  		union {
>  			struct xfrm_algo	alg;
>  			struct xfrm_algo_aead	aead;
>  			struct xfrm_algo_auth	auth;
>  		} u;
> -		char buf[XFRM_ALGO_KEY_BUF_SIZE];
> +		struct {
> +			unsigned char __offset_to_FAM[offsetof(struct xfrm_algo_auth, alg_key)];
> +			char buf[XFRM_ALGO_KEY_BUF_SIZE];
> +		};
>  	} alg = {};
>  	size_t alen, elen, clen, aelen;
>  	unsigned short type;

