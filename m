Return-Path: <linux-kselftest+bounces-1767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF9B80FC0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A951F2104B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F1E18E;
	Wed, 13 Dec 2023 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9GbhBJh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5820E7;
	Wed, 13 Dec 2023 00:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FCBC433C7;
	Wed, 13 Dec 2023 00:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426352;
	bh=/Uqsa/rMn/XJk5I0oTDeaQtC4OU2ZOohqD0FVpsAGxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A9GbhBJhTMIv1SWJmdN6G1qNyu5bv2cKzXcblqq3VFGIx2DGMVe8xCp55YpCu+lrV
	 y0QLN8uWNGDX5ar86GhAVA97ZijH0bULtOKDJLZblL73GuTcZLb9sEkiwyOr/qb5qi
	 fptGRm2RxyYqoLH5KzVENLnJnfqgVwncXQvOjwtTWoUnlQmHJ5QnZlYTK0YLSbhO+c
	 tBw6NpwDbIXQ9JpnqvKa0f+9rhsAPJqfKmsmnMHdwa4kxyRsvA6vJ+tQPRply87mNW
	 h8tNJO6eL+7dP0xQsnXmDXeAI53u2zDd78ihjIsqYuLkcBe72Ar5Vm+iMQVeHPYyev
	 P0qYCZL/q1yVg==
Date: Tue, 12 Dec 2023 16:12:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
 linux-kselftest@vger.kernel.org, Po-Hsu Lin <po-hsu.lin@canonical.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>, Amit Cohen <amcohen@nvidia.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Roopa Prabhu
 <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next 06/13] selftests/net: fix grep checking for
 fib_nexthop_multiprefix
Message-ID: <20231212161230.56ac67e4@kernel.org>
In-Reply-To: <20231211100925.3249265-7-liuhangbin@gmail.com>
References: <20231211100925.3249265-1-liuhangbin@gmail.com>
	<20231211100925.3249265-7-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 18:09:18 +0800 Hangbin Liu wrote:
> --- 2001:db8:101::1 ping statistics ---

This --- will make git am cut off the rest of the patch :(
Could you indent it by one space and repost?
-- 
pw-bot: cr

