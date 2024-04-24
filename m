Return-Path: <linux-kselftest+bounces-8825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F08B169C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61241C236E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DBC16E88D;
	Wed, 24 Apr 2024 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf9+O0Am"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5EB1E86F;
	Wed, 24 Apr 2024 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999411; cv=none; b=NmhsAzuCsc9zIcERgEpFMjx5k8PH5Zw9i/SwvHVyHFFWWxRHhWB38YV6vkqb39glZ86qu2vuPuB752G1Aombfd1IvMOK0a7aKnhcJX2LboLi3E4UyRx6WSYuyht8/k0kZ+AlKEa5rLh9Rbnfc/QyNWtRF6gfzFrB4F9FbzYdkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999411; c=relaxed/simple;
	bh=L8SWJW40YNg+bBM8Lg4lMQv0LTgccJJD5LAiYkskBCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYeGHAgatQGgmfZYTaOkKD2Sj3g4RDlKlx26ttPaqJCsbuTIgrmKKknKyzuEZ9KH66CyJ39BHq5fSkBP5g70fmjdwXDUdow/a34jD/ole9RwegW8pPLyoJzOIerirgw7OX1NEomK5Wo2+cWcPEu52IW7Fgp7u57y+oIz08Vf6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf9+O0Am; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C90C113CD;
	Wed, 24 Apr 2024 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713999410;
	bh=L8SWJW40YNg+bBM8Lg4lMQv0LTgccJJD5LAiYkskBCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rf9+O0Amp6VZAFJSD9SbhoQ1oNFE16Ob5x7SziiiVjyL0RTvzglyxI+z96JhauSaJ
	 sLRPik94PxE6n8AHVOBRRx2XKzAlMUXfNy98/FzleXdF67rWikgxbLvgqdY3+6Mkn9
	 U5JtZCstn+eytBymgmVo2Etp6MuCLhY/WxQQTZ8whC39xCr24ToDJxYFyBmB5VrYP1
	 jgHxug7KnvhqyjJvvPy8bEu2h47mwNPbidWucFNklPAef8ApG6FL4LMsHqTQN9jIdQ
	 tZivneNVAJio5w67xs06qAVmsvmF84qD/WemyFFtS3Bqc18ESV5eCqyJt3EA3Kg4l1
	 fLXDYifl3TtLA==
Date: Wed, 24 Apr 2024 15:56:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 1/4] selftests: drv-net: force pseudo-terminal
 allocation in ssh
Message-ID: <20240424155649.5f43b426@kernel.org>
In-Reply-To: <20240424221444.4194069-2-kuba@kernel.org>
References: <20240424221444.4194069-1-kuba@kernel.org>
	<20240424221444.4194069-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 15:14:41 -0700 Jakub Kicinski wrote:
> This is not yet needed, because we don't terminate remote background
> commands. But once we do, if we run ssh without -t the ssh session
> may close and the program may carry on happily running.
> 
> I have hit this problem experimenting with mausezahn, let's fix
> it already to avoid someone else wasting time debugging it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/lib/py/remote_ssh.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
> index 924addde19a3..294a4ed8284e 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
> @@ -20,7 +20,7 @@ from lib.py import cmd
>              self._tmpdir = None
>  
>      def cmd(self, comm):
> -        return subprocess.Popen(["ssh", "-q", self.name, comm],
> +        return subprocess.Popen(["ssh", "-t", "-q", self.name, comm],
>                                  stdout=subprocess.PIPE, stderr=subprocess.PIPE)

This seems to mess up the local terminal. I guess we'll cross that
bridge when we get there... I'll drop this patch when applying.

