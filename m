Return-Path: <linux-kselftest+bounces-1071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFC803859
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7212811BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6ED2C18C;
	Mon,  4 Dec 2023 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ6zStno"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474652C185;
	Mon,  4 Dec 2023 15:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ED31C433C9;
	Mon,  4 Dec 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701702623;
	bh=yLuE5GhnEWx5vEyz19OFSwOiD3wwpOWWPeMlHaVekZ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZZ6zStnoKrzr/9zxY4plsPjoBj6GwejiDm9654JafTvuius4cirVOkTAqioHdGUHe
	 xfDGtzK/ARjtVOi7E5bhnAzMkFqAltskxxta2VwbRfPTc65mvuD7iJ/rrrm8wNnVi8
	 4vlaH57Qq+mlHGyLTD8uBklvvVqh9Y8Igz6eFQjQUp3WERtKqVlqcgNp2VoD2+eT51
	 dhuCBKpjFf2Zlfa/RI9mT5hbqiCFjD380gWpmuO1rlS1SPxMJuEWsFGLbObPjOo1fC
	 IirbX1CCFpoBxXwkdUctnmjeNZT+oa7opleiWk6MqL/xshxxHP3Er4z/ZuY6TyIbXL
	 I0QSA03yfJZ2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80E5EDD4EF1;
	Mon,  4 Dec 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][NEXT] selftests/bpf: Fix spelling mistake "get_signaure_size"
 -> "get_signature_size"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170170262352.16559.12056527906684806638.git-patchwork-notify@kernel.org>
Date: Mon, 04 Dec 2023 15:10:23 +0000
References: <20231204093940.2611954-1-colin.i.king@gmail.com>
In-Reply-To: <20231204093940.2611954-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: andrii@kernel.org, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  4 Dec 2023 09:39:40 +0000 you wrote:
> There is a spelling mistake in an ASSERT_GT message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [NEXT] selftests/bpf: Fix spelling mistake "get_signaure_size" -> "get_signature_size"
    https://git.kernel.org/bpf/bpf-next/c/153de60e8bfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



