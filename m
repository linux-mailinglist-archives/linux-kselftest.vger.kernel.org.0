Return-Path: <linux-kselftest+bounces-42474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39357BA3FC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97FB189AAE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06B2F7454;
	Fri, 26 Sep 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1ZdrKfJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B782ED870;
	Fri, 26 Sep 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894878; cv=none; b=HG3f7+bYe1KWTv4SySkKJ/pSHf36T3XkMomRVGg46ybg53nAzvpcu//PW+us9b5SgR4rKR4NdYEEiN9NeaUql4FgYgxqpf7tdXnJ7MfNoRiToqeUt6CkrbsU0OF1ClVwhaNElP0nguXlcR9gNPrrYB74mmXD50P5lo6nfabVk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894878; c=relaxed/simple;
	bh=8dTYO2SG9LZPYUqhzUoJXU5HyhLc7HXkqR2kzX4dgYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbr3K1NCQhL+M2sSZLRJhJzcTCytHAR+6P5E3/SjqJYgUTSzJS8kQJy0SbUisRzCsXHmlVvmFnVDe5Xl2SzvfW8hU8fryNMlNz/h/Ss+G10KKEANVIJVpgNMYvljSOwTaCBNAx903GEMnmSCFwW/0g+LE1GUSIGNRxQyaMLDQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1ZdrKfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0C3C4CEF7;
	Fri, 26 Sep 2025 13:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894877;
	bh=8dTYO2SG9LZPYUqhzUoJXU5HyhLc7HXkqR2kzX4dgYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1ZdrKfJPU6DAvIyc5BfBhjxD0hHJKX1FUveXhl+i2IbXqWb0YFZzuU2nBZTwEdwy
	 Az7dPaA7BJI+A6rUdwIHUDe3rDhe5RnoybKNIyDQgCzs6qHghKbMnOLGxFmUW0o3k3
	 uQBOud1NJf2rMVt4wwQwSQwjSvDROk+mNg4IzB41P/L9V7m/OJe7n+2huIcI3TzzBU
	 /hHZ0Tz8H8seX3/Zu8vi7haHYFcIfVkbZNMvas2b5qRtmWTMwTlTq4m55mISgaufK6
	 EeMhGO4uGKW0isj6P7oIJhx0Gflm+9k70RcMO2UNUovf2CSkwWzMYhCq5wYROMZ6Xc
	 s6xVye7IhtBHg==
Date: Fri, 26 Sep 2025 14:54:33 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 04/13] selftests: net: lib: Rename
 ip_link_set_up() to adf_*
Message-ID: <aNabGesgnNqu4stM@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <475716ef792f5bd42e5c8ef1c3e287b1294f1630.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475716ef792f5bd42e5c8ef1c3e287b1294f1630.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:47PM +0200, Petr Machata wrote:
> Rename this function to mark it as autodefer.
> For details, see the discussion in the cover letter.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


