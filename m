Return-Path: <linux-kselftest+bounces-6388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2B87E989
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 13:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6891F21848
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB7531A76;
	Mon, 18 Mar 2024 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAqzdd6R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32642210EC;
	Mon, 18 Mar 2024 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766061; cv=none; b=lkAtwHyzSORuMpMa05Xfu6yJPOh6rXlYyK3xDl/+zQPXMq/8GOLmkHJJoTpW2AS3RTjPAyogRDcmkxGnoK10cJECu3h+LT28WfL+l5c2o1Bv72l5/xxKoPPATs4lyN3clQbIy2IE/oq8Xo/pMe9yYgySK8nLiGTyQitYIorLkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766061; c=relaxed/simple;
	bh=IAavgjwG9/Sp67iqayo+f0gCAIYZtO5K2WA3YjasHuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Io2+2bcza3En+1mh24UcT4sco0MJ/4KcnPMsRKaUTzjdniwZYsU1Bu3k5afFC2GjQuJ2xpJsW0WGOv7Sq0NGHuy/utAyY5Vf5i3CWlApPNnEroPlz+ow3LmlYnJcFtyoeChF3jtFK2BK2LwoArv72MVSkJCzC7RlHMQ3zkkyWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAqzdd6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1C0C433F1;
	Mon, 18 Mar 2024 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710766060;
	bh=IAavgjwG9/Sp67iqayo+f0gCAIYZtO5K2WA3YjasHuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAqzdd6R/vU2Nv0dkmdQywWtGgulP98Rw/ZEjYI+MfsUCh7OM9bqiaAzvpkthK7Sy
	 h7brfiOiogtbnOTH7nmHqE2VVp2o6sjUTv4T1IMfnmpCLuT1efoRaOmUD2jR9beT22
	 CAUJAJZ7Epbi6ab17jyTL9V3N8e6BxI57L9D6XiHkhDvWkgqrQPjzf/gvrONNG5VRa
	 jvtpiXsa5oh27fqEbaNDgWOJthsdUsbYuHN3sJ93ql+s3tnOv/s9jIyOx8++Z/11+8
	 XjzQbYoNwizZQ20MST827W/iodqoUkBhzo7fIQ+8YjLxkaeMcvRYEsrQwxSYOoxIJ2
	 Dr8Ji/lSHg6Ww==
Date: Mon, 18 Mar 2024 08:47:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, martineau@kernel.org,
	davem@davemloft.net, edumazet@google.com, shuah@kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 14/23] selftests: mptcp: explicitly trigger
 the listener diag code-path
Message-ID: <Zfg36tcGXUsZnJCh@sashalap>
References: <20240311151217.317068-1-sashal@kernel.org>
 <20240311151217.317068-14-sashal@kernel.org>
 <afd248db-921f-4067-b917-a7ea3e807816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afd248db-921f-4067-b917-a7ea3e807816@kernel.org>

On Mon, Mar 11, 2024 at 04:28:01PM +0100, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 11/03/2024 16:11, Sasha Levin wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> [ Upstream commit b4b51d36bbaa3ddb93b3e1ca3a1ef0aa629d6521 ]
>
>Thank you for having backported this patch to v6.7 and v6.6 versions.
>But it looks like it depends on commit 9369777c2939 ("selftests: mptcp:
>add mptcp_lib_wait_local_port_listen") which is not in these versions.
>
>Because CIs will soon use the kselftests from the new v6.8, I think it
>is better to drop this patch from v6.7 and v6.6 versions.
>
>Cheers,
>Matt

I'll drop it, thanks.

-- 
Thanks,
Sasha

