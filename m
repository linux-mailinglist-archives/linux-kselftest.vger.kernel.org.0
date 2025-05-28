Return-Path: <linux-kselftest+bounces-33912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDEAC5F27
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 04:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC8B3AE01B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 02:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3196141C72;
	Wed, 28 May 2025 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sccMv1rn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8AD53C;
	Wed, 28 May 2025 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398599; cv=none; b=LxyPm2W/F9S9WCDiHBLgZpkq/0KTfRnyo+VRh4idBtZnTWwChjhHNuQ/GrSZcFZq1xIoYY9hl8yqxGHoC4RJ7ha+ud8h8Vy3jl/xiX0UectPjJz7lFN47ICpp5v0uCSvEEZUQ4X3L7lVTuOWVWWJomuzOqEw2WOzJnAhXUjtjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398599; c=relaxed/simple;
	bh=HEau1pyiee5cWgzZViwY0o1ycTcxX+DgaCx3BHxoJOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZVYm/q5H+6vigyMK0kjp0kmETburlWaB+maHoYqyX5Eki9VMBUgRa/F0yL1Hk53eWpYY/TqprMDjcd0LudTRY0W4Wx4z9dh9L2huJgqMX/P/b1L5T8+8Kt0JrGg3hXb4m/i7sCIOqGySYrDq9JYtMTmPLGMdi76hWrVIo/+SPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sccMv1rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0FCC4CEE9;
	Wed, 28 May 2025 02:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748398598;
	bh=HEau1pyiee5cWgzZViwY0o1ycTcxX+DgaCx3BHxoJOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sccMv1rnjJ3U4KKB52lNHKFoFk2zK3BUFctep9wyyfX6gA+L1cXk2J7Ze3lhbIi1U
	 /LP7A4YTVvHiR2DdaK8GbcVwefYsZf8lL3JoMfLYoccb5jx+zYRjUCwLFawPKxnMNd
	 YvifufS4PEZp+GfPvxI56/sWdvtjKaI2IeMGMlyBxN7ROGKGyY+dMxcROeJbAXllq+
	 6hVrDCU//YffT31UTgtY4l9UqHakj63HuMkRECyIPqt+pS3KPgRIvCO3LwVsVP5DKI
	 YdaPnppqVEAzc2HHdaGjp6aF7ohpICcQBOqI5WvNBIJB+k1v7kYsdn3ccJfwNLmm8y
	 mjR7zB+gexVNw==
Date: Tue, 27 May 2025 19:16:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <20250527191637.1c0b996a@kernel.org>
In-Reply-To: <20250527-vsock-vmtest-v9-1-24eaeec6fa55@gmail.com>
References: <20250527-vsock-vmtest-v9-1-24eaeec6fa55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 17:36:54 -0700 Bobby Eshleman wrote:
> This commit introduces a new vmtest.sh runner for vsock.

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.

Please repost when net-next reopens after June 9th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


