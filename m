Return-Path: <linux-kselftest+bounces-28705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4AFA5BC69
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E350A3A7E6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA544226CFC;
	Tue, 11 Mar 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYOSkmcV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8121B9F4;
	Tue, 11 Mar 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685758; cv=none; b=OiXY6VCiI0uzwMZe1jPxCF4kTAVWsLGK9liw6/Hp1nI1asTe9WU1UUSpAjgUgOoF8PC4enx+lgb59Dcc012hCcA3DtvbjBp8NPiIXP++udEZ7rshYcg1133dqMAj9QAqgvz78jJye4EMdA2O16OFgr3qf8Z6KeBavEDew1KKRB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685758; c=relaxed/simple;
	bh=mtHEipNNrmWCIuZqaAZNIfMKcPAdFiy3JIQXqY3AJt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujWI9eiFDNG6z/86rEw4KGtoT+hwyxmQifCO/9r/1iXyC7lI4URnRT0FW0ERgybUz5DSAP0iUCiYlP350/npCELD62MYQn0sZiz5AKgKsplYNR3iaALssPZwJhBmrpjKxO5vU5tu0DFMzfLjU2yJZUxl64+cupFfmhzXfTgVKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYOSkmcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842E1C4CEE9;
	Tue, 11 Mar 2025 09:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685758;
	bh=mtHEipNNrmWCIuZqaAZNIfMKcPAdFiy3JIQXqY3AJt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYOSkmcVQczG8/oGer4vsAblsSRWQmzLndTYtkqv/0h0Eyzor6Mkhi0XR1sOBejQF
	 I3dlJ4j7GymW5Yjps7O+gn8PuU6DCf9SG2qXrbOpT3zC3IF6P75mcSkSmg49yhiduZ
	 mMcOuNgoKO2jWmF/v9TkdUP9vNybZ6uHXEv0HeQ9Nz4CFXdYpX5q1Zq9d/LGG8TMUO
	 nmuRyaA79I1qi7Ac7wMO6rceFRO/DeKssHiWTR+7ftEyzs82LM7plj2kKYavouhNIz
	 xwBi6l+8S67ZXn/6U/tnzlgiOHhevzlxhlYEAzwh6U0mjtWHy7mtuua7XDOVNiPwmm
	 e7JDISrga7F+g==
Date: Tue, 11 Mar 2025 10:35:51 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 net 2/2] selftests: bonding: fix incorrect mac address
Message-ID: <20250311093551.GI4159220@kernel.org>
References: <20250306023923.38777-1-liuhangbin@gmail.com>
 <20250306023923.38777-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306023923.38777-3-liuhangbin@gmail.com>

On Thu, Mar 06, 2025 at 02:39:23AM +0000, Hangbin Liu wrote:
> The correct mac address for NS target 2001:db8::254 is 33:33:ff:00:02:54,
> not 33:33:00:00:02:54. The same with client maddress.
> 
> Fixes: 86fb6173d11e ("selftests: bonding: add ns multicast group testing")
> Acked-by: Jay Vosburgh <jv@jvosburgh.net>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


