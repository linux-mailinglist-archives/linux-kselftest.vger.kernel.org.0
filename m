Return-Path: <linux-kselftest+bounces-41086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687F4B50A63
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 03:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D7AA7B92ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDA212F98;
	Wed, 10 Sep 2025 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shzysXrn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EFE212550;
	Wed, 10 Sep 2025 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468543; cv=none; b=NzVzobWQoZnTFlIg90kbGdSqoYnosp20HqGEAHFpI78w+aNcVu/dfM5mHLr7LbIVSCMXliOrn6WoESvLD+V++o5XFgJS58De4sfcjWw1WwlGM9mpXlTbvJz2Y04BcW7Rv3QuDEejy0RlCIHylIONxzMoOwKUvtUg4ehfSf7dvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468543; c=relaxed/simple;
	bh=VS/jCBz/twNOKbVyRFcGfLXUgMkqYIWxlqN5dl4ocB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMTzoJdNPyt6Ys5aB6t7yjXFmQpcF2/yJWFnbArBqsy0pl9gt54Q/n7qIkSm5+RP3mtbNYN0i/tySUTjMD5RRBbKAQhlPLi2VatR0BszxQzDD4sl0FLLp4cvfp64SYnwyi9Aj2pm6EzhTFHTmmwxSEiFYkhSdMXeujV6geFSjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shzysXrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3414FC4CEF4;
	Wed, 10 Sep 2025 01:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757468543;
	bh=VS/jCBz/twNOKbVyRFcGfLXUgMkqYIWxlqN5dl4ocB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=shzysXrnijyXfHLYpyT0/8kUeGhZc26sw18hS5wfolGD7r2BMPFf2kA526KbMNQjn
	 L3aea3U9+sdhRPlT9zNP07bZDIjNKOkIY4eiRPOXsrz9J65RQ1JQhfw72FtEIz75mt
	 aAYEUb+JOYhAQLYZjoE6uesT+bvtWlx63EX3x+D7vEjEBiGxjalpUMBVdV7Cb4NN3m
	 wZLrTGT2y9u1m4+D9Xx48/2RhRdgIWWtng/oGoKhENmAQe6G/DTKrxIWsBMasqb5cL
	 NIoROMFfc7PQ15JafpquIZF6gc+NoDFyWRhpQUPGyhp+nnQpfp9zwpEbiRuhB/fmnC
	 GddC+ao8h1CcA==
Date: Tue, 9 Sep 2025 18:42:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Davide Caratti
 <dcaratti@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] netlink: specs: mptcp: fix if-idx attribute
 type
Message-ID: <20250909184221.02b070b0@kernel.org>
In-Reply-To: <8f0bc70f-1657-4938-88e8-532ffb7c1a12@kernel.org>
References: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
	<20250908-net-mptcp-misc-fixes-6-17-rc5-v1-1-5f2168a66079@kernel.org>
	<m2plc0ui9z.fsf@gmail.com>
	<8f0bc70f-1657-4938-88e8-532ffb7c1a12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 11:08:46 +0200 Matthieu Baerts wrote:
> > Note that mptcp_pm_parse_entry has this, which should maybe be fixed at
> > the same time:
> > 
> > 	u32 val = nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);  
> 
> Good catch!

indeed!

> This should be fixed in a dedicated patch, because this fixes commit:
> ef0da3b8a2f1 ("mptcp: move address attribute into mptcp_addr_info"), a
> different commit than the one being fixed here.

int = u32 is unlikely to cause issues AFAIU. We recently applied 
a bunch of such fixes to net-next. I think this can also go to -next.

