Return-Path: <linux-kselftest+bounces-23611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FEA9F81C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 18:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1519A16988E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E758D1A2550;
	Thu, 19 Dec 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3oEXGbe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3381A2545;
	Thu, 19 Dec 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628847; cv=none; b=uUedVN+sONlbfvxc0ax5DUvoAUDU6as6XB1scZZRbaOmquJ6GBLWcgpIczThcw3G8avSyNE2efxLyJBuFMLRQyrvHgkUbbTzzf41ibpjarfhaOufkDgtX/7zQnZwF2hcczqMTV1HIZE9uuanyclytuUD+hvjIXBV6KnYYV/a+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628847; c=relaxed/simple;
	bh=Dp61a4XyXJ9LmojQA+6CWAeq8GDrOBVwfXno33BmibM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5uCYGHSzyU17tpJXf9256CBtwhtkMvMcI1wEQIyh5kwqxIazdwF3Yd/J5WEtEgfOXV1Ft1pfdpgZLLHCxeHHy7RRImgJaEF9hY/xM5jiib+WtNGemW784SA4uWIHztBanL+n/mTxeqSbLXWrSOB6cLmi5FrtVrXgkPKXczUO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3oEXGbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C154C4CECE;
	Thu, 19 Dec 2024 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734628847;
	bh=Dp61a4XyXJ9LmojQA+6CWAeq8GDrOBVwfXno33BmibM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3oEXGbeN0fS81ba9DcuNlggBx9qJFQArvXnlKshAeSyTsvBYisJmkQaVOlTZW4Qw
	 UzguT9ki6M+JauPG+kSSPipv4iDQXjg9tmvTuhdsO1sf/H4Yy4mtX35lcm9XEwtNS5
	 viiiweupR1zGpzaJoq0KpMy7B603k3ambsAQtpJf5ZsfcYX8KIHVY3ovotR21Y94gC
	 oMiyxts+cFONgdazH8lFrXG8me9svrXQY8Q4ZawcXZz08AXp2XMGwTdbAG1TYTW8/5
	 D6oERFcN1q920JnFfc9RoxoRZ+C2yzQkA2oA3/kyH+OImDgkkrsYpWCfwKbxE0KrY6
	 oceGq5RGzcpeg==
Date: Thu, 19 Dec 2024 17:20:41 +0000
From: Will Deacon <will@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH net-next v16 06/26] kref/refcount: implement
 kref_put_sock()
Message-ID: <20241219172040.GA25368@willie-the-truck>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
 <20241219-b4-ovpn-v16-6-3e3001153683@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-b4-ovpn-v16-6-3e3001153683@openvpn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 19, 2024 at 02:42:00AM +0100, Antonio Quartulli wrote:
> Similarly so kref_put_lock(), decrease the refcount
> and call bh_lock_sock(sk) if it reached 0.
> 
> This kref_put variant comes handy when in need of
> atomically cleanup any socket context along with
> setting the refcount to 0.
> 
> Cc: Will Deacon <will@kernel.org> (maintainer:ATOMIC INFRASTRUCTURE)
> Cc: Peter Zijlstra <peterz@infradead.org> (maintainer:ATOMIC INFRASTRUCTURE)
> Cc: Boqun Feng <boqun.feng@gmail.com> (reviewer:ATOMIC INFRASTRUCTURE)
> Cc: Mark Rutland <mark.rutland@arm.com> (reviewer:ATOMIC INFRASTRUCTURE)
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  include/linux/kref.h     | 11 +++++++++++
>  include/linux/refcount.h |  3 +++
>  lib/refcount.c           | 32 ++++++++++++++++++++++++++++++++

[...]

> diff --git a/lib/refcount.c b/lib/refcount.c
> index a207a8f22b3ca35890671e51c480266d89e4d8d6..76a728581aa49a41ef13f5141f3f2e9816d72e75 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -7,6 +7,7 @@
>  #include <linux/refcount.h>
>  #include <linux/spinlock.h>
>  #include <linux/bug.h>
> +#include <net/sock.h>
>  
>  #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
>  
> @@ -156,6 +157,37 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
>  }
>  EXPORT_SYMBOL(refcount_dec_and_lock);
>  
> +/**
> + * refcount_dec_and_lock_sock - return holding locked sock if able to decrement
> + *				refcount to 0
> + * @r: the refcount
> + * @sock: the sock to be locked
> + *
> + * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
> + * decrement when saturated at REFCOUNT_SATURATED.
> + *
> + * Provides release memory ordering, such that prior loads and stores are done
> + * before, and provides a control dependency such that free() must come after.
> + * See the comment on top.
> + *
> + * Return: true and hold sock if able to decrement refcount to 0, false
> + *	   otherwise
> + */
> +bool refcount_dec_and_lock_sock(refcount_t *r, struct sock *sock)
> +{
> +	if (refcount_dec_not_one(r))
> +		return false;
> +
> +	bh_lock_sock(sock);
> +	if (!refcount_dec_and_test(r)) {
> +		bh_unlock_sock(sock);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(refcount_dec_and_lock_sock);

It feels a little out-of-place to me having socket-specific functions in
lib/refcount.c. I'd suggest sticking this somewhere else _or_ maybe we
could generate this pattern of code:

#define REFCOUNT_DEC_AND_LOCKNAME(lockname, locktype, lock, unlock)	\
static __always_inline							\
bool refcount_dec_and_lock_##lockname(refcount_t *r, locktype *l)	\
{									\
	...

inside a generator macro in refcount.h, like we do for seqlocks in
linux/seqlock.h. The downside of that is the cost of inlining.

Will

