Return-Path: <linux-kselftest+bounces-13331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FA492A9FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 21:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10524284D13
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7714C58E;
	Mon,  8 Jul 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMTv13EM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8214B95B;
	Mon,  8 Jul 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467746; cv=none; b=rUMIRL1RG+AO3QBja9c0PY2Xv4KU3Zz97/j9M2leKWIjpMnp0xm4Jac5TYz07kKTMjwQO8Ro04koeMFOXIKBLCLmihXfEAA4uLzkabSIQx97/wXXuGC5iETuQZg6UKD7V08ravMc7wtqiPYQr9HUsAeAxbc5MEyO1yfDi3bvXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467746; c=relaxed/simple;
	bh=UYEkDikTrK4yUGHNdvG5X7alA+OBfYc03Q1rcRBDxok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RHpep7a6+IX/HndLt5DCuu87HXA4WeFQrEvtF+YzeGjs2dN90gTtI2xQtVAOpYivr4N0wdkS9NGXSN58LluEOFd/xFrUl70ekGgLpJC6OvP+wP5IJjeTGZi/IAItMqgWqwKVbotTyDBK5fc4kVg8fNL9adov2/4dIGCGH/+N1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMTv13EM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7924C3277B;
	Mon,  8 Jul 2024 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720467746;
	bh=UYEkDikTrK4yUGHNdvG5X7alA+OBfYc03Q1rcRBDxok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bMTv13EMbkIVJRwr7CSLXUVzWa2fnxM1psAVIok12DIc+BoO+bqy5qhjS52mkK3TV
	 wr0gDxVdbpcZmiYpWGPSys0n0bQZtOhPdLBf50hfjWMGufeMzfFrCZ9RAO3KlpDHw1
	 NLyIdD2EmH6N2g6kgHL805hRjJO0+/CX64rKO2ELYRqtUJmOKIei/bdWiu6py5QNr/
	 760c/u28g+h59M49Z5bNa+5IeRWZyDGZ5lHrqluZYPtZu5ETI9NzJXETTI6Slh57Iq
	 6MOBwY2spaUDI6eCYLKTXmuNVb6lVV6LkE9H8Q7Zv668Fth7yEqBNKQWxytQ+fJuKN
	 art3T7LQEkXfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2038DF3713;
	Mon,  8 Jul 2024 19:42:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Small API fix for bpf_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172046774585.17805.5648980759770927798.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 19:42:25 +0000
References: <20240708-fix-wq-v2-0-667e5c9fbd99@kernel.org>
In-Reply-To: <20240708-fix-wq-v2-0-667e5c9fbd99@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 08 Jul 2024 11:52:56 +0200 you wrote:
> I realized this while having a map containing both a struct bpf_timer and
> a struct bpf_wq: the third argument provided to the bpf_wq callback is
> not the struct bpf_wq pointer itself, but the pointer to the value in
> the map.
> 
> Which means that the users need to double cast the provided "value" as
> this is not a struct bpf_wq *.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: helpers: fix bpf_wq_set_callback_impl signature
    https://git.kernel.org/bpf/bpf-next/c/f56f4d541eab
  - [bpf-next,v2,2/2] selftests/bpf: amend for wrong bpf_wq_set_callback_impl signature
    https://git.kernel.org/bpf/bpf-next/c/16e86f2e8199

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



