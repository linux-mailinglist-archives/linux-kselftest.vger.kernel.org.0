Return-Path: <linux-kselftest+bounces-35021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA01AD9F8C
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 21:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF75189662E
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904FD2E6103;
	Sat, 14 Jun 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIYRgYUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C31C4A20;
	Sat, 14 Jun 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749930711; cv=none; b=TfC+BS45aQtdc4XLYuSEuX0DZXALJI6MAGHGxCJPEqUn47DuOqusxwWOuIev8WzhUwgw31/nRex6XHkc47Xatm9fDmMK2ZiVwlt2IPRSKVqzpDp6TTNWf+M0ckPv/nAq8Sc9hQO+ksezTB3Re0WR3qDy/9TTtO0w4ZoHotxHhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749930711; c=relaxed/simple;
	bh=MpxMa/I6gxllKAnbeDXs7r46YEtoqLfQN5rcAbxlQBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXxlPXabPZ8Yf0I/9NH/qx+VVnJftGNr4h3ulnDTd4UnmsGahy0CiLiIzVYp8SZM7C7z2yRF6gHBjjkMRKZZsF0Z41H4Nkplwsfmfbs6snNIVH7gaDGO13Ag6oNUZTFfaY/oJS756vNNT+MMw11oVAEJkriiDQTXUntC94+dEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIYRgYUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3BEC4CEEB;
	Sat, 14 Jun 2025 19:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749930710;
	bh=MpxMa/I6gxllKAnbeDXs7r46YEtoqLfQN5rcAbxlQBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dIYRgYUKLnGks8Ce8K3QK252RYhr6anc4mPYD2mF+78g7ZQ48wZxHXS5QqXjwr5Ls
	 Qdex4soQPhvOr8rW/96ska5IgfKOgmLsLCI+5D1eT8WdSN0hx08MrTxCnCnVSB9UZ4
	 evJduORDbcERl810G3N7ZhVJ9s8D/Bsl8bPVBmZb+NNK2S0I3boTxvgzXag5TQ1x+1
	 I1MVmXTRd2LQd6w0NhqXQX5GN75VzVnIW3Ye0F9g0Hv8gjqxvf481HzikJpZnNj8Cf
	 P52ZFf1N3RB0Hy+tYPxpxaBXVnYBNOszG+UobE02d9o0UKDmJV006yC60X4hzwNeDX
	 qLju9b5amlxHA==
Date: Sat, 14 Jun 2025 12:51:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] netconsole: append msgid to sysdata
Message-ID: <20250614125149.55a8bc1f@kernel.org>
In-Reply-To: <20250612-netconsole-msgid-v2-3-d4c1abc84bac@gmail.com>
References: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
	<20250612-netconsole-msgid-v2-3-d4c1abc84bac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 13:02:16 -0700 Gustavo Luiz Duarte wrote:
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 3bf8777fcd01..baa9862c1bc3 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -155,6 +155,8 @@ struct netconsole_target {
>  	size_t			userdata_length;
>  	/* bit-wise with sysdata_feature bits */
>  	u32			sysdata_fields;
> +	/* protected by target_list_lock */
> +	u32			msgcounter;
>  #endif

kdoc is complaining that:

drivers/net/netconsole.c:167 struct member 'msgcounter' not described in 'netconsole_target'
-- 
pw-bot: cr

