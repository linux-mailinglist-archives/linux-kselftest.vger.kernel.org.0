Return-Path: <linux-kselftest+bounces-11727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FA9048DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 04:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2D9B241B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 02:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29FE6FB2;
	Wed, 12 Jun 2024 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D66Bvnvi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7B847C;
	Wed, 12 Jun 2024 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158675; cv=none; b=jqjyPFRf9hB3DzsznJxxQHKUnhVmvPTZcTLps70uPgSYMIaccGiJ1BZYeHiWY1E7w5PdGBni+KuJ3IW7pZ3P9B/6UOA9hfOj/D21M6iTtcV0zoNYt9mOgvn589w+0lj3zXCP3+f+DJtVnHwmRlhi/HCskCuEyIFr7Vkbq/Al+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158675; c=relaxed/simple;
	bh=BxYwZHOKNpm9NiGnRCPulpeS5GyBzWDtwt98wauBrmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxCnsyZQLttmzqRsajIxyHJAS4ovWelKNGMXc9lTIO3LkYs6nILd0C4kzWEJopGUnDrS+9I1wmBm6wmKdjx/2PoEi4TDOpg5+BJclRM6pWJLbh7poebSz9NzSFcBPMnG2uK5TQ8EQO0wOvSLcup5MWVfldeDrAto+CdFK5Cfz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D66Bvnvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF6AC2BD10;
	Wed, 12 Jun 2024 02:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718158675;
	bh=BxYwZHOKNpm9NiGnRCPulpeS5GyBzWDtwt98wauBrmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D66Bvnvih3zRod+zJqkxbA5+cGNDx1zOYKk7mTGTw6FsDP+m3EHUxs/M5PnayFbCM
	 JG35+lZ1dh4HnNf1J9dG1bPmZz+nKvh49yFxjHqNeiTadz5uyj7UFZ6CPpEZbQ0K5r
	 Kabyu6HJXm0XRWN4HO/MHzi03bjEJXpKhZ8J5eGPY393GOppMHVtaf79prWCfWU1Q7
	 c1jhbjqW5DOJi/RiD0OPK8SwFKE71bLs6ydKIQJ9E5LtyP114s/m7Wvj8ELymDPoiG
	 tKJJuNGUFrz+9oLqsO5zSAUSnJH5UHESNztppnC1yStdHK5jV+pwcWsx9RC2tIuZXk
	 9dW2RdhpuUsxA==
Date: Tue, 11 Jun 2024 19:17:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Boris Pismenny <borisp@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, Geliang Tang
 <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/2] tls: wait for receiving next skb for
 sk_redirect
Message-ID: <20240611191753.1b3d703a@kernel.org>
In-Reply-To: <3101675d11beac0ffe16a86877f7f0c5166605f6.1718096691.git.tanggeliang@kylinos.cn>
References: <cover.1718096691.git.tanggeliang@kylinos.cn>
	<3101675d11beac0ffe16a86877f7f0c5166605f6.1718096691.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 17:13:34 +0800 Geliang Tang wrote:
> tls_sw_recvmsg() doesn't work in nonblock mode, it returns -EAGAIN in
> that case. This patch fixes it, always wait for receiving the next skb
> for sk_redirect.

Is this commit message basically saying "block in nonblock mode" or am
I missing something? Either way you have to at least improve the commit
message..
-- 
pw-bot: cr

