Return-Path: <linux-kselftest+bounces-27790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2016AA48503
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C6117878B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C671A841C;
	Thu, 27 Feb 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8RDKIiO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69308F40;
	Thu, 27 Feb 2025 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673305; cv=none; b=khhJE10ShYJlKjdu3E7uGMjC+HGL18tQkbsLbzc5v06kwkdKrNvNvdlVk+S4uWg6xCKxP8jzDTMQJaoPtajbEl79J+yRNaQTAIBAMRt9+tcQy1VWbEXoGubjyG8rdAg1ajqGyBn2QUfPqPki/ikNLhjGHAA46vFHGFUWVXVcRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673305; c=relaxed/simple;
	bh=sQlGGH25GF/utpCa8TrdW+aJYJDmWgb1GYvuLn4jCAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVn0mxhFfqFe7SiphAp3KAeDwyGDWkcujW/dfgF7G12mZavzjfcSk3sACj9kSRJIlkN7RfvkSidMtzfnI2uu4XTGx4guJKTaed/nHtUsDmvIr+B4k6luxK6HqjdXe7YqhqM/4HQFIJt3lDWvJb+W4IDQHFr3VXUAaaWrko5TSOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8RDKIiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560E8C4CEDD;
	Thu, 27 Feb 2025 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673303;
	bh=sQlGGH25GF/utpCa8TrdW+aJYJDmWgb1GYvuLn4jCAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j8RDKIiOyCSaYuBH82JphMKE2yS4OtBZVgpEa4tsNDfprl+ZiQ4F6hQ0colXqNNG5
	 aNnHt6cPHK4gffZEMubVgqAJwCq24wsNqo+oza643jKiTF2+k1b/jk1V4xrP5Zv7Ws
	 6cPWvWs59d/erzBLa5Z5wK/OL8akFXlGoGV5NCFwR8/KPRczckOzN0JSFL1zS0OXa8
	 +Wl6KCYZyYuWfPUAXrc+TDQHtxHq2PCbWbozMauTar4/6HpPelyIeTv/WB/lfkjp8I
	 /o70+GI34UHbh5p7pxKkYny8PDcEfU++Equ10mKQncWS7n0OIKf7PQjYA/YQV3L3eY
	 Vq6Gn/Cs9PIcg==
Date: Thu, 27 Feb 2025 08:21:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Xiao Liang
 <shaw.leon@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>, Andrew
 Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next v20 00/25] Introducing OpenVPN Data Channel
 Offload
Message-ID: <20250227082141.3513de3d@kernel.org>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 02:21:25 +0100 Antonio Quartulli wrote:
> After some time of struggle trying to fix all hidden bugs that Sabrina
> has found...here is v20!

> Please note that some patches were already reviewed/tested by a few
> people. These patches have retained the tags as they have hardly been
> touched.
> (Due to the amount of changes applied to the kselftest scripts, I dropped
> the Reviewed-by Shuah Khan tag on that specific patch)
> 
> The latest code can also be found at:
> 
> https://github.com/OpenVPN/ovpn-net-next

coccicheck has a new nitpick:

drivers/net/ovpn/netlink.c:439:11-59: WARNING avoid newline at end of message in NL_SET_ERR_MSG_FMT_MOD
-- 
pw-bot: cr

