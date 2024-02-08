Return-Path: <linux-kselftest+bounces-4344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670684DFB8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5902F1C27972
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2481D6F07F;
	Thu,  8 Feb 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR7TnUzt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13416E2D1;
	Thu,  8 Feb 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391791; cv=none; b=Q6K3eg3q+Uj9M5fv44+WaX8slZoeem7d8EEmAaShA8oWWfBifJNc8vWInujAhuX0FOkwpH0ZWG0QfYHZx1j4VLHdslPJ/QPFtVqaI5001F+bWCt8apyM5WGSfW6h0yoOgrUMUCk2S5hCe2bKaVBD/yKLToctwW9T+ZoRyKYltWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391791; c=relaxed/simple;
	bh=I3eCz/ZRTx5n7CETldr7dqc3sg5MstLNDuyaNn+FVYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti5h8ZNR644is8Xx/nRSA1T/CwFmpxFyO89Lx7vMO9p67gLYR7z/ulh1XV2RIUqSoLcKFaeOIw0OEsm9REKriurmbYaNrIkE3dVb7TBeCZstijovHpRyrOSlpUGtuzf6TnXIfKZpsauEQ4R+x2cbqpcWaQEybTZnQFQbHfgzTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR7TnUzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF06C433C7;
	Thu,  8 Feb 2024 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707391790;
	bh=I3eCz/ZRTx5n7CETldr7dqc3sg5MstLNDuyaNn+FVYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hR7TnUztZaaZ3JH373jHA1eLBU1F/x+1hxubO8OScSw2h6Zs5EeGRLfl8EQGJKWp9
	 X+fUi0XvlXKmvc4MOH+FYilxqMSFmvV+ZAd6pWcPKGtNC308iixrbsq2Nq2mfJVAYg
	 Q6FYS6Nw5nSIYwRqFA//x+1+n9MVinNMLre384qZkc6UloUCaQO8nJbiUJX+f6eEe3
	 E5QXez9Dg/eGxULzGIsddpyISPSZZP8Wjf2Qjp5KlYwBPN8VxB0pB1DXDK0PlfkPxb
	 z4mxYrZl/IVXaBlhSeBM7qTqsbCoYqn3rxSGQEzmqWkl/pQZ1qIZx5IEQM2nm90yCK
	 U9zAqpwyI/R7g==
Date: Thu, 8 Feb 2024 11:29:45 +0000
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Andy Zhou <azhou@ovn.org>
Subject: Re: [PATCH net v2 1/2] net: openvswitch: limit the number of
 recursions from action sets
Message-ID: <20240208112945.GG1435458@kernel.org>
References: <20240207132416.1488485-1-aconole@redhat.com>
 <20240207132416.1488485-2-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207132416.1488485-2-aconole@redhat.com>

On Wed, Feb 07, 2024 at 08:24:15AM -0500, Aaron Conole wrote:
> The ovs module allows for some actions to recursively contain an action
> list for complex scenarios, such as sampling, checking lengths, etc.
> When these actions are copied into the internal flow table, they are
> evaluated to validate that such actions make sense, and these calls
> happen recursively.
> 
> The ovs-vswitchd userspace won't emit more than 16 recursion levels
> deep.  However, the module has no such limit and will happily accept
> limits larger than 16 levels nested.  Prevent this by tracking the
> number of recursions happening and manually limiting it to 16 levels
> nested.
> 
> The initial implementation of the sample action would track this depth
> and prevent more than 3 levels of recursion, but this was removed to
> support the clone use case, rather than limited at the current userspace
> limit.
> 
> Fixes: 798c166173ff ("openvswitch: Optimize sample action for the clone use cases")
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
> v1->v2: Switch to tracking the stack depth by using a depth argument rather than
>         a per-cpu counter.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

