Return-Path: <linux-kselftest+bounces-15069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E64494D00E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 14:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493BB1F2333D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D331194089;
	Fri,  9 Aug 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM7VoSNe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4819309C;
	Fri,  9 Aug 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206035; cv=none; b=Fs5kREJBCR7JSCqqDubaxPPvYdVEHWCFAmrSe1wtTKAuxx49ZsQ49+6oNWtNffv+GMAm3cC1TehQHamCtl+R5DeffGU+qVjQfJu2kyivA2Byuh7unQ1ha4xbwPobnXSWN02UZmxPJ+vsIVypnvyqrFkG+C21fLJPuvokWm2ebko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206035; c=relaxed/simple;
	bh=dfOvVXlaKNfGf0eYSd+F9fO3GVkdWOJRDP7fYXcTKLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ElfLfPck7087KPdFza1awK8c7wBWbCFGVqj3O48x87rLN2v3WrOr66RJKOg4207evZRrVtXFZjKb7NsnKlNmtm4ojd2BO33bP73FcOcjLej/wmfQnnDkFNqrbVeJUe323XUpbkKOz4hMzQpjO3QDLLPEFGw2HGclj9aZ0LBizig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM7VoSNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504ECC32782;
	Fri,  9 Aug 2024 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723206035;
	bh=dfOvVXlaKNfGf0eYSd+F9fO3GVkdWOJRDP7fYXcTKLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KM7VoSNeGMBgluuaCPcc8tSG6UXyK9Ysg+W7e8eeISg96Uk5DN7a/wlHegW7IrjuY
	 5M9fVqy5amUOOz1LCwNxoBq8gLuQEIrX3+u416Iq5M1k3xouE+7OwCT4XWvDTr4l5w
	 ZZ0kEbNzqumpBWaJWCAuWEv2fi5M1dyGhFp/WioVtYXYDgDC9aFR+25O5dqLU9yiTp
	 pG2Mc9EOge8tE6Zoypb6qb1r6IvbFssT2m144KnykC0sDPbWLReOd9UrNchfPhThzb
	 2VtHIDLLaUR6r3e3szo1s39y8fh2WhZLMn5nW8qH9fBkwFUQUUyaWgHSIVdAZ5EYQx
	 Bk2MpdPApnU8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E38382333D;
	Fri,  9 Aug 2024 12:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] selftests: rds selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172320603426.3771951.12747958365841454041.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 12:20:34 +0000
References: <20240806153809.282716-1-allison.henderson@oracle.com>
In-Reply-To: <20240806153809.282716-1-allison.henderson@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, oberpar@linux.ibm.com,
 chuck.lever@oracle.com, vegard.nossum@oracle.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  6 Aug 2024 08:38:06 -0700 you wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> Hi All,
> 
> This series is a new selftest that Vegard, Chuck and myself have been
> working on to provide some test coverage for rds.  I've modified the
> scripts to include the feedback from the last version, but let me know
> if there's anything missed.  Questions and comments appreciated.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] .gitignore: add .gcda files
    https://git.kernel.org/netdev/net-next/c/a0f6e5e9f1f8
  - [net-next,v2,2/3] net: rds: add option for GCOV profiling
    https://git.kernel.org/netdev/net-next/c/bc75dcc3cea7
  - [net-next,v2,3/3] selftests: rds: add testing infrastructure
    https://git.kernel.org/netdev/net-next/c/3ade6ce1255e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



