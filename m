Return-Path: <linux-kselftest+bounces-22223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B289D1E55
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4979B2347D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 02:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5AC13A24D;
	Tue, 19 Nov 2024 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWi6g7Xj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12A78C76;
	Tue, 19 Nov 2024 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983716; cv=none; b=MVrBzBfxGwpkFB2p9x/MNplIdrmmhAlcvykzTEV/1TaO4ZOGFfptUAhaFVChH6QerVU5sUxQM14gxRN1d0shu4KCYbqbhNP3CjJWV0O1rSywvJ1AkRCFW4OnnwRyRJF6GatbnX3VC06gUlRtnTHiWl0VvdYaCE13sS7H9/TjGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983716; c=relaxed/simple;
	bh=1GoX5IhsH8FcKHG+6blRbHEVULqXKn7EekxL9MIkGcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owUUJuwhva9Toke8ibEBHlyHy5t5xZ9MlBqRA0M+7Gbxx2uq8jdCQ5oQ0ONFPsqwgkMq6jk6EbVuW3xeUALtoYDJxtgc0iBiwnQMFShJm8pGPvVsB2DfrqD/5t5clMxF0tSOxlI9WoZknVP2F7D/K4TzjCOzDJPyyVvmP+OxotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWi6g7Xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE73C4CECC;
	Tue, 19 Nov 2024 02:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983716;
	bh=1GoX5IhsH8FcKHG+6blRbHEVULqXKn7EekxL9MIkGcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QWi6g7XjppUoNmrHz6q2GJ0f3w6TCROAQ9i8Hp/l0HZUYnQNUO7LwRi4a+u9aor94
	 aszSjJYd31LOP8n59qK+32uMYFH9w/8SHv+UvqulaE7zahLZILqNrSQu2adKyZpm1u
	 K9SSEWBqF4JFaTlAC9mwYXrCGCRdRfDZgyIJ3tqxCnrXeE3AHX1GmqV5SV4agYaC3K
	 qmSH/LjY7PVmHRYXwQYrHc6P6vYstBJdeaGUmskMj7OCqdiYbxCUHa07TDYQAMgwWv
	 RgnXDcR2ZC1om6Z3ZB7y69IzVW3R0jNyF8jFM4yw3cItIhQsuyPvQubwRFpuvL0XHF
	 +DruudrtZySSQ==
Date: Mon, 18 Nov 2024 18:35:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, max@kutsevol.com, thepacketgeek@gmail.com,
 vlad.wing@gmail.com, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 4/4] netconsole: selftest: Validate CPU number
 auto-population in userdata
Message-ID: <20241118183514.112db8b9@kernel.org>
In-Reply-To: <20241113-netcon_cpu-v1-4-d187bf7c0321@debian.org>
References: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
	<20241113-netcon_cpu-v1-4-d187bf7c0321@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 07:10:55 -0800 Breno Leitao wrote:
> +	if ! grep -q "cpu=[0-9]\+" "${TMPFILENAME}"; then
> +		echo "FAIL: 'cpu=' not found in ${TMPFILENAME}" >&2
> +		cat "${TMPFILENAME}" >&2
> +		exit "${ksft_fail}"
> +	fi

Could we try to do something like pick a 'random' CPU ID from sysfs,
taskset the write / echo, and match that the incoming message has the
expected CPU ID, not just any?

