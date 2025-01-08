Return-Path: <linux-kselftest+bounces-24084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6746FA067A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 22:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A169A3A6B6C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5A1AA1EE;
	Wed,  8 Jan 2025 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfVLMhq7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04D18A6A9;
	Wed,  8 Jan 2025 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373431; cv=none; b=bCsIw85M1XymMed8qaazLOnXo3TOzPBMyPwybwrUrVK4qlgHDfAN+FxE4O0PRDrKB6Nirj+amwu8ZJWRsEVkwsGoTJR2OvhKaEuc9Dl3nfNHC5QKmQ3nYs7Z3ZNmgq5if+1Ey4fZ7CTt0XFt2bbvhpncCmqdhVN4HblsFVgUkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373431; c=relaxed/simple;
	bh=PlB5rRCAg8PN3jNQ5Zd9S4cJXD/pPT82JVYXYz1NosA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5bpkGPjRXXq9cwP53WHo18sdnftq+kHMQpbGok7nArhu+sOnWPRV8rX7msxsp9jYqYRcN4XTCxSs7+Uxknw3DSr2S3IVunKB/05Lp57wFSrh+WKX1UdmgAB3Ij0U4CNB7IhiuekVgNprSlMAQ3L7fQCmldv/N9ty9Cc+F5Xmbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfVLMhq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB80C4CED3;
	Wed,  8 Jan 2025 21:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736373431;
	bh=PlB5rRCAg8PN3jNQ5Zd9S4cJXD/pPT82JVYXYz1NosA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfVLMhq7dFW5gBhXst01jNX8r1ow/nDeJwG318UIQubgWkovk3NkxmCpgjD8PrGu9
	 TKYrK/uaKyKJB1pGLSDzFtJnAaOhrxYcjLMy51oCdvleyIhu20d1RoeoaaZeFpR0QI
	 3qQe0g1woljw3nwAPkHHXeQr8tVN5+eAgH61N90x+g0P0yxBhJ4iE9KyB1UQ6gsB7m
	 jftsU8FRXCmg5wxeTX9YpZtFNKeqScuZ/Ki31qlj1JkCvKefvfiKnvuCJtOCINBU08
	 MfwgAdnkYiz7f9umN6kJ2IJ5FACX4wfUAzkGjacKqM2+XCw9pmaWVDPF/d/l6bbEDi
	 ykxjj7ABVeY8A==
Date: Wed, 8 Jan 2025 13:57:08 -0800
From: Kees Cook <kees@kernel.org>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Shuah Khan <shuah@kernel.org>, Gabi Falk <gabifalk@gmx.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: harness: fix printing of mismatch values in
 __EXPECT()
Message-ID: <202501081357.BE10EC4403@keescook>
References: <20250108170757.GA6723@strace.io>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108170757.GA6723@strace.io>

On Wed, Jan 08, 2025 at 07:07:57PM +0200, Dmitry V. Levin wrote:
> intptr_t and uintptr_t are not big enough types on 32-bit architectures
> when printing 64-bit values, resulting to the following incorrect
> diagnostic output:
> 
>   # get_syscall_info.c:209:get_syscall_info:Expected exp_args[2] (3134324433) == info.entry.args[1] (3134324433)
> 
> Replace intptr_t and uintptr_t with intmax_t and uintmax_t, respectively.
> With this fix, the same test produces more usable diagnostic output:
> 
>   # get_syscall_info.c:209:get_syscall_info:Expected exp_args[2] (3134324433) == info.entry.args[1] (18446744072548908753)
> 
> Fixes: b5bb6d3068ea ("selftests/seccomp: fix 32-bit build warnings")
> Signed-off-by: Dmitry V. Levin <ldv@strace.io>

Ah nice, thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

