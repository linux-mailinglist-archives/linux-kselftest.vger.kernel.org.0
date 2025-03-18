Return-Path: <linux-kselftest+bounces-29371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EEA67AD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B95424310
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89F20FA84;
	Tue, 18 Mar 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1zDWJrf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B5157E99;
	Tue, 18 Mar 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318653; cv=none; b=Rz+iSDMS5lUdO6+On30zly3bsEZFZ+mI4lemIZ4AFKvRuxW+R+M5oZty6bBpNnfukY0wmWtATplZyEFTqoRpvtP1WfD61cRP/8IMd2JwuSr0Vd1xCeB6JUKxEIUXPh2ZSugItz9L1ER2lmATFYcnSVD4MO2jEDlOhCn0ovcL7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318653; c=relaxed/simple;
	bh=+R1dtj/q4bf7kut34dnT0UeoHmKyy9KwuCYj/R+J5Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ittVzjBWT7FBASapf/VieY++XE4S0x/PJz5cypXT6gMkQGGeqJWVDYPH2/+SipYDUIi8d1+NLD7ew4flOYI4PCACo5vYmVvvTKALqZfRHGIq4afPPJqg88J6qBs3LwCTe4opWTNzQlQoc7XYnWy+p9+hcMKcmJQPo+K1zL90BKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1zDWJrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E0BC4CEDD;
	Tue, 18 Mar 2025 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318653;
	bh=+R1dtj/q4bf7kut34dnT0UeoHmKyy9KwuCYj/R+J5Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1zDWJrfYwCMOjE9P/bu9bbZA9psQl8U/db/FzZ1/GUJ4Qnhn1Fak/FF0t/RNPWUM
	 0HaRPgAbupj7c8xB4CXLkHUW8LjnwgKOT9waXYSZ1T3PAAYZE8Uctslz7dNflnR3rU
	 sfpNU8+UrA2lLGYqT0jxtIRj/aaY5QBHoIWCdq9l8DDmRHtOkh0pkBIshixSLIy7gM
	 U6CL9SQVJHkA0LRaGXCodkgWlUjuODvoRm4ngnIA23Y6p4ZR7ijiWYRpN9rpLZnVAt
	 Nh0QAtpBGgRPQRZQ4eSVcBeraAKmjgevrEyPt7HBKWZH9WaGoWjcYkWD6kNLdMsX/K
	 yeTDVpAReYFhA==
Date: Tue, 18 Mar 2025 17:24:08 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] mptcp: sysctl: set path manager by name
Message-ID: <20250318172408.GM688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-8-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-8-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:57AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Similar to net.mptcp.scheduler, a new net.mptcp.path_manager sysctl knob
> is added to determine which path manager will be used by each newly
> created MPTCP socket by setting the name of it.
> 
> Dealing with an explicit name is easier than with a number, especially
> when more PMs will be introduced.
> 
> This sysctl knob makes the old one "pm_type" deprecated.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


