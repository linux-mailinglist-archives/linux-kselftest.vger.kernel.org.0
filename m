Return-Path: <linux-kselftest+bounces-38736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE5B2199A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBDF2A876E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2C28FA9F;
	Mon, 11 Aug 2025 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+qAssGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2896284B41;
	Mon, 11 Aug 2025 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956738; cv=none; b=fUPETYDv2MCwSgq+DTbgVQn0h5Dat8vk7+FrgcUikiDFQqxJvMDpOSxC5IyXZOcgy3ljWbd/0keGicU1Nr57OPtfzfBrKteVkTa6MVg1jtCEB1rRQ0tpD4LmyKzp8b3EgFPrVkRdbY20L77Yzp8Qgph0eK2C+rDuEt3FyuIXiY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956738; c=relaxed/simple;
	bh=UyyEtm70Ekzg13BLNS2P/FeBKEqUo4aXuqs7S280mis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwTTig/yx8C6HqoalVoJGorNe5QDAHDbUF44s/7SWKpynoZ8wE9y8Br9SZoCVTlJtZ/Ig7z9NBzabI2saqUYYNG1s1rj4McKKxs8P3y8RXBEnJfKmDhBlvQdIBoYLdl2tlxYYn6pGtruQ1C+LzW1tm/tUc1cPXxGpunwzTiWbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+qAssGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EF3C4CEED;
	Mon, 11 Aug 2025 23:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754956737;
	bh=UyyEtm70Ekzg13BLNS2P/FeBKEqUo4aXuqs7S280mis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I+qAssGhPR8c/Vsn72M+SyqtVK7AK98nrFOEzDz4DRGw8Dwr7Vdov1HLluM+3gZlM
	 RcK+HZO6w8kQqVzKuxO1mb31z5a4WCCR3tNfzZ7qJENbwAv21IoJJLf6Uz4jSLJbAv
	 ItFZIjEEgAvtC+608y5R5aRmpFLQbElufjQNTk7JMclkk1/fQvzXB8xq1QgUTEw4oU
	 qdfpvk6Fa3Td/oKizSbf3rxfkEd+KtmZUtBeXF8m7G6DlMXX40oS3lkIP0J2LQUwnS
	 BvWMMWXdg2zTb9g1LOwEfbDFV5EJlbS7LLQh9VpOBxGcnMLiDbd6krwuImt3rP1OjX
	 Tll1OzAVXg8GA==
Date: Mon, 11 Aug 2025 16:58:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
 noren@nvidia.com, linux-kselftest@vger.kernel.org, ap420073@gmail.com
Subject: Re: [PATCH net-next 2/5] selftests: drv-net: devmem: remove sudo
 from system() calls
Message-ID: <20250811165856.1867eb6a@kernel.org>
In-Reply-To: <aJqDDIZxNAnZ-I8W@MacBook-Air.local>
References: <20250811231334.561137-1-kuba@kernel.org>
	<20250811231334.561137-3-kuba@kernel.org>
	<aJqDDIZxNAnZ-I8W@MacBook-Air.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 16:55:56 -0700 Joe Damato wrote:
> On Mon, Aug 11, 2025 at 04:13:31PM -0700, Jakub Kicinski wrote:
> > The general expectations for network HW selftests is that they
> > will be run as root. sudo doesn't seem to work on NIPA VMs.
> > While it's probably something solvable in the setup I think we should
> > remove the sudos. devmem is the only networking test using sudo.  
> 
> FWIW, it looks like:
> 
> virtio_net/virtio_net_common.sh

I think there were two tests that had sudo in code comments.
But not the actual code. I may have misread..

