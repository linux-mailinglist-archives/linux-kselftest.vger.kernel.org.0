Return-Path: <linux-kselftest+bounces-47041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2FCCA4B66
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97EE6303073F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8302EDD64;
	Thu,  4 Dec 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7STUNvj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A832D47E8;
	Thu,  4 Dec 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865676; cv=none; b=RgkOcEsxp7xLPyaf/3oE4KtBHdLPYA6aMjeoqpN9tHjBvSJSlICQKtePbVjuLYH/PXYMg4DeVS4tTvgUx7OI1KbM65vPPmYnuVbUnWmzULxj5AlxbpsERPqIPYhBn8CU71UtPk3aVqFrwt/dylvXk9mivPUPnqBDAzlTY0sqq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865676; c=relaxed/simple;
	bh=581B1SlMsFDvgNegn6JUJ3XGiVPnodiNvou0kRcy7ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+2DxRlRq/jh7AfXYadonaNtFb1kPs6ciKHYvjZkMFhhM8A0RrHrMKNrYz/OoKck/hEim+XEpEClDBPpbI/s8nOxA/ex2wBpZjySeknGcFNDkMURrlYy8DqyRLwZN58gkz6c04A26EosuxST3tQd+Cmjj7xWoxHap+9VtVrCBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7STUNvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59873C4CEFB;
	Thu,  4 Dec 2025 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764865675;
	bh=581B1SlMsFDvgNegn6JUJ3XGiVPnodiNvou0kRcy7ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i7STUNvjE/9AOB5UX4WzOkpyfqsOcqf2uJh+epCv79qIUOoCb4MEY0jz1imtDYpPC
	 nYWlf8zvzqkuIzMoH95uqpWxkBm0QCsskO7icanilST/qt+ZEegUoZBC6LW4tDhz0u
	 hWWHOH3TOohGCH1BJ3s9+y01zjAZdvqyvzs0d8kpys1pTVEYxR+PpZOMRczUbMAo78
	 G0nBO2g3jvvXn3zQ0YH2CVq0fNKnfqKVJpwAYpI/PpJV6rnQN/LyGQaGqRwAXm3Qka
	 htg9jpq2bg2ZK4lQPBJNCHOv+kiLENCH0m4yMAYsMkPUH4IYJrSt3oDXoPAY/KmeYB
	 diQtTVBXpx4Dg==
Date: Thu, 4 Dec 2025 08:27:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Elizabeth Figura <zfigura@codeweavers.com>, Thomas Gleixner
 <tglx@linutronix.de>, Eric Dumazet <edumazet@google.com>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, wine-devel@winehq.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <20251204082754.66daa1c3@kernel.org>
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:
> This series fixes build errors observed when trying to build selftests
> with -Werror.

If your intention is to make -Werror the default please stop.
Defaulting WERROR to enabled is one of the silliest things we have done
in recent past.

People will try to use new compilers on a kernel after it has already
been released. Not being able to build the kernel because of some false
positive warning in another subsystem is so annoying :|

