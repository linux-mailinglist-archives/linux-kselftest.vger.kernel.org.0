Return-Path: <linux-kselftest+bounces-25849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B15A28BBF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E5116804A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2277D86328;
	Wed,  5 Feb 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRZRAaky"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE577126C03;
	Wed,  5 Feb 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762501; cv=none; b=oJ8Nc33rgLDAO697rw5oJb4HAaXZKXHFMgnbqfPtPB1qinFwEeUjbERxkCL5mt8JbT5Hf9O4Lm02VCl3SLU2XNqXr2OPp5/horr9V92zffPxK2Twgr9LaqsG13Ifhjv1FzoSW9aqYO3obemfErY3yHOy9oPFvRrKB2Q42kkKO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762501; c=relaxed/simple;
	bh=ylyzBhfK36oYMIuzOzuX7mbpXEoCjZ+TtZ+GLpD+u4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwXDX/06Od7VC8KTf9FosqOxwGURgw4XLEA+5c7F/E2BSeSd/F4nbUT2KdLR/ZFyPDDZ5xQlGU5QshWFVyRJdnwFoqPX7EC6HOGdOGezER3xtaEEHLbiW7w3UcPkJOznnzWy1oFRCWDjDFvmPIdl/RhJhJiImH5sbKXJoaxTtio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRZRAaky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EB8C4CED1;
	Wed,  5 Feb 2025 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738762500;
	bh=ylyzBhfK36oYMIuzOzuX7mbpXEoCjZ+TtZ+GLpD+u4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRZRAakyQZ3qbDhYAJ5ggSNoMJgY+bZEEsoSecv12sKfsFpMz3rWQO1jfeHw5xq7K
	 QEt3PPUSOwHwgZEFUnRHvFNRUqOu+/AHmYR3KoVo85LO3zwDGS5w08kKJZtdqbUMBz
	 lg2/uqUQeehRDTW08qFVlYvjbVajqQN6zm3foPfMULs/6EYmUN4VtxqNVE3HUWrjUC
	 sG5mT1LS9kPeHjoriPnC6Oc65MIggM9OYPg41cZ4Hcs6C3y3aWyWmN5rmUKjSuAZ+f
	 UAfWzkMdPsf4a9EaPlgsET/5A3gVp+84V7vTmRTuzlrq5FPwTNk1MljFsrPb1Hohbb
	 PIFUSRoYHrszg==
Date: Wed, 5 Feb 2025 13:34:55 +0000
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
Subject: Re: [PATCH net-next v4 1/8] netconsole: consolidate send buffers
 into netconsole_target struct
Message-ID: <20250205133455.GD554665@kernel.org>
References: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
 <20250204-netcon_cpu-v4-1-9480266ef556@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-netcon_cpu-v4-1-9480266ef556@debian.org>

On Tue, Feb 04, 2025 at 03:35:09AM -0800, Breno Leitao wrote:
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
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Breno,

Unfortunately this series did not apply to net-next cleanly,
which trips up the Netdev CI. Could you rebase and repost?

Also, one minor nit below.

> ---
>  drivers/net/netconsole.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..c1ad54d99438dbd14e8288d39ad6bcc6f8ff5ad1 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -123,6 +123,7 @@ struct netconsole_target_stats  {
>   *		remote_ip	(read-write)
>   *		local_mac	(read-only)
>   *		remote_mac	(read-write)
> + * @buf		The buffer used to send the full msg to the network stack
>   */

Tooling seems to want this to be "@buf:" rather than "@buf".

Flagged by ./scripts/kernel-doc -none, and W=1 builds.

...

-- 
pw-bot: cr

