Return-Path: <linux-kselftest+bounces-22127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A105B9CFAC6
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 00:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37D5AB27A7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 22:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C991917EE;
	Fri, 15 Nov 2024 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCFkBbW4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283014F9D9;
	Fri, 15 Nov 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711076; cv=none; b=dJQTwY8wj9sBvF2PoC0Yze5eMY/wlMFElkyeLYKL0+549Oj/BKLgMvbf979LSxZ6w2Ajken3m/3CM5pACuL9DhQHHkTjureBSBFSHu0p0zubyeG5fmAf96Cqz2sqF+IT9Biqu8IO4XnPeJ10KXLAfYGFkSUWsQ5Yi6SuK8oS5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711076; c=relaxed/simple;
	bh=Jht/2wZpROGtsN14r3YcP1e9epsnJMyCctqGZl0f40s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLtQRV7eRGaDc6Q4ZchczF7aFL3vnDIwxQrg7XW9FKVF5s3AM9Kn5+MwF/VXZ/R+/PapectXGRLCbRUkv5gb6krUEDZLyY1CLEv8J9oAWpVUvODOXSKNLCz46ptB+5eJm7p1xYSt8mHFLVAjGTRmFyrnTnhY4H3zYHT/Lh2PE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCFkBbW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14001C4CECF;
	Fri, 15 Nov 2024 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731711075;
	bh=Jht/2wZpROGtsN14r3YcP1e9epsnJMyCctqGZl0f40s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PCFkBbW4KMxzIiNilnx1D+38dZUl9xMatxEwTnxieesvyQaDMebt0p8A1S5AD0XwX
	 6xS7Dsp8BRDyGdbMKli/DgLMzyCJ5yOP8HIShiKmA/wQX+CRKDIPrUvlXP8GjrKemD
	 nXAL97JH746uehmvPZsiFshb860GinB8Ny7ro1xGR1ym232+5LwAvZIVbxRl7lEx5X
	 F0ca/qbe42fil5LCSfhCYj/pMtLSFuJDb994762noA21eA+CF8rSv/k0dZ98CwSIAx
	 f3cT5ZJnrmxQNrNoCLiykc1+bUGUwRWSfmKJu9KZHtFhQlDvMFmvUWF5361B93lzTN
	 TKguxkPtB2TSQ==
Message-ID: <80785a22-26de-4466-af44-5aee85a056fe@kernel.org>
Date: Fri, 15 Nov 2024 14:51:14 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net/ipv6: delete temporary address if mngtmpaddr
 is removed or un-mngtmpaddr
Content-Language: en-US
To: Sam Edwards <cfsworks@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Xiao Ma <xiaom@google.com>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
 <20241113125152.752778-2-liuhangbin@gmail.com>
 <CAH5Ym4jjVFofG5J7QW=EsD00siDXtNWKt4ZDNbbUmP+Y4Jb-DQ@mail.gmail.com>
 <ZzWo5fJcraaDDLm_@fedora>
 <CAH5Ym4hcguhXvJvVuANns7Q9VTOWR-SxHSdD55rR5BWhWeg2Ow@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAH5Ym4hcguhXvJvVuANns7Q9VTOWR-SxHSdD55rR5BWhWeg2Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/15/24 1:46 PM, Sam Edwards wrote:
> Hi Hangbin,
> 
> It took me a while to grasp but the problem seems to be a confusion
> about what it means to set a temporary's lifetimes to 0/0:
> 1) "The mngtmpaddrs has gone away; this temporary is slated for
> deletion by addrconf_verify_rtnl()"
> 2) "This temporary address itself shall no longer be used, regenerate
> it immediately."
> 
> The existing behavior makes sense for the #2 case, but not for the #1
> case. It seems sensible to me to keep the #2 behavior as-is, because
> userspace might be setting a 0/0 lifetime to forcibly rotate the
> temporary.
> 
> So it sounds like (at least) one of three fixes is in order:
> a) Make ipv6_create_tempaddr() verify that the `ifp` is (still)
> alive+mngtmpaddrs, returning with an error code if not.
> b) Look at the 3 callsites for ipv6_create_tempaddr() and add the
> above verifications before calling.
> c) Add a function that calls ipv6_del_addr(temp) for every temporary
> with a specified ifpub, and use it instead of manage_tempaddrs(..., 0,
> 0, false, ...) when deleting/unflagging a mngtmpaddrs.
> 
> Personally I like option C the best. What are your thoughts?
> 
> Cheers,

Off the top of my head regarding recent changes, please include Maciej:

commit 69172f0bcb6a09110c5d2a6d792627f5095a9018
Author: Maciej Żenczykowski <maze@google.com>
Date:   Thu Jul 20 09:00:22 2023 -0700

    ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new
temporary address



and Alex in discussions around changes to temp addresses

commit f4bcbf360ac8dc424dc4d2b384b528e69b6f34d9
Author: Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue Feb 13 23:26:32 2024 -0700

    net: ipv6/addrconf: clamp preferred_lft to the minimum required

