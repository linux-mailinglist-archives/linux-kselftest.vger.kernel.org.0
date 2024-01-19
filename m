Return-Path: <linux-kselftest+bounces-3256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D309A832FF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 21:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1BB285B46
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 20:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8E56B94;
	Fri, 19 Jan 2024 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBMK3ujj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548F57302;
	Fri, 19 Jan 2024 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697100; cv=none; b=V5QJZBUSfT8RMshRg1xolEzeVFgBe9es/H53jg2IKsWvUJIcrNw41JCpkc4P6ML8fO6yRj9mpTvgeLpyp4Rzzj3IJlsfnBmK/3glm6GdoRJ8vdiHMYNClBHD6ij5bVSW8uRaM6h5FjWmFq8lbv+QsmTzxPOzWgZcZGBAgNYZLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697100; c=relaxed/simple;
	bh=WytaNQ4rbcL0OZG7yk4gPfx23IYscfMYaPkwb0fV7pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHxv2xVoGmcJaM7iz+mijaHS3dKTY1oNRp1+QLOuAp3vH4DLiMMu0aHcbiCcGH6rsKEtQtqrgl1yM9eRu/NxxyWbAkFtYg8cpcG9nDrJzZ4SHMCjhUcbDtFWc250ecQAthA4YKxQnbbeG004ZjzqCD7In02nX1VQFysveaK5DI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBMK3ujj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85944C433F1;
	Fri, 19 Jan 2024 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705697099;
	bh=WytaNQ4rbcL0OZG7yk4gPfx23IYscfMYaPkwb0fV7pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBMK3ujjyy/kWli4bg/MX7oRWQeFjt0GWjhQ3YelQYR5T/OiDu/r58hzwR0LZcHLJ
	 iO6bJ6trjHhW4aMxN4mCYrxuYpiIJGebqsnUuaqam9vK5KfLxxEDglWtmRC5ezpW1t
	 pk4VGu66/atxkG5B0FtN8xXTeerRSYuJKTE4hBh20vyWf3S9EU5xm3s7MpnFK0wZXp
	 ZZJQsLilVJco5rC2ycsUqs7MIsS6S7mbR6tH8Do1huK+IXw62adJVZQJySQpUbsq/D
	 Rpy2AfLxCZUh6Bi69fOzLOiDM1ohFeDq7005mchc6NWkmanxpRb7gnh/F0HEeqqO4O
	 +FvyHxb4IwzTw==
Date: Fri, 19 Jan 2024 20:44:54 +0000
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/net: Clean-up double assignment
Message-ID: <20240119204454.GE105385@kernel.org>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118-tcp-ao-test-key-mgmt-v1-3-3583ca147113@arista.com>
 <20240119162525.GF89683@kernel.org>
 <945fb211-e224-4d81-aa12-9cfd5c066751@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945fb211-e224-4d81-aa12-9cfd5c066751@arista.com>

On Fri, Jan 19, 2024 at 06:37:46PM +0000, Dmitry Safonov wrote:
> Hi Simon,
> 
> On 1/19/24 16:25, Simon Horman wrote:
> > On Thu, Jan 18, 2024 at 02:51:36AM +0000, Dmitry Safonov wrote:
> >> Yeah, copy'n'paste typo.
> >>
> >> Fixes: 3c3ead555648 ("selftests/net: Add TCP-AO key-management test")
> >> Reported-by: Nassiri, Mohammad <mnassiri@ciena.com>
> >> Closes: https://lore.kernel.org/all/DM6PR04MB4202BC58A9FD5BDD24A16E8EC56F2@DM6PR04MB4202.namprd04.prod.outlook.com/
> >> Signed-off-by: Dmitry Safonov <dima@arista.com>
> >> ---
> > 
> > Hi Dmitry,
> > 
> > This seems more like a clean-up than a fix.
> 
> Do you mean to remove the tag or that you'd prefer it rather go
> to net-next?

Both :)

...

