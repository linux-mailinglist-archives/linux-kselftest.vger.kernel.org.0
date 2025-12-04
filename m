Return-Path: <linux-kselftest+bounces-47042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA8CCA4801
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8ED3301AD1A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3C2F5A1A;
	Thu,  4 Dec 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBMtB/3p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1932F3C25;
	Thu,  4 Dec 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865832; cv=none; b=FpamFgYZYt/GwTrxmZk3Pl6XIoXMySfu4hlEmlBqvuZd/0OvzIqf/6Z7AYpq9Rgi7tg2BZkcypiNDL7pYuZxXOa52muGCWDZXvfnUhVUqdxBVz1m9c6K2atcP6qLPlW1xa0SDhgqEOdtwfflrxVNcFMySe4eidJWXg4pkMDiaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865832; c=relaxed/simple;
	bh=SE2HTB4lJ6g7toD2TuLecngAbh7hMHZEgFCorTLRzOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftLbhRx9sBUQs9pP2e+Mn4u8ybAjvky6Ck4vV9lU8h2DtCUoCAgwqu6FJtQcQ6J/rXNcUepLLM7rp+apOgpc54tj145fkju27VZKYoydbpwQJVVSKflQ/ZNX9Y0lEBxh+knS4RwceVfkEZAJ5TYqlPb9Xw3rkH6pfu57ysYNhVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBMtB/3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C55C4CEFB;
	Thu,  4 Dec 2025 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764865831;
	bh=SE2HTB4lJ6g7toD2TuLecngAbh7hMHZEgFCorTLRzOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBMtB/3pZ4ZCLQuV2U80QyCkJ5AX55vAIOFBqxCZOVeUQROWTaqalVjaa5g+ty0Gf
	 s+ghJjP+xph8kp/lq+BeLnzWw9PULu+aWd9NQ0MRF+PN2ZzZxsBQD++25E+piPjlGH
	 DIqsk4+rr3vsygr0sChjsql4E/MA42s2CHpd8J5Y7dEP8uCHLL+HamUlm9D0aLfV1J
	 k9VawOvqhpDb4g+yGyBAs7vEwOuE1yKpCuymU4+/pUXYs5B6x9p98fih7Z+nkrLA87
	 e/ViWMveH0A3JTsUrdkIyjn6/g6+zszQip4OhAb4Ge32eGoq+46AVw/Gp8oZ0Ltc5X
	 jUnRwV+guBuHQ==
Date: Thu, 4 Dec 2025 08:30:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Elizabeth Figura <zfigura@codeweavers.com>, Thomas Gleixner
 <tglx@linutronix.de>, Eric Dumazet <edumazet@google.com>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, wine-devel@winehq.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Joe Damato
 <jdamato@fastly.com>
Subject: Re: [PATCH 10/13] selftests: net: Work around build error seen with
 -Werror
Message-ID: <20251204083029.188cd7a0@kernel.org>
In-Reply-To: <20251204161729.2448052-11-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
	<20251204161729.2448052-11-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Dec 2025 08:17:24 -0800 Guenter Roeck wrote:
> -	write(fd, msg, sizeof(msg));
> +	if (write(fd, msg, sizeof(msg)))
> +		;

At least add an perror here ?

