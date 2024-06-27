Return-Path: <linux-kselftest+bounces-12888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4927691B26A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 01:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F8F1F2372D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 23:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A913E032;
	Thu, 27 Jun 2024 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iB/M+Vby"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FC1CA9F;
	Thu, 27 Jun 2024 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719529235; cv=none; b=WRqgJxzhyRHD+oiOpKA7zl6b8OXjXVgEN5EjSCou8cvEFPX9ZBZYbKxqt5hMIqBbYamQoJYTc/5DXt+fhztLx8VI4HwIxRxeHdUAwxC+9ykBVONz7WF4t46sdh5asFxHnP2ohYI42etvSiUCWo8h5U/gPrrRBwfb9MVzrO+VIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719529235; c=relaxed/simple;
	bh=CIO3N+TLnePbA2/TejlgJ3gpGMe8zDGVeHZgQHrVq7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ChjBZjMvWhz9mpL6vy3JmC0rwCYoBbscXyhkecUC5dAlaeE6E7Q/VwO/YhsjC8X5pEXW/t+W1je6D9re8clNcCA5gT434NXnj3XYZdPnUNWG8bXBXXyI2ya197Z2t6qIbcT2EixYZ9anIf+iLmfMnW8J5lxEHSCg/4MEnqe3YIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iB/M+Vby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41567C32786;
	Thu, 27 Jun 2024 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719529235;
	bh=CIO3N+TLnePbA2/TejlgJ3gpGMe8zDGVeHZgQHrVq7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iB/M+Vby4NoZa6eTHGVCNajOD5zqg8dxjfdG6v5M/i+KhcA77g3kDSoQWHc3Kq8Kx
	 IOx9Ed0iijSjR97z7w2bqYSvx4iJXcZ4EXd+EVx0OlJS6e54YiOYHa3lpajtdCvDuN
	 I1EG/+D/Yvkgb1lx8JlrDzieiz5W8WPp8/G3okvRqiMS6VXliO/SFjaIbq7IlMiJaR
	 BHfu9stTZT8cctdHTn5YDugC7iWkAhjOJZ41hgHheEoE7bXCHIGQQMEYDyq5qdTiF2
	 HSLZBWSSbOS59F3yu/3UsNtBQ0ck7AUUcqH+bJ7XOK5ZP5q2ea61htpEksyS0spTsI
	 aSS9I10vSiTqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2614FC43335;
	Thu, 27 Jun 2024 23:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/7] selftests: net: Switch pmtu.sh to use the
 internal ovs script.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171952923514.28606.15428721836548855074.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 23:00:35 +0000
References: <20240625172245.233874-1-aconole@redhat.com>
In-Reply-To: <20240625172245.233874-1-aconole@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 pshelar@ovn.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, sbrivio@redhat.com, amorenoz@redhat.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jun 2024 13:22:38 -0400 you wrote:
> Currently, if a user wants to run pmtu.sh and cover all the provided test
> cases, they need to install the Open vSwitch userspace utilities.  This
> dependency is difficult for users as well as CI environments, because the
> userspace build and setup may require lots of support and devel packages
> to be installed, system setup to be correct, and things like permissions
> and selinux policies to be properly configured.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/7] selftests: openvswitch: Support explicit tunnel port creation.
    https://git.kernel.org/netdev/net-next/c/f94ecbc92092
  - [net-next,v3,2/7] selftests: openvswitch: Refactor actions parsing.
    https://git.kernel.org/netdev/net-next/c/37de65a764ed
  - [net-next,v3,3/7] selftests: openvswitch: Add set() and set_masked() support.
    https://git.kernel.org/netdev/net-next/c/a4126f90a35f
  - [net-next,v3,4/7] selftests: openvswitch: Add support for tunnel() key.
    https://git.kernel.org/netdev/net-next/c/fefe3b7d6bec
  - [net-next,v3,5/7] selftests: openvswitch: Support implicit ipv6 arguments.
    https://git.kernel.org/netdev/net-next/c/51458e1084d0
  - [net-next,v3,6/7] selftests: net: Use the provided dpctl rather than the vswitchd for tests.
    https://git.kernel.org/netdev/net-next/c/b7ce46fc614d
  - [net-next,v3,7/7] selftests: net: add config for openvswitch
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



