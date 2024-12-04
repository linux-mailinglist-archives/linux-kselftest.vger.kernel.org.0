Return-Path: <linux-kselftest+bounces-22806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAEA9E31D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 04:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A712827E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 03:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F68137923;
	Wed,  4 Dec 2024 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdIBwFnU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10717BA1;
	Wed,  4 Dec 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281689; cv=none; b=qevlHPI6YwZ4FlCABCoolo4nPDbqKv4Kgjculg7y001jZLct9W/5t6b9lk/n6Msnfh8vBtyCfwU1PwwCk2gjagr20sv/fMm8z0/hq7GsXb8mBZeeDIt/tdAzsPxrp2yUIw6NU4Qm2Qken4Qn7ej4gTBA0LlLUzxp0p0xg7olZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281689; c=relaxed/simple;
	bh=6y0xVYlZb8Whi2VSOrF7nZQqniOjfk3f6lrYdyE7QkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsELQnhEMDtcaNwiEKFxaY75Tl6M/SF0XJ276zd+yi2uQZlGShcaMyx1CEpgZvcqXXrL62os0DtoMUmOebLEIyCzU40imNFv/A8oBdE9cCVKhRK262bxdDDObRNhgjo/4LvUmLH5vhA5iyCnF5ddaVgWTc0eEjeOjl+O+RWl6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdIBwFnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8305C4CEDC;
	Wed,  4 Dec 2024 03:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733281689;
	bh=6y0xVYlZb8Whi2VSOrF7nZQqniOjfk3f6lrYdyE7QkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jdIBwFnUkvcZ8+roXuyHAyUot7FBFVzk1uCcI8LiwnK+U/wwOloqLS30y3WRvoHKd
	 ZyWcO2wi4dQ5H0FioQVmoC5HPwpODRV1oAPUs9ropSANcNlvrdKCk2fpmfMBP+d6Xg
	 4D/s0D1i0kvlXB1FQIX4ZoVdb9FIv2tQgkxuv7iBrG0jJdWYqRN2SzXZZzD9RmP9xZ
	 7bqY3V3Nfdkssvvmi0Zh+Avazo6J3Bzds0ia0oTyP13cDO9/o5UIOlsY+mX3Vq0lJP
	 /c0jz9AooD4leb13z0rdQEOiG1wORsppFdRUQcytXaLC5mU+jCNxScSe43h8MSjezX
	 d4sC3mHMl2jUA==
Date: Tue, 3 Dec 2024 19:08:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v1 11/11] selftests: forwarding: Add a selftest
 for the new reserved_bits UAPI
Message-ID: <20241203190807.330fa9b6@kernel.org>
In-Reply-To: <e4591fe820d539e45a08eae96a69ac7353a2cc7c.1733235367.git.petrm@nvidia.com>
References: <cover.1733235367.git.petrm@nvidia.com>
	<e4591fe820d539e45a08eae96a69ac7353a2cc7c.1733235367.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 15:30:37 +0100 Petr Machata wrote:
>  .../net/forwarding/vxlan_reserved.sh          | 352 ++++++++++++++++++
>  1 file changed, 352 insertions(+)
>  create mode 100755 tools/testing/selftests/net/forwarding/vxlan_reserved.sh

Needs to be added to the Makefile, AFAICT
-- 
pw-bot: cr

