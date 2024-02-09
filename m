Return-Path: <linux-kselftest+bounces-4380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE2484EF36
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 04:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6C11F2641F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D63FC8;
	Fri,  9 Feb 2024 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVr6/dX6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B104A33;
	Fri,  9 Feb 2024 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448226; cv=none; b=Vdt4ymgBnOsLIqfU92NWTuySlYJsE6+bYsclJbHSO/VuWfnEigXEV7ycJKp4K09BVblFC4PtDy+ZBGWNkb9Q8NwV58M7ehYOz2MNyq154J16zdnC5e8082bBDo75tsa+6rhA3SvmZiu1SVegd+UMxpJ64qoyS2sPaLeIMad0yUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448226; c=relaxed/simple;
	bh=Cs4mdukg4pg89OUG0OzgtWbbg6RpGW845x+lhFVlMPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IQdlmsMuGqL2HAWvUMU+emkGNXGo8XOVk9zENsSKykiFa9/4urjZ4KuDGtPvc+Z6QqhZUp6M8mNhdWjUOr0fCvPqZvjWwL5XKb1SfWKsZHips4vOULdNKR/JVZbCxC3ClzGQBkhGov/jbtkP3gYG6EY28JvCYx2qayJgHxjpPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVr6/dX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E459C43390;
	Fri,  9 Feb 2024 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448226;
	bh=Cs4mdukg4pg89OUG0OzgtWbbg6RpGW845x+lhFVlMPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BVr6/dX6eBgkPPNq7KU+6dHDUnB+iRplsjnqSUOvNdx2eIO5z/cMct6ldERC0NOk4
	 ogsTfE0614/uTCStZdWwbyWiflibYXPCw1XXwjX/Wbn7SQxaRMx3neUWqDExcP2s5x
	 Bz6VzrCGhj4W/C8oaWyq1yV40WlUbINENsOLncr6Bz5tRO1mMxgVa75q4rwO1My3fa
	 33ZqKRclYYlTXsRpvVUktwH1zCI1/lQUqgZoQCwhV712YL039OKxXD9N6HYTUbIIEJ
	 RAJMBmPFvv5wrJzZ/0NEnwiXMYhT+X1pc1R0SW/StK/xyvaBY7dmij3bYtpz86ql5L
	 AlADY4uUwVxbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2C90C395F1;
	Fri,  9 Feb 2024 03:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: add more missing kernel config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744822598.23533.10537868285259056914.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:10:25 +0000
References: <38d3ca7f909736c1aef56e6244d67c82a9bba6ff.1707326987.git.pabeni@redhat.com>
In-Reply-To: <38d3ca7f909736c1aef56e6244d67c82a9bba6ff.1707326987.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Feb 2024 18:31:10 +0100 you wrote:
> The reuseport_addr_any.sh is currently skipping DCCP tests and
> pmtu.sh is skipping all the FOU/GUE related cases: add the missing
> options.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note that this does not include the - still missing - OVS-related
> option and pmtu.sh is will keep skipping such cases. Such tests
> will still fail in the virtme environment even with the relevant
> kernel options enabled, as they have an hard to solve dependency
> on systemd/dbus.
> The longer term plan is to move such test cases in the openvswitch
> directory. One short term option to avoid skips in selftests results
> while retaining the potential code coverage would be making the ovs
> tests disabled by default but reachable via pmtu.sh command line
> arguments.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: add more missing kernel config
    https://git.kernel.org/netdev/net/c/02d9009f4e8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



