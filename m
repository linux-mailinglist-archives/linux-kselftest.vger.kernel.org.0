Return-Path: <linux-kselftest+bounces-15282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407F4950FD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 00:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12A0B21921
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120D51A7054;
	Tue, 13 Aug 2024 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIP4A0LL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCB370;
	Tue, 13 Aug 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588639; cv=none; b=sfdkEaTX3LVR0eDYXLrvhwd6ql0uTH4vZ4VnuxTzalTYh0Omc2IMHs7VBm+QzUXPISn2nEDLgUn1RyaOQur38BKDo100TRJCPRt9eERRkcQlYwWGrWut3SmEtPviIwANstoPrCuW4drRFuF+cgX3ygnfj44YHgApp4s1m3KKefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588639; c=relaxed/simple;
	bh=Y/+laaQg+oKh8plQS1ymsBYjx63OG8abaG/apzDV6o4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxIxszenBU6+/+w+Uy2/uWr50ERQYqe5vOENy511fJ7FAVatz5I2ZS7vKsCKHnh62GvILDgj404qJhPWmbhs8kuD6d7XzJ+osF+fhfpid0d70U+TgRKwYrc5p5lvkwLnFYW0MYvy+M7Bb5dqVKysPCSIblY9rxzjwg9G0ua6QPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIP4A0LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ED1C32782;
	Tue, 13 Aug 2024 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723588638;
	bh=Y/+laaQg+oKh8plQS1ymsBYjx63OG8abaG/apzDV6o4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gIP4A0LLX8gxYwmM6m+hA8aYCpS7Tlrr+9RAR4Q5z2wMlQWwZwS9DbeX+y4nLILLr
	 hv4Qy27N74EVPOd5YWP6ty7QDdR9BTXwbX3NC57Mug+ile/SGtnVkVSf1J/PY3DnZW
	 nlcu0cFFFG5rbTGHoVGRSUw9akm0dzaWRxYG0iMjujzj8nj6verEVes0QiLI7WMRQa
	 oRegBa6RJsDEoHRNYp2DAQfHbc2Q/BznN0r0qziM9EqCKYenWdR59IYFwPxxhe/w/I
	 8dZ2TIa1VgS1H7+eiVl5Yn7iRIABOnyhjkBAP0TvNHINVme2yG0BuigJpaHyL9VA25
	 nnr04qhi8OIhw==
Date: Tue, 13 Aug 2024 15:37:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, David Wei <dw@davidwei.uk>,
 Willem de Bruijn <willemb@google.com>, Petr Machata <petrm@nvidia.com>,
 linux-kernel@vger.kernel.org (open list), linux-kselftest@vger.kernel.org
 (open list:KERNEL SELFTEST FRAMEWORK)
Subject: Re: [PATCH net-next v2] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <20240813153716.76abf5ce@kernel.org>
In-Reply-To: <20240813183825.837091-1-leitao@debian.org>
References: <20240813183825.837091-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 11:38:16 -0700 Breno Leitao wrote:
> Adds a selftest that creates two virtual interfaces, assigns one to a
> new namespace, and assigns IP addresses to both.
> 
> It listens on the destination interface using socat and configures a
> dynamic target on netconsole, pointing to the destination IP address.
> 
> The test then checks if the message was received properly on the
> destination interface.

We're getting a:

SKIP: directory /sys/kernel/config/netconsole does not exist. Check if NETCONSOLE_DYNAMIC is enabled

https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/726381/4-netcons-basic-sh/stdout

Gotta extend tools/testing/selftests/drivers/net/config
-- 
pw-bot: cr 

