Return-Path: <linux-kselftest+bounces-27119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64DBA3E812
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 00:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882D54219CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C626561B;
	Thu, 20 Feb 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR+8eBm2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F16264616;
	Thu, 20 Feb 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093014; cv=none; b=E/6z7E8Ildjp5y1sIMn4ak2q2iIyVl1ph65dSQMlpcVCrcDdHPbteBCiJ8VeNKBrdxO9g2/O249RdfRzAMGQejolXhGwP9OtfqGln1ZUQfZhFyJRvPgz8kVZV8JGWKcZJ+oEGPuAR7O8Lky2VuWNb7HJAGJyn1z5B1k8y52y7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093014; c=relaxed/simple;
	bh=SCGVRp6GOl4cx1eigu66mZ6vlzczca2P/5/u8Zt6Saw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OTX4reBusjVwontsQLbBcnZYEi0Aqu///xANSY54Qtujg4KINIOUN64hZfVpGraMPKHPJWlCYGJ4a1O4rrnFAvfekqbq8wzkPXqZ8rtTAAceDIDSz00Qa6rY8crtXIg/qFYlI8PWXhs3a8iZonRNdcPlAoNNPhOjMgRe4Cw8K4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR+8eBm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B4CC4CED1;
	Thu, 20 Feb 2025 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740093014;
	bh=SCGVRp6GOl4cx1eigu66mZ6vlzczca2P/5/u8Zt6Saw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lR+8eBm29pOim34f7Oc1islIwbMTNcL/VK6wvCInGDpyHebUAvrUtNaW0CxdWlySv
	 GH0NNEGbTa3RsyZiUpBJQ4wMbhe+5TwQI0Jbbu4O8dlZKPnolzwzw/tbGDyhkxMgQY
	 TSrdjKlWFwY7aXVPOqheBkDwpVlVIX2qdyz5FN4TpDofGyCV4vbqdWn1cZ+q9l/Qj2
	 kNS6PjfhOdXuPmeu5TxiwDiVScKvyV6/mQneRZ5inM845N7EqnRGcbtRP4nQ0/Uf0h
	 RXtz97nL83s5c5rGn0y7Qev3tlI/59E/ivxS5L+wztP1QZUEx6btWuIQ/FCvzRfTFa
	 goKzHBvrlrgXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE54B380CEE2;
	Thu, 20 Feb 2025 23:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174009304478.1506397.8001698369516362752.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 23:10:44 +0000
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
In-Reply-To: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: corbet@lwn.net, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mst@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 yuri.benditovich@daynix.com, andrew@daynix.com, stephen@networkplumber.org,
 gur.stavi@huawei.com, devel@daynix.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Feb 2025 15:04:50 +0900 you wrote:
> tun simply advances iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This will become
> especially problematic when tun starts to allow enabling the hash
> reporting feature; even if the feature is enabled, the packet may lack a
> hash value and may contain a hole in the virtio header because the
> packet arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tun: Pad virtio headers
    https://git.kernel.org/netdev/net-next/c/4adf74971018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



