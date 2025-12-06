Return-Path: <linux-kselftest+bounces-47222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A980FCAA422
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 11:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1CBE30572F2
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C612D7DED;
	Sat,  6 Dec 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nky6W7yy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842733B8D58;
	Sat,  6 Dec 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765016826; cv=none; b=Pu4d4YXLSkO+a2ES/b4sYktPFzFkHffOCTJrzHVV8+UubE2rJwd34zbcOZXNEfaN4dwJ0/Byqtd+72sG6RQoykRXYdBrm/xfHpitAzDrf2nkIb6WOQXcJs4PzYaG9C0LNSfoWaTnH6/QhSvUTDkwQmTfhnaPohQtjg9udyxeNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765016826; c=relaxed/simple;
	bh=5xBMLdvMh4YXjCcTKiBSZoEIiOrT8J8JEJHJ3JpAzuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4ViYVzGfAqvVX3kNRiqtYSQ021tIB4JySpYLN6l/m9W+2oDdrIEgwi0M+KhhXI/afRlp+snlqrIZGabuiPus/JjuKpIzaiN1srMh4QNs3K/xieyPThwMXAt6wPzwCsa0aktVNtObf04deUxsBfyKyDnH5nJvnD1y7NIjU3ZsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nky6W7yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1454FC4CEF5;
	Sat,  6 Dec 2025 10:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765016826;
	bh=5xBMLdvMh4YXjCcTKiBSZoEIiOrT8J8JEJHJ3JpAzuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nky6W7yyBrPQvLGNBLaT4nx9rhDT/rHgWZm6Sp4kzF+MnLdTjz+x3ROSG8XvU11Do
	 Dh82ZPZ9UrqlzLUyRpXWXHLttZjkDBygNfXVxpUU6+jvqHiSIjLSRvMEufeQckbZy8
	 KI19BHhMBXT+Foz61HYQ0TtIeRi+8j8a/u+WMsl14WnyNYR3w83NlB3Od5oGm4iGso
	 nyoyiYz6vibz14GwvhKptBNu5h9GcPCp27jxq4xONe7avyZYchRkoyqWasXtHEnvkI
	 lnFP4Xyp5aXJpF/4BQ/FmkOIGbck3lw9ARkYiitDpCCrqIyn1ya6aepwpTvuroMTwu
	 /kzMkKcpuygzQ==
Date: Sat, 6 Dec 2025 10:27:01 +0000
From: Simon Horman <horms@kernel.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: tls: fix warning of uninitialized
 variable
Message-ID: <aTQE9WDQxBA3g6Gr@horms.kernel.org>
References: <20251205163242.14615-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205163242.14615-1-ankitkhushwaha.linux@gmail.com>

On Fri, Dec 05, 2025 at 10:02:42PM +0530, Ankit Khushwaha wrote:
> In 'poll_partial_rec_async' a uninitialized char variable 'token' with
> is used for write/read instruction to synchronize between threads
> via a pipe.
> 
> tls.c:2833:26: warning: variable 'token' is uninitialized
>       		   when passed as a const pointer argument
> 
> Initialize 'token' to '\0' to silence compiler warning.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> ---
> compiler used: clang version 21.1.5 (Fedora 21.1.5-1.fc43).
> 
> changelog:
> v2:
> - update patch name and msg
> 
> v1: https://lore.kernel.org/all/20251129063726.31210-1-ankitkhushwaha.linux@gmail.com/

Hi Ankit,

Thanks for the update. Overall this seems good to me, however,
net-next is currently closed.

## Form letter - net-next-closed

The merge window for v6.19 has begun and therefore net-next has closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens.

Due to a combination of the merge-window, travel commitments of the
maintainers, and the holiday season, net-next will re-open after
2nd January.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: defer

