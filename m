Return-Path: <linux-kselftest+bounces-42944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1C9BCBEC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 09:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8443C1E2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 07:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315A257848;
	Fri, 10 Oct 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETy9e87q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34275126C03;
	Fri, 10 Oct 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081458; cv=none; b=KOHcW7HXBJttoyidiGcp4UCLXp9BM3MxNuUW7nSk7r4iRHOtGl+1BIp8fUoeU7zuCxDWkHF2h6x4FqJZ29X9fyceDuae+6DMYIqP5/IXIZBHA/tt3bAQkaQWx34pUvqAOmdVx9O6JLBpwzuzEeBldYUTCezk0VlsdJZ7HmOSqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081458; c=relaxed/simple;
	bh=dSBSEOeyJ9yVqe6h56bcKNgWvTs5lcZikjMzMMaWZxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g40f1uxC0mO2tblZaYqakbrKMtjqcNPRdv1LKwMRzr1Fy8UC/6TwqiWfZIARFeDgVYdmK5/qo67C1rOoxE03Cu/tR5I6E4JhifHsmJ9S6TwVMADidhObxnb/ryfD8Bhef+p+KW/8hr5Lt60HTIS5gKjMjDeybi5zcXJxHBUlYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETy9e87q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F203C4CEF1;
	Fri, 10 Oct 2025 07:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760081457;
	bh=dSBSEOeyJ9yVqe6h56bcKNgWvTs5lcZikjMzMMaWZxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETy9e87qoKkumAF4HlNVAbMMfgbXCU0rStVl7Z2zCiRiPH8RLjDm6pRiQqExF5uZi
	 TatwRnq7q8RtgRCm9H9UWgUsBerl23oIWLlmmwT4F56IA8UecV5KIGQtb+0P0goxRX
	 uOwdgwaJMq4QGvX9277bF3BOORDRAwMfqsFoLzLux5cpAejgkN7PIWf6BE3/qPlDo/
	 GaqS/ZY0PjXNoapX2N138BdSSXPvYXy8p0HKiVkvo/STSAMWmapnbd3STlA7WpXC7t
	 zXqmrjaeNkHrNVjK/K6svdgKtGJgGLx5E1JeXMSdRCRn4U4jsMkdAE5LE4KqyXSxSU
	 2KdIr1+5N/ZVA==
Date: Fri, 10 Oct 2025 08:30:53 +0100
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	shuah@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] selftests: drv-net: update remaining Python init
 files
Message-ID: <20251010073053.GC3115768@horms.kernel.org>
References: <20251009205629.379829-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009205629.379829-1-sdf@fomichev.me>

On Thu, Oct 09, 2025 at 01:56:29PM -0700, Stanislav Fomichev wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Convert remaining __init__ files similar to what we did in
> commit b615879dbfea ("selftests: drv-net: make linters happy with our imports")
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
> v3:
>  - add my SoB (sending on behalf of Jakub)
> v2:
>  - remove tool from imports in driver __init__s it's not actually used
> v1: https://lore.kernel.org/20251007144326.1763309-1-kuba@kernel.org

Thanks for the updates, this one looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

