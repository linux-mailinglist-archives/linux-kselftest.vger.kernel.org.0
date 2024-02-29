Return-Path: <linux-kselftest+bounces-5631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72D586C89A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 12:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C6D1C20F67
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745497CF0E;
	Thu, 29 Feb 2024 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="lvMq4XJf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45B7C0B0;
	Thu, 29 Feb 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207627; cv=none; b=TVxFTZWNxqxuqsCt3aIZC3ywWgvajobHLvkdvRdYNa0nDhTAMkRTD85zuHCjAIsiLK60YsK5nKTyzzw0xnG1aUlN5pMvO2aqrWZI8NqpHzSgOfYHjGXj3giIfx+Cd8jNSwrAhFSMn5Ski3iaVVo6jj42A0p/lyqWkFXBnJQUB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207627; c=relaxed/simple;
	bh=5nYYs6dSF95dhDnBprwAw/RpexnL1f/GeFnPwzj6Swk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/RTW4a2sMSw1hTNjR7++uG3pKfRYCja4yhsHMeChxqpUFVrQ/DMCpMZwlpqgNpnL2xllJMaJt/UbqnQNltTlnFmKS73vbuy/oNjYMT8/rLWv//7ywsmX+VowwhSbhReeNkit7HtuN5evqmbOGPNBepIL9uUP3gcXNb06mJFnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=lvMq4XJf; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66A0AFF802;
	Thu, 29 Feb 2024 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1709207622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaToIPDzXPunSHPMARHyvDeuyEwDr1/ZO+a/4iNtt4U=;
	b=lvMq4XJfkUm+hqYjnbZC8YybN52tAczd6MyvYXAmNWe1H+cCDijJ8iweHc9mMYwqRAp6pQ
	cVpAJS4mvNq9CbaMQClD5F+VPienkcvhhOr68EsSyt+KDmeO5ZPxnkSur7yYCQP1aVRo8J
	Hb5CtEBdDjHtmAJ9mMiY0X0ifSqaWRmnQl8ufw2zNFRSjGZ5INDE8810qo5lj1Jrb9Z2l2
	2j7+nMAAAp91ewPsVQmsQPnjyl9KYun0eDa0XPPh6lM+BBGUBjZLTcQJBdMeVqZMyZVe6R
	V7dFk74JbD1pcEUT1zA+IHVojyGc65UdG7/s7rJJ1/fHGE57DtHP/K64S9lr1A==
Message-ID: <b3fb89aa-56b4-4b3c-88f6-c6320bf5c489@gtucker.io>
Date: Thu, 29 Feb 2024 12:53:38 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
To: Mark Brown <broonie@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>,
 Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 gustavo.padovan@collabora.com, pawiecz@collabora.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228230725.GF1659@pendragon.ideasonboard.com>
 <0a5bf7d1-0a7e-4071-877a-a3d312d80084@gmail.com>
 <20240229093402.GA30889@pendragon.ideasonboard.com>
 <655f89fa-6ccb-4b54-adcd-69024b4a1e28@gmail.com>
 <20240229111919.GF30889@pendragon.ideasonboard.com>
 <a4fc23e1-5689-4f86-beb7-5b63a0d13359@sirena.org.uk>
Content-Language: en-GB
From: Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
In-Reply-To: <a4fc23e1-5689-4f86-beb7-5b63a0d13359@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io

On 29/02/2024 12:41, Mark Brown wrote:
> On Thu, Feb 29, 2024 at 01:19:19PM +0200, Laurent Pinchart wrote:
>> On Thu, Feb 29, 2024 at 01:10:16PM +0200, Nikolai Kondrashov wrote:
> 
>>> Of course. You're also welcome to join the #kernelci channel on libera.chat.
> 
>> Isn't that a bit pointless if it's no the main IM channel ?
> 
> It *was* the original channel and still gets some usage (mostly started
> by me admittedly since I've never joined slack for a bunch of reasons
> that make it hassle), IIRC the Slack was started because there were some
> interns who had trouble figuring out IRC and intermittent connectivity
> but people seem to have migrated.

In fact it was initially created for the members of the Linux
Foundation project only, which is why registration is moderated
for emails that don't have a domain linked to a member (BTW not
any Google account will just work e.g. @gmail.com is moderated,
only @google.com for Google employees isn't).

And yes IRC is the "least common denominator" chat platform.
Maybe having a bridge between the main Slack channel and IRC
would help.

Guillaume


