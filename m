Return-Path: <linux-kselftest+bounces-26743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC7EA37499
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 14:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD3E3ADD62
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E3E192B9D;
	Sun, 16 Feb 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3fBkFKI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7E78F35;
	Sun, 16 Feb 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739714329; cv=none; b=dsFUIkLEJLVmJ73ejp0VkMBDuOjhepCf2SBnV4Dpl8luFQovwHw5SNz3pwR2NyChXsf9lnT89QbEOrFxrosoL9CwBvV0kZWVXL7XdUwnhU2EuLnvJfTLeM97nm1RN/NispYXPGRnX8A4yPGNaFQ+cV1wGzCzdNdpHcgY8KBEDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739714329; c=relaxed/simple;
	bh=5uNVuKLVqQy802BnKY+ivTEhCRLZCyGAsm/9/7/vMlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK/l0mJPF6P5BcJjAQftOOcaTMmTLHfh8b71ffaBYp5WdB3RA2LYezCeQgPMdvtRD64vFHeNu62kN+AS8k5R0OJ2N95IUpC0U5oaFvnvasCT/Sim+4L5QckAqioKhd2mTUQX2zLFWUIDPRp0CEvtwMpPZM466qVvXxiREJjsYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3fBkFKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421A5C4CEDD;
	Sun, 16 Feb 2025 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739714328;
	bh=5uNVuKLVqQy802BnKY+ivTEhCRLZCyGAsm/9/7/vMlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3fBkFKILCunLEJVn7qoBqRWaUgVgPNQZoNd+0CpeTtI8yjP/aiLxYpjdgdFt6Ofe
	 bLyb5ihBJRb90Jy/HgUQ6mjNxpNxGg1U19n69+aRxgFto5hAw3L0l+PMx7WtlAp0lR
	 YxYZfUUJR5HkUgAW0NGeU9xXL0LrbiI2f+LVQ2r7mTZuKSr2buEqvLSUIZGu1/DDdE
	 tVsEvNqw6sWacjrftVU3aOxWX+6PhKw0TYHnKp4NhS+C2xB5y3RhQU/0/2fcuVYhG2
	 BfRpY8yGpEGmlG7cWYX3czESI17ICetX2XHX/ZaG9tgDWOnu8GB2VOnrNc5zsLaA8t
	 CjOfUvuxPi4aQ==
Date: Sun, 16 Feb 2025 13:58:44 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 4/8] net: pktgen: fix mpls maximum labels
 list parsing
Message-ID: <20250216135844.GE1615191@kernel.org>
References: <20250213111920.1439021-1-ps.report@gmx.net>
 <20250213111920.1439021-5-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213111920.1439021-5-ps.report@gmx.net>

On Thu, Feb 13, 2025 at 12:19:16PM +0100, Peter Seiderer wrote:
> Fix mpls maximum labels list parsing up to MAX_MPLS_LABELS/16 entries
> (instead of up to MAX_MPLS_LABELS - 1).
> 
> Addresses the following:
> 
> 	$ echo "mpls 00000f00,00000f01,00000f02,00000f03,00000f04,00000f05,00000f06,00000f07,00000f08,00000f09,00000f0a,00000f0b,00000f0c,00000f0d,00000f0e,00000f0f" > /proc/net/pktgen/lo\@0
> 	-bash: echo: write error: Argument list too long
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes v4 -> v5
>   - split up patchset into part i/ii (suggested by Simon Horman)
>   - change patch description ('Fixes:' -> 'Addresses the following:',
>     suggested by Simon Horman)

Reviewed-by: Simon Horman <horms@kernel.org>


