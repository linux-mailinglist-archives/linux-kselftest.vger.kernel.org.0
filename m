Return-Path: <linux-kselftest+bounces-47053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB27CA532D
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 21:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7685A309A7D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406733891A;
	Thu,  4 Dec 2025 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An3rPEtR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518C299937;
	Thu,  4 Dec 2025 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878610; cv=none; b=MYmCGOaXIUU85BLPUpFCVeZd5JHE7tNe2jOk4pNYNx8NwVUeAUU7aDDk+7voWHf01VV/NcJaIg1kF6evBt2w0vJwxxCPnm3VYlqvI+JtiTm4oueQMqy7LpRoRrH7xMEtD909M2aD8UDsAGk2jRPiJvVNuiQvOj8nvoq6hCIFbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878610; c=relaxed/simple;
	bh=F/tuPHzaviurzJ8050yVZnILe2Za/hpOx98W5eohkaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCkwqewD025sgQc4xL5HUQXY4/2GnafnT5wKKddfGSiA6jFI0nOikmn9S0jmOcpZYzH0xeR3SgocgMRNIN/fuOE/bvacaBrLojmDfiRxJznC2etfXkqDT4JsXolqzh4gX9IDg2XS1E10LtIdo80FJ7ayy3+QwTrtxWYNZdQdUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An3rPEtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D7FC4CEFB;
	Thu,  4 Dec 2025 20:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764878610;
	bh=F/tuPHzaviurzJ8050yVZnILe2Za/hpOx98W5eohkaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=An3rPEtRX7Jyz4iMxIs8MluEIB64ILjOZ/wuqdkJvSK1R1bjUz/odGewTfaQ4LgmW
	 Lgh3ePmU0/+JTMo/X8gDdVelcjdBrZ8iP9k2qhr7AxDJg+RYLEDixMXuAibxeI12QI
	 2pF1w088rtRx1kfpuT0LprSV6pznqjQAk6YDZvKNi/yeefyx7ZrkSa0ID2XPDVMGc6
	 ITeX3NpX0g2zD7798Pn38MEqq6QLRSWEEthbMFQKgaofQiUqHVKGeJKOMEK1/p2ymA
	 zYRLJ7gx1dlXzUDHFWeMgKRviTduUn1Erbn+g9ZK0hWzVk93jYc175tjYWCysl/m/n
	 Vd+ZM1Tm7tmZA==
Date: Thu, 4 Dec 2025 12:03:29 -0800
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, wine-devel@winehq.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <202512041201.EBE3BF03F5@keescook>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
 <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>

On Thu, Dec 04, 2025 at 09:16:16AM -0800, Guenter Roeck wrote:
> On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> > On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:
> > > This series fixes build errors observed when trying to build selftests
> > > with -Werror.
> > 
> > If your intention is to make -Werror the default please stop.
> > Defaulting WERROR to enabled is one of the silliest things we have done
> > in recent past.
> > 
> 
> No, that is not the idea, and not the intention.
> 
> The Google infrastructure builds the kernel, including selftests, with
> -Werror enabled. This triggers a number of build errors when trying to
> build selftests with the 6.18 kernel. That means I have three options:
> 1) Disable -Werror in selftest builds and accept that some real problems
>    will slip through. Not really a good option, and not acceptable.
> 2) Fix the problems in the upstream kernel and backport.

The series fixes build warnings that appear regardless of -Werror,
yes? That on its face is an improvement, so maybe just adjust the
Subject/changelogs?

-- 
Kees Cook

