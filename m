Return-Path: <linux-kselftest+bounces-37612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC7B0AD5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 03:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF871C26100
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 01:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B61185E7F;
	Sat, 19 Jul 2025 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3+3boCm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBE1487F6;
	Sat, 19 Jul 2025 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752888930; cv=none; b=W/XhuDhlkUjyH1zL8teRTTbXhQY5GvOfn2MMhRCVYQb55ZbpnbZY7meMnD1QuGt58i3hiZHI/O/hPhr4QHE3skafQm/RlSVGRJvSI0O8hGtTdIz8QfG5z52qUfhm9WS/MjrVhG7raclRJxacWyMZQKxQQSUUyFOFXJBM1iXVUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752888930; c=relaxed/simple;
	bh=Nvvd1IlDe+KIcuRyeOQh16dqqPrbvD1IBlN598V/r9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FH4AnncdJU/W8Uhek/pdHjZsqHK+Xh+jOaPgVfmC2pDyxaOUC16i2Beigj+2RgtI6tplk/ULTUCzZqX993L6cqV79Lzah+5W8GoYx0qLoUXIUyvcAgVy7qmqQSSZagSj4IpX8y51OSwmd/EPPMgW4Ja9ojE2K9Py2EVTaia6ZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3+3boCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185E1C4CEEB;
	Sat, 19 Jul 2025 01:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752888930;
	bh=Nvvd1IlDe+KIcuRyeOQh16dqqPrbvD1IBlN598V/r9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q3+3boCmssV/gkbSksi66+2m9x7gUAhUnPUINqyE1YjdJxmHOu8dGZrQ7kDbMIkbr
	 Zu8Up72zOp7882A+nVFImoVFdaDQkgMcRf7uQad26TsXZeFba3sb4mBJEalZcVLZOB
	 s2VMqpgjUA3eo2L2eWR+zchxUEgAq+xcTkPj9XIt2g/dXd52ScSk4opN5dV//J5zlN
	 RuWEpKYZkvC7rZvd5/Df56Yko3TasWnblPoRRWstt///P8NBm9FiGhEtMqmm/aA1n5
	 j8cWquvfzx+6TD9sqRQi/3IHzUaOqe4lqQsLoQcw0saLdLITUAiqGtmDmce8UA5nDs
	 Z0yALrTe/NRSw==
Date: Fri, 18 Jul 2025 18:35:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Christoph Paasch
 <cpaasch@openai.com>, Davide Caratti <dcaratti@redhat.com>, Florian
 Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
Message-ID: <20250718183529.062adb42@kernel.org>
In-Reply-To: <20250717183346.06576698@kernel.org>
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
	<20250715185308.2ad30691@kernel.org>
	<20250716072602.386a8963@kernel.org>
	<ae6d333a-f3b2-4463-b930-b4caf56b39f8@kernel.org>
	<20250716083632.72854bd5@kernel.org>
	<e46aadbf-51c6-4e09-bdaa-374698b406f3@kernel.org>
	<20250717074242.1ef5d441@kernel.org>
	<9175b633-b61f-4ca0-9023-c99dff4f53f0@kernel.org>
	<20250717183346.06576698@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 18:33:46 -0700 Jakub Kicinski wrote:
> On Fri, 18 Jul 2025 01:49:24 +0200 Matthieu Baerts wrote:
> > I see that you already marked the mptcp-connect-sh selftest as ignored,
> > so I guess we are not causing other troubles with the CI. (We could then
> > also apply this series here and ignore the new tests, but it is also
> > fine for me to wait.)  
> 
> If you're okay either way I'd rather wait. From our perspective the new
> tests would go straight into the ignore bucket.

Restoring now, given Paolo's fixes.

