Return-Path: <linux-kselftest+bounces-40493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC1B3ED5C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 19:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B3D485D6C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193F320CBE;
	Mon,  1 Sep 2025 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX00CJAy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352432E6CD8;
	Mon,  1 Sep 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747569; cv=none; b=UnVVMxfDkH7MmA8SijSzv4YghfZwrVdlRcNLbAusU3oXR5Ja4Q0JXDEadxwkKC2cNEUUursTkZolFRHVD/h7N+uI4ir3haPbNUlsanMErdurq/XwY38+QFl/PTtEnWT6gcSNpAm2fSePleIFYBDlDpDNx7qTHxktAv4fbckTkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747569; c=relaxed/simple;
	bh=s+QL2R6hZtLufT5nr0vf9bgxzcC3WEmyCV/mmoWyqrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MU/6VkApJrJFKBc5eQheuE5sFhhwbfQTPV2HvVXAPnfZOk/s5Jw3qQEGWdyIBU6okAe4n8AoViLoMpgLLIK4U9lisQC1eTPWCG8V1DM11P1pHaq+3IRv686dFFFIdnrl5nvv/pYq/41M2nG1NHU7qckah17ZSSr/QVicFz2RdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX00CJAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381ADC4CEF0;
	Mon,  1 Sep 2025 17:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756747568;
	bh=s+QL2R6hZtLufT5nr0vf9bgxzcC3WEmyCV/mmoWyqrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gX00CJAyn77Tjz2S4DalkOpdFkfQoVGS4w2bRNHR7tOF1r1cLL1YuU+paeXJIWjZV
	 KBpweom17YSrwHok9rVuK10DGORm8T+Kjf4CMcbZBUwxRm5de0upXS/1r3Hd0ehrKn
	 FyiAJQya8ek/Uah5ZeA4pS5020GnIy2QSCH8glDhzQ57c0CEC0pQEgLW+xWYeeaHQb
	 +7pAkePcfED6Z0Q+/544qaZO2/yu9DprTzd/ExJqlDJAld7HZ+wkAC0uJK55vo1sXJ
	 TpwQpm4gmZWVr785dMAzj725z9z51hUx1kW972m3KuqKsVkkt7BhA8suvpBMz/h9dX
	 LKo1W31JnZ28g==
Date: Mon, 1 Sep 2025 10:26:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, ecree.xilinx@gmail.com,
 gal@nvidia.com, joe@dama.to, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: rss_ctx: use Netlink
 for timed reconfig
Message-ID: <20250901102607.0ee14e3c@kernel.org>
In-Reply-To: <20250901135008.GC15473@horms.kernel.org>
References: <20250829220712.327920-1-kuba@kernel.org>
	<20250901135008.GC15473@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 14:50:08 +0100 Simon Horman wrote:
> > -    key = _rss_key_rand(key_len)
> > +    ethnl = EthtoolFamily()
> > +    key = random.randbytes(key_len)  
> 
> Is the update to the generation of key intended?
> It's not clear to me how it relates to the rest of the patch.

_rss_key_rand() gives us an array of integers in the range 0-255 while
randomg.randbytes() gives us a bytearray. Difference in return type.

Let me respin and add this to the commit msg. Looks like I was too
aggressive with the decrease in 75msec timing, CI hit a 120msec run :(

