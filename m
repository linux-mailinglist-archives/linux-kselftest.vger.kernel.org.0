Return-Path: <linux-kselftest+bounces-25314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A213A20E1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B771882BA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B5D1CDA2D;
	Tue, 28 Jan 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngcSBs6K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E831991D2;
	Tue, 28 Jan 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080694; cv=none; b=ewigHtlgQZ3Nj2WmbATaipt2HHb3vi95c7pKV3KAIZOWdH/4NkPrHeB12rqMtOb7/B9W7fjA1uvD8VLsWxItpvy7a7e/H0jhFNxSut56CDzbO/U0ENCSy5qyvckff9reZ6DtNiij++tRB532WIAopv197rIAId7d+/z+iMvrHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080694; c=relaxed/simple;
	bh=bqzQVhTrpMA2uAx0Oer/MhQcFh1TGCsOexF5xB6IkPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4NXoKcdcJwWV6AbKDa5pXXrHOGvkH7r5ZadHudbSud1Nn4o9ZUfBAPkWnOCwYIsbBYiJloLRsfFdw5BAySJPMLM1BWJMR/PLlbvQJeuLRgDjeL4pLN3fIiy4jSjXECPNyiMNtiSPYKtpAU36iwRUkvUsCdbYK7PPmCUi20x/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngcSBs6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9C4C4CED3;
	Tue, 28 Jan 2025 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738080693;
	bh=bqzQVhTrpMA2uAx0Oer/MhQcFh1TGCsOexF5xB6IkPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngcSBs6KG5f362pVgzlakhoeZ2UU3Q1uMAdeexJz6NKVQSu1zKw+qKTsvKvW1qtCe
	 bJiyCl4COtdi4CikOnRFEfynrUmT0YipptgOTRd6xvGHloQCmoAbYqR27UNJdJTDz2
	 VuCJPlYBujprVVen6IR55zPZZG61q4kaER+QbOIK/Ri29/u5iC/MRwycJS+rjyrk3u
	 ynRIV9nJc4XWF4euNyHmlrB24KCy7LrRxT8xJp8nCAGwmqDissY9AyGw5SJkFy3ko+
	 gcOWLZJWYw/iM77zrfcdS6p+Nsqh/O40VdkbMXdGDRw2avgyfHx6POczWtgefgr8O4
	 qxecbiewfTScw==
Date: Tue, 28 Jan 2025 16:11:28 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 1/8] netconsole: consolidate send buffers
 into netconsole_target struct
Message-ID: <20250128161128.GB277827@kernel.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-1-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-netcon_cpu-v3-1-12a0d286ba1d@debian.org>

On Fri, Jan 24, 2025 at 07:16:40AM -0800, Breno Leitao wrote:
> Move the static buffers from send_msg_no_fragmentation() and
> send_msg_fragmented() into the netconsole_target structure. This
> simplifies the code by:
> - Eliminating redundant static buffers
> - Centralizing buffer management in the target structure
> - Reducing memory usage by 1KB (one buffer instead of two)
> 
> The buffer in netconsole_target is protected by target_list_lock,
> maintaining the same synchronization semantics as the original code.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..1a78704681184673f5c1ba8ae665e46751384293 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -137,6 +137,8 @@ struct netconsole_target {
>  	bool			extended;
>  	bool			release;
>  	struct netpoll		np;
> +	/* protected by target_list_lock */
> +	char			buf[MAX_PRINT_CHUNK];

nit: buf should also be added to the Kernel doc for this structure.

...

