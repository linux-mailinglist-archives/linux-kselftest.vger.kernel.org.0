Return-Path: <linux-kselftest+bounces-44984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C74C3BF65
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E25188AA26
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6B33DEC5;
	Thu,  6 Nov 2025 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="CBw/HXoy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECB303A03;
	Thu,  6 Nov 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441681; cv=none; b=DLJqWlMt/c8IPhdpT4TRz7TPDQwiPwQ/x/0+YajABiE0Knvf6kJOgYnWUHiBuiMfvkGCg5b+B2v7nsTDg8ODqZxrA554iHyeGK1GPIXUfHRFB2LHEyle6vwSBTdEUCSMnfZiD77VLolwZ3EisNYln13lDXOK3AWkRSgUhdnlh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441681; c=relaxed/simple;
	bh=xI2Y0QxaMnb5vKnd01YzkAPu7E6ufrZswKh6AEVF38s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQYA7/UHnmdA8kke42R65rnUK9ZO/92Arit2+NLJPmUCLWi7Zk13VgD/YzCKMIRbHKSne5OZRHmnLI9erB9wisCnuCN2I33SrgvqfqPAnPJXtALjug1rTjXpDf2VDkOD5CtOR3Iwd41rAF0/IvrX6oTws2UbI67WLnwa7PIKmyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=CBw/HXoy; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1762441676;
	bh=xI2Y0QxaMnb5vKnd01YzkAPu7E6ufrZswKh6AEVF38s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CBw/HXoyr0HWCPOl3hC8Oh/XaIWmhtLFjiYJZPhlLIw277zmZN2JQ8vykdDeWaH5z
	 kYLFYeBLiY3qAnQUIimGRZplbOU+XP2C6W9f1RiBE107TTqdJN3NxD/e1IAlGxymqj
	 YDYFI2kQfbx1N/72i4wh7sz0IhmYDxvQJUw9tOIAANu5sHuUcZHiYiIqmKMN3r2Ut1
	 Vjvr+VbkzQBhEBsOuUjl7qjot82ze/5DkIKLpz3EeqhZrj7m8I6yKftSjOb4MXVHvp
	 dAd5QvrF3aTjZ1c60plHabfRlopMAHuwjQ+bnTGdLPNiLW0UkWn+RlmgLXdrJhDab+
	 c2nxLvKKJNieQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 87AFD6000C;
	Thu,  6 Nov 2025 15:07:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id F075C200CEE;
	Thu, 06 Nov 2025 15:07:25 +0000 (UTC)
Message-ID: <f420e34d-40ff-43ce-8448-e7947d666dbf@fiberby.net>
Date: Thu, 6 Nov 2025 15:07:24 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
To: Jakub Kicinski <kuba@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jan Stancek <jstancek@redhat.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>,
 Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-3-liuhangbin@gmail.com>
 <20251029163742.3d96c18d@kernel.org> <aQnG8IYsY3oyYekf@fedora>
 <20251104164804.540a9b8d@kernel.org> <aQsDA7ufLlIwSf1h@fedora>
 <20251105161319.0591f96e@kernel.org> <aQwJLKka-_pBGq_g@fedora>
 <20251106064104.135b73de@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251106064104.135b73de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 2:41 PM, Jakub Kicinski wrote:
> On Thu, 6 Nov 2025 02:34:20 +0000 Hangbin Liu wrote:
>> but genetlink-c.yaml doesn't have "ipv4-or-v6". Do you know why?
> 
> Probably just wasn't used until now. It should be in all the schemas.
I couldn't find any other users, besides wireguard, as other families uses
the ATTRv4 / ATTRv6 style attributes.

In commit 1b255e1beabf I wrote:
> It only implements this display hint for genetlink-legacy, it
> can be added to other protocol variants if needed, but we don't
> want to encourage it's use.

