Return-Path: <linux-kselftest+bounces-11155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2848FA6DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 02:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A02F1F237B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C41811;
	Tue,  4 Jun 2024 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7I6Xfup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94098622;
	Tue,  4 Jun 2024 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717460109; cv=none; b=F7lPW6YM62XSNYCwiBf60LqpD8IA3jp0mm23DFESNDEn8HvQxvN2DboMpcOXtagSqmgpORHRreeq8fSQL37oTDxWbCOQFC1RGsEornSJ2cEpKnbrKn51t1AD97YtjCcX0Zn4xoXBNV1pMhIimMKzu+mYeNlhDkVGjoSLRhxcy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717460109; c=relaxed/simple;
	bh=3pjvfGdcJwmqkuaIPFqlBnicTRQYalvmjRMwHiifioM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQFsg1L2VWFPjoO3dqiGbDVyI2iNYk4e+rERS2O85MmfWwXyoJRLwguK6mpwcuh9uPoB7DyVLePtXMC+Vu9DS1mvVy6iLNY9wdfvyDWGdWyNgYI9Re4GmYwJ/5pIlxn5Lm896bMFwOMBO28BHQz8KkZaCu/KKMewVXJWwfkUjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7I6Xfup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35F1C2BD10;
	Tue,  4 Jun 2024 00:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717460109;
	bh=3pjvfGdcJwmqkuaIPFqlBnicTRQYalvmjRMwHiifioM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f7I6Xfuph3hbzicFUXWOqzQkePA+YDQ4TGaek1pwLmdUpapH0cHkPS5AspVBmO/nG
	 Inbg4sPcsFsxrNav9S5uk40Rj53dxmjoTig5za8kfb8F9IukGizBqeYmakLslzva5n
	 B4Q5KYQ39Eh21xy0mI6Av3nPKYckVUnIBJCXqfvTkkg5asm+xu0zSJEgNL2t0cIr6K
	 ojz5pAAOsEAZnO3aTdAmInt7mNhd+ymSRKxXP1VO+qXJ9ixeZH32AYYAMM7cEWiKxk
	 FAbj+6vbMcHZrbOLhAZcE/QLShDb4AgFCdTWDl9hw8Lu8QxQNOxRtq2oJysdu5k6qE
	 yG45bziBoc4ug==
Date: Mon, 3 Jun 2024 17:15:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH net-next 1/2] selftests: openvswitch: fix action
 formatting
Message-ID: <20240603171507.2bd5e904@kernel.org>
In-Reply-To: <f7ta5k126oc.fsf@redhat.com>
References: <20240603183121.2305013-1-amorenoz@redhat.com>
	<f7ta5k126oc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Jun 2024 15:00:03 -0400 Aaron Conole wrote:
> I agree, this is an issue.  BUT I think it might be better to just
> filter by field type up front.  See:
> 
> https://github.com/apconole/linux-next-work/commit/7262107de7170d44b6dbf6c5ea6f7e6c0bb71d36#diff-3e72e7405c6bb4e9842bed5f63883ca930387086bb40d4034e92ed83a5decb4bR441
> 
> That version I think ends up being much easier to follow.  If you want
> to take it for your series, feel free.  If you disagree, maybe there's
> something I'm not considering about it.
> 
> NOTE that version is just a bunch of independent changes that are
> squashed together.  I have a cleaner version.
> 
> I can also bundle up the series I have so far and submit, but I didn't
> want to do that until I got all the pmtu.sh support working.  Maybe it
> makes sense to send it now though.  Simon, Jakub - wdyt?

I'd say - hold onto the changes until pmtu.sh works, unless there's
*any* reason for a particular patch to go in early, eg:
 - patch fixes existing bug
 - someone else needs a patch
 - ...
 - a patch which falls under some of the criteria above depends 
   on the patch

