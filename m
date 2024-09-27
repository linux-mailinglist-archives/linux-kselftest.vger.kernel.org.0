Return-Path: <linux-kselftest+bounces-18520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73355988C33
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 00:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F90B210C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463E318E762;
	Fri, 27 Sep 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWVG/epI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C816F909;
	Fri, 27 Sep 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474431; cv=none; b=N2WTJl0HgBt8I6ZIsnsqzbvDyLRuSB60h7HiRXTsNXB8d7wQHbBgSuyk8nCOY9ffJppSr23hxZURxS433GOWxIr2DdI1taAHQrOdPGIC5+//f8+gnyXtY0eUvB9EaR4QJHsjWg/HzBPw9+I4FuPjNpMyoZ3niE4a1/Pe1mDVjYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474431; c=relaxed/simple;
	bh=6bjl9SUvdODKRD66JzPVq0qtGWL9+duEpGhXj3N3DOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Li2q04Y7uBmOOWNVx4Vgfoa4oY+Nj2WfRsbAPUqA4TJYa82Gi77ddVdkkgQ95Tf052YlrYRbSDXnQVcBVqdQP8+G4OSoQ5uuJcIDq1vjpAWVUPE04wDKqrXkRvIvteH226A+O4UFDXkKflfrtX9t4lVXqnTcVf7VJ3bfYIrBZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWVG/epI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E622C4CEC4;
	Fri, 27 Sep 2024 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727474430;
	bh=6bjl9SUvdODKRD66JzPVq0qtGWL9+duEpGhXj3N3DOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SWVG/epIz3M8qZTj51UmupmsMUpJV/ZbJxyTaTAc32EJd408AObG5SN9UTZI+PIl/
	 qlZ9DCMONICS4Uw4/bukTJvN9moLG/1tAReA62DjIpie21sJrbIDDk9H9Zi8jfL1KJ
	 nTooUfDB/vHU8hNF6GRZJUMXj9a1CxJTkJmAX7m1lSHBSQlSHO/6VGAWuu1exACgQA
	 gmaTeXEM8juio/fnBHH3aKGR5plNg7Y6XsLSVU0ufGW6v14Jr0ujQL/9vCMhglFw46
	 jvGB8cdcXo8gdUiKVmsTBXJC3UPq5DhQ4NTGfs8/k0cs0JOj4H0t4PaCoKhFjweIkt
	 bxQEKWLk7AvTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7124D3809A80;
	Fri, 27 Sep 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/8] libbpf,
 selftests/bpf: Support cross-endian usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172747443327.2094989.6626660527565870189.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 22:00:33 +0000
References: <cover.1726475448.git.tony.ambardar@gmail.com>
In-Reply-To: <cover.1726475448.git.tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 iii@linux.ibm.com, qmo@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 16 Sep 2024 01:37:39 -0700 you wrote:
> Hello all,
> 
> This patch series targets a long-standing BPF usability issue - the lack
> of general cross-compilation support - by enabling cross-endian usage of
> libbpf and bpftool, as well as supporting cross-endian build targets for
> selftests/bpf.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/8] libbpf: Improve log message formatting
    https://git.kernel.org/bpf/bpf-next/c/86eb7eb4fbfc
  - [bpf-next,v6,2/8] libbpf: Fix header comment typos for BTF.ext
    https://git.kernel.org/bpf/bpf-next/c/4977b35bfd4b
  - [bpf-next,v6,3/8] libbpf: Fix output .symtab byte-order during linking
    https://git.kernel.org/bpf/bpf-next/c/a91c9b9697ff
  - [bpf-next,v6,4/8] libbpf: Support BTF.ext loading and output in either endianness
    https://git.kernel.org/bpf/bpf-next/c/14a76da84b18
  - [bpf-next,v6,5/8] libbpf: Support opening bpf objects of either endianness
    https://git.kernel.org/bpf/bpf-next/c/f9292d6570d5
  - [bpf-next,v6,6/8] libbpf: Support linking bpf objects of either endianness
    https://git.kernel.org/bpf/bpf-next/c/ab4184fd1bb8
  - [bpf-next,v6,7/8] libbpf: Support creating light skeleton of either endianness
    https://git.kernel.org/bpf/bpf-next/c/a1cb9abcfec4
  - [bpf-next,v6,8/8] selftests/bpf: Support cross-endian building
    https://git.kernel.org/bpf/bpf-next/c/4fd5a501e1d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



