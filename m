Return-Path: <linux-kselftest+bounces-21024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD99B5724
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94BC2848E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 23:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E69E20B213;
	Tue, 29 Oct 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6bcsdkU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFCE20B211;
	Tue, 29 Oct 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245409; cv=none; b=Mcisgh6Y7IKVz75EpEBX/AEywWEPXVa27Ln8h8Nh3YsaJk6ZH8eX9rbL359SkN8TessVx/AhT8BYJYrSaw3HCEMKrbQUTWC9cVnXeJUkGjRi76ikgVFa2PqWZQQvaP1JwEpg5ekL7bEkvXfIscthl6YygrbNpkO1R7Qgfl2Wcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245409; c=relaxed/simple;
	bh=yj/5UmiqwvAxDkH4orkU0wgvctaBXLazPRwxdo1vTwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noHqsVp7N/Kdq+54L669tqavTra3ZVbhMfMXtcLw6oAZRwb7Oe7JuxgkhgvCxBfo4kISVDjS0NFZRnFpF3gLW4THx9eAQWyJRt2YkoInIkIUy7p+pSg9bzyPwwFUUuv+irb/qSX6zQ6e0n1PMmm751Yn+Od+GY2ja/3oPI5aW8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6bcsdkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85253C4CECD;
	Tue, 29 Oct 2024 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245408;
	bh=yj/5UmiqwvAxDkH4orkU0wgvctaBXLazPRwxdo1vTwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P6bcsdkUNCMN7TdBmCcfZ5Rep9OEeauHGojTtU4Gs8imuHpFbjgSygbOQsoogf6Y1
	 senDiwOiaZxmgHsFhHpNOC/pfWataOoTKmQSWqwULEARJyzcv6btiDH/Mkjs9UgVt+
	 kGynAvTYEgXFQxPFa7vv2OQ4Pgj7z1A4USkhb9hDj5ygYN2nt1cebf4wXbhY5XMRwK
	 Sv7f0E/531Rng65b/gapbwzm7z7gEnAW9exPfGG17as35WRR/tog0PpHZKxdInUNM9
	 LSsXpi0n77iTTeh5EnOoAzZNYbFXqY4FXZ4dnv5i7X5Dfz7pMn405L719Y9I/Zc3W4
	 ctDgICBKdMr0w==
Date: Tue, 29 Oct 2024 16:43:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH for-next 7/7] selftests/net: Fix ./ns-XXXXXX not cleanup
Message-ID: <20241029164327.7cd4ca29@kernel.org>
In-Reply-To: <20241029164306.6122b372@kernel.org>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
	<20241025014010.6533-7-lizhijian@fujitsu.com>
	<20241029164306.6122b372@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 16:43:06 -0700 Jakub Kicinski wrote:
> Similarly to patch 6 

I meant patch 4, not patch 6

