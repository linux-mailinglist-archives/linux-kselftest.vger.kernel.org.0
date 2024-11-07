Return-Path: <linux-kselftest+bounces-21620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964049C0AA4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20391B224F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D38215017;
	Thu,  7 Nov 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDZenKXU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1E212D2F;
	Thu,  7 Nov 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995185; cv=none; b=hbaUAgEtJ3oeXY2gCjZ4pMaHqNUiS+1UBWHzttY1pItjtiADCY38Zr5M3sRFuwQKQKdws42AQpRWadMpY584fvOBcKeH4y7xHmzTmzkfLfhzFD4vWwwDyTWtwdsPO5Y/o5UiaeIRk3Iu8uephlTteF/wkTL7ZvPOwyTQsLI7K3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995185; c=relaxed/simple;
	bh=XOKShilNEm9Nnm1tXX9CAaQcYToZT7HxAyXsjNfZlo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5Qx71Z+8Rnzv7/aZKNZJTyNIKFC2X0aRBawEWnuctTZ2eZ7BLAXTw3+85jkJZZsNQODTo4vox6aRiaWuxHmQw+ZT9itQ3expb4LO4nuKVrYX2VYxeOxv7AfUu5IkDo+TTDafp24YpjqXq4M0pbH/i8cs/w6XniDfNy/LXKKLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDZenKXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C2FC4CECC;
	Thu,  7 Nov 2024 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730995185;
	bh=XOKShilNEm9Nnm1tXX9CAaQcYToZT7HxAyXsjNfZlo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WDZenKXUeXr7gS0DDjWrAL0m8nrkJYxyirYLZExoi2+lwJ6jfjQI1KMCXKmKOXGoK
	 n8TEzDgP6Pd1rdz8q3CDKxEtLE+uy/qaU2F4cmbtpagz0Trd0NAFjC2o+06xztyF8D
	 xb/yud13fgIrCH8YhanFBYmUtAvSsSIgU2cwSP1m9GBb0OeIHNmEHYJlBed6uRYGBD
	 /ygFoevfgkLQbynA0jz3AC5rPk2F1BjBXCvwv0nOKOk/dCWkdsKo9uVNKaJrIihDHX
	 sDCn6ihE7vlP39laURtRKIdkmRejTPP8f6MFYhNMZhRb0V7bjQ242+rPZBpdujTp83
	 LhAnx6aveCqGg==
Date: Thu, 7 Nov 2024 07:59:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Donald
 Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next v2 5/8] net: ip_gre: Add netns_atomic module
 parameter
Message-ID: <20241107075943.78bb160c@kernel.org>
In-Reply-To: <CABAhCOS8WUqOsPCzQFcgeJbz-mkEV92OVXaH3E1tFe7=HRiuGg@mail.gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
	<20241107133004.7469-6-shaw.leon@gmail.com>
	<CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
	<CABAhCOS8WUqOsPCzQFcgeJbz-mkEV92OVXaH3E1tFe7=HRiuGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 22:11:24 +0800 Xiao Liang wrote:
> > Instead, add new rtnetlink attributes ?  
> 
> It is to control driver behavior at rtnl_ops registration time. I
> think rtnetlink
> attributes are too late for that, maybe? Can't think of a way other than
> module parameters or register separate ops. Any suggestions?

Step back from the implementation you have a little, forget that there
is a boolean in rtnl_link_ops. User makes a request to spawn an
interface, surely a flag inside that request can dictate how the netns
attrs are interpreted.

