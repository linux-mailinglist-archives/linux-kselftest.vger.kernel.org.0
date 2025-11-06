Return-Path: <linux-kselftest+bounces-44999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD989C3C253
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92713B294B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556952BCF5D;
	Thu,  6 Nov 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxdYm7jM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F529D295;
	Thu,  6 Nov 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443646; cv=none; b=h9orXzjs4GIOLJcG5Ao+lFsbHMi+noiCnGa8JrsLyND7WHtDwJXohBFE7nJdfIsaLI7CuNTAdYD9YREi7BzUxC1+L6ZGtc5DF5g2xxzV46q4yL1rjm1NM8hSOu5wlA2tFIdH0kn3MglddppHXaD406BjjQcu9aiuzaLZXEMEZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443646; c=relaxed/simple;
	bh=Y6N7IJM2Oj/jWNX8r/1XtlsxcJDtxIZrO+3M+nZOCMg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eDeKJx2Jl88JUOGPSKxcWDywxtdlG9LPqM2Bk3aDN04+RO9vSNcYH8GO+jlx9ZTTytRTpyHA8ghMC3KHE3rnMvcaoNpAbAJ1U0oioEssdZ0dSeR5VwgDVK9fzYamablGSQH/gSV7SvkDHblR0DVdlMOGkk4+QWDoJ9rpqw/ZvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxdYm7jM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068FEC116C6;
	Thu,  6 Nov 2025 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762443646;
	bh=Y6N7IJM2Oj/jWNX8r/1XtlsxcJDtxIZrO+3M+nZOCMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kxdYm7jMdIXfmP4x6akdKEi8P7cGzhI0Xf05xXw5KTwGZq0JWdHKmUOOscFqwrsdJ
	 D6G8mO+akEHsVB9Ceg1ktwlwkWJxVxz/9ytbRqAJRgF7iS0NtN97HNyqIW4NH6lxeB
	 t+GsfAFKjmCk+cva2NTfnXAePAY/4HzkI24lJUaVuCt/+bvvjz8/251OgNL/pKAWPc
	 JnPQHfZeeDvt6biRTnrZYUAln+XYHcvGY0F3yo7JjeM9xkGs/0aFcP50hEsmkwL6K2
	 NMHwk3mSAVQ9OliVrTzYNAdUlVy5yYKpgjULamUSVctMkDWnDcl/VXucY13m2UcK7b
	 PxUuWWuqxQWWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9F39EF947;
	Thu,  6 Nov 2025 15:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests/vsock: avoid false-positives when
 checking dmesg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176244361874.255671.14441717354801229577.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 15:40:18 +0000
References: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
In-Reply-To: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: sgarzare@redhat.com, shuah@kernel.org, kuba@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bobbyeshleman@meta.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 05 Nov 2025 07:59:19 -0800 you wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Sometimes VMs will have some intermittent dmesg warnings that are
> unrelated to vsock. Change the dmesg parsing to filter on strings
> containing 'vsock' to avoid false positive failures that are unrelated
> to vsock. The downside is that it is possible for some vsock related
> warnings to not contain the substring 'vsock', so those will be missed.
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests/vsock: avoid false-positives when checking dmesg
    https://git.kernel.org/netdev/net/c/3534e03e0ec2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



