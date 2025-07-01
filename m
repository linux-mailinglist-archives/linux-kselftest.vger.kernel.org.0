Return-Path: <linux-kselftest+bounces-36218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC21AF0504
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 22:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9C23B489C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 20:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2762EFDBC;
	Tue,  1 Jul 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvSIZO0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4113774D;
	Tue,  1 Jul 2025 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402382; cv=none; b=ahMHpiB5WgZatUY+gWN3u+9OOKqqKb8LNyG8QIkz/vf/f6PpvmGEnnLKOl2YKjDOi+Gbk9TyE/kCftL27yDW6xjTAfsVw8yGKPuVjKA2O/+IG9VRLgjBOVEJhLyPZPJqOJaLFiejeAw2GpiEHtrdI1mB/Uta8oNwqi/l80IxQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402382; c=relaxed/simple;
	bh=ML4ZxeAfrYr5UuQmjcfVS0wK0k0uBdoFhk3hWEcsz6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TPEwe2ZfO3ArgNjzEIEE7CPEkJWygzJIqZsVoRLBHpLroCoZNY3x0HK2DmHTyC1fKimNwMtFP/b8jrFKxWUwWW5TLWZfJlVHeIjnUlauq7nkVSZbid/DCUmi30PmWSOpCT5oUaJIg1O847PmO9rf6MT1oq7F/w7B1/JGkZTZ9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvSIZO0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CA6C4CEEB;
	Tue,  1 Jul 2025 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751402381;
	bh=ML4ZxeAfrYr5UuQmjcfVS0wK0k0uBdoFhk3hWEcsz6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OvSIZO0KMXCFDOPeZDjdZTxILlOQzfiWLj3KI5BEwTeaIX6XIZDlp79bXrf9a0Njs
	 9dxOUfMRSsIfQmdR4RSwUgZs/8652U0uNygcJ6gq92VN2GPZ7CXGVpmC8hmPqfTu91
	 cqPYMvc4uJ74gG4EWah9ofCK11wQJoYi67wa7iV5Fyue7xCiAqIVszR1eoO/SsK4/W
	 wxh6zfc5Mwifv22fbrVlM7PmljxNkPI17Oaa1Y8xy0Q5g8v4+S+n8tom8WjzVHliE8
	 n6m/XPas6SFRtW4ZntPAWx/FvQmti/cgo6W3Jlf9KS5lsbZmGqjm5FZXSGtL1BMfI/
	 R2m9omFDkLPiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE54383B273;
	Tue,  1 Jul 2025 20:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] selftests/bpf: Fix spelling mistake "subtration" ->
 "subtraction"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175140240652.112233.4529950579954373113.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 20:40:06 +0000
References: <20250630125528.563077-1-colin.i.king@gmail.com>
In-Reply-To: <20250630125528.563077-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 30 Jun 2025 13:55:28 +0100 you wrote:
> There are spelling mistakes in description text. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/verifier_bounds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [next] selftests/bpf: Fix spelling mistake "subtration" -> "subtraction"
    https://git.kernel.org/bpf/bpf-next/c/1230be820981

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



