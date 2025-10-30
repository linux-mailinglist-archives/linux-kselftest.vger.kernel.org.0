Return-Path: <linux-kselftest+bounces-44423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FECC20F5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2EF4642D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7137B3655D4;
	Thu, 30 Oct 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9fDkfRa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488853655CF;
	Thu, 30 Oct 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838488; cv=none; b=pylXX9DAM2r85WkkJV2u8P6v24jf8sbxUyAhEdFDm6bZxQoHPZ603bOMkie00nUj9FnUNC5onQ/TjamPzTeybTWNKwuvIU6LOTS1W5h+Jru5JF/dghc7OuwDf0TlKVMBA8n3ML72jSGUX5cgqMj5a4ChcOYJxi8aC629tlnK9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838488; c=relaxed/simple;
	bh=0cI5L+2GoYgkgOTgvSKGNPMHZMHPezyi0/RCkUUrMvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USqr1xQepLqv0xRnTQGxgns2fF6azYOE9fDnQ5ewnWxjUrQI2bcSv+fo4NVw0rKZosuwjIIflzcsw/JvBH5AewRegrJRgHwYdb4Y3VK3kBBg3AxuvZuZI+7AkhuKnzZkqXn5/U4K+1judIaRThi6OyQojhmqcmMcIO3aTl0/JSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9fDkfRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065E6C113D0;
	Thu, 30 Oct 2025 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761838487;
	bh=0cI5L+2GoYgkgOTgvSKGNPMHZMHPezyi0/RCkUUrMvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m9fDkfRaNMJ7A0XCkjp6LZEMhnz+MmFhlftqSt0xcTJjIqo/rnsB+LUmC3/YkyEbP
	 bhDRvvcITsJXszBPKD22+92IRNaNpI82Sh1LHYtuWNZtFgMQ0+/n9XVovXVzob4GK2
	 UFJ2ZulPvlD/n3iWCIl/cmOJ4dWIxYOk4dq5biqSAFIrLFxrkguMn7YUPQiL8PBmuY
	 sOxmI07SCILIS04ISQSq8PWU2T76LXoMoWv6Ym1YwQoiSI9OL59EnOM+BRDOhsymwa
	 bh6+1QTaaI3HAJu2mGZznjqXPOkxEkORfhfQSsG48RBToJrnsBrzzxYSMbKk+0Em1e
	 P3KGtIozugWEQ==
Date: Thu, 30 Oct 2025 08:34:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jan Stancek
 <jstancek@redhat.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>, Petr
 Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <20251030083446.16b8cefb@kernel.org>
In-Reply-To: <aQMHJlwcchqtoAa7@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
	<20251029082245.128675-3-liuhangbin@gmail.com>
	<20251029163742.3d96c18d@kernel.org>
	<aQMHJlwcchqtoAa7@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 06:35:18 +0000 Hangbin Liu wrote:
> > This will be annoying For C / C++, and you didn't set the max len 
> > so I think we'll also have to malloc each time. Do we not support
> > display-hint for scalars?  
> 
> Ah, I didn't notice this. Should we convert all the
> 
>  type: binary
>  display-hint: ipv4
> 
> to
> 
>  type: u32
>  byte-order: big-endian
>  display-hint: ipv4

I think we should try. Technically it may change some kernel policies,
but without min/max-like checks the byte-order should be a nop for the
policy.

