Return-Path: <linux-kselftest+bounces-37851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0E3B0E204
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 18:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED729178F1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B127E061;
	Tue, 22 Jul 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvqAwC8i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C431E5B69;
	Tue, 22 Jul 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202238; cv=none; b=GAGOlMVXRTYE+233gNXcfnGJoFycDSvS67Fu77EAwnT/1e5S5h0ogvIlvQ1l6MaVNUsHTcSz9YaCW73giYi4S5plvUcGZAeIlCJtzWt2yrPHsOENHAo6mpWtv3sDaFoYxvElBfJhv1sl2xCOz6CCWk1cJmJfDgPfjPIuHYslov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202238; c=relaxed/simple;
	bh=xoL9LOWD95mx5rvcTZ/rPxXyuggZfmAY+gAIfMrRP8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=japWfBMHv6ipaM/0vBgbQ1oGBuzks94wyh5yBz6qlVtXXlmzbtzxHXs370iCv6ludJ1o34snHMt40XyMjJHTS8jqkS/Max8EyxhzhHN+pOKPdxXxhO7yC0csh8AT572mfWgdwZh8pcD6U22ixstD8OQooSjTxRn33MrT5LG/gzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvqAwC8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7DCC4CEF1;
	Tue, 22 Jul 2025 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753202237;
	bh=xoL9LOWD95mx5rvcTZ/rPxXyuggZfmAY+gAIfMrRP8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvqAwC8iQMek3PKW1xpY2pw6sha3G48y7rYYA4DduGcj1qVse9waBdH3qyFH5Joxg
	 8/UfwF6lfvYYtqveobsISUvs64+ieAip9uSKCTO2fPYsmVBZYYCacngOp1iXyTNauR
	 9pVe6skKv48bmsxYluEGoVBjbb1P/yStGoaraL7xMWjwKXkvD0RP5LOIlpiPzkMpMp
	 9x0av9bgZq78EWO1byLUwSCI/gt2oTAuJ4w1aZy2eGhQt4llrtDLaxHl+ozkm9lX9d
	 UJBmnxbOWl3gRnUVqdI8tbsHJkSZgvUZt9yd2SQn5W6BHJ8aiB7wTcggSdm1BbBs6x
	 lh0OhK9Ju+cnw==
Date: Tue, 22 Jul 2025 17:37:13 +0100
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
	andrew+netdev@lunn.ch, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: rtnetlink: add macsec and vlan
 nesting test
Message-ID: <20250722163713.GQ2459@horms.kernel.org>
References: <20250721165423.990313-1-sdf@fomichev.me>
 <20250721165423.990313-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721165423.990313-2-sdf@fomichev.me>

On Mon, Jul 21, 2025 at 09:54:23AM -0700, Stanislav Fomichev wrote:
> Add reproducer for [0] with a dummy device.
> 
> 0: https://lore.kernel.org/netdev/2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com/
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>

...

